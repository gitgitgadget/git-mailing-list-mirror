Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DE7C433EF
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 16:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiCLRAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 12:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiCLRAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 12:00:40 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F32FFFBB
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 08:59:35 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d3so8100253ilr.10
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VnHhYMA55kNe9hx9NVaYvxN5JEdw4xZYB17e+93MZ5Q=;
        b=JKcngQZZ3LgrspUX3K1lxIPACDOer5Nk07YJ/Ek7gDAd1eOqBAdXCmhGOfd39l0Hyi
         QjXDKtZzVEXG1ZtcQaLB8n9+UHw1jJCatH3DT1cwYSoXro4ME2EwXt11Nd99evb4n9mi
         sHcctxZGsBe2JTqNb9R0jTIy0v676v7XKYcWI23M83J1+NP82pz7hKDdI3wBep2DfnVh
         Ye7UgvpRWSbup55mwSYV5iOWIpgFOs+/UXQrP7TlRQ2/QqgE9gN7ZqKK4iW8eyXMP2bA
         9ErGQCWcxdD1RWrImjTVaZDjCG6UrggXkWIhjOyNpErSlz0pcV5Nnvmx3PSp9bdkWNfn
         Xb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VnHhYMA55kNe9hx9NVaYvxN5JEdw4xZYB17e+93MZ5Q=;
        b=FvOb9a4Gx2/3tUcK54Q5E3yawsLRFxdSlzJBUC1cSpnXtjVeQO/wpty0SbC/XaAvzC
         luAaaYpwn6YyXTjLF0JQwP7lan/HrYgUMnZbjZQDw5S1rLrSU9LzidzGAwHtAmERtnLy
         TsQgMgvts4FZSZnsjttqDxIjKKtSO0/R+KKKl2VzxnJBkRAN9NlYyvgAvSZaExO1C1cd
         Q1sEzV67RF/l3Ssf82fz53+I4XreKm5Dp/eE2RWlQU0gB8wlzda037WTbLvnAItm4+DI
         LKfZyDA7/sshhFrkYmZmO4wHKEiB/yPLLha1sGxAFid8VKbfVy5S4VHZe/TwI49WIkuy
         K1eg==
X-Gm-Message-State: AOAM531GjnzFFAYns5ek6BXjioy1tPLSuBWlYF0kw5/t7OZBfC7c4FU+
        IhmI7zKGvnW0B51oLRrfFoQx273YybYLrmkd1swDkx4m7XgcCQ==
X-Google-Smtp-Source: ABdhPJzqX4Yi0grAtW2p9WDfFmrN2euxBCSvMPMizS+Xa2m+992PpEwqPcO6W/oYZyLavlq3nPbLvhfA4bJtLYgqjTU=
X-Received: by 2002:a05:6e02:5af:b0:2c6:2c4c:c4af with SMTP id
 k15-20020a056e0205af00b002c62c4cc4afmr11955182ils.42.1647104374624; Sat, 12
 Mar 2022 08:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220304130854.857746-2-a97410985new@gmail.com> <79bd770e-74f1-edf8-884b-c0f916732ce0@kdbg.org>
 <CAN_FRNK-FD+4_Nf_VdmU1N+TBapQ7ZnWo5Bn8M9YDWWhMfBypg@mail.gmail.com> <504f9f0d-a1ab-5ce7-d744-9398b0e7e68a@kdbg.org>
In-Reply-To: <504f9f0d-a1ab-5ce7-d744-9398b0e7e68a@kdbg.org>
From:   xing zhi jiang <a97410985new@gmail.com>
Date:   Sun, 13 Mar 2022 00:59:21 +0800
Message-ID: <CAN_FRN+Q6L-RhUNrpoyNzL-dmCNYKB476Wo9AKQst-4oiS-T8Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/1] Add a diff driver for JavaScript languages.
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 8 Mar 2022 at 14:47, Johannes Sixt <j6t@kdbg.org> wrote:
> I meant a multi-line function call like so, where the first argument is
> on the same line with the function name:
>
>  RIGHT(aaaaaaaaaa,
>      bbbbbbbbbb,
>     cccccccccc,
>    dddddddddd
> ) {
> ...

OK, I got it. I thought it is not a difficult case, but I add a new
test case for this.

>  <No, I refer to the whitespace around "=3D>" that is not required here, =
but
>  was required in the previous expression.

 I think the space is required, ex:
https://github.com/webpack/webpack/blob/c181294865dca01b28e6e316636fef5f2aa=
d4eb6/lib/dependencies/DynamicExports.js#L17
. The link above it has space before =E3=80=8C=3D>=E3=80=8D.

Best regards.
