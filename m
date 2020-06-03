Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E407C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14BE320757
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Jw0mXFj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFCCRj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFCCRi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 22:17:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD4C08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 19:17:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u10so703699ljj.9
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 19:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6V2SWrhv0t5P7MoJ8Y170daROhv/j8LlzWitIxYY3n4=;
        b=Jw0mXFj7qBksZtnWEBVgGWhWS5VJ/2V9tCtlYlTQRfXUfjGGqC76Hc8N0vxxCn/P+v
         Tjaj0r8dHkvxP9RVczM54LxXejm+mVj9jZldDwF/sRsZ7dNnyrcs2xe2rGFlnH9X3wTp
         siSuGkksIPHXg5AiaU7RtDyPTsIkqK6/ozxqPfRX4RAD3sIZcaDROclMaiMmLh4si0X7
         S1Grc/dDEFzS6aK5AejJUYhLMkoMYzReK6vgVKIFucIZOZy2/UxVMzJJnK/BRaGsaLhi
         xeW2DJM0f2K05noaPVmZxFKh55rW5iLgQ863rOI9k8AL0ldJHZe0/UmFH0exY5mqeevc
         MPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6V2SWrhv0t5P7MoJ8Y170daROhv/j8LlzWitIxYY3n4=;
        b=C8OqnB+iaf8NUU/1+uy932hcwEwazCC9bKKH5OYCSjR0UmR1SYA/YLwpElM2BZ7/nM
         zoVnbQHZNU6CpqF59TFevDcuxRu1DRL4KGP8Oq/01zKQPWOQDYodFQiHUCyLri1Y5c1l
         m21ZozGqpux3g7wG5xjVFg3d/qKfe92uiE/sBlFx6OsEhFIyVrThafqDViJFzEBezx6j
         9mcii3IFbcoIK0E04zztL5Dar/GfZmTReWgkBpBjo9UnvsR/qZhYjVSZVcyk0kSXfNLM
         m8XiHxdbnRGmxCcZWCXIgGpyQtZxljGGVmp9bTBAjUm9OPS2wJ9ISLbZAhBpCHm/LXwT
         oSVw==
X-Gm-Message-State: AOAM531wZrXiMwgz9xPPgclC8M81JCChLCRSKHg5o2QHnAHPQVZHtdl1
        RTBDaQLnSkbFDjBvqVswQmK73wLsABILit37YkEo45fqY4o=
X-Google-Smtp-Source: ABdhPJyfnvA5n+OX+xpss2rTmvhZcbxlA/qrs2ZEL8OYq1ewg9X80dQfg619tBfCr8/mGULFnxgbb5HvIHaxoXyIR2c=
X-Received: by 2002:a2e:959a:: with SMTP id w26mr848416ljh.74.1591150655397;
 Tue, 02 Jun 2020 19:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <d9686e75-0792-33f7-dd70-3dc8ca6c4d66@ramsayjones.plus.com>
In-Reply-To: <d9686e75-0792-33f7-dd70-3dc8ca6c4d66@ramsayjones.plus.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 2 Jun 2020 23:17:24 -0300
Message-ID: <CAHd-oW5gaaH9Tn9Xq99AgH41N30Lr6N3n+GC2j1XUiNKyvAbdA@mail.gmail.com>
Subject: Re: [PATCH] git.c: fix sparse warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 1, 2020 at 8:27 PM Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>
>
> Commit 4acc44d720 (config: add setting to ignore sparsity patterns in
> some cmds, 2020-05-27) adds an external symbol definition without a
> corresponding external symbol declaration. This causes sparse to
> complain: "symbol 'opt_restrict_to_sparse_paths' was not declared.
> Should it be static?".
>
> In order to suppress the warning, #include the 'sparse-checkout.h'
> header file, which contains the required extern declaration.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Matheus,
>
> If you need to re-roll your 'mt/grep-sparse-checkout' branch, could you
> please squash this into the relevant patch.

Sure! Thanks for catching this.
