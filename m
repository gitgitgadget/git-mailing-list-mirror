Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF682291E
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726901751; cv=none; b=obeIOZuYEv2IF2Nf2T4n3Od1FShsax+xhYEZ2rKSRYAtatR/84syXeQoy3Jpb+IbSki1ADE6X8Jk5+EvrlTKtju4Ptz0c+P4+wh1PsFyou/b9TLTSMKMTt9oQ6qh4KGavOHREL3ssO4TREQ7buIbrWB8+hmuKE/Drcjmzqle9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726901751; c=relaxed/simple;
	bh=Gnq3SDpPPWeVUqIv2nnB2JNAqPBQ6d7q0AMvGJp3l38=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sjBnNm8wIW+ns6E8Bxwlp3zYT+wGK1rR7G4ni3EuJ5Mm+TwRgR8OCtvImTAML4TrxZKHoPwhErEGbQj3iTqZ4Y1IXXQxPM2Q7N5ZqCgE4Jv3HjLn0VLrFiTlAVoUw9xfor3YG0MNsJoCvgRGxcGrJDQVSv3LGUW2cYeOhgcebVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGELUIxR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGELUIxR"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d3cde1103so19801266b.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726901748; x=1727506548; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gnq3SDpPPWeVUqIv2nnB2JNAqPBQ6d7q0AMvGJp3l38=;
        b=lGELUIxRF/9sI2CbuQeSjIUzMs0SNDnFzxQa4PBNVjipxPfPzgTNKRjQLfAQXVS5Ui
         u0rNJ1WKurizBEOse9n7wtTb58DsRQ9yU0AqUqYOKlrqlF1kejeW8p8JKZyylO0hQbVZ
         zS3D7D1RPHHylga9hsLnerZAF8UQd1TZ6b1r+G+ZZ4X+MHZQfh86JTtN6NYHhrG3fc3p
         hhY1dSjN3E6DczQR5344TYxLfTXGAUJk9HIgp2sY/A7TnOecoV8rhLwB8xG6xMTy8C5w
         zwO9PGE5MxlC8TmML5EfhzzlBoE8nN42E3OfQH1+YkgoxJHHQWgc6beYJ0ER6iydHaMp
         25Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726901748; x=1727506548;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gnq3SDpPPWeVUqIv2nnB2JNAqPBQ6d7q0AMvGJp3l38=;
        b=BscXBbffc3A+4O+I+zlTDEtWS1CHus9Y9PqSKW/KFE0ZKOVsXBYU8Ho8M+lcgMqSnQ
         QV3xoq52ecyW9K2Qr/9B0MRlzLdCElSBPpLsALArFfm952sm4BO2J2MiB/Uvw+gPKpPD
         VA+imDHjv3oaMKTHUDO24uGBb0jv+Ltv4koVn5mQ3Mi4hQANiB2aUT7VYramVx5C2J0Q
         ABQ8w0lVqjysw+8J19QqnwZDEnHjwx3hj/swshpMtR0tN74E275z0y+dDdnCINIAiH+G
         mh8oO3+BB7+4LH/0uMP5/5iXbf5A1u/XFCCShsBmyuNs+U9DVnJwwvPLaXzDdFWVrAHb
         lGRg==
X-Gm-Message-State: AOJu0YyaMwMxS9twnVJ1RMMvLQb6D4sWJ9yM9VeyRRkCs0UX4m2bWLY1
	7eP0LpBR0/onl+QfNoh633APmA72S/zc98eNUqE2YKob+Zv92huxtWiKfPBCVA6ggbJ7PG4VK9W
	gTg+UwaOzlpeLjXcKePWYtZ4vicfanPkJ+vU=
X-Google-Smtp-Source: AGHT+IEZekBiev+o6Ac7DdRsRcPiEt6/lBG0jFtVkT2pyXQ/erMFi5QmHbTHWAZnaywP0ugNKwlVIjCB15PmNyxL67o=
X-Received: by 2002:a17:907:e656:b0:a80:7193:bd93 with SMTP id
 a640c23a62f3a-a90d565bf4cmr500737766b.25.1726901748087; Fri, 20 Sep 2024
 23:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Khushi Bansal <iamkb2808@gmail.com>
Date: Sat, 21 Sep 2024 12:25:36 +0530
Message-ID: <CAFRk5Gwt7uzi0ErXrbvVfRAtSbEV615bPzaPnxheFB3=0DJWKw@mail.gmail.com>
Subject: Request for Guidance on Getting Started with Git Contributions
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Git Community,

I am writing to express my strong interest in contributing to the Git
project. I am particularly passionate about command-line tools, and
Git has always been a technology I admire. I would love to make
meaningful contributions to the project and learn from the incredible
community that has built and maintained Git over the years.

As someone relatively new to open-source contributions, I would
greatly appreciate any guidance on how to get started. Specifically, I
am looking for advice on the following:

1. Best practices for setting up a local development environment for Git.
2. How to find beginner-friendly issues or areas where new
contributors can make an impact.
3. Resources or documentation that could help me better understand the codebase.

I am very excited about the opportunity to contribute and hope to make
a meaningful impact by improving and supporting Git in any way I can.
Any assistance or direction you can provide would be invaluable.

Thank you for your time, and I look forward to hearing from you.

Regards,
Khushi Bansal
