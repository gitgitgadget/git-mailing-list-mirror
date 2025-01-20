Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BDA18FDC8
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368325; cv=none; b=sF7cJl1GbD1y+10QHIAtnnj7KzOC5oP3RnDt4ewgGlqH52Yn6aWUg0w/oO1lpwlhoxR5gidm5LpuTIoJFHGNL4RehqreCYDYcLqazPGEFPJOs/54NcXl0jRyvh9ULqfppmoxv0uGTexhxSEg1vSztV4Ob7tvaR37QLbaQopipbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368325; c=relaxed/simple;
	bh=L9v3rE7yqd8a0ZhAjcuZYgKjR/FNP1F06aDJ5tp1S/w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ+Cdl9blhDPjM4AYzXn5Ukj83LrlZUQ1c6O+sxu4OZBnhkC1hCZMPIXTnM0w0sDBSfR0WUuoWAYJUxtrFaaVw1mgdutL/xWhSIaOMyuGDHusDDZz89gnAg5E6tNRAumggkIzKO2O8Vc1mt2UbppptDFlf+LXWUFHldEN0Ffdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjBXIjwR; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjBXIjwR"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4b68cb2abacso483661137.3
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 02:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737368323; x=1737973123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L9v3rE7yqd8a0ZhAjcuZYgKjR/FNP1F06aDJ5tp1S/w=;
        b=cjBXIjwRJvKEKVnIxfqi1JETEw8V1EY5badbm05KiQ/7rmt/6Ts+eXACxVvqLIM7eJ
         5EdPnAMSAMpYcI3lxzG3f4x/5tY1Ds6CeyI3YsX7NMKQ9CFtTkpwzcFPzCHbMFwPq1uH
         rB9GcaBP8Lb/6hlQRb+x6a34mJ+rgN8yVOLQU69LiukcQ2yLEwH9LhfOpZwR/V7pZcJ5
         ESokrkYbE9YhnlcfhWXtyEDzFfh9M/0QpfqldVZ4JvoFOKO9Wp4vyZZH6KWnHKjM7uL4
         OmfdpNOVC0I9PxVVMIVc1WpgT+a5JyZMhTTuZEV2jvKlZfjUveZ3dZTSDfNJ0ldhJbW+
         tJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737368323; x=1737973123;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9v3rE7yqd8a0ZhAjcuZYgKjR/FNP1F06aDJ5tp1S/w=;
        b=Bxr/sixlZpfHE32Np3P4nKzA/9MCyEnQhny0tWbPJIQP5//NA4zCr2sIP3mQYGRQCJ
         CxC5oyBReSHA7ZEINaJCuWe0Q/3HmylZuPJprzomw/a/BofhpOEt5UYNgB8tOhU6+Lqy
         pwvewvBtoESM9aYuQbXko9p+rz0byYJBNxx/g06cfxeudUvJeyB/gl2AdLrI7sZd4Lfe
         khR4vxvOSvzzFv1ikpKRxGPz2j0tJU+7QItTOsxQPTTBmDj0sH89dxcCg8N0WFyUVUhU
         O4SWPe8tYxDAISOKDzZl+Qn2/e/W0Gru6xusv8dE6Y502gDltK633K+QmOsSN8fJVZp5
         Lr6g==
X-Forwarded-Encrypted: i=1; AJvYcCXvltLBfqN8M4xj5B1gxpvKYWumAajLQQ7nPiwORfuoeo23jBKEwrj3RT6UGMM6pk2+sSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQjeGgKXLorhQZcC0NZO9nle8JLyWFzDlxl71h42J5FMCUeDFk
	aKGHMDP2aBJjDG082EBT3xAjaB5XYDbAy8AuGqRdqedHgT0FW9mTDBc65MhS8vQd5on061GtnwR
	9BnmAeMQPX8FrjD8jh6KJK5CodS8=
X-Gm-Gg: ASbGnctIa3cjrFGfoUkn7fne/t8Vnm2iwVCKXqsmZqYNWmrW3e21qMw8NIdyIvHxxB4
	vR4/0f6F8AqzXuRhP0IX0iM3JrH28KQd6ZXlqck/CaZNqpyazCzau
X-Google-Smtp-Source: AGHT+IFT93ABygI16SQyCP4zwWVvHk156ccUzgMXSqcXHLqunO5q4zPsZChvItGewLsGQGIXXO3tq+pv8u+3ysjTl2E=
X-Received: by 2002:a05:6102:3e83:b0:4b2:bc6a:2e8b with SMTP id
 ada2fe7eead31-4b690b8b624mr10071373137.3.1737368322938; Mon, 20 Jan 2025
 02:18:42 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 04:18:42 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250117122926.101749-3-kuforiji98@gmail.com>
References: <20250116161559.91038-1-kuforiji98@gmail.com> <20250117122926.101749-1-kuforiji98@gmail.com>
 <20250117122926.101749-3-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 04:18:42 -0600
X-Gm-Features: AbW1kvbSpydSvnlXy_2A5Ydff7aQPpmoXxKlH4z6B1q5ZvjjwoEMPoREs78C1GU
Message-ID: <CAOLa=ZQvW1fRv_BVAFYvj1u==TC4U+xgBMbVNH0ZNfnhqimfYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] t/unit-tests: convert mem-pool test to use clar
 test framework
To: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, phillip.wood@dunelm.org.uk, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000bbc296062c2095c6"

--000000000000bbc296062c2095c6
Content-Type: text/plain; charset="UTF-8"

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Adapt the mem-pool test script to use clar framework by using clar
> assertions where necessary.Test functions are created as a standalone to

Nit: missing space post period. Rest of tha patch looks good!

> test different test cases.

[snip]

--000000000000bbc296062c2095c6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2f545bc3a8b95519_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT0l3QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOGFpQy85bGxUVXRCZ1lWdG5lajVHa2RWSGM4L2FTeQpYcVRPUm50eC9D
Sk0ycjVKRjFEQStHTHZFdGNPV05ldFdCQ1ZobVBHL05KcUdNZGptdEk4Wlg1Y1J1UHpVdHl1CnV3
YmZxTHIvMUJkaEgrQVNLUDRQdW5JZExWc3A5UlRRN1dGUk1BMzJXSjZGZVpDWmhwTEJYUHRhUUxB
TEtOaTAKclBYSUd2V1Y2Y2c2eXczZmxkQk1YVmN1MWlOQ1pFRUxPN2UwQnRxR1Nmai9XZGQ3SXZJ
anZaYk9EbGxSVlhRVApKQldXdVV0ckl3YW54Z1JCeFp4YnlPM05CWWs4WWMvemtwOUJhSWdVRmM2
ck9sMURVOU9BOTMreHp0TTVOblc3CkgzcC9OVUtQS29CeTEvb0FmSExiQ2FzMTdGSCtrTDlHVGJa
eGxndTBlWUZQVlN1YmhBdnJvWEZScFAwSmtCOHUKa0ZGQ200eHU3eVZHbUV2cWpRWFlmcFNDSW9y
cmlCLzk0YXd1KzIraU5JSGNUMkxOdkJlZndzSW5QVjJtUUhXcApVZ3dlWDVZWU5HalBBWUNZcVZq
MzdBbEJBbFFhMVVhaWZScTYwUjVqNFlCeFlHY0dBRXJ0OFluNXhsbk05SHJJCi96NzZzak1JNElp
ZDl0T1R0WUpiOXNWc3N5Z1BLdkZKM21DMG1sUT0KPXB4ZTcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bbc296062c2095c6--
