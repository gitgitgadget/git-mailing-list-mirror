Return-Path: <SRS0=yx/J=7F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0260C433DF
	for <git@archiver.kernel.org>; Sat, 23 May 2020 22:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6381220727
	for <git@archiver.kernel.org>; Sat, 23 May 2020 22:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elKQTYWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgEWWpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 May 2020 18:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgEWWpM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 May 2020 18:45:12 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7CC061A0E
        for <git@vger.kernel.org>; Sat, 23 May 2020 15:45:11 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id b13so5038613uav.3
        for <git@vger.kernel.org>; Sat, 23 May 2020 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rEkkcs1lhhUJl6eFcQnPyH8W5/jYnV0uzFE1yc25ieM=;
        b=elKQTYWtGIQVsPThwM7I9PAIQMPFUMKg6tjNrIG+D+WHXP5fTUuKsgOjsR6j0l0dh/
         uAMul0XEMpRt9hGc5IwaHzj4fjZzQ5sOrR/j5GsAM1b7blTabzf69h9Y5bcqMObVBLQM
         TR5Q4TcfVPlB7JH504fqLEOL/hFwOsv8gD4+ZAqcMWbel719dS8ZxKbOXVIUC7iJsZE+
         XxMdwsTNHhIXOEczhG5xhJINDTIgHwfmPSYr0yGO+zOWwWSySIsNh75WQZ9WdELzqG5J
         JpaetDN/O8Nnd8JflK4gyt8gZGtEEY8SHMVKd7OEI4QbRt9Uxmg7j9DiasUetPQRqf+u
         xFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rEkkcs1lhhUJl6eFcQnPyH8W5/jYnV0uzFE1yc25ieM=;
        b=RSc+gZdK5MrOc73Jo38CfrUfPOH0tuyWjLofm98qbh+sCSReVPN9SbxRDFA1JhBDCm
         PZ3QRoBKkec49DhTniWLMw1A2/VeX/WRoaNTiOnFKCYeHy1qwgAcO3nEhlxh8DQ32edI
         0UqwXj9LLLDjzFUuxIWnnc9nOz16iknhTOvcndP40dCzocaG9swgi8cvk/FiakjF6yP9
         0l19pqPSU7AhPlEJKv4ufawvHHkHQZjyNWMAjP/BPI4Khzj0yUOEOZhoUfKHXK7vMnP9
         Tdx1qm4JcNHnNbnjQwPDHONi6A8pk2tEX/EscIx7rGFFkrAfO8ssY0fSLJyOCHrIXiXC
         qnSQ==
X-Gm-Message-State: AOAM532U6PJynOGrXJfx30b3jI05/lSw8gTffQjnbMwH0Hhdj6ap5kc9
        gv/sxTRwqyPdW0LsEgpnH2mHchdPv1E1hY+Vlnxj1dZs
X-Google-Smtp-Source: ABdhPJxiLpv7Ohiu+YLy0qLiSGhDLsWBHo2wS9FZ2bqG78G3c+vaD7ecUHHIGtfu8fQVvU5f/Cdv9DBAT1Qk6+vrtAc=
X-Received: by 2002:ab0:6855:: with SMTP id a21mr15181765uas.30.1590273910528;
 Sat, 23 May 2020 15:45:10 -0700 (PDT)
MIME-Version: 1.0
From:   Michal Vrana <mivra1@gmail.com>
Date:   Sun, 24 May 2020 00:44:59 +0200
Message-ID: <CA+sZKRqMaSZqj3PdpRz3xrruTbz1CJV=W9s_ox4BrhCAuQqhKA@mail.gmail.com>
Subject: Submodule init uses STDERR output
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I've come across an issue that seems like a bug to me. If I clone a
repository with a submodule but want to initialize it separately, then
the error output is used during this initialization for what seems to
be a standard message.
Motivation:
Cannot use - Fail on standard error setting in a devops pipeline

Steps to reproduce:
1. git clone
2. git submodule init 2>err.txt

The err.txt contains a message like
Submodule 'xyz' (xyz.git) registered for path 'abc'
From what I've read this is the standard output in this case. And if
not then why when I use "quiet" mode then the error output is empty.
So why is the error output even used?

Platforms reproduced on:
git version 2.26.2.windows.1 - Windows server
git version 2.19.0.windows.1 - gitbash - Windows 10
git version 2.17.1 Ubuntu (Windows subsystem)

Thanks,
Michal Vrana
