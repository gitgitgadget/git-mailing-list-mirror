Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1752C47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 15:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF93613BC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 15:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhE0Pld (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhE0Plc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 11:41:32 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FADC061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 08:39:58 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w127so1139389oig.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=i7upClFIWTV930Y8aPKn5Os4IVhzR3lZ7pAI3GcMSow=;
        b=UIHBog/BJnx1PvFulyJtJ+KZpCI+Brw7BMfHzZAdl1IExc7L+jjkAAA5dmL4oViZnZ
         eO+sS2c6/BHSQCCPB7t+yUNOjdaSZIsZZwv03mcdgBYt4fYa+u0k5s8tUSAGTUurEpME
         x0Lor2uQ+RWqCT1s1ORjWbJmvEPDHi4PLdKVToSTviPf1aOb3kz93E/5ai1reeU2JoaD
         KJV2VmoK7H0YAvEPlsghu2AXdYxRhaepVE36CIvtSan3f0NxO33/AHzfpx4Yz88KcEK/
         9B0FrQKT4I/I5lUCPnc3PR1fXGcT8JcYAo5ImZFJQG125MjYhfhJoCbNTTI6JzndqoQg
         TYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=i7upClFIWTV930Y8aPKn5Os4IVhzR3lZ7pAI3GcMSow=;
        b=UFoO/x0Iy9B0YJwmCWuMwPKBKnPREg4/z2bijgIrdqZy5iL9xFr3DWXVxK4ZGo990X
         NiSKvG7QJQiMfZHgSO6Q0l9p/DzoCjaaiOwhxz3y4uVTzq/8lzNYhgQqhwE6iwNc4IP5
         j9bCXxaHWTKm7LNPLftSYon9a+ZA/G6buaKuPTaYYjY3K1AH3+ingCnCiaFihRF5bMU0
         FEwgpK/y6FybtZy9De/XFCdHnBSOoHWPbH0ZEHbkwGCsKtMdR+nCpKxK23WAzWmT2Cbp
         qLbRDe3cBiLqpvy2esJgNO4WXaN+Puwhv8pPSY7md4wfu822kYYqQ84ji+zHxtTCOV0z
         oUdA==
X-Gm-Message-State: AOAM530bCB6Gf2banJM4Nd8E9oAlgCpOocWhMBeGFFaC0dJUQ4823xiW
        3xSCkUwoZ8uv/5C5zZpE220=
X-Google-Smtp-Source: ABdhPJxln4GUC9zkHX30Vo1MPgPpQ7aLOVtNLrQffZPJpxK4H7yAO+4VBAx6HIQtE4dP5CsCG+O+MQ==
X-Received: by 2002:a05:6808:a8f:: with SMTP id q15mr5899759oij.35.1622129997408;
        Thu, 27 May 2021 08:39:57 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e22sm520488otl.74.2021.05.27.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:39:56 -0700 (PDT)
Date:   Thu, 27 May 2021 10:39:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Message-ID: <60afbd4b81e44_265302086d@natae.notmuch>
In-Reply-To: <pull.963.git.1622126603.gitgitgadget@gmail.com>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
Subject: RE: [PATCH 0/2] [GSOC] ref-filter: add %(raw) atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu via GitGitGadget wrote:
> In order to make git cat-file --batch use ref-filter logic, I add %(raw)
> atom to ref-filter.
> 
> Change from last version:
> 
>  1. In my discussion with Junio, I came to the conclusion that
>     --format="%(raw)" should not be used with --python, --perl, --shell,
>     --tcl. Therefore, die if both --format="%(raw)" and
> 
> --language are given in parse_ref_filter_atom(). The reason I don't move
> this part to raw_atom_parser() is if I move it to raw_atom_parser(), when we
> use:
> 
> git --format=%raw --sort=raw --python`

Missing the command I presume (and the other backtick).

-- 
Felipe Contreras
