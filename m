Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E13909B1
	for <git@vger.kernel.org>; Fri, 29 May 2026 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095162; cv=none; b=qypQbe4tcUXelMTJZR9rW7jsrvnCnAgBAVhCSaUncgLWjj4QrF2CgbYzKs+aMRB7Z8AwaLK3+DzT/VxJkRw3wYL3EL9Bh8vKPsmVo0gycSJADXX4ufapRLhNSoXZ7HYcyGqWyCgiq12KyI63cU+XdolKRdy+W/B5EZzdeQNtgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095162; c=relaxed/simple;
	bh=RktWqVoF1mPhOwBcm4/J/3rg3Am2FoJswYTOpCLdvAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyHKUVcVJ1lDpRpj0lrp1ALgtzekfvsqe7Kb4+IGZ7t6vt6NiPfex95LN7svKg6uRcNUyp/ycM4QxdLR99dOdn678K2adUK6RsXgn3E3HCyMXdS+PHOL16I2+Z0thQnOvAPhO+Y7NoL/8kxZZ75SWIRe6hyVzSd9c46pcHVvfyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=agFDaa27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHbDxFJX; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="agFDaa27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHbDxFJX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D7B71400029;
	Fri, 29 May 2026 18:52:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 18:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780095159; x=1780181559; bh=8ys7+PsxP5
	kUAHOWHzbM+3SGuoINR+jXcE/a0kdRJRM=; b=agFDaa274h20fgKs3eLeq1mgnq
	TA/fxe6kZWu1mTrrPC2K9tXGhoOthX+xNlULSqwFeo1xQnfK/PafL0zQkAY82vBT
	lEhpg4DNp18eCUzkl3Xp3dLFgjBIsVOo8iRZDZtkJTbE5qz55f1D/odipHShWj2C
	N84tHhCWdcF86qXevxIy9TMy4nxtTmK8xRGmoUcTVxRs9eN1kbF0PmigB2i+As5A
	JvNY+e+oRdkR3Nt8kJfvV479JRzp6pw0PIgSVlbUf9VANMb692jdsKCSU+MR42mW
	DzgZlS5ewKg0e6dy2XgBrp1gPRVS6BSZhaZhzl5lDIbOZBbI6DPPJwq+YW2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780095159; x=1780181559; bh=8ys7+PsxP5kUAHOWHzbM+3SGuoINR+jXcE/
	a0kdRJRM=; b=AHbDxFJXtR+k6PnaIXoGYUJ5YvsgdqNl6N7tPyW+gDwBvBoKm8G
	NvJuHUcvp85ssoseo9J6fSYFx+7w+wK0Arc4Qg+o3IlhVwcg0JyDRd30SAi3BNs7
	bzDbOHPJGd1oZ1W1Pvgw6Qv4EtEtNACMwxmnBUU6sWieJEqH2mAdmKwvH4RvQPcf
	Vkgsg4d33S2jTOE8KDxL/tBooOpuexonUg/+pa0nXIeFpriqFBOQOqs8moPq2SpL
	LGCz8U13S55zFQWzEDozxTbzvhR/Hxhg+2dqN/k0oEfsydPZE2j/MkYuSHZzsBCv
	g6SFTKYJSYYr0FAYFM+yxoIPqHfE8Lw8TqQ==
X-ME-Sender: <xms:thgaaq9INwuZko5zrsZbxdFainVNWR5PGRBuNclUPB5Fe6ystuLw1Q>
    <xme:thgaahvtWZjOYIDcgs6VZK3JEp2c8x6rc7w1ATQ-Ujk3SC0wAforzSAoDPoH0cGi_
    Tj297hwO3kp6ojlMzVHfTAVkr_Xhds4H4qS5uZ8dHHYrwakgnMKyU0>
X-ME-Received: <xmr:thgaalBEHhafxVw1iRepW80qF0Mo5bIMOcixplcGcs2ZGOSNOWPsdqBCaRsQdYJTJocRzTkUi7X2dXAuKWPY7h0wmdIrj7eMYEaZ>
X-ME-Proxy-Cause: dmFkZTEITWP9L2+ezdrNaWk7N8yj7fB4h+NGe+T26obk6SVUbsdTOwehFnpMrXsnmD8Ohw
    Mf9woWZWMDu/sUenjU0xHhXL0gxjZpq1RnaDTWc2jnHZZHTXXU7POLAThZUWsDGHan8yQx
    /mhSyBcaYhoUaeTk6YxMLuDsJ84F5ptrnRnLgw3jAaLijIrSoKJoL01Pq4X5mrbOipjcEB
    mg5s8VTDsIcLu5tNQV+TNdzTOgvJ7M0sr2yBdxpaA9Ew2nqRQtd1SNSemV8VXpQ9EEp9Pj
    auYWJ28BbmEVMmprlBgAkPqx58e2YT4u1tbSOhSkYA48j+lMXFgROqhH6VVN3057/5A2Ka
    iUmqvf0T4fQpzigJPAAmjqNjdGWWFIyEXavTjQr24kIGfE9lS1Jm25x3gujlzYY0EG+AaF
    +J9uTu0YtYbXL/U0nxr/hV0cN6s5KTg6k7FalXRiWPZbwUHHbLbXoX/pYlIQDIm84N7gIg
    Ayj0H6alqms8vfLRnH73js3OKJFiP+5D9Ox4qO3XNOBkeMDYwzTSLHZFyCq7oinzxTp2g8
    jiEa9NFvbWPCvbtF30bLjfox5DlAJSdiaU7Va6qyXAuMqoC7sAWxjCAdEQtDa3UVXnJBRt
    mvtNA5Ew2mcr9JCM2E7N92CrNeytnEPhq12fYesBS4YAYdgevUcox5yA88PA
X-ME-Proxy: <xmx:thgaahUEI8-jvmSawkuJ2PWXDwmH48TAyp6qg3vx8tXIBnmFdYlS5Q>
    <xmx:thgaarDQME4lY1JDAq00qa_Ro6AiDsJYQfV42ymaZfDHmWoN-ioA-A>
    <xmx:thgaas9IHXdazZSMIahEO9p7CnjaO9dd59nSV9wO8BT0Pe-nCUTOXw>
    <xmx:thgaaqENoS8w5SGtvbaAIYS-6vuqH-7UCvAKvgu53oNVhag993hQOQ>
    <xmx:txgaatETJSweJf9DK7HeQmQkHd3CjzkSn-5PY6SbtWz0eq0YElye_zBn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 18:52:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luna Schwalbe <dev@luna.gl>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
  git@vger.kernel.org
Subject: Re: [BUG] internal date format does not accept small unix timestamps
In-Reply-To: <08a04d91-af90-44dd-b28f-f3d5b9e77413@luna.gl> (Luna Schwalbe's
	message of "Fri, 29 May 2026 16:52:38 +0200")
References: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
	<a8e51dda-7b1d-426e-9af9-cf856c42342d@app.fastmail.com>
	<08a04d91-af90-44dd-b28f-f3d5b9e77413@luna.gl>
Date: Sat, 30 May 2026 07:52:37 +0900
Message-ID: <xmqq7bolg762.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luna Schwalbe <dev@luna.gl> writes:

>  > Apparently you need `@` in front for small Unix Epoch values. `@0 +0000`
>
> That is wonderful, thank you so much, I somehow did not find this small 
> detail anywhere.
>
> Maybe it could be added to Documentation/date-formats.adoc?
>
> Luna

Good suggestion.

This was introduced in 116eb3ab (parse_date(): allow ancient
git-timestamp, 2012-02-02) and 2c733fb2 (parse_date(): '@' prefix
forces git-timestamp, 2012-02-02) to allow specifying "ancient"
timestamps (like 0 +0000) without conflicting with YYYYMMDD date
formats.  I do not think neither commit added documentation for this
'@' prefix, and Documentation/date-formats would be an excellent
place to do so.

Care to whip up a patch?

Thanks.
