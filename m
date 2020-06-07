Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE0EC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 05:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624FF206D5
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 05:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqFBGJk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFGFyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 01:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgFGFyS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 01:54:18 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169DDC08C5C2
        for <git@vger.kernel.org>; Sat,  6 Jun 2020 22:54:18 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l6so13728297ilo.2
        for <git@vger.kernel.org>; Sat, 06 Jun 2020 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PkzCUxQQr/xQfgnMBdZkI9A0N2sU3Vbwf4WkVvbqA4E=;
        b=BqFBGJk5uUMaOn6UX0K4gD4jlzV2ccSt5q7JtZ+MkVue0KZZBdLfayCrXxfu+GALg0
         6W3CGhqc491nPZnlryQ5Wy74ws3dZdjqmi9lWP4SG1RaNpXytjBSAYzOsFq8ASn61OG5
         DRCp+Ls/q2aIgonql7q8DjzA7T9v4/OdSbUTR0o7CQBVwFCEwbhj7G1pZL/1AlnB9K+v
         H7w7PH8pLz/+XO0AuLwHwFcTIC+JQFNB4OEfqkIvXGJ7WsFexo0EA6XmL5xVB2ShJ4Yc
         oh3sNLQxGHdPTTXoJJE2bNv417aJlfdX8yKT5YFMy4gAnJBwzQEW8BUJVac0X2TejhZP
         dRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PkzCUxQQr/xQfgnMBdZkI9A0N2sU3Vbwf4WkVvbqA4E=;
        b=YkZJpbL2MRMUcMKPGApI0TcKJ+5vVCE0YH9ZtFdmuEu5Ww8l4NPZw90dmomk5Isspe
         Xw+aHjNZBCqfGvpIUt8kqZ6r5YPTO+n/GvyM0s9dEFN36ywZ/jN0CxT+XlOF5OzBDfcR
         GYVQqJpADk9/J2t76gG5RrSwoXoJ5zW7iigZYCvshkEMK6v8CWo/SsLRaRStelOMSkpJ
         radA6bOzcBAPNYmyORijMfounfYI9BR+/KStimTCltVsRQ1RDV3jAuQXWwz+4dcV6Uxf
         q0mief53FD9vlwaLu1ny8vH9c/4kPl7Iy28+qUx1GN1DbDtEUJlVHaPPIkKSvP2Ft3yd
         apoQ==
X-Gm-Message-State: AOAM532LWpDUBKuXWHk7OOgNQ+s3uVbrTMm/UyqIqK+guMy+T1aZOPHB
        mSUaSizvddqohZqUmy/iWzBKYDOvroJSRF3jF3IBDaL6mfg=
X-Google-Smtp-Source: ABdhPJwnVXH9vCGhQqKC07vROjQGyq0lGz9iVfkkn6szvfvk0d1xQsE3s+/ocLEvKZzkQWm+AW1d5YCO54TzJESmAv4=
X-Received: by 2002:a05:6e02:cd3:: with SMTP id c19mr14190006ilj.102.1591509257222;
 Sat, 06 Jun 2020 22:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200607054849.1014185-1-eantoranz@gmail.com>
In-Reply-To: <20200607054849.1014185-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 6 Jun 2020 23:54:06 -0600
Message-ID: <CAOc6etZGw5SUj_ijWZtDjN44i7WLMKrUKALCpmfPAPxZK1c-tw@mail.gmail.com>
Subject: Re: [PATCH v1] builtin/checkout.c: replace bit-shift values for
 macros in call to check_stages
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 6, 2020 at 11:49 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> Currently a call to check_stages is using bit-shift values to define what will be used
> as the first argument. If the reader doesn't know what the values are from heart, they
> have to go dig in cache.h what each value is.
>
> This patch is replacing those values for the macros from cache.h so that it's
> clear at first sight what they are (CE_ENTRY_REMOVED, CE_ENTRY_ADDED)


The macros are defined since at least v2.1.0 and I am able to apply
the patch on top of it. Should
I send the patch from that version? I am sending on top of v2.22.4
cause it's the oldest version I
was able to compile successfully.
