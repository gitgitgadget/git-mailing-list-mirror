Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADEF24C669
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750800521; cv=none; b=BAt1XOz1N+fNcPA/fgow2PFOSOPxc56nt5vBR6uheWqLV5P4vpFxo6cz/p+rxaJq7RCHSY/UVLeJNJwz20NvmLnnRqlyCoschJtoc+h/EAwOMCInFd+0ESQZyhcoRYv7cBRHFnJmbEl/olgeFh8IRmcF4v+fbzako0lbGBdJVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750800521; c=relaxed/simple;
	bh=O9hr6wgvjiHCOX7o/wWEH0EJwGTHNxcdI1iQXjSkB+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhZgKQkDQYybxTyRYB8aRQDjvD2iZ4dFiVbjPOVuHCjcw4kTm4jWK9O4hIRb4tW7ckB3zoYbu+nfv6f06WFVX2F3NxHwdr1aUGhsf1hX3PoeofKTbO3AtWGZkSN0wod4liT1nB01BtoX8TrWEQSKMysyXxDz0q1dviXhzIK1aR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFwFfbGy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFwFfbGy"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490cb9a892so378181b3a.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750800519; x=1751405319; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/4hQ/55iGWjjtZ2AoUI5QDEGAC5p5F9xOG0OeErFUk=;
        b=OFwFfbGyEymOrwRlLJCzXIyYnToIXRSkPoHEZtCB8RCuDbxO8mtioaUHQmdkpltxxA
         vlSflN9p2+qGL3tdyGZOr1tWbX7+EijqMCAC8JtAcuvhbhQa6o+1zVSckoZ1zLOSWumC
         gc9ZAdekCxGxlCpMvsho3t91WvA7ieOWGYZ1bBP2kv7z5+R/GnU063sMXJhty1G7UX7N
         J7D+Iow0U1PD/CHj2HbXFMBSTdOGuOK67RyeEs7xONBc5GKyh1YBMZ8hY97HgG+fQ9tF
         BPSOkYiyV/VZkybXtW9aBJDUQDf1xgCAhPLI2KJYun3pKdOQqr5XCc33VDrD5wD6uvK1
         Gbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750800519; x=1751405319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/4hQ/55iGWjjtZ2AoUI5QDEGAC5p5F9xOG0OeErFUk=;
        b=i1De3gJKJOSYh4LyyVtzcBc8qZ9vZejpTGLFVQPzkBfxE2Jgj09NNmPPjN5NVUKG3f
         CasVUf/aS2n66FRD3y1/zf2iQU/Xgym35EG+gFpEVBzSF5jg9uOwxSMlZfgIhJLVlKts
         /1QepTSl1RSx+I/OOy7IJZH3FmkpyV/b2I2bb24wQLh7QWEoYbtcbBhvRYTMOqpqQ38R
         xFU0hDS1RNfksGSzFLZQuwXp0M1gWGqYucimghqkiRx1GXLxLQR1xQQsVLqzGLtai8gx
         m9No31FVp2ENHGZS51CmdyRW5NHqM9uoxWokUMUfm0rs7CMzQYDKSFfEBQuLCUNiBSUx
         ZdSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBxghAVDbQR29v1qFLWUV6/HebC+Fx3sO12yBwyL6Nc+92LTgHROa0IszjO4CI9/aTc74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/T6kfcmzVjtLRgCv+JWXxt49aW4kXAa4HdZ1kST/Up4NjYFV
	UMKtybRnK7F3CzsXwapUSevQvc1zgXsRdspuipQqlL6dqj5FjLnaG3Ij
X-Gm-Gg: ASbGncsFE7pNCGKX07n926pADc4wSU8JliWUY8vTnjVNTn5XVyoHQ3tIXaBQC/R/4hD
	qeDtfheDz7raZ2KSHQ42J/ZaM+3cXp6wylOqhk5ryTiKg+qWGwWnEtfoFEpvrL/7KGSSWTxLNOl
	a0cxUk5gtoKOizVQFWgrQ6RMVMtAxLbp2S2V/i0ssixTKXXfA3b/nAgmu6d7YBbHyixX6C3jYYb
	fFmg+kKNsVyRVKp4uoiilkcVKIUgTky3mZgmU1yeQOk6/Tb1hMyplh+l7ATHV4E9WR6BXI62cnG
	81LCtqcI8eFaiu+qLaekcrFOTm4Hu0tBNmU6qvn1agD92g0gRiLPhQSbCdwiTuwIl1dyxT+ZZNj
	2lbOdR4eqTydTeYCl54JR9vc=
X-Google-Smtp-Source: AGHT+IEAbo5dWFJc4ajsliOsLKR9andxyd9PM8hTyjtOedKotz6WNAGKH2RvseasUPgRAaCQ/nnLYg==
X-Received: by 2002:a05:6a00:84c:b0:740:9a4b:fb2a with SMTP id d2e1a72fcca58-74ad45b4901mr854394b3a.20.1750800519382;
        Tue, 24 Jun 2025 14:28:39 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:a1d3:1456:244b:d366])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08e2fsm2731966b3a.19.2025.06.24.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:28:38 -0700 (PDT)
Date: Tue, 24 Jun 2025 14:28:37 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] daemon: use sigaction() to install child_handler()
Message-ID: <7f3ac4djbbhskbryzr754kdjdiyauiiy5dduv7h2uaa7mvafsr@chntkatmbbcb>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <2e8c4643a60e354d24bda9bf364e1b34ce1c45ae.1750774122.git.gitgitgadget@gmail.com>
 <xmqq5xgl1589.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5xgl1589.fsf@gitster.g>

On Tue, Jun 24, 2025 at 09:20:22AM -0800, Junio C Hamano wrote:
> "Carlo Marcelo Arenas Belón via GitGitGadget"
> <gitgitgadget@gmail.com> writes:
> 
> > From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
> >
> > In a future change, the flags used for processing SIGCHLD will need to
> > be updated, which is only possible by using sigaction().
> >
> > Replace the call, which hs the added benefit of using BSD semantics
> > reliably and therefore not needing the rearming call.
> >
> > Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> > ---
> >  daemon.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Hmph.  Wouldn't it a much smaller change and fix to discard 2/3 and
> most of the 3/3 and instead make a siginterrupt() call to tell the
> system to interrupt us when SIGCHLD is received only on platforms
> where siginterrupt() is available?  Use of sigaction() does not seem
> to be buying us anything for the purpose of this series.

Using siginterrupt() would work (at least it did when I tested it in
OpenBSD), but its use is discouraged as it has been obsoleted by the
last two versions of POSIX (since 2018).

Indeed that code fails to build[1] in recent Linux with :

  daemon.c: In function ‘service_loop’:
  daemon.c:1138:17: error: ‘siginterrupt’ is deprecated: Use sigaction with SA_RESTART instead [-Werror=deprecated-declarations]
   1138 |                 siginterrupt(SIGCHLD, 1);
        |                 ^~~~~~~~~~~~
  In file included from compat/posix.h:112,
                   from git-compat-util.h:26,
                   from daemon.c:3:
  /usr/include/signal.h:324:12: note: declared here
    324 | extern int siginterrupt (int __sig, int __interrupt) __THROW
        |            ^~~~~~~~~~~~

Most systems seem to be implementing `signal()` with `sigaction()`
nowadays, but in the ones that are not (ex: Solaris) calling the later
to get a `struct sigaction` with the flags being used, doesn't work
and therefore it would seem, that the only way to do this reliably is
by using sigaction everywhere for this signal, as implemented in 2/3.

Carlo

[1] https://github.com/git/git/actions/runs/15849572148
