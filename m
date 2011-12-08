From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Re-roll rr/revert-cherry-pick
Date: Thu, 08 Dec 2011 10:41:49 -0800
Message-ID: <7vpqfyj47m.fsf@alter.siamese.dyndns.org>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <20111207081734.GG11737@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 19:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYiw5-0004p5-4W
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 19:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1LHSlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 13:41:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab1LHSlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 13:41:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8D395159;
	Thu,  8 Dec 2011 13:41:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uH0Zfe5dBZoSqGMCi+gIhEswPoU=; b=A/TLnC
	Num7xLu6GNwdCAz9sHcwkJNbdw7dQo59/+9jo0dIPCeG/cMM7Zu/yAR5dFrx0Sjt
	3QHvLgnhLjfvgIku5USoyRasehirD5TDwKN773JbIGRrYK8y2JFHb9FkDBdHe5yY
	8Gulm7UzP5ajpyUYtKGjmGIwSck0waIxdkczU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ibNGRl9PiMdniZkdYgzRMhxebYWK2ZxN
	nGeurt0kRNihmXQOoMc8M0mkTZ60Ahaq/uOO0mDn61riNLr6tcowGAtBuzuyVEDs
	LoxAUw/gpiUwAN9pGk7d9tyRteQCSm0iWm9FpfxEWryCrlBxxbyKWT81DqvNRAt2
	bW25cixQzaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C09715158;
	Thu,  8 Dec 2011 13:41:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 295785155; Thu,  8 Dec 2011
 13:41:51 -0500 (EST)
In-Reply-To: <20111207081734.GG11737@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Wed, 7 Dec 2011 02:17:34 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AEC4FBC-21CC-11E1-ABAB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186585>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> This is a re-roll of rr/revert-cherry-pick, with Junio's suggestions
>> ($gname/186365) implemented.
>
> Thanks for this.  I am worried that some of my comments in previous
> reviews (especially about change descriptions) were not addressed,
> which could mean one of a few things:
>
>  - you didn't notice them
>  - they were wrong
>  - you noticed them and they were describing real problems, but it
>    wasn't worth the time to fix them
>
> Fine.  But I would like to know which case they fell into, so I can
> learn in order to do a better job reviewing the future and know my
> time is well spent.

Another thing I often notice after raising an issue during a review (this
is not limited to Ram) is that I do so in the form of a question "why is
this function done this way?" expecting either "ah, doing it that way
instead is simpler and easier to read" or "because of such and such, which
you may have missed. after all this is a tricky codepath with this and
that constraints" as a response. The former should and often does result
in an update of the code in the re-rolled series, but the latter often
results in a frustrating nothing in a re-roll, when the fact that a
reviewer needed to ask the question was a sure sign that the code needs
explanation either in the log message or in-code comment. 

> The series makes various changes, all essentially good, which leaves
> me all the more motivated to figure out how to get this sort of thing
> in smoothly without making life difficult for people in the future
> tracking down regressions.

I looked the series over with your comments and tend to agree with many of
them. Perhaps I should wait for another round before picking it up again
(I've already dropped the old series I kept before 1.7.8).
