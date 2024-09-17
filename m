Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE113BAFA
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726597625; cv=none; b=t8OBg2/YUb9YFWU86srV7IB86QwSN6qHDpaNh6xdcaiv/OulScOidyn4v5d+E6xYVmNgxajpybg81FwxQoI8ZPM11PpqUzqjtRxtIDcKThEHOq95DIe0G4gXbs39zhd9sbbfwDf7orW1dLtvHZ9O8n6i+5jChL3b2UfGB8cxglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726597625; c=relaxed/simple;
	bh=4vg4914nlqUWkOewWPUyn8SYIeWYvdXv5drq2SlFf5A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=o7JgpcD55eTWKKV6ZaFcdYhnNMwA58MgUJZ2kBkKxoScw/+Gqk5Iu/3An2qS5S3w+cvJum8CzgPN1eAhlgS0uWID6f454/3PPx/w0v9f6cOgq2MW43uGkoks/1Xz4JpjPGdrdNVY7NWF88QVmqlPOkK2HqSsKZeirAaE5kU/Iwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cK2rj8da; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cK2rj8da"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d8a744aa9bso3266381a91.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726597623; x=1727202423; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRpwS5EhYTLRlv3stKfvp3FPqK2XQ1rkOQdzOeER/GA=;
        b=cK2rj8daMxv1riGPzKCNezuxsm2vwI09FeouTxBlDG4yczH3N10gm/J8ku0Wx6uBf1
         eDlfHQbTYUg1uuUGF5AhTPS7jCaHI0mOy+TRCB6gnA5gfhTc+WAYViS1K37gSfOC6iCL
         sX7cO+waPu+FJBcUfjtLhz38oGhjvbz7kxFISxYF2n5IaM/7Oq5WLMXpX6ph6SWXo3jP
         Oa/Z1c4Udt+i4uuL33waBKuBd9m7l5ab9/lIypuA7H7/Xy1qxEWPpKPIIe2ufX3wrwTW
         niHY64MOJ03CQ0MJEOPQAXq4ykijsvs1bkDXK7DQyap+zd+Ejj/hoCyEEnSnpy5jQcpb
         XrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726597623; x=1727202423;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRpwS5EhYTLRlv3stKfvp3FPqK2XQ1rkOQdzOeER/GA=;
        b=mtQXVAqWbVpz8JoFuKxsnC6TRO4Outl21qZjYfEf2dSg0yi0XvODGOVTPSQWT/6hhj
         6l24qo/2/M2XmIgwI+YYWq7oDZP5ZYg0LWoMnAOiWFUobDES8Hp1aqPrgIBhufi+RIDV
         JzhTKV1DWFbQ4IQ148p8OCjzuof/KgTb2KMynb6XAOKZIVyPxLeGAot5RT0bmog8CmGD
         Lk3imI0bRJDZMkCpsyCcBdYcF8Bw2gMBmvYfeH6FSQfOaKH1QXA+6Z5cC11qGEn7mQTv
         IE0Ogt4WVpEBOm0nyViW25ZvmxAHZDl8MNWXKzTtV2QFZFaTbQT1/pUIc8UCVBtwyTrx
         a6xA==
X-Forwarded-Encrypted: i=1; AJvYcCWoPx4+EqTAkG8deanAORsY6rwpMMZJR75dcc4/G1dPkd34VqnaF6EnvO0vSSNmRGXBytw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsohKvrUjsht2qBvqdspiNn5aA5WJWmY0l01uL1hCfXFaIsSVZ
	4qi/BGjTXTv8YwjzRr0snCar2ulTCfT+nGiQkjkOOSAB7Db72Qh2ZqQXbjW5ADr44HQpoWqlZc0
	f0rejd3Pr3RSbuujCp3byoGRskt7QGyEwwtU=
X-Google-Smtp-Source: AGHT+IEviDc7qZeDFzz/ZiCdxHyP5G4onGY+aF+yeUfeX78Sr2jU4JDOf6gnSoaGeDnw/SAk0sJE6k7/kw7w4Tsfc78=
X-Received: by 2002:a17:90a:740a:b0:2c9:649c:5e08 with SMTP id
 98e67ed59e1d1-2dd57f8163bmr1601639a91.15.1726597622897; Tue, 17 Sep 2024
 11:27:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 11:26:58 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1726578382.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 11:26:58 -0700
Message-ID: <CAOLa=ZRwLYLba4_mze5cDRZqyG+5+-F+sQmuzf4Lt1LKVo5_CQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] reftable: graceful concurrent writes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fbbfa7062254d58a"

--000000000000fbbfa7062254d58a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> the reftable backend cannot properly handle concurrent writes due to two
> reasons:
>
>   - It will bail out immediately when it sees a locked "tables.list"
>     file. This is being addressed by introducing a configurable locking
>     timeout, similar to how we have it for both loose and packed refs.
>
>   - It will bail out when it notices that its stack is out-of-date after
>     having locked the "tables.list" file. This is addressed by reloading
>     the stack as requested after locking it, which is fine because our
>     transactional API would verify queued ref updates against their
>     expected state after the lock was acquired anyway.
>
> So with this patch series we can now spawn concurrent writers and they
> are expected to succeed, which is demonstrated by the test added by the
> last patch.
>

I only had a comment in the first commit. The rest two look good to me.
I do wonder if we really need a flag? But that's just a nit.

Thanks

--000000000000fbbfa7062254d58a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9c9ce68399204e79_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1icHllOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNndRQy85TEVNa2lUa01hY1dXMmJLQnBWRnVMN3NYWAp4TzAyWm9iRmdn
ZWZjZmlRN3l5YUU2ZlVhajBFRHRPdm1lSE9rUFJHaEsxcVFsaHlqTzJPMW9ldUlQS0t1WUhZCnBr
Wng3OHJHYUtReVVXWGdoZHpwT2FCMXlKZGs3NlhhTlR1YjI2U0hsa2FxemdJK2VVemhicytaWlJn
em1UZDUKR3BCaDQwaG9HT2l0RXkwdzh3eGdPTUE5elhFMzU3bjhkRWhjbUUrR2FZMld5cEVabm1W
bWJyRnNHek85aWwzbApkM0lDMTFLeFFzV1pDOWJ3TTkreXNmZ1JhTEdWU2FuVCt3ZUhMaTRBM21F
Z0JpQU0wdFFMZ2k4SzJvTEUyZnFVCmFEbi9MMHdSZUFqOXI2UlR2ditLRUozYU5yTmE1c1dFZ3Vs
SHI0ZjZjWDBpT0JGUU5MUEVCNEU1SzZicExSWEkKVXpicy9ZYzhFZ2VtSWtDdUhwYTh0dUt3NDJ1
WmNrQjVLSm5CZG01dEJyZ2ordjAwaWVkcFlCQVJVRXpUUVBORgp5UUpQMmZITUNHbjNoNnZoTjlP
R1lvL05vYm9qYzRoSzR4dmVFL3pUQ0U2SVZaYXlIRjFTb2ZVaTljMENnajliClltaXcydjVsakJx
VlNkOWxlM1NnVzFFSU5FMEFScUNIYzNlRmdUTT0KPXJSWUgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fbbfa7062254d58a--
