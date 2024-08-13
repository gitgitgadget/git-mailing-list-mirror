Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD871898EE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541146; cv=none; b=e9I4dc1sIzadBW07umRqValM4JrTHPyxrhJRLYIJMF7KgQPVJZ056pJkT7zkwiyLlwIcRhaYsfAz7czwVb8ol5V4ihQ6KAp5paxMBgninPgyGvwFet8PK30RgdTqBHhKJb9OulwmlyjvqMYVK4KDgSLqKwNVcd1Yqdsxtrh5t74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541146; c=relaxed/simple;
	bh=uLTwTK3gzxA9JPQVcUGEardcwuWU4uD+5hkF6HLw5ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d79EyXrlfzhns8QoGG2oF8izOCEM8xpnyjhX24xU+FZ1CaE91yGVnMEGqicvdqYK48o3Z1AqbzT31Ovz0RQi3t5G47rtTsz7vHfAy+OvJO6Kylv3cKP46Qbm8gYPg6nXl8idgPMPLrYH5vp5OBqtIzognQt5VQGP0kXtqlxtoDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WOkR1kQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mke2pF8G; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WOkR1kQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mke2pF8G"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 04E311151B4B;
	Tue, 13 Aug 2024 05:25:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 05:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541144; x=1723627544; bh=j83dv6KtUt
	wIFGfvvy8sxxI20WehYvt+ci5eF16lyY4=; b=WOkR1kQNnV7JOY+D76L+ZW42JG
	wPHRHMgu3r6Bck0FmVLjHuU4E+HtK5HEobQ6eKjBYlcDUWh7JUoYCR84csEjRGay
	+s2NUJlDuKzRwaDIjAGC9Fiy2pYAME54jyb7g6GHdvKRvot1lSx5AffcxGRG6Ba3
	275v5qfzh0Gi/5w8Fbl6wTemJd2IKvgaYXLq9EyXQoamtnsB/OhiLOktl1l2MS2e
	XJZtyZ1lxIS+QT49E+kllKHJLGzLFv4qwB1F8tX/qTv+YlL4f/Qy5HUq7oQ3kFt5
	j7rOQSfs1KJXS2arlQUHZluGdH5qqjTay+8UwnmpUNu0yo/+e2vgO0ZLvjkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541144; x=1723627544; bh=j83dv6KtUtwIFGfvvy8sxxI20Weh
	Yvt+ci5eF16lyY4=; b=Mke2pF8GX2n+65ffRefSTxYjyS+/CToOrHyfJyRAvxwx
	GFhN/BKarCPb4il0aCMcUb0BitpjwjHpQgq3ZTX3xlF7Hg8SW5KLs7LcE9Rcmlhn
	i6hYhXGr8fvU7wO5rQBm41xSktd/MjTOlhGKHturtS1I7vB+Uz4vVskgH6CKDahm
	wfukP1nwITF4XqD5UP85LX6Rv3B6n1i7jlFQ5YKqFacP/sS3/GrcUikqX65flyYr
	jfPA3Y3jIWjvSC4glSyLEmWwWJV0+QTHK9/XVCd7p8+yEbYcKDG66hEv5W4JqyVV
	YL982JHKL9YJdGsyxz2TMY1w7oXD2k9cDaejz9noPA==
X-ME-Sender: <xms:lya7ZttZeVQgmohHCzA2DeqHx5CdfcUow49SnZMas_Shxso4uhUA-Q>
    <xme:lya7ZmcgQAaNwgb-PWECrCa0xDjmTGZP9OxLUmzcf3HZmwAnpnvs3dpwYz3Albcnh
    6fIfNXvJPzxR6ZX3Q>
X-ME-Received: <xmr:lya7Zgyuvm5JjStrAlxJv1csLV6rOFCURat5GkVjWhO3QB9gbyYCXfA9DHoig2nUsiFQnjcsf-mAKpvBPr8i2EDv5L7DTMD4brIaUtpcMMfp7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lya7ZkNPgpdtOt3TXbTsHxgonmxn_L1K_DTfAnbaEYNHz2QXAeDhwg>
    <xmx:lya7Zt-1uf1AdmBYgHIUaZNugt3hpqpXyyFvXyOhAoMaVJ3l2KMgMg>
    <xmx:lya7ZkVm820tEyq9DwUFC42ISgstwi0dvtTrDAHCNeVdPE9dVdKCoQ>
    <xmx:lya7Zucavg56Cuat0ObgPxEki6h5P7v35j4B3hMuXjIsH0_5drJkiQ>
    <xmx:lya7ZvL_65PQpVx5zflAOsJR-YiXfw-cBGkVv5CAEbnZGcCxMx7X_KkT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:25:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f5e9ed9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:25:27 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:25:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/20] config: introduce missing setters that take repo
 as parameter
Message-ID: <ZrsmlVfjIoFw3gur@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <feae2ad31ac91baae75c46c22c5c3ef3b58c1897.1723013714.git.ps@pks.im>
 <rg5j5ehur5a2qvpt65ezfub5dmmqrbn7if5f2r7ibweuupsnm2@qeciml3qvdvy>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rg5j5ehur5a2qvpt65ezfub5dmmqrbn7if5f2r7ibweuupsnm2@qeciml3qvdvy>

On Fri, Aug 09, 2024 at 03:07:37PM -0500, Justin Tobler wrote:
> On 24/08/07 08:57AM, Patrick Steinhardt wrote:
> > diff --git a/config.c b/config.c
> > index 6421894614..ac89b708e7 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -3178,21 +3178,39 @@ static void maybe_remove_section(struct config_store_data *store,
> >  		*end_offset = store->parsed[store->parsed_nr - 1].end;
> >  }
> >  
> > +int repo_config_set_in_file_gently(struct repository *r, const char *config_filename,
> > +				   const char *key, const char *comment, const char *value)
> 
> Instead of prefixing with `repo_`, should we instead use the `config_`
> prefix? Maybe `config_repo_`? It might be nice for names to align with
> the config subsystem here.

I think I agree, but we extensively use the `repo_config_` prefix for
all functions that take a repository as input in this subsystem. So in
this case I think we should stick with that, but we may eventually want
to revisit this.

Patrick
