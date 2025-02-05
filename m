Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203422288D7
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738751772; cv=none; b=umbcV/VlRfyisG1Ic7z18mfHnu3Regvu/RpU3XHr1jIxzqAo8ejEhGfAyIjapijHSXsRRV6CBPmeg3OofLHvfip3jE/wb0sW0e1kesl4mR9oh+hAj/MuD98pQkVOfDKFhjg/ajqQyfTgNo7YTmLMDor2dOIk2a9nufz2jrzBc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738751772; c=relaxed/simple;
	bh=KnS5xrNtVgXgKNdTXD/dm+EVJY8CmjN/jiF9Itk67KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvk+cOyRazN3jw25tWIy9lNg2Pl59CTUr7E7th/WeYfAIg84la1NLenVnO/hdVcabWWGd4VYLN/JMTDR4r/AKyu/jPm9p9EoJP0490SbJXkwF5mjuby353Bg1mgUw34dKx9ldjYQI3IpDS41lZ2vyU/Atoo7GnduJcmiV5uULZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izFeXtAN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izFeXtAN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso10866506a12.0
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 02:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738751769; x=1739356569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvFhQYaXJaQRMW4TmkcHYwvYsPvZoZlRfwy1VcJYirQ=;
        b=izFeXtAN5TICKFUyYBNs8kQmqNc1mehqsb8rEGcwRLkUeBPzV+q8A7UwkkQWfHDLNq
         /z56HtUnsSa47zvcc7+8MOo12z0/8dWJ7RhzIrgXjOZpZOhyYi+92a8cELzA94Zz6J1u
         VMnxGmMhfwJvGh/PV7A8v+1I3rpjq+B70sTvXQ7VHZ1MpcIZoAZ7z5ut9cv5clllXIlQ
         LEfHBeM2Q0BrYsquhLngkmgWf2Rb2hT9uGVMJwJCemm5gs2s4Zq9HLmJXair8r4lSA/+
         sS23K1IpjUQUpRNYhbf2FPeCU5P54xtp9TT6plQXt9OO9eFD9Yf6RfU5PL2FTph++7x7
         8cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738751769; x=1739356569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvFhQYaXJaQRMW4TmkcHYwvYsPvZoZlRfwy1VcJYirQ=;
        b=iKILF4FPH3ldm+n0dN0YksI79AfbOiD2bjATgDbjDWLQW8Wm9vmPjvyoPat7jiwRGZ
         1D03S+O5AAstkXm78SIFiM4Ij2DpGOa8Cvt+aapfERmtYZ7OkYxmZOElrEseJXKxuJcD
         yLkkBOA4M+Fhp5fKEESdj+hWBRDSucskYeXLIeEAnA5NlyQnMdyHCjlz56OSPwYy3S9c
         eF/cqi2Z1VPzBkkpgT67Vj3fqqAmoepIZa2BZfqtK1Zs4MGxYkP7Mp/DuwEUwdDiDjKb
         sf9kPWbkPf6MK9dgXgRCtsT/fcjI9Z95kTq2QQLixsHihzjYdAtvxZ6K9rwx1aCbE9Lh
         1uaQ==
X-Gm-Message-State: AOJu0YzCIVLmvy7BrVrGKg4F6csZXKp8XvhEuwD/z97mCKywBmdb1QMX
	kx5D6HHS5Bt5NYZARWqUDA6FjVciydZBQTDRmlcCSK1Gq4BiMuFD694OyVrhXDgLuTMuEc6jIRc
	4DZVnjVUCF++LbPWwx8J124AanJk=
X-Gm-Gg: ASbGnctqbsDx/YUusgOXgaiZUCRrE3WxWmY3/euW6L7kQs5EHC0GO0b4JaIgme126Ii
	wRJaQJbPfXAMVQNueBCx6lQLblkrcFRS0r5xQXJjDEr0S9Iyj7bxK2z4DP7PkXiu17M4Lb53On3
	c=
X-Google-Smtp-Source: AGHT+IFV/SPp/5AApd5t5zALHqMs25BZ8okyiFIOisNb8gY/yNCfTTufPVis21mXk/M8U+Gu0lUet4bmylMvauY0qis=
X-Received: by 2002:a05:6402:5d0:b0:5d3:cf08:d64d with SMTP id
 4fb4d7f45d1cf-5dcdb779fb9mr2736492a12.32.1738751768893; Wed, 05 Feb 2025
 02:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201201658.11562-1-jltobler@gmail.com> <20250205004147.887106-1-jltobler@gmail.com>
In-Reply-To: <20250205004147.887106-1-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 5 Feb 2025 11:35:56 +0100
X-Gm-Features: AWEUYZmWKLxHbmUhe3vBNQxzA7CtBGJ6TtZzahYGzsPfykvWHy5EsJmrGQUGgZQ
Message-ID: <CAP8UFD31kbtqXQDp9LyA+x+h+m592=HQHHbskSfar3S2GOfWVg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] rev-list: print additional missing object information
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 1:45=E2=80=AFAM Justin Tobler <jltobler@gmail.com> w=
rote:

> Changes in V4:
>
> - The core.quotePath behavior is no longer force enabled for the missing
>   info values. Consequently the first two patches from the previous
>   version are dropped.

This v4 looks good to me. Ack!
