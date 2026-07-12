Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163FE3AA1BB
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862924; cv=none; b=EKoNxccfEt87x3QxvOpN44TSG2YHhHCg6+UmC/6Frn478I/vuuOvZbUJ6lrFHv+xMr2l+KVTjxEC/FwStJrWieCKOBz/mTOoRbkMT0/o9qo9G35wlIbngFh7R/kUtGIz0JybI6Rfh8yEdrWvg5b7yRnrALrqkLnbJ4Uv57uc7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862924; c=relaxed/simple;
	bh=kks46oO85WOO3UgKJUZ8Xqq7/rbfF6oApvMyVVYvz8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTQ+PJTA4SauthXmTHEfxK37F02JZzxBaNR95bAegrJaXYaB66Op0F3sgfF+FeDAqtZ6eSRcxuLHA1s7lbn3r3ntNGi+ZXnTNhj9uWFNTsb3mYOD6NKg9oSXIT1PIOWjeiRAHjBhhMr7xhiDrdBsejGLzqMlXKjN7J6f/ewMwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KdRl+IAF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IlA/BRZ+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KdRl+IAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IlA/BRZ+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 43D72EC00E3;
	Sun, 12 Jul 2026 09:28:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 09:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783862921; x=1783949321; bh=/Br9iQJLfL
	1I/ddcGW4YGWMBXscjYxgcxcSwYkwEP4M=; b=KdRl+IAFAFLBHrTrWjPXzpaGr0
	1ahchPfgmsbehUGR9+mjC7aNOOEsDobpQSJiOpdp378LHR98zeZmbAZQ/PXRne/o
	f+M3TxTpYIdcNkqwN2JVt+g8Gp5jaKfgKTPqClFbXUFQyQOcv/mXLV11Eqatl140
	Pq4KoEf0WUdtkUPWJuanGX9ImRU4ZfwZprf3yITMME1HJLNtmPNYH+gF/EYZMRxD
	Dfhgp5a+7nvNruMahklynQ5K1O2s8aYX2DU5cLuUDnSPm/P82lEaeyN3qLIDM4Ku
	FIpvhuzjSpJOBZExjssz1ln12V/k8zC83n8E5XMi8Me/dWvoj8ZI2Vg8Kr9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783862921; x=1783949321; bh=/Br9iQJLfL1I/ddcGW4YGWMBXscjYxgcxcS
	wYkwEP4M=; b=IlA/BRZ+w7cHydGSl1pO14psegOZEsQkdwzEMkAWMxVNom7j82B
	okO/QrdSCr3GeszeWXjqBiJtp19QBd/HchpMat8DzEdEAHR+un5/F+bDQq3uo8uL
	6JnHoLBYufQYJf23lf1o4DRFIm941m7ZgHcFCJGeVt/BXmmRYpeomsvTmnrci9Er
	Kku3kwvHWECy0ww9Qot0b0mfCQUNLBx6nxjeIl21OFgsPZX88a7dP3mmkcGViO+5
	1Re2XVy9s/M50YYkJH52iE7AqGP3f14gumIBWCTkNfYpMvdhScFo0qsf6Z/4QMlg
	nGerseBDiZTGnP2UwelhKutULMi9T9cS6zw==
X-ME-Sender: <xms:iZZTapI2OkPeTa3rhKjJpeqgenSUHi2jmmHlERB17Erb8LKhG_j31g>
    <xme:iZZTaslfOomRe5VaasFNqXXj-PmRGU0NBGIg-4vYX-Gh42wG_rYMJBYSbYox1GnRI
    29K-dCyZMlvRBISLX3hBczd-_sftq6zd0xRLBLyaco2-ju-Tom2_A>
X-ME-Received: <xmr:iZZTavFms6-YqeWhzU47eNM5cDlPkJ2IY0XRjJcXDqP-xoQo79-r8ibDXVOyvU9C2kpwq4zQDYLlxuQTSqJ7hyQK5Nh583r9XexHs4g>
X-ME-Proxy-Cause: dmFkZTGvcWzblz3V/XxkSce1ZAJXcu0WFWFyMky/Ok3mgsqcN9s4ZidkiJVEBQzhdQ17SD
    Sw/sAXTq78JQEsgFkDbQ2VevbAKQODyGiecftWeGvom+U664dqhu8lK+bxyRZiFOL8t3hN
    FO5bnb6clOU/64pWSsi636G6zbIMXk0/No5/lmgyphmAVLhvli4Jzr3fuCtZSQjeHK3cZA
    WWviFicqZ+HBRAZOugQ/qOuWibi8lT2LnVdTgzROtWHGyHDimnhAM/4OEhFsRgZnNA3N9R
    at0b8LDDRSw4nX0m36pIYqlY7CGsL2k2nUD+DAp8zafPN+pi9XyS8Y05+rvSwtqGYJm4f3
    CVoZAkyDMDbXUv9hEUbiCVvgnfaffOl03WDCO/J0yWzoqRWU47LlTf6y/o070TMsZiPsot
    rYOQPOtYAWGKqGt4hWuYupB+P5b99kC6W2Q3FcthYhCMTcIMWsLy/JjSnnD2Mwe8x4cKId
    Cq/oR9bT4ORjZrVpjLFOn2jsSqCoGKpG2HedfMDZ95WRl0hxB6MvASjxYPAfnTf4AB9Z1m
    /mNn42pOTp601zGDFKJMqO4nlF6OoeKd4TvFpAX4dlt6jkv3rkZsIG24nhCt3vpuiBWQLI
    CySsI2eNuEQhsBG2Ofg/A+W7IB3q8bQ9uJk6moduWi9SFaGUduBWpJ74G+Tg
X-ME-Proxy: <xmx:iZZTakHe1coqoJjSfrjrIO_OUFZxqhn4SbViadhdceLQp72s3CJojg>
    <xmx:iZZTakODCy8LLIrRJzx2xQo3iFRcXInXX0vAC3WuZVqnTiNRQebPLg>
    <xmx:iZZTarGWKobCRe6JCg9aMkxQNISnrzgQ_KEA66kmZTJ1V3OmfYmY3g>
    <xmx:iZZTajM5hDoOdFSWbvtmZaRkyp-tdFxBv0LUCXPlOnH-lIs2Oyw28Q>
    <xmx:iZZTarxtmMPb5pxuXSJUAJx0fFmklqxu8hv9FkcVTdkOrWCjWVnkSo4K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 09:28:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: git@vger.kernel.org
Subject: Re: "discard!" commit message for commits that should be removed
 while cleaning up the history
In-Reply-To: <07c9811e-41db-473e-ba0a-cdcbf8187be7@hogyros.de> (Simon
	Richter's message of "Sun, 12 Jul 2026 14:54:48 +0900")
References: <07c9811e-41db-473e-ba0a-cdcbf8187be7@hogyros.de>
Date: Sun, 12 Jul 2026 06:28:39 -0700
Message-ID: <xmqqbjcc72wo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Simon Richter <Simon.Richter@hogyros.de> writes:

> I often add printf statements during debugging, which obviously should 
> not end up in the final submission. My usual approach is to commit these 
> immediately, into commits with a message of "DISCARD", so that when I do 
> a final rebase pass, I can remove the debug code easily.
>
> Would it make sense to add a mechanism that autosquash understands 
> directly, and that could be checked for by a push hook or CI rule?

The sequencer machinery used by "git rebase [-i]" already knows how
to react to commits with certain subjects.  For example, a commit
with the subject "fixup! <title>" causes that commit to be moved
next to the target commit, and its "pick" insn is turned into a
"fixup" insn.  The "git commit" command itself helps you prepare
such a specially formatted commit title with options like "--fixup".

So, it is not totally out of the question to add support for
noticing a subject that begins with "drop!" (rather than your proposed
"DISCARD", purely so that it matches the existing "fixup!" convention
that instructs the sequencer to use the "fixup" insn).  This would
automatically turn the "pick" insn into a "drop" insn when "git
rebase -i" works on a history segment that includes such a commit.

On the "git commit" side, we likely do not want to add any support
similar to the "--fixup" option (for example, "--fixup=drop"), as
you can run "git commit -m 'drop!'" just as easily.

Having said all that, you can use a custom GIT_SEQUENCE_EDITOR that
notices commits you titled "DISCARD" and rewrites the "pick" insn for
these commits into a "drop" insn in the todo list, without making
any changes to Git.
