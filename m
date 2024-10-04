Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C925634
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728013239; cv=none; b=CzBpsGRTZvz04jtSeOSvFKV1rulPv0OznI6brrBru8iUYXJhvrZNFho9QG2v2pBqdwpwgrbKRd+XjCeIckTZS2ZMltjdmUSmNwqibAhEgw4ZPLAE1/Ng8i4eSWxJnOitdNeMg0VVk5QYWBu4KcA1xndzlMZEtNeuET7cnnmrdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728013239; c=relaxed/simple;
	bh=1+QzvuCNg399uWRWuHUlD+L5PxDyw2fLEOQ5okGmai8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Eabwfv5baE5Y4NEggEQXUOsmzYKqBf8weNhBUDP4g5LnGpSn1EhsmSoOWNtCwjlU8pUzuW2wLrdZb9bwegbXdC/RZXDiPmfNl966f+13/gNrANke4Gf3QIM3ONzDIKleAkCgLyXWUltMm76IJrxTstK7Fp03EkyKPycaVlwV5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmGk5VkW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmGk5VkW"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso13462586d6.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 20:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728013237; x=1728618037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1+QzvuCNg399uWRWuHUlD+L5PxDyw2fLEOQ5okGmai8=;
        b=DmGk5VkWEyzMs4TdAhumgyacCRrkzd5kwzgEh+3UqjpzfJjbWpuoJb3/9sZo1Penr7
         8cJ2LiXjc0Uph07Vxa/hl1PGddrTPwGnhjy6NSC+z+cIofv8pLYOs9/C4S65R8c4RsXw
         IJwWvuAu4L7/WQXQEJza4LkocanEwLh4ZKvV6OOzHj1uOKPACBW/GJZGCmgwwISydw98
         8SXzW+btmKTHBN9YTQKsPTK3MmS00Hms0Js40euvPlsFt0/E3XOQ65sfdFyRkKtTjiV7
         9MNNMZFQ6STly9ZGAK2hyc+yL3NH+22t+tON7j8ZkKmZ77LB23AnNt777H7uJjF7CLWU
         rA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728013237; x=1728618037;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+QzvuCNg399uWRWuHUlD+L5PxDyw2fLEOQ5okGmai8=;
        b=Mqbr1e1SdpjHshHTof5flJooRVQnFjbjJIVoD1i74kKlAYUuohQcr/vXhVwZ8+FrR3
         CLqC9MbXRZXWk8N95HwyOsLYbUfSPkcZyKnicif3U4H7wz38vLyXOJNZfuQI+4rxN/5v
         zi9Bs/OsYSALVBCb3nCHo7QhCe3KtpK0AWF0FTTFMeHcniLrWFkYCn5BVfKGnkvaBWMI
         53WZXEjIvfe0f+LBMvazBObHFuC44Z6uw5rej5B6WZTCNiPg2ZUIXmZHfHfjCo1haRtM
         LD1zuLPEbgLucwe3CncYu0hOJl7A5qZZwv4ttKwDcSURr/ta/HacTg4BHtcGeF3f82Uq
         /mhg==
X-Gm-Message-State: AOJu0YxS+4U9vOZcuEV5NR6vvgRuhvsHKHZjSN+lxTzPqrba4Vcn4YTa
	k0F9QlwQ7FXKRRrAund9tB8GkJz6sZNYYqZ/YboPZ1HZKJMfHFXxDrJeNT83A2i1N40Mi6J7npJ
	RZ3xWDvgSa8+S8XEXLv+4wh+HB3k=
X-Google-Smtp-Source: AGHT+IFc2JRRN/evLfclzcT2eJZbmCsxLwnI+aGMDCl+eS/3oIu2AZngGSrFOq/lDHZCpmYz/yluNptnXaiYZoq6QYw=
X-Received: by 2002:a05:6214:3f83:b0:6cb:99db:bdbf with SMTP id
 6a1803df08f44-6cb9a4e7955mr23691416d6.43.1728013237033; Thu, 03 Oct 2024
 20:40:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: abdulwasiu maryam <abdulwasiumaryam@gmail.com>
Date: Fri, 4 Oct 2024 04:40:24 +0100
Message-ID: <CACUwfm6S3Qm=VHvG2a0Yqh6FdOhk9S3BzELr7p6HAL8qmrgGyw@mail.gmail.com>
Subject: Outreachy
To: phillip.wood@dunelm.org.uk, ps@pks.im
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I am Abduwasiu Maryam, An Outreachy applicant, (Dec 2024).
I would be glad to work with the git project #1 "Convert unit tests to
use the clar testing framework"
I would be glad to intern and learn under your mentorship.
