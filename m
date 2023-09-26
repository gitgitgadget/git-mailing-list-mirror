Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C983E6FE31
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 00:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjIZAns (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 20:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjIZAnq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 20:43:46 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D245116
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 17:43:40 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f55c276c3so60149117b3.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 17:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695689019; x=1696293819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgns4opt/A9S4/J8V5XA8IpL7plK5603jjwiHOacLeY=;
        b=XOXO3dlXG06bVJ5VsFRM2Hpa/O8qfCAX8470+ZleY8ScZGx6owdsX60Tg7VwS6kov+
         OjuqVsxgT6g6ZBhC9Drj27taT87Uw1sv2rCYTGDtolmCSXI/4RHjYMGIf4j1V8mimmVM
         cNe4/DdJObNCsHGXFPCIlkHCO75FHZgepsHVhU67Niphvhyj8kGsZnmkEql0ijYiCD1M
         GDTY6xfyE4Em2DHKcItNYLd2K1lqw+7pAbLAXzT4p83AKP33cjrUCTjJiZgZlV8+fzSX
         b4BHuI896O41i0Lux/4NQbdOVey7jY7w3I5zcd+AiAphVkbewcx2skQwSXVG2Et30MP5
         kfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695689019; x=1696293819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cgns4opt/A9S4/J8V5XA8IpL7plK5603jjwiHOacLeY=;
        b=krOurYTZVaCBWJ/MxehHcOmYBo0BT0gl+kg85EY9cAZG04x81cyvm1iZEQUvRqpr1y
         RvC8nvBuQjtQ2ZEu4MIXVTcHRkSYDITgxOsoAhHTm/OcqGglDw/8x7MgJ6gk6BMYsqAZ
         6f7E0DOC2mtfuSIj5XzFTZ7zw2JN1lOVB12zrPrV6v8OslYNBT4lsCQiskf9yi2keZY7
         0XqTfKEbUlb/i32ZrBzhBBwph9G7JllBjhpOSiHVudTYhuSom/bqD7EtDBcSv4kFTwL7
         31d8gQ/2T4vB03BAhUcwp/CbVRR837m9aHxUlgyyFK8+YGcERyae5OTpupaVVA6nMeoQ
         t6Uw==
X-Gm-Message-State: AOJu0YxwWO/IiIbN0Iur09WTsSlxgZAz/mHcyUFw3mzcAdnQsY2p7vIf
        kGG+Yt3JjrNxYS5t3+Yg3z+1gkCHVXjrhl5YJ51irY5gWHw=
X-Google-Smtp-Source: AGHT+IFHQWQh/3z+MzxpNPoGbf/VPazxQwK7y5GyTizCvEOZS9L2ftaAteMw5lUJd2QNSpXLY7ic4GsvCjixQj06TzY=
X-Received: by 2002:a81:4f96:0:b0:59b:eedc:43ce with SMTP id
 d144-20020a814f96000000b0059beedc43cemr8799185ywb.4.1695689019088; Mon, 25
 Sep 2023 17:43:39 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy1h2f5dv.fsf@gitster.g> <20230923152201.14741-1-worldhello.net@gmail.com>
 <xmqq5y3xrj19.fsf@gitster.g>
In-Reply-To: <xmqq5y3xrj19.fsf@gitster.g>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 26 Sep 2023 08:43:26 +0800
Message-ID: <CANYiYbFwtJ=pT=TfWmkOfzKLNeFzoT2ofXsjKihfUt-awv6K4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] support remote archive from stateless transport
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 6:21=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > Enable stateless-rpc connection in "connect_helper()", and add support
> > for remote archive from a stateless transport.
> > ...
>
> Administrivia.  Please make sure that your patches [1..N/N] appear
> as a follow-up to the cover letter [0/N], instead of each of them
> being individually a response to somebody else's message.
>

I will set the "format.thread" configuration variable so that I don't
have to worry about forgetting the "--thread" option when executing
git-format-patch.

        git config --global format.thread shallow

Thanks.
