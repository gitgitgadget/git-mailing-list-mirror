Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B402E06ED
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092764; cv=none; b=RlXTqKjjbyk1lVA3TD2LMYVHGXjSbBn9zBPiigU8XMLhN3HWK5wfhG09scCOdj9P3HA6pDmQBHDtWrHncOtKnRCIT22Xf/KI5iazTYAd2zD6toaOhdYniKtbbdwOmz1Y88yHlLDe8/2xfIIpZDXMNlF4LXYhGv1ZhG2fAqWiaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092764; c=relaxed/simple;
	bh=yh28FOgsepMmBm0BNAw9BOOH9Yr4MMZqZjzHCUG3wrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C8wFiDV+ampU1Jf6KYwefd87/QzKxvlFGcWiHeIiINRIxXE7EXduPHB1O3X2tQtNjJUKUX7WaGzKMVketMMl4uK9a3roQ/CovoJe2QZ2Zr3D0LV4DK3wJgtN1+4pGuQ4HaEZTdRNy/1gVIVK6C7Yc2b3nY//DCcwik38BhLMON4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LM1HibyB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQbpqVlI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LM1HibyB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQbpqVlI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D48891D000FE
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:32:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 15:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792092762; x=1792179162; bh=TEHVvLyIzd
	9wIjIdLTpSDUA6GFit/dhaK4G6M/okWOU=; b=LM1HibyBgJ/6VTBscSQU0xU8Km
	n50riJzgc2MR9C7FofZlKmxtOvx/p8ZXuwrT/SHwLBq27tdBYHJn8sZHHtRU1hn5
	bnZAVP4tmME/9qkppbqQRr+JZZQIChu1b9zF/WZgX6zidIXHA7RGiGkBsz16Olok
	HsoInbJPRRNr4AX+uK9B3qku5K/QWnOB7ua96EUmFgCV4en2dONOP50mVm9rC2NA
	nuAJ8XO6DlPHt8TAWdGK7KMfc09AmzeAb8npgQwd4963rA+JsbX4GIRxXy9DUYf1
	MoCQn3JpWNryna655N7ug08blguAI88rdPUTkYJI66eFCn0NcN9pHfGbQ4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792092762; x=1792179162; bh=TEHVvLyIzd9wIjIdLTpSDUA6GFit/dhaK4G
	6M/okWOU=; b=QQbpqVlIreJ8xmWth6QN9anZfmbfoVh5+yxIVHc0dqJmVtPylMg
	yg+sgAJ0FShfZjut09pNxYIP7s58E3Vt9OVdqV/SS7lYGOeCiff1LUdjGu7ApLsV
	2nleVsa6lJ+Dik6IydDMdJGCKX6atZQrTFekY5WtW+9+gHBwoEq6cFOU1NBO68kR
	cbFsZjvWeEweqiLQJ/DuR0H8CbWBCn2YB34jyWoyNsD7rePT39goxy4NXx4+nIwB
	kWmnpUHxOM7CYcj3JR6BoMpMYJ7E1xWOLoXWZXYNBoWhlsrfPR2WRIVspw9wLrkC
	hmaS93GXWq/cDBUeHxeKSl6S4H6UdU7d5Vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792092762; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:evQ9tUP11d4mQ1jeE2n0PVaUf8ORQUEZVyxQjd8YK5FsubV
	PylxXZg6NBaszVk8CiQknRre6sNrZYej1wQ3WUF3PJaDqKVw11tcZNO36SrOwL/C
	bzo9M5mv1j9MTE1zTbU1ef2cafNjziHVjkuSVrLDrMuc1l/4YJBfePZL2BCB3N3v
	ctuAe4nRb/BRtHYuWSkoVs9qOJWLxbptp5GlU7AwWbIvQQtoEltvVetOy8Zxcx38
	K3syNf4q3+9rdJ7QtSeoxijPB1CjFBK4taRGNSKEhTrymN2awudagw9ztCbD7hhN
	G9aj/Qyxgr7esJIDSHfu8HhVJ/XcMSK40u3/7aw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:UwKpHyQFApZx3l249zHs54C8x+T0wJGCHjOMhZUk16I=:yh28FOgsepMmBm0BNAw9BOOH9Yr4MMZqZjzHCUG3wrU=;
X-ME-Sender: <xms:WirRaqAGpPTAycl608Uth_6zgkBO4c9U_vNA11S2O1_M8nSATqNyJg>
    <xme:WirRaoPTu1obnlq0LJGP0OM6wfuf2Zvp3Jy15a-IsHlRtIEwzR43Pr1PaZm6BFw9h
    QoASRZiOVOdUNdxZpq0u1DoKZ1ZbD-O4g2d5Nf2zhII4Lj6up4M_ygW>
X-ME-Received: <xmr:WirRanYbiEEgouVLii-m2_mYQ-nzHsQia9hCBSZp_Uyvn3QqBS4rYFFynhtPxsdXr5gR5mkHI4x1PWeioRSFReT3DYJJiyVWj3s2>
X-ME-Proxy-Cause: dmFkZTFBbP+D6am80sqVZ1RHSGnZ1sytI1FZcFuRt0kZ7Qd/D4Y2I4VG+hpP7HDsrpYu2R
    Z8NZ3l5gZZJ12UF8XyIceSalzle4CyVUmE0FRm+IKEDiq1glPS4g+OiViUMGhFxkOb7FZq
    RdKrGB+LSB9SLuXRzlD9PZdWW0sPInNtbEIktzyjXPc12utJNXtWJtt3IRkiqa/Vc6pNTV
    g48VPvGbKCZNJPprJP0d9eQfSK47fGL1Q090ibq4Fpt4/dcMaxYzmVOfOWzz11dmIf7dKV
    NudooXvBOuNkXkZEsC6i6lmalgqIiF3p8jU9mLEbAlT3ndnwzoI5CVdLEgfqeuccAv+Okk
    +FvYpTjC7rHTeXbilOs7Nnuz6EO1JckdMgkylkjyi5lEHK06IiHXCyg6Vqc/zz0yuGdA1m
    O8KdoIkU+uuDEoux0aJ4EQrH0TZBUgVQVx4Anfi3IFi2/zQCL5Uw3XhfS+gGD4Ubz1FvMj
    KzB4j8RuOz1Ut66wQo52ITYRYo9FGyWt8LyitgQTjaVKlRcpuQ9XnFlP8PlvPYFkW3z8oL
    hLSM3yb9EVzU9uYebidKGenKj+23R9PJlaf60lFML8/eY+xW/TCm3FoxRVbzDVjM+gh+7W
    Ip5+hckmhY83nYynx+LcFcpaSa99q+euKqPfTgD6e1FOMm/bcpuPCdFc5atQ
X-ME-Proxy: <xmx:WirRavskVbghdkRu922SI4O-3gdQ4nYYc6NEdX-W3MR70viGpVqIaA>
    <xmx:WirRahMQVCM2u44KlKBAwOvf6cfRuIZCgPPAPB8ydaIhcjzQvQmilg>
    <xmx:WirRau4I8GvI8MSe9ZIF4pw9KgVTralAPpvfKlIhR6tnAR44B_Vqcw>
    <xmx:WirRavQXqkpnyTVdniFsVyLDvvqxR_n0d_MkqKmuFusLz7aeJq-IaA>
    <xmx:WirRaisQ1OpYMYpFY1wek61QBMvuR7CjCONWxIeNCXL3cTDcFkiy9oxd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 15:32:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH v2 1/3] var: add GIT_HOSTNAME
In-Reply-To: <20261015105859.3184108-2-bellacaselli20@gmail.com> (Isabella
	Caselli's message of "Thu, 15 Oct 2026 07:58:57 -0300")
References: <20261012015846.2649843-1-bellacaselli20@gmail.com>
	<20261015105859.3184108-1-bellacaselli20@gmail.com>
	<20261015105859.3184108-2-bellacaselli20@gmail.com>
Date: Thu, 15 Oct 2026 12:32:40 -0700
Message-ID: <xmqqjynin4iv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Isabella Caselli <bellacaselli20@gmail.com> writes:

> Git asks the system for the name of the machine it runs on in a few
> places. For example, "git gc" records it in "gc.pid" to tell whether
> the gc holding the lock runs on the same machine. Users have no way
> to see which name Git uses, and depending on how the system is
> configured, it may be a short name ("myhost") or a fully qualified
> one ("myhost.example.com").
>
> This matters more once the config can depend on the hostname, which
> a later commit adds as an includeIf condition. Without a way to see
> the value Git uses, users would have to guess what to write in their
> config file.
>
> Add a GIT_HOSTNAME variable to "git var" that prints the hostname
> Git sees. If the hostname can't be determined, "git var GIT_HOSTNAME"
> exits with a non-zero status, and "git var -l" omits the variable
> instead of failing.
>
> An option to "git config" to show the hostname was also discussed,
> but "git var" was chosen, since the hostname is not specific to
> the configuration code.
>
> The test only checks that a non-empty value is printed. The test has
> no independent way to know the expected hostname, as the "hostname"
> command may not agree with what Git sees on every platform. The
> includeIf tests added later check that the value matches what the
> configuration code uses.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
> ---
>  Documentation/git-var.adoc |  3 +++
>  builtin/var.c              | 13 +++++++++++++
>  t/t0007-git-var.sh         |  5 +++++
>  3 files changed, 21 insertions(+)

Nicely written, and the implementation looks sensible.

