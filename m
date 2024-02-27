Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CC1848
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 00:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995408; cv=none; b=hAjRbmNo58C65Ai8Icl9Dzel0oCH7be+IKBIeyV5ch3L4y+Mtji5sTyTVnHmc4zzd5L510MuweYfwS4oGmqqx41FsBh6Ri6kbfeLUsOVXxtBfQ5ltlupQfQEPW5DFVeQCMWZP9v+Cx9GImR7kkx8SyRUSGsujLiW+kxywXnExaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995408; c=relaxed/simple;
	bh=YqZXSkqQl2IvT04syfNaJXvrkkE15DMvPMcLi8ySxX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFbQ0QnaIAVlRHLlCS9HxjVVZf7lS/UkrpdtEi3rMenNoi7Xat46BJl+V0ETGGZDtJcisYPTGD620xX79fgJkrEWLl2IbWkdum8sKf7uUGSw2IXPoCtf/fOgiqGFJY/vWMPExFoYZfNctsLhDQU4p6pXqWOFSCBZMvWml+6dcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JUiBoGvB; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUiBoGvB"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so5578349e87.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 16:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708995405; x=1709600205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMOaPJaPmUpI3GojCGLU7YTAAWJ7UYYWwoPj7LHjkIY=;
        b=JUiBoGvB8w54iFdTsAG36S/h2vKA8k4I7nz08AoS8v/oG8fdXqAVeS7YcZjugLH+YH
         0OPeesHSydH+f4NDuMtVUIPbII/0HvEpHF/JRAdxDwGHee+ZdTq1mAPRqVHMbyasEVgQ
         qi6bQbhh0/SM8o6VmmJIdCue4mBSRwXK4kcEhvmGPbVh5GmxWWBO1DG6IuepIhhxNrBD
         MEvpT+qz5rOsqI/XGfD7ttjPaKQ2L0n9jC8FWaV2cnXvOmRMEx8p+1AiHV5EjKMe13xG
         CxYJTSnAKWGLz33rUP+zPgbVCdoQkcHGyHLHMXkWRFKlhSLFJgRf6vYbHY/tsTDTBWYo
         WKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995405; x=1709600205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMOaPJaPmUpI3GojCGLU7YTAAWJ7UYYWwoPj7LHjkIY=;
        b=cQdvWduA714ZUdPU016mc0/htJlFrmSeuHBKGBs066OWKIClsbftYtRI7gfv1WhRoN
         DUgu62Hxr9DGNyzmXITuXd2fO0xDmDwnzYbosrbCJS7ttgK5Ud/RXoD8GGHg1uOFRumn
         9iWMAL5KHQkFezGeY9sGIqaEvjCq9RxcnxXcxq42XM7GAQsdbgcf1wU7+wbmiNRygvHc
         km61dJAd8pZJrnIBpARmTFavGXmx0HTo1TgOl7ii2+OvEaSsUq1Mi584jMdWtvVem6QW
         eWysi4XH67tXkP5LZyzjfan962vnIuCWH0ccrtPvtJSMSItJneDj/gQ2fAZrHp9y+srW
         8UTw==
X-Forwarded-Encrypted: i=1; AJvYcCXX7zUTUgI/FJeKwFsb4TQk4LY2+dV15TX1gB6PlptpzAPqUcaO/alrzm+fCxcw/9YEGogW0oNknOV5FD6aIXm6DbcT
X-Gm-Message-State: AOJu0YyUpZnpKmAdWVgzomcL7651RPbmcNjBe90hGlfxFPaSin6s8vws
	N5OGVmSE/KRRNjRWJInHDz8ZSrziTD7ml8LaVfCv5f8emD2kN2OKkKykDhRtT5lNzAF03uVgaVk
	KwIAkm8xu8i2k7PX/qdeEizmBqfZYjR/8O0Wd0uCv1vYZFdO/5Q==
X-Google-Smtp-Source: AGHT+IEkZ6fPSjFCZK9Q5uow3ly0Ssr6g/tEdlp8zigiWwu+ngtRX05i/YU2VRriOCBu0pVjc9gnVoZ/xpx+5m/3lr0=
X-Received: by 2002:a19:ca51:0:b0:513:790:7695 with SMTP id
 h17-20020a19ca51000000b0051307907695mr105290lfj.40.1708995404921; Mon, 26 Feb
 2024 16:56:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-2-calvinwan@google.com> <xmqqh6i0cgyo.fsf@gitster.g>
 <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com> <xmqqle76iwqw.fsf@gitster.g>
In-Reply-To: <xmqqle76iwqw.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 26 Feb 2024 16:56:28 -0800
Message-ID: <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:20=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Kyle Lippincott <spectral@google.com> writes:
>
> > The condition added 13 years ago was, IMHO, backwards from what it
> > should have been. The intent is to have stdint.h included. We should
> > include stdint.h. I suspect that 17 years is enough time for that
> > platform to start conforming to what is now a 25 year old standard,
> > and I don't know how we can verify that and have this stop being a
> > haunted graveyard without just trying it and seeing if the build bots
> > or maintainers identify it as a continuing issue.
>
> The nightmare of Solaris might be luckily behind us, but the world
> does not only run Linux and GNU libc, and it is not just <stdint.h>
> vs <inttypes.h>.  This is about general code hygiene.
>
> > If it's still an
> > issue (and only if), we should reintroduce a conditional, but invert
> > it: if there's no stdint.h, THEN include inttypes.h.
>
> But it would give the wrong order in general in the modern world,
> where <inttypes.h> is supposed to include <stdint.h> and extends it.
>
> We use inttypes.h by default because the C standard already talks
> about it, and fall back to stdint.h when the platform lacks it.  But
> what I suspect is that nobody compiles with NO_INTTYPES_H and we
> would unknowingly (but not "unintentionally") start using the
> extended types that are only available in <inttypes.h> but not in
> <stdint.h> sometime in the future.  It might already have happened,

It has. We use PRIuMAX, which is from inttypes.h. I think it's only
"accidentally" working if anyone uses NO_INTTYPES_H. I changed my
stance halfway through this investigation in my previous email, I
apologize for not going back and editing it to make it clear at the
beginning that I'd done so. My current stance is that
<git-compat-util.h> should be either (a) including only inttypes.h
(since it includes stdint.h), or (b) including both inttypes.h and
stdint.h (in either order), just to demonstrate that we can.

> but I do not know.  I haven't compiled with NO_INTTYPES_H for some
> time (to experiment), and I haven't met a platform that actually
> requires NO_INTTYPES_H defined to build.  Once after such a change
> is made without anybody being knowingly breaking some rare platform,
> if nobody complains, we can just drop the support to allow us to
> limit ourselves to <stdint.h>, but since we hear nobody complaining,
> we should be OK with the current rule of including system header
> files that is embodied in <git-compat-util.h> header file.
>
> In any case, your sources should not include a standard library
> header directly yourself, period.  Instead let <git-compat-util.h>
> take care of the details of how we need to obtain what we need out
> of the system on various platforms.

I disagree with this statement. We _can't_ use a magic compatibility
header file in the library interfaces, for the reasons I outlined
further below in my previous message. For those headers, the ones that
might be included by code that's not under the Git project's control,
they need to be self-contained, minimal, and maximally compatible.

>
> Thanks.
