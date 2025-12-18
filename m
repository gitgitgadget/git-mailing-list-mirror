Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183052EACF9
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045170; cv=none; b=izRgwpdtRAPapKQqL6k6I/0cV+MSitkT0LASNjnea4TjBvOpK6bYmrvArsYcz3QZhnkaYhNu31Rbm7X19C1urMcNxxI+Ha6RiPOR4VhErtyNSbZFi+ZjVGi8qu/5ixWbFrXXHXVhpGAq1wTDhGzZgrhrT5ZvjaPJzPJGJ/l9W3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045170; c=relaxed/simple;
	bh=aS9dRi3utZdfbaUFwWaRwEXMXaRDzZZUD92jcfljAqI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YboMtX0iFulNbcMiTJsyrZ3+JakYOv1BCI08Jxrl2lKSokL6TGKcis4xfXZ5ll8gpO7YECjWNFlHHM1f8vOn/q5uJ1/8VP7lelO1p7/46bZGeeHI9lf1ZKNCo84Q1uUh0w9FwjLdneA5fLXZg03AH78gsYWu3KLZxxKyzi1FlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ssriql+U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lj/BT9XZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ssriql+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lj/BT9XZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D26A1400230;
	Thu, 18 Dec 2025 03:06:05 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 03:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766045165;
	 x=1766131565; bh=WbwEmq7W4AhyEWJIymCic4ZkcK9cE5ZwRBP+Dfi044c=; b=
	Ssriql+USLUtGkcMHgOEgs3pEqWV3fhbUuOPAb4WaxOziPrN3XN8ayOVKfOaj5SC
	E9E6V4AeCH+aMt0HCH9bmg4KPXkJqnosfXaBxkUbyOKdY6Szwwe76h/1NTRDuZRb
	yUoFMJ0frGJVt2WLe1q4x+FTuDiZPEW+SKP/S5DhTsi9gpDtLATincAlqm1wBSmN
	1lwy8aRi9B7sNtxHrjxn+iciEyj4/MX+HumRABEnz8iatS2z45g5UGQTjTK/rsUc
	X3P/bIdA57euYqzf71yAR50HHC95oQxLJEOIU57H6D595W1yGN+T4ROIGrgHa0Lo
	MxsaDTkn6QUxqLkEDGDgag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1766045165; x=1766131565; bh=W
	bwEmq7W4AhyEWJIymCic4ZkcK9cE5ZwRBP+Dfi044c=; b=Lj/BT9XZUJq/4yH3S
	Xys0JAUNmvgbim/wbnBgEQvQ2UgGGlfZuzFZxrIkUb+QPOygGrud7I1Bh6N3OYEy
	f7OECZSEWFyWslyNRua81uOm4l0a3UdMhjfAgpeAApNkMPUElRhPt5RgKU/5E3Hl
	EDZPzhqeGHngXtqIa4L6P8wDxACHB+byCjkE3dUwtVxFHgCfEWtwhT+ImMblkolr
	+0ZXxq+NXAszKyeveRnfUC7n8vpfzTBdZ0STfHAxmEOxJ3vrix/4TeOZfq6Kg+Ft
	WLArXWaKswyL47vhf2u+mV0t7MlyI2nd5uk75ABfkNBjUu2WMjYbjCdVsGDcp/1e
	B7h3g==
X-ME-Sender: <xms:7bVDaSvzIxEjFEGeE60K0R0DD8JTrp5d3U4pQ49edb4dxnAzgpDXc98>
    <xme:7bVDaST_-emmTLqFi6FzaZ6FA-Lg46GrLKHT4bDQNs962GbIdZTLJxwBNbCYaCxl2
    194SRggzyGQjpeym1YDbnwdbz8t01dZvPHAn4eNjuvQZ96QS6WN5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefh
    feekheetgfegfeejveeikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdr
    tghomhdprhgtphhtthhopehjvggrnhdqnhhovghlrdgrvhhilhgrsehstggrnhhtvggthh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7bVDaeoZ5J4V7BhENFzLTbKnoCuZKjCbpTo-fY_U1uWXC53kLNV3aQ>
    <xmx:7bVDaUbI6U7FrboMfJUk6bz4so0oE_4scPLuuBhillaLiVnq4yjfFg>
    <xmx:7bVDaWSlYmIzDtNUDfYCvK2DIpljUXq9b5UoJrBvoz_k1GE4ilwEqw>
    <xmx:7bVDab7EWb9blnEwG0rPl0SaaaIVXxx4ceyraXCp99qR4I2VGFiq6g>
    <xmx:7bVDaXfc79MMHzOUwHlzHU7tSBJK5cv1F0UdSaMmVYfIlmgiRsYIeUV3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0BE161EA0066; Thu, 18 Dec 2025 03:06:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7cBr0QabPqZ
Date: Thu, 18 Dec 2025 09:05:44 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jean-noel.avila@scantech.com>,
 "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <843711d8-00c5-4747-972e-e705e14d85b4@app.fastmail.com>
In-Reply-To: <876ee36d-610b-4df6-9297-96b38f106c6c@scantech.com>
References: <pull.2016.git.1765830229824.gitgitgadget@gmail.com>
 <031d7b41-b6d3-450c-925e-cddaf2e7aa85@app.fastmail.com>
 <876ee36d-610b-4df6-9297-96b38f106c6c@scantech.com>
Subject: Re: [PATCH] doc: flock of small fixes to various documentation files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025, at 14:45, Jean-No=C3=ABl Avila wrote:
> Le 15/12/2025 =C3=A0 23:50, Kristoffer Haugsbakk a =C3=A9crit=C2=A0:
>>[snip]
>>
>> Could this fruitfully be split into at least two commits?
>>
>> I just think these are two different categories.
>
> For me these changes are so straightforward that splitting/grouping
> seemed overkill. But, I understand your point. Style vs. pure formatti=
ng
> is a good approach, even if here the style is not about the approach to
> writing the documentation.
>
>>
>> Is that just an academic concern? Well, in my experience it is very
>> pleasant to pickaxe through a snippet of text, stumble upon clearly
>> marked commits like
>>
>> =E2=80=A2 Use USA spelling
>> =E2=80=A2 Fix articles (the/a/an)
>> =E2=80=A2 *: typos
>>
>> and just race past them. Because I am looking for the original
>> motivation for some phrasing (say), typos and missing articles and al=
l,
>> and these commits are simple to bunny hop. But here, fixing a missing
>> parentheses is mixed together with
>>
>>     Replace: less than `<n>`, where `<n>` represents a number of byte=
s,
>>     With: less than `<n>` bytes
>>
>> And now I might have to pause and think which implicated change this =
is
>> about for my purposes; a subjective-but-good change or a
>> fix-objective-mistake change. Because that matters when I want to know
>> why the text is phrased in a certain way.
>>
>
> OK, will split in two.

Thanks. Your consideration of this point is enough for me. Appreciated.

>>[snip]
>>
>
> Not the purpose of this commit, but maybe, it would make sense to stre=
ss
> out that the first sentence for explaining an option should describe
> bluntly its positive action expressed in imperative mood, with no
> ceremony. After this first sentence, the negative equivalient, more
> context, more precision or use cases can be described.

That sounds excellent.

>[snip]
