Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E3B801
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719892103; cv=none; b=CD5dTftluJ8a0pcvgjMLZxC7OoKpbo/1p+L6N7qxSaIgbx0Oz9QbfhMY00YGM3F+PaRM/whdf4MbRWL2BlVFPRkqerlZoO3N0USAZBaJnf2qrNVa7fdJZRN9G1hfwywYolTC+LWE70zuiPDAayUQjwgfGarrhkvFa709cZUzQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719892103; c=relaxed/simple;
	bh=VhVlb8j/fqhFnIHRLa8P6BS1/EYBrbOL1/pbk0yvwEk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lCZm5RFECLjTCjfPN0oK7hADHXEUjskz+IGB4BKhxH7OHjNt05K14IgecmfSx4ECVQHMrlrN3PPTQYKPbHB9N3d6m9zXE59CJHOqu8dg4HW86B1FmXefod4bmHxnC+ZTaadCrtLAR9k2q2cNOVHnDegQrYbEF+yksbuwBmhwz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULDgqK5Q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULDgqK5Q"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so20088935ad.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 20:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719892102; x=1720496902; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDNEMneNDonnsh3uv99G8ZBYVuHpDMfVk51mZwWpcW8=;
        b=ULDgqK5QQGtfxH8A+5kFwSX4bPHHAu1HmmrvNustwAHNbVz9bPY4HMG/aYxvEMeq2d
         v/Ewgno4y+pibHo5R6WOWKgSN5MbYdr3essxUB7TuCR6g8vjElPU88pcEe3eylbLg9Ad
         PHzU6fc9C+bZoQk5ZYMPwffE5QylFZDyDzkm8Ex1PcHppMJPNQ6SwxiW/O91E6j8wBtm
         0Q4Hj9sgNkRVPjlz1eWct//4ooA3puu7ybnJaCJeBnHqb4tdI8TvPViMpwC8PIqe1Fyv
         0XSgtoJhNaH3vMr5R0FUx6hrNHjk2MmWQrU8z8/qf/ISf3Ukxrj+cuCV6RZ59FjGBrUc
         Q++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719892102; x=1720496902;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hDNEMneNDonnsh3uv99G8ZBYVuHpDMfVk51mZwWpcW8=;
        b=GeSyEHxI0BDGt5Fp8gl+wy8OKQnbLQSEreeDzDfiGmlxUbr926NyOk1T7bEyniDmx6
         B7Sbd+sSoXcmUkFeUj73cN8UJsZp4IaPceRP3xmQQuklEvJYLi36WUmJVr4sqKXcKCDI
         8BTPeaAMMpYDS7YI69eFNg/dA4XQM0ifC68BaP2tPTFdCi3VP5VeFjK1/LEyT9T6ZqqH
         i/pFC5fX28zqMxuJlPCo2uWZ9C+vJOlJizQT3D6gZXc1bsOWu2Cj8K68Ls026GCXYMpV
         i3RaSWiXxFQWUzYeB6m+JehWAxOowcSoTXdgFkunOAJfeon9g4Lrw3XesrXqAF2jEnsA
         GgMQ==
X-Gm-Message-State: AOJu0YxjV+tvUIh1FaPSkyAOv5vEV5a76Tw0FlON2aBITIqEsiTa2+pW
	ksoPL33V2B4EkLv+ZeaSGs9c4i6Ss5w9WItl8vA6UGkebjblFBujAStb5aBPpYk=
X-Google-Smtp-Source: AGHT+IHz22Z/BDuS7c/jcxVUoJBWV7mg8dI67pdoMD/2t5zSGk7p1bHNA1ifDM3b/DkQJk0op7hzZw==
X-Received: by 2002:a17:902:d509:b0:1f9:923b:259d with SMTP id d9443c01a7336-1fadbd13773mr51619325ad.67.1719892101662;
        Mon, 01 Jul 2024 20:48:21 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568ea7sm72916215ad.186.2024.07.01.20.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 20:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jul 2024 09:18:15 +0530
Message-Id: <D2EQV4ZV3VEW.2CV0OLF3T4HVA@gmail.com>
Cc: <git@vger.kernel.org>, "Jonathan Nieder" <jrnieder@gmail.com>, "Josh
 Steadmon" <steadmon@google.com>, <christian.couder@gmail.com>, "Phillip
 Wood" <phillip.wood123@gmail.com>, "Christian Couder"
 <chriscool@tuxfamily.org>, "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <20240628122030.41554-1-shyamthakkar001@gmail.com>
 <xmqq4j98vmpw.fsf@gitster.g> <xmqqjzi4u52u.fsf@gitster.g>
In-Reply-To: <xmqqjzi4u52u.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Hmph.  You seem to overwrite key_val[i][1] ...
> > ...
> > ... in this test, rendering the key_val[] array unusuable for
> > further tests.  Is that intended and desirable?
> > ...
> > The TEST(setup(t_foo)) pattern is done so nicely to make sure that
> > everybody is independent from everybody else, preparing the oidmap
> > used for each specific test from scratch.  It is a bit disappointing
> > that we are now invalidating this nice property.
>
> It may be just the matter of doing something silly like this to
> restore the "different tests are independent and the source of truth
> array is intact" property.
>
> The first hunk should be reindented properly, if you are going to
> take this and squash into your patch, by the way.
>
> Thanks.

I think this is very reasonable. I'll squash this into my patch and wait
for any other comments from reviewers before sending another version.

Thanks.

> t/unit-tests/t-oidmap.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git c/t/unit-tests/t-oidmap.c w/t/unit-tests/t-oidmap.c
> index 13532aa98b..be2741c6c7 100644
> --- c/t/unit-tests/t-oidmap.c
> +++ w/t/unit-tests/t-oidmap.c
> @@ -14,7 +14,7 @@ struct test_entry {
> char name[FLEX_ARRAY];
> };
> =20
> -static const char *key_val[][2] =3D { { "11", "one" },
> +static const char * const key_val[][2] =3D { { "11", "one" },
> { "22", "two" },
> { "33", "three" } };
> =20
> @@ -116,7 +116,7 @@ static void t_remove(struct oidmap *map)
> check(oidmap_remove(map, &oid) =3D=3D NULL);
> }
> =20
> -static int key_val_contains(struct test_entry *entry)
> +static int key_val_contains(struct test_entry *entry, char seen[])
> {
> for (size_t i =3D 0; i < ARRAY_SIZE(key_val); i++) {
> struct object_id oid;
> @@ -125,9 +125,9 @@ static int key_val_contains(struct test_entry
> *entry)
> return -1;
> =20
> if (oideq(&entry->entry.oid, &oid)) {
> - if (!strcmp(key_val[i][1], "USED"))
> + if (seen[i])
> return 2;
> - key_val[i][1] =3D "USED";
> + seen[i] =3D 1;
> return 0;
> }
> }
> @@ -138,11 +138,12 @@ static void t_iterate(struct oidmap *map)
> {
> struct oidmap_iter iter;
> struct test_entry *entry;
> + char seen[ARRAY_SIZE(key_val)] =3D { 0 };
> =20
> oidmap_iter_init(map, &iter);
> while ((entry =3D oidmap_iter_next(&iter))) {
> int ret;
> - if (!check_int((ret =3D key_val_contains(entry)), =3D=3D, 0)) {
> + if (!check_int((ret =3D key_val_contains(entry, seen)), =3D=3D, 0)) {
> switch (ret) {
> case -1:
> break; /* error message handled by get_oid_arbitrary_hex() */

