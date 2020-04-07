Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C3EC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D338F20768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R72ilhWM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDGSVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:21:40 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34727 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgDGSVk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:21:40 -0400
Received: by mail-il1-f193.google.com with SMTP id t11so4216315ils.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CX3fcceQ4bWjpoWaDimGwPSyFm9Hn+hiedA5QMT7DDg=;
        b=R72ilhWMiTc/PCRQzHAO4Twi0qwv/Y/Ntw9fd7QD8o8NKf2uqxzln6xrnOg+cIxot+
         0Fp6rC+Xu8QXeIvaO20Aw0Q/TngPWDSl5oZn7bFThuYNLDsMy5ZYyu2q2dvGkaciGyXo
         8c6s06gNiupTYMsihqJtCFdsK3sfw3hIQ7LLsi1neBaSaeTKIOelKuhtZj/zOnFc9vU9
         9kYcH61qCmUIpyw2b+xAAmczvi8Z6zKAoNPUBHtR7SP2cO6GsrVLcHUkliYObqLu7xwh
         8IWpaDcp7wZ5+M74LVsTuhYkBVu/mdESaTM8hjB85mArrcDurhU9+AJToL9IZFNKVmOW
         xJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CX3fcceQ4bWjpoWaDimGwPSyFm9Hn+hiedA5QMT7DDg=;
        b=lb5vPYSJ1MbOkEO3h8lwZtS9FI4BlvKX/uQ510JEMxYnkpUapcUKTMqHh9d5IcY5if
         BxsCqqm9OfUxFiT24KtAATQvgIl6xcQMrmimm0DqliqOzKt6spXQZD/i+ZACNsdBD8qU
         n3/hC24J0kPsre4QhpJxFyWloDTOxBp8gjJyqAOAE+OxP9SsgD2plGJUNpJmBhZdmP4B
         9YN29r4w5IP7TG2er4NQhiux3QRDO14woHPuUWS29Lb4WpfUXL98+A3znmGeXG6DbZQG
         0YDXoE9uqFTpHMfci3USpzHmFrj1knxpA1WuEbJu9rLnDPbxHQApnqpxHj4HbPemB1Pa
         6nlw==
X-Gm-Message-State: AGi0Pua18Z3G0y06osGBhn6ErOTJNmmdQAH7ySpFsvGQBmVURwrJYVtN
        FVqkqoq7m8Obr3fXWZ81lxlYxcbs0npDY7nMOunnXQ==
X-Google-Smtp-Source: APiQypJ+8WdBu34ygQPqepwzJjEqWXJ1LGj3fQ55GhkzqQlmautdONrKA00H/eBm44Q630dlyB8CkvHYJT17KYktGRE=
X-Received: by 2002:a92:8151:: with SMTP id e78mr4061106ild.227.1586283697358;
 Tue, 07 Apr 2020 11:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAMSEaH6+fQuDjhY-5THoYpEjjrHU4Sofnmr-nASHaTZbHvQw1w@mail.gmail.com>
In-Reply-To: <CAMSEaH6+fQuDjhY-5THoYpEjjrHU4Sofnmr-nASHaTZbHvQw1w@mail.gmail.com>
From:   Sankar P <sankar.curiosity@gmail.com>
Date:   Tue, 7 Apr 2020 23:52:40 +0530
Message-ID: <CAMSEaH5eZdNooNHQJAto_0dCZSFtiji8ZYvft+oZQXfzDHSyEg@mail.gmail.com>
Subject: Git clone question
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I am trying to understand about git clone.

From the few git videos that I have watched and using git, I
understand that git stores the difference between each version, as an
object, with the sha of the diff as the way to address the object.

However, what is not clear to me is, how does `git clone` then work ?
If a repository has a thousand commits, do we download all the
thousand objects to the client system and then apply them one on top
of the other ? I am sure that must not be the case because the `git
clone` operation completes so fast, and I doubt if my disks are that
fast.

However, when I do a `git clone` I could see the history until the first commit.

I can also partially ignore the history and clone only the last N
commits history too. So my question is, how does `git clone` work
under the hood and how is it so fast ? Does the git server save the
expanded git tree (with all the git patches applied) and we just
transfer them when we do the `git clone` ?

Are there any good talks / papers / books on the internals of the
working of git ?

Thanks.


-- 
Sankar P
http://psankar.blogspot.com
