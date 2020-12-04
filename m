Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43793C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C47224BE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgLDCrx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgLDCrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 21:47:52 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B264CC061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 18:47:12 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o7so2314446pjj.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 18:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sl7KMeDI9twS5KSEie/hTya3nD/pCZPpwVBgu8gOddk=;
        b=fYAM9Cxm1zicAdXXbpwYzlWCt4xtzFR7B0v03wiCJUzdyB6Uo1SW2SoLmypMfJqWY/
         25wLbcTZZZzguivoDLylDuLYVYaQPh3CuZw/TQetIdP6u3HP1+ZZCMp7XtZCNBvLHzxo
         IqZqwZkDvh5c/s44HbAuRLTsdVi4RmWYfv5nVl94IhaPLuZcnCiOvuDDa/f7Y7zB3unP
         aPYM1bXcbFD0jsy1SdsbnTs/+Vcy80AHfWQyPZUJy7kXlcS0IZYapLwbTiTn01okim66
         XxLwO55dJQe2A44NL5j1gyMwCojqS+5SPFgXJzrB3+Ej9VCtc1KmubOmQFwuy0gPhhiO
         ANAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sl7KMeDI9twS5KSEie/hTya3nD/pCZPpwVBgu8gOddk=;
        b=OGYK8TxZnCO2uVglbmCx59IiFKS0K/opwsYuv7qF+P2DGDLfgZCU+aqtgHA2YFAxGo
         SBk39RspbQj8WDpelDL8XPOs8Zt/y/uLUxJGZBTRlr4/h5ANQr3/ejYg8gW9LsMXsjV4
         OK73iyGSmhGdqm1R+lPuMVmVlg+Oyeir0UGBMgYak9GhYhG4pvST0G/Osqu7hBRW+qnd
         suoLD/aESaamJ4r4gl/tMgiLggH4IPTBEifk6hKvYLPy0Q2pK3g37fcXsOB/45XgZwsR
         oUrDVbBWn4jROeeScoUMT9Q2DgQbTi+tRIyWgEyDBkFmNc5fyMEjNmr/nxjDPoqJ8ews
         vQOQ==
X-Gm-Message-State: AOAM532G9qLUeYPwVtLkNS4iF1LKfIoBXee5UE+PyrYI6NVmM/PYJyQT
        oUYdfLm/aTRweEpPgCkqvOoWLZ+nRCE=
X-Google-Smtp-Source: ABdhPJzRHrHygndmhjsuGkuQ/Cg+6+wMID586AqYAXyFT1eRQ69uXE+DuHKGrRq9IKLxAiQ4PBP0og==
X-Received: by 2002:a17:902:b28a:b029:da:725c:14db with SMTP id u10-20020a170902b28ab02900da725c14dbmr1931574plr.72.1607050031626;
        Thu, 03 Dec 2020 18:47:11 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id m5sm562882pjl.19.2020.12.03.18.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 18:47:10 -0800 (PST)
Date:   Thu, 3 Dec 2020 18:47:08 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "wireshark-dev@wireshark.org" <wireshark-dev@wireshark.org>
Subject: Re: [Outreachy] Internship blog 2020
Message-ID: <X8mjLHvNCYimATw7@google.com>
References: <I55UpoMB_QMpFuqJEp1cHW7oN8AJy-b5iveBe2kZLslum_LOctwR5IdXUJhzZETg7bZDtm4beN38Nz6kvpJKDf0luxBMFxfpoFCYWkwaae4=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <I55UpoMB_QMpFuqJEp1cHW7oN8AJy-b5iveBe2kZLslum_LOctwR5IdXUJhzZETg7bZDtm4beN38Nz6kvpJKDf0luxBMFxfpoFCYWkwaae4=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joey,

Joey Salazar wrote:

> Very happy to be joining for this winter's internship! A short blog
> entry on the beginning of this journey here: https://jsal.home.blog/
>
> A new entry every 2 weeks, check it out!
>
> Thank you Outreachy, Git, and Wireshark for the opportunity, happy
> to be working together!

Welcome!  I'm looking forward to working together (starting with an
initial wireshark patch to get the lay of the land, then fleshing out
the plan for the project, then executing on it in earnest).

A question for wireshark developers: are there preferences for what a
high quality dissector looks like?  [1] talks about portability and
robustness but doesn't address other aspects of convention such as how
long functions should be (like [2] does).  Is there a rule of thumb
like "when in doubt, do things the way <such-and-such dissector>
does?"

Excited,
Jonathan

[1] https://gitlab.com/wireshark/wireshark/-/raw/master/doc/README.developer
[2] https://www.kernel.org/doc/html/v5.9/process/coding-style.html
