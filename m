Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F0BC77B7E
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 17:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbjD0R0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 13:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbjD0R0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 13:26:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9F12704
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 10:26:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7ba919dcso1577930276.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 10:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682616408; x=1685208408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrjIc/skg5NgeOYp/Pp1amLUnnX+iU4fZylEvFnPF74=;
        b=eaHMJjK+fx+l3YaO5CuygoDATlp1UAuvLYDZ5j5RvtGRiSYn/9+baEuc5M2CKAFnJA
         T3DvKqZ0o4Q5yCRryUl7ScJEUB6rGslWD6hF7uR4BTcP8A1PvS09leWM0oHmQukrS5zR
         2VbIhGo/baMC5RIvG711uWYiKulW6g/i9hNJwftz3HEvqXxIktvKU+MqGzt1jdDwmDsl
         ghzxtio+VKP9pJDbEdEoCJTKFu2kCK8URcs0IRjgFPPUn8suBhWqyJ7+sEN2+1CqTh40
         SxhqgiI7dUJgScLHOD0WeFRg4v9qsICr1NULqdvv9A2jn4EPZQtpl6GL/NMqAo0j3XLJ
         1b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682616408; x=1685208408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrjIc/skg5NgeOYp/Pp1amLUnnX+iU4fZylEvFnPF74=;
        b=dNAyxJdbDlhApE9SC5y94tUwiMsDIVWT1p/hvafuQng9Cy38dbmgceKEQN+WkFo7dC
         ePhklUcoAqiMmOYT5km2bQIYTSIIgfcCKtQKTO+miLvZ7Siq10t35QFbvE/cW6VqS5fj
         oc9PeLPDlEddrYTqYWVWhSIsgdNzcc7Nmyrra3zLOzE0ZlBmt0qsbzWutBmEX69PGeiV
         72HzhsC2gkXCiPQVEtM51tohgZUbkBT97Mzl5Txvf0tlU/kS2jcYs0Ia71YtXoaJ4RAo
         msY0f8BLKPqtTIGuBoES9I6+eKgxPriH34U99SeFFzp35Ww8ISMh0EndMqe9xKJnbNO8
         XKpw==
X-Gm-Message-State: AC+VfDztZJVI7dlO40P4eba73ekcfBMwTMxiD5PtlzAiLNLEhHEsDYTt
        Mz7qw8PK/G5MWnHyERA1AA04IDr0STGsyQ==
X-Google-Smtp-Source: ACHHUZ6hkwj4oBYkiIFo6rNzEStv/PekccHsYyC04YWfxrRRYQeCeIm2b7aaLv8iaNQPxXJZ2RiDznrqMKy1UA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:ae10:0:b0:b96:3344:c211 with SMTP id
 a16-20020a25ae10000000b00b963344c211mr1207749ybj.10.1682616407869; Thu, 27
 Apr 2023 10:26:47 -0700 (PDT)
Date:   Thu, 27 Apr 2023 10:26:38 -0700
In-Reply-To: <d1fb6eeae76bc550030475e40868b90a2ca6ce8c.1682593865.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im> <d1fb6eeae76bc550030475e40868b90a2ca6ce8c.1682593865.git.ps@pks.im>
Message-ID: <kl6lo7n9me29.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 3/8] fetch: fix missing from-reference when fetching HEAD:foo
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For v2, I've only read through this patch for now. I'm still formulating
my thoughts on the output format and the CLI option name.

Patrick Steinhardt <ps@pks.im> writes:

> `store_updated_refs()` parses the remote reference for two purposes:
>
>     - It gets used as a note when writing FETCH_HEAD.
>
>     - It is passed through to `display_ref_update()` to display
>       updated references in the following format:
>
>       ```
>        * branch               master          -> master
>       ```
>
> In most cases, the parsed remote reference is the prettified reference
> name and can thus be used for both cases. But if the remote reference is
> HEAD, the parsed remote reference becomes empty. This is intended when
> we write the FETCH_HEAD, where we skip writing the note in that case.
> But it is not intended when displaying the updated references and would
> cause us to miss the left-hand side of the displayed reference update:
>
> [...]
>
> As the return value of `prettify_refname()` would do the correct thing
> for us in all three cases, we can fix the bug by passing through the
> full remote reference name to `display_ref_update()`, which learns to
> call `prettify_refname()`. At the same time, this also simplifies the
> code a bit.

This rewritten section explains the bug and the fix very nicely :)
Thanks!

> diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
> index 0e45c27007..b9dcdade63 100755
> --- a/t/t5574-fetch-output.sh
> +++ b/t/t5574-fetch-output.sh
> @@ -54,6 +54,31 @@ test_expect_success 'fetch compact output' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'fetch output with HEAD and --dry-run' '
> +	test_when_finished "rm -rf head" &&
> +	git clone . head &&
> +
> +	git -C head fetch --dry-run origin HEAD >actual 2>&1 &&
> +	cat >expect <<-EOF &&
> +	From $(test-tool path-utils real_path .)/.
> +	 * branch            HEAD       -> FETCH_HEAD
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git -C head fetch origin HEAD >actual 2>&1 &&
> +	test_cmp expect actual &&

Maybe rename the test to just 'fetch output with HEAD'? The 'and
--dry-run' part seems completely obsolete.
