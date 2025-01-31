Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715618E25
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352779; cv=none; b=YzQjY8zurXwr7y1hLJlPJbKmLihsp+RF6dlMiXqZD3Y1zOpQmp0+YUQHzQ9Pv0Vr1wAGk6D8VEX0xOfPCjKEAWNRDNvTQUskHJTAeA6vzFg4Ww6s0twNy/oushFagi+Ock8C1JO0N5p/KnGMP7It466uFTLVQegNDdmUq9ypju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352779; c=relaxed/simple;
	bh=4tzGph7pBuh7Ko26HdmpzkcXtP7Nj+shySaHhFpiLME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5nFa8404Wrb+bwlywn1JhunKGJG0Wmygj6oZJCwMhV5MomQreDHwb//PAKenkv8ucofxKIjusf3Sp7i5OBc4m5/PWtyMaVxRCgtB29/ieL41Q0fbPGCsFFK9cVJkZjf/nyu54sPR58VCrkxXcH08jQ5d993Rq23iLK4YkGWtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1yXog8j; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1yXog8j"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5189a440a65so1423117e0c.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738352775; x=1738957575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP5BcbCD/dKHocvLL2G5P/6kfyncnLZLCuwE3T+eHrE=;
        b=C1yXog8jKuBOBD1F9GMfruFYISHuPiYGoW3LwvjJmMHaZzPmmPQ2WgCdnXbe+CFhTF
         SlMaHCDwO/7NG7iaEaJm6HMigVOiHDnI7U2+OjGTz2QmDZIaMlNojJGuBQgYVTlQqHNC
         V4nCtM0xyOWKf43EpFhMH0Xcu/2mPe35Sn9FjtYCytjtMexLvIDlgzIMugZYbTPzhBZT
         ZVtnwiMdUIlCFUfH5WfpyCjujLWKHGuDhwiA5K3proFx+2VYaRZs1obZuxwYvsIeKGTe
         f9x7QV+8SmgCWGe1Hlr9OSr1ZvYdkUhvYbKNGlscG4ZqGmUYdYh/FIS+ei/VYJijqNrL
         wmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352775; x=1738957575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DP5BcbCD/dKHocvLL2G5P/6kfyncnLZLCuwE3T+eHrE=;
        b=taodlwXTO/mzNph8GfRJ+jyeanJKdlwzt1WnqC28OidGLb52NGlV3ddenbHyyFNMUd
         PVvnJrFJBhuWgPTALFXUsyZ81lGI1iOpLzQaEkgp/3US4dz0CLKNeaHgq8juYJegL8ny
         C2lVTC0ykt1Q4oD5UnvmmCpGKjtEDFxDw57tiP3s+70aEyAald/x35wggkuQEjgdR7Om
         bOVl/sWWhYdWeDyC3C/UcB1SsIdNTM876dEki5nqU5buMYNu5ncCP9wPFoow3W35Ck0o
         BMjkN4DpHZpqxtxD3hdB+EXFxyntqPSEtJ5z3QmsNjRA04+ZJv9YpGEVrIyfdeNCGpgE
         xUpw==
X-Forwarded-Encrypted: i=1; AJvYcCXc5FV8DuYEA5SWsB7hgAgrV8HgwbRs+HJ5EBkEKq/q9pRdT2FW7dmKLZAllNC0ns5iiW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAyTrVtY/bvFcyY6hl5TK1SGJi7A29PMRGGc93mZjnW0YkzGT
	QPXsxjQEUdyQKze8Gd1m5ougMz46wsKiEXIiZpCVthIYoJs/1f4pWIVFQ88cv96C20NzgoGnnpY
	ThmVJmfvC5zGdYVQpsoO+Kkx21b7MAeUyTiWWyQ==
X-Gm-Gg: ASbGncsb3fmRa4g9OrmTcybkllBfUuaZ/EGSmOM9Wlk2BJHr55vPwSSh/QrfAsgNfdS
	QpnFNzBn8Tsm0pqMQ+s+bMjfQfR5cPTW3QDOk0qckMYkQ7xId5td76unwg9eUov7sGWyiFMs+
X-Google-Smtp-Source: AGHT+IGuyCnV0vK8JvXvoQQ7Vww+L+XlTDuRQMN1W3T/8xQ7YcY3awnR1DezPfld+I2usO2vv74I6uN+sh2GezA0aHk=
X-Received: by 2002:a05:6122:3541:b0:516:2d4e:448a with SMTP id
 71dfb90a1353d-51e9e33abdcmr12556840e0c.3.1738352775561; Fri, 31 Jan 2025
 11:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117104639.65608-1-usmanakinyemi202@gmail.com>
 <20250124122217.250925-1-usmanakinyemi202@gmail.com> <xmqqed0sxdiz.fsf@gitster.g>
 <CAP8UFD31A9KuqzXrDWzjokWzBtTYsF1FGJPX8PFAWXnn_2BH_w@mail.gmail.com>
 <xmqq5xm0wa5l.fsf@gitster.g> <CAP8UFD1+Qa2cRkYs8R_Lgr8Bkz7YqPUW6Q3ogKcrBSp+q-3qbw@mail.gmail.com>
 <xmqqzfj77xd7.fsf@gitster.g>
In-Reply-To: <xmqqzfj77xd7.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 1 Feb 2025 01:16:04 +0530
X-Gm-Features: AWEUYZlepTAwqhvLHtZpEEYvovJgWhZLTgiagpeWwckjYBIEOe8ZAVfyINXMC3U
Message-ID: <CAPSxiM_eob5ygBoND9QR-bS073X-Jzqfg27Ec0LOFmjEesYDhQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6][Outreachy] Introduce os-version Capability with
 Configurable Options
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	johncai86@gmail.com, Johannes.Schindelin@gmx.de, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, rsbecker@nexbridge.com, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 10:07=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > By the way, if we put the OS information in the "agent" capability,
> > how do we separate it from the existing "package/version" content and
> > make it easy to parse?
>
> Do NOT parse, period.
>
> If three "things" that talk the Git protocol on the other end of the
> connection gives "Linux git/2.48.0", and "macOS libgit2/1.9.0", and
> "Windows git/2.47.1" as their (enhanced) "agent" strings, there is
> no "ah, this one is 1.9.0 which way older than 2.47.1 so it must be
> missing features X and Y" the users of the information are allowed
> to infer.
>
> Just take it as a single opaque string, and group identical ones.
>
> In the above scenario, we found three different kinds now.  Maybe
> we'll accumulate the counts and notice that there are N times as
> many connections whose agent string begins with "Windows" as "Linux"
> and "macOS" combined or something.  That would be an offline
> analysis, and forcing users to do the stats offline would reduce the
> temptation to use it for purposes other than its intended one.
>
> You may find "ImNotTellingYou" and may wonder what OS the user is
> really using, but they do not want to tell you, so you honor their
> wish.
While the current implementation allows user to specify this form of string
 i.e "ImNotTellingYou", for agent value, it is not mentioned in the docs,
I will add in the next iteration.
>
> > I don't see a good solution because
> > GIT_USER_AGENT could be used, and the config option to not show the OS
> > name could be used too.
>
> That is a good privacy measure.
>
> > Also we don't know what could be in the "version" part. The doc says
> > that the agent part is typically of the form "package/version" but
> > doesn't require it.
>
> Exactly.  I would think it is a feature, and the way to treat the
> string in line with the philosophy behind that feature is to take it
> as a single opaque thing.
>
>
