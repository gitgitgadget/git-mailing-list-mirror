Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970D3FA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 17:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJURo2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 13:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJURoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 13:44:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786F3262DD4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 10:44:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8ABA157B3B;
        Fri, 21 Oct 2022 13:44:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3UAqaJoVYndDoh74KH1EO9lBQgdind6azqy/1E
        /2zWo=; b=TNWC4d7xk6B0EMTqjfL8ol9o1K56FmMTZvrTS6Kg/V55sGenJMVdgr
        DhamgXhFCwv2kWIzWPqdPNh//NZfxzfxIupQ6UFpDFbEV+IK/CXJqiGATBKdm1ln
        ot8XHkMvZoCIiMoeqUM0W54k0WWZxuGOxrNHH/ciHF+bJzGTuMw20=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F3AC157B3A;
        Fri, 21 Oct 2022 13:44:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 10A2D157B39;
        Fri, 21 Oct 2022 13:44:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 7/8] rebase --abort: improve reflog message
References: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <pull.1150.v4.git.1666344108.gitgitgadget@gmail.com>
        <c8fa57f129dd61fd4925e1c29ca78b89364dc62b.1666344108.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 10:44:12 -0700
In-Reply-To: <c8fa57f129dd61fd4925e1c29ca78b89364dc62b.1666344108.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 21 Oct 2022 09:21:47
        +0000")
Message-ID: <xmqq7d0tm5qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA480A2E-5167-11ED-8B25-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When aborting a rebase the reflog message looks like
>
> 	rebase (abort): updating HEAD
>
> which is not very informative. Improve the message by mentioning the
> branch that we are returning to as we do at the end of a successful
> rebase so it looks like.
>
> 	rebase (abort): returning to refs/heads/topic
>
> If GIT_REFLOG_ACTION is set in the environment we no longer omit
> "(abort)" from the reflog message. We don't omit "(start)" and
> "(finish)" when starting and finishing a rebase in that case so we
> shouldn't omit "(abort)".

Super nice.

