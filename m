Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254359B6D
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 10:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573106; cv=none; b=ERqi6zg0x9D3R1Auo72czgM+9bnN38M6abm7yLgQF6VT/FYG061/0qInpCFzsabAaXdro3iQ2jW1QRZAxq24gyXlFuDuIitMK5PJ1ZMPwMoA3vXKUZKwreINC5E+0acABfMAQfZxLmJOXCUTsKCmgVQNxl3Wu4vAdaJniih0Fiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573106; c=relaxed/simple;
	bh=LDayKJ2i43+n7wwG/nfLp2u7G5ZOzfcJgPpDzEkJKLY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dtdMHX45bXpJ4UB8EUDA/sR05jIs3z6EtPhLfE/Dtzv024F2PRYDGjAlB0cLx+0DH8YttqjB4RluNy7zs5suOO75n5j1eF6sQwng+X/bhOF9twmc0LontMiHnZv6QFv9O7HftRV+lGWROs7sVYZXsGJyCbaUqh+ik9e71mMh9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2o1YHyA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2o1YHyA"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d895138d0eso4423251fa.1
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712573103; x=1713177903; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mCERIsJcYO57CnqQhR+rxCilpw6HntYmHyiRrkTUb5Y=;
        b=f2o1YHyAr/bijOa3CAR/F6Zxah4cE7ufmMQ1VcrRq4Zwf29eOR0qqsw5PYg5usleER
         AgVbYUsthFxaAY/GZKgYOmN8nKEvPTlPoA0sm2bzj7u4wtzbAXIgd730gDafYv5nea9z
         wDZHza1hUaVWEAY8HP6DW1C1gRcu2rWm3Ex7WBwk+qtdAP1GdcoWRR23yxOZSAduT5lw
         bYsjvapGQ1AdQPfSqSzhErn/u1G1LgemWiq+cs5OuWe1gfaQqQsivlkuG7MltvsBnIjT
         A1Oc0HDYuPlJeJeWa2Fc/caIwfU7MWsO1U1xnhhI8Dsxu1y552BTlNk1f4OKNoVMeYdO
         dfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573103; x=1713177903;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCERIsJcYO57CnqQhR+rxCilpw6HntYmHyiRrkTUb5Y=;
        b=C9RYVukw5G0qx8zmLmsa41hhy+ZbQu8WObcLonypuEKh0fFLb3IR8Ha6V1aLbmnvr6
         GNgnxKBfI6XvN0K9++W4XM7yALOsFQcaEbVC4EZO8RyhfRT6FGBwncWKEo6m3yKgj0qN
         ZY4zNUTeVo/GX00SKLYwnjAyyyLaETGf61u5JiM9d2di9ed7lwBQRGnV01xYqyxwhrGC
         sulVdFd+taoB3/vioGGCtJN1mQL7EWsIQULIR/fjxLQyHxo/AZXo/50gpLjFRC9sTC6a
         rqDpMe1iuLBLkzt+qHxZdWo+w3oEkDzydHKDsBWw+zowwdNJA0Ys90ffKAuN3Zc/yctR
         A2oA==
X-Gm-Message-State: AOJu0YwPBpspXyhFTB0hqVUsRqmF7ExekOWLzfuStT21odxw0YHOZWf6
	TUAMrZx/ypgdnqbJmBlUW+ahEianQFdV+dXPkNYCVnCfXYw/6oSEVAXezmX6cg6cyTVnR2Px5Au
	nSHVb9LJNod8TcjIysLmK/gd99PmWj0FrLAo=
X-Google-Smtp-Source: AGHT+IEo73+uDKN8LJYris62tUmxdbK9/KhgtzdePg+QMFg9OzmfOsepb0NtYiwVUR0F9v5pW5yXm59efixa1TrK/5w=
X-Received: by 2002:a2e:8256:0:b0:2d8:592d:f47f with SMTP id
 j22-20020a2e8256000000b002d8592df47fmr4889820ljh.44.1712573102507; Mon, 08
 Apr 2024 03:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dario Gjorgjevski <dario.gjorgjevski@gmail.com>
Date: Mon, 8 Apr 2024 12:44:26 +0200
Message-ID: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
Subject: Makefiles are broken as of GNU Make commit 07fcee35f058a876447c8a021f9eb1943f902534
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Git has plenty of conditional statements in its Makefiles which begin
with the recipe prefix (tab).  This used to work in the past, but no
longer does as of GNU Make commit
07fcee35f058a876447c8a021f9eb1943f902534:
https://git.savannah.gnu.org/cgit/make.git/commit/?id=07fcee35f058a876447c8a021f9eb1943f902534.
This commit has not yet landed in a release, but it probably will in
the future.

A similar bug was recently fixed in the Linux kernel:
https://github.com/torvalds/linux/commit/82175d1f9430d5a026e2231782d13da0bf57155c.

Best regards,
Dario
