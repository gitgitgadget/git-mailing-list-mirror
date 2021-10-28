Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AEBC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5B861056
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 14:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhJ1ODJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhJ1OCr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 10:02:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913DC061348
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 07:00:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t127so15413207ybf.13
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=99IPAL6hvU6/StxwbJZeizOmFrkc81b6ng+qGkPzUyU=;
        b=j3R8rWONo4JRwx5nDtla0UgVkpuV1PivLI8LNr4pwkWbIGb9cqc/I8nAJUz+S9nr0g
         4zpR9G2/SVOwVrPj0HT8dyqxOvI/jJzThWgJ9RzcFCKp1naoADKXjY05r5WAzrI4uZEY
         WyxiA3QQryY5uMhN5IE+RQ3anNZdhIdQJBjqr/ZH24D4bCVxBYbbtkHf6MtcL43U63AD
         zbmxbE6lA5dQ3cEb2NVGewui4uKwBgOKnFB2K/7Q049/GIXSwgS3wS9k+gAQ1KrUwtcU
         qQKLmt034K9xEE3InAeeouTZ6LGp5xwNpnlp6HX3bGUMXeorwC79CSj5tvWucQwN/s/o
         pUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=99IPAL6hvU6/StxwbJZeizOmFrkc81b6ng+qGkPzUyU=;
        b=QXXnbU5tqfA4f+kq7WHOlb0qj9BF03QrhLwgbje/TAgdpUmvWLSD3FiXpBA4NADb8y
         dSbCe20G0HhWoXkzU442TIG3I40SkwnicNgJX3z3DCgR6pzvU6r7GGtBjpm0+n/JddoT
         cBmnjn2CStBGL1XFzR868sZ7CG/tomqNpbmE//vw9XkJfWaUvlR11wM0whkLgNj0D3ON
         9/KNOqpxsWLgwbmYyzBQe3kebkPPRwO9RWakSqoI/oC+DGSbufHHoJo6gEtNtokXJf72
         hRz1SAznuKF2cCOSkhz9sWl3Hl1ZJBY0oyX690Me7WGoPFuttIyjHclrxew+BI1B8IJF
         rIOQ==
X-Gm-Message-State: AOAM530BykW6APCjjb/LIIdN9xDTc530HvGzL/kphP/A8uOqzJCrN4Ps
        6DadCR4JgHluGOR77gYz4EgikHiHligCfzcBgr7o+9r0pmc=
X-Google-Smtp-Source: ABdhPJyKuAxnP1XzlgNryMkZK4O+wVGAtHa+pp/c5n6Z4STZUrAsabYDJQnRWcls5zUwKKNy6xierOAI22tu92VvGLw=
X-Received: by 2002:a25:bed1:: with SMTP id k17mr4690546ybm.215.1635429619448;
 Thu, 28 Oct 2021 07:00:19 -0700 (PDT)
MIME-Version: 1.0
From:   Nicholas Bransby-Williams <nbransby@gmail.com>
Date:   Thu, 28 Oct 2021 15:00:08 +0100
Message-ID: <CAGyLXMBWyfcBVFDRbYJMk+-RjjNBQDvoDeaBtEPiXpUDDTqfOA@mail.gmail.com>
Subject: conflict markers in markdown files
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isn't it quite unfortunate that markdown chose setext-style headers by
=E2=80=9Cunderlining=E2=80=9D with equal signs (=3D) meaning if a header is=
 7 characters
long it's going to clash with the git conflicts markers (example
below).

Would it make sense to add an option to merge-file so merge tools can
specify a custom marker that is statistically much less likely to
clash with the kinds of text files that are typically stored in git
repositories?

cat ./ours.md
A Second Level Header
---------------------
Ours
=3D=3D=3D=3D=3D=3D=3D
Its ours
The quick brown fox jumped over the lazy
dog's back.

cat ./base.md
A Second Level Header
---------------------
The quick brown fox jumped over the lazy
dog's back.

cat ./theirs.md
A Second Level Header
---------------------
Theirs
=3D=3D=3D=3D=3D=3D=3D
Its theirs
The quick brown fox jumped over the lazy
dog's back.

git merge-file -p ./ours.md ./base.md ./theirs.md
A Second Level Header
---------------------
<<<<<<< ./ours.md
Ours
=3D=3D=3D=3D=3D=3D=3D
Its ours
=3D=3D=3D=3D=3D=3D=3D
Theirs
=3D=3D=3D=3D=3D=3D=3D
Its theirs
>>>>>>> ./theirs.md
The quick brown fox jumped over the lazy
dog's back.
