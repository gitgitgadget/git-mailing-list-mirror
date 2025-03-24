Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC917E0
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847800; cv=none; b=Nz1o9YIgtOFYyDZxybJZ2J5kRt6alWU16rG1GMESfd3YDGi37pV5TutEuQymB5cpUHQBpaLz3T7G+1OH83D9F5vbSQDSw30nntZO7scSzNBs1655K++0I+X2ryQ7Zfj/sU9ziI7dsOECxcNaQ/1ZYapDKeug3IKiZANB9Felobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847800; c=relaxed/simple;
	bh=vPvt3Y/bB3hVtboO12G/MVhX0Dz6zbhwDP8SOjJcp3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLqbzKU2GIcX3L454bQFzkOlBZCJyD1Cmj6M4Yfl7ou4b6cZ4yqDDm3EKSzK3E6XaemFjL7AN81VkRN6c0hPcwfoEr/6yKvG4FtRtu0in4KXBiwBSMLTyR7wjN+LgWfUfPhBuJkJ5EMoiPa+E7CpMqKcOgDdoMS4ouFu0erAhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEWLotxt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEWLotxt"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so8592660a12.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742847794; x=1743452594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPvt3Y/bB3hVtboO12G/MVhX0Dz6zbhwDP8SOjJcp3o=;
        b=TEWLotxt+2GoiuLLAa8tG69VU2eAk4bf/G/x1AhWzvaucw69uc7qyz8nq/qu+5QA5T
         PF4k+7CAcxUNhMW3ZlIyBsg4qaZyVPpXxvDU7XtK1Z2fB78DsEgzD0OqksBk6B3M+WK2
         LM69AIISftF1P0WsOPXZfY4VBL+LVsNYfKY9eVWCeq/nkJQRGIlM3y7WcIEbEelj5OPW
         afA9fCtdS3fz/qlRZpRXD/WtVIchOY0V+A1bHY5QBVZhiSPb3jn/k0xJB6KJAgEc1NWK
         knVpcsWZJwwE3K9VrppQ7Qzr7h30PEygrQ5jKlBBHbvJ1aLRaeMhutskQ3cm025KxydF
         yMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742847794; x=1743452594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPvt3Y/bB3hVtboO12G/MVhX0Dz6zbhwDP8SOjJcp3o=;
        b=BT4VHmgtzkQHc+9GJNygMIUsZNSxsNY730JNx0+TW4oumym+2x3NlRrqcKwNTyAtDZ
         DKvXdSq8hLRgkEx70hW2kYgNzp+uyIBtofZZP91MJv7mtSzgqYZwcvgN2ZuZsKiA21WF
         xxD7viebkmcI+PxAD6IBKhfxt3e0gORkTbsvgNMEzM2FnYrSNvRNQuMxVrajDlN3TK3P
         5/rUNu2A6BH/SpCS1yBTdhLQwX2wTiRTi5vDsCVWZ37eR4BevaMpZPwTLr/L6X2lRUOL
         4tEzyvUY7vUxGRbE9RokXRS9e0dd0IoCV40kOmUBzNXw+WLVKl/e1CCUt5soOAirdFhD
         26gg==
X-Forwarded-Encrypted: i=1; AJvYcCV6/SBjHHoypojk8ElIUO5ZMFH9ZKjYCtsbUUm1g+YZ3g3bKf8BQv5Jo43npxDYTyFLjpE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5mm4Q/REq9/sx34yL/EagsVBg4Oj76v5wSZPre6rNEtpLNbl
	GQ9el0viIVIJJRY71PDLiZ39ps7YSMs/gZ0uIUux48CN7gc0CqcARj3/pOAeEgZ9PKY7mN6pBqt
	1bTD3T55pbQmFx1O/8T/7Y3u7XWA=
X-Gm-Gg: ASbGncvg0bWCeCZv2uHI8TyvG0lKrZB8dw2KohRYajeAvu+Klk+EOvSMuBnzeJZ3tHt
	Gpqlvc7zDcAnDm+LZC9xcgOpYl58qIHc08kzgmNgAJp7vRZ4djixxBHEsTfKj9QbkuUR1KHcJB5
	OmbC00+SH7l5h/W91hNAlFbYvuv8HG8Jv3Dm5lvlocci33c+OilnuxtV0hsRZR
X-Google-Smtp-Source: AGHT+IHMfjPniackru8+wizRyeqZusu/pfthANQHjTDyPN6I+IsmpCgqWHcbSki3XYrpVxvo+Z1sPNkJ+c3don1oGvI=
X-Received: by 2002:a05:6402:51ce:b0:5ec:cc79:84f5 with SMTP id
 4fb4d7f45d1cf-5eccc798841mr3107502a12.7.1742847793625; Mon, 24 Mar 2025
 13:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324021101.7483-1-lucasseikioshiro@gmail.com> <d4c0c9a4-0402-4456-9fa0-3102b5bcc3dc@kdbg.org>
In-Reply-To: <d4c0c9a4-0402-4456-9fa0-3102b5bcc3dc@kdbg.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 24 Mar 2025 16:23:02 -0400
X-Gm-Features: AQ5f1Jr8IyDQEfLR99Sb9fcLArkGULZv1dMvqjhwJ-YXGz2zJHwHfm6eXUysUfk
Message-ID: <CALnO6CAsF1J39MeO-KY80bQfFL1V3UHT08-Va2R6QNh0JqwZ9A@mail.gmail.com>
Subject: Re: [GSoC PATCH v2] userdiff: add builtin driver for gitconfig syntax
To: Johannes Sixt <j6t@kdbg.org>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:18=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
>
> You have now managed to avoid the "No newline at end of file", but have
> added a blank line instead. Not a big deal, but unconventional.
>

I missed the opportunity to reply to the original patch on this front,
but here's the information I usually give out:
- VS Code's default settings do not respect POSIX end-of-file newline
standards, so you should probably change them [1]
- There's a similar setting for Intellij IDEA [2] and Vim [3], but
they might have saner defaults (Vim certainly does)
- If your editor or IDE picks up on editorconfig settings, you'll be
able to avoid this
- Git can warn you with diff or show saying "No newline at end of
file," so a careful self-review also catches these.

[1]: https://stackoverflow.com/q/44704968/4400820
[2]: https://stackoverflow.com/q/16761227/4400820
[3]: https://vimhelp.org/options.txt.html#%27endofline%27

--=20
D. Ben Knoble
