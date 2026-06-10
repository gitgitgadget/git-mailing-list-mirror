Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7A915746F
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130197; cv=none; b=EbNk9anv6w9aTAM5+A/AlL68kF2alN+YYJQHcZYwgmDhRtSps0dqhIefMhKdhYy8qAoXw+GfTamr8FzPMXIs7C8nPEzSeF7TdRahQX/r7UD90NLd3R9tol6iuR/ehOWO4ZRVQ030zByAYpFWtIgCTeUc7Sn/YshvF9h1YlGmXJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130197; c=relaxed/simple;
	bh=RxRtJHNU2XqWGDj9h55OK/fe2EEpz6mW1fDdG2NCDE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWMTFblEhGseMBwfTmGG3FMuESRUC7eHCWqbEM9a8ftwyoQCuYpmgkpWf8PnbjJZNsZP6Jfu9PJNpGQ5kdwRQo26Z2MHLBtadUY1+HoxQd46wA0U0Lp2H36FUJ2ZcCpBxhZ9fSauluQPOiVPmSr+CuSjTChp9c3evZbmobpISJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YORBo7xb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0arKg8q; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YORBo7xb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0arKg8q"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BE511D00070;
	Wed, 10 Jun 2026 18:23:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 18:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1781130195; x=1781216595; bh=R1
	E8iaXTI14cIEwNq94oAaqG12r8v4Rosffr4ksgydU=; b=YORBo7xb5C+FzNUWpG
	mz4bj5ebTACTaJDM+VxfPZwIr7IihCAIyj/PX6CjjwVZqYOIGVjcXUWzkmbKkQ2N
	uR5+lo3jURaEab8jt3RCGFz9R6pyo0snmXm3uVsaDu+FgQ+V3EStffG6I1I0/b1H
	jByUI0GH99BrxIG3m09DIm1Wt+bM1ErRw4sK8WUOLXooxq0FV968+va8SSjlx4gN
	iEOC0FIJ44+N/mmBc5i3kAIi0d5iN2huBXJ3wy6rWA7B5vseFyRwHub8dNTGklW1
	klTXqQgV+H6KQ5aMjzvSGAL992rOqG6K8DOvVyUCSHKe0hV3ElmBd7YMwNgjIwdc
	+j6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781130195; x=1781216595; bh=R1E8iaXTI14cIEwNq94oAaqG12r8
	v4Rosffr4ksgydU=; b=O0arKg8qqyPR43bsOBqVBz1xSqjZBFTucb12rSV2b2PB
	iLpQdAL3WAfC3NQmh64JvTpdNrGomC3sNM0p7hLCMlFYSUDVMTocL1u72g0qvr39
	OcVE2+6kwUT0SiuYoCrF67mKQf/QFMKTsWs1L73KLATRyu0wQPOMM/vuf4rok2V5
	OmDrY8hrcjYfr9tlsoOS9/hJSYzlntB2dFGa9xBjcGSFxEPkUd4Y5e89Ttzl1QHy
	eKP8LxhVl7u+bmVtyl8a9tOk+JkKxIO4pkGNfrLE+sWWFajd/V9Cuzwl2J0BxvBE
	wRj88cUiRSzEPkPV0WpwGK01oaW23uCxNfGWCxYYAg==
X-ME-Sender: <xms:0-MpahoduTUfdB8I0mnKUVTw3xSTQzw3UuMwBJoyZPChhtgZ_387vnU>
    <xme:0-Mpappfgmjf0GU98BBIHm7Mt0FwWQBBDXiktOq-QpLyXx8OWOF5KwAbGLaslCi4z
    oXRtWXBWgfMboPuq8UEjDLd2vk0zbM8yaOD3F4FmkM5QHErjdxmrQ>
X-ME-Received: <xmr:0-Mpar0GqIMMF4w7nSs91MmZgkhMSutmvrKtdHY8Kl2mnc5lrFKerB6t675vEbPnV-BQfE7y8R9u_Dfb9-MKigfMElkrdr0qhX_ZslYKgLz9iPL3vjwbsN2pPQ>
X-ME-Proxy-Cause: dmFkZTGiWPNRqASvMVdlP9h40Y9OWrM5vR052QkblstALiTh8ETkqhAEHxjtfqfzbEzbbj
    Jl+yHfwddO3FdR9cnHa+oAzNAq1ayXMgEU/iOGpmPYrCiiLDuXeR6b4MAFwEhrczSQRXCl
    VsJwoiFKjzsPaIXSpUziX3Jl7QqCqcxaL4HxfeO9osG+UnUA62nPui4xAyAEZ1Bb3+IF0u
    5sbTg1g3L4k6PznSUz9sZ79LOWzGxxF+5+Aht46bO0vlXMtNCh5z8RZNzbZ0vrm9xZk3k5
    6N7mvcn2yyTLe7fH1O65WftL09rI8PGodMLJB+rpU+Qlwz0uCSx9vr97k+j+Ql7ed2n7PD
    nIh65LMQkYLG2aFt7iS5x3uc98J1XfKB5dm3U/06JGbSnaVJRRa1hSgvz0IMZf+mtwBlTE
    NJcV6mfY6hYrsLPIl5SFl+G6txtCK/46kqtQgPPV5wApKhDmPdTuTGuAtMCqull1IrVmdA
    N2+f4SrKuWSCFUVuAjb15fVlrIwNiW4mSb9xkqUmDZ9BoESGef+Mx55HX/bPG4wFC8lgL9
    hvFGvZaofDhaNuCVr/1N5fFlSpwTaHvEO8ex7CieAKCn21YFz/JbU79Id0JiZkwuoUuGvv
    A1E2eKsaorQYt+naiJnnsoDGfSw0tJt28R1xJMEskez8S1ByXleYqIdZPx7Q
X-ME-Proxy: <xmx:0-MpaoD1rkgwQMEoYy6sNEWSLZhEV8cdgDlnU6ms1-MEZXeGC_11Ng>
    <xmx:0-MpajcF1l5Pt5ODfKzdBzhaovDk2kuiDr9rpGkptE9pTkq8wB5TWg>
    <xmx:0-MpatiNG8ij-tVZdtFYUp1RkgmShuSIslfAiLPKYvTfXydfq9YawQ>
    <xmx:0-Mparon4OMHFLt1BnuRIqaOcrKzxzxRun_CJXBFUKONZYKiROvt_g>
    <xmx:0-MpalDA9KMZcqmn45tH8XAC_aj7jVRj6KmTnEoZtzlhAqw5sxDfgc0w>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:23:14 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/6] SubmittingPatches: update and flesh out trailer sections
Date: Thu, 11 Jun 2026 00:22:43 +0200
Message-ID: <CV_SubPatches_trailers.8f3@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/submitting-patches-trailers

Topic summary: Flesh out and update the trailer sections.

All of these points have come up on the mailing list. At least for me.
And `Based-on-patch-by` is a nice-to-have documented kind of thing.

I have had these lying around since January since I got distracted. I just
wrote this cover letter today. But I think this still makes sense.

[1/6] SubmittingPatches: encourage trailer use for substantial help
[2/6] SubmittingPatches: discuss non-ident trailers
[3/6] SubmittingPatches: discourage common Linux trailers
[4/6] SubmittingPatches: document Based-on-patch-by trailer
[5/6] SubmittingPatches: be consistent with trailer markup
[6/6] SubmittingPatches: note that trailer order matters

 Documentation/SubmittingPatches | 46 +++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)


base-commit: 1ff279f3404a482a83fb04c7457e41ab26884aea
-- 
2.54.0.22.g9e26862b904

