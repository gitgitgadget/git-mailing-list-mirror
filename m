Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D2B205AC1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292803; cv=none; b=pSzKgi/wLT+DLFzL1VxPE1ghXHDdyFMx2RUQHd58Gf8VvcDfgwFJmNV4v+n0kcOB2Y25sZr3sACVUyD92nM4QZ1AcVlQAFdRCBFCyReFvnYxciJWtrDdRuTOpJ5iN/DTzdHFCuWLPKvboZlcZo6dJgcKvI7i6a7a+0Qxf22Qs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292803; c=relaxed/simple;
	bh=dMLbPyKxrwPj5PLkrgLYYRFS/Opf78AhkSZzmkxp0EI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=AR9kWE0IRMj3AVDDXtu24ktil5KH/QTtwVrT9ZatcvynrgM0A8DBPIYY7j/dfCeezd8rZHR0U3UqYlBpvXkyR7o8ek8LPOVGjQGvzwYDYtYSSQDpf44gU+MokSwpdgCNFeINFgV/gVvHh1hZHrlvg7BPAocdms4fii7Aiob76Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7HtOMwB; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7HtOMwB"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so5284298241.1
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 03:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742292800; x=1742897600; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHRl5FA165b0bNE+QF+cCBEYVh9rmFk2wQ0at36soe8=;
        b=S7HtOMwBk7rbfCW92p8Y59KUho0uN0Mahfl/O4mbHUjz92+I49Z0Mbtnrk5F6a6DbD
         iO1O8scjCYBIoWOzbz8+FmjK0x3Cj12/tJDjJ4luTrUCCQOipkYNan4B5qmgyaZcoiNG
         Ym0dKkIDkaTGj2YPzvEeFK4fTIoJoTmm5J6/OYQs/bt6gLh6oxabF1hG+Ao3ojcgGsBy
         avmj86rRw5EE3rqnmJ7qGU3sxdCDAnxPrEhkpCwE04cCF7bWfWNoVa+BiIes15CziO1j
         Li+TPDEIxav3n8minrLjPLvtT+DgwEghaclldrFG6rb6JB2ejxj3sxv3L/IHkc9IbVyM
         4UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292800; x=1742897600;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHRl5FA165b0bNE+QF+cCBEYVh9rmFk2wQ0at36soe8=;
        b=euZuuLtY2WFQZEzpip5v6XITxRQHq9o3snRTS+yPLZLvQNCkuTvrbw8FTGlHtddZpm
         AR3v4nlhD3bOBU9hdF0abWt1uS0tYpUlyaU2cajWiu6PHHjzGkAVOfVWs1GnEEtaBU7v
         /xdNpzsvZPQBZ4F81DLrkBFHGyJLIb+AtsuR0aR2kf8uAtptUIFulAEdBf5V3to6hXud
         w3pT4IshEO4YInkMN0x6iBVaxWRvtALcR4FZo67Gp706LZzvnPjkbVDDyfONzkFF4t6K
         FCdPN/MoRSUQw8q6GATl3Bw4YHLjoJDX1kdM+1en9aQNT8kKpE2JHflum6SRIwAbWss0
         YhbA==
X-Forwarded-Encrypted: i=1; AJvYcCV9k5KAksQ8hfI6PjCAfilEqCit3efJ8ow0KiupruzInk20yG4WJ2XJAheLe73v1qBglhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/VXTdQk7EVGfmvg53pBT5XLu814/uFHvD7ObMCkQGEFZAZrky
	MzCHJq7zdEiEgAeA8SaG5dHg0BvspXys82acpSrQ77nLIpeG/A1T55x0tLfaiS8ztcjIRJ70lTs
	mwG7terEAv7JfP/3ApVcAjul+siN8iUXE
X-Gm-Gg: ASbGncvneMeTxb3sp/3lYdt5A7OfCbvbu542691ldzog9FRMsfwP/t6sC80OjXzmso6
	OSHNdPHetKUhycOI4HsyZ/jgoNpVOIoL+fSldFsa2QFtMY7q9SqLDA4w6kgoLp0QiOz5Ij6cp7O
	4cV+TRQiykwlRu1NyPNZR+U6Vj
X-Google-Smtp-Source: AGHT+IHNuR3rN4OkoeS4sNSK+GOjOjcrmgCjFlUDLm0q8om2CTYWHlbtCvJbNLrb5cKQTnaDj93haigFJmyeJQyUuoE=
X-Received: by 2002:a67:ef87:0:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4c4da81cc33mr1522954137.12.1742292800454; Tue, 18 Mar 2025
 03:13:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 03:13:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqh63xx23f.fsf@gitster.g>
References: <xmqqh63xx23f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Mar 2025 03:13:19 -0700
X-Gm-Features: AQ5f1Jo4mATv2k6b9YVQtTV_4wulreyxnk0scCNpeBJfFpRwbSAX2cXnHEm5ZWc
Message-ID: <CAOLa=ZRpDHkqWc=-pnERM-4E3OTzQk7XBy+J07Ek4TKdyATTJw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2025, #03; Wed, 12)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000077628f06309b272b"

--00000000000077628f06309b272b
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:


> * kn/reflog-drop (2025-03-10) 1 commit
>  - reflog: implement subcommand to drop reflogs
>
>  "git reflog" learns "drop" subcommand, that discards the entire
>  reflog data for a ref.
>
>  Will merge to 'next'?
>  source: <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>
>

I did a re-roll here, with some fixes based on Patrick's review. I will
try and get another review before we move this forward. Thanks!

--00000000000077628f06309b272b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 368818a03db7bb18_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mWlJ6d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN1gxQy80N3VVMzlzM2ZyNkEzVXBUeFpudllrRWFDMQpYOW02SEZucDlS
RW5pSDg3MWpocTczNDN1WUVmL1RyYXZ2akdDUzBYSVlHSjRFVjZnaGFDQ292TVBicnlXK1J2CndP
S3Q1aG44Mk4xQzBmejFxdjlldFgyVy9SOCszaUxIcDZWdWZSZEs3QUFZUHM4c3lPcEpWWmF1UG1q
TUUrVnEKUHUrZncyeXF1VVg0RHVRUW9kdEdFc0J2TlRuMzRmYVFVV1BxMzhObzAvcXcwYTQrWEt1
eGxPSkRCZTZLMnFvOAozZklKVVJtWm04bnB4NFhoS0FBcWF2bmtLL2lPWm5kOGQxVC9sQ1l6ZmxF
V0NXQTRUN1RqNGo1TS91eUd2cVN0Cm5YN2M0YTZ1MUFXWEYrNzFHNEVnUXc3WmNMZFFtdnJwYng2
d1JLZk9SZFJrVnB3VkM0Vld0ZW0yeXl4b0N5VjIKTGZDUEVDZ0Y4RnBtM3VVbjYya1ZhMkdqUk53
ZTFoeEpZV0hYTUZscXBVbzdpRy82MmtJVXY4UXUyZ3A4U3NEVgp0VW5kZXpsT1VOaWR0eExwOVBC
d0dZdnJkVDZ2c3BDWGR0MlN5WUxqbXd0OTVRZzJ2QnVUSU9RVnZYSHV1UE1RCm11VkloSVFCNFFE
V2xVM0kyWjFwQ2NYRExlTDFOVVNyaFBQYzdOWT0KPU5YZHoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000077628f06309b272b--
