Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA9F510
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176749; cv=none; b=NpcFrF/KAtZCNWd/oqKFwrzHDxHfRdzB8hhOKVTWRAFwT9jVLL3ZPAYw5Sm8ZUZD3WnsumOkgw1HVj+hcAPKcQVhbDErqLK5imcSfaz25ohkLWDa/610LJjn6zln6r+TbrkXdEUDrSAY2ESSOQwSsVSbPA18deOSPWSr9JCiSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176749; c=relaxed/simple;
	bh=UPJinGRPcnKsUMfS6bzbsyYipEYu4Ce3/M6krDEZ41k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Y1pJksJJUyAK5NccE1wzny7w8ZN/1KQSFdN/Umh96RnnSYMK521/7ya8WfPjgj4RU/lkBve+GlgVbZITuI9fj9wOHYFQVSTES1ZbCWnMCua8ZjLEb1jxiDQIJC3BRcfPbXpaQMlPbq8DaiVC/j2fvg07E1292b7vAscsma/Exhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gidk6sG2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gidk6sG2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d6ade159so11372555e9.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752176745; x=1752781545; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezk9Djz0wQhikueLdlIFGOBQBFCP8fWu7hR5c6//ej8=;
        b=gidk6sG2pH2+DC0EfxH+M7Umh9fCkFH4HRPOjs4Z53DI+lfgE25WFbmF80z0OZpTOe
         wFRnwrxTRgmraqdYUJ5hLjMsSVsaceIozWcuxFeqLg3DfROCNybuOst2DhWxZXpSZFpP
         oL2IPgYXrca88XLklbNPMaqNTGu2PcsojUJHawSl3i4d0GEVAJFZ0wXJeyGXfxA/2oEP
         qT1keWoAIDguarLYsgGUua4h9aBgi5YJKYdwh4xU7bu2XqaqtF++iWQhvB9mZzzSSSI3
         yuGQGR0asBZHARZn14/rnXTRbHEJ2D8L0QwTDPmpgEqOcrdHyak69cDevDjFY1YWH+s9
         KG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752176745; x=1752781545;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezk9Djz0wQhikueLdlIFGOBQBFCP8fWu7hR5c6//ej8=;
        b=GBl4ep5Ye8FxqkGjV5aSzXuF2PBTNDllvPlNTuy4orlt33ydYhy58QDuD7Nf6bM88N
         uxNwyOxG9QoCBvNRzHVUu9iOg+1BKfJiBuaGCWyTTXUC2JvKsI2spUvQi/iBoftdjZ4+
         OuapzHlUkoEEht4ahbknOKVINy8Q50IsVLPWJtH2918yf6JWhzS784XGyjzeiirDffKu
         KQKcAO3CN+d0FwW13e9fHWP9xI7SMhPfOT4sC8ycomVhcevBePCLvegpvXXNp01n/PJr
         fVq3rQMrGJlqZv0qnsiU3snGalolCvfpdEsH1qVpv7vkENWrbdD5dkcUYm6zAAe5vGW7
         f6FQ==
X-Gm-Message-State: AOJu0YyJsha6m4gTZzv0JDqWkN7C8PrbQdiUhyLqWxE+S15QpcBulhR5
	W8MNGEW1BJo9+OjdZbDRU6SLi8eY0ltip1+XG1kHe3Es7MuUHiS+YGo+SENtEQ==
X-Gm-Gg: ASbGncupveNJRdeEb3XNOJP9uwwP6993epg8++I8dafk5bsZzBr1UfMJnedpSn3HE+B
	K5htpKJJCcaQz1J5QKCtTlfPYtvRpIrP5pqZ1YtCbulnftIoZjDvCb1YBL3RRvJ8Q+lgGhU8cK/
	YDx3obrRyA3d0WzRcIKsPM5Ti2tRcsj3Ws7FzieOeDb0wPyVFvUA9JxFTu/7FZMaD4YLMCXTeig
	aBEwfI5b71382WoET4ZOYVHSNZy/ZtWu6GUjiNvhY4u8fErOj1W8d+3SFxAA7BJ8BR9pXbdvGMA
	CftS3tG2nlZMJ1tWQNBP8oYZXXpJ71yFpUl5MMJQNS719bWXdAy8ADZyCBqDcLLVZh5yShDceA=
	=
X-Google-Smtp-Source: AGHT+IHnd/xdpWOSfd6NxTRYJk6ENDOv8m4xL6BgKvZo3kU8ZP23B9EMLsOlmk9uZVhubRYGAzdFDQ==
X-Received: by 2002:a05:600c:3591:b0:442:e03b:589d with SMTP id 5b1f17b1804b1-454f406a57emr853045e9.24.1752176744939;
        Thu, 10 Jul 2025 12:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd437f78sm28295835e9.6.2025.07.10.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 12:45:44 -0700 (PDT)
Message-Id: <pull.2002.v4.git.git.1752176743.gitgitgadget@gmail.com>
In-Reply-To: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
References: <pull.2002.v3.git.git.1750927988.gitgitgadget@gmail.com>
From: "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Jul 2025 19:45:41 +0000
Subject: [PATCH v4 0/2] daemon: explicitly allow EINTR during poll()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>

This series addresses and ambiguity that is at least visible in OpenBSD,
where zombie proceses would only be cleared after a new connection is
received.

The underlying problem is that when this code was originally introduced,
SA_RESTART was not widely implemented, and the signal() call usually
implemented SysV like semantics, at least until it started being
reimplemented by calling sigaction() internally.

Changes since v3

 * Remove patches 1 and 4 as suggested by Phillip, and setup the signal
   without SA_RESTART instead.

Changes since v2

 * Add a new patch 2 that modifies windows' sigaction so there is no more
   need for a fallback
 * Hopefully no more silly mistakes and a variable that finally makes sense

Changes since v1

 * Almost all references to siginterrupt has been removed and a better named
   variable used instead
 * Changes had been abstracted to minimize ifdefs and their introduction
   staged more naturally

Carlo Marcelo Arenas Belón (2):
  compat/mingw: allow sigaction(SIGCHLD)
  daemon: use sigaction() to install child_handler()

 compat/mingw-posix.h |  1 +
 compat/mingw.c       |  4 +++-
 daemon.c             | 12 +++++++-----
 3 files changed, 11 insertions(+), 6 deletions(-)


base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2002%2Fcarenas%2Fsiginterrupt-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2002/carenas/siginterrupt-v4
Pull-Request: https://github.com/git/git/pull/2002

Range-diff vs v3:

 1:  ae1ca6bb2b2 < -:  ----------- compat/posix.h: track SA_RESTART fallback
 2:  3f63479119f ! 1:  f21e8ff5c9d compat/mingw: allow sigaction(SIGCHLD)
     @@ Commit message
          A future change will start using sigaction to setup a SIGCHLD signal
          handler.
      
     -    The current code uses signal() which returns SIG_ERR (but doesn't
     +    The current code uses signal(), which returns SIG_ERR (but doesn't
          seem to set errno) so instruct sigaction() to do the same.
      
     +    A new SA flag will be needed, so copy the one from Cygwinr; note that
     +    the sigacgtion() implementation that is provided won't use it, so
     +    its value is otherwise irrelevant.
     +
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
       ## compat/mingw-posix.h ##
      @@ compat/mingw-posix.h: struct sigaction {
     - 	sig_handler_t sa_handler;
       	unsigned sa_flags;
       };
     + #define SA_RESTART 0
      +#define SA_NOCLDSTOP 1
       
       struct itimerval {
 3:  c66bda461f4 ! 2:  81c41b43e60 daemon: use sigaction() to install child_handler()
     @@ Metadata
       ## Commit message ##
          daemon: use sigaction() to install child_handler()
      
     -    In a future change, the flags used for processing SIGCHLD will need to
     -    be updated, which is only possible by using sigaction().
     +    Replace signal() with an equivalent invocation of sigaction(), but
     +    make sure to NOT set SA_RESTART so the original code that expects
     +    to be interrupted when children complete still works as designed.
      
     -    Replace signal() with an equivalent invocation of sigaction(), which
     -    has the added benefit of using BSD semantics reliably and therefore
     -    not needing the rearming call in the signal handler.
     +    This change has the added benefit of using BSD signal semantics reliably
     +    and therefore not needing the rearming call in the signal handler.
      
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
      
     @@ daemon.c: static int service_loop(struct socketlist *socklist)
       
      -	signal(SIGCHLD, child_handler);
      +	sigemptyset(&sa.sa_mask);
     -+	sa.sa_flags = SA_NOCLDSTOP | SA_RESTART;
     ++	sa.sa_flags = SA_NOCLDSTOP;
      +	sa.sa_handler = child_handler;
      +	sigaction(SIGCHLD, &sa, NULL);
       
 4:  851d663be0b < -:  ----------- daemon: explicitly allow EINTR during poll()

-- 
gitgitgadget
