Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084D38889B
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782766368; cv=none; b=Nn+JRUtTRDGlb7vOvGiCN6Jfv/yeTDhHwGJp9CAVyKcGYNkCwQcmMoB4hXyW7cMQJvk2D93EMQiCt+nVGR5wAPGFKAVgYevDrro1khgxGuKOIBklKmn2Mm9YsOJOC/JvtW9HXUbaeVr0+Ev/qvyg3LhZep35quGcsSoRRx1X2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782766368; c=relaxed/simple;
	bh=uf4mDMB7tEFDnwoGc2B1dXIu0+hIUl4RJ4EQwSleQwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CL8vUQt3Joaf4vahaZZlsZI2HzZMfaD4h1TA7EpKRA0lj365UG4AHGoWjaFlVKYRi9nDFOhtCGZPfiiO3FZbCn0mCzDJY3kTYWg+Bu2lM9JIQymZed7S2vz+fH6wF6NHon9zMVyNQUlD3YI7AK0pkItypM/oGirTHyne9p89RNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TkalLQch; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RqxM9yzN; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TkalLQch";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RqxM9yzN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CC2B7A008A;
	Mon, 29 Jun 2026 16:52:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 16:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782766366; x=1782852766; bh=J0FUamc4Jl
	R78vzQN5wcdi+xQbDVDR8rggqMmbDzb0Y=; b=TkalLQch8I4q4ulOMnhjVl9iXX
	ly9FSdVZrPiBtef5Xcq1X0AKX72tQea0IQuqIT5r8shmMay8qJdo6o3PrdetUFTf
	pIZzi2rkLnyyDD2zKPAYGNiag6E30deDIXpDP44j331yjUaYRBejz4WShZjdwaIk
	Wph8U7PDLfNEaTUOZOmcQoK7ZgOpctb8GM8NbIIKxnYy3juW8R1MdGiME4Dtk3eP
	9jXmO+EbhNNrJW7W8DZ30Is96wTXcN/fXVID0vMyio25n8cRXmivttb++DBb8Dkt
	uRNNq8Q4s1AH1+syCMI3Vg6/uRu1dwuJoCDFjUvrEpLyTr6Q4WdCJ1gtmALw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782766366; x=1782852766; bh=J0FUamc4JlR78vzQN5wcdi+xQbDVDR8rggq
	MmbDzb0Y=; b=RqxM9yzN68UeAG/eiPJ8Oar8/Xzj3wQwEU38rJrmaPLdO9KNOxG
	6G3ziEWXl0KWaezqm4/kitwozLJXx23ikeQ8HMRAfJvL7zqDTvT3X7lpZ5qAho6m
	qVCfcjgObfvTHW/wibp3DkAyKrp+FjNE+HvBFNXrznwpLOO6OjykvJnPUczLxrpl
	SauGGshBAwVaJDo/ivNeKER5nDJA+Nu5etwVHLjp90aeZkJ3BqLzg6VvgCsyjrBU
	cr0bIGdlxdHXLDrMyUC8OMXntDZGsZMmkZxARSIxY0yqkmad2LHNNd9quSUu6DBo
	YSuxi0cwpQKw4jjEBFeetboGuS54poaSBYg==
X-ME-Sender: <xms:HttCarlc8mxxtG_hev2S4vkTrOS2rFsLzxirtjIMjJWrlr8VIyVwDg>
    <xme:HttCamSo3bzOS885O0jRH1KJEUkdof6cPf76Nuw5ubbLYrjmWasbsPkKd-3G6B8dw
    U4n7UQdhb6zxXImkX5tnVib6a9hl2R52xw0E15Yy8a_OyHqAaHSjg>
X-ME-Received: <xmr:HttCavCSWLi0XvW3NX8bvsqmcksxq4yWn4O5_cnTcD_zZBpUFHyaWPcu_JFS-8s8Io0aXoQ6W5oizO7G-ByE3T9USY9-Iuz0eSLePcc>
X-ME-Proxy-Cause: dmFkZTFH/j9S5lqH27dMP8VmSvGy5zW08L2hV2YhY48vRNzdq3/98iNlv8p5RoEz6/+Ldn
    v87KucwGAWfiD6z15+SjvDCmfIMehgbCKjIR0iXJe2s9gHuqdKHSJ65qxfajgIhU53A+42
    77XDTTPvSab0usc/ePX1Ea3Gp0Y8nSq3xGh71PVL/A1ESgSVvYmQgUGgGGGtAw4jVlx2qh
    Ly6G1Y/XLZb07zSQiLtqPd88tL/sTD7uiknn3Pu6grDjNxhzDEE2lTHOgvXnhSNZKDxcJr
    /uwkGrEL5X5CkO6GfyuNc+qCqrnPvdhjK+gM2zhOzQt0GQYVS724ggkiRZ0n8acJlFlnsB
    cMC/4xEpnEMeYn47ArkNqtE6KHKV0JHID8P6qv2lMVxAdB8A8i3hVi2lOD6q/0dVKo5mCw
    GB8/qEroRxDWApdcWeK+zS6jZZeMR2bW2H7bFlFdVEu7paiwqXL7C0RhAF9avIxCVpWxif
    9QJmD92ch6P1ho2kkSpnlMNhLLMp1fJlVhZe41duJtn1ct9Lz530hbPOp7EYTQjbUebyhk
    snJ0IUI0XkRdocI0YhGvLELmEZslFCBOJXo3ctDnF/OUZ21xqCIzYe9pmQL0mDgK17QcWw
    krlQLfynUZ1tgSK/lkJOpsl1bju9uu7iQQtVX23tcekzBYOqr8RQMUmUK4UA
X-ME-Proxy: <xmx:HttCatSzxI_WGeVVDq8lArCjaJWUKO6JiNTDOP6-QlZDDxFjprTixQ>
    <xmx:HttCatqEIvpqy_v7xpR0jcoh5l_8C_Brj49ReGqeKlg0OH_hZKz-OA>
    <xmx:HttCavztlxPiafRQlx49BTAu9MQEF75WUnHcHTGaHH3HxQ5O09cVJg>
    <xmx:HttCaiLGozHKqpifMFUyzHs8x9RqvZloq1ExovS0YpZkiFwXGeuiNQ>
    <xmx:HttCamYYqe0TgG1ZDEXGt57zMV414NC7eY3PFvlyYgK5-CONkOR7jr8s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 16:52:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] builtin/refs: add ability to write references
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
	(Patrick Steinhardt's message of "Wed, 17 Jun 2026 12:15:57 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
Date: Mon, 29 Jun 2026 13:52:44 -0700
Message-ID: <xmqqik71ul0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Reference-related functionality in Git is currently spread across many
> different commands: git-update-ref(1), git-for-each-ref(1),
> git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
> hard for users to discover what functionality we have available to work
> with references.
>
> We have thus started to consolidate this functionality into git-refs(1),
> which is a toolbox of everything related to references. Until now, the
> command doesn't handle functionality of git-update-ref(1).

This unfortunately hasn't heard any responses since June 17th, so I
took a look at it again myself.  All the things we discussed during
the review of the initial round has been addressed, it seems.

Shall we mark the topic ready for 'next' now?
