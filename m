Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C463D3B8
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090005; cv=none; b=JtHPSqLmPPmOMzmsz0jh6BIPhxF7WrzuMTG+ymxv3sLlsfsAJjic9Dh/RoOdRtHegpsxt4qNgjweRVgCRiHE7KzYldl0v39VG+oKsJ2SzzsIbltX8H0s4PWUa8aHxXDY4K+rWETgzZO8OvgD8rUg25Jn/h5bvH8HRrOcSj2VDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090005; c=relaxed/simple;
	bh=DSjO+STAOwtd1bi395tNSqMpq9Mt9S1ltqvneaeNeEc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCoCJQ3S0v73l10sANDgeXw8EMuwizjYSCpacmosUETvpw08tWK8ZRKcyUivIF2R292dwhI8HHpjkcaWnvjTy/fdzCpiB+9aopLDBzbacg+mhXQp7dsu1pKgApFYQa70/kMrABjgTlFUw6j9JbyjWt7Q/IuEkqRttFMWsYJN384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEQm5Bj/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEQm5Bj/"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e174925b7bso144505eaf.0
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726090003; x=1726694803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSjO+STAOwtd1bi395tNSqMpq9Mt9S1ltqvneaeNeEc=;
        b=WEQm5Bj/t7ldw0btmoptsqq95p9UGTLwKHUjTIW2JSA/auEXF23o/fBGA04jFsTSZ4
         9Ynpehq2qHZy7sqpM2XQTXyx0Wkcnh9UJ2/ct/Z8ZWf43k4+ZCPG2hy573vBP8we9SGj
         DokQW9mE0ANspGu2OzM5TkJ5NH0H4xDbd4Mpi9v/fNcDOEqpF7T2A5MAgapPObf+z2Pd
         n262abvaxdZsIn+wz6tuogXlV6CkCTb5HFRmt2ZtsY/zyV6b2ppjBfG1xok72AfG6MH6
         1EGv0viRYq32zHHqgLlTowGOmqgv9otYHzHHqMkiw2u8PhjXG+cdbI8fcHURwQjX7VxU
         /Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726090003; x=1726694803;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSjO+STAOwtd1bi395tNSqMpq9Mt9S1ltqvneaeNeEc=;
        b=s+3RNDSEa9KSE8wblgJzG/e3Omy9xSFsThI6rlhcisud2kh1eL5XnZNvHXVg+vN8IR
         JQlBV5RGRlK5NzxUM11neT8jN0fy0ao+9kJK579+EnW4JhTX44dahb9kkwJV5fmLWHH+
         JYJU0iJYGTUvLfyTFMtp4pPk2mdVnMiD9WsDBIZzaABA7umSxJJ0OksbJy+wUe44PwZL
         GmUmG36j7qWoYW0uQYqc/jfIyXfVVFr74zHuPV57PoZGa2I3p42J4xTgNSdBJ4+vFm1M
         BTFncqlKpxS0kuImOUYhIT93OCwbApIVqtGV/MKmaCDxRPR83P7sAryrt/wOroegheJs
         63KA==
X-Forwarded-Encrypted: i=1; AJvYcCUOE/eIhu/l2i7oiYgV7dtKt0dz2J/9o5PoL5bO+5ia1tAFiQ0kGgf6nbvUggmOytcwuoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8l9YptX0tMtozPrgpO4r95x6vlWKLqJlsdis3fszlnu6AHYx
	Sob/OC+MQwSpmHcFygrr5ocweKho7KIykckbrohmJaD8lQ8AM5zhIccyuvLhOIxf1TgxPHjqeAE
	qD+iGNn/vzrtSJ2+jzansRGRBKJI=
X-Google-Smtp-Source: AGHT+IE1oLXEp3NwcLKlwWwSmaS/bXykTl57p2qe6Pdz6YzciImD1u9H46CxsyXslt6x2sLo6RiWmFvzM4ZV3R4DbmY=
X-Received: by 2002:a05:6820:1c88:b0:5e1:de92:6b4c with SMTP id
 006d021491bc7-5e201320281mr377404eaf.1.1726090002903; Wed, 11 Sep 2024
 14:26:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Sep 2024 14:26:42 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ac2cc4e03719ecf6d6a2eb4aacb8a162429addb0.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im> <cover.1725008897.git.ps@pks.im> <ac2cc4e03719ecf6d6a2eb4aacb8a162429addb0.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 14:26:42 -0700
Message-ID: <CAOLa=ZQLd4M_CmjnJBg2ht-U9sa21bq5=WgXn7RWe2cWpZx5zQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/21] environment: move `odb_mkstemp()` into object layer
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000007955ec0621dea555"

--0000000000007955ec0621dea555
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The `odb_mkstemp()` function is quite clearly tied to the object store,
> but regardless of that it is located in "environment.c". Move it over,
> which also helps to get rid of dependencies on `the_repository` in the
> environment subsystem.
>

The commit talks only about `odb_mkstemp()` but the code also moves
`odb_pack_keep`. We should add that here.

[snip]

--0000000000007955ec0621dea555
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aaed005bf242749f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iaUN3NFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWdVREFDQTJEVTNLS0MvQ2VzV0xuMkhqb1RKbGpHNAo2ZDZLWldDZkR0
dG53NzJBaHJlWUNEeGcvUVN5ZUwrRThYbXlKNGNoWEpCMDNVQ01aL0FzNEZuTTA1WVpWbkk0Cm9i
Q2pyaGRqMWdqZk9PdDdBMkd5YlVRYUdYNTZTMTFFZCtCQ2VydVFWQjBFZFAwT3JCUm0vQXpndXFv
T3ErOXUKb2g3OWdxV1FzdzM5WStNamRqcEwxTFcxNE9QWXlOb3V4Rm0xK2NJZG9mVEdPWDVDclV5
ZFgzUFRXMmZFYXl4dApsR1pnWDFwSzZkZTc1MlNwdXlKWnRoaWFYNHFTRzNWOEZIMTQvb2lBRnp0
R3M1bHlUR0d2d2ZtYXMyTkxyOE8vCnFHTnYxUTNMOUpmekFVMm55YXg2SmZweFpsN2J6VDJ1dWhy
clJvYmw1TGtzeTQ3dVFSNjFyY1AzTndaekIrcVAKSlBSSEY5ZHcxTloxMnZqem12WE42R3MvUVo5
cHBFSFhJZTh2bkh6a1F0K3lrRVdxZ0o3RWJVZ0VTS3I4bUtWdQpQM2d1SithY1ZvUWZYWUJJVGRW
YTEzdHQxNXBUdzYxVG4zOUxEMXpyN0xMUUZ3WUNtdGIwYzI3M2srbFZVNXFmCjdsMzY0UmxmS0ZJ
N1IwWHpIWGRWNUhsTjZIWUJzRmRnY0IvdXRYTT0KPWs3ZmgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007955ec0621dea555--
