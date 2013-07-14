From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone.txt: remove the restriction on pushing from a shallow clone
Date: Sun, 14 Jul 2013 11:52:56 -0700
Message-ID: <7vfvvhgeif.fsf@alter.siamese.dyndns.org>
References: <1373607462-12836-1-git-send-email-pclouds@gmail.com>
	<20130713212541.GA10951@google.com>
	<CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 20:53:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRPs-00046y-Gx
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 20:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab3GNSxA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 14:53:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891Ab3GNSw7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Jul 2013 14:52:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A95305ED;
	Sun, 14 Jul 2013 18:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AtZsRK+Dkjjv
	hEoZa1YTY1Nl2ds=; b=JmkKS7O3S1BOTR9B1ulXw0S5lghRb50SAw9DupJ8UJTB
	oJMQQ+RrSIX2ArA+5Tx2cUzJHkzoWAGAuhky3zq89yI5NuJgyrwt9mvLZ0dDKip4
	1zlFUW+FYQFYAj5OjbQusl5t1kFmVkfFmao0CFmLNcC28PWREq3usluVdS+qKcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AMKpOz
	2APo/ZcAQzflk+LvQ09+Bire+tR+0tnXIKny2JwV/bz+CSh/XzaCyBkCGAinrkHZ
	S8O/mQCeclRw/KtmslgI+VTZra3lFzsczERpjyo+uH28oqOUW8NLEUqbnZ+7/CJV
	O62FE0V4bK3qdqAgl9mFVpKwrmm6KJv75clJQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67550305EC;
	Sun, 14 Jul 2013 18:52:58 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC1AA305E8;
	Sun, 14 Jul 2013 18:52:57 +0000 (UTC)
In-Reply-To: <CACsJy8ATX8aJJ40sF5XSoVpy=X1ZTLj5qpthrTQ52fv40QNn7w@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 14 Jul 2013 09:28:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 997C8096-ECB6-11E2-8CB2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230382>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Jul 14, 2013 at 4:25 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>> Hi,
>>
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>>> Since 52fed6e (receive-pack: check connectivity before concluding "=
git
>>> push" - 2011-09-02), receive-pack is prepared to deal with broken
>>> push, a shallow push can't cause any corruption. Update the documen=
t
>>> to reflect that.
>>
>> Hmm, what happens when pushing to servers without that commit?  Do y=
ou
>> think it should be applied to Debian squeeze for server operators th=
at
>> haven't upgraded yet to the current stable release?
>
> This is pushing _from_ a shallow repo, where the sender repo's old
> objects is a subset of the receiver's.

The "subset" assumption does not necessarily hold, does it?  The
receiver may have rewound its tips and pruned since then.

Also, the sender may have cloned from the receiver (fully) and then
fetched a different history shallowly from elsewhere.  The receiver
may have no commit on that history, including the shallow-bottom.
