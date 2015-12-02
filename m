From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Wed, 02 Dec 2015 08:40:05 -0800
Message-ID: <xmqqlh9c6byy.fsf@gitster.mtv.corp.google.com>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
	<20151202005338.GD28197@sigill.intra.peff.net>
	<xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
	<20151202024403.GA29329@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 17:40:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4AS2-0004We-09
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 17:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbbLBQkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 11:40:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751668AbbLBQkK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 11:40:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0323730448;
	Wed,  2 Dec 2015 11:40:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xMbGGT1+XLdStqDAV1QRZzPxNZY=; b=PhXr72
	8li47IFHOqRq7d4h18+pC1XYwhHWS7ogtev5QWxmjijtIxBsCFhcTQ3+twRk3xSH
	SGChBzpidWld+ZsrfBDqYSqk9am7MrGNLJOcyg/Du3vLo4gKmeUrBEppJHBpCoz9
	sScCQ9i5Ux1q3h7hufrAEm6u/jWX4qAqgYf8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aV+7ZBKJUbJGg6AaEI8v+m6n4dIsH4cF
	9FUDLKtbbVxluqwA7E66nKeeHQMn8jiwplPcXidOScoXSMavQOJnsA/FzvACLyXb
	XNbdByWG6Jn6PzVCcu0GvefcS5lCnEvZSlliFDrZ1izDFabRA79OW5nAL8qdpHzx
	PeQhC6aLc4o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEB7830447;
	Wed,  2 Dec 2015 11:40:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6219B30445;
	Wed,  2 Dec 2015 11:40:08 -0500 (EST)
In-Reply-To: <20151202024403.GA29329@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Dec 2015 21:44:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 592B92A0-9913-11E5-AB71-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281890>

Jeff King <peff@peff.net> writes:

> On Tue, Dec 01, 2015 at 06:18:30PM -0800, Junio C Hamano wrote:
>
>> It is likely that existing users are already using $HOME/.gitconfig
>> that sets core.excludesfile=$HOME/.gitconfig as the personal
>> fallback, that is overriden, not tweaked, by project specific
>> settings of the same variable in .git/config, so that would not fly
>> very well, I suspect.
>
> Maybe. I would think the more common setup is:
>
>   1. Personal exclude files (e.g., your editor's backup files) come from
>      ~/.gitconfig.
>
>   2. Per-project personal excludes go directly into .git/info/exclude.
>
> But you're right that it would be a backwards-incompatible change.

No question about it, but at the same time I can sort of see how
useful being able to read from more than one would be.

But for this particular one, I viewed the topic as adding a new
option as a shorter way for passing multiple -e <pattern> options on
the command line.  When viewed that way, even if core.excludesfile
were multi-valued, I wouldn't have imagined that people would try to
use that mechanism for such a purpose--for one thing, the precedence
order is wrong for that purpose, isn't it?
