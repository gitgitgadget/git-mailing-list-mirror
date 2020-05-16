Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C6C433DF
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5492F20727
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlUTZ7Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEPLO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbgEPLO2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:14:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B3C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:14:27 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id g2so2801178vsb.4
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98Z5OHl2l8HODkB/mh9hgCU0DqdJP76m6PJB80oaQjs=;
        b=SlUTZ7Omi8H6e+5tXPwOlIvrui+ncVBmhOvsaaTuYQdOxYLgZXTj+ePdizG0TPMtXl
         QDjqAlC2/CErV61NWuzRYFRh2Zij3Cyvlo6TQx6NnaM7mXJEKkxSAQeRPZi2bivej5Tu
         Qmfj0lmLjEeo59J5rU21rkgcD7XgfngSlV6f212ed9NWCDR8FMyW6M4tpqZuIhDQ18Jp
         9Dtc91g61fAS0cA1u1+PzsajpNdWtu97eGgxU9eD/ClZnG4emXwZv3JupLaLDI0V7eIX
         UkcHHc+Z0krE0shf9HlY98XuvAR+H3UUaaEP6imkJ+Z6fZxRdGwGAFtlccRkb+NDk+/D
         WBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98Z5OHl2l8HODkB/mh9hgCU0DqdJP76m6PJB80oaQjs=;
        b=RwWoeRr8h0TRwtOOP+p4DNAqBSTyySEvGWgp9MeChffxy17ZyF4TxzU4gcdP1P7s30
         K41prncgEW8cTq+pHowLU1cxKuPdMtmEkuQuL3mziBdfPcdmInQX+4vv1PhkTqwmUOJV
         ZXFVE3B7WBZREyJHi3GyIMO4/DZMm48BtCaT2ZfRgki8REkh47+FOirD4FVHuzxpe0I5
         KxlLA1gbYwwBWuHj6/woSDazPDSvr0lb+T8OsSkB2vXlF3UVdgK1JTrTdHfGbnygEGF2
         ol+A9I5EEAw7gf7jC+LF+AvfFWL/MCgKeWzFAjGuvxB21tNjUH5xqpX1ddELEYvJwTkG
         ZgyQ==
X-Gm-Message-State: AOAM5317sSMFVuPdH21qJhAyO+485UYyzOS7rntd/FOkyhN1n+ildTiq
        xnDQahtrOixsxrGhHR4agth1Kaayi7PydC0ExuUZUA==
X-Google-Smtp-Source: ABdhPJzRXz7nX5Ur7fYKeDUw4u0V6YYkOhOIksqkyn96UP01ouZuFWYFjl7aK1TtVjNWvPPr0XhcuO9KT8LiC2ICd7o=
X-Received: by 2002:a67:ecc2:: with SMTP id i2mr5339605vsp.85.1589627667086;
 Sat, 16 May 2020 04:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-32-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-32-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:14:16 +0200
Message-ID: <CAN0heSpq-t1E6CBsLiVDUE8NYB2ES916MR=d99eug9U=vdOLHQ@mail.gmail.com>
Subject: Re: [PATCH 31/44] connect: parse v2 refs with correct hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:58, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> When using protocol v2, we need to know what hash algorithm is used by
> the remote end.  See if the server has sent us an object-format
> capability, and if so, use it to determine the hash algorithm in use and
> set that value in the packet reader.  Parse the refs using this
> algorithm.
>
> Note that we use memcpy instead of oidcpy for copying values, since
> oidcpy is intentionally limited to the current hash algorithm length,
> and the copy will be too short if the server side uses SHA-256 but the
> client side has not had a repository set up (and therefore defaults to
> SHA-1).

> -       oidcpy(&ref->old_oid, &old_oid);
> +       memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);

Might an `oidcpy_algop()` prove useful over time?

  oidcpy_algop(&ref->old_oid, &old_oid, reader->hash_algo);

> @@ -442,6 +444,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>                              const struct string_list *server_options)
>  {
>         int i;
> +       const char *hash_name;
>         *list = NULL;
>
>         if (server_supports_v2("ls-refs", 1))
> @@ -450,6 +453,14 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
>         if (server_supports_v2("agent", 0))
>                 packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
>
> +       if (server_feature_v2("object-format", &hash_name)) {
> +               int hash_algo = hash_algo_by_name(hash_name);
> +               if (hash_algo == GIT_HASH_UNKNOWN)
> +                       die(_("unknown object format '%s' specified by server"), hash_name);
> +               reader->hash_algo = &hash_algos[hash_algo];
> +               packet_write_fmt(fd_out, "object-format=%s", reader->hash_algo->name);
> +       }
> +

(Similar to an earlier comment I made, if we don't see any
"object-format", we rely on `reader->hash_algo` to have been properly
set up (which it has) and to not have been modified since (which we
could probably rely on, hmm?).)



Martin
