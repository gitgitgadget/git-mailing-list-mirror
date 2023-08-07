Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3287C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 16:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjHGQQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjHGQQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 12:16:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E513210CF
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 09:16:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E5802FF9F;
        Mon,  7 Aug 2023 12:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F9RhJnOgbsQ8gq3QGF0eN1wRZFw2O1BKCMFBRM
        JVIis=; b=sEn45pzcs5zINVuXdS7LQUvZOP9o/NeQRjjZ8e3yCu8BK8Cnmn0ZcV
        9AGRsygFk0trJYuGLbLMMPnDqzDfmt7ACE6Kc9T1YWZDPlvHx4qfNY4OLVTl+TiP
        PzKrw3t0iV3JSwcjbT6jZkqHhq0/dxFKGEi321dkiGuNcofGVmVRk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 862CF2FF9E;
        Mon,  7 Aug 2023 12:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C22A42FF9D;
        Mon,  7 Aug 2023 12:16:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase --skip: fix commit message clean up when
 skipping squash
References: <pull.1558.git.git.1691068176051.gitgitgadget@gmail.com>
        <xmqqedkj515a.fsf@gitster.g>
        <b43a5b46-f391-bd9e-4bf2-bfeaa3548f3e@gmail.com>
Date:   Mon, 07 Aug 2023 09:16:30 -0700
In-Reply-To: <b43a5b46-f391-bd9e-4bf2-bfeaa3548f3e@gmail.com> (Phillip Wood's
        message of "Mon, 7 Aug 2023 10:59:41 +0100")
Message-ID: <xmqqzg32hlpd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5842150-353D-11EE-911B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> I am not sure if deviating from expect vs actual is such a good
>> idea.  It is not like use of two temporary files are transparent to
>> the caller of the new test helper---indeed, expect and actual are
>> likely to be used by the caller in tests that comes before or after
>> the ones that use test_commit_message, and by using a pair of files
>> that are different, the caller will now see two extra untracked
>> files left in the working tree.
>
> That's true, looking at test-lib-functions.sh it seems I unwittingly
> followed the example of test_cmp_config() which uses
> {actual,expect}.config when it calls test_cmp(). Anyway as this is in
> next I assume you're happy enough with the implementation as it
> stands.

You assumed too much ;-).  The above is a bad move, but is minor
enough and it is not a show-stopper.  If you are aware of other bad
examples, clean-up patches after the dust settles would be very much
welcomed.

Thanks.
