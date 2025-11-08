Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E022AE7A
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 03:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762573458; cv=none; b=Dt9fyeK27hbXoFhB55WGjDVzNJYP1GdARrnoBJ67r60W7538ioswjlcex7Q1RRqvNpV29bOTOLgdaqwvJJysUOXBwSXJy1FAHXzbENuWmTc44VYXeOaDFhbGrRLVRQHx+pnqy0jls/DmpW8R0LWACglXrqPdFnxsGuTe2vOqzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762573458; c=relaxed/simple;
	bh=wbPtsPP9tHpOf21BMjsbpTqVfozXdCkYg0pc/F+MvDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iCRm01zCTQlnn27IvDyGQGBG5BpxFYmJA//CUr4Ce6fTEH7u70Sz7gnxZmf7sWYqXB2uQS9Q6Nja67cea+hD8/o/Pr+UgKIoTOCsheg3KMwNhFm00sN/C+uhjiub4IstwIcHLr0+01MwZ0ECCsFaYHOV+bSki6xDwXRfGdZAMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxm6LJie; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxm6LJie"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5598c430b75so783056e0c.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2025 19:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762573456; x=1763178256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84GJkoCsHlkHPsLDFt7Rx9uoHXyvv06cCF5Jd9HB5K0=;
        b=Qxm6LJieaCbOobctWfqZDDC++ysOURug8eCfRLp7rmovi9BbTb9qow6C3FE9uH1/83
         z2rPDk22wXI5COg5hEktN2rKtn/FcCeVJdP1ocytGNTfROHM0CCJ3OQ/YZnhQZiRqUa7
         jISH1RBaIoo8y4FH/THjqdYnOIQIBZRCTVI/SLXch6Qfmf2xJEi4Fyty3kgpWlTZJ/uf
         gMzpBeSzut/9lx0uoRdwTsWM7fPNxqrCm/WyxCO5P2VBH42jg4NGROXSLDSC+fEB+A9R
         W5WAVNMvYAR4UBsUcwVV12CfIhvuQFT3Q/J6ddowGW1EqXVm+yYoTyE/Y4y+0i2LvNHR
         /BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762573456; x=1763178256;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84GJkoCsHlkHPsLDFt7Rx9uoHXyvv06cCF5Jd9HB5K0=;
        b=aVw5s1ZR6Rw5sAZOCUNH+AQD6MAEzLujJBdzfQVBne92pA0MNxjr11q7lDGa+4pcL2
         o98N1bomq8NSsOUdzwn8pWK/SKuhmddWROQoHLEPT3FGNrpnbJ6es9dlbWJGExNgyuIC
         kdsYRkWlwH2gORpCbQwUyVeUibIh4d+hVN1XnhBGeGHXsQAP6fLoj9rCnt9nUdDU5GO+
         BqH1IqLNOW6TV36K4i35zIXuohYzJWAkRdEOT0wp70UPBlWMGqmfIkfFf/KH9J+XImPs
         SrKau5j4emSc+c6/rMe/kQpNkic/LZqU9rfPoP7pEJdpup7jdReEWrIiJ+k8dSXm/0e4
         bJyg==
X-Gm-Message-State: AOJu0YxOBqjmPeUoAIELvvBsrWa1AdtP3EHwihzi1z2wiCKg+C522OKd
	vgRFvgXyk/MtruHo6Uu4kYneBx0jzIyrMue768jH3r6DwC/LH32gGpiw/OnJ9pBVeIkLox3dA9n
	uKh47xmtjwsDVTzpP33uYZQ3Ma9R/1ScFHGTn
X-Gm-Gg: ASbGncuUtIoBZnvoCqgkYsS9fWOK0186Gqbnm++8C+EdEHeenwRFSuz9aHaJwqhqd8b
	14n5rS8cF0ZEjUmHK4ZzuqZcasAC31yWoZwiYMrvMXKOiJuYZ5FlzWZVzzpt8whbGAO4/Xka3i0
	c26kHfIZbRzr3tBsjwe9bhwj+pbic/Kideds20TNHnaGET+EYSoK9zqbgBVNoOn7ObuKPU5rOHi
	ROI5AEviEUcVJajGiQxr8mGIIb90c0B/6dFP4s3x6vWflvXrxdpJ1xAH8q4MY+tqBBXIc1u
X-Google-Smtp-Source: AGHT+IHJ1I8aG7/duE0GStImLscZZYFEG/tvuZvrGC8a5ZlEnzE6C+1hp6j3rUw47C4Dvoggq7czUQLggrKJkjnLu2o=
X-Received: by 2002:a05:6102:3049:b0:5db:d2b7:9511 with SMTP id
 ada2fe7eead31-5ddc4806b3emr596237137.40.1762573455532; Fri, 07 Nov 2025
 19:44:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEyHQXWd77_jJachC6FYbWMJ+L=KkKoUqiACQ7z8r-ZwYq8JYw@mail.gmail.com>
 <e1fede83-bed0-49e9-84a0-f026b9df6039@kdbg.org> <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
In-Reply-To: <CAEyHQXWd4kN=ehWh0Y7xNnPGk3ofXEc4=PvSYaZM91TFyLtnpg@mail.gmail.com>
Reply-To: bhavikdbavishi@gmail.com
From: Bhavik Bavishi <bhavikdbavishi@gmail.com>
Date: Sat, 8 Nov 2025 09:14:04 +0530
X-Gm-Features: AWmQ_bnz2WL6X4vN9nbDL2U1YKSgpPDYpwxFsBcAReQAtJjEE1cWXqLz0ynFaiE
Message-ID: <CAEyHQXUgzRnT=8Fydn9Ew6V29hfJcjR8i26mdvGOXaWD=agzNA@mail.gmail.com>
Subject: Re: [Bug report] git cherry-pick silently ignores error whereas git
 apply fails for hunk apply
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > If you use `git apply --3way`, does it still fail, or does it succeed
> > and does it produce the same result as `git cherry-pick` or a different
> > result?
> I've compare the file content of `mango/utils/apple_utils.cc` for `git
apply --3way` and  `git cherry-pick` is same

If I understand correctly, `git cherry-pick` is processed as expected, but for
some reason we are not able to follow this behavior because the end result is
missing content. expectation was to have this content either be applied
successfully or fail with a conflict (indicating it could not be applied).

query: is there a way to understand this behavior? Based on that, we can then
correct or update the file format to avoid such issues in the future, or
introduce an additional process to run `git apply` (without `--3way`) and check
if there is any hunk failed to apply and notify for the same.
