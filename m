Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D8BA3F
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937556; cv=none; b=cDKh2IUSyeNF6lyHsw7SamsEBU99Xn9t6rMp+iUNzEqo7upKZr3dPL1LVaB4yuItwEPHyh7QLFjfP7uYvTophSPyD67xHohEaF+PrxEphRZljV4zwzoKBkmBx3wDMTrwM7LYDNBOoRF9s12V3964f0QE2b+nCADKRMf5o8vo1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937556; c=relaxed/simple;
	bh=+MPhcbWIzLj3WVn10osfjIo8L5dKbwA+Poo5BPqskdg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=prc0mprm7a9qHhD3eDIHZt2aFP1W3wps6eqXO06agXvEQOVKLpk9wsgQn5qSdbQLDEmGo2U1zB6QxwpG8IB+9tT1o1d//XLtx3dVMdYD9WyIuDat3S1UURRe6ZflKZAzc68xjYp21c5cZEjEUg+i/wLNqf8tpU43p8MK0h2jtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcuqYy5t; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcuqYy5t"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706524adf91so3592851b3a.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719937554; x=1720542354; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+8HkjdjI0qFuJ1hdtMwvAPtoTgnpyX8Mh9fX37R5tU=;
        b=IcuqYy5ts44KXBOvZRGYfxVP3DZO9HOcJJCXcEhFtLKhUrKKxusl+DR4o15Zre2zPY
         vnCv1tZ/TN9TbJY15R1TUKHaqnXJevuMBbWJjBSQkhA0wIGvjUtN2RBSQIPa5FYOpytA
         KiKA90VMAjr6EcTlvRWgXzRAZNdfNc8MJWEsUkSoyHr0k/gjp7vgexldbGJ2FELnvWHt
         kwCX/L3XBpAZ0ayhPo7Y9hCzuK7mU/3z9OFJSPk8+HH/YrR/jgaLbKuquoiHmOOMI8iL
         YMe6nZmBzv9foeGM6LatxgpYPTfunrF3wogonoMlE0eeOZF7H/MH3YZnq7CZZCPRdgge
         ln6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937554; x=1720542354;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+8HkjdjI0qFuJ1hdtMwvAPtoTgnpyX8Mh9fX37R5tU=;
        b=Pe50HIJ34KFDS405DL6DMSt6VIkI823xj1ROw5Na8Sg0obNGW22ev7teFuQkplUoUN
         NZe1NgvB+DSH5qb6sEtntpwMNFcCIiGbvEUGBrK3aStLPQCe3o1VnmtS1a7WQd9O1ukm
         jpKuzuzts4HgSEpzN5/aIjcrDm3nK/xRRBISy5r9iN2hWDQwSx/QWLEBbT5XPGkoaqCU
         FFG1oETXLpIYhlOYO+XnxKgfax1x/7+9/e9JBp654vdMhIrhRwbB8uSKYLWfoo9fdBKh
         oYA70eNcnqZwrJDDq/6SlORuZpYGpUWgwE9B1PIjd6TRQuNCZrEc5sScqqKjQKeLAohM
         cJEw==
X-Forwarded-Encrypted: i=1; AJvYcCXOoo06rh3Jdn5dB+975oYy4YfsVzqjCj5LHougAFQhyvelZ//YrZS66fXIGMvdPALgGWLjEw0aaFGwUutbLLic5yOh
X-Gm-Message-State: AOJu0YxOaAogWq0XaK+K3QRs3kRav388czR0oQ7mQSy7zG1Hq+gm8P8x
	oL91wWxetghehCYfiV5aUCOXBrLteyfTm623HrA0SLtmpVhQDmcMJh0hFc9hWIU=
X-Google-Smtp-Source: AGHT+IFfy0KomlPRqTEholA/1LiOtg+jSBl8HkaQYGxuuOHoGzOKqTDxP2IcdVqvCWNezAykTgeIzg==
X-Received: by 2002:a05:6a20:7489:b0:1bd:d5ba:e163 with SMTP id adf61e73a8af0-1bef60fd0b3mr13811570637.26.1719937553987;
        Tue, 02 Jul 2024 09:25:53 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15388bdsm86320255ad.168.2024.07.02.09.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jul 2024 21:55:48 +0530
Message-Id: <D2F6Z5WUBKKQ.2A00IY9IF37SI@gmail.com>
Cc: "Jonathan Nieder" <jrnieder@gmail.com>, "Josh Steadmon"
 <steadmon@google.com>, "Junio C Hamano" <gitster@pobox.com>,
 <christian.couder@gmail.com>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t: migrate helper/test-oidmap.c to
 unit-tests/t-oidmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
References: <20240619175036.64291-1-shyamthakkar001@gmail.com>
 <20240628122030.41554-1-shyamthakkar001@gmail.com>
 <16e06a6d-5fd0-4132-9d82-5c6f13b7f9ed@gmail.com>
In-Reply-To: <16e06a6d-5fd0-4132-9d82-5c6f13b7f9ed@gmail.com>

Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Ghanshyam
>
> On 28/06/2024 13:20, Ghanshyam Thakkar wrote:
> > helper/test-oidmap.c along with t0016-oidmap.sh test the oidmap.h
> > library which is built on top of hashmap.h.
> >=20
> > Migrate them to the unit testing framework for better performance,
> > concise code and better debugging. Along with the migration also plug
> > memory leaks and make the test logic independent for all the tests.
> > The migration removes 'put' tests from t0016, because it is used as
> > setup to all the other tests, so testing it separately does not yield
> > any benefit.
> >=20
> > Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> > This version addresses Phillip's review about detecting duplicates in
> > oidmap when iterating over it and removing put_and_check_null() to move
> > the relevant code to setup() instead. And contains some grammer fixes
> > in the comment.
>
> This version with Junio's fixup addresses my previous comments. One more
> thing occurred to me as I was reading it again
>
> > +static void t_iterate(struct oidmap *map)
> > +{
> > +	struct oidmap_iter iter;
> > +	struct test_entry *entry;
>
> I wonder if we want to add a bit of paranoia with
>
> int count =3D 0;
>
> > +	oidmap_iter_init(map, &iter);
> > +	while ((entry =3D oidmap_iter_next(&iter))) {
> > +		int ret;
> > +		if (!check_int((ret =3D key_val_contains(entry)), =3D=3D, 0)) {
> > +			switch (ret) {
> > +			case -1:
> > +				break; /* error message handled by get_oid_arbitrary_hex() */
> > +			case 1:
> > +				test_msg("obtained entry was not given in the input\n"
> > +					 "  name: %s\n   oid: %s\n",
> > +					 entry->name, oid_to_hex(&entry->entry.oid));
> > +				break;
> > +			case 2:
> > +				test_msg("duplicate entry detected\n"
> > +					 "  name: %s\n   oid: %s\n",
> > +					 entry->name, oid_to_hex(&entry->entry.oid));
> > +				break;
> > +			default:
> > +				test_msg("BUG: invalid return value (%d) from key_val_contains()",
> > +					 ret);
> > +				break;
> > +			}
> > +		}=20
> } else {
> count++;
> }
> > +	}
> check_int(count, ARRAY_SIZE(key_val));
>
> to check that we iterate over all the entries as well as checking the
> size of the hashmap here.
>
> > + check_int(hashmap_get_size(&map->map), =3D=3D, ARRAY_SIZE(key_val));

Yeah, good idea. I'll include it in v3.

Thanks.
