Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22482C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346314AbiCXQkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239263AbiCXQke (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:40:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD38B3E0EA
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:39:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EFD018F1F5;
        Thu, 24 Mar 2022 12:39:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xuElqgtJ2UT6ErNA4a3eF6+03na8oToZ+tGeAI
        DtlIE=; b=Yp5F+ePiU4Boj+7pB1yni7uZBh5xkPa16ZeL6A6K+aqMaPO16RdDw9
        CjzGvKzOduh65D01VRlDr8jhrKovPTHZejV9l5pD5cqtxGMGD8iWKE3VDNvWQV5G
        0OLxibSgGP79wxkTB//kkVYs/b7FqklnHtebqI6ZvkTt9NaJZ9XJs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2770418F1F4;
        Thu, 24 Mar 2022 12:39:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83D8F18F1F1;
        Thu, 24 Mar 2022 12:38:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
        <xmqqmthgu3e6.fsf@gitster.g>
        <e5331972-512a-c498-6a1b-927f21ef9de2@github.com>
        <YjuVAgjaiqrcT7P1@nand.local> <xmqqfsn8p8nr.fsf@gitster.g>
        <72c54461-8af7-29fc-04da-f435adee9bbe@github.com>
Date:   Thu, 24 Mar 2022 09:38:57 -0700
In-Reply-To: <72c54461-8af7-29fc-04da-f435adee9bbe@github.com> (Derrick
        Stolee's message of "Thu, 24 Mar 2022 11:42:44 -0400")
Message-ID: <xmqqtubnl2zi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7487724-AB90-11EC-95A5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> The full post-condition check requires more test code, but that's not
> really a problem. The problem comes in if that test is now too rigid
> to future changes in that subcommand. What if the post-conditions
> change in a subtle way because of the subcommand does something
> differently, but in a way that is not of importance to the top
> command?
>
> In this specific case, the test name says that it "packs non-kept
> objects", so we can do more here to validate that post-condition
> that we care about.

Thanks for clearly laying out the way to think about the issue.  I
agree with all of it, of course ;-)

