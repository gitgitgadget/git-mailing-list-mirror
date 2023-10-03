Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A2E7AD57
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 14:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbjJCOae (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbjJCOad (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 10:30:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0787A3
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 07:30:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-27736c2a731so694620a91.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696343430; x=1696948230; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YERPgnlGDSAOvvqGASI1tt6mi3S4cTK2dwJGDgB0EIA=;
        b=kw0vQ83IphhnpMAgk+fonbZKac0cIlh25f8wsbdgE5bqr5yJZyh3geUbZEOxaCnbg+
         KVmHS3qOKEJLfXImPgocTnQ/de/g8iJK2sWx7uxIdLbiPkAH0nBQMAMvVF4WbXbEyldS
         oClcTTywsDdUE2zRUunH020+a+TjMxP4kzKEtIRNcu6kx+hf8LKp4qlxxGce4ntpy/El
         Gh6MUgiWiIHAi0fvZZ9ebuuw8AWW3rIwMvpZQwwq4VWXts1FxIf7OxFSoIBl1ZG60qCG
         Cj3wDXkJdmUaZBUpoGYnmDXfnB7zwttEUAp3nVN6tDT5vPPOTEryfjmTnPsxZT+gZd3y
         Vlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343430; x=1696948230;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YERPgnlGDSAOvvqGASI1tt6mi3S4cTK2dwJGDgB0EIA=;
        b=RTJ7RcW2MC1VVAE9iReDTrdYvi4V7vs9sRn0AWVTcJcftmmm7+zf53GAPlT7UUxmxh
         7PEupjLCDm+tBvq+Q6O2iJElWazXrjDOY6NXxBXM1tF1FjGZKPFpPylBF/qt4rVyb6J0
         ADIgzsyKZeeTvlHHz5y14tHKVXDBgzQRxHfEWb347mCLm++VXdS+NEIT76t42egLLEP4
         P8t9iU4xPmlueluegil1J0XqBXf+CKaf58MaufBFxYWPgOIHIYNRBr4MF4SPoNyRy0wC
         25z4tX+GukJ0JxibeIidAcdjBL1OuiwrQihcegl+E06d+iiOjDQGOqwEuvxcGS44XFZo
         liEw==
X-Gm-Message-State: AOJu0Yy12ee5DOaoevH8ltAbS7d+37av8Jkz0PrwVHZbAHFIzAxEYUAc
        WAtAdqO5DrHo9UFqGG+JQCn5hZIKiBMKyBqchYhl9BeC4PZjP7NfWlOe5nAJuWQ=
X-Google-Smtp-Source: AGHT+IEICx6MW4SeSD1u3P+9xWYzCTLaTDHMgaSvQcsLFA1t3NEfK3por6nIL0Nh0ET58pqJYLgJkrGAaknio+ZFaPM=
X-Received: by 2002:a17:90a:740a:b0:274:3a86:4c10 with SMTP id
 a10-20020a17090a740a00b002743a864c10mr12833978pjg.29.1696343429904; Tue, 03
 Oct 2023 07:30:29 -0700 (PDT)
MIME-Version: 1.0
From:   Luma <ach.lumap@gmail.com>
Date:   Tue, 3 Oct 2023 15:30:18 +0100
Message-ID: <CAFR+8DynAJ7eieMYUrezoNii5tzARNbESFxRCcT4w6okS5FZDg@mail.gmail.com>
Subject: [Outreachy] Move existing tests to a unit testing framework
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi;
My name is Luma, and  I wanted to take a moment to introduce myself
and share some
insights on an essential aspect of  avoiding pipes in git related
commands in test scripts.

I am an outreachy applicant for the December 2023 cohort and look
forward to learning from you.

One common practice in shell scripting is the use of pipes (|) to
chain multiple commands together.
 While pipes are incredibly versatile and useful, excessive use of
them can lead to script complexity.
I plan to avoid overusing pipes in test scripts by: leveraging command
options, using temporary files
and using functions and variables to break down complex pipelines.

If you have any questions on pipes, I'm always here to learn and share
knowledge.

Best regards,
Luma.
