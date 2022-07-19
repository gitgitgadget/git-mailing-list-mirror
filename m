Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78918C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiGSToi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 15:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSToi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 15:44:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5732352DEB
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 12:44:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE9BC12677D;
        Tue, 19 Jul 2022 15:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=2i+Hcic49V3U2/I2fLkOWEKOOB+WJzPlLQqTkAo1kV0=; b=W0PG
        GuLSBBoG3vQAGLCLLwzlTZRjX7YJ4VjscrMDaxke0Iu8UwLZqvaXr8axCKFh91JU
        QxaJIsEYPg8Ozb2iINjfb2ENqVg1D31FAiDzM4i9qKesiaV/Uf4avrnYVU6s4jFr
        T74CuWGZ4znhB+HkkBLAVsmmuuYMJiq3luwf+EE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4BE812677C;
        Tue, 19 Jul 2022 15:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 16A5212677B;
        Tue, 19 Jul 2022 15:44:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] t/*: avoid "whitelist"
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
        <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
        <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
        <220715.86o7xqzkt3.gmgdl@evledraar.gmail.com>
        <75cc0f43-d9a5-45d3-5e36-dd20acfebf50@github.com>
Date:   Tue, 19 Jul 2022 12:44:34 -0700
Message-ID: <xmqqwnc8anvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 381CE142-079B-11ED-AE6E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> 	GIT_TEST_PASSING_SANITIZE_LEAK=<bool> when compiled with
>> 	SANITIZE=leak will, when true, only run those tests that declare
>> 	themselves leak-free by setting "TEST_PASSES_SANITIZE_LEAK=true"
>> 	before sourcing "test-lib.sh". This test mode is used by the
>> 	"linux-leaks" CI target.
>
> Another iteration:
>
>   GIT_TEST_PASSING_SANITIZE_LEAK=<bool> focuses the test suite on finding
>   memory leaks. When the variable is true and Git is compiled with
>   SANITIZE=leak, only run those tests that declare themselves leak-free by
>   setting "TEST_PASSES_SANITIZE_LEAK=true" before sourcing "test-lib.sh".
>   This test mode is used by the "linux-leaks" CI target.

Sounds good.  These scripts opt into the sanitize-leak tests by
declaring themselves to be leak-free and that is captured very well
without using the *list word ;-)
