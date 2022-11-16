Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD70C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 18:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbiKPSgl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 13:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbiKPSgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 13:36:40 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F825986F
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 10:36:40 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-369426664f9so175893507b3.12
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 10:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvsGIi73PhigwMSJtp5SLgf46kylmt4dBx6q1q+cQN8=;
        b=kQecxsjh7tcOzrnbm+U4Y3aqVmt98P6C9O2Tw7VGEGcxVUG23ZZslpFKasP9MvOAxK
         YQbjx1hWD9oJWbuq4NSQs6yZ3gUY7+ahiF/OW+fMmlcu3P55p+43nuLljq1xh4kYBaXS
         3TBUHDcEZqFKYAGP+p9hwvJB2B7fuzsKNKCvNqmV2qpBh7h//q83ECaT4oHUxIKgrcLN
         R4LMkqD0cKlWHxfRU5K9rWhcdg3y/vdAizwz8NPUicBTaxuloXUrfzvSjDeCQNxrAqb1
         SokmgmVbwaoXMgR6JoNljaqsUy97w5nk5RPdaDoWHuGK5WHDUSVKmjX8vrODOss443v+
         z4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvsGIi73PhigwMSJtp5SLgf46kylmt4dBx6q1q+cQN8=;
        b=OJmfrtGGVH4he4wmUZt0CETV+y+Ib00XLkEbGybP+lEGWbXJZXAhvpGKKHYU+Yhf/S
         AGusfQs9kx/Ed8IvebKqq2sk6OP7jZc7yLd+nmy3KZ8cGosmGHKpVWd2vP1Q3WnoHzOo
         Gs7GhnMq9Yi34QreUDXkDrFgbnkCOhaY1VUpGeBDw8uuoqh1GB/2QTzmThir0dXWX2OQ
         8r+BNqrj0DH1rdBBfSGvx6q7Q40Ig6CpFPsTRDAL4EjPMzSzUcEWH7WRwNiSogqyuyZH
         Ebz1k+2pIJE04oHAdVv8riSaz0Y/34QPa+t21bkMkB0hbLJr8MjL6iZkUK7WyYKIuqJp
         C29Q==
X-Gm-Message-State: ANoB5plRSq144A25OJC7rJ+qQFk5u8B2v6ViGiR1v8oRTOb5KB8y7uuo
        fb7Ol65475fJxKyIhfHJm5ws58o9NdcE4priKngB2HVwGak=
X-Google-Smtp-Source: AA0mqf75om3GkoDj7nSff1+0NOc7mIXWr5CQG2MC/+hCqZ7VLXy8twWrSEMi+gG+NWq0XSjcfj6GaSINmrLigTV3dDE=
X-Received: by 2002:a81:1a56:0:b0:369:edd9:6c8b with SMTP id
 a83-20020a811a56000000b00369edd96c8bmr23634602ywa.452.1668623799151; Wed, 16
 Nov 2022 10:36:39 -0800 (PST)
MIME-Version: 1.0
From:   David Hary <davidhary@gmail.com>
Date:   Wed, 16 Nov 2022 10:36:27 -0800
Message-ID: <CANNdkQZByT6dAiAJ=yrQshBi9suDUV2Xum2TtAGyJDKxb3f5QQ@mail.gmail.com>
Subject: Issue: Git for Windows: : Incorrect registry entries for the Git Bash
 and Git Gui
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

:Observation: Incorrect registry entries for the Git Bash and Git Gui

Likely Cause: the registry entries do not update when updating Git

How to reproduce:
1. install git as a personal level user; git goes to c:\apps
2. Change user level to admin;
3. Update git; git files move to c:\program files;
4. Try git bash or git gui from the File Explorer context menu; both fail.

How was this discovered:
Having had some issues with android emulation for visual studio, I
changed my user account from personal to admin.  When updating, Git
got installed under =E2=80=98c:\Program Files=E2=80=98 instead of c:\apps. =
Yet, the
command lines for Git Bash and Git Gui as recorded in the registry
were still pointing to the c:\apps folder causing the explorer context
menu shortcut to fail.

Workaround: edit the register changing =E2=80=98c:\apps=E2=80=99 to =E2=80=
=98c:\program files=E2=80=99

David

David Hary, PhD
President
Integrated Scientific Resources, Inc.
+1(310)453-6809
