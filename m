Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28B2DCF61
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218851; cv=none; b=j6VD4GwjQ3Jf/iMmb5Eh8BRHrqpCMCeG70p5ZSoo9pwBu9mv+D//vrF6kWIOsROjBTeAbgLv/etxHp5mefuv8nR/lspbwirKdu8ZuCWpSOGZYvH49Lkn/dPxeHv+JUju6tlH4S4Ai7oWEXhekUHVvtBfEdk+BNb5NHJw69TmQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218851; c=relaxed/simple;
	bh=+w7PheZ/v7zpakooXwKSMXw6Wi6VRSX+dD72QJ/izmg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFhcghURJzSyIqdCns7EyR05CVKcVM+IBygIuw/0ZKlS/k77r7hDTlJZl79hEygS06AUMNmbD4z3HLPgLIbEMrd90yoOoeefpuyWpDUQ7OCXFt7ywWykbExR97Qiq2HT91I76Nz5qkBW4zmzN2+pXq3uAtPdD+FAsdlZGakw4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZUxJsat/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePh1UJEM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZUxJsat/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePh1UJEM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6404C1400187
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:47:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 12:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791218849; x=1791305249; bh=hlCWoSSoFh
	eT2c/gjUz44XB4d2QbJeAQzDKFhzrI1Ds=; b=ZUxJsat/IFdTZZK654TiaOWQl5
	oyN5h912yFRi0pLIwfIv55wWW3P1Fny17MceeKzl3xNkjVoQnfP2QdRs/ISj5ISh
	S9pe1HNnapG5p5SPbETf4EvRkC3rG1lmVmxgLP6MJQnaNx36rXK7WaQ4SFqG30yX
	r10doG2MrMbIIm1xtLwlWAWZqj4s3td0EG3B/QM6RgdpJpQWCQGIljOTypaFsJLQ
	SmfulrnlaQjPo7Z/8RTOaAu7cdcPw9rJs/1SCkcYpqEAR4JVWID4Ke/WJDtdCzPp
	OwoWF7PA1y/NtWo4trjdUC/lpwBpZUWCrCRwuXFFT6OTpslNorazGR/T0frQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791218849; x=1791305249; bh=hlCWoSSoFheT2c/gjUz44XB4d2QbJeAQzDK
	FhzrI1Ds=; b=ePh1UJEMwTKPEDBrwymUVSX8o1reXqC+SevLLnVz9ocE0W2K00p
	6oG1nfrYE1Z2w9OsW6LxbDKh19TLT1HtdtcHfkw0H/dMbjL6cq6VkKC+sBgnM251
	0rHNmcVRO/JqAw9XaH2t5k71x3ynihxQ3vQVJm19VTZouMzZ8QOlHF6BHp4k9Ckq
	OTMzmWQLwkvkDHsreJ8zz2iPGUYcuVxD6ECLzoBrKdG51yKikWOPFLrLSuCnJp5H
	wfXVux9Yfm2L/7nnrNCmFWUOzs33TI3aOm/AHyGAONLOvbHkBCbVee+/OJcIXkKf
	tJInLSUyfWEWqPgrwY7/Qbx49w0mRnICksA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791218849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:DwCKxfywHw1Iy9ueWxMGld8ZHEmUFhb81njd8bLfZeuuHmu
	SAEkwEBunUMT7MHr/AWNj8RGVbWMsn1leMYbkm65pPIbxTtvvsTle89iA0XYyjfH
	Dm4q8NEV/GZcQI9oDlnUSJ3HiEHBdI3Zwp5zhSXvC6g6b0a4zaJkCnD30MOnJfSH
	kW1lNdNG7KLhWiqNpgcV0erDv7tLMdSHt7DuSvFRYaKPSroe+BHoJRP8fqIhaHTj
	R4GUfb4JuyJhBO2GhuP2UXxcK4Q2/Zi3nUPnn15Tje+kYo5OudFRCWDW6n6HBrnq
	Ft+WResHO/8NYhg6KA2K8UTzDzWYkRSUeZTzjpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QW1jIbpcmcDds8Rwo5Gfb5aUrpM5rZu34C58u8Pn/Ek=:+w7PheZ/v7zpakooXwKSMXw6Wi6VRSX+dD72QJ/izmg=;
X-ME-Sender: <xms:odTDauydbDvRb3rE_RoBuircrCS_PVdJ7yjRmV2wY_f4gvGG0NE18g>
    <xme:odTDaidWI-PTFFDZdLZvqNEpNkGtoLU1KcGrUoQmT6QANaIcsFgimLzoK8kBUfqT3
    _spbCCkTMXJpA6-jdrR3ecV3PHcEmhdgd9cnD6LJslwbIZtsbk_2Q>
X-ME-Received: <xmr:odTDar564Ty2Q9LSdltCse3RXIRKrsuLfccrmA84L_q_C_6CzbInWFwPzpu6eZ7kl7zl9ETMKwycLgfT23fd8wWMrdcb1d2oEing>
X-ME-Proxy-Cause: dmFkZTGRgl9MZ7syJVRavbl7l5Q1OD6yjB9JE4uaQXleXYe/plRzM2fKujF983P5gh4Pub
    jYTj7k2vraC1pRyNthR4kARlYP5jFs+zFf5Tb6N4Bf3Ub3R3HcsO6hAGfkNejTbMiZCbbB
    3nco+dskYOu/mZZnxNyXdPx8qqBdYnr72oBSwEImTbHWEduKJjfDc+K0G5jN2N+uaCrJfV
    uLpnEclaodwBQ2DmhSJZoF5lxNG6wbM1L7Mn5+idM2Hr7fy5W/fp7KLzC0bwOoONMwF+Ak
    AnOi/ttJ9viRaeFAfQkFHCzhp3Grvh+ov1xkDe1kJ47xhO5fwXLMAVXdTya0NB3USW+ANY
    0SszqK6edcceBF7gHLdt/tbPo7Z0gfKr30P2w9lw+rdDOgKCJ4vm41yq2vdBtvDuq8ij5d
    7AIYPJ3hEPFZ01d7fZRKgzSGP/3IPUN5u5SGtH893th+BI0V0xDmEQ1l4A+qMgKonUaMeV
    5sVMznUOpUcBqOxafG/qFDHJSU5/aKQ/F936nd/cSBfyPChnDHf4GvTBC7gjRMWMJP1yg5
    ot1swdkjbcZkNsj9jyMvnzZ3u42O6P5O1KD/NzoEVoANXREGQnQSzRaSaL8CbsydbdwPo1
    riDl1Fc/YWaW+0tx05TugOkM343vQqxs4h7yDcX3DVczKLKnVtcjq1JA148g
X-ME-Proxy: <xmx:odTDavJ86M1snsihpD9yIhOmfomO9MeUg_s7GSE2_s-e6rE612Ngag>
    <xmx:odTDarzipI6Jj_0vm4Oj66nS6GqoewSS-S710WypBXGYMl0FTRFikw>
    <xmx:odTDavJEHuSzfwh9efaeQNM7PvL8SpoZA_iqqFAmtypmiKhBzKERtg>
    <xmx:odTDaiXit410FY1g7GrcKbBX4NKNYyb9IkJvZWpjwCTDcc2z4UxJRQ>
    <xmx:odTDagGQbjKdQ3mmrCuh1ZHrShq-VPpyujbz-iieuQ5S0gZIeejUaI5F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 12:47:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Domen =?utf-8?Q?Ko=C5=BEar?= <domen@cachix.org>
Cc: git@vger.kernel.org,  cdwhite3@pm.me,  phillip.wood123@gmail.com,
  sunshine@sunshineco.com,  ps@pks.im,  avarab@gmail.com,
  test35965@gmail.com,  kristofferhaugsbakk@fastmail.com,
  maciej.ciemborowicz@gmail.com
Subject: Re: [PATCH v3 0/2] worktree: add post-worktree lifecycle hook
In-Reply-To: <d550ede0-6a33-4eea-a6dd-051d110b68e5@mtasv.net> ("Domen
 =?utf-8?Q?Ko=C5=BEar=22's?=
	message of "Sun, 04 Oct 2026 23:09:07 +0000")
References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
	<d550ede0-6a33-4eea-a6dd-051d110b68e5@mtasv.net>
Date: Mon, 05 Oct 2026 09:47:27 -0700
Message-ID: <xmqqwlrwjdr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The topic _claims_ to have been sent with

    X-Mailer: git-send-email 2.54.0

but it seems that the thread structure is so screwed up that some
automation machinery I use seems to be having trouble locating its
thread.

Here is what I see:

* Cover letter
  Subject: [PATCH v3 0/2] worktree: add post-worktree lifecycle hook
  Message-Id: <d550ede0-6a33-4eea-a6dd-051d110b68e5@mtasv.net>
  In-Reply-To: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
  References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>

* First patch
  Subject: [PATCH v3 1/2] worktree: add post-worktree lifecycle hook
  Message-Id: <2c1c1f06-05e7-4d8c-bd29-c2a9708b443d@mtasv.net>
  In-Reply-To: <cover.1791152172.git.domen@cachix.org>
  References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
   <cover.1791152172.git.domen@cachix.org>

* Second patch
  Subject: [PATCH v3 2/2] worktree: notify post-worktree hook when pruning
  Message-Id: <f7ead9bc-fe6e-49c1-bb7d-6efd14eb6766@mtasv.net>
  In-Reply-To: <cover.1791152172.git.domen@cachix.org>
  References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
   <cover.1791152172.git.domen@cachix.org>

Notice that the "cover letter" that are named on the In-Reply-To:
header of the two patches do not match the cover letter message at
all?  I actually doubt the <cover.1791152172.git.domen@cachix.org>
message appears anywhere in the list archive.

    ... goes and visits the URL and gets "not found" ...
    https://lore.kernel.org/git/cover.1791152172.git.domen@cachix.org/

Somebody should find out how send-email is misused to produce such a
broken threading, and add some documentation to the send-email
manual describing what _not_ to do, and/or update send-email code to
detect such misconfiguration that caused it.

Thanks.
