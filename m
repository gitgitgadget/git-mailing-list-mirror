Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E071367
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699539; cv=none; b=RAnl+eocJ//U6C7gyInB/ylZiF5EMjHg5XnbPMKbeEstHJSdf1qNhSDJwpf3roj0+tgKThGM7mEl6EkdI+p5I+kIV4UcJgI6+VzeTvBb/TMX9L9tEyLgmajNGQw1+EPFTv7oE3eGzF1iN81KDuqZ1GnPdBFgKiQr3R6dkl61wEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699539; c=relaxed/simple;
	bh=Ky0WzFVuw3E2qlBFAsO4G1q6Rv4nNNIcysII96MGYKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvJm534aVATWq1Vjttu23s8Co9/0bXzjv+dXVsXZMoqbq26Kv48B6bM2QrcG5Tjq7S6calMYWIUiHNwTgZ3r+PwS2jRSB7KCmc+f0gQCjE+9udlWGrgLqT5GTNwYaGAYjCeHVBUpOeVwGcmjcxh1OyF3k2bSbok6YgEoxE/1JSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qLfJcG/p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l4mMZrxP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qLfJcG/p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l4mMZrxP"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 893FC1140194;
	Mon, 30 Sep 2024 08:32:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 30 Sep 2024 08:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727699536; x=1727785936; bh=EPgyoPIfbG
	hTUJI3YaSu+Dl9dop2Tum2EIulVdOyYl4=; b=qLfJcG/pgX/ch172Zdv/pm0oqk
	REHJE7CmqSfykxQarev4b3ejdYOe88hVtdy0xvAJONLfs1D2/w2NUW4AIWGiIYGu
	g5hk0MuF+Yy3a96vg7xwFzW6wnxiisogBvq9E1D1GvP5JLJN0J9j05W9aV8Ib8Bg
	YWcawODg7qcNLbF+kOn2oVExMbtlD9vmaaHPrjq659AEXHDsczBPgYKgvJ6UtLlk
	4pbckoO0XUT71DV7iL/8+dKF2wOageDto4B8ATyXQCxGi3bztSU41nxul2+e6Mhd
	h0tixxbHIJSW+xUpaZs+BMwqzUZTryqkoe3ngFf04mFnD05P6yQa9CZFQYJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727699536; x=1727785936; bh=EPgyoPIfbGhTUJI3YaSu+Dl9dop2
	Tum2EIulVdOyYl4=; b=l4mMZrxPrA2kgX0WBz1IiHMhD36eH20HaKsDReVNKAt5
	Ujtu1LIcp4RxvxIUtTB9qrF9FKja7dboQ8wwMwxNC7qQqAUejvFf318uriCQk5NK
	GGZtM9ZRaV4hneKAKcPp5wor9UvXhQHqXPejKuS0s3qY/S9k7lFueGNZjLpZafey
	0TC3ZJr37SOQq1e2ZFkgz37grU0BqJ5i8tmx+1VHvXbn8J4KIxxW+EwPk47pYvhF
	Z2xMQka6ZOs3Pjy9Pam2l+lkMuqviShlpl1CY/L5PhixRQD4Fh0NyJu5cylHhDC7
	DrukRIoSUfYzHocWiRjWNbARBwKCiqUhFKmpfAl0qw==
X-ME-Sender: <xms:UJr6Zj2ZrmthRhV6FJGEW4KQityK2UD6Zs5zPdwqaLSlmnhOoomhcQ>
    <xme:UJr6ZiEpNimz7aX3Fkiugw2qLca3fuxgpQDafhT6g4IVdrs1zfY0C-7gutPUPVLJZ
    PZDUiJddMC6w0MQAg>
X-ME-Received: <xmr:UJr6Zj6Bz7QdhlBnf2uhA8sbwNzPTImrnQag2H3YcP7SLIz979aOUqM4qE1FJp_Xs-VyW2X2DtdzQzuASzJXfU61bPRw20izD7nKdNEaoPBuEiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsth
    holhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:UJr6Zo0ng5jc8AU7GoXqIxk2SDjQ7PmIArBo-i9wU5uqFXZuv3snhw>
    <xmx:UJr6ZmFJoL2ZRRG2o5i8_M0H6AolIWVi3KQLRSzVjDjyiNumkSWvqw>
    <xmx:UJr6Zp8AfwMW6_EGknAgwup1K1QuTQkoxjNc_P_c94XCiRCw8rAa_g>
    <xmx:UJr6Zjmv035M8oMg3YilCuSpC0bGjvRYtLO627ydRYesjzzQ6UxtWQ>
    <xmx:UJr6ZjOTrDm0HUSUtQ5a6l8ll_hJ9H2RlRYI4yZEeT6mCJKbZJXkpYtU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 08:32:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fd546580 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 12:31:27 +0000 (UTC)
Date: Mon, 30 Sep 2024 14:32:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: free hash context in do_write_index()
Message-ID: <ZvqaRIY1OzOIh1bc@pks.im>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <b6fe5b3ef7e5f4ac8cc339685d92e3ac39fcb456.1727696424.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6fe5b3ef7e5f4ac8cc339685d92e3ac39fcb456.1727696424.git.gitgitgadget@gmail.com>

On Mon, Sep 30, 2024 at 11:40:24AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
> 
> While writing an index, a 'git_hash_ctx' is allocated for hashing the
> file contents. This should be freed as the method exits.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  read-cache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 3c078afadbc..51845c2e611 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -3126,6 +3126,7 @@ out:
>  		free_hashfile(f);
>  	strbuf_release(&sb);
>  	free(ieot);
> +	free(eoie_c);
>  	return ret;
>  }

Yup, this one looks correct. I've sent out an equivalent patch via [1] a
couple hours ago.

Patrick

[1]: https://lore.kernel.org/git/c51f40c5bd0c56967e348363e784222de7884b79.1727687410.git.ps@pks.im/
