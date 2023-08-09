Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC29C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjHITRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjHITRX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:17:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B13A97
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:16:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E858188D18;
        Wed,  9 Aug 2023 15:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9TISdSTx5oUcwbu8HhUySlpnxeCPUKEqqE3q97
        eLq2A=; b=vEO35ERils4IhBtNPxIDhbBw4P9sv4BMToh7wFbvmSLxIYxAEMULCD
        ah5MML1okdzf0XjVtYJSZD4kKrlgn82DQjkscHk6NmGNqcJv2fpxzwt7mAKDc7SL
        GhKsu4qTo0PXGc3zI8upqK1So3vWzwAq4+XIi7UJ//5wjYPuKHgAk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65786188D17;
        Wed,  9 Aug 2023 15:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C2167188D16;
        Wed,  9 Aug 2023 15:15:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] send-email: prompt-dependent exit codes
References: <xmqqmsz1a547.fsf@gitster.g>
        <20230809171531.2564739-1-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 12:15:42 -0700
In-Reply-To: <20230809171531.2564739-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:31 +0200")
Message-ID: <xmqqo7jgm3hd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23082E96-36E9-11EE-BD22-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> From the perspective of a scripted caller, failure to send (some) mails
> is an error even if it was interactively requested, so it should be
> indicated by a non-zero exit code.

I would agree that there should be a way to ask the command to
indicate if some messages were not sent due to end-user request, but
I have to say "From the perspective of a scripted caller" is a gross
over generalization that I would not want to see in a commit log
message of the project I run.  Not all our scripters do not write
the scripts the way you do.

It should not be hard to make this opt-in, and I still think it
should be opt-in.

Thanks.
