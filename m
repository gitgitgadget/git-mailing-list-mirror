Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833D18EA8
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722565723; cv=none; b=WlpnkIX8vwpAgYLT5JAtYMkrBj9QrOXiI2uwD/sZupKTOf9zY48Qn8MclAmpgTfvV8CP2Dbags2mP7sgvX9E1sgwdcuGuHadMkNomhuDtl6Z/9lUt5axU4HFjSwpgjJPJagyPOAAbYp1l6sFSmfYd6BXNoeAwBYMfukjXj4nGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722565723; c=relaxed/simple;
	bh=MSOaEeTnzc+2QNKGlaZJtFKKEpsUWfFuPI29Gcv/UiA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XXZx8Hbfc+kioiWBjdBSRshAlxZWnFGAaz/DBWFqz6uHtjg9KToN0g3KPycCn5Qsg9QW3p4HxLtOh4Onw96Rc9DulUoOtBK6jGx9vGsddy8zHEfKvLhoL2D9F5/ayVuSIopvE/skkZ8Hl3rPqZMLjQd8wGPvInCPN2gIUvzf16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDcFY/gK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDcFY/gK"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc49c0aaffso58618655ad.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 19:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722565721; x=1723170521; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vBMRcNCyXbYSi/s0Yf5RhNl0mE7HCPLlYJX9kfaHQo=;
        b=mDcFY/gKPoDIqecY2wqdSHRPISxx47CV76DQC6WpzCDRuZwyCiwe6OiUw2BvOKMHKW
         zu6mqVbus6R6TVjTDbZ8XSqLNm99r4jxbHu0HAHVbB7TWwvcpPzG9JxNsKydMRpG4h+z
         ALb7oCUxP9G1rg+w5LZnxq8dtCl4vqxBcCEGJnMBwfnJzznd7X9ucgyC7Z/ayID4JfZw
         ezz+e4zpA8OFXQLU+rXJll4Rdv/Qbhe0Hxz3TGa3vUdB2vq15n7xzxUv6AHeXZ0jENoa
         874QdGO9O8qkyc+V8IOG8ln0LYe9w4zgVDLRUjSPOdmu8hiBucV1dJW6JBtnkW13Ozv0
         rgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722565721; x=1723170521;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3vBMRcNCyXbYSi/s0Yf5RhNl0mE7HCPLlYJX9kfaHQo=;
        b=P/07tmell+TYTj6KRBvyneh41IXrq8TcURn5+2eOQ6e//Mx6VYWhIbQtEjOtCjxXja
         KewrmWS2ht17oa/gQRPl/ssYnzoqZIRkONJMbbz40PtsTNPwD23RRIkH+x4m3Amx124S
         gwldC8fhgZDuYNTrSAblND9gieXnFVlD2w6Iz94nRDfkEF5N33nth5Vf2gxmV7+9QEeo
         6l8nbUf5svcBf27R9caASlREFuaHHPKsGJtMgBTjsyH5L9MZC0y0XCmhc679FrPml7k8
         8eOrmW4SqL/cedaKaq/GKFnt0bKP5T94mLRtDBOBH/apLsW4Sx919MnKFaepfIre2F/Z
         G2mA==
X-Gm-Message-State: AOJu0YyzDyljhd9hvkWGuKDiRc8ulDZxwjMF5EGPPLM3aegt2QR/r2d2
	WVgYoq6fmQH82LKhYZyznK2gUBmJj2Eg+683QnHaz0zA7wjBwOPky6jfV93V
X-Google-Smtp-Source: AGHT+IEPr8gYpLn2rWIFOmelrwROEL62XY4fSnmbucfE+4BwoGzdF+vU6VI6Abq3HHtDf0wWRUXB1g==
X-Received: by 2002:a17:903:1251:b0:1fd:d7a7:f581 with SMTP id d9443c01a7336-1ff57258148mr34405985ad.7.1722565721134;
        Thu, 01 Aug 2024 19:28:41 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f59c51sm6036625ad.67.2024.08.01.19.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 19:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Aug 2024 07:58:36 +0530
Message-Id: <D352L1G9SF8Z.1NMPOJB2YOLRT@gmail.com>
Cc: <git@vger.kernel.org>, "Christian Couder" <chriscool@tuxfamily.org>,
 "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Josh Steadmon"
 <steadmon@google.com>, "Junio C Hamano" <gitster@pobox.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Christian Couder" <christian.couder@gmail.com>
References: <20240711235159.5320-1-shyamthakkar001@gmail.com>
 <20240730115101.188100-1-author@example.com>
 <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>
In-Reply-To: <CAP8UFD04uQbWhY0QDp+nC8VyBvpUs=tBDm=w4CzKK2GcwFZdGQ@mail.gmail.com>

Christian Couder <christian.couder@gmail.com> wrote:
> Hi Ghanshyam,
>
> Not sure why the "From:" header of this email says:
>
> "From: A U Thor <shyamthakkar001@gmail.com>"
>
> Did you make changes to your config or something?

I think I must have changed the user to "A U Thor <author@exmaple.com>"
in the repo config while testing something, but don't consciously remember
doing so.

>
> On Tue, Jul 30, 2024 at 1:52 PM A U Thor <shyamthakkar001@gmail.com>
> wrote:
> >
> > From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
>
>
> > Changes in v4:
> > - update commit message to add a reference and fix typo
> > - change 'int ignore_case' to 'unsigned int ignore_case'
> > - make 'ignore_case' the last parameter in all the functions
> > - update t_get() to add a testcase query for better ignore-case
> >   checking
> >
> > Range-diff against v3:
>
>
> >     -+static void t_get(struct hashmap *map, int ignore_case)
> >     ++static void t_get(struct hashmap *map, unsigned int ignore_case)
> >      +{
> >      +  struct test_entry *entry;
> >      +  const char *key_val[][2] =3D { { "key1", "value1" },
> >      +                               { "key2", "value2" },
> >      +                               { "fooBarFrotz", "value3" },
> >     -+                               { ignore_case ? "key4" : "foobarfr=
otz", "value4" } };
> >     ++                               { ignore_case ? "TeNor" : "tenor",
> >     ++                                 ignore_case ? "value4" : "value5=
" } };
> >      +  const char *query[][2] =3D {
> >      +          { ignore_case ? "Key1" : "key1", "value1" },
> >      +          { ignore_case ? "keY2" : "key2", "value2" },
> >     -+          { ignore_case ? "foobarfrotz" : "fooBarFrotz", "value3"=
 }
> >     ++          { ignore_case ? "FOObarFrotz" : "fooBarFrotz", "value3"=
 },
> >     ++          { ignore_case ? "TENOR" : "tenor",
> >     ++            ignore_case ? "value4" : "value5" }
> >      +  };
>
> I suggested adding the following test case:
>
> { ignore_case ? "FOOBarFrotZ" : "foobarfrotz",
> ignore_case ? : "value3" : "value4" }
>
> to better check that things work well especially when not ignoring the
> case.
>
> This is because, when not ignoring the case, there used to be a choice
> between { "fooBarFrotz", "value3" } and { "foobarfrotz", "value4" }
> that can be decided only by the case of the key in 'query'. But
> instead you removed that choice from 'key_val'.

Yeah, you're correct about the choice thing. I think I misunderstood
your comments from the previous version. Will update.

Thanks.

