From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 10:53:04 -0800
Message-ID: <7v8vx4aqun.fsf@alter.siamese.dyndns.org>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 19:55:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt2p1-00078d-BS
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 19:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639Ab1BYSzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 13:55:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756483Ab1BYSxL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 13:53:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D5D66469B;
	Fri, 25 Feb 2011 13:54:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mqfc0X/T6vfKZpND6H3cqkdo4Xk=; b=n+nKtc
	hA2azTrmYUT7gmoemqAr29CGXH1XMo3IZ+5JH3vJmP88L8SsMP+8sIXJOdqJUSpY
	B01q30RiPAxCNAUPKUZXP0QHCv6vT3dJLlVJQxNRRy+HGizFbm4H3aLiOOERGzSJ
	IPa0zTijMEP3TNZTi92f53cLQI9ZAU7aL6GrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BjD7Z6Zlb6SCweJk/52RaMRXR98ekltf
	ItSnoK02PMPUa7eBXZZujJfbvi5re5KofsUsqMY/rD1Afl4zNTzYnNIUAEcAubCs
	Jv3uLyfJsjFkaDFmJwfZxjrsop1Kv9Y5nnV7d0UgTKrzUGmgGK2sANnSUPAGHxxS
	fQErFWuCSkE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5C92469A;
	Fri, 25 Feb 2011 13:54:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1A524699; Fri, 25 Feb 2011
 13:54:21 -0500 (EST)
In-Reply-To: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
 (Thomas Ferris Nicolaisen's message of "Fri\, 25 Feb 2011 11\:34\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A9E999AE-4110-11E0-BC62-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167917>

Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:

> I tried asking the same question on the "newbie" list some time ago:
>
> http://groups.google.com/group/git-users/browse_thread/thread/d562b4eeac016711
>
> Basically, when I go
>> git revert <commit> <path>
>
> .. my expectation was that a new commit would be made reverting the
> changes from the old commit, but only for specified path/file.
>
> Maybe it's a bit of a corner-case, but still would be nice to have
> once in a while. What do you think?

I am afraid that it would lead to encouraging people to record a horribly
broken history, unless you think carefully about what the resulting commit
log message should describe.  It would look _as if_ you negated the effect
of the original commit as a whole, but in reality you are only reverting
just a part of what you chose to revert with <path>.

We do encourage people to record the _reason_ why the particular commit
was removed by not supporting "-m <message>" option to "git revert"
command, but the commit template in the editor given to the user should
make it absolutely clear that the particular partial revert is reverting
only a part of the original commit, and need additional words to strongly
encourage to record why only that part and not other parts are reverted.
