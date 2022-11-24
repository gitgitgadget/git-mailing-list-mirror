Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB9FC433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKXKbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 05:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiKXKby (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 05:31:54 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E89C6899
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 02:31:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso4463987wmb.0
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 02:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSvgpQCcJk8qcLBtyBIOoJjB7rAoK85ovlefe0K94PA=;
        b=Jnpglb17qk1eyBC9k9m2PWl6kP2mYO8c1CHA8jiE8CuQQovM9rtJmrpnY8oP1CG8Xb
         wsDD5UZ5punJ40NTdjfIgZN8y7yHN2IaxDiQYQyVVBDranv42005L+BBxGd4b+BKYqWy
         rFTUJ23Sul1mXr8MPohWWqXXDwLfeKWx/wTcxOR87eGJ+cleKv406cX6B4mUnQ1/CQJK
         uFTyqqxblHW6EPccfMroRcg8PGO/7gG4jHmrfor81lfbGG+Z67g7r4mQ+V+tC2n8PXEy
         VBlACRTqes6B5yNpPcYetjKRNkSbqPTKyudg2WWMDVbrqoOZbNEqw2T1FfghjGobQfIo
         iv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSvgpQCcJk8qcLBtyBIOoJjB7rAoK85ovlefe0K94PA=;
        b=xGCo7IjewTeeta554wyn0RKXIkEJM+jixNqPbh1u/CJ8bchnyLhL9OwOqSBHTmRPRE
         Szuj6kQ/LE0rtXYHrZMMnq0lTOos+PW+LFsFmHZ0LOInjmd0h+7x8hOe2TiqYM2IGvpa
         nk5aaYzqfCnThNvQTh8twgiHMT6JsA/iEBg5YQOC1Qd7tyq37arkeR7xm9Idh786L2Zn
         yXq8pTEkmNdtr5vADIjWwb9l4GO1bQISe3lR2QKaq17oluayYf2EjJOs/J0n89+VfYtg
         ktcOSnsu5SgX3kUIOh2sevWbaLn5QYjVvlwuHcjxYeWnlSZLBRfXKKA8ICQp+U17vlzT
         Lw5A==
X-Gm-Message-State: ANoB5plZyv6nq9g4Iwuf8stJI65czU4csXFzvq8DBSneM544RpLlO4C9
        6xealULqLIeNithrsergPnnRzWbKrio=
X-Google-Smtp-Source: AA0mqf6fxlcMEpcyKQGW//q11fA8ciYKfL1MWlHj+D12olpWx94zGcsAvo7uOru6/HD6Mdk+OPe7WQ==
X-Received: by 2002:a05:600c:1d9c:b0:3c6:e369:e856 with SMTP id p28-20020a05600c1d9c00b003c6e369e856mr23068170wms.35.1669285911532;
        Thu, 24 Nov 2022 02:31:51 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id m66-20020a1c2645000000b003cf9bf5208esm5058904wmm.19.2022.11.24.02.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 02:31:50 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <909b0770-2ac2-1a87-498b-0537a94e94ac@dunelm.org.uk>
Date:   Thu, 24 Nov 2022 10:31:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [bug] git log --invert-grep --grep=[sufficiently complicated
 regex] prints nothing
Content-Language: en-US
To:     Zack Weinberg <zack@owlfolio.org>, git@vger.kernel.org
References: <71fcf215-101e-4398-bffa-4ed7e286d9c8@app.fastmail.com>
In-Reply-To: <71fcf215-101e-4398-bffa-4ed7e286d9c8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Zack

On 23/11/2022 20:17, Zack Weinberg wrote:
> I’m attempting to have my blog, which is a static site generated from
> a bunch of Markdown files stored in git, automatically pull the
> the most recent modification date for each page out of the git history.
> The idea is to use ‘git log --follow --pretty=tformat:'%ct' <file>‘ on
> each file and then use the oldest reported timestamp as the creation
> date and the newest reported timestamp as the last modification date.
> 
> But there’s a catch: there are commits I want to ignore in this
> calculation, such as mechanical changes applied to the entire site.
> And this brings me to the bug: --invert-grep doesn’t work correctly
> when the --grep regex is sufficiently complicated.
> 
> Here's the complete set of commits that modified an example file:
> 
> $ git log --follow --pretty=tformat:'%ct %s' \
>    src/posts/uncat/unearthed-arcana-music-division.md
> 1668545053 Begin restoring the site structure.
> 1668545051 Reorganize directory tree prior to setting up Metalsmith
> 1668545032 Mechanically convert Pandoc to standard YAML metadata delimiters.
> 1610735533 Mechanically convert to properly delimited YAML metadata.
> 1417101173 Correct slug for Uncategorized.
> 1417050416 The Great Dead and Moved Link Cleanup of 2014.
> 1416938128 Use category_meta plugin to fix category slugs.
> 1416763607 Initial import of content and Pelican skeleton.
> 
> And here's an application of --grep that prints only the commits I _don't_ want:
> 
> $ git log --follow -E --pretty=tformat:'%ct %s' \
>    --grep='^(Mechanically convert|Begin restoring the site structure|Reorganize directory tree)' \
>   src/posts/uncat/unearthed-arcana-music-division.md
> 1668545053 Begin restoring the site structure.
> 1668545051 Reorganize directory tree prior to setting up Metalsmith
> 1668545032 Mechanically convert Pandoc to standard YAML metadata delimiters.
> 1610735533 Mechanically convert to properly delimited YAML metadata.
> 
> Theoretically, adding --invert-grep to that should make it print the
> commits I do want, but instead it prints nothing at all:

I think the problem is that you are excluding the commit that renames 
the file and that stops --follow from following the rename. See below 
for a simple reproduction using git's test suite. I'm afraid I'm not 
familiar with the --follow code so I've no idea how to fix this.

Best Wishes

Phillip

---- >8 ----
#!/bin/sh

test_description='Demonstrate `git log --follow --grep` failure'

. ./test-lib.sh

test_expect_failure '--grep breaks --follow' '
	test_commit first file-a "$(seq 1 100)" &&
	git rm file-a &&
	test_commit second file-b "$(seq 2 101)" &&
	test_commit third file-b "$(seq 3 102)" &&
	git log --follow --grep "^first" file-b >actual &&
	git log first >expect &&
	test_cmp expect actual
'

test_expect_success '--grep breaks --follow' '
	git log --follow -E --grep "^(first|second)" file-b >actual &&
	git log second >expect &&
	test_cmp expect actual
'

test_done
