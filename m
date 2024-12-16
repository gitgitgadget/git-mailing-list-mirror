Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614651FFC48
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349574; cv=none; b=qnsxvot1euiFdxbTpuSEFd96pBpTW4rocQ/aNS08MAKd8wjMYjL/l/tnvDYbj7uIdJTV8ByZ5AsnTKDDzZS249TXu9xJX5Cf+gjthhKQR45HYrmIFtH47NqjKAonvTmQY53Y29RsKVquvqid24PdHANgy89O2/7qbsTsNdC8Soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349574; c=relaxed/simple;
	bh=b1gkRWvGRmp3R4N786BzwVrLtRSpaUt3PHwFhk/lzU8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hbP7CmJ7ikcIENojCKkasM7cZIrkNinWEqyzRg9sGEk4gp7mb2uFthOrcjHe3VBEcRSwKkD7nn2eCsVnW3K9y8tF11UKxQhOUzKqRqOHzf/S2mU3RW2gSzF7bDMSvFmdegDcs0TyT4fFL2mydj2tHi6E1wf0oNu7L6r+2qk1SGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tet8V0Oh; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tet8V0Oh"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso1111695fac.1
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 03:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734349572; x=1734954372; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1gkRWvGRmp3R4N786BzwVrLtRSpaUt3PHwFhk/lzU8=;
        b=Tet8V0Oh482fSyJf9sYW9Xrjgx7GDu8sPL2N/ALXTsWAXawSoCm0gsjflADwLFR9QG
         gZSryEfW6P57CFpRTqml0eNPr1SuDHFNvWikBlmvjkQf12rd3PbbtS3p/v13xZMrS/3q
         a7d2IQRa6ULsfZzjMDfZQRZnDo89CbI4weFW7BMM3bHmgUCvsidt61GVhWbCu1Xw566C
         n+SLu5p2cgjYRSZabkHHRDR2OR49d3VKNvfNbCbxUOQWtaecMMdbFdkxPB/Orrl/tTWY
         u+kvUxz88B40rHRg28CoSokWzdWQRzkKIQaoennGW4w0ksOEpIyo6m72NYW2zQHaChdj
         nhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734349572; x=1734954372;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1gkRWvGRmp3R4N786BzwVrLtRSpaUt3PHwFhk/lzU8=;
        b=LVQNJGNEKTdANz/E125ErvElf7wuwH7vJB8A5xIAlan9+A+Fhc7r6f8t1CGyL3xp9T
         0r1Kx2CcwR2yJLl/5WDDCeoc9m01sF9qRpmZ04e5yeAFevpwGak863/PzcLVDuwCcSf9
         +UXCvYA1FrdEC7deisYzqZ65qptJRafbZatS8/IklGWSLvEEMuNBpCeuWPDWUH6b/CPy
         SKXFPWHbrBp5guMTkVy6FGeLcnkl2Bz9FaqlNH3cr+z43U5rfL3ZLwF3xib66/BS+Nk0
         peUkBl17ieFOsDoJVyinYqQw4X7SpXjDOiSUm+UXyfKmwIrOXz/L2YGLBJmw/eXK6UAX
         TY2A==
X-Gm-Message-State: AOJu0YwlC/yeFilJjBdZaOd8Yz5RSDDwcJsTcy7lYZgiK6x1c7T+LV9w
	LCltyihth4/IgAhRsck+d9Xdlz2nQqMjTZhRVchDq8YyXYgoJ1TPKnt2V44CAddBGTgwJ2lIIJq
	7mUgsrwQwrIgdC+HN8FDyrf3Tj5UmXYz3
X-Gm-Gg: ASbGncvaqPzwX/+6Kmzur79ORtXS6Ld9eqLazwSpht4GzYNNbs2Ssz0j2C07MHmyGFO
	NgIpJBJruZyfH5yDE9/H2SjP4xg06u3NfEo6fIr8k
X-Google-Smtp-Source: AGHT+IH6rnWgOgJwV05L+c+knOcerBRNdeoi/QSDS2hX19Lj5RDUo51u9Nbu1G6ULEiTXssxiqGXqPv1rGkZ7/QkPzc=
X-Received: by 2002:a05:6870:d623:b0:29e:1b70:95cf with SMTP id
 586e51a60fabf-2a3ac973cbbmr5825299fac.40.1734349572246; Mon, 16 Dec 2024
 03:46:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Meet Soni <meetsoni3017@gmail.com>
Date: Mon, 16 Dec 2024 17:16:01 +0530
Message-ID: <CAPhwyn20hzG=kBz1cUFhCaEbh1upV3V+M=PRuO=3MugDAKQiWA@mail.gmail.com>
Subject: [GSoC] Introduction and selecting microproject
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I am Meet Soni, a Computer Engineering bachelor=E2=80=99s student currently=
 in
my 6th semester. I am an open-source enthusiast and enjoy contributing
to various projects. I had the privilege of being a GSoC 2024 student
with the Python Software Foundation, where I worked with cve-bin-tool.

I=E2=80=99ve been using Linux and Git for a couple of years now. Contributi=
ng
to Git feels like a natural step forward - a great opportunity to give
back and learn while contributing to a project that has been so useful
to my everyday workflow.

After reading the applicant microproject documentation, I have
selected the microproject involving the modernization of test scripts
and would like to work on implementing test_path_is_* in the script
t7611-merge-abort.sh.

I look forward to your guidance and feedback as I begin this
contribution. Please let me know if there are any additional steps I
need to follow or considerations to keep in mind.

Best regards,
Meet Soni
