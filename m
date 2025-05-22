Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11A176ADE
	for <git@vger.kernel.org>; Thu, 22 May 2025 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904817; cv=none; b=llGguDiXeyqlXFdz0AmA2YlKEM7EdeGmXZffjtsZ4yE/5ecBVDG4KCnUKMl11WEZYICda5MXUDxK9TCvT2LeLQ20AC6YVi9ReLpIIEvU9t/ss5+K5m3GCML1Vtfq+ghpwMvmsmSxuGzIxO1fIBkObYt+3PB1BA9q23qHjQoVeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904817; c=relaxed/simple;
	bh=M2N6+FpnJZ8CWkh4nnAbACZVWWwtaEdYw0ZL7c9Yxfw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzSmeTax7zppnhfdvrar30nQ6HdV45rC13F0T8lblP1wOS8pRDevZmcjntR8i1HFsHIW0JlxMxATieMqnXGMWoGsiywzm866OoLvlckXsFrPQqac8JGEY1Pk3U9NtcJQdAQtCopc/o45zHRcYrOZd1q/5TXd1qqP2455Q2fO1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzHBQnxL; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzHBQnxL"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e149bf7f4eso2154490137.2
        for <git@vger.kernel.org>; Thu, 22 May 2025 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747904815; x=1748509615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M2N6+FpnJZ8CWkh4nnAbACZVWWwtaEdYw0ZL7c9Yxfw=;
        b=HzHBQnxLbBd5gNj9AZrhH52RqZS+3IOcKItGHC8JJqeL6orCedJaCk7iKNTxu52pr2
         loslVNQ5Uibu/ghNoFiOXHhgR6bSJvJlTeIXPMMGAOrBfmusStEO/ipe4cU3f+M9lZxE
         ekUJ7XFx3dSEUiI3Rda1uqdWHSNP+ySRINzYwO9ATgVjK6VUiDf3TIJ7/MFf+pu3yZJS
         cj0Gw24xz5kQiFbJcIYe1FSCZqEjPuxx9v3WCUFGh6nwYj9C0m04moD8SnERtre7rvsL
         A3nnm9Hd5O7gIv0KIQtr6AotX1p2BHRE6l7af+RoKc5choSNml4MeA2+W7Hr7elGJHOe
         69GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747904815; x=1748509615;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2N6+FpnJZ8CWkh4nnAbACZVWWwtaEdYw0ZL7c9Yxfw=;
        b=E0jCK6aB5GlG4ukk9g2sGDTGHOrNuQBK4r5+oBU8aNe+zyE5f0vhN0oPZn6adPeS5W
         dRIGeOD6JD7h0JSFisuaGcbmSnC2gazwPbZOmNIHw+QLSAN9gmBtbmVey/d/+/Yge/xf
         uhyQ/XEyd3ISk8EHJuU3s28y8srjmLZEOhaNB2OOuXrtij7gEs9Tg3OXS+1JEZddCRxW
         pUFJRdbNBiomQTvfQB/QxPZwfYHPkyMnCz4DojRgoCNuvIz0KvYCrdgIZRthnLcPlxbx
         zWHnAZ8tpQJrdTm4Rfr6wfsyVb5TlFzU9G9n5DcCrh6OlVL/DM3L2/LWGJ+sXcdLJAFK
         ejjw==
X-Gm-Message-State: AOJu0YyMC4lyoLpNd12Iiv4VMtsPyYBp0DwhYC/zknx0aJxyV5Nk0N3z
	0t3iE5cmaxNa29M33t80rmt2xwwfkgzMkyqKUha5ZKcj33/24PR3EKraBLbhgBvMVe5tz5izu0i
	T3lBXaCPXYGKaYZef/lx2x2zFfXYzYIE=
X-Gm-Gg: ASbGncvUKI4JrMtnR+BHAUe4t9miGgoUcnnVJOhRbvVojZGUlR0p8T0hMIVlHlCgomJ
	7KgmLMuQtiQxcUfP6Xd0oaGgro319ajzs0wKBrp0ZvQGb7oOUNq2zD+RnAvkKXnbumIuuxFALtg
	u9LhAQnxeXNnZC/4jD63KGF5yN9iJVa/XDsUXlHcsiX0dqdLBpEkpm3ijb9PVPSFfBdcZ3hpwvK
	xH69w==
X-Google-Smtp-Source: AGHT+IGPmbC1VjIL6P27qIRM1eOH4n3gcKOw1ONgVfmuT2KnJ1TA2Va89tncs841U9tkbqEU/1DQ4chITw0pO78xfLw=
X-Received: by 2002:a05:6102:1622:b0:4de:ed14:da6d with SMTP id
 ada2fe7eead31-4dfa6af1df5mr23427348137.2.1747904815098; Thu, 22 May 2025
 02:06:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 04:06:54 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 May 2025 04:06:54 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250522060933.GA1135565@coredump.intra.peff.net>
References: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>
 <20250522060626.GB1137854@coredump.intra.peff.net> <20250522060933.GA1135565@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 May 2025 04:06:54 -0500
X-Gm-Features: AX0GCFtPSiwjAPg4gFXwAc3uQqNR_abiAmdN61A0DeqlGOP-63Z3BLeY079K44E
Message-ID: <CAOLa=ZTg8_Hs0Ysu4bhtp9VZxnDEkSx3MvD1dN2yYYw7DqKRLw@mail.gmail.com>
Subject: Re: [PATCH] t: remove unexpected SANITIZE_LEAK variables
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, stolee@gmail.com
Content-Type: multipart/mixed; boundary="0000000000009b0f100635b5cdc2"

--0000000000009b0f100635b5cdc2
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, May 22, 2025 at 02:06:26AM -0400, Jeff King wrote:
>
>> As a side note, we do still use the SANITIZE_LEAK prereq in a few
>> places, and I believe that it does actually work. It might be nice to
>> clean up any leaks in those few spots, though we probably want to keep
>> the prereq around forever (e.g., if you introduce a test which shows off
>> a leak and then fixes it later). All orthogonal to your patch, though,
>> which looks good to me.
>
> Ah, nevermind. These are all due to 8415595203 (t5601: work around leak
> sanitizer issue, 2024-11-20). They are leak-free (and the tests pass on
> my system), but apparently some upstream bug can cause issues.
>
> -Peff

Yup. Someday in the future we can cleanup the whole thing. That would be
nice!

- Karthik

--0000000000009b0f100635b5cdc2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7c8a7dcd7d635083_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ndTZTd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1memJ0Qy85Qm1KM3UyeUJDUGZNM1lzcG1Cem4rOExtWApzTmxuZDdOQWpu
aE1haENnTjVEbEtxaWhJL2RWSUtDUGY4bGU2UEFoL215cXJVS3dFdGJqUi9iRmlQekE3YnZYCk9m
YWlQUytzV3QvL09rNWFIcldlSWxOM2NsYzh4TnAvUzBwQllPQmUybzVYUUZLVUdkaStnbDlPZUlB
OGdnZloKZGtVd3A5b1pVRjVWM1FUK0liT3MzakY0ZldDbTRTWC9WQWRBL204cm83T1NINUZjZkJE
MHh2ZHlxMy9ZdUlzbApOQ2YzbW4zYVBicmY2QWd3d1Z2U2tTUk5SN1QvenVMVDJYT013c0pKbE14
Qmt4cU05TzVPdlVVSUFnRzhNYVplCkVkbzNxMmRJTXkrcmlrYmpTSW04eExSTStsTWQyWng5SnpT
Y2d5dWtESFJaNk5SOS8zdVhPMWN2UjdYamU1TlYKa2pEd0NHdGYvZTJFUFpaYUZiUml4MnA1R2JY
M3k0M2J3Y2kwN0xNeVFUZDNKY3dmMEUxZ214cklIbUw4eWZpbwpMaVdCb0JyaGF4Q0xxNWxONGNs
N2NEdjRJVWZ2c3RQVWdCRjZqZWhMYnhCdzl0NndKVWVpVE9ENlRKUFAzUC9MCnB4Z3EyTEpCMEQ2
SVFGSzBQeWc0czg0R2liQ1ZkaEc0SDN1YTBJOD0KPStNU3kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009b0f100635b5cdc2--
