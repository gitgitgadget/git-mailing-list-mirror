Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE09C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A3520786
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 19:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YiuV2uIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgH0TEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:04:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55880 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgH0TEe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 15:04:34 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0000EF082E;
        Thu, 27 Aug 2020 15:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e67J7WeCeyj0k4cjHY8QUV5SxT8=; b=YiuV2u
        IrG9BuqU4bmVo7zcXZkKmvOfyb4nqMSzwUZnSXlDxS5pGrIEbmoD1IC5lH02Kh6h
        Hhm2VSpi5YPh0wBzOVr0TBSDl6GdBxlYGMv4aKmnStEhEudGSEMjMYSqderD3viq
        +ydr7bI/MVkNf0fmdRXAOPodQ0BLl9+QeLVIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qLj5/vpyGbKAcReCz0AdN1zQTyVq/EUw
        w0jJohrYv9bv97PYbtV87DbIUH0YRHrOYMlzRxd4lCxmT7r7uFQWHpRKFtI872FG
        Jka4CHODrQuygjFAemPUO+5kHrKFQ+7vNn58YMr0XQOaTFy5HZEYPlqgrtL5iIlZ
        SJsyLT2pqh8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC4D9F082C;
        Thu, 27 Aug 2020 15:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C0BAF0828;
        Thu, 27 Aug 2020 15:04:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
References: <20200827175552.132193-1-sir@cmpwn.com>
Date:   Thu, 27 Aug 2020 12:04:26 -0700
In-Reply-To: <20200827175552.132193-1-sir@cmpwn.com> (Drew DeVault's message
        of "Thu, 27 Aug 2020 13:55:52 -0400")
Message-ID: <xmqq7dtjrjut.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 217AB28A-E898-11EA-AB7A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> Most mailing lists prefer that new patchsets and their revisions are
> placed into a new thread. Additionally, knowledge of what In-Reply-To
> means and where to find the Message-Id to fill in are domain-specific
> and confusing to new users. In the niche situations where this is called
> for, the --in-reply-to flag is sufficient.
>
> A config option, sendemail.promptInReplyTo, has been added to re-enable
> the old behavior.

We do not break existing users' habits without a good reason, and a
subjective "this is the way I prefer" is *not* a good reason.

If/when the claim "most mailing lists prefer" can be substantiated,
we'd need to devise a transition plan to flip the default over
several releases.  Here is how I would envision the plan should go.

 (0) Introduce sendemail.promptInReplyTo that defaults to true; this
     can be done today and it would be a genuine improvement for
     those who want the new behaviour, without hurting any existing
     users.

 (1) Substantiate the "most mailing list prefer" claim.  If we
     cannot, we stop here.  Otherwise we would move to the next
     step.

 (2) Teach "git send-email" to issue a warning message when the
     telling the user that the default will be flipped in some
     future version of Git and optionally ask them to tell us to
     stop on the mailing list, when sendemail.promptInReplyTo
     configuration variable is not set.

     Advertise the future flip of the default in other channels,
     too.

 (3) Wait for at least a few releases.  Monitor the mailing list and
     other channels for objections, and if it becomes clear that we
     misjudged in step (1), stop the transition plan by reverting to
     the state before step (2) (i.e. not to before step (0)).

 (4) Flip the default and tweak the message to tell those users who
     still do not have sendemail.promptInReplyTo variable set that
     the default have changed, and if they want to get prompted,
     they must set the variable to true.  Also stop asking them to
     tell us to stop---at this point we are committed and will not
     go back.

 (5) Waiting for several releases

 (6) Remove the code to give messages for users who do not have the
     configuration variable.


