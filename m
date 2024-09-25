Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C418C32D
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274480; cv=none; b=CWbiEhrGZYw2zXsApQcgEsaagLMp15NlT9eVj8GLsnZ2FwkLqcrGqOZCclrMReF6Ybr+ZRRoi8e1J09aUZ+x7clpMbL9p38oLzMvKMHFwnINDnXOXVsQ+v/dNUPRqgAfa/vgOnplCBuyxmAZ9IXYDKRawNU3xhDHIOfNiHjw44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274480; c=relaxed/simple;
	bh=OhnhXkr9wiTu3OlqtGj+tePFmdVFJE+CZFPsffnApRY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B1nU1Yrenn8rUYM+7b1DxXcpHBoqoinCuWjqs4CxGEPOQqHm/Qb7NA+ZPS8RDtv8Q/kkiS35CmonKhGzoKSfy0kcfcVF2rf42vWptQmRkr1FhJF76c4xqoZwnok9ZNk8CYU/hp0QHxNlIAojHUm7YOYWYhdaG8DjUrnaZhvtw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e26J7qAS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e26J7qAS"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e07e40e7d2so428676a91.1
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727274479; x=1727879279; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OhnhXkr9wiTu3OlqtGj+tePFmdVFJE+CZFPsffnApRY=;
        b=e26J7qAS9y1u/FPrGVWtPVyRAJ+rutWlcemFS1Ft4EOXVi/wMb74gWO6kYQB5PAdu5
         J1X/H/Xe0UZ0kGr0xrBvBBJXzPyWhdW70IqmvMPVCl7L2OYoGhc/BRS1bMW0N6+dvQ8e
         +BV99H+HaPIOqs8waTmpAqCDsrn8beiinSzngN/3Alehi3aR/18QfNqb/YsPADKps2Vc
         EhAtUMRhsDTZAJFa4ffYT5ypJS5DuGKZko+HOhYwM1ExuKbExfP+vP932f6H5WiF14LZ
         FvK4CaGEJTf2oMzNpdM9mcoQMFON4cHj83iquZFG6zp4L7pn/PTNVXZRzSyvT+fE8COd
         a3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274479; x=1727879279;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhnhXkr9wiTu3OlqtGj+tePFmdVFJE+CZFPsffnApRY=;
        b=jy3Ay1QZVApKpm6CLztCiMt0E1Uk30GjbAY7NpxESfC4ubYYFdwt35S44ohge3xsYd
         JiJWjxLtVuzg01R665Cs8G9FOR3T68yvaT+7POG/JpD4S9+gsfwjWrrvyehjSMApmFSO
         1wfFgmKhTSwn0DzP93X6jHqTFhdjogjhjSjQ/ZlMmsu1p2tGUt8u9TKqp6AtU00iWn3G
         cZ+KybE/qQQOT6DxVqstkr9jEvWU/3jyYZhLah8LCKOXkfEGTW0z3wMJrb0piYm7rEdx
         PekkCoeM2LXl4mdzYpaxZsPZA1ZzFWbg8jrtryz85Yzoa9pKgqinx6hq+bgKD2A8jYpA
         O7QA==
X-Gm-Message-State: AOJu0Yx339zq9zN696TlXUpyj4diUIkh4xKxI1w1fImXVxob+1YShjuU
	+VMRtuUdMLc0Oex/d8l5m+uOqnXudBtGi2OgBn7OeE2QU8dv7aUrWE75vPOfCdm84Xc3XpjLh65
	Lw/EHr8hwFx9sr5kjoAYkk9OAKTKANoqyE98=
X-Google-Smtp-Source: AGHT+IFj/NC+tc+vPvnbsRHlfjuWpVEVMEMmt9s+eXhFRSAjbLsIb+jxQYUSOqoroSNmDCGifTu8/77cus5Ro/LjgiQ=
X-Received: by 2002:a17:90a:e2c6:b0:2e0:89d5:985c with SMTP id
 98e67ed59e1d1-2e089d59bf3mr1136518a91.13.1727274478631; Wed, 25 Sep 2024
 07:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jan Wendland <jwend1703@gmail.com>
Date: Wed, 25 Sep 2024 16:27:47 +0200
Message-ID: <CAB0mhhz9LHZ1AWSu_0oM=c89+z0w=XemnQwFAm45wp8zSmQ1Sw@mail.gmail.com>
Subject: git diff --exit-code misbehaving in 2.46.x
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey team,

git diff --exit-code in 2.46.x is unexpectedly returning a zero exit
code for files marked as binary in .gitattributes where 2.45.x would
correctly produce a non-zero exit code.

To reproduce:
mkdir -p git-exit-code/dist
cd git-exit-code
git init
echo "hi" > dist/main.js
echo "dist/** binary" > .gitattributes
git add --all
git commit -m "Initial commit"
echo "some change" >> dist/main.js
git diff --exit-code
echo $? # actual is 0, expected to be 1

Is this intended?

Kind regards
Jan
