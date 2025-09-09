Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454D6342C93
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451310; cv=none; b=h8dtoatoglFcgqFe/5JNJ2yBvnh+r5Qod696YfE4uVydaYI3dAJCCQNqW9adS+Hx1rmdPsArYxTQw1hAoJYYNPNxRpU3FcYX9JkMIapdF984IoDt69pbnWocY+GFkAAWI+gy8gx5IY+7ZroAXPbp9nE3xmPhzV3m9KV1AHvE48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451310; c=relaxed/simple;
	bh=K6fY34vaLM0jsM4FHUsRGvZhrMNXNY7yJdkwZixkqeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSEjzEMetC/Ye7J2XIFVS+wiZyuZ3X77cYMGHhpHtAP+FSrsi0VrbzP3RMM5dHh4UiIdgrE3vy7kqOVUcu5lpW8/hE771YuWzVQF9zJ+HQcnr35by5O3dq2cyJB6CAPpeE6PHEZI1R5f0iyiXZzO9j0Lma7p+i0MUQEwblo75pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=3s9oc0QH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnJkRdmB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="3s9oc0QH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnJkRdmB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4850C1D000AB;
	Tue,  9 Sep 2025 16:55:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 09 Sep 2025 16:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757451307; x=1757537707; bh=qOEkKykqxe
	zhjPAmZMdGXtvgs7gJ4ailUnN2LRljslw=; b=3s9oc0QH6hyKYUOchpoLx3CJG8
	CaLMjfU38NgluEDYkQOa2PKoNK1pri1nsjUJBnm3IHSAaku+jlaIW6T+jZpVwy/N
	bcNuT8IeQ5BV/VK7hSjmslfsqD46XpxPs1voO3HtoV2hkVPjHGLH1paEgY584xWZ
	3YFrNXgWNtVdTX6XNvzZ7C2ogaAPogZg5sHUtp5j4O2MV0ntqk19La87/PSeeq9z
	ppWFX0qA5t6ZMC9WvX7HGEFkcQh//GpHcC9duCEQhHby+UKCdlHMDblY5jAZQoHE
	hsqevzUK+wMtuelXcLbMa7bnxgspjMcjgyX7utCgegbtF4Zb/z99PR3zj6uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757451307; x=1757537707; bh=qOEkKykqxezhjPAmZMdGXtvgs7gJ4ailUnN
	2LRljslw=; b=YnJkRdmBH6uCsjWnW5octX+a13qz7JC8zlTF/4SIpPwg+EaEjx4
	WEMNJO7y7G/DwaFsv1YYZQdlnYPDXW0xlW6aQT3CFGTcvtr+9MbGPn0cu2WTR70O
	4CmRatbZFmR6BxpFBaqYTXZLaY6+J3YaZhlBb7nAsjW2bJhfjsgC5Jb94l54ruId
	ftZQkwkTlZ/BFY+d4rw0qynyhy5t5K9p/gYesUl6gNfr9RVAu/EsCPnyYwareCGh
	08lQxna0M+wDBUeS86jazEmwkgvb6XODa3v3wLtDGsxh2QPyOtKQdzpTchw0hylc
	XtKheLvJOtmHjdldVbRFx6NVZd1FYHnHAgA==
X-ME-Sender: <xms:KpTAaNuOwcO67O_Ow7MD2SYeJ80lknx067hC-qsdoySWm4TYwiQSbg>
    <xme:KpTAaBCjkEnMZDE9MB8k3fEm2BS_rMeGEkpetpIgWYqZO2sRhtKPnWl_P3spwjefq
    OBQ56YV7M6Gf4Gtqg>
X-ME-Received: <xmr:KpTAaNXb9VBoYNb_fRjTPDsbvxhMtyJA1JjxtjSPl0eyrsJwblc6OnPOalN77BL3co2jbXWC3z5xD_c4WmbRckhFvM3JOI5vIfzPy44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtofdttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffge
    fgfeeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnohgsohiiohesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KpTAaHAtzWfZTIYm9pQRjdz4w_XhFOGqG7iF9Cp-D_AFw2FKpzvsww>
    <xmx:KpTAaI9GBdusHY7Vz4pp5NuTjL-VgJ7wZ9bWue09xCwHzT7v77fLpQ>
    <xmx:KpTAaGGYYpSHCNZXGyrk-LQo5PD7GznKJF2-u6NGdKqE6wWVmr06ag>
    <xmx:KpTAaOPtenXakfNNrESJXaAl_5WlMTmrzYs-EDF3_EUjvSKBJO0ZHg>
    <xmx:K5TAaFeHOBqxN6Ux9DtfTelC_qahuSrNX0InhcYoifWLKnRCUjg_2H5Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 16:55:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jon Forrest <nobozo@gmail.com>,  git@vger.kernel.org
Subject: Re: Is Git Add Supposed to Work Like This (git 2.50)?
In-Reply-To: <20250909184231.GB1912898@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Sep 2025 14:42:31 -0400")
References: <63045080-74d6-4835-9d9c-4d3558acdbfb@gmail.com>
	<20250907233456.GA1281511@coredump.intra.peff.net>
	<b8df3605-7afe-4121-ae50-095dfd671df9@gmail.com>
	<109prte$j8b$1@ciao.gmane.io>
	<20250909184231.GB1912898@coredump.intra.peff.net>
Date: Tue, 09 Sep 2025 13:55:05 -0700
Message-ID: <xmqqsegvtkgm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Oops, I think our mails just crossed. I don't think --ignore-errors does
> quite what you want, though:
>
>   $ touch foo
>   $ git add foo bar
>   fatal: pathspec 'bar' did not match any files
>   $ git add --ignore-errors foo bar
>   fatal: pathspec 'bar' did not match any files
>   $ git status --porcelain
>   ?? foo

The option is described like so:

    --[no-]ignore-errors  just skip files which cannot be added because of errors

I think "because of errors" is meant handle a sequence more like this:

    $ date >foo ; date >bar
    $ chmod a= foo
    $ git add --ignore-errors foo bar
    $ git diff --cached --name-only
    bar


