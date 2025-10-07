Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93492C9D
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878099; cv=none; b=ZNdaLRuNvfDoL97AuoZIQDX0JcSnUN6ZrPURDW81/KKdTbqGnsxtabdRDvs4GT4p5/zd6Dt7D1Gw1vSVpF+MYyu9wPqnPr9q1+lYxZCRTlBFRysO6d9jEfAyBhNVCWtxoYNdpIXxOfmHHk/hMKMYsa8DZConbpsJA6yPjh/lZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878099; c=relaxed/simple;
	bh=QjRtDoP/CmRb5KJc69Fj6UIWsT3T72spWXTxi1iYuFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTDdyHiQ891xzPsu2E3y/VHKNiGO6nCOTIJyZq62A5apSAnzZL3/C33G81OitGWTZrES2/rWwqes8UgR0IamgDe/VVo/+0fkUoisxYbAAqwHTIFujz9k3WV+E5fe7Sq49GA9Oxp/0sVvAMFCK9w16hZf0k3TX7Pt4Sm56YKaxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GaSuoSBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dFWdiGPw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GaSuoSBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dFWdiGPw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EC3641D00108;
	Tue,  7 Oct 2025 19:01:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 07 Oct 2025 19:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759878096; x=1759964496; bh=wBNzkjialQ
	0eILLAbaHgLlN+VvTDMFWTQctUccZxcJg=; b=GaSuoSBYeyLjyjBAoHzLcXkskR
	GLAnfDBPt0aRK5Z0P0MaCfeO0QUuxaUMMNxVv1avEeS5v/PUlmDZOtM1LfGJuF3V
	tfV2zrgpD/ehYxKYRLpgRaE5ujWlI3DeVxWQMWZciTHNqSDNAah2ieo/Mmlb/Zs6
	0WzlE0I/926FqRhUMLdmdgz2pinCQVVawqsVvf9UN5XaWYNkvVMPqN5itSnhkfvy
	o6FxbxC6Ry+U4ATanL9rmLbNIv+uetSJKsea5jC5Y+WMWOcvDDRhD03bdUf5i0lb
	kiISoLrpZFqQgZwueAUZfjRHcwS/wIiW8Q0seKTu5sP9Ln0S3lOsmulBFHig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759878096; x=1759964496; bh=wBNzkjialQ0eILLAbaHgLlN+VvTDMFWTQct
	UccZxcJg=; b=dFWdiGPwN0nkeG7VhKy2ZWKMtpZ0liytinhCPYAwytPZjeA+A6P
	HkuQD8i+aufoObw26fdu0z69RoMpx4QqLJ0L4E6J3DxW3yt4uHW4t+nyapAc+VhI
	XUMwszTQ2a7n7uco5wtkVpLDbIjL5Lm/uI0a6yk2LkSE+StTfi2egzdYMpkjFILL
	LsbcpHAODqmtXB2QciqkB8bUjqkhckTxLtGqo9oaBM6vAqrgGO8QcnE1+T3iRyV2
	4jldWeUzRYrpcW08I7BkmsBxvu1tHEZN4j63QLIOa6M7xOHC436VdCUkbgeo9Hle
	CBXZzSpF/XoAuvWt4ryBTcl8G+pilYeCffw==
X-ME-Sender: <xms:0JvlaBYNFooA8xH3FXyzJLF2i9mZTOiY1eZ2SAZwOyFw9k9tda3OJg>
    <xme:0JvlaP1NP3EuVLpYA_p5F2eOfbU8YHbcTKVlxctpeglQfleaz5iGYlmEVjqKKyw_Y
    3eDs1nTR_MWUyKCN3TSLi7LpdxlNNR38mwGOcKrF84p08uDTnkkLA>
X-ME-Received: <xmr:0JvlaBWLv5cp_nNvX-gTcavvsADz00YCujKwmQrcEP3R-Yr65sWQr0uRTQc2ViHr_YqLgL7duhvALu2oip1ddXF_AkOp96GBdgeq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdduieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:0JvlaJWZqQnvn0hI6KXK9P4DC77AXf9PT9aky9dHDicJ4j2nhPNxjw>
    <xmx:0JvlaAe-77IQH8DuGWvmvior9ChzGpAaK0zrIj3lwf9kath9WRSvCQ>
    <xmx:0JvlaCW009_VLPmoZ4JlW2XABTINPtn_KdIfeP0ihqzKdcugpFLL5Q>
    <xmx:0JvlaJf76xaMgcCkf8pY6WLMAGmjMF5eak21N0B03l1J813JiygaNQ>
    <xmx:0JvlaH9-cnx2KOziScUZvX8GiCQNvzusZqpjmy3WfEo758UIZ5fRyv3r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 19:01:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/13] refs: improvements and fixes for peeling tags
In-Reply-To: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
	(Patrick Steinhardt's message of "Tue, 07 Oct 2025 12:58:37 +0200")
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
Date: Tue, 07 Oct 2025 16:01:34 -0700
Message-ID: <xmqqzfa2gvu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> originally, all I wanted to do was the last patch: a small performance
> optimization that stops parsing objects in git-for-each-ref(1) unless we
> really need to parse them. But that fix cause one specific test to fail,
> and only with the reftable backend. So this led me down the rabbit hole
> of tag peeling, ending up with this patch series.
>
> The series is structured like follows:
>
>   - Patches 1 to 7 refactor our codebase so that we don't have the
>     `peel_iterated_object()` hack anymore. I just found it hard to
>     follow and thought it shouldn't be too hard to get rid of it.

I've only read up to here, and found all of them welcome
improvements.  Will continue reading later.

>   - Patches 8 and 9 remove infrastructure that we don't need anymore
>     after the first couple of patches.
>   - Patches 10 to 12 fix a couple of issues with peeled tags that I
>     found. The underlying issue is that tags store both the tagged
>     object and their type, but this information may not match. We never
>     verify the actual object type though when allocating the tagged
>     object, so this only blows up much later.
>
>   - Patch 13 was my original motivation, a small performance
>     optimization.
