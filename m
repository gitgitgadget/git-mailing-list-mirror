Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76831FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbcLGKSO (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:18:14 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35701 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbcLGKSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:18:13 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so27206647ioe.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oVBmJtzf/dvG+/YRHubDzahdS4qXCHBlT1QoA/s+9J4=;
        b=htFVxalOr7PsE6B8fmdy2RgZN2ABMiKd4eZjXY2cb3jQrCHURTJJhnJLyaMP80G8rL
         1CVizpRiQmLM5uNnTaouZsGc4rsioxYuk28ZS4UEdX+6TRW/c+Sx6+i69C5LVDwz/9uQ
         NpN6JBrYjz0ZRD6uC7m4Oy/mTTRxQlK9ErEkXugRR7VVuNfUlMYtPjEbCLltQZWhwEgB
         +l/s7JoNhLiMT+1kswuq9TRzZ5tdxivsnaECGbfNMCq0C3r2qrJlN+cEhnWG2/PgelaT
         t1HB0reagdQd3h+c48CKefLMnW6wHxE8TbhfmWWLLYHCvv5Xdk3Z3jtawi54H8rJITMu
         xBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oVBmJtzf/dvG+/YRHubDzahdS4qXCHBlT1QoA/s+9J4=;
        b=Su+P1yT3HFBi/NEFuFzPjNyDtVo54WYAmAkrIZvQN1He6hq2M75kSKrDQ4kOr0IUo5
         mp3xyg5LgUXw01bFBzJVIAHsupds3TEsrFm1Kzlgt/tKIUKUeWzyA0migt+rRswn/7Wl
         OpR+6vaLu1IZ0fkrGqAEJ6E439wmAw0LwgWQZXpwxns2eGBQTVokncGa9EMbPNs6e9ex
         P/qhNh//BVWYoLwj/zpoKUES25SifYKwtqn53/9BzAy2e24RjvJx4DKiYqAKSIV7V+T6
         1rm6MXMcSAb++hp8ilWGcpQ8srkywSwDmwud2eBh5sNrXGfAd5DIBZ0NstTgJ0DdljgB
         U04g==
X-Gm-Message-State: AKaTC03+BZ9fJJxh65mzyzazT3YnbuYHFzjJZHkviCcI9+Rt4yyfA2JRpfcI5Dt0KGpbT7+BFZGBwP8IbFfHqA==
X-Received: by 10.36.66.76 with SMTP id i73mr1434519itb.50.1481105892971; Wed,
 07 Dec 2016 02:18:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 02:17:42 -0800 (PST)
In-Reply-To: <1481061106-117775-3-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-3-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 17:17:42 +0700
Message-ID: <CACsJy8AX09pxkyUkLU905v1MpXocLzV5bK0APuNmMUNb50Lavg@mail.gmail.com>
Subject: Re: [PATCH 02/17] dir: convert create_simplify to use the pathspec
 struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> Convert 'create_simplify()' to use the pathspec struct interface from
> using the '_raw' entry in the pathspec.

It would be even better to kill this create_simplify() and let
simplify_away() handle struct pathspec directly.

There is a bug in this code, that might have been found if we
simpify_away() handled pathspec directly: the memcmp() in
simplify_away() will not play well with :(icase) magic. My bad. If
:(icase) is used, the easiest/safe way is simplify nothing. Later on
maybe we can teach simplify_away() to do strncasecmp instead. We could
ignore exclude patterns there too (although not excluding is not a
bug).
-- 
Duy
