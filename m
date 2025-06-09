Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6881A9B4A
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462149; cv=none; b=ohoNfKv7/zmzzV30BZp2y5/5Tw4nhhIkcAxLKJ5oG0V2T4QYF4WnaO/9SAF53jN653u7C5acQBrZ2x/aMxwnU/gF3k3iEBqAfXNPYq2siofaIUQCUMnQtHCYED7Js+OVRZS6vZXFO3eCYHMxJG6G1BM/UjUkovhqN3LCX5lk1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462149; c=relaxed/simple;
	bh=C7gDaRGGqQQCrGmxguqfbAgcfr9va6SXIf9WrBEfd6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIqUGee2DLgqc4NOeX4E+kvEbdpiIn4YcrrVkV9A07fAaB8IqJDJUBBPpamPZoiBmEtlP3q1j5l7XsZhVf2gECu+vRdXhU2tw5vqynR9y1GcTkJA03LHFmyZX+DeH5yzGA7ZzE7Zb3piOAWyhuD/2B80ifO2pHFKjeQVY1Ii02M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dimqre4o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dimqre4o"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cea01b9cso13124235e9.0
        for <git@vger.kernel.org>; Mon, 09 Jun 2025 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749462146; x=1750066946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nUoqNqR9A7+/Q0SU1gcrgQ8YdK8MBSFGEKB/h3dJLJk=;
        b=dimqre4o02NaQORuDyzAl0jRhj1VJ+S13QP2S//7O9bPWCTn/y4zGTRa8grjKaXY41
         M4AzntilmTFeuo1uDhnU8GgtOKfeYrv4EHoqa8gIl2Hjcionor+5LHQRkDHcv8Z8Rm9Z
         RuxQqU9qdnIQFcPZGXVKtsLQ7nmt7R4sONfRkswff/akwDJ4cOW3kICzM+t7NRZdr748
         Bg4dsmNtnVDHbylIx08TvuQEWBcpMMT3EttX2a5XePlps1OYNvAGc59c3UCTmMqTo7eJ
         7PIU6WZwfyqt72TARGgYWcsWkHUWC7YH8raRXy17eaUTxQIjJoUDKnaB4KDLObOBL4pg
         pOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749462146; x=1750066946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUoqNqR9A7+/Q0SU1gcrgQ8YdK8MBSFGEKB/h3dJLJk=;
        b=M3KgHjLhrm5CeB2KgBgADLzGyofVGxdxfWwGfxAfthTrQqoq8qH25kFcGst1Q+cKrF
         ZGh7peyVsdLUFX3MMplMpLjtKU38x/D7vhZoRSw0F2VkwtCw23uAgd2o0zYZ/8zgYmNb
         jZ9m0zWT+K5YeTKdh2JgtHuT2QoawhtZNJWKXCTgpdJV6BGEfMp2J76Wyop3LGxCIIvt
         pTDBBGpuvRLJZ/3J9dFyL5WQn1KF+Oj4g8sG53c9/URZucBs1sLcdhhigSFBVo06O9Jw
         +zO844UBzkBsqSUs4zWKSUf8J4wKhp5mBNvnOTxYW4p7fTmRtrExpCjQpOC5ooNmwe7b
         APYg==
X-Gm-Message-State: AOJu0YxuaXmSehiBpMw0frNskKKcg9ZrF1TcwyxpCAPcZBb5Stnfutll
	nZdS6LSLecKEe8oogG73NoPCWt1zlkOTxbpEZMVzCy24zZAmp6km6y8+
X-Gm-Gg: ASbGncusfc13u/fL1z0WCEcuCjdw1LS6y5WcG29p9l4Z6XTz9fvNOyF2J4G4YrSiBHE
	e3fdvBccR+5iyodcZudzGwTzD759Y7aDRUOu3PDNRIalVMbGQR+0zozHNqGB5WzMNkkgDkbn2zE
	pCmumzm3Wn3rSw8/6XaIaRpI5bil6J7IVhJXpCSFYaYeGFwSKm161xZDzL95nfRnfpkLTE5nZAp
	lRs5usXOntYn3zuuM0YhWtK95cILLElGcYKwTITyTRX5hV5z07Z0ILe5e+MjlEa5cGBd2fqqR0F
	1bJyTixP4v3qWmP/4l0UEU1fMatdPvgbJkgUlz6b29EQlHedyn19848s1R6yizmr7ui2pCKWcGC
	wFpnoCkXwKlehFiyVNlSxxEqr2uiFHiDHJv2yVQ==
X-Google-Smtp-Source: AGHT+IEedQUHE/Bq4OpN1ERaMmbFSWQf1dQcQ8x+OH9o/3h4mNKhNxAFNarB7cabeENIRw1mMl1LIA==
X-Received: by 2002:a05:600c:c04b:20b0:43c:f87c:24ce with SMTP id 5b1f17b1804b1-452fce1a254mr53796105e9.21.1749462145898;
        Mon, 09 Jun 2025 02:42:25 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c73b8sm102939075e9.29.2025.06.09.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jun 2025 02:42:25 -0700 (PDT)
Message-ID: <a66483fb-5bc4-42b5-b361-c900a69015ed@gmail.com>
Date: Mon, 9 Jun 2025 10:42:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/2] stash: fix and improve "git stash -p <pathspec>"
To: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
 <cover.1749289514.git.phillip.wood@dunelm.org.uk>
 <CAN0heSotWpNmqd905aknVTfk6WEcYifAwbXBKYfAWkhzxua3ZA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAN0heSotWpNmqd905aknVTfk6WEcYifAwbXBKYfAWkhzxua3ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Martin

On 07/06/2025 13:56, Martin Ågren wrote:
> Hi Phillip,
> 
> On Sat, 7 Jun 2025 at 11:45, Phillip Wood <phillip.wood123@gmail.com> wrote:
> [...]
> This range-diff matches what I'd expect. Now this test makes sure we
> really pick up the `-p`. On that note ... I just realized that all of
> these would keep the test passing:
> 
>   test_write_lines s y n | git stash -p file # what you have
>   test_write_lines s y n | git stash -p file otherfile
>   test_write_lines s y n | git stash -p .
>   test_write_lines s y n | git stash -p
> 
> So the implementation under test could bungle the pathspec, query the
> user for both `file` and `otherfile` (in that order!), get EOF from
> stdin while handling `otherfile`, leave it out of the stash, and end up
> passing the test. We could try to protect against this by providing
> another "y": if git wants to read something after our "s y n" sequence,
> we'll give it a "y" in the hopes that it will trip things up. We do want
> to test the handling of pathspecs here, so maybe tighten this?

Junio has merged this to next now. I was hoping that we would already 
have coverage for this with other tests but I couldn't see anything so 
I'll look at improving the coverage for "git stash push -p <pathspec>" 
in the next release cycle.

Thanks

Phillip

