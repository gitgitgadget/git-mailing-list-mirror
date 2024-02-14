Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4E84A3E
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934539; cv=none; b=YMby3jdkYX1KVwbxe7GSy9dEHD4sKtqtb6E6fXWXaG3EIT6By+EmejgfiozfUuRSAVtYVIWkHtAjJ1wC/rYu8xQ01Ds6kHKPjcwcmVc/OBKlBTEzrds6UE51x5zvQkowCltFxXG/cHJ93NeZELCIpnLAfkbktviA8FYMiMi1/yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934539; c=relaxed/simple;
	bh=us5uzlLDN/RgHWADvDRWT0mvNGtW6PPxM3DM69aYCTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjmWwyeh5doE3WTjy6E5IrOqJFwqIXaWxtKsqld8ZkkXdcvtkM9kLjPHYdlExXd2kL/czkApnOTzm0k9aiwZKYJAAQAkM9Yv6U6qR/gXPA0FxHUXCiebgp8Xnv0C95vOENN2Zzso92oP6lpSF4wKvXM3RgavqnzXGad0p4d6BSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCU1NE0w; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCU1NE0w"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2dfc98664so2248657a34.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 10:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707934537; x=1708539337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us5uzlLDN/RgHWADvDRWT0mvNGtW6PPxM3DM69aYCTc=;
        b=NCU1NE0wECTjf8KHEpi22elOnSgglihSI7eT3xEK2/eBfNVru/oo6NHX2+vHqwrxLn
         B0EkH9YW54HQxdK7R5lhNvjkP+zEMjkgMZ96y+OXQ5w/DYK1F1zzMVsHA4knRY2UyPiS
         rG5h4OTXygdLhX9fNL3Af1JtZ0Q9zf3DmpFaJl8WIlIcMk3JuJrOdgJhncLW/Vf8OtYl
         cMgo2Ve7LemWYrVx/MQmgl+ZH4MmUQMaaAJSlTC7igJoHgGqSHQtG9190YrzNQcTCsKp
         N2+N1/J5SQJAmJXnBr6R0meX64aNR2Pkyfy9YU1AefiC2htA1GrHWQLUOufbzhd8cy5q
         Z8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934537; x=1708539337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=us5uzlLDN/RgHWADvDRWT0mvNGtW6PPxM3DM69aYCTc=;
        b=d0JB/eGe79j9IULQetTt9xlkRmkqLFsjpev+IgayPnK2rQnJGrrR/2Pt+DCx3GZ32j
         6n8i0lGvWlGylqccd8ijt3PCzKos6biOAqtEJb8FUfa5XMErE0y5cIP0/0EMsPOEeKnU
         nlqZmWHqXNTIcQ7EyJqlUKPQIRPwJXivAOeNvjZbuqqKk73UHS6f9UaO/R6LAWzZGpnk
         YJI4yPIT7IC+cIPC7R8GkL2KWglzjWdk+t2xULccv+4Au+nhuK0PVu8gzx25j1wubM11
         8JtAi3Lk/FBTwT3MQFla5q+kWlYlW3eyBfidzVN4CYA9ji/1gq2FPjQw+2aD47wU5BCN
         FkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKDSET94XFzODeW1LT8/vbje0Nls8dUf/Jzbk8r3elx0OPK0EaegSK+cYjNSihovLLvOKRPFReCRWIfGAxvV+v/WU5
X-Gm-Message-State: AOJu0YyelZuPUMb8Tf7Zo8JGwkV10zX2xRG8UljiAKhHoFuVSlHMMpDk
	fO3276y6unV5Tjxorz9RdPUXxPYwwKR/P5XVtcUcBT0cE8wFbjbMMJfzcb6DEfvQug85EAwKceO
	1+zUpTwvsAw0Bwd64MW8TiFJqJEA34SiTItk=
X-Google-Smtp-Source: AGHT+IExtRVRndAJdbmmuMLW8rW0QDnVaUm1sWk6cxWbM8YhI7eVZTlJJOumdVqqyZiIlebAAWceZuzETF/BY+SeZfs=
X-Received: by 2002:a05:6870:f217:b0:21a:1702:ec4c with SMTP id
 t23-20020a056870f21700b0021a1702ec4cmr3872082oao.20.1707934536789; Wed, 14
 Feb 2024 10:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240211183923.131278-1-karthik.188@gmail.com> <20240211183923.131278-2-karthik.188@gmail.com>
 <ZcoTbRxIaGmTd4fJ@tanuki> <xmqqh6ic5ex3.fsf@gitster.g> <CAOLa=ZQN17Nyxo-uv7CytO1RkaPu9TPfeVHANvV=tycCGpy+Ng@mail.gmail.com>
 <xmqqzfw3vv6o.fsf@gitster.g>
In-Reply-To: <xmqqzfw3vv6o.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 14 Feb 2024 19:15:10 +0100
Message-ID: <CAOLa=ZTf16qje214mOhgm1XQcQCC=d0VgKem7mLDVb=o3k2vgA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] refs: introduce `is_pseudoref()` and `is_headref()`
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, phillip.wood123@gmail.com, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Junio, let me know if you want me to reroll for the whitespace issues.
>
> I think I applied with "am --whitespace=3Dfix", so we should be OK,
> but if you can double check the result that would be appreciated.

I did go through the patches and didn't find any other fixes needed. Thanks
