Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B41C77B61
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 05:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjDPFvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Apr 2023 01:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPFvU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2023 01:51:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8532D79
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 22:51:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x34so9714642ljq.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681624277; x=1684216277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hbhbzgCE8p+NLKwQ8J4gekM7W+rJ5lYFNhQJdRmduM=;
        b=a+14b6WKd6ENBgqoeKjq+1gCXTwJY3W3AaFgnzraLhOIXfMezfIJORcKtTWpYwAo37
         E+zFs0Ec2wmlxyMwibBX/7d2bXqW+SIukDCaobxugjLVRtg9KP49ElCFV2mL98A1rbFv
         YEbMoHGKIFdhp8wmM++rdQJ0B/b0vnFoTqXQj10ApQ2oGotjhiqdNUDcajEFNSjppaJn
         luVYaK0XgkDo8AK0tPoH9PBBbLKcQZGJLeeerv7vNH0a3N95d45/CuiQ79QdE95iqHWy
         Zg3RzniyGLCfLBpnn1xwrUhlgBIBCe1CNrC1E1qfoqe2jOwu7Fan8XuyA3CKoJ6KHsRL
         /jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681624277; x=1684216277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hbhbzgCE8p+NLKwQ8J4gekM7W+rJ5lYFNhQJdRmduM=;
        b=GRmRyBTjRbX6k/og0C8YZ1QpnZ3PMl1VpXno0f/uMhEEHGwBt0rxCk+K8y++R6arVr
         Pjg+T08a0JFV3YPwKQMVZOSEiaTKiUnoMmQc1r8EXnQVlSJmNPIeH0GGwZlys44phq6D
         pI5afQexnxaZXPc6SDUEODK9tNnN7fK3VUCx89FdMsgLrlbdI8m8+zoMHR2/4hkiRzZQ
         V4RbgiVml5OwA+17EeyS4H4TjELz1ixh3Ao+YTDcdUVcMc4WNqmZM1XeQMhBZfuWPD2G
         fLy11XdL0ESqrHmKnQwnZGIhRU6d6b8Y3Gp3VlMJWjJEipbPXxipO5i3/R4OuvJCV6dZ
         ZFdA==
X-Gm-Message-State: AAQBX9cD6Lngf4SIVkpZgDjGRYiJdH/692PN8TQiFjCXwELvDnazsRDX
        CThSLrKyv2500AkBusJhZ9pFaJYB+OVaPswNBJR0xVPfxEk=
X-Google-Smtp-Source: AKy350aNBLvztswYSWaggQYWsYkyESE2/kzZ5bs5o83P6hRtUXF/qBHa/P6zSmU9PjuORgy5Cy2BKjpUJ2HEYXTJf/A=
X-Received: by 2002:a2e:9916:0:b0:2a7:a52b:123e with SMTP id
 v22-20020a2e9916000000b002a7a52b123emr3369857lji.1.1681624276849; Sat, 15 Apr
 2023 22:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com>
In-Reply-To: <20230416054735.3386065-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 22:51:03 -0700
Message-ID: <CABPp-BGM3NkQssYXKK+eeNm6qm7Jt6wXQp8AuXJRuVBThiwkXw@mail.gmail.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 10:47=E2=80=AFPM Elijah Newren <newren@gmail.com> w=
rote:
>
> On Sat, Apr 15, 2023 at 4:06=E2=80=AFAM Michael J Gruber <git@grubix.eu> =
wrote:
> >
<snip>
> > A real fix will identify a proper common header file (I couldn't) or
> > create a new one.
>
> I've got a patch that does precisely this that I just submitted as
> part of my follow-on to the en/header-split-cache-h series.  I've include=
d
> that patch below in case Junio wants to advance it faster than the rest o=
f
> that series.

Link to other follow-up series I took this patch from:
https://lore.kernel.org/git/003548de707f57cb9908b6dfbdf42954f668ee43.168161=
4206.git.gitgitgadget@gmail.com/
