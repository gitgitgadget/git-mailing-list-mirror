Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318B3890E0
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114861; cv=none; b=IxzgdAOLZjgVu+KDaQHVHZp9vacMb4ZZx/kxloAFob8uCcRkihf0L1Zfc8V4oWs1h59AcEwOCm7R9bO1AfZ7/h+CDWCvWfLZiApIx3Cgnyz+WpcbqutX2NUPwTcK2Bfqrmk/DaHi9ft15EPjM4s2xdDthIiIO7+4BR+nUDIbptk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114861; c=relaxed/simple;
	bh=SnVi7z6OjDx7q2KB6hEl2ElFFID+fR8sXIWXB/eNxwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJUfLZRGYDhv6ibxhTWvu5aynESkM6pjXyjLp4UgTTRRY9yLu8pwqrAdKc+/6JvI4seBnZbmtVfIqI/tGPQ8JS8lYzXVFuDOk1jRo24v0yspi/PJxNpOr3l7A5RRfmgSHyuq2cOAYntOKFyzHyqNvbP0bp25kFReL0/3PGUwZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=0pBXg8ib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b06tEHVh; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="0pBXg8ib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b06tEHVh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EFA61D0039C;
	Thu,  2 Apr 2026 03:27:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Apr 2026 03:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775114858; x=1775201258; bh=dmuR1ot9q6
	a1LNo6CizofwJudkR+FJ9wgUxuSBq7C5w=; b=0pBXg8ibx7ZCClGVj7X2xaCFQq
	nHOeqNlwf/RBCFFCTCEVqohX7vWQfE0KS33CdE2s0Kv1K0em6PEcjzQFpcmkS9NT
	kYTe1oVUoRnrJZSGOW9mgTy7kWTYL6p3Xw74tKXWYGDETVoTC9OAkmKwrNkfzjYp
	yCmIUWIk2rYxjthiLIvrpm/7K8Sn5QZV7L6j1tJ/BkBgpSZJJzBEEjB5jYqDheFv
	PWZsjvIJOlecO2owmX8zjol41RoCdVo8aindAiw0yoBqAH/svFSpgDpuK+Lrddb7
	I5u9sY1E3n4YiVuxNk8BJwaQ2QTshnGAt9a2Zuc80JFk27GVJKWwjCQ4rxlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775114858; x=1775201258; bh=dmuR1ot9q6a1LNo6CizofwJudkR+FJ9wgUx
	uSBq7C5w=; b=b06tEHVhMPWwM5nvnnOlJZyqpnPj4BE+2TiV6qePE2oj8n55Erb
	p1RuWazoo4qJ110DwMrhUNUywkfMOyim44+BSg/elRkVkFnKDGn9KfcgjGbuW/br
	D2h8vQvBisEF/IF8S9cin/awRfFbglYAfnWBZchbQXBSH0j+pFe1AqMjBHowsU8t
	EEwzTX/QFCMRUG4DZcXJGIZJ8unZJA00WeHy7DB+sVqLBSWMw/sQyB8Qmw94S1SD
	lObkFoFT33uHw0UAduB1Mgx/h3I9koZqbfRxwloXVR6cY7o9+37DgHTX9dhZTak0
	X5nMuSnN1f+OoF9ZgJF6yUYfLngUUSUv4BA==
X-ME-Sender: <xms:ahrOadd1REcxx8U2fSORxBnbZW2fS9lAz6os1aJcmZiCZp6U2JzSWw>
    <xme:ahrOaRP2zMZ0h9JqbUjXft-xt-bWRqtQwcNTaPFER9qIvKp2YznENJ1aRv13iYnib
    EgjNjyqTHN1wSMbxfwa1kTfuVbnztlmivIs-D951UXfWqAgOh61zQ>
X-ME-Received: <xmr:ahrOaULOJlLSgk5T3kSlaDaFGtgFn_Z5oFoMZ15e7vqVTygnqlonx6oqPraYPs4pYNNpc9wmSoB0f9NH7m9uxd0Gtpb_-mJzFHmsa4UqYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgf
    eugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:ahrOaSFnh2BSeygcNNQIJ5r2g8MGzb-4nq_7FdpCwQRNYH8cniOUNA>
    <xmx:ahrOacQMgVriq6Uf21VelF_gybzXEEtpvQjhM5t5y9IDDLznZHk1sw>
    <xmx:ahrOaeFystQhruTGKXaZ5SQrONyJlzk6VLfU1AgzxBGHbfbgDabCmA>
    <xmx:ahrOaY_CMcR33YB4DnP562-zCyqVv6zIw4DN4ciXwgHNMHs6sOIf1g>
    <xmx:ahrOaUO2XCl3pzl8M3mskCNGQXl8Ck7PJKehHgeftN8U15g_nh9IYhFi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:27:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2f75e813 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:27:36 +0000 (UTC)
Date: Thu, 2 Apr 2026 09:27:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/5] refs: add struct repository parameter to
 branchname helpers
Message-ID: <ac4aZRveWXjOtxgB@pks.im>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329101725.1092900-2-shreyanshpaliwalcmsmn@gmail.com>

On Sun, Mar 29, 2026 at 03:46:39PM +0530, Shreyansh Paliwal wrote:
> diff --git a/refs.c b/refs.c
> index 685a0c247b..5cdc8858c5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -758,10 +758,10 @@ void copy_branchname(struct strbuf *sb, const char *name,
>  	strbuf_add(sb, name + used, len - used);
>  }
>  
> -int check_branch_ref(struct strbuf *sb, const char *name)
> +int check_branch_ref(struct repository *repo, struct strbuf *sb, const char *name)
>  {
>  	if (startup_info->have_repository)
> -		copy_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
> +		copy_branchname(repo, sb, name, INTERPRET_BRANCH_LOCAL);
>  	else
>  		strbuf_addstr(sb, name);
>  

I have to agree with Tian's comment on v2, this part here looks wrong. I
don't think we should depend on `startup_info` here, but we should
exclusively rely on whether or not the caller has passed in a
repository. And that will likely require a bit more scrutiny to figure
out whether there are any callers that shouldn't pass in a repository
because it's not initialized.

Alternatively, we could go with Tian's suggestion of checking for `repo
&& repo->gitdir`.

Patrick
