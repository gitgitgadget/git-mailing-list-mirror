Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53099C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036292076E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCfpfkE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbgJLLWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbgJLLWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 07:22:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00987C0613CE
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 04:22:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so8384828pll.11
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 04:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g96E7+dHtrxzCt437OyILKaBgot0Vp2fsl689lXWPlA=;
        b=GCfpfkE/7EQNe/gKq5KaIcB2QFictPSFTBmEsqhQbBB+1n8OkXXQF3PTn1bPhMKx4T
         cTF+LSMVUnkSFIQEP0FSIXfOjsYBSu7cfcaMmcFE+93aASn38WGtvK/t8+TGqxnk/8vf
         MOnCjmoRI+UsOemmJhG69VRbtxCG88m5WOCide/ELw4RBwnH9HiQjp2j37CfcwSQDApR
         pe/vHXxrSb3h24uBlpXjg+AzbQtXtu+A4oftHWFSSnnyqRwsJi15VT+UsV/X9R9nMx43
         MMm81NGX4zijE6eVzWiUWRCFHga1KhCXEPNh8/LATavEP8v/XId4PqfbWQ3oGhbRqRhF
         kOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g96E7+dHtrxzCt437OyILKaBgot0Vp2fsl689lXWPlA=;
        b=cMZVCZtvHMTS0UTSkXlLeUn8jFQxl/Rs0hyDADJyuUTh0Gfek+t7CC6bFIHHFiJnRI
         E/bYGEMuSswet0BJhf0Nsdht4PGvbZ+CckkWHq27KYZTPL8Xzc1N1VIsOtcndnqsmJo1
         fjbfiutm7dd+kVVXLgGo7Qph7Rgb8DFEOW5yH5+mEwZ8wKc+EFw7XTP/3DvIjma4Aynu
         MoygkPjTUh9ugvneWMyGv+PKqjOxj+dPnzlejnp5srUpRKO/6bxhJ/avoZDqNPyftQ08
         VYlJaM01WaEsxT1L0tGPIzAvRLQigb97FnsdSrimxlH5Nqp3Ii097WWw6D3lKQJrDGFm
         jn1g==
X-Gm-Message-State: AOAM533Jk3ZfEbsC1bPyqQdC3YxiHwv/jlS2kvBQ2TUcqqSI9GH1oZSU
        zelQjEnzs0IeQyn32TEEwqY=
X-Google-Smtp-Source: ABdhPJwPzvz9F25WQMJ3wtc8ijvdniOG2BTpDSk5+Eh3roC1QgDW0SKMtSju5Iw4gvEeefBZQQ0QZA==
X-Received: by 2002:a17:902:d34a:b029:d3:dcb5:a84c with SMTP id l10-20020a170902d34ab02900d3dcb5a84cmr22612124plk.81.1602501738476;
        Mon, 12 Oct 2020 04:22:18 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.85.234])
        by smtp.gmail.com with ESMTPSA id x16sm19745935pff.14.2020.10.12.04.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 04:22:18 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Sangeeta NB <sangunb09@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com>
 <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com>
 <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
Message-ID: <943d84e6-98fb-29e3-086a-3763c9e73ef8@gmail.com>
Date:   Mon, 12 Oct 2020 16:52:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta,

On 11/10/20 5:00 pm, Sangeeta NB wrote:
> 
>> As I understand it if a submodule contains any untracked files (i.e. a
>> file that has not been added with `git add` and is not ignored by any
>> .gitignore or .git/info/exclude entries) then running `git diff` in the
>> superproject will report that the submodule is dirty - there will be a
>> line something like "+Subproject commit abcdef-dirty". However if we run
>> `git describe --dirty` in the submodule directory then it will not
>> append "-dirty" to it's output unless there are changes to tracked files.
> 
> On running `git diff HEAD --ignore-submodules=untracked` the submodule
> wasn't reported as dirty.
>

Right.

> I guess this is what we are expecting. So should I make it the default
> behavior for diff?
> 

Yeah. Changing the default behaviour of 'diff' looks like one of the
options that Junio mentions in [1].

> A fix for making this as the default behaviour can be:
> 
> --- a/diff.c
> +++ b/diff.c
> @@ -422,6 +422,7 @@ int git_diff_ui_config(const char *var, const char
> *value, void *cb)
>          if (git_color_config(var, value, cb) < 0)
>                  return -1;
> 
> +       handle_ignore_submodules_arg(&default_diff_options, "untracked");
>          return git_diff_basic_config(var, value, cb);
>   }
> 

I'm not sure about whether 'git_diff_ui_config' is the right
place to do this, though. I'm also not sure about what the right
approach would be, off-hand. But I believe the Junio's e-mail I
reference might be of help in pointing you in the right direction, in
general.

> But this would also involve a lot of changes in the way tests are
> written as 12 out of 19 tests in t4027-diff-submodule.sh failed after
> adding this patch. I am working on any other workaround for this. Let
> me know whether I am on right path or not. Also any pointers on how to
> proceed would be helpful. Thanks!
> 

Some test failures are likely to happens as a consequence of the change
given that we would be changing default behaviour. So, adjusting the
tests appropriately would indeed be necessary. We would've to be careful
in evaluating the failures so that we don't break other _valid_ use
cases as a side-effect.

[ References ]

[1]: https://lore.kernel.org/git/xmqq1rixi4cb.fsf@gitster.c.googlers.com/

--
Sivaraam
