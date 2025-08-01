Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1426CE37
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059462; cv=none; b=RnDGvqbJgIHO+nNUtMju/sjUU366Nz8ob+XzWXIic4p0Y+0IxBf8TTozUXZS45GJZ5WGe0B4GBVPe15BTm3cLjl2cF4iihXkMTKRGHA43MFCc08zI0/IGKcHT/Nd7ZQitOjzeD3KIfb+5A9HD/bnh7FsfeumhwnxFjxLcbS/ozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059462; c=relaxed/simple;
	bh=uVe6TSiI8rbma+vBErdqv4E+WHQ5ulr4nsyoO4oHV98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipyFvSVr4YYcVvOOFS8022p6k/G0LIqccCoaxgafAUceI3Pr9NC+meD3wb1oF/b5FBra41DiX+xWDjDHP9Fht2jJLSTYQqfwCzhbcT89Y9Vt+3KsZ0vNw65bKbMNGOmQs3IdjZmfyHaQ+//UWyywCI0PUb/ktlEASfYS4BifG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=atLe/MjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hgd1AmGT; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="atLe/MjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hgd1AmGT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E28C7A01AB;
	Fri,  1 Aug 2025 10:44:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 01 Aug 2025 10:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754059459;
	 x=1754145859; bh=iTtoUE+/cV/KF8S7jCVYB890PHW5jmx1zbQqQgdln1U=; b=
	atLe/MjDe2DSdr5y204jf+KUfyaDMvabibvIAfwecW4/wIyoNzITNcjHRxGVJDwB
	x7zGANhVUR+P68/qakwaQz63x4vn4X+noDMUyxVvZsVb2MKRAFPy5Py9m2HGZjer
	NtvmE6PQTK3Y0qUVT7b04EtLhskzPqY1epAml2d0R1WzHgutBp4/CH7Z75eYMIGs
	L5lLKg5iZz2cS/r19abz+7ZciIpTqkJxg4LBZ0aFo3iQ0ItTu/zFEm5okLjmR5LB
	DF9Je46DVXRmJ41/NVlJgLATpvsTd2Cam4bwfinNJSGCcyIgEcDjOywBD4TZTSoB
	EQSoG8mxDjrtV9NAtq6kMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059459; x=
	1754145859; bh=iTtoUE+/cV/KF8S7jCVYB890PHW5jmx1zbQqQgdln1U=; b=H
	gd1AmGT2904d1HUnLiuUI5aB8zBICmdjeVwGutzvhOKC6Lc6o237tvwP7UHB105S
	Q8aZlN94NdmmTWFcdteb5c5LyvCS5bNlbk0jyQoqVyPtV1jiN9R+l7F80szBB05d
	KJJHpT1Qbn3aQwELA2rBEyYt8AWX+knn9YqwS+rFnAKvIZq+5ycRrNCFlmtT6e+E
	ueywuSJuKeyGx4c1foouWoXBPceSGGeKrFYhdKa5pzskcu9VS41B37oxS9xgBCEr
	Hb52qGGE02ac9URD471Wrg4mQNVZIIExE2Z9BS36ysTNy3V93eEHw097nhQL3hCC
	XCzKrDvRxXVXq9IawIX6A==
X-ME-Sender: <xms:w9KMaM-iUicxL--B6mves6p11gGTvOwV-_jj7FzURMHPCnFQIk5ndw>
    <xme:w9KMaPRZMwPQuNnWYZWqnBsDJyZFAVhgQAu2J5dDxHawZSfgRaEuj50AGb1PFMwQE
    LQqUMl67XTDcweKHA>
X-ME-Received: <xmr:w9KMaOmSvt1J_qc_sS1HtvgvJjL1tbjSBtKbIrmXjz8Qpd7vP3uNLjVzZDu7c7VQqkdsMMRmxXfJauAl_lKTEGh1KUBd0mGt71BYSgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:w9KMaPQYL8yCGU1Pcj8RNcehmkFQyHhKuXKXBhm-WfCf08iAAmqMOw>
    <xmx:w9KMaMMl_yc0MJetSkuSZEZcQHvA-hQ5zqK3MI2a-XCTQ6ZMzGEAsQ>
    <xmx:w9KMaIVZP7UhjKVXReZ4BN7GT6dS-91U7OPwYlj5Fx0gg95yNfNF_Q>
    <xmx:w9KMaDeCLw5996MimOUGLyq_q6rKjjpCUBpO-4bcwFfbomou9onmZA>
    <xmx:w9KMaDVKkiKYoneX1jPBWZznnqyez9mXt7mVvGarIcJg42sUuKhXG0o7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 10:44:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: fast-import: contextualize the hardware cost
In-Reply-To: <a9bc7547a27aab8bc2404caeb821b7f5c4c10d14.1754055658.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 1 Aug 2025
	15:42:25 +0200")
References: <a9bc7547a27aab8bc2404caeb821b7f5c4c10d14.1754055658.git.code@khaugsbakk.name>
Date: Fri, 01 Aug 2025 07:44:18 -0700
Message-ID: <xmqqo6szm799.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 6e411d20440 (Initial draft of fast-import documentation., 2007-02-05)
> pointed out how much time a fast-import took on some hardware with a
> specific cost.  Let’s further point out that this experiment was done
> in 2007.  So modern hardware should have no issues with such a repo.
>
> Also move the parenthetical to the end now that it contains four words.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/git-fast-import.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index d2327842003..6f9763c11b3 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -182,7 +182,7 @@ amount of memory usage and processing time.  Assuming the frontend
>  is able to keep up with fast-import and feed it a constant stream of data,
>  import times for projects holding 10+ years of history and containing
>  100,000+ individual commits are generally completed in just 1-2
> -hours on quite modest (~$2,000 USD) hardware.
> +hours on quite modest hardware (~$2,000 USD in 2007).

That is a definite improvement.  Thanks.
