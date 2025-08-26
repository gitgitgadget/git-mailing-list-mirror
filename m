Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71A1DE894
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220650; cv=none; b=VL2ZkRv2HSIL7bct7R9qQQT+4/DfyRfgbi1gmJeT0HgDBsrSFxR2p4xjJXO1JV0IyhNh7SIEnCc/3L3jLBIzwJNMZxVb/jh2GCveqz3u8EsYo3o2rWq4VmaDs088xoZVrXKuyfHv6sBIj6XP+CPYvbAho9Q7YvqXktRDVx+OFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220650; c=relaxed/simple;
	bh=sFq+Zu+8s4jHFQFFyXV2o8H6/+fUYKyCj8c5eHOS/40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmWjwjt2h9mpnAQYxRRju6lad+BVPjV+gXjm3nev82tRsVijyCk/tEYrWDhQ44bRSMnmmzxSZ0dc2pZpUjlkWQyMEDsmlpj4tlXwvexc2f2HeFlm/xnd5y9MJd9fLrM5JciuLS/dd2NOMsLP1Z0k38cuSDMfBVQwWeEkiS8N980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiV25WuJ; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiV25WuJ"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c1so15736945ab.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756220648; x=1756825448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuoSC2DlFzwUsMQrdMvgDz0kyj8kWOFG5hUWjHh1xIY=;
        b=WiV25WuJKnvTAN8ev/mXqgna3EIK8hg2wLI5n/zovPXziQZ+NpbaxMpWiFuMtXM11j
         r36ZOBpaE4Rgc/URqnqe3D0TFzyu8ilM7lh4lEyK2JA1KvosgEfymRhkBFha0UZD7RiS
         GIGmOiPN9HSne41mrX5qQsgxshwQAp+/0smJKUAdEvXhY2GTz+CrqcrLQyStd1ofzt4+
         XndJWIgEfHxvabWlm05UjTgJG2dxlk/bAEjzmNB/haVRuFk0qNR4AHp9/sHBy7PZcNh/
         ILjzJsR9vjl8S7Q481/H26bX7afyM9xglryvsw8CQee4PdyV7yP0cxZLLeqr4xtLy2P1
         a2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756220648; x=1756825448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuoSC2DlFzwUsMQrdMvgDz0kyj8kWOFG5hUWjHh1xIY=;
        b=r7ma0qoU2O4q9vSi9Uu9i6XLhFVP/gpzn4ogNTyQHUOwDT6LFyrJJvpsOyiSipjnY0
         c8CUy31RFD6NgAtA8Uci6k5tIH00mWXKm6vgAYfvqOVCTQxCJAp6Zfhcy5G+laVsDtWq
         loD+wrvzJgdfprlHYeBKdn/+Z5HQqK1CEa+AR12mpT8K9/e9tTYAVPXf48dPLjbaHRZ6
         VpH0ZiuxicKyE04ZRjHvH6996Lg5/fUP3jMZMUI6od02529hMh2M2nHSV0hwPUbn2oGh
         omwNTz7DLKn9RZXREAxchRlHDAhveO1MDj6GIBa68EAr0UVsLKLeU0LFcmaeW+Ra69rw
         x7aw==
X-Gm-Message-State: AOJu0Yx0Mc6bYwchPJw/2mZizpmUk+GdxPI2nuXGmpNAlkCitfsrNdiV
	F8R/M6jy9/gWJKAHT+00LY93b0bRHO9LyR82KYykOUNLz9i+oCjpOcGXnaf+iDge1ZWuQdzd9s8
	BtwWQTHFSR1+1XvK1eRM6POiBt+yTF3BkpQ==
X-Gm-Gg: ASbGncvqngEPux9LCp9M9Bu6ZLyKpDQzwsq8owZ+3JDoaCDMiSEs+h82T14Tp3hUIw3
	mATaewEqY3STms4ijUsuiNYk4EVlZ5fAjIGot86SOD7SyYgv7NHv20v/0pXvGlmUDgjwnJRgFK/
	NCT/d3Fs3YRl6KPz3Yt6dp1zCqxVLMZpqsYhyyk9nfPdZWUvWddf/fcAQcOIJb7BmekmWHMlDvU
	wWxMyhfwRroUDCKMjoC4HEwelCprzk9l6f2jVgbG7UO1JKCIFA=
X-Google-Smtp-Source: AGHT+IGphKpBWguabPnDKnBzn+A+tmec5z0KKsTZodJSV3UzuzI4rhtxBhmnMiQIuHHdvK3dKo8D+m0ZxcgyQ2X9BTk=
X-Received: by 2002:a05:6e02:180e:b0:3ef:6866:ca1b with SMTP id
 e9e14a558f8ab-3ef6866cc82mr13381665ab.12.1756220647649; Tue, 26 Aug 2025
 08:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com> <pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.v2.git.1756126197.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 26 Aug 2025 08:03:56 -0700
X-Gm-Features: Ac12FXwCjL4Vwg-4Cz_DMhLxT3yfIVsTnjPjdLlXN06p5RaTjHOdVV0jiis6D3c
Message-ID: <CABPp-BHFxxGrqKc0m==TjQNjDGdO=H5Rf6EFsf2nfE1=TuraOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [2.51.0 Bug] Missing singleton objects in 'git
 repack -adf --path-walk'
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, 
	peff@peff.net, ps@pks.im, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 5:50=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Updates in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thank you for the quick and careful review of these patches.
>
>  * The test and bug fix are now in the same patch.
>  * Several commit message typos/grammar edits.

Thanks, this round addresses all of my feedback and looks good to me.
