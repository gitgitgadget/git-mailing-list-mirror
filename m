From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add --author option
Date: Tue, 27 Mar 2012 13:42:14 -0700
Message-ID: <7vvclphj2x.fsf@alter.siamese.dyndns.org>
References: <4F71E415.9030800@gmx.ch> <4F71F902.8090200@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathias Weber <mweb@gmx.ch>, git@vger.kernel.org, peff@peff.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCdDi-0002Vi-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 22:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab2C0UmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 16:42:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab2C0UmR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 16:42:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90D0F5B32;
	Tue, 27 Mar 2012 16:42:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jlqqF3NpNy+x
	3jshjF1MvJMtrtA=; b=CEbDarJISKaEb3Mkn/aEQwyvryauWWUNP3Z9ICgJ0cpY
	Sr4h0MKMVmV/CsTIGD6cBqIxcJQF8GdWmmmKH6mUxhESSpey2KOFeBfIbTIfnRvz
	/w00fq4KZEUvFRBG5Hay36Wa8ldFGPaZ4iOh2lqsrSO9m/FPMrM3DZ7oEuWPmAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=trrfST
	eZIUIX6ngFo62kLssCfEG+cSwGrXVQLY5/yNorM23fqyULE0zoTgoQnCnrgXT5B6
	zvUPqeNQ1abqjo4L4zF5WJvXTZGn/IkKZiNjggRLsYkGtSyTtJOP9OSxI8HFsAYD
	qpgrv/fnCQPtIzgZax4iLZElorWoBYMIg2PEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 885825B31;
	Tue, 27 Mar 2012 16:42:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B24CF5B2D; Tue, 27 Mar 2012
 16:42:15 -0400 (EDT)
In-Reply-To: <4F71F902.8090200@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 27 Mar 2012 19:29:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5688433A-784D-11E1-8A65-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194085>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

>> +	if (force_author) {
>> +		const char *lb =3D strstr(force_author, "<");
>> +		const char *rb =3D strchr(force_author, '>');
>> +
>> +		if (!lb || !rb)
>> +			die(_("malformed --author parameter"));
>> +			name =3D xstrndup(force_author, lb - force_author);
>> +			email =3D xstrndup(lb + 2, rb - (lb + 2));
>
> This part is identical to builtin/commit.c, it would be nice to
> refactor it into a function.

Or we may want to use something like split_ident_line() from 4b340cf
(ident.c: add split_ident_line() to parse formatted ident line,
2012-03-11) to consolidate the parsing of this kind of stuff even furth=
er.
