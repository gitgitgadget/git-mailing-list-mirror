Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB32EC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9195C207C4
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2eZi1PD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgEROqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgEROqH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:46:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23506C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:46:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s1so10289889qkf.9
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=B5mot1ayUfVTF8v4Q9l6gTUxh3WwrhtcsfApGBT2Qo0=;
        b=k2eZi1PDqJ/JAgRhc0sECocqjVwL/n3jyDZbRDDr0jBrBoyXTVcIBSZ4O3bE6CwKeq
         pDx9H6wPNqRg3V86dDQaK9BirvimatT82xy8HKRSmotM1g1QWMGfKdXsqiGKWLCE+gKt
         yq/vyZ0FoRH/XQiWJDe/OPOllxprjHatbEqX8o/nOGqRdyQXlKRB1XWKE5OsvLRpDVVD
         94bNoHbSM8LJ6cqwKxU35T0ITTpbm4e/Lf2q3iNkSGIQsF4+9wYz5otPXswMf7VPtPbz
         VHJ8a7syJ1qPyb+CC+ZfZj1E7W/pm6AcKKH5hRjkgB8FWm2mv1ycwnFpfE+F29sfR03u
         o4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B5mot1ayUfVTF8v4Q9l6gTUxh3WwrhtcsfApGBT2Qo0=;
        b=E5EOKicWly79N+miqMi3zToHkY6zm2GhOHN/n+/dmbmPTlcvMIgCFgRHL8PNBw7Moj
         BDEXxuXYCdVpZb1aEpHx1gIVmE1mBTG2Kv4d403nJ+5YEBEyuyT0yPlBH3VbGfSMpTfa
         AHnDv18ds2s1oX0aBpFrszmr+BuLFFQ4vIP1trlx+r/Sk2yngPvDWjsAPKDFBDbfhI3Q
         QNXUjVLuFlpDE3J9maKO+MXy8a0uQXtZYWnip/w2cxBUMU0gU0SM2cy1FoQ32cmVIr5J
         PVgcqf+GD5/PFVRM+EHvTsTHx0FQqRyhnyIB/DmiEhKb3fH5c9TcVbkV9rafTRlVDz+r
         TAkQ==
X-Gm-Message-State: AOAM532kxvSRgheTCrD70yc+x5zONPtRcOs6GvTZX5iKed+ue+fPTRnm
        ejtvZlwIWefwUEoNa/Vs+/gWv1fwtXo=
X-Google-Smtp-Source: ABdhPJw58/Wh1OgGzjTTtltALH19xzBcSSsupep9WJC+N1KK1TfK1DxdHs53cArE+fgGFkJe4yebxA==
X-Received: by 2002:a05:620a:11a8:: with SMTP id c8mr2329883qkk.365.1589813166146;
        Mon, 18 May 2020 07:46:06 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n68sm6943088qkb.58.2020.05.18.07.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 07:46:05 -0700 (PDT)
Subject: Re: [PATCH 3/7] git-commit-graph.txt: fix grammo
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover.1589739920.git.martin.agren@gmail.com>
 <af1e7c7d7d123d1187a7ef62cbf11fc41ce2fdc7.1589739920.git.martin.agren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f2e465e4-4671-6bcb-144e-5b9ccb95e419@gmail.com>
Date:   Mon, 18 May 2020 10:46:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <af1e7c7d7d123d1187a7ef62cbf11fc41ce2fdc7.1589739920.git.martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2020 2:52 PM, Martin Ågren wrote:
> It's easy to mix up the possessive "its" and "it's" ("it is"). Correct
> an instance of this.

Good catch. Thanks!

-Stolee
