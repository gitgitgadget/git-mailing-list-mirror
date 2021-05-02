Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094BC433B4
	for <git@archiver.kernel.org>; Sun,  2 May 2021 02:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325A461462
	for <git@archiver.kernel.org>; Sun,  2 May 2021 02:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhEBCkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 22:40:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59884 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEBCkj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 22:40:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2EFAEBAE69;
        Sat,  1 May 2021 22:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6e+OVxPjg98d1E42wws2QSkEqJzABGCUWRFnoW
        kj8H0=; b=IOsyAUCNFsKDoVI9K1yrXqUOAvFfDk9/a3RpTCV/fvKLpRw6A9W5zC
        4iPPrP6eCZN3c73Q4+20lLlOEK42yqS7Yt0YP7TJ+vztv71Vyz+pzWiAbrwJwvP9
        ICLiJCpOFqAaQcAV95U9njCcPOgZi8YXdeipCFZ4Qz5EWoIgnxTwQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26C45BAE68;
        Sat,  1 May 2021 22:39:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6F0ABAE67;
        Sat,  1 May 2021 22:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Josh Soref <jsoref@gmail.com>,
        Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3] git-merge: rewrite already up to date message
References: <pull.934.v2.git.1619047347605.gitgitgadget@gmail.com>
        <pull.934.v3.git.1619052906768.gitgitgadget@gmail.com>
        <xmqqbl9zcawf.fsf@gitster.g> <xmqqk0ol7cka.fsf@gitster.g>
        <CACZqfqCXrhUtsC3TLYaw6u7D0VohsBcz10aVxpe-1u8gg77qxQ@mail.gmail.com>
        <CAPig+cR0Z=sUPHW8kuMG0sOv4bb309MV=WTR1nMGOoYB+1yfVg@mail.gmail.com>
Date:   Sun, 02 May 2021 11:39:47 +0900
In-Reply-To: <CAPig+cR0Z=sUPHW8kuMG0sOv4bb309MV=WTR1nMGOoYB+1yfVg@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 1 May 2021 22:15:18 -0400")
Message-ID: <xmqqv981c0zw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A92AE942-AAEF-11EB-8B4F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Indeed. While it might be nice to settle upon a single punctuation
> style for these messages, I don't see this as a requirement of the
> patch in question. It could, of course, be re-rolled as a two-patch
> series in which the second patch addresses the exclamation points, but
> fixing the punctuation could also be done later as a follow-up patch
> by someone (it doesn't need to be you). So, I don't see a good reason
> to hold up the current patch which stands nicely on its own.

I would agree in general, especially for a patch that fixes some
behaviour that hurts people *and* does a clean-up while at it, that
it is OK that the secondary "clean-up" part does not do as through
job as it should.

But isn't the premise of this particular patch "these 'already
up-to-date' messages puzzle readers by being sligntly different,
when the differences are not meant to convey anything, so let's
unify them and make them more coherent to help readers and
translators", is it?  I think that was why "Yeeah!" was removed, for
example.  Now we were made aware of the presence of "Already up to
date" vs "Already up to date!" by the "grep" tool.  Leaving half the
grep hits unaddressed makes the patch look like stopping halfway the
task it started to do.

So, in this particular case, I do not agree with any of the
"two-patch" or "follow-up" or "somebody else can do so".

Thanks.
