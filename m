Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14662C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE45060698
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbhH3SFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:05:14 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:43941 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhH3SFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:05:12 -0400
Received: by mail-ej1-f51.google.com with SMTP id ia27so32985252ejc.10
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 11:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=998QvvvAy0C0TjG1GbVcR0OfjDiTfTN1YfF9iB5rUbQ=;
        b=jA7oL73y0kYkAe5Lw2OvbXZGUIcooK44+fFFD3kqygD3X8L9+LjJPQFmXCK3Qr/OlX
         M36WHstHCXa/bbLtHi8j9JG92FdPQcGtE/jyyyv4pJoqEHmrk8BkpAgyyhmjSytd5P2z
         RDay/W2Qb1CBb1qo+GTCY9fdzNn669E7VvrEfXIP1Q+EXyTFhRx9juuWKyZE7KOiLPN2
         r5qwP4TvU1yKFEJLVZj0U6zNObInjiTPom3jb0nWI1jotJEr1rcHLxqFJdEd4ganApKK
         Zk12V3iim7lnebuAv9+oYZjw5Xdh/LCn5owfv+jrzDFRXVcMyI8K1gqUvnAXqCrRdh+r
         ji/w==
X-Gm-Message-State: AOAM530SHRIFbbaapho9eENz7ArdU99oDi1iZAjSvEGxvcsWyR/Z3XVj
        Z/9MU0PakF3rCtqL1QG8LcNKkPsn0o7TSGnpvEo2G2im
X-Google-Smtp-Source: ABdhPJx+2MJ8bBamSby60jL5thevvXlGscZ/Zed2ALamLe/QEL6ql+zWs73StY+5wijtRu5L+Dv2+4wVz9gl94UFVFM=
X-Received: by 2002:a17:906:6808:: with SMTP id k8mr26939242ejr.138.1630346657955;
 Mon, 30 Aug 2021 11:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210830072118.91921-1-sunshine@sunshineco.com>
 <20210830072118.91921-4-sunshine@sunshineco.com> <xmqqwno2505w.fsf@gitster.g>
 <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com> <xmqqeeaa4y0v.fsf@gitster.g>
In-Reply-To: <xmqqeeaa4y0v.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Aug 2021 14:04:07 -0400
Message-ID: <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 1:56 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > [1]: I suppose mechanical extraction of notes may be one such
> > scenario, allowing for simple-minded (not necessarily robust)
> > extraction mechanics; i.e. start extracting after the /^Notes:$/ line
> > and stop at the first line not indented with four blanks.
>
> Yup, that was what I had in mind.

In the general case, such an extraction mechanism would be far too
fragile since there are no guarantees that the commentary in the
"Notes:" section hasn't been hand-edited after patch-generation.
However, it's certainly possible that such a simple-minded extraction
technique might be applicable in some well-controlled development
pipeline somewhere.

If we are worried about that, then we can drop this patch series.
