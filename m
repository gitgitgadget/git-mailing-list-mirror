Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA03812FB
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063469; cv=none; b=sBXWY2t6OhRtBERo/mzDHllm5kRfuBerb8pYuCqW67CG+8fLX3L6v86uAvlRBaIqLHKPD9vY94ztuaL3rtTk+1ZNV7mkzcZnH+ALPlUQiNS1z6Dp/pY9Bqwe7xG7/J9rshfGeer9wrz9FfxawrrThwOrfji7B4ssxnG8PvRdkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063469; c=relaxed/simple;
	bh=fEEMgJTZnXLdBQZTQxTJ/CP6GTv7SNXdWeVi576YfyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oobBZK7r8mb41X97DM+2vfTNWaqbgwuSo4EF8whX/LJW0Du/7lLcxjIEZpiRQYRjBehPT8hGEC4bgCBT0ogybCkNRcQxBpCf2K5fk3/UPLmdAQPodwn3kPRKigPtCQhPQZe3eSq1R6mRxj/CTS37pzItYe7yK1cUoWVGt4tzdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Dhy55TXx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBrjD0es; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dhy55TXx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBrjD0es"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 26F9E1D000DC;
	Tue, 18 Aug 2026 10:31:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 18 Aug 2026 10:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787063467; x=1787149867; bh=4HOv12O4R9
	r1E+VRuAILU7NOW6dMN0CdLwAZCNtVKA8=; b=Dhy55TXxPvFmz73hoD/8qtsA1P
	ahEoV3ucODbzruRdA69U+0f8ivBbGoboIRDqxtLXCiWk1rFTjiL+keOFwK9u2wv5
	jS2JX+yn77pOi/lvoQtOsJXRAUTExfrAC6YHK00orH3tvRkTKJ0M3c2fIv3jxEqF
	hK29gDKeS88aZwfX9t/MPhwfTEyByEx1a/Ax+IMvL6d34ip52mSPfI+ZYw8nN2ql
	S44RA539P5wtC8EworMqvrwyElEyKkly7Yr+50/9VY+So+jPvV+QwOHDeWRlc6Go
	2j9hTolXsi17Ii1N/A3MWve905WVtBtBbYE5A5TyTM88/hUEaDhTZiEfkyTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787063467; x=1787149867; bh=4HOv12O4R9r1E+VRuAILU7NOW6dMN0CdLwA
	ZCNtVKA8=; b=RBrjD0esanL8vNZi2RnoC1mKYlB6EA01/+AqNofrnGPREngACBM
	5nRbXm/pKnbtOXHlwpsJStuhuk/PLLIn2E0cIMXipq/bBBraTUPuPz6U+w5J6PR9
	oe+xWNI5shl2Lo3CatjDCzYm6fqHEXgF8Co0zPQMlrkFfVEr9WHWvoaVx66PC4Oi
	EOP2M7SQ0XprLtir2pw8TOUHfIwTSoyc2cKSHvAKm/gDEJ5W6Rq/cClhB4ALV4pi
	j4ilf7zNujdUvwLXxblBa7KnT+LHEVm8ssG+bgqN32u0h1RcASAdUZv7VvW7oOYa
	6cpQJgeM2fFO+w055GVFyjdzy7DYUmdcxQw==
X-ME-Sender: <xms:qmyEaq-pWvGZsu40HLozzASzbE7Dn3ogfhpsgX3pSxW9RBPi9Xt_Aw>
    <xme:qmyEahlgjoKrqXEHkZUxO6lkTJCNNX3ZzqZxSdXIs12M29JYOJyqasB2DlUCI2jWG
    Voj87KyXmsAEytQZflkjPb_2WfH1N8hjiTTZL2BoBK-iJxN5xhRcQ>
X-ME-Received: <xmr:qmyEaoXzE2mIbynQ9HBCcuwR884f7nE2iWAuY1xd6Y4fbHOIh3zQmsIZAahwt2j8xS8Lnkc9-cIbww-hhflOFzqdnA4ifY5wvg>
X-ME-Proxy-Cause: dmFkZTFeK7pYUB97d1yxIyEgHYvHvke3zOCHWLutA3QirpaAUEUsqDnk400IsvbOtlV8Gc
    qJrNLtg3InlDgXXmq1BYcPMZCeXy167sm02baHiN4HYp+bZx86dzZy0CmRDSfAnsTDHqdY
    xmcSbWfTmBRexSGK/5qt2wyee3pim+Q4kEeAZn19stq1VDHvXbdOT2a6Q1sWVF+p7v9yk2
    tPiDUb6CWtodk52cKxniqoOpiGnUe/FhU7842vM0o9a6Sarm0A0wI37a0mFTPvNjzqgqQJ
    rlvC46g9P+V3bMB5w6jqg40C2iSOIAtvYoI/9rivcewgc43Uc8RrqBJCLUrtiKLO+iKOFB
    ylgYyELmyYQNAXWjlRMCdEIrTAHbeWL46VbkzxZV2k2+QuIuCAAZ5HetyyyCXRkcnJk7Vm
    a7bq2djkFmNu8X5PEUBZXjzPetdxN/GX9jreDokwvdmXL7QC6v2a+A+4IXuDhLRKqqb1dg
    uFetZ6XQMgz0zO+wgc4meniTOgvI2l3qaor6FRBmDiMw7OdPQZ/pOyMvp8UvfHg0Jq3zUE
    5Znsd00XFhGUM0y4AH2Lvj5OQyxS3tEMJHizGFrKX2elAyH0L1lvhGYIm/6BI2vYTvPV3l
    HjyHbQ/q5ZDgGScxyhJilIe46wCljqszoq50oTOvnQgrW0Kr1e0jo7tObwfg
X-ME-Proxy: <xmx:qmyEauFXhQS6QPUyWFF5YglMWGzj5eqOpwcBuH6tBKY-ijPHjHSe6g>
    <xmx:qmyEasdNPBCUz9yX7hXPs3ZaS4ntT-0ac9GG1-paGlIwxSbYfcTn_Q>
    <xmx:qmyEanJB_mAn_iYVLlwIHOI5h_yLnPAStUMYskKIuJdKVfGxiiS1eQ>
    <xmx:qmyEapGRX0JhLnPO0rWKW1Mb_BbhTXipytIv1slFW3Iohm_52nmfIg>
    <xmx:q2yEakhd8OSyK4Evli14AnekbFS29wUzXgZDME1BaClm4GCKY2Jf-rh8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 10:31:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kenneth Lorber <keni@his.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [RFC PATCH 0/1] config: surface editor failure in exit code
In-Reply-To: <CAOLa=ZTykwSDcFaEmEJJ1PTnX5L9=2t+tkCWhF+hV4J9EPBwWg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 18 Aug 2026 03:26:36 -0500")
References: <20260817211936.2943278-1-keni@his.com>
	<xmqqse4c2wyu.fsf@gitster.g>
	<CAOLa=ZTykwSDcFaEmEJJ1PTnX5L9=2t+tkCWhF+hV4J9EPBwWg@mail.gmail.com>
Date: Tue, 18 Aug 2026 07:31:05 -0700
Message-ID: <xmqqecfv33h2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Wouldn't it be better to notify the user that something went wrong
> rather than simply brush it off?

If we were adding 'git config -e' today, absolutely.  The issue is
not the comparison between signaling with an exit code and not
doing so.  The question is whether the benefit or conceptual
correctness outweighs any possible downside of changing the
behavior existing users have grown accustomed to.

Having said that, 'git config -e' is relatively new, introduced in
commit 3cbace5ee0 (builtin/config: introduce "edit" subcommand,
2024-05-06).  The folks who may be affected are those who used
'git config -e' in their scripts and carefully checked the exit
status (or rather, lazily used 'set -e'), and did so in the past
two years.  So the fallout might not be so great.

So, I dunno.
