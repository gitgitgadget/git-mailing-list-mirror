Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21241DFF0
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345920; cv=none; b=kCpxfgfuQ/VxC290lgkkJmRpcOAEuAwrto1a6Aw0UNSzaVtJEpKCPxtqTQStWhCKPyXlue7Wlwbk/ZGXlW4iT66Pz+q5YhCaIuW+1OyABIWSGPLUYyUVoXa96e+OwvI/om0/RzQS0jgZysdTra5ACk9KoDUwqj8mc7XQ3faBviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345920; c=relaxed/simple;
	bh=i127LVJCKVYZ50BZcpmXpF04sI+aJQrs01scZGXNpUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QuOcmAw+8UZCx/XMPFKPCABWjeirZcwKfcjq9Tequ1uzj1nHz9t4ubZtvrxyLekvsERyeVwL1PNAvqCRy2LSBsYB6lowtetq6QcRYJe3kocuyU64Ji4BEE/rIcZsQ7qRDDGl/nLuMcZYuLOH+aPtrlXF20mIAzgd7fZ5Y7cKGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PHvOgiRc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j67cTjup; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PHvOgiRc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j67cTjup"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9567825400DA;
	Fri, 31 Jan 2025 12:51:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jan 2025 12:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738345916; x=1738432316; bh=xwdJweiO7g
	MESCaZAMjM+t3RI15AalRd1YQj7facCTw=; b=PHvOgiRcsBGksj3GMHnBBeh/Vw
	LvrKr265xMYrdLboT+eG8xX/F5FLzfEaol/cFf5zTD1WqpLUImVU8xnimpqjOc0u
	sjHNz0TsWS/U0Lg7w5oZubjYGcpAedN9g1sU7CHI1BvWMVFTi5cEGk+LCnrbq8ot
	7Aky/mKrLhw6WQg7GsZcZJgOrnAbU+myndBO09GAPV+fEhtiX5tPQevz2UXarZUV
	NbP7ddMMSxNCGLno6gAiOjXpURMil+FCCEWzMc5zD7p2dgWhEUh3Th8L3Vi/spnS
	uiqn73BSERQbP0MttBnpzqWvcowfx3QepRaX5Y8fRvCs2OzB4ggyas0/AwZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738345916; x=1738432316; bh=xwdJweiO7gMESCaZAMjM+t3RI15AalRd1YQ
	j7facCTw=; b=j67cTjup6O7dIQbskcRiA+IWTAXtm8yjjmyYocMhwG+JiRjaj9y
	yCu/hdSceIJs6cxhAcjvEbZ/N0Usbyw7AxrVJDch2sjxMiBNoiIm73BXVRPn2vQh
	CPMmI3rqnVq53/IsrFFcIMpbQr07ljL6sH8egJVlHKsfpk9N4Ehsw4agNyL+msaI
	XgZEb9ypeM1iAXm5NWetklPuVyBEoVsYkVsLBKm4a3EXkIn5jNwzh6iCjRtUslH3
	+VuSCXVVIm4/ccfGtn6OQD0tmRDCxbOFk3I+mZVu94TALu9RFsIMksBPjeAL/krB
	81Yb/RWAW55VV9w9soAkzaopris1Y26RcaQ==
X-ME-Sender: <xms:uw2dZ4A1fvySMlXGu2OvzUv-xadr9H1gQ17hvvt_PqxPHQHAv97dQQ>
    <xme:uw2dZ6jjw3-RVUpcLDy5EENSydi2TNQk4k8iX4PmlZcLf1C5ElVzUxROwaAHb53bU
    w04MfAlc9xCsOziGg>
X-ME-Received: <xmr:uw2dZ7k2MeumguW6euICC9-d7OcPT_vNJShJkHNy6G30LrScQrFKwGvxrcTSTUBfsdl11R5KO7YGFNNHnw5FuIpbKAPrcLYcMS5R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlihgrnhesughruhgtkhguvghvrdig
    hiiipdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uw2dZ-zujYDXoTUcH2Ylam1_gTnWXUibi_1hZwx-R6-N0IdWQmYfNw>
    <xmx:uw2dZ9SG6mad2mtNgNCEsbL4a5a2isJXhg1hhMeiuDXul1S1BTOYPg>
    <xmx:uw2dZ5Z8VCswifjIy6Sqgu8KD8EY016oRPBvZnsL5erog6VPMX2JJA>
    <xmx:uw2dZ2Rhzbtzm-nxkea7zI1Au9wyejI9Epo-gWuQ66251hGOhNye7A>
    <xmx:vA2dZ_eemyC63Ht-FJdHxqXFkWOVduYvMhlRv1OgLyA1X8zMb_xS-y9q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 12:51:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Julian Prein <julian@druckdev.xyz>
Subject: Re: What's cooking in git.git (Jan 2025, #08; Tue, 28)
In-Reply-To: <xmqqlduulbgn.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	28 Jan 2025 16:18:00 -0800")
References: <xmqqlduulbgn.fsf@gitster.g>
Date: Fri, 31 Jan 2025 09:51:54 -0800
Message-ID: <xmqqr04i98hx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> * jp/doc-trailer-config (2025-01-24) 1 commit
>  - config.txt: add trailer.* variables
>
>  Documentaiton updates.
>
>  Will merge to 'next'?
>  source: <pull.1871.git.git.1736429142334.gitgitgadget@gmail.com>

I've held the topic (and others that touch documentation) in 'seen'
as we have been seeing GitHub CI breakages on documentation task,
but I think I figured out that it was due to semantic mismerge with
this topic and the recent "everything in Documentation/ now ends
with *.adoc; they are no longer *.txt".  I'll make a merge-fix and
will mark this topic for 'next' when the result proves OK.

Thanks.
