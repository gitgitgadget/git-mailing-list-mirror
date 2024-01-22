Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD303A8E3
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924925; cv=none; b=bPcZsNq8qwRr7KNy8oB5OIAaQPPoGGrQrweQmq+YpDmus9+/cPyGvovyOTrPY64jCFMg6Qy8JBzrOnjw4tmZUFRtCM7ZBpLL9joxhcRkbZ5elRE7PEofFGqTGEKgedTMFBd1Wti/Btai+Syc3y8zRGIa+IUy2iAUHYfAU/0N5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924925; c=relaxed/simple;
	bh=qb9/Ys+5R5HAuw/vEinBxDdycl5DL3gQ+jo+WbC0SG8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=qbQ4zaeJGU1/3lCM/c8BWxMt9JKu4ohbtnpWEGFCQ40hBDmrI766tCS6UsrXIOX3BNWG8iF46Da0Zc1zbr7gCnx75Zj75P105KT31SGOgIJ4kpISYEpz6tSqKl2ufaW+SBRaLLZKKkZpEsvUf6HcADFFXi3SfeddwVYvTjbnp6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DydVeOr4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DydVeOr4"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bda741ad7dso2489977b6e.1
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 04:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705924923; x=1706529723; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qb9/Ys+5R5HAuw/vEinBxDdycl5DL3gQ+jo+WbC0SG8=;
        b=DydVeOr48nmV+u33xf0iE9tujGMM/owITgdTNY7r7rhtxaRKNFSIvsGZzGCOJcIieI
         G32UnW13AYw5EckO4mtJnGMpLfvdLt+pZmzoLQOiri1MDCOU3Gy3ThR/xLmtIHDvJTup
         0Ec4vuM3WfqgzzDjrLBXTw9tL9PLmX5IlSyLoNCbFYiruMxr41+gKE/C/XtOEpykwQU5
         3QUatnUlNBTjpuMnpCWREyLaebQ/QQskjwCLVCXiZokEfmicColsKwsaVTc52fMIkcaJ
         lxd0QOdakvJQsnYwLzgND2h3feE/W3lZICJBYFqTL4APg9pGeXUKzAhP3KgYOV2pmR5p
         0HFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924923; x=1706529723;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qb9/Ys+5R5HAuw/vEinBxDdycl5DL3gQ+jo+WbC0SG8=;
        b=BbmasbA8KesOqjMtXenZO78YFcLEafx3wZAzAUTSI5d7TvN1Ovg27xkNkE5P39ms/l
         ohF+RHGjZPjrthAT1SJyrSg4hg6jaZJ7LWFqS2zacgFgx9AAK7YnvdTPOvVwnpOEPgRC
         cKenk9T3g0hNYMmIVW+0sjZ8Bm4W6s1lclhldc77jPqXDULiETHbs3alrlV2v5ni/G2Z
         MbECVf2b2u6e75Dnaz8wJElsGTelIYD/3BIPX+a51dHO5ZR9iUEqXf+BlXa5ozPwCAB7
         iQ/iAhciTTvPSJhEgk7UAMhWe5bw4BTYPpdjZuuUxjqpdINa14vdo2rj2qow1usPYw+U
         /tsg==
X-Gm-Message-State: AOJu0Ywil/xtpoG2OdC1J76DovrUx8zWnso2KFJHBteJvrChGCqer1h9
	kUH2QCxQf+pTRWd62Tt5VCMq6GnJErJuDrJDVBLEKrw3yV9kd9x0qL3jmTDNHL66YAz7tWPE2Dk
	EGwJ++/3f/2kqSKyjmQaJUPMBQTGyyrg1Td8=
X-Google-Smtp-Source: AGHT+IGwATbGiGXkV/lkQ+YerRrTa83tvGhwJsIS2UNokUnLNcCw8wzJtCEBgq44WvJEm77b34O6zez+wcEuza/1miU=
X-Received: by 2002:a05:6870:15d4:b0:210:be34:2bca with SMTP id
 k20-20020a05687015d400b00210be342bcamr4760731oad.69.1705924923429; Mon, 22
 Jan 2024 04:02:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jan 2024 04:02:02 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im> <ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jan 2024 04:02:02 -0800
Message-ID: <CAOLa=ZRXS823vHFaBWx_T1159Ex3Y+sxBGXQVa8v+fq_q546mg@mail.gmail.com>
Subject: Re: [PATCH 3/7] refs: convert AUTO_MERGE to become a normal pseudo-ref
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000132868060f8799f1"

--000000000000132868060f8799f1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In 70c70de616 (refs: complete list of special refs, 2023-12-14) we have
> inrtoduced a new `is_special_ref()` function that classifies some refs
> as being special. The rule is that special refs are exclusively read and
> written via the filesystem directly, whereas normal refs exclucsively go
> via the refs API.
>

s/exclucsively/exclusively

--000000000000132868060f8799f1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e0fd7c4beacb98f4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XdVdUa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0ovQy85WWJjUkRmRjJlMXVzYkdiWDRGdGxiU0YzYQpNV1h6TTBhYmhx
blJ4NXRoVk13Z3U4OGNxWDJkUXh3N3ZhMUJLTERpUXVFNnJpWHVGK3VCNCtJK3RQdDMwV0hNCnpP
cHZiZ3lZVVpaQlE4TEpuSkU1Q1RtWm5pNng3K1ZqakQzTVJjVTZDRGExc3RsM09hWHVDWmFycFh0
eDBsQUsKb2JtQ0Qzb0tUak1hT1NQaFVZNUFHR0ptZkoxYmtLdm9KbXo2cVdMNUUrNUQ2SG1DYkxi
b1pJbHM1NlNZSStrNQo5Q0NWOUUyZFpIaWJDWHN5SFlEOHRqb0pITTQwOW9YODNrNS83T1IvS0NK
bFB6L0VCLzNqR2xrVkVRbGJydThoCnQvdmJYQzluanpEK2FLQWpGV0pmYjRWS0ZkRXd4STFLcnRF
V0R3SytpNUg0T0xXcG1WV2JGcmJudHNGN2c1eEcKZEJIaHM1b0ZtWlNRVVBFSEowM0pBdWVRaTh0
WEQyUUtpRHJsYWlQMGhOK0VrK1dPZzg5VlFKa0RhTHVGbDVDVwp1a2VMWWZCVnFmY0gyM2RiRmhS
b1pNa3BINFFzNklZUWdEa01PdFRoNXpuVVVuaDF5VGJ4RjlrVUlodXNCYWJECjNKSmhldDZaeGQ4
aDNTbDhFckFUS3J1MDNOZHN2aDVYaWVxdjNuUT0KPTIyY2gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000132868060f8799f1--
