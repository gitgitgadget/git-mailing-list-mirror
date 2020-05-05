Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECDCC47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 19:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25CC2068E
	for <git@archiver.kernel.org>; Tue,  5 May 2020 19:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJJ350dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgEETm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 15:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEETm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 15:42:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69DC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 12:42:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so3575280wmc.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKU6u0PDGBZ9JYP3ud9V7DMSQhiU1EuzOhmJTLuCvhA=;
        b=FJJ350dyEeMs1XLhSaviyjRnDFHqpXyMEaxrDOwrXKqoako1AdsojRUiyL43dCtW9t
         Kh65m0TSKhAY3NOmadf0SxEsBSAutREscSPa2cp5eLPm223YNMlsucSr+bnl+ADdOaSz
         d343MiVg95laYJnOlEg3BuehQYaak3xrOkq+Zx8wQzpRQDJPWGWdRRQQCNPXD+cP7wD6
         Jo/TDeQv2OX6z8B3iKjoWaVc6PjqVQBJ10ITWbwBUP6ev7+Gbg0UAVQmo5cMbUFCEZEE
         88vzkmQNm+NatQFoVDZAr/nO7+1Y5sRGExtrFV3qlLGAKv4L/b0gZD2cAoLfyCFHu5ql
         ER9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKU6u0PDGBZ9JYP3ud9V7DMSQhiU1EuzOhmJTLuCvhA=;
        b=IostE8PRAfqfKXJTNtHy63aE9UeL+ZnW7i7ZtmSQDw4G+u+pWTR6ygXrWdbbIMlbDE
         +8N5RqfaxG3SvjhOHvXUK2hPNYg9tLAqjLd+w7TqaQ8J2BnBrB60kClIntW0tMRSEQfn
         lS9JOCDptThh3xS++HeZha4erl2bSJDXuk11C1ith+ZbZQPvzDztDTwiQThF+m0vp4xk
         9cc8I3vDYLn3Q7tJovse07btLgEek++4YltdE9O7EB4m/z7hO7E6neoXvF4f9X4sMOtr
         SJy3EIIf37vC1N5U+Bg2s1jE3L+3ZdFUL0uM0uBNkD9teOsquJuM5jONMyQ0Zf2zYzJO
         t40A==
X-Gm-Message-State: AGi0PuajbiJFrBD3RtKTV/3wNlGn7b804SlC3jYE2dBzncPbnnW6jwBM
        T+BWQVStbrH5sl8D7n9Mi30dlhFv
X-Google-Smtp-Source: APiQypKrAfaqtsrkSjUjxM6oAs04BdXHrr0DmRRgLUB1NjGV3fG2xNrrB2N8VMp5u7EcuWU3tQpzhg==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr220471wmj.170.1588707775539;
        Tue, 05 May 2020 12:42:55 -0700 (PDT)
Received: from [192.168.1.240] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id z22sm5293333wma.20.2020.05.05.12.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 12:42:55 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: RFE: teach gitk to automatically mark
 .git/rebase-merge/stopped-sha
To:     Mikko Rantalainen <mikko.rantalainen@peda.net>, git@vger.kernel.org
References: <1dbc41e9-b2e5-0b77-26c4-c912c82f9069@peda.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <79d0c40d-3bfb-2902-3538-1eb1a6cd68fe@gmail.com>
Date:   Tue, 5 May 2020 20:42:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1dbc41e9-b2e5-0b77-26c4-c912c82f9069@peda.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mikko

On 04/05/2020 09:26, Mikko Rantalainen wrote:
> While doing long rebases (I'm currently rebasing a feature branch with
> 166 patches) and rebase stopping in the middle of rebase, locating the
> old patch in gitk is sometimes hard.
> 
> Could gitk automatically mark the original patch that failed to rebase
> after I press F5?
> 
> The failing original commit SHA-1 can be found in file
> .git/rebase-merge/stopped-sha but as far as I know, git does have
> logical commit name similar to HEAD, ORIG_HEAD or anything else for this
> case so there's no easy way to get already running gitk to mark this patch.

Since git v2.17 rebase which should set REBASE_HEAD to point to the 
failing commit.

Best Wishes

Phillip

> Of course, doing the same thing for failed cherry-picks would be nice,
> too but in that case it's pretty clear where the source patch is.
> 
> As a workaround I currently have to do something like
>    git tag -f FAILED_HEAD $(cat .git/rebase-merge/stopped-sha)
> after seeing rebase failure. Then I can hit F5 in gitk to easily locate
> the source commit.
> 
> PS. Is there a way to automatically run git tag -f FAILED_HEAD $(cat
> .git/rebase-merge/stopped-sha) if rebase fails in the middle of branch?
> 
