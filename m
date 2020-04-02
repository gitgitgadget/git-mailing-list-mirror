Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AE7C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 11:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0C020787
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 11:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfUHglnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgDBLaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 07:30:03 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43259 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388001AbgDBLaC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 07:30:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id a5so2842025qtw.10
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oDeG2Ot1bu3KTddxdubDUJeZaCl1YIFpwx7gIKkGmnU=;
        b=PfUHglnMqoBvsKZt/I/aEcaPZBeeS2UsxPeCubSWMxx/1Me12NJeAJ/P1HB5Fqe/lH
         tgbaDAniN/D8wHBIbH3bNuBNrQqYJ0umVQ4unr8dIpKLch9+1ZK4EEYyyBKz+hyKykh7
         uSeiOhbnZ5Dp5OAYsqjuDn4l/HsfkjIFUraVYlvnIId3kQkWoji2JkLuNzex1fyb3QqA
         /NQ2tTUWA8/t1791f/Npm8yPddvyi3btZq2WaU2cFnbsQP8UotgEml9T5yfxfFf3yhXi
         shgaQOgRrMxqTGXI92WhAqCkLt2adO3XbBDJMCYDWcCxnue/NGPtzpTrPMbNi2/DKSN9
         fk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oDeG2Ot1bu3KTddxdubDUJeZaCl1YIFpwx7gIKkGmnU=;
        b=ICQ2LckflMoEeE81TZGLwWAtoHuUNQ5J8U2mNsYZHQPvpNAfgw+E9P5MeH4nWAFzSH
         gb9pgXH3F3LEgblhrIA603BCAMpPhoQVjfCASnq7pTeBmYhJnTt2t7+LuUeVi9f6OZnu
         X/CqwTKjrmqFaDpPD3ZOLI+F7fTKYVrkdmZksxbV143RBLkTSmVf0Q6nLTiQM+W+XlTt
         DTvSVSHSzfva136ZWnmH2+nRi6WAvgmDTUGIokqIS4UZztgHucFMLZkJRe3kiVbAMD+2
         5Kd6vUF/NDt3A9SyBpf1AizNpjsdNWC+5y6VHr3PzKTVbi0E2XKXOCpsG5KyEMNFVk9Q
         YAOQ==
X-Gm-Message-State: AGi0PuaMjgu6U15G3qNSrUmUJNGwPvX7kPWWz2P5JfoAQgBWQ4m58gKu
        qhUIMhcWUddlas8okU9TgjqSHo7IEc4=
X-Google-Smtp-Source: APiQypJXbzJrVWhOOCheF7ksjuWvt3DpYED/hw8Ms5nfqGQpenGMDhMUT4e93gaIdPUqSWBh6o12PQ==
X-Received: by 2002:ac8:7293:: with SMTP id v19mr2422283qto.133.1585827001552;
        Thu, 02 Apr 2020 04:30:01 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id k18sm3230433qkh.46.2020.04.02.04.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 04:30:01 -0700 (PDT)
Subject: Re: [PATCH] clone: document partial clone section
To:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f5787308-a673-7356-6d9e-f226954e1310@gmail.com>
Date:   Thu, 2 Apr 2020 07:29:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 10:02 PM, Teng Long via GitGitGadget wrote:
> From: Dyrone Teng <dyroneteng@gmail.com>
> 
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation during a period. Add
> a relevant section to help users understand what partial clones are
> and how they differ from normal clones.
> 
> The section briefly introduces the applicable scenarios and some
> precautions of partial clone. If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.
Everyone, meet Dyrone! Dyrone volunteered to work on the partial
clone documentation after I reached out on Twitter. We did one
round of internal review before this submission.

Dyrone, do you want to introduce yourself a bit more to the
community?

> From: Dyrone Teng <dyroneteng@gmail.com>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>

And a small thing: we prefer the sign-off to match the author
information at the top. These are at least the same email
address, so that's good.

Thanks,
-Stolee

