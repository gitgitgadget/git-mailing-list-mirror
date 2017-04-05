Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A32520966
	for <e@80x24.org>; Wed,  5 Apr 2017 20:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933173AbdDEUBA (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 16:01:00 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33011 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbdDEUA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 16:00:59 -0400
Received: by mail-pg0-f43.google.com with SMTP id x125so14240392pgb.0
        for <git@vger.kernel.org>; Wed, 05 Apr 2017 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DaCFSctazocb6com16zJw1fjddzZAiI+2IVa+Cienwo=;
        b=exgy/SyGis4F+yFxUnhSnrDe9PKH5HIDWc/P/kaiQpSj6QYrXSIPehynO07WGv2b5g
         Dk02mAEnpi2f0v6IWYXwiHgIfoSorlVdORGlEzA4GjRqt9pr23hAm1KdXZ4Cp8beHOb5
         meSdzQQkJLwjHSh3u4OquBmEAuacVSfyFerl+d/EyOcpqYwWz26CuWDUfyDp9iNxfFUD
         VWSpvGkzI8RNXMY204VgMXUpyGoPBrVejqn12sBuOe78x4U+ZHsHqMHUju6BteQk1ogl
         ZbT4Xr3XEF+ytvlpfxgNcmkzZpXEZ0EOEFK9Xd1bfuDLPYG1TyGJNf1p0agtemnkNzSZ
         USag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DaCFSctazocb6com16zJw1fjddzZAiI+2IVa+Cienwo=;
        b=HoYckuTh2sjNvVUSnsuRbotT/E0WcERXTkS01GdzRgTpiR3TFg1Rv4HaZb3WT8PhBJ
         0qqLvPIARgHVBFVOUt171zg0AsbudKaV3PIqhiiPs1ArT5e3y2ebANh0A1pFVLUN4nk5
         hz/DUSiMERea12iZTfghkVIIuvPUn+tbXy6GfNJLJvYb4mrNuUbJoI5WQzRkA/EgH2g3
         0eBQOSQ7/r1si+bcnIhoJaRUdPjWPGnnnazt0kXUVlgni7Fyh5bY2DAo+19DIQlORBFa
         hnSzdjQ94IMlLDkuOnt46IQp/RUUiWJHt5G0S/PlSJNflF6ImhhATIP8/8XL/hpvQZRj
         QvDQ==
X-Gm-Message-State: AFeK/H0a7Zr4+Gx2m2bZszA+X8bdcwnW1re4wHGk7ivaRUnLyeI7B1eTj3NduVUW99Al+p3P7Vgjjd9ky6Xf1EBJ
X-Received: by 10.84.232.131 with SMTP id i3mr38312488plk.172.1491422458201;
 Wed, 05 Apr 2017 13:00:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Wed, 5 Apr 2017 13:00:57 -0700 (PDT)
In-Reply-To: <20170405195600.54801-2-git@jeffhostetler.com>
References: <20170405195600.54801-1-git@jeffhostetler.com> <20170405195600.54801-2-git@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 5 Apr 2017 13:00:57 -0700
Message-ID: <CAGZ79kYFjuESBr72f5eyv7r4XohzY4KoQU36pqHLa3CsLuKi9w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string-list: use ALLOC_GROW macro when reallocing string_list
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 12:55 PM,  <git@jeffhostetler.com> wrote:
> +       if (list->nr + 1 >= list->alloc)
> +               ALLOC_GROW(list->items, list->nr+1, list->alloc);

No need for the condition here as it is part of the macro as well.

Thanks for spotting this fix!
Stefan
