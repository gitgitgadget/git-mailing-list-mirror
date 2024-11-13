Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4A2010FC
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519177; cv=none; b=smZOC0P93UQbIukUO2ItkeLz4LI4HG5iyk0HAZd2Pg3QMeZ/83FSlUbzzBte1j9HCd45XB126UGOAwJKiGlF5kxRDF9mgFtGHjlxXlYiX8lF9RYJ8VbGBk92asxr+BCZmZlcMXr/WsLyUy9aQsc52cm8QXv4/497S5DmQBuqdZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519177; c=relaxed/simple;
	bh=vEfaMbqP0CZ/10lWem4spkb36dxtxkwdM3pnA+ye7Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SlovVANOjoRtNpAfFrIs3uW0GpXz1gu9jOQ3prJ4/AdHIRzLO3frqJaN2Nqd/PKW5CDI00A0tT+S1sUhjeNFhmWS0MU+ChfiWj8eKENOZCL8Wu5sbo9+HlTskvFGC5PciwyapKqVzSxWAUAJf5DOpWdIPqVCQiL46wCDE+BeEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=mabgWH6o; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="mabgWH6o"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e29218d34f8so779978276.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 09:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731519173; x=1732123973; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQm3XfercZZjo0BOZXerN4/oprirrSpcswMQJAtwqOE=;
        b=mabgWH6oxu6qsB+L/skiLgMAHHSAOvvTyHip8la8FlsFpzOFprSqSG6EVI9+WBpPks
         9KSbXlka7FwII1Q2JjddvnwFNzQGdoQRj7ewIVdbRoupyZGvLB1oRMbItUZ3BeCBZME1
         sslwapoLWPkHZAcElV9VenJaNSLS87J9mjBWEPsxQpj82eSgP1NrY6CHzZ1ok9HH+a2h
         szbyupXrxWnu3Ob39pas8km9yqmkV+LpuiSzxjzvhSrhnSSlVWHWSYAR05RdM6tLkHGD
         FbpH2A/5g/7oLvpf2vILkEcKY1SehyNN7DfgPh56x1D+dxZtJRRbvtgT4vmNkRrVuApU
         783Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519173; x=1732123973;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQm3XfercZZjo0BOZXerN4/oprirrSpcswMQJAtwqOE=;
        b=M3L4b8gYsTUeXckMiQHmGsSoWChDBOUQN5bRRlaoEMUiSJicz4U1HBLOTBlIxlI8ab
         yFPRbfR6PWrtu+WgNhVU1ynyDhnFORaCfv83SVvBs3+iFqOLIiAfu8L6Tt+1cze/9iF9
         vQsulllXZuctyqfId6oLDOwr+WcyF/Bd9YBDCrzT9YEdy7+kPako0wPw7nEf/kZwPTBi
         JoyXN0S+ByZtAwXSdZ7BsnVOAVh9+UGcYXEhqs4orm61hSR1jg9kNMbHURu0LcO40ENO
         zkg0JwB+XmFFtop6gEMFC7vTPqM0DUStuQPWXv2R/LdPes9/eHGKMkhgnCrgdhsy3avv
         zTpQ==
X-Gm-Message-State: AOJu0YyGNyJUyS5ax9WTbrakh27oIWaRetC/QOKr5uotn8N6hqb1rb/Q
	3R1SGlCCS1UOpN7ygt60jyIVlAuHIF8aTCf5DMwbmfqxvrrWNAoQnnFFMdQ4DD6VSowfiR9shqW
	RiFk=
X-Google-Smtp-Source: AGHT+IEUxpVVzQ6AvIwNc5fmTMNkG/hXQSTysKqSVo7JUF/vKOxKfqOa6iiPCErdB+7rKmDJf482qQ==
X-Received: by 2002:a05:6902:2788:b0:e2b:e7e0:35af with SMTP id 3f1490d57ef6-e380e23d459mr230173276.26.1731519173404;
        Wed, 13 Nov 2024 09:32:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ecf05sm3405098276.51.2024.11.13.09.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:52 -0800 (PST)
Date: Wed, 13 Nov 2024 12:32:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/2] pack-objects: more brown-paper-bag multi-pack reuse fixes
Message-ID: <cover.1731518931.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

While starting to use multi-pack reuse in more places throughout
GitHub, I noticed a rare but persistent segfault, which is the result
of a broken assumption in write_reused_pack_verbatim().

The first patch demonstrates the problem, and the second patch fixes
it.  The second patch explains the broken assumption in detail, but
the gist is that we can't infer that an all-1s word in the reuse
bitmap from a non-preferred pack means that we want all objects
between the ones corresponding to the first and last bit.

I'm fairly disappointed that I didn't catch this obviously-broken
implementation during the original development of this feature, or in
the first round of bugfixes. But these patches should conclusively
resolve at least this issue.

Thanks in advance for your review!

Taylor Blau (2):
  t5332-multi-pack-reuse.sh: demonstrate duplicate packing failure
  pack-objects: only perform verbatim reuse on the preferred pack

 builtin/pack-objects.c      | 101 +++++++++++++++---------------------
 t/t5332-multi-pack-reuse.sh |  23 ++++++++
 2 files changed, 66 insertions(+), 58 deletions(-)


base-commit: 25b0f41288718625b18495de23cc066394c09a92
-- 
2.46.0.421.g159f2d50e75
