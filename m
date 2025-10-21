Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DC1E89C
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085195; cv=none; b=gqw7yxDao8llGFXw7b2VefSlOQDiHkQ8QA2x/XxbhcalpfpDwaIP2qv5zfthqGXawjU9Y90PPBzK/qkhzbien1thfriCoKPUGR4OH0q9cwFAXNglusRKBjTzPFwS/bSJ8h6UwXLZeEVBM2KwZf2l/MNCR/THKvv3S5yU8eN8k1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085195; c=relaxed/simple;
	bh=lNl3MpMP5HqVCXYuCbNGgNWkFJbWc2DCciHX471xznE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Be3RzVF6pYkK7axZLIMEAzqL1HLkzqO104yY+VDqqyBc9qfMA/19wLj44TCwx0K6jBeop6Fs5Ejleh4bZQT56RlfWMgZpneWHqGUaNKjd8Ndoevg4fgZqcw/9fT1QzM/Icqoj1RMFk1JakTz6c4BFsfP/eGvOnBhygWuey9bWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FGBoPpe9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVIsjLd7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FGBoPpe9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVIsjLd7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 029CA1D00176;
	Tue, 21 Oct 2025 18:19:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 21 Oct 2025 18:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761085191;
	 x=1761171591; bh=A4NoVNV2Edaj3x2+HSuknjGI9Zoj4S1DW/+pMvXw0Y8=; b=
	FGBoPpe9lDepYa+SJUO80p8oU+lI65JxygvXC+Fc/4ZHHFjBOY4raTdkYUfz0FD4
	/44R16rsT/4/xZjLWrGSj3YQWnoam/ME5HWVIBODArcqi1CuQmFmn/tNk4xDk4xF
	oCwIPzJ0Vc1tYqt3u3HAv5Ua4MNZD6Dl1AjuY9c1mVPr3I3vsVuhWq6AqJ+jmbgu
	yPOEWK6wht+HBvSqyQVfFCmqlzmS6oNNBWrW6d5DpmllMB7JdtYpgI98aITuHJBB
	he45lTfzkgZ0cpBvo/7Yi3syH9y5QngFGLmBApm/EXzf5O+iFUil3uIwRX2lOE62
	Rc6L36mDgXsD3wgND+jjOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761085191; x=
	1761171591; bh=A4NoVNV2Edaj3x2+HSuknjGI9Zoj4S1DW/+pMvXw0Y8=; b=C
	VIsjLd7wuIRD9tt1Cr/3rft4ZQU4T65dg2mp6skOLXOF9FZ2YaT4CyBOdWBV0A0P
	0On9FbcNk53jM0cPb27rwS+3nkJ6nv/+aViWtfapszLGshxABvCtgu+VgALFFeEl
	3o7k0nIGUob7P4zo7C78eU4dvcjLUWSuBbavPNnCkoqHflXMIpFjaF6P6IDD63Je
	Xii7nlJ+uoWcjSDDhThLIVM6WcgbbiVeNDOK8dGb8O0UWPuO6NOL9NBo2bKpgclV
	avBMqmhFkmPU5jTdUaNBx0OUCyUwGCO7qpzFnAw1fcMF7Ak19FDs0A+Y62wfZVpx
	8k2gUgw2e5s2JjZgIzN5Q==
X-ME-Sender: <xms:Bwf4aIdlV35uxTWlNUuEi87RuEe65GkDjPQj82dVgNn4J8om3cECAA>
    <xme:Bwf4aBp8s6xoRnvlwXFNLNQqOqaL2frR-c4AKUFduaXm3ZAMFFV7PVEX-wk0MC9Y7
    OeSujSWvJUU213lemivwwUoe1AdkcyKhsAGzWr_-dMCOlcnbVXRgA>
X-ME-Received: <xmr:Bwf4aG47YfLPdetDOE2L2xZ6QU3SAq18rsafYQoaGOux8YBzNQsEyK9si4k4DQdeb8LPGDVfEzgPBz9R-utx6A2HUCCWRv0CJD6J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedukeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdtjefhgfekhffhteeiffetheelhedt
    gfehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Bwf4aHql_aTs0ZplXTJbGpqztgaFTUXGFZS8gMiAuknqhsBQyoVOSQ>
    <xmx:Bwf4aIiMhOXGqgxgKN4SXPye4jCb4lAiy0nNTQR-8s6KhwBa6Hpr2w>
    <xmx:Bwf4aBKHo1e4kxifs2mfcAgWTMZq-9k_LSYSQX1tFDApmt6snkVaSQ>
    <xmx:Bwf4aIC4Zcr5c4z4mz9GqyWSfww1zD_gr9hKXqDvNz_5I52JmltDGQ>
    <xmx:Bwf4aBz_cBgXUTffDH3gi_S0WTMpVnE7KEr35xZTNWRSGyaoGw30RrV0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 18:19:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [rfc] flip rerere.enabled default to be "on" at Git 3.0 boundary?
In-Reply-To: <ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 21 Oct 2025 20:55:47 +0200")
References: <xmqqldl4und1.fsf@gitster.g>
	<ecf21e8d-acff-47fb-b972-59cd7b8f3146@app.fastmail.com>
Date: Tue, 21 Oct 2025 15:19:49 -0700
Message-ID: <xmqqsefbsxru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> The biggest usability problem for me is when I have a cache, I want to
> keep it, but I want to remove a few pathspecs.  I’ve made some notes on
> this to myself.  Apparently I tried to `git rerere forget` on some paths
> but I got not output.  Then I did it again and it reused it. According
> to my notes I had to get into that conflict resolution state and then
> *forget*:
>
> (this is straight from my notes, I didn’t try this right now)
>
> 1. I did the wrong thing for `file`
> 2. I reset the merge back
> 3. I did the merge
> 4. *While resolving conflicts*: `git rerere forget <file>`
> 5. `git merge --abort`
> 6. Do merge again
> 7. Now I can redo the merge conflict for `<file>` while keeping the rest
>    of the resolutions
>
> I don’t know if all of that was necessary but that’s what I did to make
> it work for me.

That is how I would do it.  Of course if I know I can get to the
right resolution without steps 5 and 6, then I'd just record the
resolution after doing "rerere forget" at step 4.
