Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E1CC433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 14:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CCF20729
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 14:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxoW2AHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgGVOWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgGVOWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 10:22:53 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB262C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 07:22:52 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 9so2097223wmj.5
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cX/BYa+lUo1Qz1itvL1wo5xqNCW3uMe4WkVKh8Sfj3s=;
        b=sxoW2AHBx07lECCN7ugolTalVMAkLh+hT3HFjUNTLclLTfaNRhYdp8zfR3jzvnA2kt
         27/dHOIi2Zn+7tVPuhhuY2WpOvDUyQJKMO89U7rAIims8LjFD4Mg4TqggW6XzxgHkpvK
         1OtqlxnxAohStXB4zrogbfVc/WtkaMp2u9QL156iFj9yuOq+NxKtEK2UFqME23+KOuMT
         WFQH5DObVXEBwq1WQoRkzLqP4PTKEXE+SIWC+lBiSX1/jp798S7JhMZ1RadiDmdghFcm
         yAVxyCglCJr7MbjHel4MTGaFAlo1QMtmpGtNUEYetVgaEyGo0blY+8T28cUukFhnGzOX
         1C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cX/BYa+lUo1Qz1itvL1wo5xqNCW3uMe4WkVKh8Sfj3s=;
        b=IlGC/5EFox7ASPwOn1AVbtbBfDdg9hxcBCHUNsbNbXXfUMnibhrL6itSwoLgldlwDc
         Q9IAXvOdki8GXoWXc8xYvUKoHZAPkf0o0VkxaPrWLPDgQapILiW1+hoyDSkvCl4nw4/W
         E9eIMvF/Y7xJVZELUBTZtHOljmtdbDLb5nH5Ca5ftB6zRX85hNqMSuJElm0nuU5kBLXn
         6IEUvFbPbz42dByp0ExQbEd1L+5dxpAyDOBbczQ4wQO/lVCVTKtgZ/rz52H6060R3DJj
         ivFRPlO5a6fgOc1r6t/XtpFLDFgmzVgnkYhwr6Fzh4PNso9cnH5rlsJwrMYviMeIn95V
         x0yQ==
X-Gm-Message-State: AOAM530AGQjY46S4+1RbVn1i3G8DAsH12E4DDBDqbB/HyflfEFyg0GrM
        xdB+fXVAD8uLjMkvyXZDONAN0mn2
X-Google-Smtp-Source: ABdhPJz1O81zb10KkM46PkBrS+75PAzPN0uLdxJ/B11XxpLmckQCH0ojc/EANF0Rjp69kbpfFsFd8g==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr288849wmj.58.1595427770769;
        Wed, 22 Jul 2020 07:22:50 -0700 (PDT)
Received: from [192.168.1.240] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.gmail.com with ESMTPSA id u1sm103759wrb.78.2020.07.22.07.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 07:22:50 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Possible issue with rebase's --rebase-merges option
To:     Joel Marshall <joelmdev@gmail.com>, git@vger.kernel.org
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com>
Date:   Wed, 22 Jul 2020 15:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joel

On 21/07/2020 22:20, Joel Marshall wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> This is a difficult one to give proper steps to reproduce. The issue
> is with rebase's --rebase-merges flag. We recently switched from using
> rebase with the --preserve-merges option to --rebase-merges. Most of
> the time the output is the same, but sometimes it is very different.
> I'm unable to determine whether this is by design or a bug.

--preserve-merges is buggy if you rearrange the commits (this is way 
--rebase-merges was added), if you're just rebasing without reordering 
anything then I think the result should be the same though there may be 
some corner cases I'm not aware of. Are you able to share the topology 
before rebasing and after with --preserve-merges and --rebase-merges?

> What did you expect to happen? (Expected behavior)
> Resulting graph after running rebase --rebase-merges is the same as
> running rebase --preserve-merges.
> 
> What happened instead? (Actual behavior)
> Using --rebase merges tries to pick substantially more commits and
> results in merge commits with no parent commit when viewing log in
> reverse chronological order.
> 
> What's different between what you expected and what actually happened?
> When the issue does occur (it doesn't for all rebases) it results in
> two completely different logs and picks commits that are apparently
> not part of the branch being rebased. eg, for a branch with 128
> commits including merges, --preserve-merges picks 128 commits and the
> resulting topology matches the original branch's topology.
> --rebase-merges picked 183(?) commits in v2.24 and 202 commits in
> v2.27, and in both cases resulted in a very strange topology.

That's interesting there were some changes to how empty commits and 
upstreamed commits are handled between v2.24 and v2.17, without seeing 
the staring point and the results it's hard to tell what is going on though.

Without seeing some examples it's hard to tell if there is a bug here or 
not though it does sound a bit suspicious.

> Anything else you want to add:
> Feel free to contact me at joel@tusksoft.com for additional details.

You email me directly if there are things you don't want to share on the 
list

Best wishes

Phillip

> I
> would love to understand if this is by design or a legitimate bug.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.27.0.windows.1
> cpu: x86_64
> built from commit: 907ab1011dce9112700498e034b974ba60f8b407
> sizeof-long: 4
> sizeof-size_t: 8
> uname: Windows 10.0 18363
> compiler info: gnuc: 10.1
> libc info: no libc information available
> 
> 
> [Enabled Hooks]
> 
