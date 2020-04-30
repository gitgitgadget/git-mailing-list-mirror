Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AECEC8300A
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05B720838
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 09:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM/E1TQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgD3Jlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgD3Jlw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 05:41:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A48FC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:41:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so6017074wrv.10
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 02:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SjSXqS/h69SH3yTlBzHh8WPrbCssDfPdfBoq+p4p+Co=;
        b=MM/E1TQHEafQyUdpMgKtyUFERc2cU9SNkaVrxudmCse42BNJJoBvavX021fnKKciJp
         kADWoYtA5T/Q522FRfXbwnfDg521DNgbZlmBBCHd4m17d4Iv4K9aOSu4d8RwPbhgFrZQ
         56XEixAu1eZhl7Qk3bzmb39ptPGlRDRLqMgm1n6E93RRly3bAx680fgcfGme5TcyQ7Yg
         okrrekwyHEQfBwYdQtuvKcXXaB8gwI4wrF1O9ZNRN9hnqyR5rnut+wXTzoKpQ5Lv61QP
         vWEyuQAGoI5JCnuEqYioC6q7/VqJKzKz8ra+Y2PYiL8W9VCX6IByuCxEkUEUcB0fy7CZ
         KHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjSXqS/h69SH3yTlBzHh8WPrbCssDfPdfBoq+p4p+Co=;
        b=RdnSk+UCQKoNym5X68VpxRJMnYEH/FiUbEdu9+6O6BnUxtuLBQPkHiCmh6iddzo9iz
         sb3ytT2kuqe36ZHBKC7cfokdesRFcXwrxMVA/s25SFvC92Gzjv4OvMDJpj2frDwRfXdb
         nSuGysLKog1AmiK2wlG03a+5AWCFwBk7A2x8n9S2wi+ekPZICP9shH4G9Ahvn6WU5LBY
         uMatiksvjHVlG4Ot/bRvlExTCRZLYf3Xu0ayNkJ+6e/3CboBzMmAxxLK1r3Gg5tmlF/e
         TrvQOCD4hKvtl6QWSSwa1P4sYb67F2rG/dRDhGGxrMmpRsB5aR0rAM0zlAXGd2XlV+I8
         nipg==
X-Gm-Message-State: AGi0Pua9jha9NpmpRLRaZIWk83793J+kkuUZyf7Otyqfi5kXzXlkHE+R
        rPY+c3j3KxB58SgHMAp6uT1AoH3I
X-Google-Smtp-Source: APiQypLrKJBLWsiWkcFATmO2zPHLZzFxcDQ945ATl71DdqSPdaLM8+CmCX6cYUjNiukveLGxeZLp0A==
X-Received: by 2002:adf:d4ce:: with SMTP id w14mr2765350wrk.232.1588239710933;
        Thu, 30 Apr 2020 02:41:50 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id z10sm3225243wrg.69.2020.04.30.02.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 02:41:50 -0700 (PDT)
Subject: Re: [PATCH] rebase: save autostash entry into stash reflog on --quit
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c2babcad-d14d-0e06-3897-a3653e72edf6@gmail.com>
Date:   Thu, 30 Apr 2020 10:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <353a67567a90aea8a90bce1de05d005c61b3b670.1588066252.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

Thanks for working on this, the implementation and test look fine

Best Wishes

Phillip

On 28/04/2020 10:31, Denton Liu wrote:
> In a03b55530a (merge: teach --autostash option, 2020-04-07), the
> --autostash option was introduced for `git merge`. Notably, when
> `git merge --quit` is run with an autostash entry present, it is saved
> into the stash reflog. This is contrasted with the current behaviour of
> `git rebase --quit` where the autostash entry is simply just dropped out
> of existence.
> 
> Adopt the behaviour of `git merge --quit` in `git rebase --quit` and
> save the autostash entry into the stash reflog instead of just deleting
> it.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> 
> Notes:
>     This patch is based on 'dl/merge-autostash'.
> 
>  Documentation/git-rebase.txt |  3 ++-
>  builtin/rebase.c             |  1 +
>  t/t3420-rebase-autostash.sh  | 20 ++++++++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index f7a6033607..7d0c89a184 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -256,7 +256,8 @@ See also INCOMPATIBLE OPTIONS below.
>  --quit::
>  	Abort the rebase operation but HEAD is not reset back to the
>  	original branch. The index and working tree are also left
> -	unchanged as a result.
> +	unchanged as a result. If a temporary stash entry was created
> +	using --autostash, it will be saved to the stash reflog.>  --apply:
>  	Use applying strategies to rebase (calling `git-am`
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index bc4fc69906..71aec532b1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1556,6 +1556,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		goto cleanup;
>  	}
>  	case ACTION_QUIT: {
> +		save_autostash(state_dir_path("autostash", &options));
>  		if (options.type == REBASE_MERGE) {
>  			struct replay_opts replay = REPLAY_OPTS_INIT;
>  
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index b97ea62363..ca331733fb 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -184,6 +184,26 @@ testrebase () {
>  		git checkout feature-branch
>  	'
>  
> +	test_expect_success "rebase$type: --quit" '
> +		test_config rebase.autostash true &&
> +		git reset --hard &&
> +		git checkout -b rebased-feature-branch feature-branch &&
> +		test_when_finished git branch -D rebased-feature-branch &&
> +		echo dirty >>file3 &&
> +		git diff >expect &&
> +		test_must_fail git rebase$type related-onto-branch &&
> +		test_path_is_file $dotest/autostash &&
> +		test_path_is_missing file3 &&
> +		git rebase --quit &&
> +		test_when_finished git stash drop &&
> +		test_path_is_missing $dotest/autostash &&
> +		! grep dirty file3 &&
> +		git stash show -p >actual &&
> +		test_cmp expect actual &&
> +		git reset --hard &&
> +		git checkout feature-branch
> +	'
> +
>  	test_expect_success "rebase$type: non-conflicting rebase, conflicting stash" '
>  		test_config rebase.autostash true &&
>  		git reset --hard &&
> 

