Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C98376E0
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 20:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734899478; cv=none; b=UvtopdB8T4cMAfehVrQ3h5DWiVMKF4S7z0EJrIZgHW+GjSCOk7L+5ZfLbPJEp3lsDaEMYyDa/fmdr2tVM2kggpe/u+bgW19NkK/hgiPJV2JgcDEwBHbjhO835Z4TXM7vuKxN9orH2bVZGtjsAdLc1TPXlJUsC7GFmafrbNwTpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734899478; c=relaxed/simple;
	bh=SG4bPLHs8tkBWXOaUl9IWDETBqQ3YAVGZyQCEV2BgnY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MRWfwaqV2FuklHqZ+f9kHcdrcrJW4HMVI/LX1yB5BeGMBzZ5pm9VBC84AdCOAtOlx7dgwGRivNH9VLtp6AbWw8rgoXLfgEU/4ikiYZePKXPGX5riU6Ej5IKHuzZ/V7ByxEKtoOSSKNV1eDbMEBFfJv+mODGi9sOcenfbNec4xWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=caJ1ADtw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xoVBnNNd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="caJ1ADtw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xoVBnNNd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A0A01140065;
	Sun, 22 Dec 2024 15:31:15 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 22 Dec 2024 15:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734899475;
	 x=1734985875; bh=x2riIT2IrplAxUS1J2m381bIVE8Zoi0tJHEbQxuHt5E=; b=
	caJ1ADtw4XPDsyHqLzuUljL0GjmYdmH7c3BmQnXImofTMyi2YyVaOoE6edon9OuQ
	kfFpBgYotxYaGIRLS+1o+m/HrDbamGKx3W92jALyliQdxWraqBglRW9GE9byev4Y
	qJotLfdnAIuunraYf8T+cTEhFk2J1Upauq4I7iyumbgjzUI4mZonkqquMDnbtSCA
	aiNeULN90qQWgJD9vbfT9KIOv3oTztYum7Sb/0T586WXxIZcBXpw05N/3gVDiLlf
	mVYaphifUzPH2RO6iKjJP6335x7xV6KDreJNjhiZZ1zOAAtGauQxF42usEo+Mif4
	16xYPciYF3x01bEgjMqALQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1734899475; x=1734985875; bh=x
	2riIT2IrplAxUS1J2m381bIVE8Zoi0tJHEbQxuHt5E=; b=xoVBnNNdB5V0uL72Q
	tw1ySQ+UyKisyTZmAlaEAl1L1lXhckwH/4ikGA6jY37tM4qmjVbqFsbngBlqAve5
	0BPbnqCIAJhOyknV+pvj6fs6RlNvZykMVCvWhJUk0cYMipXplkQoM0WVr1JTrpBM
	0y6PwG8X0BTnDmjQw4z19kpYI4ym1RGkJmeNCvRCo4yDqmHut84xaTEyHb5CnZW5
	KBfEr3JgtfmLnltcJs174/x2yQXU3/yJ0oxcPQ5TpSNeqVNvJCOXb4kNYIfrE77J
	RDh8EO84zCywquMsikJjv4LSU9LsDVesVXGLmzq5bR74nC6OMU3RvM4WwMdupEaO
	He7UA==
X-ME-Sender: <xms:EndoZzgEFzHNlEMB8u-ICOwEqPy8GjyiqacGWQbKb59PZsDjZLID6i8>
    <xme:EndoZwA4LVDgwLKXm2bAvADlRPdI_joxNiamatxlUdj7CC81GHTwF1SiKCZRzmWk_
    G1NW6vI_oxPdFNVBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggff
    fhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvieegtdfgteeghfffteetledu
    veehteefkeffheehfeeihedukeevleevfffhjeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgsjhesmhgsjhhnvghtrdgukhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EndoZzEw8VraRt6ZEBvI8mqXyv6BmzQQvr6japwjnEkjUqE-qIcVCA>
    <xmx:EndoZwT3DJrvKiRaRW_XgPjy7sT_iTGzq3hU3alPaFlx9VN89y0CYQ>
    <xmx:EndoZwyJZqk3a19YONJJSZ83Ui1LFUNOn5BHOeKPMCYnFLleSBW15A>
    <xmx:EndoZ26-v3_2VrXBjA5zC1IW5HD0LG99OjYDQa-7xeQci4N8BXLojA>
    <xmx:E3doZ9peAjRIRmoVV0lyaZzqrbUT4DoieVMqXhHfswCNcVXLsi0mRk50>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 506C8780068; Sun, 22 Dec 2024 15:31:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 22 Dec 2024 21:30:54 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Morten Bo Johansen" <mbj@mbjnet.dk>, git@vger.kernel.org
Message-Id: <78610da6-218d-4f41-9435-3e510d31aca2@app.fastmail.com>
In-Reply-To: <Z2hLG2xmO9KFRpY5@localhost.localdomain>
References: <Z2hLG2xmO9KFRpY5@localhost.localdomain>
Subject: Re: [git] bugreport of a segmentation fault
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Dec 22, 2024, at 18:23, Morten Bo Johansen wrote:
> In the attachment, I have reported a segmentation fault in git.
>
> Regards,
> Morten
>
> Attachments:
> * git-bugreport-2024-12-22-1816.txt

Hi, it looks like this was fixed in 98e40155936 (builtin/difftool:
intialize some hashmap variables, 2024-11-12).  That change will be part
of the upcoming 2.48.0 release.

It does not look like that change will be part of a maintenance release,
i.e. version 2.47.2 (based on Documentation/RelNotes/2.48.0.txt).

-- 
Kristoffer Haugsbakk

