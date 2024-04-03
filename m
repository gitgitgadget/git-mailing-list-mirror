Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1054725
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137644; cv=none; b=imdKGovTIZQOORrqhrIbnJtp+w/kzOg19PZcceRNwmx7bZCfAR+lgwLO9R7hbQF0XbqA8jB0rrtoOdTsU6osqvHbnsTNjjWDROEnMDEAWDaHJM3BS1QL+uoKtgDZ807/Ziu4Stq4aMMF8Xk83b9FmJbl8z/hjlkwww8ySz6Ul8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137644; c=relaxed/simple;
	bh=01KKvmvbtN8li6/ktuHHKXuTjN0CbZfMjCqPiPur2Mg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lE86XoMG4X4MltT/JAg7RsJF3Ry0luGVGU1djq8C5UKu1gqwmnltYQIWObX8lD3pEp7v4eaYlP4r347YEd2uTIMpMz8/i8MvZt1VuQoLHbFK37mijEGrLLwcWUFGJGC7lYknMmUivKOyMeYS2Xpxu9RNz+oddZyWI2QqHL+LoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsoe52jB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsoe52jB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e2987e9d06so2006425ad.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 02:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712137642; x=1712742442; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/OzxRLEGWGWJbD1kndKEQpWInbFjR63D/aKgRD7Kh4=;
        b=gsoe52jBbVH3+p2r7ObAttwI4yjqWYQi70+Ohdp4TD7wNeukvB+hSl46/U9LFTn1KP
         0RTpv3RlwzKAhRWHCZnKRJtnN0a9cvd+R7B2BfcTcXbBJP9HFcH8tWK0BTyNKs5/YyB5
         Qrji2dSkiWHpNQ4w0qVEWOepzVZE5bsik2eRnN8IZbkcXEbMAEWY9jgNg6pD0EjRWgFp
         IJSeDAgSfFheOZSyQ2GBWxy/fFD6RvFH1RnHyLHWLFVEIcPEHuWguWwi3Ltcez+L7sa6
         cKqdgzKcV0+0a5s0YsYcdOYIU+mj7s26UI2EY0ysfqoGxrddzLeetcTHYMHfspf5hvGv
         M1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712137642; x=1712742442;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I/OzxRLEGWGWJbD1kndKEQpWInbFjR63D/aKgRD7Kh4=;
        b=Z1lxR2um/Al94jpkAHaAaSxidMF2tAYyCGZ9zTQGFSB/Gp6LwzEiyI0vzK/OZ4IRgP
         YtzCac7Q5riEQjX7SW/2mlGqNuqNyma4SK3FnFciwvnRpWlNCZCmc70bVeG1vqBY+zeR
         TK9aDdzzSeKD9Rpi6h+5UzTECo1M/YcYNUPag+9zL3Fslj/JCgfKJwxolwBLIMWnXXZT
         DifN+rYjNgOOEpXSquSZlHb5orpJfk9C6TL8xDGEtcHb+k1EMAQ8s67bfLB4tRQ0M9De
         /rp4zmHYlwSSQggbicdqiHxQJc1eOtLMs0RMd32G/0ccOyi4PBQ/urnnBzV3I++RqisD
         i74g==
X-Gm-Message-State: AOJu0YzjCHRNljAa98R+4m6uw+qLn6hkdsFw0jQcjNAgoQef8k6/5l51
	6r3I6S0jmynwSzMx5I7a2c0a1T06ViMUmCv/ch5j05I8rBBxzgk8bFXcQKdApS5UcpnMCUh3+Gf
	7fHVS8rZwiEOiFgpVHTD/Qfb/LPI6l6eQq0M=
X-Google-Smtp-Source: AGHT+IGO0YoG9eQ2az52lqNTb5i0f20v7x1FcOcsipHhn64KajK1fMVtw/zsY9pu+2+mSQKjEV+cLoYXkD95/ufcwRY=
X-Received: by 2002:a17:903:2b0e:b0:1e2:7c72:767 with SMTP id
 mc14-20020a1709032b0e00b001e27c720767mr3590591plb.30.1712137641929; Wed, 03
 Apr 2024 02:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Wed, 3 Apr 2024 11:47:10 +0200
Message-ID: <CAOw_e7YspBkOo7QE0Z3QqWXd6P1OVnF9j3q7ircrce25KNbKLw@mail.gmail.com>
Subject: Subject: [PATCH 3/9] refs/reftable: skip duplicate name checks
To: git <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

I can't remember why I did not rely on the available routine (did it
not exist at the time? or maybe I assumed the files backend relied on
the file system to enforce well-formedness).  If the functionality is
covered by refs_verify_refname_available, it's probably better to rip
out of the reftable library (essentially, just delete refname.c and
friends) rather than disable it. I am assuming libgit2 will have an
equivalent routine as well.

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
