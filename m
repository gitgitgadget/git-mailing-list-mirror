Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8267C4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C8320724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 14:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXtT/HXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCVOjV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 10:39:21 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44331 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgCVOjV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 10:39:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id w4so11611901lji.11
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rXtT/HXUaCJtn9G4tGi/htgkeZFJVwcOIBQImGoBFAwEQzzUQ8wRK+aBoXd4OUo9L3
         HunlXEcnP9U+CmPmg/kE2/ghq3U+IQvLEBxJARs6yJBfJnkpHifPHveWu0upHXTcZzXY
         r6FeIVeB0SuAalMTCOrwpeYGZrbJvPDjlUcRQSkn0DYc1LEvmTf/4ZpPcRji5AaYYhyG
         V4nkhlS7pMjXPS0V/lR6/Pnpt1vTUjMczte4hyHfZIRpsO/rZ15J5v2tysEtkVfIzGbS
         oBvaVU1affOzTPrRdc87elv1zhfJlx4lDZce4K3l7572XS+wmxgu+LHfJPFwAr+sqDGv
         kWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=rMJ/HhRLUbIi8nALjALNvWZ0jXukjdIdmH5Ar0AyBrHS9OxkK9HelAqHjASva+TMcG
         35nPV7lwlOoxAbacOFZeTBi9I2tqkAC2rZ+wJJoXWVkdbmOJYeX2OeCmtqDVujCbx+pg
         peDRqkpKPjN9yuK9EF5aHZrq/5oWo9aVgt4BkqI1lvYzqhlc1dDyzxIZuBbFhKwTEY2f
         lptHOR+TLUkEVi2GZbNTx0Ae9K/ljzM/woPMt0jv18SJlN/jYQO0vvwROLAsb7Uez38c
         sMYg18Hw/UkDbi+2xVYEkvaxpcsNZjzcwsawrrDqx2gfojy/s7UKXl/xy4xRWXsdZ67c
         a0nA==
X-Gm-Message-State: ANhLgQ3U8tB7tyWEnqJfxF54W1ODwGBxu+iZhDPDGBvRY6bESFTwhY4I
        N6j0dM3bC0ucpS3buXChQdU=
X-Google-Smtp-Source: ADFU+vuIlvlQMTdsghJRZLIq9Qgcl8LAW8KCN2KonsnmHwe1yag8c07hMISLFgLj3R1AeP8uMUo0CA==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr11251143ljg.144.1584887960083;
        Sun, 22 Mar 2020 07:39:20 -0700 (PDT)
Received: from mehroz-HP-EliteBook-8470p.Home ([119.155.6.126])
        by smtp.gmail.com with ESMTPSA id y20sm7103840ljd.35.2020.03.22.07.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 07:39:19 -0700 (PDT)
From:   sheikh hamza <sheikhhamza012@gmail.com>
To:     sheikhhamza012@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] bisect: remove root directory restriction for git bisect
Date:   Sun, 22 Mar 2020 19:39:11 +0500
Message-Id: <1584887951-22737-1-git-send-email-sheikhhamza012@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20200322104826.GB2224@szeder.dev>
References: <20200322104826.GB2224@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

