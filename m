Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945D2066FF
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261051; cv=none; b=W4LHKoLM6JxNpikJ6tE1Nci92nW5dtANi4mcZW8kxRLTTRasNYR0ZPpJUI26kjtIPx3xICQy5uAMlWWMsfh56RxBVKH3B2OGn6wtHq75SYvlvcH81IV/O7WrlYUL96KZQ57Iv9HhtAFy6flCVCXZYKgwC98Xst104YUSt4DgN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261051; c=relaxed/simple;
	bh=DhDTKYTUFywAb7w5PR8RefdzxNLP21JNrtOdEmGdVAQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KguXGnru6NFevNstqKiDs4rLhL7EiZ7OVo5ZqbMHzp4/mJPGmMsfmMFEZJ0lxGrFiqL4An4r8uo/ujrCkFdbT+ELMVRU4XlcpHWNRpkufGQBu9/eu1u8GMnpFd1MQ/Ufijd9A2FeE1GSNipaeK+jy9KcupkHoZ41gi3Lc/h9XKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bugGI939; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bugGI939"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52384afabdeso550068e0c.3
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 03:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741261048; x=1741865848; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DhDTKYTUFywAb7w5PR8RefdzxNLP21JNrtOdEmGdVAQ=;
        b=bugGI939w0MhxRFYtbY1IsegN6QNKKLZaceaseAWza2tp1RvVxGmdzMktdQ47s5OGb
         Dc5vXxorJy/7P16wzbsw06+GFAT3GqH2UnfqguQ7NWfF7KqRyYajPMBS8lBXRvWC/HPw
         4l3Z8cSuXvgg088/eMelrMk//3WF4fQfDIPsi1qModBOcW8RXhO/zo+W6h37d8OeLAvK
         4KGdRt0TiEo6NYA82Ds+3GaFuwdGCH4RtHX0BC45zVelHUnk6GKdqzAVHEbfIwwKBJEV
         dSKVqj1Z+9/uUEIvb/mm3hgtn0ZjraLHLng8BMSBXj+EW0KcMFUR5g2FPawD+O4QvP+I
         nPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261048; x=1741865848;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DhDTKYTUFywAb7w5PR8RefdzxNLP21JNrtOdEmGdVAQ=;
        b=AEy0rLOqnpIyYOltPKNn7Z4a96Q7Dr3fmPafhaVN5eFp1DCGNTsmofhPCnUE5MRoHg
         NvqCNhVbX5M5rK21QVu0Po1Kwc6Ycl7FynFpYEslSfNT24e1SrbXPb15qWN7UZQeiA4a
         wgVon3rmRRbFIv12pmGsmVvX7rjghrdppFZG/8WTkAk8VAuBqZJlnkw10pARGr3Gh5aI
         m5FGx56ccjze+tvEJ9M75yBGpIOG6yBBnWFgW0T1BTC/+5CrKsJBW3Gz3rjY/Yg3KE4Y
         3Z+e8RclyptPtlmP4SeR48bV8XiScznAv/C66i2SSmhc7otTh+i3R42I9yhG4iVh10Z6
         Jy+g==
X-Gm-Message-State: AOJu0YywBLRlSrPpHXx3rRATiNOqBPiOYxY/jyxwihWlBx89ysKWqnRf
	hyoLSZ7HWvYqNq/YZlt5vgtY2yXPwrMJH9H3/+76nnm6U9pqcGvK7Qt4Qw/J40zG97Z9WTzmFu0
	YpOBTCi1kyJfScT9r6nn9sJQ5CLYrjPgwgOk/cA==
X-Gm-Gg: ASbGncvHOITpQWeskWkHNn7vIsfKDwp3as2Qyt5spTgRBImsn/sM6upA9yiBlxlQGZV
	EXXAKuiaW2SfegjlSXvZRsYN4gJw5yNxcAa+go9Uhf/ZiE80RidBMNqbn2Th/ZXoUXqoWxLMSMy
	N+KUc5GR78xlTgdbMF/V5rQiuyVjlrBYtuPhdL0I4qESlLJKH7PYDJxgZ7SN+e
X-Google-Smtp-Source: AGHT+IF5Etp3WiEwTmNlV9leVFIZURpOzIFpGvnNC1PtNIWsprVjTPZWV3RCv5JqbhnSkbXmDJRhX9771z6fY404DD0=
X-Received: by 2002:a05:6122:1689:b0:518:91b3:5e37 with SMTP id
 71dfb90a1353d-523c616da98mr3979274e0c.5.1741261048379; Thu, 06 Mar 2025
 03:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yuting Zheng <05zyt30@gmail.com>
Date: Thu, 6 Mar 2025 19:37:17 +0800
X-Gm-Features: AQ5f1JrTKlt0NGSR3Xm0dek4J6QrHYnQD9dhJYXZytjkHpTJBqWM_xbkzzEBsSY
Message-ID: <CAMvj1+pyx2pphafmPwkZoeEnPsDcp3YZYjGSO1kMtdOOnJ=PYw@mail.gmail.com>
Subject: [GSoC] Introduction and get-send-email Microproject Plan
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I'm Zheng Yuting (Daria; She/They), a first-time GSoC applicant with a
background in Network Engineering. I'm preparing to work on the TODO task
in git-send-email.perl as my initial microproject contribution.

Current Status:

I have searched the mailing list archives using keywords such as
=E2=80=9Cgit-send-email=E2=80=9D and =E2=80=9Csend-email.=E2=80=9D However,=
 due to my relative unfamiliarity
with the subject, I=E2=80=99m concerned that I may have missed some relevan=
t
information . Additionally, I=E2=80=99m seeking recommendations for more ef=
fective
tools or methods to search mailing lists. For context, I=E2=80=99m currentl=
y using
aerc as my TUI mail client.

Requests:

1. Could you confirm if this task is still available for contribution?

2. Are there any recommended advanced search filters or dedicated archive
tools that might improve the efficiency of searching mailing lists?

As a new contributor, I appreciate your guidance to ensure I'm building on
existing work appropriately. Thank you for your support!

Best regards,
Zheng Yuting (Daria)
