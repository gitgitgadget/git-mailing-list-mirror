Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2CC1885BB
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107144; cv=none; b=PKJG2fTfM3yDKdNMVsVfX/+2BG/D4FzLqQ1Hf09ppyegso1K9wvuS5eToU6YVIJ0zekU+VLk9qkHl3Fbj26vVdO61it6nYzsmiXMqVqZtsRYhUM4S0kyvgpoAiR5p69fL5l92sh7BBfeQ6430R3A6PaGVGGmVTQWqMvyszUi6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107144; c=relaxed/simple;
	bh=jwiGBFOYMZeSI6mAu2xbBVRlzb5eg9ChPBlPpb534A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXOoYae2bb4kck3VkHYPmMq05DwDYSaZhk0jfhjFG6hGA3KP7zq+fYOQJDfHHZ2ZZBihXWnREuvup0yTVhL3i8EwYQmCOIeVFVsKBH8c9aB6CVZIUokBqq4bH6sdpOk4by2m/abEi+55yCJ1Q+19W9YqC6gK5iXy9cKUxl8ifAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rNLhd14e; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rNLhd14e"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290222fdd0so139155276.2
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 12:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729107142; x=1729711942; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJ3u7z3qAOf/+dZLiRfn7o/xjlJYby2c9pOjWlpbf+w=;
        b=rNLhd14e2NtWQMAmKXZwXdeLAnP7tAUMm+vlRfzwxedZ22Nu8VpDX3pSuiq3Dxj/ng
         f6dkBN7gTfuZ8l0QJCjnoU62xUknfh+6/cAq/GHMVA1wdoVTDunCMpA9iBPos3eQB7dw
         MD30NnieH3rlNo5Fhd2prVP95ipLRmLwRe81b9QM6oFoL1wu/rGs+RK/OeRQsIsMucJQ
         nY15rcYdSKYs2DP/LMv/MlGCVQsdTBFvmHsEbZqCT/+fAncGvxLKkr1kY5va8aUIiEes
         UKc982AmrLKPzwy7vuaT1IDV3yIIvp7bTfjEF0V/+KUxsZXzFBiPcHXilEcaCAmsAaSJ
         YnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107142; x=1729711942;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ3u7z3qAOf/+dZLiRfn7o/xjlJYby2c9pOjWlpbf+w=;
        b=Zzn9DBPP4tv23cEL7rPe1fNNJPl5p1gtu4tHFgnNNr6hTfJwJhiYawVifE4kH/zL3T
         3aI0mnlx8FzVal8cKsr1Eberz6ggouHFAvDlGMemj1L+BDe64lae+L0Wt4ZRHhI6Fq0f
         XyR6loFyg7CMMGt5pdpnE/zMZTvoU1MV+6882cVDUdWBI1YMtgBXZyPpT345c/R6BlW9
         weyne4otWEZNmNwdqs5Ya5C50XlYT2Y0AatZtXdu6UoOaPO82ogZ47iwtsIe0qyBXcrq
         94mug/IIAuS+ZDoA70cZv9f8Muc7D24b/MFnfvPLqpNVkf6jrenQALOq7cwGVzxecv2f
         VYoA==
X-Gm-Message-State: AOJu0Yz/KOx4Odhq3Z0dfoe3xDLlgCZi715m7F1kpAyo0b5BgIjx6Lmi
	MVyKCDvHOlRqDNetErP240cvePuH3Ndb87JZceYJ0N434IIWUMc0nB54g1bVagw=
X-Google-Smtp-Source: AGHT+IHb7paIGo6DjK1vRS+c9lDdiRQkFOcOXu4cvGJdx7JNE4XqULgVnOPJH0Ie17HpzL1jgjlHJQ==
X-Received: by 2002:a05:6902:1701:b0:e29:214f:3cf9 with SMTP id 3f1490d57ef6-e29782f7ceemr4891767276.18.1729107141745;
        Wed, 16 Oct 2024 12:32:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e296cc21735sm726730276.33.2024.10.16.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:32:21 -0700 (PDT)
Date: Wed, 16 Oct 2024 15:32:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxAUwxswtz4HmFeg@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016182124.48148-1-wolf@oriole.systems>

On Wed, Oct 16, 2024 at 08:21:22PM +0200, Wolfgang Müller wrote:
> Here's v3 of this series. CI should now pass as the code has been moved
> below any declarations. The regression test has been simplified, thanks
> to Eric's input.
>
> I added another commit with a test for git-shortlog(1) that makes sure
> it can process logs obtained from a repo with --object-format=sha256.
> Thanks to Patrick for the suggestion and pointers.
>
> Wolfgang Müller (2):
>   builtin/shortlog: explicitly set hash algo when there is no repo
>   shortlog: Test reading a log from a SHA256 repo in a non-git directory

Thanks. I took a look at this new round and it is looking close to me.

I had a couple of small-ish comments that I think would be good to
address in a new round. But if you feel strongly that the current round
is good as-is, I'm happy to hear arguments in that direction, too ;-).

Thanks,
Taylor
