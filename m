Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267C01F461
	for <e@80x24.org>; Mon, 26 Aug 2019 00:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHZAmf (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 20:42:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37492 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfHZAmf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 20:42:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so13633019wrt.4
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 17:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPUaGQ8UaufaiJG8HD3ojLbGyv4aED5KRuXU+wrByy8=;
        b=g+XSpB27UU2VuwX+0UF1VdTccaYNyLDijP9ncmuFsPh/92+94rIWY6g+REL7IHZfF7
         Xv9W7yoK73WiqwDbr0/BxrQr4swQuk46yLtD/2JRMWJg/27dRGcCz3ZZAoTpb15cS527
         +V4mHRDf6B9z+sgIWlhcwTjQ0YOvq3qiYkHqX+/vR817wGdE52TDYU317AnKuCgmERXq
         hfrbWQgNG/I1W9jA9igVQug+6MD/ukTypsbkXU0HI25boEoSSPL0c8VLZAUD+LNW35cp
         30ZUONJaKNMXjsItPs3UjoXUqbylcVI4qHqA8U4E3vakMTVtkDyaAfp/0DrPcDNgDi5S
         I70w==
X-Gm-Message-State: APjAAAXtzNKqNS0shdstI2F16JyB3YgVi1p8QDqx/cCnR1B1HLyBdvbb
        DvQ7oMjNgBGeCgiRracJC7ljv6l+p+Gfol+jxK4=
X-Google-Smtp-Source: APXvYqz9ygLk+Nr5OgzPGaBMqzPrLDfTOHWVCNTwt6fkrLxUGmgLLzLx4r4rkKEIC5YO54nD1WPjoaAgt8eb1RceIp8=
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr17704786wrt.278.1566780153684;
 Sun, 25 Aug 2019 17:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566285151.git.liu.denton@gmail.com> <cover.1566635008.git.liu.denton@gmail.com>
 <7d9a24a97972ab8a8a1cfe1f2605630e154886be.1566635008.git.liu.denton@gmail.com>
In-Reply-To: <7d9a24a97972ab8a8a1cfe1f2605630e154886be.1566635008.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Aug 2019 20:42:22 -0400
Message-ID: <CAPig+cTBzxbEOo2tBOeTiYM8njDuAVTdBzATtPUmA6uMni4L-Q@mail.gmail.com>
Subject: Re: [PATCH 08/13] t4014: let sed open its own files
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 24, 2019 at 4:27 AM Denton Liu <liu.denton@gmail.com> wrote:
> In some cases, we were using a redirection operator to feed input into
> sed. However, since sed is capable of opening its own files and provides
> better error messages on IO failure, make sed open its own files instead
> of redirecting input into it.

I don't care strongly one way or the other, but the justification of
"better error message" is rather weak:

    % sed '/^$/d' <foo
    sh: foo: No such file or directory
    % sed '/^$/d' foo
    sed: foo: No such file or directory
    %

I doubt it's worth a re-roll, though.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
