Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87DB2144C5
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318122; cv=none; b=nJ07ovMm06ZPMDoR7iKEfqirihzq8v48XxMCOSouOckpZyYD+fM7eGTW0KIj3Pu2219H4wboiNoRgYBqzuAF9WmhzSlyFGevUwAQcuC5oLvc0UMU85+VuLNTn0HAkrrbFcLab6eFaYX76KI4b2Lw5x/k/F56ETAzu86GcvhdNt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318122; c=relaxed/simple;
	bh=7JV3BuBCjfe3zfZyCJVytLPKhN2RTJwukLl8lrnqhJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRoNn3xWDo+GSDvKP0ZzoSHXnUw1M0fl97HkG0KxWCPx/mp3kQBM53/ihYYq3lYJcociZyl1k5rcHWGTnBjx3EqWQ76Pzr+IMAUy5jzeIKvWjauG8yk2wyQmhzqKPkwjoB3g2qRq/5pDflt8XCZgtO7YENKRycSXsVWznvoWeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J3dWP0a2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArKYcVAC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J3dWP0a2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArKYcVAC"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 160F7114011C;
	Tue, 18 Mar 2025 13:15:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 18 Mar 2025 13:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742318117; x=1742404517; bh=2EJ/cFY66U
	ud//lTIZ/Q39/WKKMvQCQxvu5ka7stbZ8=; b=J3dWP0a2AHnr9Xps0CdcLoNdzy
	4aYDwyxU+wu63fZ4RccfWlEIJrpt7JZHk9yI3bkMv9H/BAqPvTP5k1g9LKuxTkIT
	/etwfyNJ3i4qyMFrZiUbQ1PnOVKV18Y1+4xjpeWa7PrDJcUst3BNrERs73Mzrlev
	dZjdU4x+WAZBl2CTyy1Ky3iMdK0z7j0gvhgE7o+zyUm/qR/yAnQPnppE23aaEMJH
	DlDBi6OkNd0SVyUecXZWXS4sSX5lyiNC0LCbLLQtTKSa+ptLS/61QHc/1H4ZgjwW
	b9QSorv/vc4f90jm2yH3x3e3PrFRuCV0FF2KlZvX3W3I2kfuGkJ1btV9Kqxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742318117; x=1742404517; bh=2EJ/cFY66Uud//lTIZ/Q39/WKKMvQCQxvu5
	ka7stbZ8=; b=ArKYcVACKETLvo4VcOOTXhNLa8n2O+BeUhZOni5ZUAddLC3OObK
	4utqi1AzJ41qMQDM41utvgNPwCl7UwUVDQI3bq3IkyG4DUR4nPyL5q0Dm2y71i7A
	9MROCvPHsZTDqKhmdYrSRQVOm/LgyrRpqID0BEq5cpkruYzb+fCr4eogosMTYAga
	kFqLWj3Qh4H0//efmIs6O1JyPbgYS9YImVvZEbwfKxqBfiB/l4UJBGEN4BuO8t1l
	pYvQjo7U2c+kYpNgvDm7RSQNCYkEAOG+pgyOOgIX+RjwOQAz2wFLUD8Wv/ZUfopy
	omr4z0s/bvqiAXj6FfMaeD2DOzS7ViuZ8xg==
X-ME-Sender: <xms:JarZZ5CRp_S4yCj7Hc8F0Ew3GFc-GBoJFpYmgv4_Dr0J93GLS2JJzw>
    <xme:JarZZ3h21hCZU0lzbQqftfeqAQyadSoRe3IoTOWV6FZ7-JLJhtrqSk5XhzesVC9CV
    D5A74TZZqZqaQVmMg>
X-ME-Received: <xmr:JarZZ0mZwBcjVdWmIYV5BtYDTQ9K7SNQtzGAkBW4-5uQp1M_NUeiCnei38pXleg-E36PD0s0o4GYGYB3AFLgU3efeR6Fj8beKhaeVzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeftdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurd
    gsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehptghlohhuughssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JarZZzxG6AgUKfFKcwAAxkZPgwzdAae6PN4a2flmqfVOXrvtgpvhsg>
    <xmx:JarZZ-STk33Sgsntt78Hmd7vbFw4j6X4hfoTj3HRB75Fqh0XISxWHg>
    <xmx:JarZZ2Zsy52p3kXUJQM1NslknFir3j_IXssT7IHqJ_5V2TSh4H22bw>
    <xmx:JarZZ_Rcpsc4RSZe-y3nRW8Ng_eZbIAu4vJjfpFaAg-4hSeI05bPBQ>
    <xmx:JarZZ7KiPeQSvIKd1TZiys8kagkmUryuRLIZK43tKMzp4gGTBpFjOJSb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 13:15:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  =?utf-8?B?Tmd1?=
 =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?=
 Duy <pclouds@gmail.com>
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
In-Reply-To: <Z9lcXR6sL3UWlL33@ugly> (Oswald Buddenhagen's message of "Tue, 18
	Mar 2025 12:43:25 +0100")
References: <Z9lcXR6sL3UWlL33@ugly>
Date: Tue, 18 Mar 2025 10:15:15 -0700
Message-ID: <xmqqa59i45wc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

>>before making a commit.  But "this makes it impossible" does not
>>quite convey that to casual readers.
>>
> no, i meant what i wrote: it makes it _literally_ impossible. it follows
> from the preceding sentence that _whatever_ is in the template will NOT
> be the comment char.

OK, it (i.e. the order in which things happen) would be a good thing
to add to the explanation, to unconfuse readers who (incorrectly)
guess that auto comment character is determined and then template is
read, which is where my comment came from.

> reading through the thread of the original submission, the feature is a
> workaround for `commit -m` and `commit --amend` being inconsistent wrt.
> message washing.

Perhaps somebody can be talked into fixing it ;-)

With a clear explanation, I am OK if somebody wants to advocate to
deprecate (and remove at Git 3.0 boundary) the "auto" support ;-)

Thanks.
