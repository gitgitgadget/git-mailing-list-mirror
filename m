From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/commit.c: fix type warnings from gcc and sparse
Date: Fri, 29 Aug 2014 15:17:33 -0700
Message-ID: <xmqq7g1r3pqa.fsf@gitster.dls.corp.google.com>
References: <5400AC05.9060900@ramsay1.demon.co.uk>
	<20140829184435.GA29456@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 30 00:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNUUV-0007T2-3G
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 00:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbaH2WRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 18:17:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59557 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446AbaH2WRt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 18:17:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEAA536590;
	Fri, 29 Aug 2014 18:17:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mYlaY6v2ZAsSDsyPYS7rz9Ic7JU=; b=CtGP1K
	wIZHwsvvy0VkujzwV4++pSyDr9gnWOTXAEo0pnYhBPGdSXfqJUP8biWIsF9DLF6x
	h7hfyTB8H5OoWGevpEceNGi3oogEtvQISc8ncdjAGk/381zYOM7Xs602qXtVgDj0
	82aq8gNK5UyDav5SmefesU7RwCICSutrtJhL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UL5kUpnV/21apdwOYJsY2HbqKUK78twv
	mYR1v8jcKQpTlrcfltyje6USgYaFekZAgg1SgCR641LtRI/DBXmF2KHqDZ/SpikD
	zqR6P9Zlp5BkOKJh1uQdNn0Uu7G/+zX01GDdlA0WYve4GPDy5utrO4znMIiKc26R
	FGjCZeRDRqo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2F0C3658F;
	Fri, 29 Aug 2014 18:17:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 762A236561;
	Fri, 29 Aug 2014 18:17:35 -0400 (EDT)
In-Reply-To: <20140829184435.GA29456@peff.net> (Jeff King's message of "Fri,
	29 Aug 2014 14:44:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 475A3C42-2FCA-11E4-AF9A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256200>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 29, 2014 at 05:36:21PM +0100, Ramsay Jones wrote:
>
>> On 32-bit platforms (only), gcc and sparse both issue warnings
>> about the type of the pointer expression passed as the third
>> argument to find_commit_header().  In order to suppress the
>> warnings, we simply change the type of the 'len' variable to
>> size_t.
>> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> Thanks, this looks good to me. I think I just switched between size_t
> and "unsigned long" during the development and forgot to tweak this
> spot.
>
>> If you need to re-roll your 'jk/commit-author-parsing' series, could
>> you please squash this into the equivalent of commit 95b5989
>> ("determine_author_info(): reuse parsing functions", 27-08-2014).
>
> I don't think I have any other reason to re-roll at this point. I'm
> happy to have this on top, or it can be squashed into the second from
> the top (95b5989) if we want to keep the history cleaner.
>
> I'm also happy to re-roll just for this, but my impression is that is
> not really any easier on Junio than just squashing a patch in.

Thanks for being very considerate ;-)  Have squashed it in with
"rebase -i" while preparing for the mid-day pushout.
