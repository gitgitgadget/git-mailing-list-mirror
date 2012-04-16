From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 15:03:47 -0700
Message-ID: <7vwr5fs5a4.fsf@alter.siamese.dyndns.org>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl>
 <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
 <7vehrnwpoi.fsf@alter.siamese.dyndns.org>
 <CA+55aFyZYnAxJc8YT=GEnq-fdXbHCXyx937KNBngn69Zuxmcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:03:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu1c-0003C7-0N
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab2DPWDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 18:03:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab2DPWDu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:03:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EC5E750B;
	Mon, 16 Apr 2012 18:03:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uokiF2bg/BAe
	U+6TBTjXkGmECW0=; b=jMOWZneuag2+KOKTT4v0bHAkhHnCZcuhpVEkfN5CJdT1
	hVLpkueMoMz9mBoLKNBX0qMpyWaee6jsE7fvNWkus7GTCTXjWYK1ZRd5lkEkGdKa
	jIg98J3LTHYedqKSoHVhwQvAYFCYzWqy89rAXRMaV7315TraVL5xciEoMfdv1vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qkcskj
	gJB35t7W1xl8l1jnCmpuv2OsJXQCGUwwxlZYN3XukuhHJEzXGp9yKTKAadQ7W1d0
	UJn5FyrlfcgvpT6W6T2GzNdMXggk8xw9macXd/sp9W8QQNXciH3bz7B079a2478f
	fGPwAjciA+UHC3XXZZlEA3Iy+8WBr04fj0Gn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75EE2750A;
	Mon, 16 Apr 2012 18:03:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0962D7509; Mon, 16 Apr 2012
 18:03:48 -0400 (EDT)
In-Reply-To: <CA+55aFyZYnAxJc8YT=GEnq-fdXbHCXyx937KNBngn69Zuxmcgg@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 16 Apr 2012 10:50:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B6EDBF2-8810-11E1-8EC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195704>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Apr 16, 2012 at 10:29 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>> I wonder if use of remoteheads later in the same function are correc=
t,
>> though. =C2=A0We equate "!remoteheads->next" and "We are not doing o=
ctopus",
>> for example.
>
> I do think it would generally be a great idea to never use
> "remoteheads" at all. An octopus merge that has been simplified to
> just two parents isn't really an octopus merge any more.
>
> So I think you're probably right - we should try to avoid using
> remoteheads entirely, and any use is suspect

I am still looking at the codepaths involved.  It looks feasible, but
would affect quite a lot of them to deal with many corner cases, I am
afraid.

One of the worst is the "traditional merge format" where format-merge-m=
sg
is called outside "git merge" to prepare the merge message created by "=
git
pull".  We haven't reduced heads at that stage yet, so the message fed =
to
us will list what happened on the redundant branches.
