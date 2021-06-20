Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAFAC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D088260720
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhFTSQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFTSQx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 14:16:53 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D553C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 11:14:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n23so8953826wms.2
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6SKSY59pGKeiCqDD+e3wgf8N6YipWiCluv4akScrrKs=;
        b=Vxgv0LRoHQhYnLJI2GmS+EYgbywqmcUtxgKMUaFpdrQ9wcr/EuCSMyZ+zvBSktfRmd
         QlLIuOIJ31UdZl6cqaz6OX4Jv1wL5Ur+X1A3B8R9J7uav4nDiNaI3sSKXoH9PmjkeSSQ
         KBXZyNE8E3hkBI51lpq0+GeY1VmrlAc6QEOUS9ggG74p4nYJv9bDFoRKo3+1EvnR6AzC
         VVRipYXgm70pcLOxGzekfC6LaaDkkrjzSvabTAKtPFnxxmlpxwhZgwI7OLVwX70n00fO
         qieycePcfwVL8Z6gV0UDqs9aKll6CqunMq7hiKDDrfWYSPB99pp7WfAecYGfahtpP4ty
         dBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6SKSY59pGKeiCqDD+e3wgf8N6YipWiCluv4akScrrKs=;
        b=K5eN3J0H3LApL9K9A50xp5bJZx6Sx5pDuZp9Lnb9Khh9PEc8C9MommY22ioZjf7NSt
         78kwpSGGQVRoZrqRZGS6msKlD5UcZ2DO/garbCNwNI1xHxrCR2xMHxHdyu5vVVdB82Nj
         P3klUnc39fmPAHOass/dhtzqBHLQ3Pe78eFJ8dn4emrwf+B62tTueCu3PgaV3Dd5zH6R
         DxlaSY6idsQdEQ30XI2JbMngR8f63/kMJBiE2Bux3ANxi18irRZzreiLj5dtXcPARlvU
         RXSHWkM5SjXCmkY2UxeZca34Lk/hXeD9AU3QZa9VVJM3ygFFvzUup0Bx3qZNEcXsd86Z
         2LdA==
X-Gm-Message-State: AOAM533rof0bV//W7k44nh943TwfS4eehjBSZ5as22U5d9dY5qCP0o63
        I7QcIjVQRbMAPjqlFUaTKPiKOvrf8k8=
X-Google-Smtp-Source: ABdhPJzx4t8iaNSoDmr6g3YufokzBh5l3x5f2wIk3ECBSi95YDVZPpPZB6HPtWQ1VAL/uq1qCAgJMA==
X-Received: by 2002:a7b:ce87:: with SMTP id q7mr23150126wmj.111.1624212877934;
        Sun, 20 Jun 2021 11:14:37 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id t16sm15227197wmi.2.2021.06.20.11.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 11:14:37 -0700 (PDT)
Subject: Re: [PATCH 11/12] builtin/rebase: fix options.strategy memory
 lifecycle
To:     andrzej@ahunt.org, git@vger.kernel.org
References: <20210620151204.19260-1-andrzej@ahunt.org>
 <20210620151204.19260-12-andrzej@ahunt.org>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6e02fc85-42a4-8b19-1fe7-3527c2308a24@gmail.com>
Date:   Sun, 20 Jun 2021 19:14:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210620151204.19260-12-andrzej@ahunt.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrzej

Thanks for working on removing memory leaks from git.

On 20/06/2021 16:12, andrzej@ahunt.org wrote:
> From: Andrzej Hunt <ajrhunt@google.com>
> 
> This change:
> - xstrdup()'s all string being used for replace_opts.strategy, to

I think you mean replay_opts rather than replace_opts.

>    guarantee that replace_opts owns these strings. This is needed because
>    sequencer_remove_state() will free replace_opts.strategy, and it's
>    usually called as part of the usage of replace_opts.
> - Removes xstrdup()'s being used to populate options.strategy in
>    cmd_rebase(), which avoids leaking options.strategy, even in the
>    case where strategy is never moved/copied into replace_opts.


> These changes are needed because:
> - We would always create a new string for options.strategy if we either
>    get a strategy via options (OPT_STRING(...strategy...), or via
>    GIT_TEST_MERGE_ALGORITHM.
> - But only sometimes is this string copied into replace_opts - in which
>    case it did get free()'d in sequencer_remove_state().
> - The rest of the time, the newly allocated string would remain unused,
>    causing a leak. But we can't just add a free because that can result
>    in a double-free in those cases where replace_opts was populated.
> 
> An alternative approach would be to set options.strategy to NULL when
> moving the pointer to replace_opts.strategy, combined with always
> free()'ing options.strategy, but that seems like a more
> complicated and wasteful approach.

read_basic_state() contains
	if (file_exists(state_dir_path("strategy", opts))) {
		strbuf_reset(&buf);
		if (!read_oneliner(&buf, state_dir_path("strategy", opts),
				   READ_ONELINER_WARN_MISSING))
			return -1;
		free(opts->strategy);
		opts->strategy = xstrdup(buf.buf);
	}

So we do try to free opts->strategy when reading the state from disc and 
we allocate a new string. I suspect that opts->strategy is actually NULL 
in when this function is called but I haven't checked. Given that we are 
allocating a copy above I think maybe your alternative approach of 
always freeing opts->strategy would be better.

Best Wishes

Phillip

> This was first seen when running t0021 with LSAN, but t2012 helped catch
> the fact that we can't just free(options.strategy) at the end of
> cmd_rebase (as that can cause a double-free). LSAN output from t0021:
> 
> LSAN output from t0021:
> 
> Direct leak of 4 byte(s) in 1 object(s) allocated from:
>      #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
>      #1 0xa71eb8 in xstrdup wrapper.c:29:14
>      #2 0x61b1cc in cmd_rebase builtin/rebase.c:1779:22
>      #3 0x4ce83e in run_builtin git.c:475:11
>      #4 0x4ccafe in handle_builtin git.c:729:3
>      #5 0x4cb01c in run_argv git.c:818:4
>      #6 0x4cb01c in cmd_main git.c:949:19
>      #7 0x6b3fad in main common-main.c:52:11
>      #8 0x7f267b512349 in __libc_start_main (/lib64/libc.so.6+0x24349)
> 
> SUMMARY: AddressSanitizer: 4 byte(s) leaked in 1 allocation(s).
> 
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>   builtin/rebase.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 12f093121d..9d81db0f3a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -139,7 +139,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>   	replay.ignore_date = opts->ignore_date;
>   	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>   	if (opts->strategy)
> -		replay.strategy = opts->strategy;
> +		replay.strategy = xstrdup_or_null(opts->strategy);
>   	else if (!replay.strategy && replay.default_strategy) {
>   		replay.strategy = replay.default_strategy;
>   		replay.default_strategy = NULL;
> @@ -1723,7 +1723,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	if (options.strategy) {
> -		options.strategy = xstrdup(options.strategy);
>   		switch (options.type) {
>   		case REBASE_APPLY:
>   			die(_("--strategy requires --merge or --interactive"));
> @@ -1776,7 +1775,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.type == REBASE_MERGE &&
>   	    !options.strategy &&
>   	    getenv("GIT_TEST_MERGE_ALGORITHM"))
> -		options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
> +		options.strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
>   
>   	switch (options.type) {
>   	case REBASE_MERGE:
> 

