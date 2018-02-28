Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C01E51F404
	for <e@80x24.org>; Wed, 28 Feb 2018 00:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeB1A7J (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:59:09 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:38557 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeB1A7I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:59:08 -0500
Received: by mail-oi0-f50.google.com with SMTP id 123so571450oig.5
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9sqlkX08Vv3t9a0Q7JdUNe1MI/pMvFqtM7kRe6g/TeY=;
        b=l0ZS8vLFkelgKEBw8EB9kskc8jQitNgMBhMxMyF6PxxFUpg22XFf689sqsPJhvToAi
         liQR7aifLVPyi4mbgf0AvFXl70ps0BMdsxX4olZk2s4ueQwvzOhuSJdjgGG+F8KbVIUx
         Vi+y+HE1e6OgN0LIM/hs32j2U6eckS9FjAkyq1jKojUZ4uZs363aECs/4CWqTKSrQbsP
         Nkl/1i32Eb8IdgCQ7RrxieCvonM7lYLTPL7TWDl5CjeI+wMXxTnnkqSEB+40M9oXfrDQ
         3Ov/nYtBT0h7GoULuq+PDfsyb9n9QlOIO0kgQ4m7cl/vQ/wH2qJs5YuoSfndgLA8LhMw
         KKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9sqlkX08Vv3t9a0Q7JdUNe1MI/pMvFqtM7kRe6g/TeY=;
        b=Z8HEfiJvwdzW09EXlcTQkH9kILq5uzEO9BXm3fyrOaxlWaOW5tkZBIUaGL7ujLhMbt
         SZJOMjhEeyqgOrjLVnvsNBvTTe/tWuBAoelBYo6RuWunYUWECSTp33zZwzmvFQWPCpdQ
         3nyUddcInx2nL1gqxvYg3Pu6USHqsApfHwHmKeEMRVyNsrho6XpU7IWVFg8HC+D3zQKB
         XkVijcT51xBz/hyZcue1RMhkHHUczx5NdO2ZbSchJP1uvP4yk0vmM2brB7OzC2kxY66Z
         mBA7MWNDyHrR0uPuFtmpNkJvnvYKh0g3EydpZHKL8qVYH2wwOK2j+GDa3KNdLIV+Pab9
         SSpg==
X-Gm-Message-State: APf1xPCLg0yEK0RQ7X4TodWiI1PRPWEZ6jsW2xfBpsXFAMjNmE1QUMuO
        LtJGBdzLBwNS8+af48wtwLlO691XKXqv+EyLRNQ=
X-Google-Smtp-Source: AG47ELuSyD3TAdW4jOsOGaoy2IHQD/iXxGmmjQkHvfUJYVEO3t1umcuYDx+oyMYxa1I6zJhTDgwE+hqJXs10UvlXtzE=
X-Received: by 10.202.206.71 with SMTP id e68mr10780248oig.34.1519779548014;
 Tue, 27 Feb 2018 16:59:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 27 Feb 2018 16:58:37 -0800 (PST)
In-Reply-To: <20180227201250.GL209668@google.com>
References: <20180226103030.26900-1-pclouds@gmail.com> <20180227095846.9238-1-pclouds@gmail.com>
 <20180227095846.9238-4-pclouds@gmail.com> <20180227201250.GL209668@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Feb 2018 07:58:37 +0700
Message-ID: <CACsJy8DhZLo2KsA5uYoqJvmJXPz3Gri7Vcpi4huG5pNQW1xLUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 28, 2018 at 3:12 AM, Brandon Williams <bmwill@google.com> wrote=
:
> On 02/27, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> diff --git a/repository.c b/repository.c
>> index 7654b8ada9..e326f0fcbc 100644
>> --- a/repository.c
>> +++ b/repository.c
>> @@ -61,6 +61,8 @@ void repo_set_gitdir(struct repository *repo,
>>       repo_set_commondir(repo, o->shared_root);
>>       expand_base_dir(&repo->objects.objectdir, o->object_dir,
>>                       repo->commondir, "objects");
>> +     free(repo->objects.alternate_db);
>> +     repo->objects.alternate_db =3D xstrdup_or_null(o->alternate_db);
>
> Just a note that this only works because the object store is embedded in
> the repository struct, it isn't a pointer to an object store.

It is possible to make it work even if object store is not embedded
though. From my point of view, this function is about "give me
$GIT_DIR and optionally the where all other parts are, if you ignore
default repo layout and tear the repository apart". We could
initialize the object store later when it's created and pass the
relevant paths to it. Exactly where it's safe to "create and
initialize object store" is harder to see now because the whole main
repo setup is spread out over many many functions.
--=20
Duy
