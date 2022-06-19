Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC3C43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 13:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiFSN6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiFSN6f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 09:58:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD045A465
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 06:58:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so5623606wms.1
        for <git@vger.kernel.org>; Sun, 19 Jun 2022 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vTWPWJmUm3rkGlVTz/8rPblRIqaYctVWQSa5b3VCHFU=;
        b=YeCfxX3IfOaUvUxZnDUnTRuKIqehpPX41b5eIjdMojXIpIH0Pbas6/U6MoVLrkkHb+
         CQaUSFor3FKu7a7f/HieW3C4pVle+cpO8GUj/+LInhsL6Yesf9qjCMvftYaQY2ODxdt4
         Gz8Zqe8v38+G9t2J0BBnHeocZJ/RHaOCbWr8klojy0XwtHhcd793+8YQuatqfQUxrh07
         u7dTCsecUVpjjlEhAjA/qazn6v+WQWTXzRxbCBEDAXHxLwFlIRlj9ZbblkCuS9w5LBnt
         gwDTxGDMofTuwB0xr1NyA3r+11u4DJJ95sKHC2rONaaZz2RYU1ySHmzvMeC1DNbQnr5x
         yeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vTWPWJmUm3rkGlVTz/8rPblRIqaYctVWQSa5b3VCHFU=;
        b=XGHkUDQ9sI8SKM0XO8YXC6CSErztUf/GGILQ+2P2Q5hZuc0gtC5A1AtO9X1Aw71rBe
         xcy1g31zzs4XBZmIHiyJtxSOywG2zzf5Um7FPFz8C/4G8HLZdkoQghD38sigUWXII8fp
         mqT8h640mCCcxv8fB/Jicgds3+yDVu7b6/Syyl6n1EsW3ThyQltzE5AkED/3zchrHfRH
         PuR3vhPHqsuYth1SBm+4S2QcXGK5/KyzhtgxSHzVgpDkOgKFlAKHA66eZ0/N426/Uf63
         EAIq81igK2GEn8vffiZ51O/gJQSs6qIDaxOStnxghJBNyPgA0jZXhlG9b8rSZA0XBjC6
         slQQ==
X-Gm-Message-State: AOAM531opC+YIBc6EIuiPMuSXWn3pmupyvIyLKDs8DjS34RMk3+/7hv6
        xtzkPXdQq5Ro1sPfMpzcTaM=
X-Google-Smtp-Source: ABdhPJyfCxiqs4uy63Tw9ugCcZDWwwi1ATBglUsaFZ7ExXs4uzBAOdpccNxUowuLrhNjzTlGpS/xCw==
X-Received: by 2002:a1c:4e03:0:b0:39c:5bbc:e0d2 with SMTP id g3-20020a1c4e03000000b0039c5bbce0d2mr29896227wmh.184.1655647110218;
        Sun, 19 Jun 2022 06:58:30 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b002103bd9c5acsm10374146wrn.105.2022.06.19.06.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 06:58:29 -0700 (PDT)
Message-ID: <e562bd1b-8be6-db70-923a-cfa27c3edb36@gmail.com>
Date:   Sun, 19 Jun 2022 14:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] Create branch_checked_out() helper
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1254.v2.git.1655234853.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 14/06/2022 20:27, Derrick Stolee via GitGitGadget wrote:
> This is a replacement for some patches from v2 of my 'git rebase
> --update-refs' topic [1]. After some feedback from Philip, I've decided to
> pull that topic while I rework how I track the refs to rewrite [2]. This
> series moves forward with the branch_checked_out() helper that was a bit
> more complicated than expected at first glance. This series is a culmination
> of the discussion started by Junio at [3].
> 
> [1]
> https://lore.kernel.org/git/pull.1247.v2.git.1654634569.gitgitgadget@gmail.com
> [2]
> https://lore.kernel.org/git/34264915-8a37-62db-f954-0b5297639b34@github.com/
> [3] https://lore.kernel.org/git/xmqqr140t9am.fsf@gitster.g/
> 
> Here is the patch outline:
> 
>   1. Add a basic form of branch_checked_out() that only looks at the HEAD of
>      each worktree. Since this doesn't look at BISECT_HEAD or REBASE_HEAD,
>      the helper isn't linked to any consumer in this patch. A test script is
>      added that verifies the current behavior checks that are implemented,
>      even if they are not connected yet.
>   2. Make branch_checked_out() actually look at BISECT_HEAD and REBASE_HEAD.
>      Add tests for those cases, which was previously untested in the Git test
>      suite. Use branch_checked_out() in 'git branch -f' to demonstrate this
>      helper works as expected.
>   3. Use branch_checked_out() in 'git fetch' when checking refs that would be
>      updated by the refspec. Add tests for that scenario, too.
>   4. Use branch_checked_out() in 'git branch -D' to prevent deleting refs
>      from under an existing checkout. The commit message here describes some
>      barriers to removing other uses of find_shared_symref() that could be
>      good investigations for later.
>   5. Be careful when constructing the strmap to free old values, even though
>      this should only happen in error scenarios. Add tests that verify this
>      behavior.
> 
> 
> Updates in v2
> =============
> 
>   * branch_checked_out() has a new prototype where it returns a 'const char
>     *' instead of copying the path.
>   * The test script is marked with TEST_PASSES_SANITIZE_LEAK and test are
>     careful to avoid using 'git rebase' or 'git bisect' when possible.
>   * Tests that cannot avoid memory-loss from 'git fetch' are marked with the
>     "!SANITIZE_LEAK" prereq.
>   * A previous replacement of 'wt->current' with 'path' is removed. This
>     changes an error message, but it is a very rare scenario where this error
>     would be output.

The changes look good to me (modulo Peff's fixup), thanks for working on 
this

Best Wishes

Phillip
