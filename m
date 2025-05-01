Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234420C006
	for <git@vger.kernel.org>; Thu,  1 May 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746122009; cv=none; b=H31R0SjIcpuDKZxjS0AyAnPsRZ02v27HlwbtamP7Hn4AYSL6B1pwf2Zv+oJyhiqDRcuzMzmYRjq+Czfnc+kUeU2CK73JlSuqvDfhyFJVh+tWURFGUaeBLbNMctnRMboDl8/jgXaLXlBj6bTF1c1RVRSvvGa/rNra35eLaZXn/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746122009; c=relaxed/simple;
	bh=nFVWPXeR2fqT1FNnK8FzA1VV8HrfSdVCV9rX6ljbBa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bsts9q9jQANiyYgkn/41Z1aySqaa3vpbclgkPo2pcnVR36+Jg9a3u/g8DdnUh76he3X8wo7D0vbm9HJ/1Oei1aihRqkfaLA1nChkJO1AsdjXFdBCQ4sUHQ9V8pjMYHB7X4/j0+U5KNk3h8muQyugIQHP6G+FxiGQVOexpkYCyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ttu4CeES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uqHAKpDE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ttu4CeES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uqHAKpDE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AAF713808B8;
	Thu,  1 May 2025 13:53:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 01 May 2025 13:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746122005; x=1746208405; bh=+2VXGPiu8j
	jvtzKGcpOHPQBq+dxQRb6wS7Wnv70WcPY=; b=Ttu4CeESMmUDcUgXyaWMtBQ5qS
	gTNhK+62PEoa5aoJTBntVAVGBcP6xyUzLixnzPxGAQZa2kNYILETScGuuPA5h33W
	1CkQfT4AXk/tyDdDeKvVGsoixnm7ss8KCkk2B0Pgg0MheHb9EHyhyZjqCx1ipQvB
	zF8qFYFY4JAQe8gKLkRUJgQQT8vO99U4i1x5lKbZAR1Ce9otlqpkIH+XJCH6Orzr
	1guD9OvKHJVAY/+Bn+JIIWvZTEfWjJsBuLuofN6aM0ot+MNppeY30YCSGeKjSgC+
	WF1YoCcu1oQN1Z9vxEJTzgvRG6ouETRfNuYhBZ1tr4TjVkLROEPifVgaCNJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746122005; x=1746208405; bh=+2VXGPiu8jjvtzKGcpOHPQBq+dxQRb6wS7W
	nv70WcPY=; b=uqHAKpDElnd3Pumil5k/YAzHC4XvMpzGo+yEtT2vizDKfZhKgC7
	vMWZO07js8RiSNpCdAfP7X7HLw/dLeUeG8Ay9idiUPi+5GQJ45BIGTng70QjAacE
	yVk1JyQo2/hoFe5NU46ReYjFayS4OyimuGczjqOTTt22HPp/V7IuOe9Dpv0GAD3Q
	Ha00c227pt38gqsL4T10oOIU8cubHYNsH13Fyzdx5Go2kQuBVnY7/jYItkXiL+1H
	08B/7v2nV/J+aA95l+T0f0MNOSb3szpT+8Mr8opZLu7gumSMvEHXoE/K1SNLEWxb
	kjhc2L6uisYHGeVCbSUgN1ltnskWWk9NRSA==
X-ME-Sender: <xms:FLUTaLnhBzKQq4OGeLkIwpRWRjbCphvx0ewUOOSyYmFD7KnZWe7RmA>
    <xme:FLUTaO1tqS50OyS5HgcTThrSX_u6vLtJtToVypFMrT1I2ZZuNPV6guk5gHtAQj3Ej
    rAHw77e0-NyIVYTQA>
X-ME-Received: <xmr:FLUTaBoUw-olxbqhuIFeTrsxX_i52mCJ0qbuGxD8UD503x8DEKf-ZWYeIvnMfMjqxUdWDvVkym4f_AJyjol9PB7T_VxuQhRSabEp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FLUTaDlX-pGRvoaney4Al0PXMvtpq6OFGclNET-VeAYjPxjyLoPavA>
    <xmx:FLUTaJ0dxCSHPjotbH_Cg-tnJIQZGgnEgm94syu8geHzQrr7U3MhQA>
    <xmx:FLUTaCtGvs1XsnxHHoSU8u68FAZh7WAhlqhUKiCC2a6uxkrtdVjpGw>
    <xmx:FLUTaNUTUPnAqNub5plWk3sEmnsThrlYMJoranVyRKWADhfjZ5hsfQ>
    <xmx:FbUTaKyeThvb5j0-jR5a_-2bMTQWoYOlE2Ex_IjZ2rPR2co3gK0iUJyC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 13:53:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org
Subject: Re: [BUG] rebase: can write reflog with uninit. `action` string
In-Reply-To: <20250501163822.GE1795346@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 1 May 2025 12:38:22 -0400")
References: <20250428194048.149348-1-code@khaugsbakk.name>
	<ce0f41e4-7d90-4398-a0e9-e8ba69791e57@gmail.com>
	<fbc97d6a-2022-4a64-a2ba-5a7255cd81a6@app.fastmail.com>
	<20250429215155.GA36727@coredump.intra.peff.net>
	<6743a9fc-11ca-45ac-bc40-4148f5d85d27@app.fastmail.com>
	<20250501131751.GA1725607@coredump.intra.peff.net>
	<xmqq4iy4z55h.fsf@gitster.g>
	<20250501163822.GE1795346@coredump.intra.peff.net>
Date: Thu, 01 May 2025 10:53:22 -0700
Message-ID: <xmqqcycsxlnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, May 01, 2025 at 09:07:06AM -0700, Junio C Hamano wrote:
>
>> >  	va_start(ap, fmt);
>> > -	strbuf_reset(&buf);
>> > +	strbuf_release(&buf); /* guarantees realloaction */
>> 
>> I initially thought that this comment may have to be updated in the
>> production version, but because we have to freshly allocate for each
>> new message for ownership change, this comment still is correct.
>> The only difference between the "here is how to expose" and "this is
>> part of the smallest solution" is why we want to guarantee it.
>
> This code change is just to stimulate the bug more readily. ;)
>
> I think if we started to actually allocate here, we'd want to switch the
> "return buf.buf" at the end to strbuf_detach().

That's sensible.
