Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE432861B
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039554; cv=none; b=rNa3yjRs0oIGV4yME1Dm8bku7zw8g0fYvvX4C1gfeC3dd/89eG/OuYb3X7P/0jYrEaBto/9lw4vFhPEil83/fg7VwWmWyTQZWLKQ3sTmY6iQ2DD7zoVI2JHJrN7hXzaWM5zMHxhpMNdmKdEobinZ8qDzKdxzjbhnJalvcIMOSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039554; c=relaxed/simple;
	bh=IjsAAgc2z1mWQ24kY/o7aQUEsDG6QdOu8UHbrq+E9aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHILGsa//Kz8TIuXehSMmHqIBmtCpGzJr0h7sw73ieYvlVllfK2WAE1a9ls99QyJZcICdGtsg5yYW30TizcMVUinlI2nj9AigZVLt2v/+fKjys1/KSLsorlRi9gncldDCgfa6WKfA2zRLdMMdI8v1AJd3VeQxhHmGMNGv45V+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mziUzLHJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBQxmIkQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mziUzLHJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBQxmIkQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E33097A00FC;
	Thu, 18 Dec 2025 01:32:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 01:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766039547; x=1766125947; bh=6GbWt6Va6I
	LaCa+/FRfjf9ytHcw9Va7skzsYf0SbeEs=; b=mziUzLHJnw+7uVoxEPmh1vyThY
	8WHk6tLDInmxT+/iYqAyQs69KN14TP128K44eZIrNVNdgSxOsbrEVUWOTOMcdiOy
	KO+yi0z1jYkj1ohod5gvCvf8Z8IoN9b91GdVEghjHUEWVtuUkZ/xK4mGtHiHDC0a
	wEmLRGwZUCZ3SDHxtz46yYwPF1gJeQQMEvFb4cdlSozeT9p4dJRrB+JsRM0tPpui
	YMI7LuShbUNvhkAqZ0YfHdSjdf91TkEHehE6YMmEerzf7wr7Pl93nlrGSPuvZfIs
	6AFrYtl/ArjBTN+kE2LJHg4G/SdWYyzXGsKigmWoQOOJE3ZZMk5nvEeVYZHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766039547; x=1766125947; bh=6GbWt6Va6ILaCa+/FRfjf9ytHcw9Va7skzs
	Yf0SbeEs=; b=PBQxmIkQCqcH8cS3FpGMNXr60fG4D28dZakGKt1cMhlQqKODHGE
	+So1vEKcL7R3wQfY6QVmh/tnR+LSI+lJlLG1/399L+I3PrilDVq6elmdK6eQN2od
	K3joCXgeCrS3Fnf/PqFCSbFweU+dzcQaJkU230JkqYKI9esIZ1n3hHoYoaaVs8Fa
	Z5OZDxK9vWeNYVlBwfiggnQAbB4cjg3fqjAYVTvcMVBAXNUh550w6JHw0QiPdTs8
	bi0FMmq/ftR7VfoodWg+iNEAye1JogObmHsRxMmkwEfQedHb0SLcp7rIuRoN7hr8
	pXIWruHVUoXCNZ58I6yBXpSuxpHyc09w2xQ==
X-ME-Sender: <xms:-59Daf8ta7-pliPTiqT6N5kauTA-51tnmG32JErInXOUr6Mf_NaxXA>
    <xme:-59DaStwOLiKVw4thZiCcHjJiZLOykaJy-MSrkI5ivTRFF6HUwHIaKhLhYySeU2d5
    O2ia7WZSgWTpyDjtlN2_Oj5IFjrfykk75SE-J-RPc0hhgdaGxikhTg>
X-ME-Received: <xmr:-59DaSByXERC1r1VxdnPiPa8XIb2SGV9TeYh1so8xGtKk6Ek7OppjnXnNS7UKcWaF5k3j-a8IhSW_5mGiB_VBmZBHreM1QDzOXYCAUPE3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopeifohhrlhguhhgvlhhlohdrnhgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:-59DaaVlhfgiwR8wtdxPaHfIMdHEUHM_-J6R0h6SQvhtBQOiKZY06Q>
    <xmx:-59DaQC7eyGvB7v_S8M8YZwV1HQb8HP-AIBxJ1585DpC8v_igXuFlA>
    <xmx:-59Dad_sRh52owrxv2rgVdesVVrH58T2gMfdleAUD1UttCPXfy6f_A>
    <xmx:-59DaXFIguTCSZxZPp9yw8RArMQqfQchK_cGAIZgWg7REnEfRNdvQQ>
    <xmx:-59DaViAF_7KuscFa1IuX_-kFvcEbNeERkHIzmkOVpRAP7cBkytpSAC6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:32:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c3a78e4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:32:25 +0000 (UTC)
Date: Thu, 18 Dec 2025 07:32:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, worldhello.net@gmail.com
Subject: Re: [PATCH v5 0/7] builtin/repo: add object size info to structure
 output
Message-ID: <aUOf9hiIWYXgWJ1o@pks.im>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>

On Wed, Dec 17, 2025 at 11:53:57AM -0600, Justin Tobler wrote:
> Greetings,
> 
> This patch series extends the recently introduced "structure" subcommand
> for git-repo(1) to collect object size information. More specifically,
> it shows total inflated and disk sizes of objects by object type. The
> aim to provide additional insight that may be useful to users regarding
> the structure of a repository.
> 
> In addition to this change, this series also updates the table output
> format to downscale larger output values along with the appropriate unit
> prefix. This is done to make table output more human friendly. The
> keyvalue and nul output formats are left the same since they are
> intended more for machine parsing.
> 
> Changes in V5:
> - Small updates to some comments and log messages to improve
>   correctness.
> - Adjusted spacing in builtin/repo.c:count_objects().

I'm happy with this version, thanks!

Patrick
