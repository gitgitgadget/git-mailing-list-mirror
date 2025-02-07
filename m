Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29015445D
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908642; cv=none; b=g7C8DvcxrOe06DIKmK1cbusl3ENGi/fTQICFbXk6+c03II51T1/DXsNIlHzI+Dr202ib2tBO2c8zOBJyJw06XzuwqdF/UZabhD1gIE4HcINQb3EXEpMhHXuCCHMOAzaTkzcl4w9Oahw3fn8OtdmSoZCoROUZohCLo6AT+IP66Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908642; c=relaxed/simple;
	bh=BqJgocwbH7Uyrh8sSJwW5MLtH+tw/JpZcezomC7XaKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BHMAMl0pstgrBhV7mGx6grFh/0rhoCEdnu27hMO51XXiU6+Ka74REmyJpwJVQ7fbytWhhWzWSmEu7clYKuOhMy6t8as0z5pHegn5I2SnOjlY611z2jKUE+TlNyyKHC8lJJIo7ze4dWwA09hZF0OYcSchoHHWd95LB6h3K5/VDpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmTCXbkP; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmTCXbkP"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5440efe97baso1836493e87.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 22:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738908639; x=1739513439; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI815lltv8ZnEU5QdAkLaA6rlPq+BS2hPbwPvqrJbwU=;
        b=gmTCXbkP3Nj470V4Fm36W0ISz65qZvs/rDa/9ChZ5/6uIOW0zx87Z9OFGMzziTPTRG
         1Th3DY6dOIKuegA5Obs0nQc/JRg+3KhJWX14/5oOk+DntgVY323ggkeYki6bdV0JSo6R
         hEyUTqGogOGvnPXBVHvLEGzMdAJvIIyWni3IX+wE91rDmDKn9pFElvtYeMzqQ5mJVXMB
         xTYJW45rJtO+VaSwWv8yGE0YKVGmlyrQb82oruwRfQphejDzkEfOdIGLermhrFt9Mm7V
         MDmQMgouTuE1ougX91Tc1lQi8eb77bEz8DL7O0v3nnTnLNyfOG3c1TRc/TpGnx+3XV0c
         jdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738908639; x=1739513439;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI815lltv8ZnEU5QdAkLaA6rlPq+BS2hPbwPvqrJbwU=;
        b=Y2kmSWS91tEeFW+ly1c8yvrjXek2MMY0DxqgsuJjGL/Fqjg9MliOAdjg/mvF4XxmCE
         Et3fXzckYVxM0w2lvQ19xPxNSwLiRP8VbEEVXAht9Mk59BWF/slFvqdEzcwG7km/2Jrn
         0wAY9BkCt+ZkTPLbGVjQaNTyQITkHd1a4DwwfI6CluePM3FaQR/u7ZYLCpDzoKvaHVHb
         jAISkd9EFfT7+4Ynw8Mpua1p0ao9CN4fRMN6Y3sOlqbfwXQtkT1u839xRu2DJDQq9oYe
         mtv4+BuVOf8eddSMc8mnp2Tmaijk1ZXBP2pxCIa0yOI+96eKTWxu3rZ5+wpe8umsCQ16
         3jMw==
X-Forwarded-Encrypted: i=1; AJvYcCU4pt/l+6eiHEvssvTcO7EN1KwOm6qPgHwSoMHMy0YZAVHN+xHLL2AEdJ7XWt4IRNgwspU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3wWlF/rxMTHWgkHbInzTxYaEf9BS6FozUisxkmujutm38Ghi
	Morpm3YsildInM6PamJXqjqltPnlVTuwEe2aoKBqdHPMFqr3YQaH/qNe5tDexdBlEQPC+4os/FA
	bWhMUHNZ4jXet1MTj1iCkMRlVd2NT9w==
X-Gm-Gg: ASbGncutzoAMYiNjNkRpWB+DH0N2+guu1nzlc9D7JAI8XVEsuhBM7mtZIGCQ5BhLupG
	vsZUbkIk9WS3JTD+toVwbKAdQUXNuFbh68C3U7hbAL1AeqKrlxUOrZmbFMFMfI8ZMz4I7hzKwxA
	==
X-Google-Smtp-Source: AGHT+IGtJMFaxvTNI6a2N4/EHB2ZWvE40lkSTQmIUPV6+TkMQSNRVDEQCceymMGUneYmXIbPif6FTIH6mGHrw1bJ+0Q=
X-Received: by 2002:a05:6512:39cf:b0:544:f8e:ff98 with SMTP id
 2adb3069b0e04-54414adfa4bmr425781e87.42.1738908638362; Thu, 06 Feb 2025
 22:10:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205214726.GA30202@raven.inka.de> <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
In-Reply-To: <20250206200418.GD30202@raven.inka.de>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 6 Feb 2025 22:10:26 -0800
X-Gm-Features: AWEUYZliLLr8d-Lsf4exkMNKxsAXtWSir8ajrBv0_zaoMnGSUiA3Om0CAyhKbfQ
Message-ID: <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[First]

> On Thu, Feb 06, 2025 at 02:40:06PM +0100, Josef Wolf wrote:
>
> >    foreach $commit original-branch-commits
> >        git cherry-pick $commit

[then]

>On Thu, Feb 6, 2025 at 12:07=E2=80=AFPM Josef Wolf <jw@raven.inka.de> wrot=
e:
> I've done a lot of try and error with this approach and have come to the
> conclusion, that cherry-pick totally mis-behaves in the presence of
> clean/smudge filters.

I suspect, actually, that the biggest problem here is that cherry-pick
defaults to working by using merge. Given that you want to create
a new linear set of "cleaned" commits, you don't want to use
`git cherry-pick` at all. Just restore the files from the original
commit, then add and commit.

Chris
