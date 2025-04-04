Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CCDF49
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778802; cv=none; b=uRzVnDdoqomKeqbulWqRKgWnLpoxDwet3XXNA24i3Qkw9UIqxW8TTQGBO5JE9vU5u5u1Ce7Xt+XqkNe+eM8tPrgrt8NKkpoY7HjFAu9t4nKBnW5gr3B3k2k4Q2TcsNHF9aqeZ7Yv1CnWhqVgA8G71JtrxOs4J67DejnTYTWg9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778802; c=relaxed/simple;
	bh=7moqpjHH8FRfouCbhpsaa8lUxslTKZBgLrEm8oPTsbk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jQsN0O/xfg9YprBe3SRrF42bDzeytRmY7lBk0SXkjBfl1m0lDyX7bIC2oevMCY6N88Hg6iepFW1N4vkqA9JkHChWa0z0wc+AofEUC+UTZZr9WFwYI/oBoEO3Giv73RhplVQ5y1cfzFu9o3mda4RrNXdiGnYK1k8t/VxiflayyYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHP6KMrq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHP6KMrq"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227914acd20so31111525ad.1
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 08:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743778800; x=1744383600; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7moqpjHH8FRfouCbhpsaa8lUxslTKZBgLrEm8oPTsbk=;
        b=aHP6KMrq1fh/0YsSeMy8WO5CbCwt2pl5KhSP62jfQ8Yg6r4J4qCyoSuAOA3IHAvIwD
         PzfXyRZKQRsVZz4b49PpJhbwNf7y1I5zvrNglDFQvCjJ8WSgzwACKJKZ0EVODMFAhNv9
         nZTBYpBCLXmCEvCGFDKSCoUq0sZYLJJVwk/4weCZn3dzC5GRed14B+vR57YogktwWhm5
         SCE1yh00cgddjFGgc1C2w+H6tOQivV7MeP/yH0h3SUF0RI8dNGwQ5WbfRMHFm643Pt7d
         BkO8PmKg7FZRwaXweJ48/46FbWhoS6rwlzpiDKDel9dXdx29yV9r9ZExZyVgQgb1EmHC
         H1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743778800; x=1744383600;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7moqpjHH8FRfouCbhpsaa8lUxslTKZBgLrEm8oPTsbk=;
        b=EzuppGxl6fikY6dxAyJy2ZJlKzdNebXbR9qfgNva/ef/UTAPK9cYxf2s5FeHU3TL/P
         X4MysA7IEANFoniPdPPN0mEhuGTFyC87LTODibnjox65HqpqzxIbX0pkguYOIhccpE6L
         jrnwHFKtvk7qYxm2Z8g6aF7Vmg6WJmJ/Bxt4dgFzVNZGZLplI+Z1Di+PZQ+8LRe1Ynvc
         utud7y+wQXdyAq59cGoAWn9iZYakAAq9pYJUjd1+qDrg+3Ja9EvKKYkaQS16U9mL9W5O
         XJ223+jxqpxOQ86cFRDRQcvr36EI94U8t09cEJaS0G1ZJiuz6XxUUl40fPouKz8Ql7Hx
         wB1A==
X-Gm-Message-State: AOJu0YyOgRYt1/Kwhkdi5NuH+mX3+ofJLtcNNnvcC2SSWC6sL/6CzIsi
	39sqhjyCENgthKRFRUKl+fbY0P5Rf5hqKrikT9elNGAXEeFld2GB
X-Gm-Gg: ASbGncutVvagAo5mtVG3yMYa62Oq9zvqoyL3NzY9f4iF97NOlTvdbjwsqZ+49PbcglQ
	52hYXKjDO4y6J6bL2cXEDeAvcEYscAdwTNPX+sFX0CizHmhawkAGnEt+D9Ubu9yNTEwHCCRt60H
	1Beg7L3WdQPfBGn+l1XF5vnB63AW5i1QxOh1Qc5SEqlNMFj/NUrnpgvC3S3EDQmxL52zX/NQU35
	OUem4rpJv2jzmKrbdDyUurCCHGkezOriHnVtnQGMKbbxanKZ+yZ1UmOhGfnkfp8vT/IbS1evGjb
	GoYREhZ5mvxEXVrUN0X6dnKQZIi8Uv6wyBx1qTs/vcHQo2/LWxqKcc2+60Be6YtOhR9ZKGiUr8P
	n8QFqcu8m
X-Google-Smtp-Source: AGHT+IGGq3z6DogYMrgamg6ju7fT6vSbDTtFxTdQwZn2puvptDrQzE24JSSsEHVdDOmaye64J0ET6g==
X-Received: by 2002:a17:902:e54c:b0:21f:40de:ae4e with SMTP id d9443c01a7336-22a89a3faf3mr52178995ad.9.1743778799854;
        Fri, 04 Apr 2025 07:59:59 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c08desm33141665ad.84.2025.04.04.07.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:59:59 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: problem w/recursive, submodules?
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <PH0PR20MB6183E53678E814C2B473BE8B92AE2@PH0PR20MB6183.namprd20.prod.outlook.com>
Date: Fri, 4 Apr 2025 11:59:46 -0300
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9274ED7A-0267-43E3-9AE1-DC0BBEC81E69@gmail.com>
References: <PH0PR20MB6183E53678E814C2B473BE8B92AE2@PH0PR20MB6183.namprd20.prod.outlook.com>
To: "Torpey, Bill" <Bill.Torpey@broadridge.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> $ git clone -v -b master --recursive =
ssh://git@<internal>/nyfix/OpenMAMA-omnm.git

It's harder to understand the problem without being able to
reproduce it. Do you have another example with public
repositories?

> The commit hash from the recursive clone is the hash of a different =
(more recent) commit:

If I understood it correctly, it looks to me that it's
another case of one of the most common misconceptions about
submodules: they always reference a specific commit instead of
branch or the latest commit.

If you want your repository to reference other commit of your
submodule, you'll need to manually change this and commit this
change. One way you can do that:

cd <submodule>
git checkout <new commit of the submodule>
cd -
git add <submodule>
git commit

Note that you'll need to do that every time you want you want
your repository to reference other commit of the submodule.

