Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0138234964
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494661; cv=none; b=CIYphylAPB2yKd2y04qr9vSRLiEvrcuIwSEwQnVq5njUtADFtE4pznqZ6f3/vHEW3ETzNReQqTUImS12ZwHb0KXONuVo/bXGhyIrBzTwus/09GT3esoFT21YGCTJIoQKblpdX/63WBg6+7ZAgPH0xZTB+FwsEa4QUVX/2dlEwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494661; c=relaxed/simple;
	bh=BI+5XelEpWqvJIuoMbVJU2skejlz9whWfgZ0iOwu+aI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FLfHmUhRo5+lLlYhxMJo46b57dmxnSYaPufGAs85EF0tMMMmovnqKKK84knXMjJRrL5F/mLbdkk/aVlhesrm6DTfZ13oO8E8DITzvJVClM4m2nLLBP7Uy4izlBIaEW021HyZIol0Ypn6EOXxIIIJpuelUvxkMTEarkNS9+95ntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JLTeINoK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9UNJKnb; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JLTeINoK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9UNJKnb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 24C4F1D00104;
	Sat,  3 Jan 2026 21:44:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 03 Jan 2026 21:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767494659; x=1767581059; bh=7GcD8etsO5
	+qiLu7/b5cgE0RCtCKXH38d+Bz8KtCZ1A=; b=JLTeINoKJekv7b6JvsYTlOZs5n
	J4sQcG+SNMc5QDWcAfs9J/9ac6DKIIeGqGEf5FZ+fgoNBxox74Qv1NftydFhrkfH
	wFQury3LdRRb+0LBO/EJUBOvzjK2G9MpISe1sA5oU9JWy+rcHhv5GVoCKfn1IFJ6
	Y9qrbkRl7cCAYrjNdFPDM3iC6V5rOZA16HRovX5lOHznFh4gstS6HH+MR5cseJYJ
	udKz9+tDMODdGgbOA6zT2awNgNsIdjEzL9ifQt+63e9fejJek1aUwLq1FPkJD6qC
	UOAELimlczpkb22Oyah1Q6niCI4paonG31WhvFc8xWV8mOG1O1zDHyaOWIJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767494659; x=1767581059; bh=7GcD8etsO5+qiLu7/b5cgE0RCtCKXH38d+B
	z8KtCZ1A=; b=l9UNJKnbEDrcelZ+BK1ZKjOFloUheyW8CST35BLzCOAlidkmCIT
	k4ijnqBEosNYP7kBtgQzddXwON1sLtDR7zlDWcXsxXy+LfStsxCaqcdI0GhzYsZR
	dM/uuEO8R/ucpo3ED5ZGqDL2AHvNYXcVnGOYspoYOw5cEdDDaObCEC+8+hfURCll
	Pz9iqv/xPCocrJran+MRtC/0CVzcbkwe6/14ZtkU1HIbe/rR5JDD7u4ciDJri+GG
	9kws+tzRgRhm4wIPnL16IIVhd+m0KPRVSOkJWHuHK8lCH22njfGQTzAZ0VNSsCIv
	JGHtx0cPMQ41hC0pzYM9ZCmRAvsQQkKm2mA==
X-ME-Sender: <xms:AtRZaW1IVyKtk3lMngx--8avYUgwneUyptQ3BePAgP6gyrLFG6Qzig>
    <xme:AtRZaQGF5rdZPDsiVWCTPeSGOVRBpU4eBwj9KBFfWpeIhomvO4zdj4zwpq5CDwEXN
    18E4SNQ59kpH27YRyf26XX0-HG5pMrWsSY9GKEEDzeVqQdY-w6cKg>
X-ME-Received: <xmr:AtRZaT6Ve1FDfDswf6rDGzheYIIywhCj1BOinqOaD1M9Yb4igMMCBNsDf7Yek6ne6iuwBWv6TXayV9UnZLjD0FjbtMMUmJL97XQ-0EM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    vgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AtRZaWtN_OuWW854N9wUjMKmVo5pSraTPUy664Ay1dxqIqPa5ezknQ>
    <xmx:AtRZaU5O4P205T5gaEzH_AK849nY_HKkl8HLiIwJboxZThIwhWSzdw>
    <xmx:AtRZaRW5WcFt7sAexr4u3tnC5GwtMzoULeGpg2lDqg1Z5fcdvubS8A>
    <xmx:AtRZaW-_w0w7WP7gVdAZDjehsDxhQbFbqGQkaOgZ4G_s7-QUvinC_w>
    <xmx:A9RZafZ0eGr0RKm1WjwbhwtOqBeuQQ3GucSaGLCjJjyvTHyPDyEYsS5j>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 21:44:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/10] Xdiff cleanup part 3
In-Reply-To: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Fri, 02 Jan 2026 18:52:14
	+0000")
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
Date: Sun, 04 Jan 2026 11:44:17 +0900
Message-ID: <xmqq5x9ip05a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  compat/ivec.c      | 113 ++++++++++++++++++
>  compat/ivec.h      |  52 +++++++++

I very much like the general direction, but I wonder if we expect
many more "rust-to-C interface layer" files to come, which I suspect
is generally true, and in which case I think it is a good idea to
rethink the use of "compat/" for this purpose from early days, as
"compat/" is not about "compat between C and something else", but is
about "compat between platform peculiarity and (idealized) POSIX
environment our code assumes".

