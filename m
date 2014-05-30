From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git log: support "auto" decorations
Date: Fri, 30 May 2014 10:35:14 -0700
Message-ID: <xmqqmwdz9nl9.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
	<20140530015855.GG28683@sigill.intra.peff.net>
	<CA+55aFzwy09-i=hpBy-5bYS6eowGzkdcF65cFJpL2qnJvYq85w@mail.gmail.com>
	<20140530065737.GA13591@sigill.intra.peff.net>
	<xmqqvbsn9pfx.fsf@gitster.dls.corp.google.com>
	<20140530170330.GA25443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 19:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqQiE-0007Qw-1O
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 19:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568AbaE3RfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 13:35:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58518 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbaE3RfU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 13:35:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FE9D19576;
	Fri, 30 May 2014 13:35:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1KwfHB0gbZkIiaEZqRMOEN4noQo=; b=iABELV
	Dr+Xa01k/9SNgpYqLr0hbsrDvpGvAYEBOGKVaUC3FEp9x3s4OqEcFSE349c+S+aG
	lu78MTRSgAFdNjx4N8xP+ROSCpeDUX6z8UqHhrdwZt5Uacq2OBTnxFdsBW80aNae
	R8XgrZUvf8Xar9eGzvDScE4/8MMNJ2WV7Xwmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kFOw6klv35+4YP63tpS+y4nY/2jCK6WM
	fukcGouCzkfSM6vHZ+L6AK7N/NBMDMjJ6B2FOMuFyqy0sMqLAGn/ga+Hz/n9CDQ0
	yG51xlK4VWZ6HMqMzAVmyaTNUi6ZEdgrqSF0N/83bFyTwLhSN3gs4HmfbXt5swk4
	E00b/NB/hf0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 826B319575;
	Fri, 30 May 2014 13:35:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E2D6D19572;
	Fri, 30 May 2014 13:35:15 -0400 (EDT)
In-Reply-To: <20140530170330.GA25443@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 13:03:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3003A5A-E820-11E3-95D1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250450>

Jeff King <peff@peff.net> writes:

> On Fri, May 30, 2014 at 09:55:14AM -0700, Junio C Hamano wrote:
>
> I don't think we need to worry about commit->buffer being mucked with.
> It is always either NULL, or points to the original object contents.
> Encoded log messages are always placed in a separate buffer (and in fact
> we use the same "optionally point to commit->buffer" trick there). And
> things like mucking with parents always happen on the parsed form.
>
> Of course I may be missing a site, and it's certainly a maintenance risk
> for the future. But I'd go so far as to say that anything modifying
> commit->buffer is wrong, and that side should be fixed.

I fully agree, and "that side should be fixed" implying "we should
always be on a look-out for such a change" is something the lazyness
tried to avoid.

> Do you want me to roll it up with a real commit message?

Yes.  I think the change is sensible.
