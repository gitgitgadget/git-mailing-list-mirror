Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810832E143
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113391; cv=none; b=U3OG7WF8RktPNLVOIdhATJBXvQDRKxiXlTdZIpqCIoRm3FT3mQNxbp1OugXZBlDm88K+gtvgB0sgDyibLFa4VdkvRX6pphzS9IM9tPOf/QhZPAv3PA+S46jgVmuUedrJvd/0zOYnMH8CxkgNXKGqG8gs5GJCfw7u75f2wxrMq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113391; c=relaxed/simple;
	bh=f9n0+L10F3+RHtzQq+WTKpI+eBzqid7OZGzNMot+qqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcQrvXA+zyxUtTvzct/pVg5W9gUqg2JxAYTrtIDeTz7XlP02J++DZHwV0jUdHSZfJXlqQJbnizHEhz613V+IuljTtuTMgJgGAJ3qCLeIsj9wr/1ozXQ886B/khp0ceR3u7dMJrg57EIGH4RY8W1oAQre+wiJJnYXCWoRPcxVEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NMJm+6Zj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXsjcPXM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NMJm+6Zj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXsjcPXM"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAAEA14000D0;
	Wed, 10 Jun 2026 13:43:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 13:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781113389;
	 x=1781199789; bh=HsB1HSh8SHOS8gPe7NSi8IyDBXl2IsXJn7G2+BMykgw=; b=
	NMJm+6Zj+7tEeS9AUWmQb5BumRSZO7Dkkv2Ojad4lNZc4SObBdsNTfYJiR86qjyb
	fahMe5q25TRyrE88IffmloxPDRpbiPaKAHdi4GgcAXjIGVpr3XtSC1WFvcYjSIXk
	mNWCBIIBJ60+1cKq7qxsPcDgaGPR9esB2qg/XODLMijsfTpdcZ+RxkHhDq9x+Hgc
	q7ZXZQq21kezPkVcbuY6wdPvF8iO5tbimhJbtzCeMrdZtixvTDPwaCmOFfzO1NPi
	/A6fMlkWPGa0nqvIXw0+9OLTocYp+7t4alLWkivBMHKZVdct8OC4y+ogVAPE1uAy
	A2vbx2Fta+o6vz90p40C7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781113389; x=
	1781199789; bh=HsB1HSh8SHOS8gPe7NSi8IyDBXl2IsXJn7G2+BMykgw=; b=Q
	XsjcPXMi38M8mG5gSQypYUE6ef5PNjc/CNotJ0I8RaTD13dFAIagfbJnA+ViiIWL
	xgoQ5SMjYDIH598wAw1sImyGDce/nxWOL/kxsyzpSpv6YHbDAvJnC4Im7YsgJeQ0
	f3P6uOO3XUkSxK2+b/gEO+1WzTIZjub3/OQMzTH/DnPLWA9ALHAfD67mUqTWY4vF
	zn24cZwalPYb6hPGbqRQKG0jn7409pEYaLqhs2xHyaOfO6xRHTHFrmIJPnOZHF9s
	Ou/BceGMIpZIqBLyP/Ijb9O8OV9j7PnQLhDp4RzrKyPETmmnc5p1p+cdtAFZ/t84
	UUulGRzSmWaqDpIGEM+FQ==
X-ME-Sender: <xms:LaIpagfW_nWauoh9LiGEOd8AqqtHywk8-brqzq28igKBsuFHDhwLHg>
    <xme:LaIpapFRbK3tkN7O4rbtYfEP6EtmuTxIEibNciQCcbxZhBN1fE4-1Issac7dFBfsV
    tto-3oK68rn_smx5bbuxHBEi0W4MJjYEWX59FuDqMzHuyfocrlK7eE>
X-ME-Received: <xmr:LaIpap2TJbsnqPqLRIZ2DINLQnvjijhs4PUg4pRoTGp8BRIXbgr2jrO_3xtjCDEQrGNDM12vC5_oS5GZgXqqJcixykUC3yv-f_Uu>
X-ME-Proxy-Cause: dmFkZTGhc32WCZzOJh+vbNst0Xg/ETvs/pLHfFZWPRkVmdIaiSoJNjqF/sqZ0Bi7ubJ70V
    pBpf1bdgVuOY3/RYrdno1pFXkB/FjIkpunpOMa3U4IJRfnhhnawuaPr8ORMogUeIcDwFr8
    vPBkHMhu0yiy+w3wWVZY3zFQC6e/kYhNm/9C6b5AomqTuzbq5K3F66JJ9/Y9zfBUD/Jzeo
    +m4Kk9tZYUA6fJL7GOsf35RDGdIWOCKlsWQJ4r1r+VijwQmU1qZ4X8uJdF2rW14ohtQdv7
    YJ0bT/uMwR8sdWrYMuvkFo7+9HagtwuPw0vYerFPwbKIkKS9VXkQ70WPhb0/EkCFfUJ3Ut
    AQYMpR8KFhVBK0Fx81TF4FxQdAKd1pgIg/6SJP0FDZw13qr4DqWtukRrtKIAShx55015Em
    Gg/3SnfdrsshoBjAl7f2VSnimMn75ESy/ZEhco+6n7hRPz/wSS7DVaMcia72zfXQoEx+Kk
    f9I3231K9/jT7/0Ny06ZFq9aCWV9vtfHYDYIqhV/9J+DpmOgPPvlhTi41XQ6MIEN44OO6k
    AGjrs6gPHh3J+jY7fanctMDCCPx9cIyZ2MXR+gAJuhwBC0RF/RmDnd+XipBPSmQm4woMqV
    dV/YTM1XJXyTVk38S0eEBe5yxY0Bdj8/PmTuu7FPQQzyjwi2JuT7cKN+tLHg
X-ME-Proxy: <xmx:LaIpahkS_DHIgmBrIdrCEGt38h1W4ORRgUtGksCF2nGFvukV0VpT2g>
    <xmx:LaIpap_nt1JM6HNQSqFLe0MqVRA9u9f5PFjSFGp57TMthVfJhzFxTA>
    <xmx:LaIpamrS9t6WgA-sI-i-57FMPDXO3oz-JucoTnqPGcNxpmeAUoUa9A>
    <xmx:LaIpaikbFOzWYkPLE6FZ_86CrRTewlHz7BJnGWsaStXZ-WsGRAJMmg>
    <xmx:LaIpaoE34MWxskGhpaoR6ckTmKiPMHoyxC6kD6eZqEMwQL-8uNc4mwAq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 13:43:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Tamir Duberstein <tamird@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] describe: limit default ref iteration to tags
In-Reply-To: <aika_Q0rWhcI6eXR@pks.im> (Patrick Steinhardt's message of "Wed,
	10 Jun 2026 10:08:51 +0200")
References: <20260608-describe-tag-ref-scope-v2-1-256fd36dca32@gmail.com>
	<20260609110957.GB1509396@coredump.intra.peff.net>
	<aika_Q0rWhcI6eXR@pks.im>
Date: Wed, 10 Jun 2026 10:43:07 -0700
Message-ID: <xmqq4ijawatw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> I very much think that we should and even have to expect that
> contributors adapt, because if we don't we will basically reinforce
> whatever AI is doing right now and increase the load on reviewers even
> more.
>
> I also think that we should reserve the right to reject a patch series
> completely in case we notice that we're basically just talking to a
> middleman that sits between an AI prompt and us (please note that I
> don't refer to this patch series specifically, this is more of a general
> statement).

Sounds sensible.  Something like this may make a good starting
point.

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 176567738d..2fd7f6f9e6 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -499,6 +499,12 @@ checking for obvious mistakes, things that can be improved, things
 that don’t match our style, guidelines or our feedback, before sending
 it to us.
 
+We reserve the right to reject a patch series completely when we
+notice that we are basically just talking to a middleman that sits
+between an AI prompt and us, without having a better understanding of
+the subject matter than the AI agent being used.
+
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
