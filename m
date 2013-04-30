From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 12:42:43 -0700
Message-ID: <7vhaindcuk.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	<7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGRv-0006yg-Is
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932813Ab3D3Tms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:42:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932742Ab3D3Tmq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:42:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B93BF1B293;
	Tue, 30 Apr 2013 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aBB5ft4jaQZmKp40NB3kjf84z9w=; b=IuO8oZ
	iwiGcvZK6uXsQCMe9crjXfFz7RzwY1rTbkFxm984WqLlWWKOCTYIs8v0zp6SH5B5
	JDVxtK4Lngmj+zD6v9orK/V04O4nDS0j0491mS72Rx0ySuMYA11O33FREct0jWx1
	AGm6igPb7dAUlmZAmR+wP7ir9sE/Mli+R1qvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dn8LIH6tco0WM32S//DSgbYKg3Y8DJZc
	mq3WqHsQy4S5zmKAhfM0x6qZ/h+TQ9tbwIJFWXbUdVrEcMdSBpeWEcqvSt6KE2Ds
	X7MiQ5g5+IOManiOAj1eMqLO9ZGYoO6ZKx3HcbURse1q+ciDy+lQgCQwqU/RWK/H
	H24Tupsr4Wc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B128A1B292;
	Tue, 30 Apr 2013 19:42:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F7091B291;
	Tue, 30 Apr 2013 19:42:45 +0000 (UTC)
In-Reply-To: <7vppxcdjd1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 30 Apr 2013 10:22:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 211BFD2A-B1CE-11E2-BB32-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222995>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>>> use 'git show @~1', and all that goody goodness.
>>
>> I like this. I haven't spent a lot of time on thinking about
>> ambiguation. But I think we're safe there. '@' is not overloaded much
>> like ':', '^' or '~'.
>>
>>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>>> 'master@'.
>>
>> I'm a bit reluctant to this. It looks like incomplete syntax to me as
>> '@' has always been followed by '{'. Can we have the lone '@' candy
>> but reject master@ and HEAD@? There's no actual gain in writing
>> master@ vs master@{0}.
>
> Originally I was going to say the same, but after thinking about it
> a bit more, I changed my mind.

Let me change my mind once again ;-)

As @ has been a valid character in a ref, I think "git show master@"
and "git show HEAD@" _should_ error out, not because they suffix
'master' and 'HEAD" in a funny way, but simply because there is no
branch called 'master@' (i.e. 'git for-each-ref | grep master@'
yields empty).  After you run "git branch master@ master~26", you
should see "git show master@" not to error out, because that is just
the name of a branch with somewhat an unusual name.

And we can still have "git show @" to do "git show HEAD", based on a
world model completely different from I (incorrectly) advocated in
the message I am replying to.

The rule would be "You should be able to say '@' where-ever you
currently say HEAD" (aka '@' is a short-hand for 'HEAD').

That means "git checout @" should work the same way as "git checkout
HEAD", "git log @~4" would work the same way as "git log HEAD~4",
"git update-ref @ $(git rev-parse master)" should update the HEAD
without creating $GIT_DIR/@, etc.

You can't go any simpler than that rule, and there is no room for
confusion if that rule is properly implemented.

Hmm?
