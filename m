Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C51B41F42B
	for <e@80x24.org>; Thu,  9 Nov 2017 10:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752772AbdKIK6L (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 05:58:11 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:43021 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdKIK6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 05:58:10 -0500
Received: by mail-io0-f181.google.com with SMTP id 134so9395295ioo.0
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=h8o5ywHKWH5zLXARPK84cxXebVMO9teSy+ppU2Uoj1A=;
        b=SADTt+wgQaWAGINZlpNuZLbhkpZbxon7NaTJ6CL7yDUrcCEaecw1UCTdDz7OPx7gtv
         giZ+ZYs/jbantnskZIw1OT9OXJDEk7lmPxyTUOoiqj8Lhytz8XTSy2zBrYaGFjXyNtYm
         VwcbSGbLB41CMXhiU57T+XoH/YXyzqBShn8gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=h8o5ywHKWH5zLXARPK84cxXebVMO9teSy+ppU2Uoj1A=;
        b=BoIhIAm/+zzc9X6hIbu0dTWlA4J9yyFkgv+P6ihRIOFFPhwbkQemqeL+TaB4HZbbBv
         7fy0JI4g6SQVq2YdRjUmUZN5/j+S863utzrqse9Z6eRaZyfeswh8zFq8BEBMNe98de3o
         XbbOL50UvVS68LPyjAqf1InKmeURP9IeR/kQ2/RP2IHgvLer4BcNxTKcEBsLVeSM0hcc
         1M/i5OeA0cXNSzTU+zRDZtVTCwY8ZmOFnp2E5iSnSwlHSx+zD1jrZ2W6TAdQ0deQuPBp
         YU+ueqMAlH5bGg+CZ4Vf4WGih0MoveOY61wVsQ8GuYH2Hax5S5RnSYNezGKUZdQggpVR
         d3CQ==
X-Gm-Message-State: AJaThX7fF9dJ8OieU+Is1RShl+IHwggAb4U6cfDI7l0pDjhXKu2f2KfF
        m1HB+e8TsJCYxxjwH0Lzeh3/nBPP7XavLCgeawyUUqD6
X-Google-Smtp-Source: ABhQp+QBO3Mmybw0Sr8GkG+tT5FIsb/4rzq/whEPUESIJi0/6q04g13RbaCasfZztYe1CFqFZYKxn8e+uFSczAepDAw=
X-Received: by 10.107.88.9 with SMTP id m9mr96580iob.34.1510225089625; Thu, 09
 Nov 2017 02:58:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.109.3 with HTTP; Thu, 9 Nov 2017 02:58:09 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 9 Nov 2017 16:28:09 +0530
Message-ID: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
Subject: [Query] Separate hooks for Git worktrees
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a typical use case, where I am using the same
repository for both Android and Linux kernel branches.

Android needs us to keep a special hook "commit-msg"
which adds a "Change-Id" to every commit we create.

While this works fine with Android, the behavior doesn't change
by simply changing to a upstream kernel branch and eventually
by mistake I may end up sending patch with Change-Id to upstream
kernel as well. And I want to avoid that.

I am looking at ways to make this configuration work for me by
applying the hook only for Android branches.

I tried using the "git worktrees" command to create a separate
linked tree for my android branch, but it doesn't have a .git directory
but just a file linking to the main repository.

Any idea how I can get around this problem without having separate
repositories for kernel and android ?

Thanks in advance.

--
viresh
