Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11701C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91DB206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWVv+p1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgEPLNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEPLNv (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:13:51 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DCAC061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:13:51 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id u12so2817490vsq.0
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9bFktvTO3s5weQbl6XkwviqtagcEkZ+zL9jV5eKbl4=;
        b=VWVv+p1vNgWg48grQ2C2zI/afbYqxZT8ZucBqe71AxhKVvwNBatiTWGF3BvFDbDKNK
         vYZbDSGs5BpiJwJ5XKTShxYP7/ZsYDX6CkL7ExzDfgRxIjqFkZsNB8ESq/O8TbjYjsu2
         q2CkcNDCivLmUBrg75UnDQC53UXOUT+obA8Nu2VhOylu6t2MT3D43IAx+seLFcTkL07j
         tGQenzMfa9PCnd0aNKHTI2tz27WattmgfChnXUkpZM0hR/aeTEhyuWorpCrInOVpO73V
         pOK+fR99dKxkEjOtpF1y/uthmjbsuZiJrz8c4dxGaJbY997Vg3Gr+XRMI/h8SvD+jXww
         sVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9bFktvTO3s5weQbl6XkwviqtagcEkZ+zL9jV5eKbl4=;
        b=Hrnd+DnobwAJjSDKRmGBnT8MMVNtF6CYmfVYvFUZshOemk6iwp5ozjVUxUjlrqv9+N
         rcrkmsVpQ6Isj/NDAMn9i7SmzsLMkTVZmasTWyosIgVPfw/3cscKYzlyQmPYlI9NZzPJ
         OBrUYlbtdouYcTyr2Z1hbMFS6h5f4wvSfTjaUO/RVZ/P8ktgmNDz02U0iOZhqjWsis7A
         GH1r2OXx0SY4sr5leCwM5BgrknBA7faQ5kiH9vtagWZIPfn0p+WWUlelIMoSns9qXAkN
         eAAFmgVvEUo/0mOR2X8jMnKWGg+XqgbKPDloH6Gbj5H33a3oq4DkgCYyd6ZoBx8KV0Mj
         Kv2g==
X-Gm-Message-State: AOAM531hqpc4SxeGfJbZIlbmCTpF/XT0oNQ+jV8Xo4G9HWk9qk6xdSXZ
        fhBJILKx0Itm72JflnHrqFhL09p8v3AiotNei1w=
X-Google-Smtp-Source: ABdhPJyX3idhpR1reXDhZAhHA6NSeI7QE1B/WtUVYrTUJJlV3QB22aziUpiz2SKV//+DNpep1GOUlsKfS97RrB4vgog=
X-Received: by 2002:a67:ff14:: with SMTP id v20mr1215083vsp.118.1589627630096;
 Sat, 16 May 2020 04:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-31-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-31-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:13:39 +0200
Message-ID: <CAN0heSqoGVAbfnDAG+PKnuCa81F=euGCBnf6Vk=a7wjvNc+i-A@mail.gmail.com>
Subject: Re: [PATCH 30/44] connect: pass full packet reader when parsing v2 refs
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> @@ -466,9 +467,10 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>         }
>         packet_flush(fd_out);
>
> +

Ah, this is where that line from patch 2 went. ;-)


>         /* Process response from server */
>         while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> -               if (!process_ref_v2(reader->line, &list))
> +               if (!process_ref_v2(reader, &list))
>                         die(_("invalid ls-refs response: %s"), reader->line);
>         }

Martin
