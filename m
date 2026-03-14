Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80142171CD
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773491261; cv=none; b=A1nJVFNH/2kvfWCg91+USzt3aR7hLra3UM90Afdmof9EAo1KknvcrNW/DiCXhBXM8kCevxnhVWPtgBGq7Alqjr+zjMG6zhaRgxVG3d9nXlf6y7A5p9aBltUlnZuGUuHHWJvUBCKvPwaYu1nSNUr7fQPVls0GXbnG+izKt2wEAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773491261; c=relaxed/simple;
	bh=CQv9LAldC+YxvQ8jKaTlw+Pj5xo+ee3+ORLzKTXInHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cG9hJKeWL5QR0j0M2y82fJ2g88PEfslvmGbUEiQdIpTQk2aJPspX4dawo5aEU6Rz+HpJzNOtB8wepD6YlxZoPf/AxrMmSwWAL2TYOsBH/sv+bLs/GZVoIZhycoW5a/1ohO/L47qypo0BEJi5+ANY5lFVY2Jmt/n8xbtUrOKeVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DrC9E3RH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsbFh4wB; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrC9E3RH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsbFh4wB"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 87F7F1D000F0;
	Sat, 14 Mar 2026 08:27:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 14 Mar 2026 08:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773491258;
	 x=1773577658; bh=6xNRZH1rJ31ZdoA4v3zhhi0/D7Ikyl6Xx/dTmmCD+qc=; b=
	DrC9E3RHAikPhAImt4eRboh9+0WA8aahgHz0W40OJSrJ1Q4m3v7Zr0JpHDr5IAa+
	OpRjb/129tGXhN3rCGjQVZDGHj2KMzqSvc0eP5jpTe1QUPneUZ46iRc4vXxVElYw
	FOnsTH0EKwNmoSmAbS/Tbqv2bisjiFFvOS9j4a8Q8QaXzPigSxTz7MofOk2qCzf5
	yaupijRtwvV/2qI4WrW5T2j5QQ+9bxXlythJV9TKCdd9YMZwap5WP6R/jBf/Qg9t
	du6tFbOx86GQnL4cuHgKNmQC1jhD/2WldelYpbyrQ8wZARewp4BD0zz0b4f+R7cF
	MBcy9pBPc1rlvT0xwXq2kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773491258; x=
	1773577658; bh=6xNRZH1rJ31ZdoA4v3zhhi0/D7Ikyl6Xx/dTmmCD+qc=; b=T
	sbFh4wBcuadiulUzRYUKDojKCEW0NQv+daxYBn9wssk+NYebMOAIM744Lp+Ua75H
	I0H7zzjnkQr3HSiZsQOOZxlklooOfX8jPp4ex5+XLhOlZSDqOEDawNo9jI44x/qP
	7YMqJdZXql6nkxu08dDoV7vYXIQKo2vlgrPnZ0vqKR3b4eHv5xetxoj21aZEOm+d
	EzcYZqb+iMaxhYFYNxqAnyx0OyC6hSl7+F8shnCBruvHI7f52gZiim/GS7VGh+dQ
	ja0/iMpxfMh54ojseEbIa5pzXgtlPpBKYodjbTtX9OpEWjgSgB5vDADqFgwkv9GI
	oDpdVHM5qX2SGp+xADZLA==
X-ME-Sender: <xms:OlS1aZ7IwUzYkSOPZHiRBPdVokSPkGZ5amOboOdIJWVgb_6M-69_ug>
    <xme:OlS1ad4flyEU7W1MZ3b7-jrWAX8q8EQMk4xHISUnF_fiQs6qky2TjwyzTpH8lYH0k
    maQV_rHIMKOKzTOyaX0IuJr1nFHPSRm_YlcaVp4XNOARdcl-evw0Q>
X-ME-Received: <xmr:OlS1aVcTjGZCFgLu7uL-BNPh2kp3DYRuWiFCD6C6MVfpU_afIcPUDYwGjE6KqotNZ66c7iFIP9_f0MDTEc37MlBE_bpfJwQqIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggrthes
    mhgrlhhonhdruggvvhdprhgtphhtthhopegrhhgrmhgsrhgrhhhmrghsmhhivdefheejse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OlS1aRB0WKJ6gRvfhLg8gIXCR5Q0wt90TScUoW8KFl6dkBOReZwLHg>
    <xmx:OlS1aY8A8SPuM0qCaVPpMI5btPt8QBrcMd3Q4aTv9Qa88kv-wsgySQ>
    <xmx:OlS1acIEiKgATEFKWDCW24aL5thDiJjXvgCSQaXG1jXr6KLytS9gxg>
    <xmx:OlS1aRhm8xw5gLh7U301S4HPHkTALAjLo0GZf7AWUuSjx8A9c_67Ew>
    <xmx:OlS1aZsNweq_ZHLIPXWZf76OGOQoeYjMHabS_YTfpa_o9DYOwZokLZ3d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 08:27:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: aum2357 <ahambrahmasmi2357@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH GSOC] diff: use conventional comparison order
In-Reply-To: <405c075b-731b-47e3-9e9c-70aaa0efe1cc@malon.dev> (Tian Yuchen's
	message of "Sat, 14 Mar 2026 11:59:43 +0800")
References: <20260313140440.564201-1-ahambrahmasmi2357@gmail.com>
	<9afe48e3-8348-4e2c-8e5f-bbdc3b2951f8@malon.dev>
	<xmqqldfv4h6k.fsf@gitster.g>
	<405c075b-731b-47e3-9e9c-70aaa0efe1cc@malon.dev>
Date: Sat, 14 Mar 2026 05:27:36 -0700
Message-ID: <xmqqbjgqy4sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tian Yuchen <cat@malon.dev> writes:
> However, in builtin/add.c before the patch, there isn't even a single 
> “>” symbol used for comparison. The “<” symbol is used throughout the 
> comparison sections.

Look a bit harder.  I think there is one comparison that uses a
comparison that does not follow "textual order reflects actual
order" convention.

	while (--i >= 0) {

> I find it quite strange because the author says:
>
>> to follow the common coding style
>
> This patch seems more like it breaks the common coding style.

To somebody who does not know both conventions and understand that
both are valid, the only one that is familiar to the person would be
the only common one.
