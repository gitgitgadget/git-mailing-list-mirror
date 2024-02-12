Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B31F4F611
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 23:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781134; cv=none; b=BqLntC1LCmZFeojpJn+Sqds6KX2kwON7SjCA9C9/m54+1je+JOyfk4XRLNzzERtyKXnK/oEfMEt9pFsSn9u/ecghDunfDMiDp3IDao3DOsZEgiD38n7u2h7tZ4I2Yq6inqpybFVBEGXud0irGXS1CmNw+tnX2+pJDyJ7ADyUN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781134; c=relaxed/simple;
	bh=1MXNyny85ssERhHhhAJ/bMv4ii9/VeQVnfGIwRO/7eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRDZlkc7zGSre1K+NdHZYSO65Y53Z30dIjNnDjpFPnSDEzOzjhT6m0g/fr5XdM/WPyWid++5X0eir66RdpcIKQrxdVTAJaJe9E+utU2MZEy6hPavOq3qIHsSI4gNUQHRgemhMG/9M2I6jO9ltcQRpbCcX4xzsR4N0lPgrUCr+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEpTt17Z; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEpTt17Z"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so656380966b.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 15:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707781131; x=1708385931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFJ17CSSBnCmuoHhYoCMiXBSwW/def7h+hp8LEIiLo4=;
        b=MEpTt17ZMi+wJGUDswag2dh2VwGPmHMN02od8ceCGoqeZ8PqTSaKD1wQlr7kODumRP
         pAcVgobmg0fEzHCJnVMntakiRQI07LNrWwDeH2Uj+OBDRrGQTKM4Rn3Zmgc0tawVJY71
         iX7V1uEJ9i90w3FYaHpmX7rCH/AoVOpCr710kSR1Sux5q0SbX4r287MWa6JJBtTLFDkS
         QCpPrw0GdOqAe6+LeK3V5KeDGrzTN9x/4D1ov938N4ZhAbfQp6pYdGsVL/Jc961mWiwC
         28I2AByPeu1/JRCqt/JYUDZpGh8+zhwyrzqLEGYheu1JF0ALEdZmeNmImAvwTKRJoWKN
         Lw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707781131; x=1708385931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFJ17CSSBnCmuoHhYoCMiXBSwW/def7h+hp8LEIiLo4=;
        b=rZGQDJjmnD5SosDzIcqpPaC8jQS+1iLoqGv871lafCiD9itgE7CsE9oOzziE+IOCQs
         dqhFN4kVQvug4NnpK+5QiFkvfRPqY8z7K5dBj/DkpM4uAoSc0Ktpa7odemLDxNIR101w
         HyBzmB62x3q+2jR7AO06TiqW9Gt04BADRpI3d2m+/IxVh5WzfGlGq4KH7/vLsvTMb9CV
         JmojmVrM2EtBs08m1SHTk4LxqWusEFKI4ZPtj6mG+tXqzS94+gWtnk0A32BaM+wWr96c
         lDeu97KgTiezRJAGIfr1o1+NpCZ9sygzSvVpBGzJwJHUqpywxaRsiR7ylLwTf690zqxe
         N9qQ==
X-Gm-Message-State: AOJu0Yz2w6Isoe99k4oTRcWDzzgguRgrMK4xWFNUEupRVvqGO6LzuTpQ
	TPlHTZQAxyynHXw4pCDjEUORvTfds0cWGM+nuvTKj2SlVPWxxemUW9kaG3/pARM0ZxuywIBCERl
	u5An1fhqMbgvAfSwwcWir1ZByG+c=
X-Google-Smtp-Source: AGHT+IHwBb4nPilIt3rQOR74TETBy1sHZSDgvYvDu4SAPEKbvZeMovYVn0j/WInUFuGyE/doQRKxZXclmjmx/n7HuNU=
X-Received: by 2002:a17:907:10d7:b0:a3c:ec8a:cf8e with SMTP id
 rv23-20020a17090710d700b00a3cec8acf8emr767507ejb.24.1707781130847; Mon, 12
 Feb 2024 15:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <31725832224e3d6b14066af8a87eaf4ab589179e.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <31725832224e3d6b14066af8a87eaf4ab589179e.1707196348.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 00:38:38 +0100
Message-ID: <CAP8UFD283wk9b+D+s3azcg9DHjaonaq6-eY1KDHkP8UWZYVXQg@mail.gmail.com>
Subject: Re: [PATCH v4 16/28] trailer: finish formatting unification
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:12=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:

>  /*
> - * Format the trailers from the commit msg "msg" into the strbuf "out".
> - * Note two caveats about "opts":
> - *
> - *   - this is primarily a helper for pretty.c, and not
> - *     all of the flags are supported.
> - *
> - *   - this differs from process_trailers slightly in that we always for=
mat
> - *     only the trailer block itself, even if the "only_trailers" option=
 is not
> - *     set.

This makes me wonder if there was actually a good reason why
format_trailers() and format_trailer_info() were 2 different
functions. Is there info about this in the commit message of the
commit which introduced this comment?
