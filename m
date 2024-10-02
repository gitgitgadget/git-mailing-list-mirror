Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DD71D0BB5
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884253; cv=none; b=GIuFFx9DgcpqZQDzZqfdObXxFCD//2xFiblpnSIzIC3FPxhU8Ce3/ObRjJoqg3db+ViJ5NGaq0UnX64HKnSMeehZhL20rmCR4DsYvgWQv2sbYv7UumOkvXe4I7uZw7R3RZ6ywtsp+IvV98DIrSFZgQNzpngkl12Nbd9wFIlBY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884253; c=relaxed/simple;
	bh=mwwP5OLLPE28D30nBtKot8i5Yoe6z9tmzAhimY3GO7A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ckrnjz47Jev5/diYQwuwlUzSykqu6Zyt7Acth1MfIu4QGbZD+CJfAgyi7RmkzvfqJeeTEbB9CNolexooXiE3pR/sQ3to/33eDsFjb0Cs7CtlMph6jYvT1wUyNNTzm52gged2B2j1MyvXVY7J7KHToAj6CLdH52PYelRg9z4LYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjNZOKlm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjNZOKlm"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a910860e4dcso259834766b.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727884250; x=1728489050; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mwwP5OLLPE28D30nBtKot8i5Yoe6z9tmzAhimY3GO7A=;
        b=WjNZOKlmKnUAnodPeKwW6yGDDEmDKIuiaW3K6Y2bUIGiLwLrG3ANUzAvAwVhyxkDvC
         CDMi6wAmgWs1D88TnAoWmsvHSLmfnErXAloOvWcl+FxSNZE2WFOI4UVsJXw+NEdqTlIj
         DwtmHJOKF9ajr6y5TfKps+yIytZu+fn/sdEoyU8XNhll9GWIegMMfLrerJMlVT9Wd9dZ
         0h7DIYKir/fYfeiPB9BdWZOwaY/PYmDylr1Ab/Z7Vma5vFPp7GcbRl0yl9rKgbTjMAm5
         rvztEgnuI8mE1uBq1hwT6z3Ikh4kEtvmihG/9Dw7m+Ks0ZAO16GZiow819VDhIFvF1aU
         SxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727884250; x=1728489050;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwwP5OLLPE28D30nBtKot8i5Yoe6z9tmzAhimY3GO7A=;
        b=oMcsJKZZTM/sMZ3Ii9C0MtAndVCpo9d9uv/hBdAE7CfqxjZYJ7+jOS52bOh0LPL+LW
         cASagoQf/J5BpuOlPY6ybKkZVclbStfAzc+B4UUCcN7Em3vNkAAwarjcnhNweb+Ybt5c
         tujT4e1xiybdItjdXRJtGnA/oMBEdgRuqB9v79TnZyjmtbAA9IJ58HvtwC000iv+NHIz
         2PiDuqcPzNOPo7LlHMA6mUpFBn96p8uYQokXMv9VRFFB0zaZDS8HDgZ0wD0LLVaWOLiT
         xelkN4Ci9hepqofVJTiTjXCz0+i6r9DwbB2T7iVw3PgWHlaQkFCMbmp2Ewr+jE1uarHM
         xfOw==
X-Gm-Message-State: AOJu0Ywor6OBNoqtbRGzhmkzDGe1ZsHH8bb+X5P0MFwF84BWK69KRirt
	iEOSqbEGBRG6JVmp/Nyt41KN7XYKI07E9p0H/xXXaALOhNrsweHRjbjAekeNq6HnG0oQbkfRRhk
	Fw6zjoJCqmBbrM+p2lG8QImDIwoJsbxZoGQ==
X-Google-Smtp-Source: AGHT+IG+SGPmI/GF0ZPjTSMtp+03GiKadyh8jP5BpMmbD188DVUVSWErpuaJStVN12nyJErYe2wYbV8U16OJd0aFMp4=
X-Received: by 2002:a17:907:9304:b0:a77:f2c5:84a9 with SMTP id
 a640c23a62f3a-a98f821de96mr427095166b.18.1727884249789; Wed, 02 Oct 2024
 08:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naomi Ibe <naomi.ibeh69@gmail.com>
Date: Wed, 2 Oct 2024 08:51:34 -0700
Message-ID: <CACS=G2yH+k801G0z4BO6T2Gc2c6vVDieSr=2B6kT_1P-j0smZw@mail.gmail.com>
Subject: [Outreachy] Indication Of Interest To Intern At Git
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, my name is Naomi, and I would love to intern at Git under the
Outreachy remote internship scheme, and work on project #2: Finish
adding an os-version capability to Git protocol v2.
I applied to intern here last year but I did not get in, but I will
put in extra effort this year and I really hope I get in. I will get
started on the micro project task today, and I am glad I got the
opportunity to apply to Git again.
