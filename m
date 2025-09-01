Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E141DF271
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734743; cv=none; b=qRYuIP17CiVggWNP1enqkm7YyKbsEWnzlrbwd4d3fDk8OAHk61TN9LmFJxA5A9EMP8GWf2yQJ8PXmxFoH8k+718ZD1fX21oNg5JN9QWe6xKVelXDnhjTfjG1qFAxA0JpYxtgUUjm7GEYTQeNdBrxCNi9NcyVGo1NOMlJhDYI7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734743; c=relaxed/simple;
	bh=Wr/F4ZycC/L+QEE3IzWoLwHTnBFpwGnITyLOhIODerk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdudN4SL+Cv0NitSAglWMVx2eHDkGT2EVMor6EHgTzctirnojwq45QVzWbrlTl4WsE46JyH+pOjLq/j84sKCHAarc9UZFwxdg9iOmHlJrOsXXnv2wozECCBQSasKCRToAA4lX0ccxzMgvhnfzCXak6r3K/tXIUwozEXYXkHRk6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Veu3ZDSO; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Veu3ZDSO"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544ba00733aso550121e0c.1
        for <git@vger.kernel.org>; Mon, 01 Sep 2025 06:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734741; x=1757339541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNqwsi3F5LsQdaSvOuQ/ehnsPk6RQQZphQsKNOl6/lo=;
        b=Veu3ZDSOGTvbFfZ7IzjZPf6HLYjF4wWEGJMM5VuLkTLKuTDhfefZlg+AmBfIaHv1cR
         F9VocaXZO3/vKC9f2kK9/zB4H2TtFAmkBU/Nk4G6bIMN3FE4XZqxTMr7y7TuJezoFmln
         8OOWDqMVDs1vy8+OZQkEKsi+6+isrnaG+K5eo1ZkMzv1B0/pzWJs0r1aWGOc8qVfdfxq
         8oqfLgB+l2s2L4t9dJSO46duA7tmDn5ZFUzAzwj+YTcyoSlvbExEQlCzGRaHeWNGyWQx
         R5aepil3nn2UZDe7vzw9if2xGzxW8Jq/eeTocEzjS0OSjPHfuObUjQYqFI5krxqF0Sm/
         XVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734741; x=1757339541;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vNqwsi3F5LsQdaSvOuQ/ehnsPk6RQQZphQsKNOl6/lo=;
        b=b7GdSEw7XHHXOGxLGf7J4unHg2SmTxI1ecl4kAwBwj8W9wrinIgGcrgqom0g+oE5TU
         fLyrwsOBGzvPXSvUE0micW7S5O5CLvO10tqEzo5V2rsR+RPF1K8skVFEwpQHJk96m1A6
         xpVU1twsPuZJR/I7Er8NPfUjuzc425omsSamn8UlPG2HS5mf8rad3KLXc3/QT5EJDcJb
         xgocvKJb6prKqudh8Yl46kLh7U+uti5wWFykq+eP+cd8R2K/prTTv4jwT7ferszxjYeX
         6/WLfiEiDCrVtyphvLg9XmYVPndtjWfLsvgTJ3TfOApeogS+3EOqu60A0UP7d8wiCksa
         oRig==
X-Gm-Message-State: AOJu0YynYRABVxjXGN++t02U5So8CZdIdbcsect9qSWf+EOvrfX53Erv
	GXK/qaLTjhV1yiiUL6sg3/ACtFR61gIoYpn9Dh3x8C9FnqCj5s2OL1PKgYUkwbBKnyXGj9ATE8m
	y3ZtIyKaiQnazYv5eCM85sOaXimqihkR0Xw==
X-Gm-Gg: ASbGncv1lwFvG7ZBSMDkJb/LcWVN+v1Kjtke7HseO8ysHzMnZogVlGmm+nKmEzEa/1F
	BoI3+Yml8STVo22cmKo9BbHOPItR8/Qd0r+naSPbRTqwi5o1fRA0ljDXaXGy8FNNXZzmxxyxda3
	M9kLnLsI1hGz7kENUDX3wijY9gSDGoj9cuLBviy5WHWdCq/OjDAovgudRxH4iYOf9OnyI2cd1ef
	nYfi2qmkotW12U6lpXL6zc2JPqnVirWIuHS50p1RU8N0uoOqnk7
X-Google-Smtp-Source: AGHT+IGs1N5h5xi6RDcH0d5Kco3GgF7c4ucpS9QVNacyRTVKPKPPNjI+1cDxguVevBc2UwJAI5GjBXKxBHWMpqTuZ/c=
X-Received: by 2002:a05:6122:4804:b0:544:adaa:35ed with SMTP id
 71dfb90a1353d-544adaa3b59mr1129689e0c.13.1756734741046; Mon, 01 Sep 2025
 06:52:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:52:19 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Sep 2025 06:52:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aK3kYZA1eq-sCs9b@ArchLinux>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
 <20250819-228-reftable-introduce-consistency-checks-v1-3-8b8f6879fa9e@gmail.com>
 <aK3kYZA1eq-sCs9b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Sep 2025 06:52:19 -0700
X-Gm-Features: Ac12FXzTrPPJ-PTFxvDUdED1Cw1n216ikvQMpXtlVYxfK7UQQZhsnr33DIG9P0U
Message-ID: <CAOLa=ZSVu9Y9MFE8S0xV9YysE53aD3bK2Wx9Q3Cr3UEwGS2JGg@mail.gmail.com>
Subject: Re: [PATCH 3/5] refs/reftable: add fsck check for number of tables
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000348f94063dbdaeb0"

--000000000000348f94063dbdaeb0
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Tue, Aug 19, 2025 at 02:21:02PM +0200, Karthik Nayak wrote:
>> +test_expect_success 'table count should be checked' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		git commit --allow-empty -m initial &&
>> +
>> +		git refs verify 2>err &&
>> +		test_must_be_empty err &&
>> +
>> +		touch .git/reftable/0x000000002812-0x000000002813-c830a596.ref &&
>> +
>> +		test_must_fail git refs verify 2>err &&
>> +		cat >expect <<-EOF &&
>> +		error: $(pwd)/.git/reftable/tables.list: badReftableStackCount: mismatch in number of tables
>
> This is a bad usage, we should just use `reftable/tables.list`. And this
> is a common pattern. We would print the relative path against the ".git"
> directory.
>

Good point, this can be fixed to 'reftable/tables.list', we don't need
to obtain it from the stack.

> Thanks,
> Jialuo

Thanks

--000000000000348f94063dbdaeb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dfed6892c2b3c85a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pMXBSSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnUxQy8wWW9wRm1kQ2tycjEwejVna1hFUWp6WWw4NQpaUEUyYmRERzA1
cUI3RU9aY3dhcmNISXJSby9VU0FlVGFmTjduV3FWcURidHVmTElKSUJSaUJrYjN5cE5GNDdmCnFV
MFhENjRyME11emRnMytNdzJaOXcwVFAydUlOY1g4R1hVZEVJUHkrTXVzUkk1OERXQTVLbHNFenJ1
Q1diM0IKa1E4WTJPVWNYdmxOUXluRlJDd3QvaEMvN3MvcThaRk9CUUN6SU1GdVE3NElBNTVQb3pl
d2lIVDJRRGpoT0UxRwpqSUlBNW1FK1RKYTd0ODhLZkk2dit1NWN0SVh4MU9FQ3UwZFk3TFhEZ1dX
Z1hiL2hnTVgrcXZxREZyUDZoSEl5ClM3YkI3SGphek83M2NzTituR3BGUnZxZSt2YmlodXpNeENo
V0MzSWFuaThDZVZqZUY2L1RmeFN2cUpmZFpCY1gKMzdJVjhjQTN6MDFaaWlSMWRkaHR2VWJSTkFU
Z0Q1eERqWW56R0lYVVh4Qk5aTm9xdUd4KzMxT3ZtRSs1dEx6ZQpDMTVIWlFqS0krQi92bm1wdTVn
YUxwWEdUR3h6V2U5LzlMeUQyTC9rZ000TmNOeFFjZVJ2d3BMbURNMmI1Q2VoClRLVk1Mdno5L1lz
NU9vVVhkT3psYXVWTkZjd2ZQQ3AyWGxpMnhOYz0KPUhydW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000348f94063dbdaeb0--
