Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031B22D4E7
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053776; cv=none; b=XERnQB6BgGKtuv0buqrWdULqKnbIdzXklc6Q/lzPCZkVLRcNMP7/AMMifOyQ4MikQ7F+Qy6YqivaQKxJmd6pMkn9LUx+0uiqoaKiVsVUJHqzqt3uHLHZZiEqbXIxOdGPqtKt67k7a6H7uOXU9ygwRut8Jgxkz6rX4K+qd0Yu6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053776; c=relaxed/simple;
	bh=m8CUML+5e9inFvkbsTBH+9ElVpS8EW2NwwFiy/ciNAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXjiJ5mmHGDtVym3niV+wzrvjZO2Ehxpx85zvEmjp1zKFPAB09z0jPzlvGu81ALISmPEPrSmfJFU/ALpOgJL/ouYvvcNpqTeAIcBedeX6jpMy62fDRd/kuZVcJ+ygSgcEFcrAD5aFCwQxmgP/mbqKuFC07Sbcxm05xQDYeYo8V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4irPXiu; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4irPXiu"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa676e4f36cso21562566b.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737053772; x=1737658572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m8CUML+5e9inFvkbsTBH+9ElVpS8EW2NwwFiy/ciNAM=;
        b=I4irPXiuUZANmlv/uklV0BJr7cOiB/Xd7Zp5aPDSJFUYrwX7Hp3wFBv7JTS8rfoPVJ
         fypPfFt12S0RTQ4buieNKPaRnJd85oDPHCfQF1IQY7LTULnXFrdQhoFZ0oP+U2eVrXYz
         czCnv1ge/JRoNJLMhZWi0LmIxWO8zSS37Gf4+XvYnB2Q9GjL+eHqWMYvOV1u0pekmX1x
         QXwoly9XhxfK4pRUPxWo5SuLRewT7ufuZAW1c6QziDAsOYFVQv6Vhg9kEGv6e7hop1yz
         S0JoxYGXju6ups01wyZF13kn1zUhrRw3asyIB2mBer5dUPHAmCaTGeshJNlsDp/XfUdo
         dayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737053772; x=1737658572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m8CUML+5e9inFvkbsTBH+9ElVpS8EW2NwwFiy/ciNAM=;
        b=RJdWVzk4fvB4iQU2YoLF3chhVxNUYd1lBXEzQzHVFOWlqN6cp9K883hfLzHAxeSUd3
         RnKKrUwMxapnBdMv6lYteZMTgNg7GrM5gF+o80wTx0tKMFHiz1PQc7ccg2LwwfuqPT1w
         evKeB9ksk54hoM3U8Poa2rZQtnth4Jx3CEuCXKxJVG45KxvztsCGfz07t2La9XzL5n3h
         n5Du9QV4B7KrFKpsdkDvk4OSdRoiNjht4qeflTbnqDgaL8eVTSh9SrHed71aLqz9uqhi
         ajtoV9WW/WygjJZRlr5Jecz9h4gANkcBIA8NSPGzwtF0+av5ib4EI6WAqIhO1kXNfGy4
         spDg==
X-Forwarded-Encrypted: i=1; AJvYcCU75+TZiQFLymd1k+784rui/FiwsIgDEk5N8vj1F78HiQGA/K4rBv+I2FFSrlNb6qdxIS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MNAbhuzn56Znhz8dYCVdna1a08g8QlayorTwOB+ssowLsr0r
	s82V2ZmQdsAW96zhAUnLLeXSAkrjhRF603SegKLrweS46Fn/u3dJ15DRb1aoWSFJNxt092l54sI
	4gAcGzD+2VeNKwsrZmhAzcJgp1fA=
X-Gm-Gg: ASbGncvPZzgJqBUGAfVCMRtI9nmWrwe3M21pXT3UQ2dm7ZorHuxpv8e1kKHskLRtEmf
	/KCwfuyWpaUrZsdVaB+rVqpE2oTbyX0q6PpQDyOvG
X-Google-Smtp-Source: AGHT+IG9VAzUepKb4pHxFgUROfhnYN8/0udfBIdBhGj8tLWEnmfoTLWslcqZRlXUD20pmRN4eBDPjA2VDpPW7si3E3Y=
X-Received: by 2002:a17:906:1558:b0:ab3:7812:b3c2 with SMTP id
 a640c23a62f3a-ab37812b749mr89664566b.2.1737053771824; Thu, 16 Jan 2025
 10:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1874.git.git.1736802194760.gitgitgadget@gmail.com>
 <Z4WGwCwnNj_XeHiI@tapette.crustytoothpaste.net> <xmqqv7ui72e4.fsf@gitster.g>
In-Reply-To: <xmqqv7ui72e4.fsf@gitster.g>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 16 Jan 2025 18:55:00 +0000
X-Gm-Features: AbW1kvbLJZlT5PJvtltJtS_Ls_8s6FPxUOsymwMU4rlSt8yPrY6FoUJ27pUYbv8
Message-ID: <CAGJzqs=rtJ3yv2YCTTphsrE=0_1EpZXCA+pGNLuTVQNps9TNzg@mail.gmail.com>
Subject: Re: [PATCH] docs: add vim syntax modeline [RFC]
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	M Hickford via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	M Hickford <mirth.hickford@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 22:52, Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> >> A simpler alternative could be to rename files *.adoc. This would have
> >> the advantage of being recognised by even more tools.
> >
> > This I would be in favour of.
>
> Sounds quite sensible.

Great, we seem to have reached a consensus in favour of renaming
Documentation AsciiDoc files to *.adoc.

I'll leave this to someone more familiar with the documentation build
process (or patient to experiment). #leftoverbits
