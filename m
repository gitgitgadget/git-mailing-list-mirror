Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E8B1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 08:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeGPIcy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 04:32:54 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46157 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeGPIcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 04:32:54 -0400
Received: by mail-yw0-f193.google.com with SMTP id e23-v6so13367274ywe.13
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 01:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIt5BtL69zApSFaTu/Bmu7XR8wTXMPij1Yu90F7dxO4=;
        b=ZkXI+KIU5ZfTkb8ci/TxF16rDb02YMqRXfvwLyii6vWfIH4fPRwir/S9Xrj+VdODb9
         TVThgWUswujXvqphl8y+jsk+T309np8qahU3rBTPq/Wui/fghIbt7ik1vX3VX89/m5K/
         oQyAaWt+wR8OaJboJ3iNPJah48nFX/fuTrKAgts4sYWABx9YRdf1scCyJx9u+MCSpror
         uyqNb21QfHvNTE+smm/bUWawCDIRBjrl+ap6gwFFLoW81k47VlS6cBYxyho/hz4mx3q0
         lZb7LkCBPtPX90CNPvFf9BLfJqZ2K13p52BxAq9XVOtqr7f5k1IOLRTpHnAXWHbAhe2U
         I38A==
X-Gm-Message-State: AOUpUlFVOk/ILUkmnHMvs4zMZ9VPlRa9jNOGndHvmnTm2HUuS/PvyIwZ
        E79qFIlaxf113Ackio4glV8qmVnbg9A9jvvKMS4=
X-Google-Smtp-Source: AAOMgpd1v72VUp4pol70AkFZEN6k16tqFn15rJ5nqkkXl5jKHMdxdfrP38CCVPZ+EQ/3xEMIrUFmtqdQ8en67JsXZM8=
X-Received: by 2002:a81:ae66:: with SMTP id g38-v6mr7704260ywk.74.1531728404273;
 Mon, 16 Jul 2018 01:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
 <pull.1.v3.git.gitgitgadget@gmail.com> <4a68b95ce2a6463708c92d1bcc0208352c14f836.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <4a68b95ce2a6463708c92d1bcc0208352c14f836.1530617166.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 16 Jul 2018 04:06:33 -0400
Message-ID: <CAPig+cSyTKLOXbfGx3z_RWbHaTZU_EKWJrCqwCaw+urQph=4Tw@mail.gmail.com>
Subject: Re: [PATCH v3 20/20] range-diff: make --dual-color the default mode
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 7:26 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> After using this command extensively for the last two months, this
> developer came to the conclusion that even if the dual color mode still
> leaves a lot of room for confusion what was actually changed, the

"...confusion _about_ what..."

> non-dual color mode is substantially worse in that regard.
>
> Therefore, we really want to make the dual color mode the default.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
> @@ -31,11 +31,14 @@ all of their ancestors have been shown.
> ---dual-color::
> -       When the commit diffs differ, recreate the original diffs'
> -       coloring, and add outer -/+ diff markers with the *background*
> -       being red/green to make it easier to see e.g. when there was a
> -       change in what exact lines were added.
> +--no-dual-color::
> +       When the commit diffs differ, `git range-diff` recreates the
> +       original diffs' coloring, and add outer -/+ diff markers with

s/add/adds/

> +       the *background* being red/green to make it easier to see e.g.
> +       when there was a change in what exact lines were added. This is
> +       known to `range-diff` as "dual coloring". Use `--no-dual-color`
> +       to revert to color all lines according to the outer diff markers
> +       (and completely ignore the inner diff when it comes to color).
