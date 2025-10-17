Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353F330336
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713243; cv=none; b=HD0UaUi6GqvKxzCm1P5i8SDlfcsZ9gy2xME6OB5Pu7MLb9anXBYprd9A8QBi3OgVy+EteEItZMbZqg2xUqM1bvtryGvVF2M0/PIV5vFEkKN3Gfc9AFTZ58nTfL5xNA/AzySEs2g7lus/ebhw7o5CifcyFqldFW0UM7ggNOqYA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713243; c=relaxed/simple;
	bh=47C6hdEPxIh0DFDcs2vnRJtvUVOJYTkZCR8bXXdrroA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ws7tssSS7d8FEkL5UTkQrdQZT35NX1st3f3cThEnLROXKaObZfpASHeBkJUGeZp/JRua6yekkz4vIdBk/8O7tBZJh3PLcerabamKW243+0oEwHrQlJXvnBghq8Fs3bEVkeZZcMZKuXpK5Q26nsql2oxSQHhC2TPsH8unikb7suI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhGM1e6u; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhGM1e6u"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b40f11a1027so370411566b.2
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 08:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760713239; x=1761318039; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47C6hdEPxIh0DFDcs2vnRJtvUVOJYTkZCR8bXXdrroA=;
        b=nhGM1e6u2KYHnFdxz6qU2xn/FoXPjTTBhTMW9HMsHFpFoplSmnwUYHV4b3bgFA/mT0
         dbIuAVkHY9Eu2GaWUmBVF/3Ipg7PzPEfDm/RHtygsKWibSQxexEiokCVK8lmTnHCklV9
         hkGSnUeJTaXIfdUbZaUYNJmWj2oWvb/n/BIGaqbariUHVUkOaQBgdtCjmk1QREj85MN+
         P3FBTlnAO7VTwx7KxffOgdENKbMjvsKGw8YPdbkBrzjH3nkgf2y/w4lXyRx4m/kfCRyX
         kW1n0RdznTNRdS+q1vqVEQtkifdkqeog+WYodlmhwYWzlaHjJW7Vv9cDg2Y7YH46dbvO
         qgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713239; x=1761318039;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=47C6hdEPxIh0DFDcs2vnRJtvUVOJYTkZCR8bXXdrroA=;
        b=WfvnMuUDmifM2AWzxVMk7JHrt83oMoBmYf2qr/UvsiUnZTcCVMS+n2IUr2twHM0GaO
         tAIXQIGOn6CkYGtklDQCLtuJEIJyyGXivzfbG0T3A975GaokrjYVJroqKTJywB8J4PdP
         MsDPD52nAUB3iSU67V5lxkCLek/Wf4sqAUJXsksvxrBFjpuVjZJMkHhVcaFXvoMpRIZK
         AR+5wF3CkaHaaowPN+Z68ZC5n5CErAKUeosiihErmTeCTNkdsh1i/3Y3z7yZPfMthD9s
         qyn5vczCXDad2dJOfZuadaHVXn9T+RtmDIippeGf81+8U0EVIJ8UBMCLldZb2FhbaZKM
         yLqg==
X-Gm-Message-State: AOJu0YxZkkgSh9m6ZaIxZbMqB2+/yrjSJ5NSvGYIGQHbdb8gwBPqRx1c
	RnyR8ffpeKEjzxG8Nb/l1PIPJMX/jaEg9CXloZm8sVSQKMh/5UOAup0fNcKw0nHryP8NqwVAOd4
	fZUAVn7LqYJeiYeC+1wpoHLmleG3GGQKQqNM9EFI=
X-Gm-Gg: ASbGncsUkhMHlsEYhR0VCTFBrk/BWFH18IGHaFlIEmUASnei7crtr7L9oLaXyrSNrAE
	BrXxkfuyka2mSFljodLDUqfBXcaxt5gGoDMbAX7DN3l7hMIW8hn/g5/bCvop+tbYqJVCjmn1KHb
	FM2XNvSc3dqRUyieJy2Xs3reDk4kCJEtiyGEXegjor8PtF8bEblg6XJ9sPd4U6N7x76KfXldaEV
	sj3ptxzDTdRIhVjzd2tZZJhtOQE7FDtvkY6Al9So3g3+J+0ZwNXdVkTYsXYrG7uCXiPnLdQ2EeA
	eud/cNqD4Waj7fpa+tCyh8etTcKhR0JlTEAURPIu3DsSS7dF0GjtjG4YDw==
X-Google-Smtp-Source: AGHT+IGtw3BtKQCqiPE4lyomf1VFirnG3kT/JBsLehG5CjSjOuo7RnhOFVouP2levxuOW/0cA6PH8+EQdlowQ+T8xec=
X-Received: by 2002:a17:906:7312:b0:b42:f7df:a2ec with SMTP id
 a640c23a62f3a-b6472d5bc00mr447767966b.9.1760713239343; Fri, 17 Oct 2025
 08:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: El_Hoy <eloyesp@gmail.com>
Date: Fri, 17 Oct 2025 12:00:27 -0300
X-Gm-Features: AS18NWDmiovjCxUFduyVZYYiOmKGJtv3sSC0NxYETDbYqTc2swMrgYMNGDrhkK8
Message-ID: <CAPapNH0C3+bU-RUO6oFHUKLjKuNdm-aXgsFTHFobYVrJXWzr=g@mail.gmail.com>
Subject: Making git grep ignore binary the default
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I've found that there is a flag (`git grep -I`) to ignore binary
files, it works great, but I've found no way to make it the default.

It would be great to have a config for this. This way a possible
implementation implies:

- Adding a config `grep.ignoreBinary` that defaults to false, keeping
the current default.

- Adding a flag `git grep --include-binary` to revert the default. But
maybe the `-a, --text` flag already does that.

Also, maybe the next git version (3.0) can default to ignore-binary as
a better default.

Finally, if this makes sense, I can do my best to implement the change
in the code.

Regards.
- Eloy
