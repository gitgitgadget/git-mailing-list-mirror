Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422E34252C
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200102; cv=none; b=JNY0P7uRxXn+wVSR4wBYnScGTav6xXT71gc16bTRWSwBI0a6WSwhWGBH/vTy7rD/1BLbbKTmoQvuEhTL1AlwbYJJLqp/NXy8ZI8Q/89uS+ESpPT/kMUxvAIAvOdq05yQrERap5JZP7HrqT4jrrbIF+qjhdt7Bwa9KKB8vhXebx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200102; c=relaxed/simple;
	bh=R8XMykJYiN6g6zsBfaRbWFK+3HEfuS5w2ViyviJNgBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5X/cW5qiFNCHFTTiloLnxQ0YQnyFCoOt016V/jCfgVZZZ1x4zKO57Fb+4bcvRgTbprBDLhjzL4rgiGmI30dN2lS2kF7x2AiM2/5GbpV1hXIA+SIyJh9xfJktRi9BLVpnxu3LV2BZeG8ApIuMi6yo7Dvb56eTucKUFoaMsBDRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j7txHvJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MmJM8d4r; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j7txHvJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MmJM8d4r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 39D6DEC0191;
	Thu, 11 Jun 2026 13:48:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 13:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781200100; x=1781286500; bh=86PEXox1rk
	XzhoyA6NIEluz0+J+rcwDCBV32hPtMkZc=; b=j7txHvJNmXxobDNK5FuXApZ7KS
	QhNtuYvzd/sljPuUsMvfA8zqaVxdIL6hE5ndbSgSwM7PHP9E9F5EvuRIm/XomNtQ
	1eOuUH5rBeaX6L3e+4DiVZLo+IF73dJlkh3Gu0PyHtKNLIuLZ5dkBDaYRZA77Ud5
	CqCb5UWolD3je+osEbuStVZUgJfeuyNAlBbxrmyYgl3spGnSGKMAETRWkBuVTBdM
	vCYppMRKeW97ryw+e7iMs6xIUkPG49s5qeitU2349pF5v8uKhHtXG5143pvk9hy+
	yOkM4izx1GPGEpg9bauuPRiF9qKM0MQ2isLuWHRX3ueQpsLNG9kEzNDAKz1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781200100; x=1781286500; bh=86PEXox1rkXzhoyA6NIEluz0+J+rcwDCBV3
	2hPtMkZc=; b=MmJM8d4rkDMhvu7FEhvdQy+Y+9V1hDtH2l3/5LkogmqGD83JYS8
	1u3LCTr1cettmlzY50LW3sN/9wHMHg3NTIWlUPyP1bdyR6wrt5PtWiZh9AXJq8un
	ojHREz7PeJL/7Kam7Qc7jM95xZwRhlXoccJzWaYSEEmBrXmxE5NC2pyoaKFm21v9
	506YrMZ6C5r4zhI7iVciDJW0LtlKtubqlVzCvjOryS0YQaAak35B/zY7d2aeDopw
	lOohP+ueVRDCPSq22A3g7xM73qXRULRDhtdSlndM4zPIKqIcZfVxZwMylZE+ARk6
	LbG0dxkg/9ebefDJgfXR2bH8pJjk/PhNHeQ==
X-ME-Sender: <xms:5PQqatAzLyzuMknkrksGqriTs6oOUXEYgh2w_YaskhTWH-A3i52F6w>
    <xme:5PQqaibWkned8UUv7_6yQ32jWAXeGEmHlWDLhlfuzxuZtssxJz_ax4CoEL5PSWeky
    4XhSbBC28vaX5tvJyZ5TjX265Z9QggQausvKJG1BfJ3f7AOOM_B7Q>
X-ME-Received: <xmr:5PQqag7lBdiiOiXUD7VEyiQ46M9qqIa_zhlqq3PkVScEvoVfAY9UjvEgA2WIW5XAmwb50qrwZmsOUSN_XD7Jjj1jOAmt88N26SXg>
X-ME-Proxy-Cause: dmFkZTGBXVDdOClPYoFMTjfJ+9IobeE6pTQ1vPpV3G9tASv2+Lc2X4NUsePDDu4z+N+eLa
    qpfFyJESz/2s+DovcA9U0q2/umBEvjE7FEBIQ8rcrljz+t1j2OW6/1SlFu8mddjn52rMGm
    4CXdvwH/J4ic2sp65Ztyv9kkWtlFwk2Re72nKpW9kxHtYO4ZzhAWY9I2jzgCDSpK3JKGdq
    0XVFy/gRjyTScXTPz7D/LgDeWQudcAn8dvC2vZFaHonWyVEEeFSCXAM5gwPf9Row4zYCO8
    wNr4/NcTakd+vCPqTKuNi/RlHB1f6SMWKkfgSfuM4VackBZaKBcSD2eT57tRsfTA87IVez
    TmBT97fjlg2RtxBrLeMdqYfmwMgBHkHad+nPcesYRH8zjvVSrCrceD/SsklWh9tlvzkDbs
    EEzKDSbu0tl0PuLoZE8EBORoV9HNE59ZFQWSvpF4+Z84nA8ByRtRyi5sMWTDXHwfDppx1H
    fLPFppA85sFwUaaVW66Kj5Vjxl1iUgAyAvikVnGkXZm/Yywq2mcZcIxK5Sm/wHw9vclH/G
    d1TtNGyqqQpY5g7oDTvnSl4tOp92xxZplTzslMlresi/OhAnb9QtH506epZS+SCgaOuZVd
    u+fQENqq2IDybTu1Uxlayhufq9eitMwmD9ZUxcHjYTmdJCiWN4rs3ohQEg/A
X-ME-Proxy: <xmx:5PQqajZF1hjWYTNpzKBrmfBarvuzZ5QRPkjNE-9L9eenKC1P_6pMWg>
    <xmx:5PQqavi4R-zo64WtUUXEDfbfSuCewpejD86RPlC61VcBELGm4YO0aA>
    <xmx:5PQqak_rVKN9xfP1gGH6hioa0ALPpQOHziNWuZwZVm1VmjnqYQVYGQ>
    <xmx:5PQqaqpynputjNbEJWSmFEhXgtmW2cyEkkFWXSId4AXf7f1CV-WkRA>
    <xmx:5PQqapa4f83ADHwM4_qOAn4ukv-Go64Z_ceheIBeaE2pcBnzUwf6TiJS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:48:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2] commit-reach: remove get_reachable_subset()
In-Reply-To: <ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com> (Derrick
	Stolee's message of "Thu, 11 Jun 2026 08:57:19 -0400")
References: <pull.2144.git.1781033285419.gitgitgadget@gmail.com>
	<pull.2144.v2.git.1781178567862.gitgitgadget@gmail.com>
	<ffaf26b1-c55e-43c7-84b6-f810a54f7717@gmail.com>
Date: Thu, 11 Jun 2026 10:48:18 -0700
Message-ID: <xmqq7bo5nf31.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> Finally, a commentary: You seem to have a habit of responding to
> review feedback only through new patch versions, but I'd rather see
> some thoughts in the discussion thread as direct replies to the review,
> especially if you think you will change direction like this. Saying
> something like "Maybe I should update the method to have two walk modes"
> in a reply would have given me an opportunity to respond and perhaps
> avoided a new version that went in this direction.

Thanks for saying this.  

I haven't (yet) found it in my exchange with Kristofer, but I did
find similar irritations during review sessions with other
contributors.

I wonder if we should talk about it in the SubmittingPatches and/or
MyFirstContribution document?
