Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C03C4338F
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 18:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AE960EAF
	for <git@archiver.kernel.org>; Sun,  8 Aug 2021 18:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhHHSB0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhHHSB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 14:01:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D38C061760
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 11:01:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so26284799pjh.3
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L3GGxvQ64SFvHX9r7Ez8fptZmSLKOODmRiOpdSLJEW0=;
        b=Muq/QOgpscafZ1Ep3aMPBrJAvZqS5S3aco/TcPsU/OGkjxlUN1ztYR9pOMir81wTta
         S2NnPOQoFBHrYWtXscUVP65f1v0E7p+iyp3hU9y3ktHS4xOaOAvmeQAI3bNgTrMKQ1lx
         4YQlBgFFBekjCPmeN2qSf/hRQMiyNfCJVjpUHCSaI/B++Z2p6AMVMZnmLLp8L38i7Ru7
         3pJH7cmcg9h3QdftuS0SSdJfZrEltjOgOH4kFzqh0PGNzoPU9MzimnTlXPSa28MKwW7C
         KJk5x/UHtjDQ0i6GJP+h0G+TX1w51N6DJ233da0NF16ml1S5pYBQoEXpfBu6JPdDiiNm
         7ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L3GGxvQ64SFvHX9r7Ez8fptZmSLKOODmRiOpdSLJEW0=;
        b=Zrmm/mBIYIeKyBuiTn1SdJLwvGsIXtCXAZ/BGXEtuLYQZcT3v7croQerWSPEKOlUex
         rWANL6uATK3F6qKgfLPkdoqY7k7Y341EWpL4FXzu+MLO2OzX3Jclw0JgcnvtnIs/ly3N
         VlA8lv4qW8tK9XJ5xflxZW6WgUaTt0u3oImmA/Hl4e0JXS5bYX6SdCDp4K6eQUZXIH5j
         AJtEEJMU3PJvTEtVCaN/osMoS5oybfeCs9N2My+enGAGjQ/SZQc66Szj9BckyaZc4IMS
         +PwZkvy+3Ecx2jKaTuOe4k2S7HJnQupaMcyKZlUuIHCFQYF0xaEejdxcSDxCq0I57eb4
         UWew==
X-Gm-Message-State: AOAM531YJH6YuTRoW3+uvCPHqHFZvUOVe1Ltd8ykEkdRtj9+CbPNFTOL
        6Px3xuMY1Z24xmQXPPkeEPY=
X-Google-Smtp-Source: ABdhPJy042IkDc5BeIpvsg8urC59Lsfsf9RIUgmJfr/+xVyeBa8N1os9LxQk9CzNInhgwlydH8WsRg==
X-Received: by 2002:a17:902:8f90:b029:12d:1b48:efd8 with SMTP id z16-20020a1709028f90b029012d1b48efd8mr3399584plo.23.1628445664689;
        Sun, 08 Aug 2021 11:01:04 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.84.169])
        by smtp.gmail.com with ESMTPSA id g7sm16687141pfv.66.2021.08.08.11.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 11:01:04 -0700 (PDT)
Subject: Re: [GSoC] [PATCH v4 0/8] submodule: convert the rest of 'add' to C
To:     Atharva Raykar <raykar.ath@gmail.com>, gitster@pobox.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com,
        rafaeloliveira.cs@gmail.com, sunshine@sunshineco.com
References: <20210806120147.73349-1-raykar.ath@gmail.com>
 <20210807071613.99610-1-raykar.ath@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <1131ec9a-d836-b45a-63c8-6f1d39dd3399@gmail.com>
Date:   Sun, 8 Aug 2021 23:31:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807071613.99610-1-raykar.ath@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/21 12:46 pm, Atharva Raykar wrote:
> Changes since v3:
> 
> * Rename the libified dir helper and update the docstring.
>

Just a note. I'm not really sure about this yet, the fact
that this series depends on the change introduced by
'ar/submodule-add-config'[1] might be worth mentioning in
re-rolls too. This could help the maintainer to easily identify
the topic dependency :-)

[1]: https://lore.kernel.org/git/20210801063352.50813-1-raykar.ath@gmail.com/

And ...

> Atharva Raykar (8):
>    submodule--helper: add options for compute_submodule_clone_url()
>    submodule--helper: refactor resolve_relative_url() helper
>    submodule--helper: remove repeated code in sync_submodule()
>    dir: libify and export helper functions from clone.c
>    submodule--helper: convert the bulk of cmd_add() to C
>    submodule--helper: remove add-clone subcommand
>    submodule--helper: remove add-config subcommand
>    submodule--helper: remove resolve-relative-url subcommand
> 
>   builtin/clone.c             | 118 +-------------
>   builtin/submodule--helper.c | 307 +++++++++++++++++++-----------------
>   dir.c                       | 114 +++++++++++++
>   dir.h                       |  10 ++
>   git-submodule.sh            |  96 +----------
>   5 files changed, 290 insertions(+), 355 deletions(-)
> 
> Range-diff against v3:

Thanks for consistently including a useful range-diff!

-- 
Sivaraam

> -:  ---------- > 1:  75edf24186 submodule--helper: add options for compute_submodule_clone_url()
> -:  ---------- > 2:  8e7a3e727a submodule--helper: refactor resolve_relative_url() helper
> -:  ---------- > 3:  82961ddd02 submodule--helper: remove repeated code in sync_submodule()
> 1:  99d139375d ! 4:  fa97d6801e dir: libify and export helper functions from clone.c
>      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
>        	else
>       -		dir = guess_dir_name(repo_name, is_bundle, option_bare);
>       -	strip_trailing_slashes(dir);
>      -+		dir = guess_target_dir_from_git_url(repo_name, is_bundle, option_bare);
>      ++		dir = git_url_basename(repo_name, is_bundle, option_bare);
>       +	strip_dir_trailing_slashes(dir);
>        
>        	dest_exists = path_exists(dir);
>      @@ dir.c: int is_empty_dir(const char *path)
>        	return ret;
>        }
>        
>      -+char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare)
>      ++char *git_url_basename(const char *repo, int is_bundle, int is_bare)
>       +{
>       +	const char *end = repo + strlen(repo), *start, *ptr;
>       +	size_t len;
>      @@ dir.h: static inline int is_dot_or_dotdot(const char *name)
>        int is_empty_dir(const char *dir);
>        
>       +/*
>      -+ * Retrieve a target directory name by reading "humanish" part of the
>      -+ * given Git URL.
>      ++ * Retrieve the "humanish" basename of the given Git URL.
>       + *
>       + * For example:
>       + * 	/path/to/repo.git => "repo"
>       + * 	host.xz.foo/.git => "foo"
>       + */
>      -+char *guess_target_dir_from_git_url(const char *repo, int is_bundle, int is_bare);
>      ++char *git_url_basename(const char *repo, int is_bundle, int is_bare);
>       +void strip_dir_trailing_slashes(char *dir);
>       +
>        void setup_standard_excludes(struct dir_struct *dir);
> 2:  11eea777ba ! 5:  a3aa25518d submodule--helper: convert the bulk of cmd_add() to C
>      @@ builtin/submodule--helper.c: static int add_config(int argc, const char **argv,
>       +
>       +	add_data.repo = argv[0];
>       +	if (argc == 1)
>      -+		add_data.sm_path = guess_target_dir_from_git_url(add_data.repo, 0, 0);
>      ++		add_data.sm_path = git_url_basename(add_data.repo, 0, 0);
>       +	else
>       +		add_data.sm_path = xstrdup(argv[1]);
>       +
> 3:  51393cd99b = 6:  9667159d4b submodule--helper: remove add-clone subcommand
> 4:  50cedcd8a8 = 7:  dc87b5627a submodule--helper: remove add-config subcommand
> 5:  02558da532 = 8:  ea08e4fbad submodule--helper: remove resolve-relative-url subcommand
> 
