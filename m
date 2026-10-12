Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B73EC823
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823850; cv=none; b=aKPdyczih+TSkP1bXA0NPKhjELkPmFqauVe+aOv4T+VltGtKWgbaQ5FPhJxQ81sTfNW4eYU6TxxBKaP/1EoVY1xh6CSELCQH99oRTv7+HuFpvIhw3Bm0ExsCHqSvVuXqRHHb/Qve7J/b9FOH19wY4EECQXi7bQ2Mz8nnL8/g1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823850; c=relaxed/simple;
	bh=hrG8MDzES9eHYn0ydaSWUiyYXlBbI2ShdsXfHv4UgYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vlt0yUkhrTHiy6oNCY5/jCqQJUftOeeX4flNFmyJVEewTDeX8Tg9DiXQX2mNgWNJBnPRTDZ4YueWZvzvd0N7r42O9SfA1gt5PWQzWDQZTrO+O2+wgiZ3xdleLUE4QOoYRfy+QKuSSwY+IF6+VWnkUykTiiPiXU2H/aSCsZIaQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SCNU3sgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p2m2DiOP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SCNU3sgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p2m2DiOP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C6FA6EC08CF
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:50:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 12 Oct 2026 12:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791823845; x=1791910245; bh=3Cu3t8DUuO
	ibD6he+o2JOMPIqm69Nqj9Icl7jGhxdw4=; b=SCNU3sgqOud8N5K3Yk6WZuR7gl
	tltOfavyudMi4lKBt9Cn83Fdgm0kqXlofSQuf8UCBv9kMviEUcAdc0s/0KY8kU8S
	vNQl9JQ5tCc/U5PoJzLAkcM3vDCRr+jQGVt95HZ5Q6rINPcR/b3kLMrhk7qPV3vT
	3qZ5XB0KqiZbgIlrZbi/8g9izkuCj/QHLaFayaCM964BxcD7E3w8rluQMYwoBA6l
	9bEb0Y9uai1rot4nLQk6NEIaxkZKuPqSPm3T0vkW+HKMF1GniTBo/Bx66bfae22z
	UrYp9jcO7pfODfpHZWEBNfLhHx6T5o3ZefasDS69yrapGDdDo5J8D8nhCJrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791823845; x=1791910245; bh=3Cu3t8DUuOibD6he+o2JOMPIqm69Nqj9Icl
	7jGhxdw4=; b=p2m2DiOPcDw16neR5ehqaEVR8N6N7Ex8vfIsyZkdJUqDM5oZSh7
	QTdexOrkMmfT2/XnWPobWJ2k1FI0ljRl94YU9pEsUdLTzD4stxKkcqgsB3X0RkE2
	tFWuBmeLHDjhesttyV9dGCfLDhtzWHmHcGkKD/WYE9cf0nTEgG5S67L6hpIjL+sW
	BUVnFJLaFeDgyBBuocegEMkSc0cRL/N4YxftfHQ9va3/V0uHpgoZWfmkDQpGOAGk
	LPJJcNH3oWsbKj9nTdgKW2SDbrm7RoPgKM8TdYo5arwCD/Hm578yNhDwSukcYprm
	LRm9TiCmNbQM7vLW9Nchr1xWkUkg8nTpp+Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791823845; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:j5JzA4EkkjhVBpVPE8srwN9vXqx+vIDFh04W5vxZnvkNp3B
	pJ1Vnf8OCEiF+fjP/wZTnliscDxXtvW3tAFdT2VHaj7phqGS3P2QMFsGyVBYDrkn
	8mBEantHhAjsKI9c5f3EFt0A1Igy7pKgsavE6qOOel0CBe3nas/Gb0fC7HXBRcDY
	tD4mvGgwxAPlNjXO5FVjYeVY3VRxH13dWbMQSeKiTjBTEP5APEsp7Up93WvEYBuQ
	rjonG7v7vhhqnMiaPy6rGfo8GeRW3VMXkr76TcwnHZodTUiDf8bOtDrEX+30ZCOc
	QNz4ek6zYx099abWWMRcE7pZ5BbQSm8/CRN2n6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ImHZblB97KGCLia57SrSxOxMyga2NiMc5fmDakfA55g=:hrG8MDzES9eHYn0ydaSWUiyYXlBbI2ShdsXfHv4UgYU=;
X-ME-Sender: <xms:5Q_NagjkpUVtTuriVTTAD_kwbrar4SrQDk9Y9D2uKS13ikB6ybOfFg>
    <xme:5Q_NarRLr9gXdsEgl_lGkgvHd1ORwIWwScDibltmyZEfoBFPrf95yjxmwiwuwgUWz
    dN0IPZh8kMJ8G3kodhe37GQXD6a-nWRHw-bCMNEn8Q__VrUdwTdN9U>
X-ME-Received: <xmr:5Q_NaqXP2o3fYzMsD7N85VS17QrrhJwCDEyRcmTSnVv_ksEKMGmYP4zl66j9AdkaDnT685PbdL-AEjjeXxomPTJF-ovFgH8ARj8a>
X-ME-Proxy-Cause: dmFkZTGkJMiGJ3NAKKLUBF9eW+LsYKY4RPYKFQELza1rjaZUD/8wtQBgJqHrzcwni2as7y
    TNu5rTcm+FNKLFU+Gn44oLw8h9w0poIQvErxA/74Dqyx4QLHFtPnrdaCv9JQUk3VtZWHKD
    mdlvevRGigWz+bzWjLdnZtqPXxPT90xWRa9ad/eY4oIHCMljWRIcPRQ3UujdibRBnFsfvn
    209eBqB4k+dGL/sqd0Bxyls+K71EEqzZ9Qa2zMfKfHwE9wkj+uCH98BvctcmfvXu6+d54L
    A+dVgwdI/YAjDgp8brXxUtwvf2qBQ8/0GXih4C5QGIeMdVfFKUMxyuX064AHA05ulreFkl
    nHho4wTKm0bCV0kReEoJt+7vzFmFRmNUc1aO3k1RsIa/+GpIAOrMyC05Kguw1FJK5z3VBd
    P2isIWvfXMBz/LuuvHn14V+1kYwE2N7wIk32nTpuf1yeKJ0td+BrxBAI8leRV86DCUuCal
    MZaRe98QxSYZZbRPdeAmsJzs+50TZ1Sh/AumcUgkpB6ceCWjfY2QkROPvuOEcPFm/sGdkp
    uk6yXECF2f5ksQDr3xs6HbXpXTVswMN4wmIUS0K9VwZFQxpcAGTx51OcUmFnolDXqaxZYF
    IPrjFO2PNJ9+GVlIqH82SN3p+x4jkyzX7969b9CZ2nONp7rP3sd8y40LlgNw
X-ME-Proxy: <xmx:5Q_NanQVhA3nZcgJh-fM8yyqVaPfSpE7Q-xTa0ZIURQWicfMbN0DsQ>
    <xmx:5Q_NaskuKBPdYexry2tRJmX-MMCmYxsgBnKG1awD3h80sfBPQXespg>
    <xmx:5Q_Nal7hvQN2gPZI0kuSyUeYyBvktIEPGunwyOunNwGEx9IHuq1zFA>
    <xmx:5Q_NaqjE1eo-1wtLYAlryifVqg7iH0w83Frti_BdAo_bodvNfXcmxA>
    <xmx:5Q_NaiG3jktLUwI8umvfGHTWkgff-FRo-mwwh4WmrZlEqCs0NqYSiJnt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 12:50:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com> (Phillip Wood's
	message of "Mon, 12 Oct 2026 10:50:43 +0100")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
	<xmqq1p9vdalz.fsf@gitster.g>
	<03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com>
Date: Mon, 12 Oct 2026 09:50:43 -0700
Message-ID: <xmqq4ieqamn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> detection. It would be good to get a clear idea of what the tradeoffs of 
> the various approaches are before any more code is written.

It sounds like a very sensible approach.

At least the one-to-one part of the operation should learn from what
Dscho did in range-diff, especially the part that does take
similarity of the log messages and authorship information, instead
of paying attention only to patch IDs.  I am not convinced that
one-to-one rebase implemented as a subset of squash merge would
perform sufficiently well, either.  From the user interface angle,
it also is not clear to me if a single --delete-merged that enables
all variants by default with individual knob to optionally disable
one variant (squash) would be a good extensible one, when we may
need to deal with the third (and other) kinds of ways to integrate
your work without preserving the commit identity, like selective
cherry-picks.


