Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C48C54EE9
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 20:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIVUoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 16:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiIVUoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 16:44:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC02BE1F
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 13:44:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B355133DD3;
        Thu, 22 Sep 2022 16:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T9vIKiCnRLaDfG2cehrfDi5gAEyglTyh0QVXGj
        54J7I=; b=yfd7mLOm85K+tSdK51mqEaEyUsXM46h1KwC/dpGmXTQQfcPH/X+duT
        k/o7Elt+F4JN++2IOnkpU6xjTSQmPCuILju29NbRiGNWCEYraw1kWy0stEuCXpSA
        ZXOEnLhSSUmavuPRIcnmaexG4rck1ebwS0LrrSS3P01cqup11o/K8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24A09133DD2;
        Thu, 22 Sep 2022 16:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E7B1133DCF;
        Thu, 22 Sep 2022 16:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
Subject: Re: [PATCH] maintenance: make unregister idempotent
References: <pull.1358.git.1663635732095.gitgitgadget@gmail.com>
        <xmqqpmfo4pc7.fsf@gitster.g>
        <bc57439a-bddc-6c1a-a51d-11498d17c206@github.com>
        <xmqqtu4zxl25.fsf@gitster.g>
        <748f4e1f-f2a3-872c-2ffd-643841c454dd@github.com>
Date:   Thu, 22 Sep 2022 13:44:02 -0700
In-Reply-To: <748f4e1f-f2a3-872c-2ffd-643841c454dd@github.com> (Derrick
        Stolee's message of "Thu, 22 Sep 2022 15:46:41 -0400")
Message-ID: <xmqqh70zxhpp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BC190E0-3AB7-11ED-B588-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Adding a 'git maintenance list-registered' or something would solve
> that problem, but I'm not sure it is a super high priority.

Is that "git maintenance" or "scalar" that list-registered would
hang below?

In any case, I tend to think the word "idempotent" is used as a
rough synonym to "sloppy", but unregistering from the automatic
maintenance (but still known as part of enlistment?) would probably
be a rare event that would not be a huge deal if the user failed to
do so without getting reminded, so I would not oppose to the step
[2/2] of the updated series.

Thanks, queued.
