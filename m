Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364021FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 21:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755795AbdC1VPh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 17:15:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33136 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753955AbdC1VPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 17:15:35 -0400
Received: by mail-lf0-f65.google.com with SMTP id r36so11685913lfi.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nY6FzwnaP8jg+eKnr+tQgeIonkj2qgiq4ShIC3ySqFI=;
        b=U50dQIqIa6ds0cGJBKnYRhL4Z0TA2w8uwm/twJvnnK9vPM16jCkZX4MH8NIbs17X6q
         NqXQ7G2r+26tKsK9+EJowBf1lDgKHq9dDU2vOkvNR8zv5BUkpj2sIZv3PgVAB5wtGcGH
         pU8yMjpDatm21q8kxqWZSJ59+Zzgih+IkfjBIYZKfHK0emzZuvozKV7CeXUzYZbgsDIg
         XFtZF9+MEVqXJzHdeJWYZzXbo+WJiC55B/yGAvysOGptS7v4DGXqzmId6o4HcW7MRk7+
         0ZR0hTq1fPXI+BHlEOFwM3jZ3qfQ7W+11sSaY+jQI/ueoHNC3r1hBH7uvAwyL8wa3bxb
         G4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nY6FzwnaP8jg+eKnr+tQgeIonkj2qgiq4ShIC3ySqFI=;
        b=O1lt8PacjE4QZvcyaZMyzeWuP7DcuiGx7o0YWhwBYIbJA/BfJmXe28sYT+prSRiy0/
         guy0U2x3GqIBd2RRhqafKdWPsJg1uQFXHrMv2PJq//wfmRiftuRb5xPGY1WOiqBfqEKi
         LcTDg94YIS0w8cNToqonMBIBlSdwUDV9sw/21vE4YfKAHEOqtnxE9o/XijqRjUDN1Muy
         Ku9yQxOpCHgHb8BzvZ+fqcvLJ8KG5t1nkx7dGjBid66AeNs1srFilTxWwmpYrX0Xd/q5
         BnQa9q+VcVpbtjPtDbQYUOe24j5zR4HdF25KjY5GxfYpHOHGhv9N4DYbV0BoAxblM6II
         Zmfw==
X-Gm-Message-State: AFeK/H3iq71qarorLLxXSqySHN0JKYe0cQFDHd8vnmF9F0aqqDxFY6Nw5o7PvRK9OfethOy/de7BiI8/ilYJCA==
X-Received: by 10.46.81.18 with SMTP id f18mr2271164ljb.136.1490735713507;
 Tue, 28 Mar 2017 14:15:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Tue, 28 Mar 2017 14:15:12 -0700 (PDT)
In-Reply-To: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Mar 2017 23:15:12 +0200
Message-ID: <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 26, 2017 at 3:43 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> FreeBSD implements getcwd(3) as a syscall, but falls back to a version
> based on readdir(3) if it fails for some reason.  The latter requires
> permissions to read and execute path components, while the former does
> not.  That means that if our buffer is too small and we're missing
> rights we could get EACCES, but we may succeed with a bigger buffer.
>
> Keep retrying if getcwd(3) indicates lack of permissions until our
> buffer can fit PATH_MAX bytes, as that's the maximum supported by the
> syscall on FreeBSD anyway.  This way we do what we can to be able to
> benefit from the syscall, but we also won't loop forever if there is a
> real permission issue.

Sorry to be late and maybe I missed something obvious, but the above
and the patch seem complex to me compared with something like:

diff --git a/strbuf.c b/strbuf.c
index ace58e7367..25eadcbedc 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -441,7 +441,7 @@ int strbuf_readlink(struct strbuf *sb, const char
*path, size_t hint)
 int strbuf_getcwd(struct strbuf *sb)
 {
        size_t oldalloc =3D sb->alloc;
-       size_t guessed_len =3D 128;
+       size_t guessed_len =3D PATH_MAX > 128 ? PATH_MAX : 128;

        for (;; guessed_len *=3D 2) {
                strbuf_grow(sb, guessed_len);
