Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5913BAE2
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290722; cv=none; b=pkErdwaKoORxmod5eb28un+GJQ5qgi3g58JPaiODnk0rmw1FBjdemCevaElz/SGgTmcwwVEL4Fx6HeO6yk0s+keFPCVr3NxexsoPPGYzZagHpE684yKLuSH7Qaow0qUmh6a+diO32SiLcFc+6xmNoKb/H5WTv4CODhvIPutLmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290722; c=relaxed/simple;
	bh=mCwGsFfhHt+QdCbzVgS2nRtBCDPaTZ+SqK+KwQImhGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYOTSRk4gC8h4btcOs3so59B5D5c7ubBBiRRUrewiC6f0UWsHDXf4+Wv7PSLIz7fzChyFXj1F+XTsvsRIHafYR5IkLkoEY1MZcNbG66nuUvb4yBFoa8VTs+PU+A84ffesCyUo5+haH2hJBTUx6i4yt9t0+6zn2dTJpJCsr8DwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6QxB58U; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6QxB58U"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e0402a98caso2184824b6e.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290720; x=1728895520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXxAyDF7z17sNezD5Ip4KXOOqBydfXNaiVwF7zaZFg0=;
        b=c6QxB58UEPwjf1Vr1C+J83D9Y6XJzbuDZb7lRsPSZN/trRYCs9Z00GWlSdgCCIzu/j
         wNAq3M/Yw+c6Pg7xYKGPHvU9phCSnVi0WYbNFl4dDW1trFyVbdYQT31DKuHSgcHCTGBs
         l4phTN2On842ZWZsAIUb0ZF9ZUgut7n+VhokfiVg8IMlBzISXdU0Ag9/kjCnNTNjGwQO
         Br6RTaz/eY4UKHqCqtJNq8KNtF/qFcHPMJw+soo9qB7eOXE2CSZDg/8XTkv8mXOylNmY
         OQ3vkyT5M2c0W54qAnMGx+f7zPCzF0i9ucYs2mdHUpB0+4KmrUVX1vV5EhBZznDWsR5s
         0k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290720; x=1728895520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXxAyDF7z17sNezD5Ip4KXOOqBydfXNaiVwF7zaZFg0=;
        b=GcVNdbW8OUtgqRToxWS3v9rdnAQV35Zy4pObMcfLoBVEMqbctOVrXcvgCWlEYchEjs
         WFfisYGtBRA9MfBuziXPdMT8bmsXk4/xGS3Eml8tZsEyaL53rnwHFfdVGjKvRaYicpEO
         q+tJrN2lLfYZB/DpttVjG9FU/6PleBMEzcRfHFxqN5NX8O/S+zLrPXLNbZRSbUzucFlw
         +lKCEm603MFSfd2YnUXa8Rk1nZgcuIS5zHnA9e7X9SUWawlqEyAHgMQipXSdELY3cjH0
         ePN0XF90LA8dQj2lmHEfTtWoPbZsle0xMIq9BT2PFBWuHzWpTwKTwYDejaCo1sAsliOR
         h4Qg==
X-Gm-Message-State: AOJu0Yx/7ywbXlylviQUPzJmvzGvihMCMq5q++8wHTE9Btrd8rR8uirv
	vQXq5lnwfUhEsDo3j3spe1zUJ8XUPd6w6s6mLi8A7e10p4KFK/B/
X-Google-Smtp-Source: AGHT+IERh2PPftqnaRUpj/521Ycsc3+QxhPbf+DimNZe5X2f3oKFEv38/n7PNZrQbqsTwQck74f1Ew==
X-Received: by 2002:a05:6808:22ac:b0:3e0:5596:c998 with SMTP id 5614622812f47-3e3c13296acmr10363923b6e.17.1728290719740;
        Mon, 07 Oct 2024 01:45:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d4665dsm3910019b3a.116.2024.10.07.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:45:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:45:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 7/9] ref: enhance escape situation for worktrees
Message-ID: <ZwOfpr7g9ZJ0Xub6@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-7Rx8ZT_27UpE@ArchLinux>
 <ZwOGoOyW6HGuneMG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOGoOyW6HGuneMG@pks.im>

On Mon, Oct 07, 2024 at 08:58:40AM +0200, Patrick Steinhardt wrote:
> On Sun, Sep 29, 2024 at 03:17:01PM +0800, shejialuo wrote:
> > We do allow users to use "git symbolic-ref" to create symrefs which
> > point to one of the linked worktrees from the primary worktree or one of
> > the linked worktrees.
> > 
> > We should not info the user about the escape for above situation. So,
> > enhance "files_fsck_symref_target" function to check whether the "referent"
> > starts with the "worktrees/" to make sure that we won't warn the user
> > when symrefs point to "referent" in the linked worktrees.
> 
> Shouldn't this commit be squashed into the former one, as it immediately
> fixes an edge case that was introduced with the parent commit?
> 

I partially agree here. I don't think this is an edge case that was
introduced with the parent commit. The reason why I use a new commit
here is that I want to emphasis the behavior.

This is because Junio asked me in the v4 about "escapeReferent"

  I am not sure starting this as ERROR is wise.  Users and third-party
  tools make creative uses of the system and I cannot offhand think of
  an argument why it should be forbidden to create a symbolic link to
  our own HEAD or to some worktree-specific ref in another worktree.

Actually, I have never thought we could do this. So, this is my
intention. But I do agree that this commit is highly relevant with the
parent commit.

I will improve this in the next version.

> Patrick
