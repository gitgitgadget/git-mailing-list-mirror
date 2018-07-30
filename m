Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24851F597
	for <e@80x24.org>; Mon, 30 Jul 2018 10:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeG3Lkh (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 07:40:37 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:39211 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeG3Lkh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 07:40:37 -0400
Received: by mail-yb0-f193.google.com with SMTP id k124-v6so4510807ybk.6
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 03:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrunpNIf5xTL0J1ZyQPWnIvkKZBkItVngeWxmMEeFZc=;
        b=TwrtnNfF81Ty51tHrMzskNURpDuH7M2JwkJEYHq7t1AaeOlN0uVmA5jCng4+glC29I
         Iga+fmmyADly6QNm+yyBZ2ixkrSx3B1EYl2oCO06N8fS0FloK6KR/yc7GNfxzFSc2jvY
         uEbzfRIUzDc1H6l/Wz6EOIDNcO/EyHWQCHNrtdxUCKZlpeIzbWuuylH4tiVfY7QyYcXs
         fkkQD5ddjXAmkbPMDBGlFxVCyrdxfEolPIh2Zi2g3EPnsMDgXC8g1lnk/zbR2zDwOmf/
         hPv3XS4Zq/lYtJxfTpE2eZR+nUev1OKPuHw0z3edMHDrHqlrHzZ9FyGUwvSV5rj/wwUf
         /JBQ==
X-Gm-Message-State: AOUpUlFew1Xa/AdO41rA0woI9Ok62ZuHqbjMSba0DWa9qzQKr3ZgHBus
        fZvlyIkDtdtaw58vYzRujEBGiEa4l7dMuRbYD9vGvw==
X-Google-Smtp-Source: AAOMgpegi5REPkbEdAOP95edzFFBzEw64qA9kptAawkd0Cfmtl2IDugzcpl8h7jcqsWuID6NW0jRRuGR6fcKgCew044=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr8795573ybd.497.1532945182638;
 Mon, 30 Jul 2018 03:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180730092929.71114-1-sunshine@sunshineco.com>
In-Reply-To: <20180730092929.71114-1-sunshine@sunshineco.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 06:06:11 -0400
Message-ID: <CAPig+cSYPEqapdQ=7zjW-RsM6XxCw2vPzZzV32uh_SgO4cQSog@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix "rebase -i --root" corrupting root commit
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@talktalk.net, knu@idaemons.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 5:30 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> This series fixes bugs causing corruption of the root commit when
> "rebase -i --root" is used to swap in a new root commit. In particular,
> the "author" header has trailing garbage. Some tools handle the
> corruption somewhat gracefully by showing a bogus date, but others barf
> on it (gitk, for instance). git-fsck correctly identifies the
> corruption. I discovered this after git-rebase corrupted one of my own
> projects.

Unfortunately, after sending this series, I see that there is
additional corruption that needs to be addressed. In particular, the
"author" header time is incorrectly prefixed with "@", so this series
is going to need a re-roll to fix that, as well.
