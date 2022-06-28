Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E106C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 20:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbiF1UQf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiF1UQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 16:16:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DE3A194
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 13:12:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3C76145AC6;
        Tue, 28 Jun 2022 16:12:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lsCFQ4iATEqVUMaS3LYKwgUm18rhOMH7wkwB8l
        0M6tY=; b=oGckKqv7y6yHIs7MqcSVTXVPSj6IvhDS4JELCTUTj75mvSPI45f5bc
        /2Z28zJLCFwc2thxWF/Z13rw9dGSTXR0QkSOcR7zT9iKvPl18m1K/zxkLNjBLM8v
        4KUhAL9oI9MqFMy6n4/HZJ9qXukRn4o8zxJTM/kIz7Hq691L379ho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A173145AC5;
        Tue, 28 Jun 2022 16:12:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CB02E145AC2;
        Tue, 28 Jun 2022 16:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v3] ls-files: update test style
References: <pull.1269.v2.git.1656407664694.gitgitgadget@gmail.com>
        <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:12:13 -0700
In-Reply-To: <pull.1269.v3.git.1656409884091.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Tue, 28 Jun 2022 09:51:23
        +0000")
Message-ID: <xmqqzghwim3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A1F4FDE-F71E-11EC-A85E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/README b/t/README
> index 309a31133c6..5e0539412b4 100644
> --- a/t/README
> +++ b/t/README
> @@ -547,6 +547,52 @@ This test harness library does the following things:
>     consistently when command line arguments --verbose (or -v),
>     --debug (or -d), and --immediate (or -i) is given.
>  
> +Recommended style
> +-----------------
> +Here are some recommented styles when writing test case.
> +
> + - Keep test title the same line with test helper function itself.
> +
> +   Take test_expect_success helper for example, write it like:
> +
> +  test_expect_success 'test title' '
> +  ... test body ...
> +  '

Indent the body further to the right?

> + - Indent the body of here-document, and use "<< -" instead of "<<" to strip prefix TAB:

Overly long line.

Did you mean to have a space between "<<" and "-"?

"prefix TAB" -> "leading TABs used for indentation" (plural is the
important part)?  

Mention end of here-document marker should by default be quoted,
unless the body needs $variable_interpolation?

> +  test_expect_success 'test something' '
> +      cat >expect <<-\EOF &&
> +      one
> +      two
> +      three
> +      EOF
> +      test_something > actual &&
> +      test_cmp expect actual
> +  '
> +
> +   Instead of:
> +
> +  test_expect_success 'test something' '
> +      cat >expect <<\EOF &&
> +  one
> +  two
> +  three
> +  EOF
> +      test_something > actual &&
> +      test_cmp expect actual
> +  '


Thanks.
