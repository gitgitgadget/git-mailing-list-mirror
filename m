Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804FBC4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 00:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiK0AhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 19:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0AhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 19:37:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E96BC2A
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:37:19 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10741670pjs.4
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 16:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K2CvtBDYp1WD5LEquT6TFmL66OCYYg8mb7D6DTdxFC0=;
        b=fLZ5gnLcPZgk9m+pIw0ejkYoacG6ZnxLAFbvlpkZodzjauF6jwhp2QVRWobqQvQk/0
         kn91cCKZY/gu1DpFhRs9tvhRP3qL2DJ8bRxreQmRsC1tpk3+TLK8WL1AQatdoVPIWWdp
         XMF6nBmMdroo3kmQwi1quq+cyUBNKcd6JmHaSwvwAa0w2CeqOhisIyRwjOPh+5vhYe5e
         kjR5SYuVBYkTf78FIQhdVHXEmqrd2qn9JqroAcrOm3v1sk1ITyxLDF9PZNoOFl225Vb8
         m3IkW68DQn0kIWFSfaLXIlfWSx+zBbXvfD1OAL0jVqflSIuGulYh4NJmJWvKFepiDGTv
         kcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2CvtBDYp1WD5LEquT6TFmL66OCYYg8mb7D6DTdxFC0=;
        b=WUp7xc1glmIKWHT4wTHrkClxuThYsiuJqGNTG6uYY7aFAR3UcH3UOpwsyaCpEPdUzV
         NAhOBy2jJDSy/WrZHYgy2HZzSW+YDOgAAzlJv+fmoghJbjUNn6ximounIleXkywDGAo+
         qfs2QBfLYnfbWYF0NyJ05oaExgaRbJnWQZNZsrLuaNNWo0an6t3OJ2hFKLV4eA8zHwdg
         oHoSm8c3LUz3YT+hHo43vnhMUSgf33yfJKYoLn9Z0sFitNHtGgK/6VlEc4zf8D15nCMb
         EHE0Pmzbk2H+0eOvsv6Q8bK+CSQOO7SPCHjuLPgU4iS1r2+yUASJuBnvlf+fdeq1QZG/
         AX8A==
X-Gm-Message-State: ANoB5pnud6g+IL4KCo17LD4ioLhjFFYKoIFNeI3oxcBtA9GSNui5Ri8q
        zcD+b9uLvrh5RXf/icQ0qrvcjiXi002OblHmeqM/t1MA++8=
X-Google-Smtp-Source: AA0mqf6r6xiJQngwX1Ika2REI9aQckZYEuEqVCZ786MywCEwT1P6/eCJRIPKdTaKZXMJG/zKZRZw6MV2XIlthtIAEsE=
X-Received: by 2002:a17:902:e54f:b0:189:6a7f:3046 with SMTP id
 n15-20020a170902e54f00b001896a7f3046mr8630054plf.88.1669509439399; Sat, 26
 Nov 2022 16:37:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com> <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
 <221125.8635a7o123.gmgdl@evledraar.gmail.com> <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
In-Reply-To: <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Sun, 27 Nov 2022 09:37:08 +0900
Message-ID: <CAF5D8-s=6eJSXZbVwebbVcqtzVG1vLGopq7_2HT7rSjDbbJ6aQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2022 at 1:01 AM Yoichi Nakayama
<yoichi.nakayama@gmail.com> wrote:
> Second, there is a difficulty passing arbitrary arguments properly to
> Emacs Lisp properly.
> For example, your version will cause error with
>         git jump grep "hello world"
> My early patch was doing something similar. But the second problem was
> hard to deal with,
> so I switched to using a temporary file.

But even in that case it was fine to use the original grep function
defined in grep.el.
I'll fix it in v8.


--
Yoichi NAKAYAMA
