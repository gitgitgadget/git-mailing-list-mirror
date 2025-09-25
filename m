Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FEA944
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826748; cv=none; b=FZeEt+MQ00acPB1o72BZP5BRU/lJUoU+94QojG95yzmip/Y1MEEOLLk7i4XSV89I3XweEMhc0WtB3i0FHopVB8LWzjvtrlTLtuhP+SDB2FesS7OclPeotKN0OSFNwzuwrnkonXZQO9HdsbgRTWi/ExLKQwBvgNa7Sz9Qr0lntmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826748; c=relaxed/simple;
	bh=PvTw+3Os1Fsap0zz4aaGLlg3qB66Y2ry9bPHlVSJIsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1Yr3vGXPZG/vR/JvQ6dh9In1MpQEQ+E5kxYOkdaFWqw5SHoU4bXjkuSBpon1pMOIWZdXefmhQb2KQ9qUNqvHI6YU/Y44DuHXglzVdewpflPSmnZhpPEPrtFdo8v32zlzFwyqeKbRUL6nuQckBlnSdsSfXdOC9H1Zuzxe92XPsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA6/MLSt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA6/MLSt"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so2548295a12.3
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758826745; x=1759431545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvTw+3Os1Fsap0zz4aaGLlg3qB66Y2ry9bPHlVSJIsg=;
        b=TA6/MLStC868lsOQLDhI0uT0bLLn3jhrE1hTKHy9+ubotQXNVMgchu8S0IpXHCmeDu
         yPGI0wNEKsh0qrGHKcjaXCc866FCb5IiQFWtYLyhkeI419FJzgSPKfbYYe/RPINOPwGc
         aXqDhY+ySOA3nqrhcQv7l3yzYWX9aXSh+7cwr2xmEhg42+mLgRjJPGppxfSQuo0A96t6
         OhLAs/Bxb6UVnjtqEQEZJUdA6+IMwsL1j0KO9g4MD45zzG2EGAUlx0X6f9dHVpzju3sF
         EtdTmyhEDe/dDt/F0by7lqAVDJW+/besXs3QeATVl4HHTAvxcY5AogvlxrRGhHWDZfI7
         Jk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758826745; x=1759431545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvTw+3Os1Fsap0zz4aaGLlg3qB66Y2ry9bPHlVSJIsg=;
        b=u9V0mc8XT+oNxuYE/yQqj2rvrN1J00KL8e6AyF8ahvwlROuzoWonEVgZG1Qh4YNlgu
         bSmu/k4Zaqqj05yw3jr7DpSt61kHEy3NthhNBHGqUZlu1RCA0wEW1LgzF76ml0B+aHpf
         QmQa2guftij1NUlZ9PBs7+fdWGqxqr2+xvzLtWmb1mGxbe+MvSF9HiGapfgjOX1sZFRI
         M3dkfMkHTKWsQ2V6qz4LSilssLOPNWGwW+2hpOpczsXl2KlfIHDjcgzsiOj0U8buKCS8
         c3nEtokyfCxURjtn0hcy6w+2sXa3LcBF5KrptGcIWkN4bBvZUQ9eJL4VOUtkRvrSgz9U
         uIJg==
X-Gm-Message-State: AOJu0YxiKEoV8eGOh9XPyOcJnVrGNOjcBccukEYbIH4zIOxoTCaj5xee
	iAPWtPzJzT5RLpTBMj16/c7sKf/yhK6w+A7/xaKpY0umfBeOZ6vOliqEYFzpPmb8SIc3P6Cz0ux
	9hfNlS1l3DI6OD8iIL0+1ZZBbDsOLW+Q=
X-Gm-Gg: ASbGncvLhy8IVIFmEKpCVs/tqRN4ANeqyQVpG4+t54yj7LzA19G4LCNEOOJL38gWp+E
	lmZ4uylZuOZmijYYiQCQVcgSmz9ClyJvn3a76/J+9v1Nfd6yCYJsVdMYYG/aCz7gSgKCL5EMyZ4
	OAtVTKikouHCBoKmxYbNnITAgFKg6lrgswFmoMyV1dzZ6xQm2qOUp3XUs+7cQW/c2JWTcK94TUI
	Xu/SqdIG6JaFTexSfSCwZlTZESEq7HK/2qcLcfuHri20WnshlO5
X-Google-Smtp-Source: AGHT+IFVytCVQW53ELvZ7aGzeYHmHw/0zIiaqmQM/yQYYo1QSSE2pVKot9G08YumILCoMOgqxnr1sDIDK1PRqaTLnJ4=
X-Received: by 2002:a17:907:86a4:b0:b04:706a:bcfc with SMTP id
 a640c23a62f3a-b34ba93ca7fmr513852566b.33.1758826744887; Thu, 25 Sep 2025
 11:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com> <20250925125352.1728840-5-adrian.ratiu@collabora.com>
In-Reply-To: <20250925125352.1728840-5-adrian.ratiu@collabora.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 25 Sep 2025 14:58:53 -0400
X-Gm-Features: AS18NWABrYg_21k_fKatbVSrgpe2Olko3LxqckbvzlChLkOzuctsKozSixWrNvo
Message-ID: <CALnO6CB0786UDZ_P7WHEETNj5YV0NigEjeOa2BSXvJzt6X4t0A@mail.gmail.com>
Subject: Re: [PATCH 04/10] transport: convert pre-push hook to hook.h
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, 
	Rodrigo Damazio Bovendorp <rdamazio@google.com>, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Josh Steadmon <steadmon@google.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 8:54=E2=80=AFAM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> From: Emily Shaffer <emilyshaffer@google.com>
>
> Move the pre-push hook away from run-command.h to and over to
> the new hook.h library.

Perhaps s/to and// ?
