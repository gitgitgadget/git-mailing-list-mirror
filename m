Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3043AC1C
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319424; cv=none; b=JkxyM6kV+Khj8bP/gT0375bjCMiJw1/Lvmp5/YLRj/mRPrdtdODMqh95kKD97UupLPdMNTyJ30HX48AHSLnpCWP1oDRfRbe/S8XxkbfV+iEMS8bDr8Jh6dRWa0va1+hE6Rh7JzRwVqx28Qv/i+E+C33C0fSPzXqSmi8N9dG8ZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319424; c=relaxed/simple;
	bh=RsBKj+rE86sOxCq8B6iNh8BVTj5JZRn5nXQFVNQgpfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C7voDrjFJAN5+w8MBm8sffsZdtSM3zFc+bJ2fJ6ETpWQId+t6Mo7d2/9pN87cFenIuqK7omYIG0NJUJfCiugO3I/FCJL3df1/RwSVdkgFdzkqwFEGSfLHJjfC2ZKduDzF0XtBvkgl5I7arXta8tGJlyF4vrOrciawKVp6Ca7EAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ra6As1V7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbapYnhe; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ra6As1V7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbapYnhe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C7191D00166;
	Fri, 24 Oct 2025 11:23:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 11:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1761319421;
	 x=1761405821; bh=SqvtratiDJL3WyT3DHEI2ScVG1FXM2ud4AkMDeB4sQ0=; b=
	Ra6As1V7RPMk7hr/FerVr9Yz8hl0t4Q2/v0+rZPX2E9a8EMXNzfKawCZK3DgmHED
	Degp2Wdt2BvlXFN0UN4wwCJrLglO8lEO3gT7NkDIIJTj1t2gZPiKEegSvNojiYp9
	NJsnBvGUu0alftyvv54ct5Ntl/ktFbd/vB/tL9ftTIAi1cHadGczQBN6abBIbDWt
	5zO0Tsj2H47kH77BNgLAY+lisoiA0gzq0Oe+SiWiZDbwUHqXlKRPTGMfZXz5V/EF
	KOL2E/5/pHgbEq96xDU9AIAW5cKg3N7Mpq1UNkk4Rwe0LzwdMveEgisLgcMf5Apz
	8aFGPa1oGtkpYa6WzqicnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761319421; x=
	1761405821; bh=SqvtratiDJL3WyT3DHEI2ScVG1FXM2ud4AkMDeB4sQ0=; b=g
	bapYnheC9noPqeru5PsweXful72JOJMKxv+DgMx28mQ+i4q/jN80SsyKQFchjCT3
	kmsPYscWwzEi5KtrGC2uB9lO02Z73B+N0xGX0/pGUlc61d+ZIysvrJlRlre5mWlM
	BQxmp0mrdJqXnWqCXHK7rB/cuKqDuIyz9ehLxA/5kzVHjNUI+HjC2KYlhic2VDXQ
	viwhdwUMGpsk4guJjjtgQstBvFatikQenqIwsBvQINwr+KEOdwi3K5DQeS8q6SwJ
	sDma/BVAieaBz17Zy+BSuMsBfeMKHXbR8UxcIJI8Jff2S9RbTj01FAWirJL6R3vr
	j9icBW24fuFzcfeyE4frA==
X-ME-Sender: <xms:_Jn7aHME7ePhO3bSANOINP6qCBdBfG79p39h9M81vxo5mTRkAFovQA>
    <xme:_Jn7aNzWtH6GLXGWDUVtZvRC9pENvj78vIF-NaJjiQmtSR6fs8aMwsy-i0vZUQDry
    stWbilJdi2DZMij-2C7sK0H7IOPLq7pnquxY1fBqXW8JN3s0jS5jA>
X-ME-Received: <xmr:_Jn7aMtHQGLlipEWTg7VfZlb5oUYe3YWfsr2Qy9LFlxvucD-pEVb0e0ObeSxYjhaAst4xZIUuYhPS55OYN9nxseMD3YnZbyWM_iT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:_Jn7aIb4LWOrDMPbh0JYmK9OKFotek7f-Ut2r_3qdWeeeOrRbsfxgw>
    <xmx:_Jn7aD2oDQuPeh_6w_0F0tmdVWbsCg4nI9Zn0qE1fsini21QX-dnWg>
    <xmx:_Jn7aCvgFlkOedrzp777mkVZmth58tsWuVW5SAmrttc6l0BT3vyMmA>
    <xmx:_Jn7aPDjWcQn9rXD2X0aIN-KDVcaANPAeJhkw588bvRBlSioOBMRCA>
    <xmx:_Zn7aPDvRz7yPBqyP375DbiSeHU0W8kHaoDFTgS1Ss3EiFrkePcahWz2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 11:23:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 2/3] replay: make atomic ref updates the default
 behavior
In-Reply-To: <CAP8UFD00rE7gF+baidmoi7nYwVKa3UDQgj+TB4wJLtjJF7u9gA@mail.gmail.com>
	(Christian Couder's message of "Fri, 24 Oct 2025 12:37:02 +0200")
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-3-siddharthasthana31@gmail.com>
	<CAP8UFD00rE7gF+baidmoi7nYwVKa3UDQgj+TB4wJLtjJF7u9gA@mail.gmail.com>
Date: Fri, 24 Oct 2025 08:23:38 -0700
Message-ID: <xmqqbjlwqq6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Oct 22, 2025 at 8:51 PM Siddharth Asthana
> <siddharthasthana31@gmail.com> wrote:
>
>> -       const char * const replay_usage[] = {
>> +       const char *const replay_usage[] = {
>
> Nit: Not sure this change is worth it, but I understand that it might
> help pass some automated/CI tests, so not a big issue.

I think this formatting issue came up recently on another discussion
thread.  We found that the prevalent style in the codebase is that
an asterisk in between tokens neither of which is variable has space
on both sides (i.e. the preimage of the above change), so unless
there is a specific reason to make the above change, I'd rather not
to see such "reformatting" thrown into a patch that implements a
feature or fixes a bug (iow, not a "clean-up styles" patch).

By the way, I would be suprised if that the reason were a CI test.
How would the preimage have been passing the same test if that is
the case?
