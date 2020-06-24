Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A297C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9922078A
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzTM1Pib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404301AbgFXPYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXPYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:24:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD8C061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 08:24:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so2164465qko.7
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MKBZzpyLThXrXwqtcrTYWyXa9pE8ZNGOlR9CEqhMoas=;
        b=uzTM1PibmK+E+PGYdULpqL1htHO7Ymh+IxsIYdX+V0mlyVpCalTqx+pHApQyA2G4vU
         iLdI5bnqf5738xOVWmhzodkLpn0oQCvBLbXUIR/XfBlNwiN6aFiYs11/spjuM5oE99+u
         eh4ypwHoqCrSMRvgKonwd6+LhRuQi7E2ZSrNIHey6Pn1hn9qy1bNGhqxj2zzWZwHxEx7
         7uREhhh9WuakDmApc7bg1t7mqgt5NjDbZv7I5FLn8X64/brrzJCjP02WyYOdwUAgOQix
         MF6FOvEBfgjg8cncDEUeRlJLTWR4UnzbBowkIPMwtQZzkzke3gPhEVwsiP5IQ6DrsNb0
         eRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MKBZzpyLThXrXwqtcrTYWyXa9pE8ZNGOlR9CEqhMoas=;
        b=b43dkpLTvvSCMcDFI0LJISHoa4Zpz5YBVrBmOx4BmJo/6C0Tt/2j2404L8qIszWgDX
         yH3eHl4gS7/dYjOUJINxUTVHlAop+AmoVpGMFuT8Sv+d9omm/kArxp+B7KO0DWROUl0o
         PiIhwLLv0BtTbloy9pBXvqsaZ0dqUDX3DQDzTVrruvXKcJzrOGe7gZuikkuaPyLvJzpb
         aSZItBvTJ0wMp9EYiDfSQK7ZXDjNKobZD3N4dBcJSrPk+ScgqUhTbTDd7u4DdBm69MOk
         gcqAPGbG39W2qfoZJPjyVhGsuW4y3KiSiUkmQ/bARDoPdbJKAj6s0kTH7juLkFYwOaZ4
         ujdg==
X-Gm-Message-State: AOAM532FoDlP2wQ9XJGPBD/65V0lqjumdwQd8GQaEsWR6aN79wCICT/n
        eqTfdH5DlzOmePLoxR35iUbSNdLJDps=
X-Google-Smtp-Source: ABdhPJzC4fvUPfY+5Wo+IxEmzrk/jjOwDhc97P7KdzI43rG3if6WX9tOcxUVVmThbcCR1SAlSEoWEA==
X-Received: by 2002:a37:796:: with SMTP id 144mr9696831qkh.84.1593012252661;
        Wed, 24 Jun 2020 08:24:12 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id r5sm4137638qtc.20.2020.06.24.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:24:12 -0700 (PDT)
Date:   Wed, 24 Jun 2020 11:24:09 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Accommodate for pu having been renamed to seen
Message-ID: <20200624152409.GA143253@generichostname>
References: <pull.668.git.1592924655.gitgitgadget@gmail.com>
 <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.668.v2.git.1593010120.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Jun 24, 2020 at 02:48:37PM +0000, Johannes Schindelin via GitGitGadget wrote:
> Changes since v1:
> 
>  * Rebased onto master (no conflicts, so it is safe, and it is more robust
>    than basing the patches on seen which already contains v1 of these
>    patches).

Out of curiosity, why would we ever want to base any patches on `seen`?
I understand there are some very rare edge-cases where it might be
appropriate to base patches on `next` (where the series based on
many, many other topics) but I'm not sure if I know of any situations
where it'd make sense to base topics on `seen`.

Thanks,

Denton
