Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9420620248
	for <e@80x24.org>; Fri, 22 Feb 2019 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfBVUi1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 15:38:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45258 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfBVUi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 15:38:27 -0500
Received: by mail-qt1-f196.google.com with SMTP id d18so4002463qtg.12
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 12:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhS1UN5KrWoXTUvkg3xyp2nUhF8JZHFXrQk1edbd+Os=;
        b=Qr2joLUHdbZfLiQJxlab7ZvK9mip9L5qeDquVCT26O7L2PUomVVNDusSnSmY51HId5
         YEXZiuVafVHzI8wmsd4M0uxbhZA+vJIKDhMfEZ/GI9rUaompZv84TuXP+B8kQcB7Jdgk
         IlNTUZVy29FzkB7ASA3R3qF63kH8E2+xJwEP4FNimRi12LM2KiJLeh+iGcYoOWefrw9I
         0VRlzwrkKFr3dMAcq95pJNWlE7KUvRi4DJjmpbSkaSL/6UKiO0ogwWHcWaMfJ6dE74vC
         bE0nEwUwi5wablU/l3GWtOmosgCKgYCJQGf26pxVzNI7ebUDN7ivn8sX+Sp74+AFuazO
         YavA==
X-Gm-Message-State: AHQUAuZD9VvQPhKtaGqIZ3/vku5fJBUzafphlSuBYlgxG+O7AXbmm6fb
        ngWdEiTEz9qyesgyNDI4Nw0rj3bo83pVkfrTSzk=
X-Google-Smtp-Source: AHgI3IYbzJakIWsA/ddxP9KP8/ubUEr/jYvfpj4tlbWqotHn4MSvoSV6eVf7iLj0inb0I+66JUzTGCSwSWw237YzJEM=
X-Received: by 2002:a0c:92b1:: with SMTP id b46mr4785968qvb.184.1550867906428;
 Fri, 22 Feb 2019 12:38:26 -0800 (PST)
MIME-Version: 1.0
References: <20190222201111.98196-1-gitster@pobox.com> <20190222201111.98196-4-gitster@pobox.com>
In-Reply-To: <20190222201111.98196-4-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Feb 2019 15:38:16 -0500
Message-ID: <CAPig+cSsONVNHsG+8Q5yZ9PU1=5059RKXBS+Ps5wX-5BihqPew@mail.gmail.com>
Subject: Re: [PATCH 3/3] format-patch: --no-clobber refrains from overwriting
 output files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 3:11 PM Junio C Hamano <gitster@pobox.com> wrote:
> If you keep an output for an older iteration of the same topic in
> the same directory around and use "git format-patch" to prepare a
> newer iteration of the topic, those commits that happen to be at the
> same position in the series that have not been retitled will get the
> same filename---and the command opens them for writing without any
> check.
>
> Existing "-o outdir" and "-v number" options are both good ways to
> avoid such name collisions, and in general helps to give good ways
> to compare the latest iteration with older iteration(s), but let's
> see if "--no-clobber" option that forbids overwrting existing files
> would also help people.

s/overwrting/overwriting/

Meh. I haven't particularly been following the thread, but this commit
message doesn't necessarily provide sufficient justification for
further bloating git-format-patch's set of options, its documentation,
and implementation, not to mention potential user-brain overload. With
the possible exception of a 1-patch series, anyone who stores multiple
versions of a patch series without using -o and/or -v is going to have
a mess to deal with regardless of this new option. (Just trying to
figure out which *.patch file belongs to which version of a patch
series will be a nightmare without use of -o and/or -v.)

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
