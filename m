Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077F1C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C030861178
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhHYATs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:19:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61647 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhHYATr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:19:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32942D4987;
        Tue, 24 Aug 2021 20:19:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kx8B8SB1ZiCHw4KGFcZcFwE5w/DQv5+3y+9eF9
        MYtg8=; b=uxOloK+tOz+Tk7nquOxV2XPZo8tup3FoP21P6Uh4GcOsA3EbthcJg2
        ITTuz3KeCqs9vzHEttLKcXoI3vzWB5nyBCaHxWH+cDa5X58fZePIdxAQwsFcSOaE
        dG8qcdQggEBsnj4M8resd8PPB/dAAXDzDjSIMoXfJyicvhoFWOMK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A736D4986;
        Tue, 24 Aug 2021 20:19:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90EFBD4983;
        Tue, 24 Aug 2021 20:19:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/4] test-tool: split up "read-cache" tool
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
        <cover-v2-0.4-00000000000-20210824T091204Z-avarab@gmail.com>
        <YSVwioizjGKVSXQA@nand.local>
Date:   Tue, 24 Aug 2021 17:18:59 -0700
In-Reply-To: <YSVwioizjGKVSXQA@nand.local> (Taylor Blau's message of "Tue, 24
        Aug 2021 18:19:54 -0400")
Message-ID: <xmqq35qyl6ks.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C6AEBD4-053A-11EC-8593-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> If we're looking for things to clean up, I do like the conversion to the
> parse-options API instead of reading argv ourselves, but probably
> otherwise prefer the code as-is instead of split across many files.
>
> But I may be in the minority, and there may be others who do find the
> split-up version easier to grok.

FWIW, you're not alone.  I too like the use of parse_options, but I
fail to be enthused by changes to churn the test helper binary.
