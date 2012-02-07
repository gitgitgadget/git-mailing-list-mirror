From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Tue, 07 Feb 2012 10:44:27 -0800
Message-ID: <7vlioe1o1g.fsf@alter.siamese.dyndns.org>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 07 19:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruq1r-0004Xf-Ot
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 19:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab2BGSob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 13:44:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706Ab2BGSoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 13:44:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D26457372;
	Tue,  7 Feb 2012 13:44:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JniUUqREpdaH
	vIULrDVyrOMRlBk=; b=wkjxz/3b96BiNOijv6eFXxvQYrjR0ks1dviPOYMen+s0
	KcTORda3ZnobqO5Rc8bdSgIHCAwYH/Ndh3f3f+wqTwJx0MIcVwNzmPb2iGONGzsG
	xp625SMyLwCo7cLkb8Ioc6CcxNgeaKo4AXXvXi4GqoVIYMSOReeSxPfSiE6xRAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WEonjd
	2+yxuhbr3gJK4zO4+1kv5uShNqHWLD9fUn4uiE9OQGif+X+iSbfOqmiC3EXVYtBR
	jd+xJH6DfXV90fAxIIrC3VSBWbE1Of+DKkcWPFaRI/bZHDkQZJIA2O3NuNSgT7Pp
	ORQRctEX5P3UoEV2QuSQTos+1F1HbMMzTSBbA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C977A7371;
	Tue,  7 Feb 2012 13:44:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3922B736B; Tue,  7 Feb 2012
 13:44:29 -0500 (EST)
In-Reply-To: <20120207180625.GA27189@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Feb 2012 13:06:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C454D3C8-51BB-11E1-8625-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190197>

Jeff King <peff@peff.net> writes:

>> > +A config callback should return 0 for success, or -1 if the varia=
ble
>> > +could not be parsed properly.
>>=20
>> This matches what I have always thought, but I think I recently saw =
a
>> series that adds callbacks that return 1 to mean "I have understood =
this
>> variable, so callers should not look at it any more".  It felt wrong=
, but
>> I did not find anything in the config.c API framework to prvent such=
 a
>> local calling convention.
>
> ...
> The "1 means I understood this" convention is used by userdiff_config=
=2E I
> don't like that it is unlike every other config callback,...
> Looking at the code again, though, ...
> Hmm. Yeah. The userdiff calling convention dates back to late 2008...=
=2E
> So I think we could go back and simplify the userdiff_config code now=
=2E

I remembered where I saw the new "offender"; it was nd/columns
topic (Cc'ing Nguy=E1=BB=85n).
