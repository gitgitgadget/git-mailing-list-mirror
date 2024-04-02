Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84224B23
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041015; cv=none; b=LIrEc+NzzI84+M6Kkr9YW+/H7LJVpMAsVbbvB+v5MlJWWW3ztlCcnZOF9GCTO79RgbP4FIdasZUuzANx1qGCv4Y+1aTtYatasbWFtdTMLCIX4g2HTrVeIRiDdUKnGCd+kVhGhC40g1hK6sj5wiFETw00/qpTy36OUofbJPr0D6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041015; c=relaxed/simple;
	bh=3N5+mdLXhPVe7/recc+wywPlkNBZ8zsl9ZDv2Rgr8tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YygFKxXfSg+pBdtCrr4sNkpRh711lzhOUjqoNqMeRtP1g3rM3Bz8jTyE6NFX2hgFDk4v9STpeu62FSjt/RaaQj2Npp7LB57H/mP+a9WTntQT7RCJ5oUtfMZqAt0L0vswSc3aHeDniuEVHo9lz/+k9dzXbBGYxqhG2NmF2AKJoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmZ1lVae; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmZ1lVae"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69699fecccdso27681576d6.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 23:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712041013; x=1712645813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N5+mdLXhPVe7/recc+wywPlkNBZ8zsl9ZDv2Rgr8tg=;
        b=jmZ1lVaekWQS84WyZJmIErQ29PQx5zfm5K8lvYZps9pDUZ3yzT5T9TN3HkIESYwKzF
         CiHbDYm/e19L1+jAL2V7W/JZdKNXstgxXNKxH5f5pSJH4FWvsaURmswIPLHaT6C5mEJF
         AxIqfhgCzt0+/fuZ6MXL/qdjScmu2T1pOXwlPkiiA9V56Mnzo35HKYQa9+FRuRlbS/gK
         W/NjspCUTGvi+gKJoFItbRT8Ac5UuFZRCdNEr9xYikr7lWRxnIr/QkUYER+kiHRjpcmZ
         tyryFXvlbGwBnl+Yej7A846pqJKuldtUlouTQAMO0XEBmDU8cqPHqWsB9tzjEKHjB20J
         0tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712041013; x=1712645813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3N5+mdLXhPVe7/recc+wywPlkNBZ8zsl9ZDv2Rgr8tg=;
        b=dzJxf7RZO55qKkSqC9qhYhzj+YLDF8JKWUgaorB2Hd6tgpMId7UWSbicMPJ2SKP046
         RVMMf+Im2ScFnNoLG/APGbmBv3o/SzBUcrBlRKkMDxraf1GZliU/TS8nsm6xx21MyDRb
         m++VAM2bSH8hHStd+FRFSrEcj0Fcn4NhCqW8WJXW+YCkuBjMMMNelF051hg0Z5OrDb1M
         7Vyx3z+6MZp4JDXPJ4WLhnswBuZWjUOUVBqHcy34kMcu/g6cpMaCLi76p7khJMHowON4
         qMGxJgJ11K71LgG4jM/iD1campIB1UGCAaXhs50NEvDMGEWBzjh0az7aANw0exPhbvg4
         69JQ==
X-Gm-Message-State: AOJu0Yw3zu/V/7yLWhwIb747ERWnNLEvVKEjYhZ5TbxpCgzgESRJbN9M
	v2sa8EFAtCxDhvJdZvW9DHoPCXd4aoccAN7SglsdNkAzO4iUz+pRaATiRfyw1OBudDxeIwUqCvk
	XllBpXjJM8YOGlyTUWSrjbVWoMtA=
X-Google-Smtp-Source: AGHT+IG1zQ7X75sLA3+9SYCZiYQY4fjrlo7ChRfAguPY7a4kAjC8kitCXCZvlBYgNY5U8CjWkz9E5yH5fnAf1S620JA=
X-Received: by 2002:a0c:ef82:0:b0:697:2ec8:55a7 with SMTP id
 w2-20020a0cef82000000b006972ec855a7mr10299613qvr.65.1712041012923; Mon, 01
 Apr 2024 23:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHCXyj0fn5_sS8FM+US-6trM+_QbCcUnLtx8=4eJdFe=rXxkQQ@mail.gmail.com>
In-Reply-To: <CAHCXyj0fn5_sS8FM+US-6trM+_QbCcUnLtx8=4eJdFe=rXxkQQ@mail.gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Tue, 2 Apr 2024 12:26:42 +0530
Message-ID: <CA+ARAtpqD0um9bVrjRKG0DmrxVR-46uSKfDKnO+H1rUp0i+4Ww@mail.gmail.com>
Subject: Re: RFC: Move existing tests to a unit testing framework - Seeking Review
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aishwarya Narayanan,

Thank you for your proposal.

On Sat, Mar 30, 2024 at 8:08=E2=80=AFPM Aishwarya Narayanan
<aishnana.03@gmail.com> wrote:
>
> This project's goal is to adapt the existing "reftable" unit tests to
> use the new unit testing framework. This conversion will assure
> codebase continuity, increase test readability and maintainability,
> and allow for the use of the new framework's additional features and
> capabilities.
>

Your project summary and the deliverables below seem to mention that you're
going to work on migration of the reftable unit tests but the project
title seems
to be "Move existing tests to a unit testing framework'.

Just to be clear, the "Move existing tests to a unit testing framework" and=
 the
"Convert reftable unit tests to use the unit testing framework" are
two different
projects as clarified in the ideas page for Git [1].

If you wish to work on the reftable unit test migration, I request you
to adjust the
proposal to clearly clarify the same. Make sure to understand that the reft=
able
unit tests differ from the other unit tests in their coding style. You
might also want
to consider them while drafting the proposal. Check the mail from
Patrick[2] for more
information on the same.

[1]: https://git.github.io/SoC-2024-Ideas/
[2]: https://public-inbox.org/git/ZfwnrL6Zl_lcV09y@tanuki/

--
Sivaraam
