Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B019A2A3
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268386; cv=none; b=BLdIJFxy8qyPFDIcfqG5Z2nlwTt6Rp+KHGrb91ZEzI4Cdd7zHJZiZ+hhR2ivgUY+lMWDQsm1zcnmqE5iKxrE1O9xhIFZvudEJMrkNVOu8g+/eM+YrV5PsbvvIOfteF9tX0jeaXdPqwxnOHdtf4G2JbPiU0asPf/QfERuZCzyTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268386; c=relaxed/simple;
	bh=PuIcixca8KpFcL1OsaghhPr9jd03+C98ifJxvjeKPlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qc1cAxEUNE3Id2HL4NdzanmilCxme2kxXPjfVpfKx5Cm6OZE5Tqg0+TMsO7QS05RmphNWe6GOkDXBz5h/jQqQkMAVK/qkR2MRjkmQ1f2jYHAiKiPAWAqlOLB/o7/YlR5PEe1xU3ncaMZ7RQi0sx+7hgWT86S9wFRj0+E7w05pUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chzf3PD8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chzf3PD8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a58ebece05so20274751cf.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 00:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751268384; x=1751873184; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuIcixca8KpFcL1OsaghhPr9jd03+C98ifJxvjeKPlQ=;
        b=chzf3PD8PTG7shn+3uG1v4g7QFSCWNeKIgGuQbRG1gYjfH/OG2WflMvYlkEso0Ubda
         YehPxK1/GGzecRLDOTBRWmv98WrkDCu78ryGHZbv1lVA45CMrgW82lrXez0A6fsRK6EA
         o67P816RM5S06J/iNhZfyh9CzdTMTjhVq96WDwi9uiwblnmLGjup0HhJ+INSbx15/KqF
         o70C4A5p3FsTQezpv3rDC+YBMzTBHk65OYkBHjssr2Fw9GwQP9FxH0M5tcPIjcYxqkc2
         FG3zJZfTcCmyCFarORSHdoE8pBPv6qL8P5kdYBZws3CUT6DOgqf6ZsQ2XK23KxZj2U3V
         pPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751268384; x=1751873184;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuIcixca8KpFcL1OsaghhPr9jd03+C98ifJxvjeKPlQ=;
        b=pjkcY4q1DzzstEQP5zODS8Li0qJDPz9qCgLKcHh2c2GkYuJwSd/VEHGfKkADZSSfUc
         rsVYdFn4pGNMszjya2iPDR30oYFZ9x4KiDRFRMb83ZyhZ/obJxgpCgHw/kyIBD8fa13c
         q1GqzVjJc5XhjZDDhY2ZuwLHvqus6gr8H6lm1K5/Poe2qCj8O4CgYxEFuIjXacaanUgN
         oPKIzdYJkTmYubKIuIDxZXK//4/aqEJZ9f74NfO4Wch7UGXGaHi8ES1gBnVJ6s1DKMkB
         OKpPb2jllNhuOc0AJUKQPdd/g8lDrHfOEItJHszhSBlkVJKxxiZntPhtM3k3XlQNW+7E
         IioQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCnt3FqD7H1mq14D5A+CAf220gQREPy1Jv2YkuySgRzf87H/HW5CYPhZclOiFZkT+nsJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoH2yVN4fpIvTcw08i0ZCyaSqF+4RENya8oTyEeAZCfMnZY1no
	af3K/cYdF89GUWWnTIInFecM9Me0qf+aGNkfvOumtQtIx0HG+fo5/KAMw1GyVHW2X/+vsupyXtl
	CUpSqOu66beBqi2PZxj3jc8oZTlNU4sI=
X-Gm-Gg: ASbGncuI1vY+l5pfZL/EiSLMyRkWCzacq6HGYpQMG5kqKKnudokgUILwU+2jbRVzeuF
	Cnl45RfA1bnaqureBfWB8YudzXxI6aorM9H05zFiKNk6nQL89iEi5Pledr2vChsHDinxX8HhWxf
	wFkdFG+V9lhE/h6Fj+JB3UNT8STXwjtssZe0WPOwJTzpaSdNuEqNyoC/fedEnExbEbt3kcGHkMq
	ZFu0g==
X-Google-Smtp-Source: AGHT+IFHIYyZtaGO7QAC4KYa8zdsQxdjoCTTyriHMpWWeEbV2cpdawpDEWAOd5LaYxbeVErpPKzva1x556G2UWDNyXo=
X-Received: by 2002:ac8:5a0a:0:b0:4a6:cee6:9743 with SMTP id
 d75a77b69052e-4a7fc9d7f14mr193809101cf.5.1751268383775; Mon, 30 Jun 2025
 00:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com> <aF7qFEfPi25_e3bq@fruit.crustytoothpaste.net>
In-Reply-To: <aF7qFEfPi25_e3bq@fruit.crustytoothpaste.net>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 30 Jun 2025 12:56:12 +0530
X-Gm-Features: Ac12FXyMQ-_C1wfwMoSdfsBkXg61aZgCTHciNAcaYnv7AQ4_bH97m5pJA5vY_jM
Message-ID: <CA+rGoLeb_rgHNPu7JAX80eRF4+EiQCyrTR1hbgQtWw8a-D4Nfg@mail.gmail.com>
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 12:29=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-06-25 at 14:18:49, K Jayatheerth wrote:
> > First off thanks for reporting the bug :)
> > So I cannot test this bug as my files system is case sensitive
> > but to just read the code and give a thought in a direction (Assuming t=
hat the bug is recreatable)
>
> Just so you know, on Linux, you can create a case-insensitive JFS
> partition on a loopback device and on macOS, you can create a
> case-insensitive APFS or HFS partition in a disk image file that can
> then be mounted (I think using `hdiutil` or the directions at [0]).
>
> I have used the former in the rare occasion that I need to test a
> case-insensitive file system.
>

Thanks Brian, that=E2=80=99s really helpful! I=E2=80=99ll try setting up a =
loopback filesystem
and use it for testing similar bugs in the future.
Appreciate the tip!

- Jayatheerth
