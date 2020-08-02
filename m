Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90969C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D49B206F6
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 16:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbN/BIGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgHBQLb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgHBQLa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 12:11:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC62C06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 09:11:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so32055381wrw.1
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+WcJB3H/BYtM1sN+8yVYSh7V1eUPgPjzzfc0OtHhsHo=;
        b=XbN/BIGUIArOZzQ/21d8u0wyO2eWOpMGNxLfNP40m2NvwWBjaOQ1iaJ4W034RLns27
         iVHtnRFxeTJRbQYOHNBhJm1c426TSmbaUZjZaQHa6grZ3WCEYakSqZfpeNj4Om1skEax
         ca4mu7JreJyWId0HwLLjF1hoWazSBuEGWhNMjgGwGwbwXM14cohBPtYMkc0oUDbaZk6B
         mSUqnYDUWJ4EP+bcFcSRnJDYtrwnoJinLZ+ZUn3fT+K9dNy26P6zRjPH78K1q+531b0r
         A1Lf7oYYbNWjKWG5Nh57fq3DaOIRFPKoFJz57ZfSqyQ5tYMXNgtBLJU1Vu+QjPKwkxZ3
         vdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+WcJB3H/BYtM1sN+8yVYSh7V1eUPgPjzzfc0OtHhsHo=;
        b=GxusKPymxp9r7nVkvrpWrXV7/Dh4i+cJyozLeICoMJnExNf6+XxdtaalSn78XvpF8u
         9QsPFFaYiH/j2nhDS0AnOC2OjdxP8KH7HsgKMP/h8DpNY2ZrzbQWN5fcw72U8wa652+e
         LYkWZNpv52q9tL26fiKSlFZz260BiJb2NwHaFKA6HFiXFCkKkLaR0KDo4GYQpKHBEUxs
         kmb9BPrE3S7fXWlRThPgJQSJunGpn3rzmZUnaKZ8t4plnFdX6HNRY0yvCd9FiHDGNa7D
         JynYPvVyXFB7KKkaBT0DIxms+NcIRe9dGIG8xTJLGDGRutsRaBA42y7kpdHVqAl/k5ph
         Sj7g==
X-Gm-Message-State: AOAM533Vh85v/f+xlZzZ7NGTrHZodw82B3V6mydGfPkrlC2Gbno9Jn6j
        goCmZK8sEY2GTTqARui3WCOzmXBwjdvJoeN0WNU=
X-Google-Smtp-Source: ABdhPJwTAqo5ZkqljvxjEjV6OJN7GNhWL9mY5FHikNXcA3FWcg+sWvnJiNevx7BGjmjLuvSk7iKrA3YBNLS5Nfod3zw=
X-Received: by 2002:adf:ed88:: with SMTP id c8mr10875445wro.233.1596384687563;
 Sun, 02 Aug 2020 09:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
In-Reply-To: <c5920e08-b7dd-e870-f99e-225d0aafc663@web.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 2 Aug 2020 09:11:17 -0700
Message-ID: <CAPx1GveChRzsA=FayzhZRSQLPz+o1Po3-_9ZvAGLPztpH5Jg9w@mail.gmail.com>
Subject: Re: [PATCH] midx: use buffered I/O to talk to pack-objects
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 7:40 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> @@ -1443,10 +1446,15 @@ int midx_repack(struct repository *r, const char =
*object_dir, size_t batch_size,
>                         continue;
>
>                 nth_midxed_object_oid(&oid, m, i);
> -               xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
> -               xwrite(cmd.in, "\n", 1);
> +               fprintf(cmd_in, "%s\n", oid_to_hex(&oid));
> +       }
> +
> +       if (fclose(cmd_in)) {
> +               error_errno(_("could not close stdin of pack-objects"));
> +               result =3D 1;
> +               finish_command(&cmd);
> +               goto cleanup;
>         }
> -       close(cmd.in);
>
>         if (finish_command(&cmd)) {
>                 error(_("could not finish pack-objects"));
> --
> 2.28.0

Here, we don't have any explicit errno checking, but
of course error_errno() uses errno.  This too needs
an ferror() (or fflush()) test before the final fclose(),
and then we just need to use plain error().  Otherwise
you'll need the clumsier test-after-each-fprintf() and
an explicit final fflush()-and-test.

Chris
