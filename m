Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959E377119
	for <git@vger.kernel.org>; Fri, 10 May 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332043; cv=none; b=hQdSh/62DeGrKUKgoxTRwoMtxuKsVkcPUPjhtGYL5Q76qxo2uVmNEnFjiomf85Jd3p4uGpPniVT1ags0v8Sn2S0xiQdczuv9NVv/SgCXslyEXaEcYA8zraq/6bcg1JnWbhm1sSOZZLvojchu3xIPH3A9MN/JZbJc6TZP1dkOrZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332043; c=relaxed/simple;
	bh=vEitvZNXqxiz58uwJParfu+YoAf0in3ya1zgLyyVN00=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=cTvOfCG4YXBsOj9fqbmXuaWxUghHsyShih5SmlWAf/gvvylIPk1ZcYX4+c2W4rPYFFt12azj29vCRHM0ycpNrhk29e1OEzB+H2JjD7JE5mSXgV4josXbijEFpwULH2TGaOWX33jTJw7l7RCcCA7t6fcLc1qPn9RDxqu9TZv0ojk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmfVOiv3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmfVOiv3"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1283621a12.1
        for <git@vger.kernel.org>; Fri, 10 May 2024 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715332042; x=1715936842; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmXgu25TfI4HE3N936kgdLAH6zuwL1LM3pkYuEIcye8=;
        b=XmfVOiv34owMXbingMEDUDpz6i2lUSoa/5r3qygCsG8sKg+7NZgQPsxTJJpBdZJYvl
         RPRwSBzEOsWJODZjto9areobQl3opyBm3xhiU4iwAEklXuKZzrrtabpqIsNSGgATKQ4t
         pzn7aJadrt3lzybrwKmqhjOmQnj5exW9xgKkSojJZwLIuhLWY5QGpsVLIkCxowEBNDyo
         XeiNx0lmdo5hZW4R+2x3g2jxeFn1RAVksMuAza4dl0EYpU7GE9xKAsyVQOYgiIzd9AbC
         0cZfEobsg2suYZTagXcOAlGEkmbBGRpi1uQUAkMTD0IvFX8NkRmdZ/kQS9XKeITLt5aY
         0eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332042; x=1715936842;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmXgu25TfI4HE3N936kgdLAH6zuwL1LM3pkYuEIcye8=;
        b=J4TA43VW0pcA4gRs6lQecb87fG909uL0DF/YBMTiDkrLFDSm+NY2dE9ObGuVpptelZ
         utbYSZ8qO3svFeFZXDqO5uqeri8zyDJ0ZYZPLa/9p1YyUjVtRE3hR6nAx3ti0dYff2Wj
         u3IsBsgUlK1TwttAmQ0MlbPj5KSh5fUOgFS1SnJQMJg4UVDGG0LVBPqQobxei92yTsXU
         P5HKUVkzi+V652Ls4gvip9Ah1T4L80aLdkjK6znkz/YbixZt5sFQ3c88EaL4+UC5W/la
         OeGuRmEJZRhZbcTfa6MV06uWDsGip29nZYEG1CgvFtuDuBLZeVN1FZ/zGsBfNpZT2ZxY
         HDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKe2Q6/sHmEl0FcouMzOKpDEmCYMkCTEAdb8PuQjtwnIacgU2QLuCV6MAbO++3Y5z1xU3X+tSchV4p2S8f1JCgy0HN
X-Gm-Message-State: AOJu0Ywh5TUXOnH4Qud2oPxjjQIKp3e3HC0bCGir5JRwd0M9AHVrQBxR
	bHLa9/aoUI45m2qULCWyAtkQFtGe18SD6DJn15xwvp6W2V4y3ArvN46f0X/pdX+r19Qtq0QquPi
	ahetPUB0v4O3mNgNqKFL7fun1E5+Agw==
X-Google-Smtp-Source: AGHT+IHEAaCw+pWYzraac4R4suS7hdCIIrgzjS+DYUUfsnY2Ji8EKm0sr11hCagp0cUzGbqLJWeQ08AUb3BQGWmYOws=
X-Received: by 2002:a05:6870:d0d4:b0:23e:5cd0:faaa with SMTP id
 586e51a60fabf-24172f6b2f1mr2331792fac.55.1715331633384; Fri, 10 May 2024
 02:00:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 02:00:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <47cee6e25ebaac5af9fd0c9eaad7fc50b2547cad.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <47cee6e25ebaac5af9fd0c9eaad7fc50b2547cad.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 02:00:31 -0700
Message-ID: <CAOLa=ZQ3m3HOxpAUVK8_KASfQwmhXNraYrm-M-T2BTHUm5c5ZQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] reftable: consistently refer to `reftable_write_options`
 as `opts`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ae3286061815c4e8"

--000000000000ae3286061815c4e8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Throughout the reftable library the `reftable_write_options` are
> sometimes referred to as `cfg` and sometimes as `opts`. Unify these to
> consistently use `opts` to avoid confusion.
>

I think one location was missed:

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 3316d55f19..40eb793b3c 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -396,7 +396,7 @@ static void
test_reftable_stack_auto_compaction_fails_gracefully(void)

 static void test_reftable_stack_validate_refname(void)
 {
-	struct reftable_write_options cfg = { 0 };
+	struct reftable_write_options opts = { 0 };
 	struct reftable_stack *st = NULL;
 	int err;
 	char *dir = get_tmp_dir(__LINE__);
@@ -410,7 +410,7 @@ static void test_reftable_stack_validate_refname(void)
 	};
 	char *additions[] = { "a", "a/b/c" };

-	err = reftable_new_stack(&st, dir, cfg);
+	err = reftable_new_stack(&st, dir, opts);
 	EXPECT_ERR(err);

 	err = reftable_stack_add(st, &write_test_ref, &ref);

Rest of the patch looks good. Thanks

--000000000000ae3286061815c4e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 213f39d46ed72223_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZOTRpMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0dxREFDUENPeEpEYjBQd3ltTVhPdkdUK3BiYlN3NQpJaE1UajdNc2tq
UW5Xb3pvTW96aFRQN2ROTG0rWlZsblZoa0xraWRGTmdKYmhTSUlkd0ZUVnUyRnhCbjBqcjBJCkJQ
ZU94dnpYb2lpUXlWMHBLNXh0bmhqdFhWandPcnVJME1VRzV3YlREL0k2VTNqVGI1eEdma0pYK2pj
czR6RkcKR3h0R3VqYnB3Vk1jQXZEc1krelRmNTRvK2YrcUV2cCtrRWxjazB2TnFkV2Flb3BNcURu
TEhCSjUvMVJUMnVQMgpkUWJINWVRTUhtZitKNyswd3lPcXlIcTJNNjRYQ0kydGM1QWJWZExzZWR3
SkZ5ZE0wWkN5TDFwR0JkZEZzaG1uCjNMVisyVUVQMWRrSlF2QzVYTCtvSUZjNnBKT1FCcEk4ZVVo
L1huZTlWZ3Q5cDdKUHhRQUVKSWVjRHJ5SjVKRSsKZkZjQ1Y2blM2SkJpQk5OVHN3QjFLUFdLYUtW
N2Qwek5YT2tkazdFMjdIUGdBYkdBV0lvQkNpckJ6akVTK2UvSQo4c0hrZ3p5UVdkRVBnbWhPU1FI
Slp0Y0lNQURWeGRtNktTNmc5RnNibGI4VXd0OWNlcHJhZ3c0K2VMNFFRSGRrCjlIUTRkZXlET2ht
enU3a1hGdG9RamphblI3OEhPU1ZJL1RCZ2RQOD0KPU1uQUMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ae3286061815c4e8--
