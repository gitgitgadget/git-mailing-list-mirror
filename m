From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --continue automatic --skip?
Date: Sat, 09 Apr 2011 18:24:44 -0700
Message-ID: <7vy63iyk2r.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=Vc6kB5fvZrqMwDD+yHFb5qENQ8g@mail.gmail.com>
 <20110409000351.GA7445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skillzero@gmail.com,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 10 03:25:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8jP7-00013D-Kr
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 03:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab1DJBZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 21:25:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1DJBZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 21:25:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BDBA541FE;
	Sat,  9 Apr 2011 21:26:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JYlsCBWzlMOM7OFrVPgSu3qkE2Y=; b=QphtqZ
	sjq05BeKEV8ATORLq57mKCVM/g7M6yKiBq1ZbAQrUvsDk72JmLYVAulOAv+RvkZd
	j4fX3Hh6iLJS5q71hBsBG5hgGo0nWcBoiGMj2Ooet4h9dw7/wCHXZfVduInpVuI4
	4YSr5oVidkMVj84gKvovTJn4pkN/tNucQpn9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DGlbJ+F2BGwm3w+/02Ta20cUsOPuJkSL
	hzo3tsTOIQPQlS1cfVCI1aQ9uIkMFOovMSG6W8aqdnHh0SNJ768wEQlxP0sUczoX
	ToQJ8LmQ0E2hlTT4/CEGg48k9KQBoXS68HIq5Msz0ZMKKwI3zYeetmegEpcnYweH
	DQr9w6+Q/EY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7AD7741FD;
	Sat,  9 Apr 2011 21:26:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 35D4841FB; Sat,  9 Apr 2011
 21:26:42 -0400 (EDT)
In-Reply-To: <20110409000351.GA7445@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Apr 2011 20:03:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9ACF394C-6311-11E0-A629-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171229>

Jeff King <peff@peff.net> writes:

> I put it in rebase and not straight into "git am", as I'm not sure that
> "am" would want to share the same behavior. I'm not sure why we haven't
> done this up until now. Maybe there is some corner case I'm not thinking
> of where the user would want to do something besides skip when we hit
> this situation. I dunno.

I think the "rebase --continue" behaviour was more or less deliberate (I
do not necessarily agree with the reasoning, though).  It is to ensure
that the user has a chance to examine the situation and acknowledge that
it is fine to completely drop the now obsoleted change, as having to
adjust the change to an updated base, even with conflict resolution, may
be common, it is a rare and notable event that the resolution ends up
being empty.
