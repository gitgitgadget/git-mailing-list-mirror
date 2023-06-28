Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6427EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 22:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF1Wbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjF1Wbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 18:31:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B24E10EC
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 15:31:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AEE0127126;
        Wed, 28 Jun 2023 18:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J6bFf41XoWXU23CU9Ja8Qrm2Of8LnvrLBJnW/x
        jxd2A=; b=wVA/989/VOGMdemD6zhYh3it8vWFAagbB34dNmKbUGhjdjMqDPdjsR
        kPjTrkVga87mcezhZFpQadsvtflA371phPJ2JwIQLPYmTXzFiLWtFzMquCjzukmE
        zVri6AFLfj8F6aqexNZpQDaEzBT1qNX04I2TKlNYrycb5x+7iK9Rk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A718F27125;
        Wed, 28 Jun 2023 18:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C1E3227124;
        Wed, 28 Jun 2023 18:31:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Subject: Re: cw/header-compat-util-shuffle (was Re: What's cooking in
 git.git (Jun 2023, #07; Tue, 27))
References: <xmqqcz1gftdn.fsf@gitster.g>
        <kl6lh6qrqtbj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqbkgzcnao.fsf@gitster.g>
        <kl6ledlvqo94.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 28 Jun 2023 15:31:42 -0700
In-Reply-To: <kl6ledlvqo94.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 28 Jun 2023 14:18:47 -0700")
Message-ID: <xmqqilb7b4mp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F30AE7E-1603-11EE-8180-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> Yes, I have found that it had too many bad interactions with topics
>> in flight and, keeping it out of 'seen' was very much deliberate.
>
> Thanks, that makes sense.
>
> Perhaps it should still get a call out in What's Cooking? When Calvin
> referenced that series, I went digging in What's Cooking for the topic
> name, and when I couldn't find it, I manually listed the topic branches
> starting with "cw/"; fortunately, Calvin's contribution history is short
> enough to make that tenable ;)

Maybe.

As I only have limited bandwidth, I do not know how stale the posted
version got since other topics in flight also moved.  It may be that
other topics have graduated to 'master' and the conflicts got even
worse but it can be easier to resurrect on top of updated 'master'.
Or other topics that had interactions somehow magically stopped
being conflicting.  Or the series by itself may have remaining
issues pointed out during the review and is not ready to be picked
up.  I truly do not know.  Sorry.

One thing that many contributors are doing, which is very much
appreciated, is make sure that the series they are going to post
would work well with at least the tip of 'next' and also with
'seen', as well as 'master', before sending them out.  It would help
everybody: those who own topics that the series interacts with, the
maintainer, and those who may want to build on top of what the
series adds.

If the topic is too disruptive, however, they may have to synthesize
a good base (i.e. "merge on top of 'master' topics A, B and C, and
then queue these patches") but it may not be possible (e.g. among
the topics it interacts with, some topic may not yet be stable to
build on), in which case they must catch up quickly every time these
other topics it depends on are updated to avoid being left behind.

If the contributor cannot afford the time for quicker turnaround
that way, it would very much help everybody to announce that they
tentatively withdraw the topic until the other topics get more
stable, after which time they will send an updated version.  It
will help everybody, including those who want to build on top of
what the series adds.

Thanks.
