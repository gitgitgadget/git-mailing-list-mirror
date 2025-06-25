Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FC2E0B67
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750883489; cv=none; b=CSz2P+N1q/kbjBkWDQEaASXFxdBhqCYoAaToR3izdyZJg59tWfTxByKfASFf6UvvrkdWIyj+7+U/tMrSrxsY/3uGxzb6HbLFQhiTxkov/d1kckMRgC8Hl2xzr3gEgcRJmR1KPDcmTAOp5eA+KhSDipTNlZIxl3JnPVbrgbXBZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750883489; c=relaxed/simple;
	bh=rgcl0VvIPNqyKtNCTg4RRM938CvghoBMSkPNvusvnV4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=f0w8g25x+s/G03VDYIdWCYAMb5UCLDxQAdms+J3xa9wqrhzaFmYpELJ7LdChMEstm3tZ70/FdgDw1fk3r8WjLkh6aqoA3Xe3uwiXvK4R7BDUqQ7BbkTJrPuKQktks+QXTdJ7e/Hmve0nHUjQrKEGWELaUW/9ox5vRpVcr9MOWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9FjyDEf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9FjyDEf"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6095f07cd53so37655a12.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2025 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750883485; x=1751488285; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4WH57YHSf8rEpcJ8A/pJiIPsQOOBuTSgNt7IYzsWAw=;
        b=c9FjyDEfVpuOcz7qm2GfqMC+mNF6XatDH1qgg/fq17wuPXzH4WxZOf526Niwh2r7Vt
         ubVkjIBwa78PMN7fDlwTCD4lHCczDMozsbeUAqU4pgz2wu0w3wxgbZT142SpnVirEvOF
         3hvHtly4YfHSghiApDhZQzR4Y1vjB7BIN7JLBWAdsbCU5KD006qtfXfU1vHwfI7uKMdp
         agshAD9sGXpA37WOL5qPCTK6ndZS19mT6YHXAPi05eICEPUAmBtzqgwCTjFpM7TpZ45a
         wcb4sa6jTtQc+JaAD6zsTEKwO1v4SgbKggt2QadmqrUH4EmvNrYglVLzxuVb4xYAvlei
         +/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750883485; x=1751488285;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4WH57YHSf8rEpcJ8A/pJiIPsQOOBuTSgNt7IYzsWAw=;
        b=CeHVYFjQUyHugRTO8ueefG+RZtD338wgI/yLDE8CeXSBwftZHlixaGSz7m1M44Yqh0
         tZP2mi9B5nFsgsapCym4akJKRc6eXn2U6hZBMA3sjavb6Ct5rYeIq0iow9DMfzLKX7jf
         nXsWqHN8afTtnnRjJKjUJf8H6R0jQuN1HAsBmrZENHGH5PaSYfSw/nEfU9o5J5ji3B2W
         1vRsboRMpXYrH6rQqnjHahKKFS1eEARa8eYGdbDK4dYpLxE7SJvmZ43pKCk0JDL1uAEm
         qm8MrgSUktCyXmAsaql+WX0ruXWcA2LWOhWJ1QB01O91PEvQ0hi73v8gCpVfk7WH4XO4
         wIEg==
X-Gm-Message-State: AOJu0YwFUsUID31NmuveJn83iLsR/Y5ODtoQQclXPXlwECKCbYDKD9Ek
	9HgeaU0KM2xkfodlpWZawKRyc/H+fhU93DTaHFI9o3smow4zRnErSf4mmR+nnagUiNH8YibsSPo
	lS4FRxSooHcWWd6US+NJkjINNCB7nmTLPaKaU
X-Gm-Gg: ASbGnctNkMLtJFqUagwgYID7IxT9B/YhI9AQimHYrhNsYbiSj26ZCvmGXTIgx0KlU5w
	kvbMtUTuLUGZ6oeNLXTCDlmDntVnfg+zWGqkwaRGQcxeo3c2PCmLO5Sj3NxeyzifTAyGG/4LFJo
	Bt9WjME3eAwxPU1Q2OffiiAM3g2PdQ+9A7T4dOOawrFx8gRMTkAM9XiTDlMh1Rphv0MJMiBH4L
X-Google-Smtp-Source: AGHT+IH6QeSi2PDvHQyGRNYCPOmLesY4p9znVtBErrB6BsYFHz4Uf/hdBU7uElPZqpC/TVXMT389VL+HhsjVmDIxa60=
X-Received: by 2002:a17:907:2da1:b0:ae0:ba0e:ae59 with SMTP id
 a640c23a62f3a-ae0be91968amr160141566b.7.1750883485309; Wed, 25 Jun 2025
 13:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Wed, 25 Jun 2025 21:30:00 +0100
X-Gm-Features: Ac12FXyDyej0V4Ej815GSIEOuQskxnoB8tYUqrq_mDP6VXAICk0KV02xpsvtwHE
Message-ID: <CAGJzqskFuQqLHgFk97S9uaBB=iW2Ni=NWokHJzMV5rYGsCOG4g@mail.gmail.com>
Subject: How to exclude tagged commits from git log <revision-range>?
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi. Is it possible to exclude tagged commits from a revision range?

I tried

     git log --exclude=ref/tags/v* v2.3.0..v2.4.0

but this didn't exclude any commits.

An inelegant workaround is:

     git log --oneline --decorate v2.3.0..v2.4.0 | grep --invert-match "tag: v"
