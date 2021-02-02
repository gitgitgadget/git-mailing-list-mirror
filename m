Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914FBC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AED564D90
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 06:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhBBGDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 01:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhBBGB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 01:01:58 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6CC061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 22:01:18 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id g7so16935584iln.2
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 22:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vjaw/b2Mkml2YfhnnyogutBy5N0/yg0/6eHT3dUfTEA=;
        b=QrS0Xtl3RjbaYxQdOx7nLBgDagCN8QQH8Y7l2i37dHmO4u0RZoKeZKmFMfCUVUWUCH
         lP2C/nycmHALLgdPEIeSbLvIThF2uIhI2WJBFJUPLf/dBNLdg2znA0WXopItqqTiTz79
         pi0WyVuAejbk7QQRHRzCOkM2KW4mm/2lASqbLgSpZM8XlyWcmsQ34UkTO6xJ6Jgl5Dgk
         5N7RbKl+jHeiI60RKOAgRzWjXNEeKkoV+YIpzCYNaXjH2W8jWqo1ONe3uwvI4EJr8Egl
         GQ58gi3ObZyU1uXd3kloNWUVpHcic2vQ1b6uQhwcZcgnmRZO6hkkFE06wN0EmDZCIFMS
         uJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vjaw/b2Mkml2YfhnnyogutBy5N0/yg0/6eHT3dUfTEA=;
        b=FASpRSVIrUWayXeZbMTjAPPFIz8ifHYck8cK8nr51nyEluVO4E/8pu8zvKnjGKiiq2
         7D5pFpF7ROCf6z/SI/T/s9KMR5pp3i/4GlYTrV7olsbzSaCp25LnXSRWLNg5HThQyM9D
         J32+IvLDRs/cgTl89X+otp1iKdArQbPLUxvGK7wh+uw+7QdGQhq5TdITjXVAsWpge1N7
         28bgXaehdwmwCDi7s547vH9rN5YW2vVooTAWSKL9CRgpn493pdSSffpnzTrNrptsEPwR
         vqGfnNthr/R3h4OEuWKGJP28BJB3rQ1uo5KfonYyEzY0pumWYijftSzGFtk6N/ymJRK9
         pPJA==
X-Gm-Message-State: AOAM531BYOR9IN3/G2bOWThD+2o8Kjk9iYfZeB8W5yoITMTQhEbyoQBl
        eb0TOaXFmEGc+rvT74NoovTY3G9r7bzkq3a7AT2aSdlO7zlXAA==
X-Google-Smtp-Source: ABdhPJzYGg52sLSJUte8zc+fAVAh+G2tz3RLfQSaX2a686NZLyE0/jDWNX3Tg0pxfo2TMaKAvFNzigFqb4ZRadNYe3c=
X-Received: by 2002:a92:650b:: with SMTP id z11mr16096039ilb.84.1612245677603;
 Mon, 01 Feb 2021 22:01:17 -0800 (PST)
MIME-Version: 1.0
From:   Paul Jolly <paul@myitcv.io>
Date:   Tue, 2 Feb 2021 06:01:07 +0000
Message-ID: <CACoUkn6+9C3+HVVQF905t1siAD9Sqo1JvRa0Whw-J6x7V7icyg@mail.gmail.com>
Subject: Bash completion suggests tags for git branch -D
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Easiest explained via a repro:

    cd $(mktemp -d)
    git init
    touch README
    git add -A
    git commit -am 'Initial commit'
    git checkout -b branch
    git tag b-is-a-tag

If you then type:

    git branch -D b^

leaving the cursor at the position shown by the caret, then attempt
completion via <Tab><Tab> (at least according to my bash setup) two
options are shown:

    b-is-a-tag   branch

b-is-a-tag is not a branch, so should not be offered as a completion
candidate in this instance.

Many thanks,


Paul
