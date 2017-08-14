Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D2C20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbdHNRW3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:22:29 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36592 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdHNRW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:22:29 -0400
Received: by mail-yw0-f177.google.com with SMTP id u207so58782411ywc.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xoKENWhX7Ni792sopqCqMRodjUqnRigKMMdKcodF0vg=;
        b=ISvbVnJ6qxk0Dbq7A7sn2TvXphsoem7iw/O+yyAw+232MXitZd9l5P8OBl1A7fnKif
         Dj/BHFgKqDOr+8zMRgpSjsOcTY/sFsvM1y+4WC2KN2I4NQFDJu5yhDoGdXblDREIuwjt
         qJ4g+RF9ToU5V05JsV0DsDi7QFFY6eb8n+KGjDbNlbpqIi73Ldip+VkOBGe0eww4qXGm
         LhAUYBXcB5Mr8AivbWrV79EwWBVU776NNQxfGmK4tNqv5sk8wfSpuT/cmhsRJfmMjGVW
         P6o1LE46NXSdoiC0Js2By+l+8tNS536pTKIO50N87yuzCHVVu3Mf8dcK9Ihl6nryaRMQ
         vQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xoKENWhX7Ni792sopqCqMRodjUqnRigKMMdKcodF0vg=;
        b=lRnZpUswRG82aWApQpvk64+lFvKwXvLhmPIFDRFMle1NIl5q3aiYiU8S1YdtUq6FfE
         f1veMSOPFQ087GrtkvJco8rHfB8QSFKDmaQG+0McZ8yOMsVzjNw9wGXhpqbLEFCgzUSs
         fwurbIt+tMPVjkpH4tWFnw/mgrc0TRLqNPfIvw5PbIeaJS6Fw9Qv09jbhQSAKFlZ9fWE
         usMRFJ9JhZoBZkYbu9Tviy6zQIapP4lDIbV36szU1fBnpWKokAjF2/9G4333Wna7agv/
         luhXh56uPQkm8WO57O7yoHKpG8ADFZn9Z5xUFDgpElCC5pf44twf73+wgZ4po2b0mxod
         yjsA==
X-Gm-Message-State: AHYfb5j1Aa8VsUhq4SxtsgA3ZbxmilXLJH0v6q9Fnl4tvYxcAtKYGiQV
        0mI8RvWgi9NfHYe3Qmp7ZSkbCCTQC1xcnweHTg==
X-Received: by 10.37.98.71 with SMTP id w68mr20023618ybb.14.1502731348224;
 Mon, 14 Aug 2017 10:22:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:22:27 -0700 (PDT)
In-Reply-To: <16707a12715ea60e05b00f4eb887ee99cd4d7b71.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <16707a12715ea60e05b00f4eb887ee99cd4d7b71.1502491372.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:22:27 -0700
Message-ID: <CAGZ79kYd1rw8kCXyP8kSc0R2gxuRUDWrwfzPcGEBvMHXQe72Rw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] diff: check MIN_BLOCK_LENGTH at start of new block
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 3:49 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> When noticing that the current line is not the continuation of the
> current block, but the start of a new one, mark_color_as_moved() does
> not check the length of the current block. Perform that check.

As far as I remember that behavior is intentional, as indicated by
the succeeding test.

The whole MIN_BLOCK_LENGTH thing is a hack IMHO as we did not have
a better heuristic for suppressing uninteresting "moved" lines such as closing
braces in C.

The information that a thing is moved in between two blocks is more
valuable than pointing out it is just 'new' or 'old'.

As this is changing behavior in a way that seems controversial, can you
give your motivation/example for why this behavior is better?
(Do we want to put it into an option/mode?)
