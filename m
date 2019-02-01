Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4612C1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 09:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfBAJAP (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 04:00:15 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35439 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfBAJAO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 04:00:14 -0500
Received: by mail-qk1-f194.google.com with SMTP id w204so3582824qka.2
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 01:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyqLmevbvMIgFDcx0qOZlPn82jScKvUv2I5YwSQBO60=;
        b=jSIddkg/OFY1oKTOADan9/+qXATSIMEQWAMT/InnLQx0EgrC0A2rX5XYn9KLCO0k+1
         Axy53DwmFfUorBSNWEjqjZfZPMlwFv0zJIFrGPrbcFzdczOS6UrHueBR9erbCLNE/K06
         exGcAxm/brjxVlPbKmCs2iJVRVWoqJyofg3Roe0q8X/bWOtU0vtlfPxPCTunMPie0d1f
         67UNyMBvRuN8jf7Zen2egmR1Mo9UWqa6/2mm/BourG54OpLZPv3Z951qDXRkhgD8BxqO
         xm1+rXhukZYenys3kXUPWhd3Wgu0yAC0UBb30s6EB76SL7+JW0mJ2eKIjxZeBR28141X
         EY+Q==
X-Gm-Message-State: AJcUukf2Zn3T1AZyZ3jHc6Ls8i86lGBFiJVBYgDPEUP854kp4svtzXNp
        A85sSrFW0ToHKKuM7MDZ1CEWrcK/2JB/OtzG4oM=
X-Google-Smtp-Source: ALg8bN6E1Veq6Rp9rvqsrj9SsEkrpWz1OFng13wc4mvFVhXlq9bGY5L+tuKbXOVqs0U4n5UuRKI3pzHLlPYY7vFkg+w=
X-Received: by 2002:a37:5e42:: with SMTP id s63mr33634979qkb.220.1549011613804;
 Fri, 01 Feb 2019 01:00:13 -0800 (PST)
MIME-Version: 1.0
References: <01020168a8338064-b1c054c4-3e05-4825-b8dc-636d9c63dcfc-000000@eu-west-1.amazonses.com>
 <01020168a83380fb-ecad8400-915d-497c-841f-096541747cd6-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020168a83380fb-ecad8400-915d-497c-841f-096541747cd6-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 04:00:00 -0500
Message-ID: <CAPig+cTEZVt13XBQ9z7aQp0PAZQbN5xRm+PC16iSNNr=G473YQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ISO C90 forbids mixed declarations and code
 [-Werror=declaration-after-statement] so fix that.
To:     Shahzad Lone <shahzadlone@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 3:36 AM Shahzad Lone <shahzadlone@gmail.com> wrote:
> diff --git a/pack-revindex.c b/pack-revindex.c
> @@ -186,9 +186,9 @@ int find_revindex_position(struct packed_git *p, off_t ofs)
>  struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
>  {
> -
> +       int pos;
>         load_pack_revindex(p);
> -       const int pos = find_revindex_position(p, ofs);
> +       pos = find_revindex_position(p, ofs);

Thanks, however, this code was fine until your patch 1/3 changed it to
have a declaration after statement. Rather than creating a new patch
to fix an earlier mistake in the same patch series, on this project,
the proper way to resolve such a problem is use "git rebase -i" to
adjust patch 1/3 to not introduce the problem in the first place and
drop this patch, and then (re-)submit the patch series.

Also, your Signed-off-by: is missing (see Documentation/SubmittingPatches).
