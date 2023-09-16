Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F08CD37B0
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 02:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbjIPC4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 22:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjIPC4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 22:56:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51EBCF8
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:56:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50300e9e75bso393906e87.1
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 19:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694832984; x=1695437784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfu/8BODbvCermWi8HB71p1NvIad4faH8gY1LJhxoZY=;
        b=E4vHUiPc54SVrgdmKX7SiW3pvaYaMYKxWGydMPjWa0rWj2Dbz7uD5xRSZHojUO5xLT
         ygtgoyZefEvJryxblzb5xLB36DWJcn9lm9WSbAodUJojzcibhnhzGGUJrAN51ubg5YBm
         CUdSj866zY2QbsYVQRqIppr1M8Fdlq8qd8C55EzBlzzwLGJRAoOjUVGlgJHM95etqM46
         oOzvA0kHX3DRak1lPS7HgGu0hlN7URtT5Rdr95zrRgp2JSZoEnvgX9YMdZcOJ9+gr/7m
         pgOfM7fcBWQqJhmFpHVT6v5ljND/m9docDk1Dtr4Z0cEQ3O+fq2iR+SgVsk6UlpGQJ3U
         apdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694832984; x=1695437784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfu/8BODbvCermWi8HB71p1NvIad4faH8gY1LJhxoZY=;
        b=Ux2dIT4Y8+simiJDqtEh1N5w9ZUnoorkGD2VYj20Ywr6hAgtMTfnRzlny7s1tkvz7q
         RBMcaM4PSmbvyUrej4wnGjKvEnWyyD+lLZdUYFbQUJcd/zZleFJG5Xaxuxe65Jn30qCC
         GpwI/lsKB0gKyaPS4P71R4JlP7+rRgOtq9YnQkJJez7B4vEJOfMZAzS+COMIGqqxAdXl
         5kIvaJO7NCiKPFwlq3WtFA0qk3UVwCoz+pFSHpltqgMoNsukXc6AjvZJ7fniHQgkxlAL
         3UuLo8/IdY5IIJlccrwwncPIT5kNWR1s5kbG/J5wTLNgBbj7brpZJv26u+jyN+mQ7AcL
         7hNQ==
X-Gm-Message-State: AOJu0Yxd0xHHxRNkWSQOVQUSmXPjsWQYOCJVUoSbLKH5+ntzFe7PE6Hn
        D3k+pOH9LDywGuWDzUS4qAO2Ps3Zv2+mJJW3s7EFJ7zPBtQ=
X-Google-Smtp-Source: AGHT+IGShCY0YGJl2hsmRGne/69oZK9tBgAS4o5zZWJH9ud7pdS3mbIjSklky91v19CljQJx1iyrsMqQP8YZxPA0XhA=
X-Received: by 2002:ac2:4dbb:0:b0:500:76aa:b962 with SMTP id
 h27-20020ac24dbb000000b0050076aab962mr2111430lfe.15.1694832983643; Fri, 15
 Sep 2023 19:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230914093409.GA2254811@coredump.intra.peff.net>
In-Reply-To: <20230914093409.GA2254811@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 15 Sep 2023 19:56:10 -0700
Message-ID: <CABPp-BFzAX3b_Dm+fVcuNSKw2=7U3x747Ws7RMyWPxQ3GTNvzw@mail.gmail.com>
Subject: Re: [PATCH 0/4] merge-ort unused parameter cleanups
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2023 at 2:34=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> A few small cleanups for merge-ort collected from playing with
> -Wunused-parameter. The first one actually fixes a user-visible bug, and
> the rest are just cleanups.
>
>   [1/4]: merge-ort: drop custom err() function
>   [2/4]: merge-ort: stop passing "opt" to read_oid_strbuf()
>   [3/4]: merge-ort: drop unused parameters from detect_and_process_rename=
s()
>   [4/4]: merge-ort: drop unused "opt" parameter from merge_check_renames_=
reusable()
>
>  merge-ort.c           | 48 +++++++++++--------------------------------
>  t/t6406-merge-attr.sh |  3 ++-
>  2 files changed, 14 insertions(+), 37 deletions(-)
>
> -Peff

All look good; thanks.
