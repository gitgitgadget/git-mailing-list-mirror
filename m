Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E11C4332F
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 22:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiDYWZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 18:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343586AbiDYVlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 17:41:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A169912862D
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 14:38:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4734D189352;
        Mon, 25 Apr 2022 17:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9ASI6BEbsqLMUa033pGKQfC2wKAe0O2QLWCp9O
        cjmFk=; b=x3JKrwQO2j+R59ur1QtTsrTDBijOi9uRmjkN5BUFrU+Y9TDnjwan4n
        sxNgyL7EHmPWnf9bQX0llTJiAj6lHdT5qtGKzM1j8axF3W1OY80Xrjgppgoscmi2
        Y561quloQ1mCjAdspdqD4Qgk9BRuVB6Lkrkm1piBP1VkZfXqOwMag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 402A7189351;
        Mon, 25 Apr 2022 17:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92A98189350;
        Mon, 25 Apr 2022 17:38:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 5/7] merge-recursive: add merge function arg to
 'merge_recursive_generic'
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <80c25c7587484ca32afcfd6cc054eab78dd1348a.1650908958.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 14:38:13 -0700
In-Reply-To: <80c25c7587484ca32afcfd6cc054eab78dd1348a.1650908958.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 25 Apr 2022 17:49:15
        +0000")
Message-ID: <xmqqwnfcu9mi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0325B3A4-C4E0-11EC-9DCC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
> +	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, merge_recursive, &result)) {

This one does need input from Elijah to properly evaluate.  Off the
top of my head, I wonder if the choice of the merge function should
be part of "struct merge_options".

