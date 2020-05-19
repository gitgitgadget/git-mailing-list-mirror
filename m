Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21B1C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D7420758
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHc9f0P7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESK5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgESK5R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:57:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9A5C061A0C
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:57:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i5so14263718qkl.12
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7AC52y2ORmbRlqKwPlbYK2mCj0tHkozvuPFB2rq67Vc=;
        b=FHc9f0P7pcCwmL0ppHh5kNpCegAerZ3Vv7y/PGPtB56AM0jBDRk1WyI2Imc7Ht5/zW
         8wRfzAzzP+WB5XxeHDl8tdwljjOUxloaBITS115qy74QlTr8wZ3sH2+NaH3VAP8S1gLq
         QMdJb/rARioWnspPLt4jjcLcAX57ynr0xVTSigPx9x8UQmBsFjUE5/AfaxIRzoGQcXKT
         SNXSHGVGZDAioJ0k+S1U+M8qBkJp97bMHhIpB9B5A3onNhBuVHiy9YdVcSftrpvvaP/e
         iMBmojPOcZM3hEU+wV3PdNX9pV/k0c9Vo5+1EunI5rwnpypFkmEM5XPTdmWEkIgVxw92
         Vqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7AC52y2ORmbRlqKwPlbYK2mCj0tHkozvuPFB2rq67Vc=;
        b=llv+qk1+dSbLl3KesQ/BCH2LPmYjyh8r1PEXiRBFN8VfotCh/gQSHYPDyChC5TTjOU
         2P8LiF1I5nY7ztMS4+4yd8tQ8gA1UoSmoUUsyO2bamh3D0bBkiqXLTPk4clPVSPyLpK7
         GFy3gwJEJAiST1nvMMNIqPKNKJXhI18F3fPWDwgEWX7VhFs4Bqgu45L9gTdGHbcumMwN
         0jIh9cizVhqmvTFPqAJmJU31ig72BfICG5/rTx1KvDVtP1Z9E5ECwC0FtAvQOV7xNOXx
         6HTHuENhFIWUviRAKV1sQvh33IiZJ+yrGtd4stHInhpjxwa1gCWykiaYA6YjQyBEFoXh
         YLBA==
X-Gm-Message-State: AOAM533jPWQ7iFvPWmCUCurnmhTKnxcA9FLJtq3Vn15K9Vxn0iBMcjjG
        2DbIBCs6788sHDHxPvafEc0wkf+q
X-Google-Smtp-Source: ABdhPJwXu/8bl3HIow2zsbWUpO/45oHGXJUi5gai+sm07isTERFEr5Pt1P+a1wyytyqDlC0/Hz5Pvg==
X-Received: by 2002:a37:b602:: with SMTP id g2mr18522552qkf.474.1589885836257;
        Tue, 19 May 2020 03:57:16 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id y23sm12540660qta.37.2020.05.19.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:57:15 -0700 (PDT)
Date:   Tue, 19 May 2020 06:57:13 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Ernst Reissner <rei3ner@arcor.de>
Cc:     git@vger.kernel.org
Subject: Re: bug in git remote --help
Message-ID: <20200519105713.GA602573@generichostname>
References: <2830ee51-ee11-4acc-ca63-3f510e6bcc1d@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2830ee51-ee11-4acc-ca63-3f510e6bcc1d@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ernst,

On Tue, May 19, 2020 at 12:44:38PM +0200, Ernst Reissner wrote:
> I have git 2.26.2.
> 
> git remote --help
> 
> yields
> 
> SYNOPSIS
>        git remote [-v | --verbose]
>        git remote add [-t <branch>] [-m <master>] [-f] [--[no-]tags]
> [--mirror=<fetch|push>] <name> <url>
>        git remote rename <old> <new>
>        git remote remove <name>
>        git remote set-head <name> (-a | --auto | -d | --delete | <branch>)
>        git remote set-branches [--add] <name> <branch>...
>        git remote get-url [--push] [--all] <name>
>        git remote set-url [--push] <name> <newurl> [<oldurl>]
>        git remote set-url --add [--push] <name> <newurl>
>        git remote set-url --delete [--push] <name> <url>
>        git remote [-v | --verbose] show [-n] <name>...

It's buried in there but doesn't seem to be missing ;)

-Denton

>        git remote prune [-n | --dry-run] <name>...
>        git remote [-v | --verbose] update [-p | --prune] [(<group> |
> <remote>)...]
> 
> 
> which does not mention `git remote show <origin>` which actually exists.
> 
> 
> Greetings,
> 
> 
> Ernst
> 
