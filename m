Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729113C801
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798214; cv=none; b=aMJ3J6MC+89bX49N+rWvzXrxJ1iEp59BmWH2USf7glWe2V5cwIbwMUgdGez5vK34BuSF2EN7a7gGe1vkSe+H/uqSwY23aOxQb7IxPMfjkSxQCQwLTenHCCxXsJQ9b0U1NHiPlym4PSRPvGdVNF5P6eIzNuvaX0m6Ai2RDeK28gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798214; c=relaxed/simple;
	bh=ibbDaUc2f0+N6kz+E/T90M6ax4b4Y6I08Vn0TlUQ/aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOJMpP6HpEbpnmWqKMzfE622B2VJZmaQlkg9jPCtxOHbne9H6OMFaGt/2xzmWFNJXCqhNrzExdAUbK8FMIXwTd6RWuYTZcJQQ33V0PYO2ZhFfpKIzleCceL7OmmBr8EV6d6+uycDKkM3fCd31Qecrm4pqWRSPsYEG+WLrbRWcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TkyA34+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UjYj8ps+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TkyA34+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjYj8ps+"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5101B1387A01;
	Fri, 16 Aug 2024 04:50:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 16 Aug 2024 04:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798211; x=1723884611; bh=sasIpm7McN
	fsPdwTdA993kLyJVqtgrPCFpVrg3syTFE=; b=TkyA34+pcnBbrA/OKCzA8i0Wo8
	gN2CE5ikIhZrLKNLWRKRrfgrsbW4mHOIVsluQN5xDmQbr+48jKf30MZni/eBuxRG
	fvgOzFhO8Tn5N4rturEGy0tiTGSA9bjMpVep5Krhz6gDM1yck60KhUZED6zv81BK
	i+hAZym/klEFMGVhpRjQ19At/MUZt39KkaFEX42+o4k89s1wGmCmiXUw6Fqh9m5s
	jclnDBByb2gnFnuUYdrz8F2C7d9M+1111+750eeYf4EbZwNkdqWFakthbBFduToW
	apsQab27LxWfxa1F+G+xnhZZyxoAlvmBIx/RcNDAbi4MnmzFWe1q7xw1450g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798211; x=1723884611; bh=sasIpm7McNfsPdwTdA993kLyJVqt
	grPCFpVrg3syTFE=; b=UjYj8ps+XPjD5cL/T28x7DRgkqLkRv8v8VjtePyCkPki
	DFU9F4fp0Ynm/oRauw1yzH2KKXf+zG6hHm9I1QEltgSyl2O4fEZ38GCOURuXyL7u
	xXz4pu/tZe+w310bWM5OyGgG+/98kc+qzbuEk+aQTLo7jMNxXmpbKE8KDhCOO/Cj
	siGippOfVWy51Q43e3J0JdPilr/zUV/9kUZhUHy/pK0d56Olm+ALN1hxt89Tz4gC
	yIj8HZ81XNSAKUTwk/YhakG7tPqkkzeJdVvh9vtiyrzn7HlsIGHloJxEgNQsK7BY
	cfjtNhM9DE2HZxCIf7QVRnQtarQ57byCe7YLPzAYrA==
X-ME-Sender: <xms:wxK_ZgXw2yLXcCZYYMSX6SIGqEAmWYCAlr6wTIg6P9txfKnFU4Qm0w>
    <xme:wxK_ZknM21ONxGhWf4X7iVLZSZNgMXvVJFSptwmVMl4hKTcLfifbh__fNhGLc_mTD
    xkhKZ1zaFv7EX6Yng>
X-ME-Received: <xmr:wxK_Zkbpy8YMLRc0Wd4E-30xSoHqONNdo6AJ98ZoUlReHXCr7Qvt4-SM01zzNL9atCSO6DClsmE3Do3K2zagdWExsZqF8Ughp0-us6FaXAEa7WE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtoheprghvihhhphhitheshigrhhhoohdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wxK_ZvWi0t34Tndz7Ch6QuIfXp2OYXQLBqfBVpmoIjiwTrWwo59PmQ>
    <xmx:wxK_ZqlEN52Oj6Vinzn4vYNRKbnHj32mtBQ5bxbume9w5ZL7AEOHJg>
    <xmx:wxK_Zkeu6vKtapAOIFEeBcJjj5zTwVwo2UYPRxYe5MO9tapNoQEfoQ>
    <xmx:wxK_ZsGPkfQQzyTPY34cBaMTpNPyIrabT9qQpXa_Xpw4OYynfF4iQw>
    <xmx:wxK_ZrD14umoO9be1Wu5QxzJhEcouD8wd3TpKlm7RdtgJ99EKV9M-aKj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:50:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e0ee540d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:49:46 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:50:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Avi Halachmi <avihpit@yahoo.com>
Subject: Re: [PATCH v2 1/8] git-prompt: use here-doc instead of here-string
Message-ID: <Zr8Sv9xZrdf6rHgg@tanuki>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
 <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
 <9ce5ddadf0bb13229461d67451094a373348771e.1723727653.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce5ddadf0bb13229461d67451094a373348771e.1723727653.git.gitgitgadget@gmail.com>

On Thu, Aug 15, 2024 at 01:14:06PM +0000, Avi Halachmi (:avih) via GitGitGadget wrote:
> From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
> 
> Here-documend is standard, and works in all shells.
> 
> Both here-string and here-doc add final newline, which is important
> in this case, because $output is without final newline, but we do
> want "read" to succeed on the last line as well.
> 
> Shells which support here-string:
> - bash, zsh, mksh, ksh93, yash (non-posix-mode).
> 
> shells which don't, and got fixed:
> - ash-derivatives (dash, free/net bsd sh, busybox-ash).
> - pdksh, openbsd sh.
> - All Schily Bourne shell variants.
> 
> Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
> ---
>  contrib/completion/git-prompt.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 5330e769a72..ebf2e30d684 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -137,7 +137,9 @@ __git_ps1_show_upstream ()
>  			upstream_type=svn+git # default upstream type is SVN if available, else git
>  			;;
>  		esac
> -	done <<< "$output"
> +	done <<-OUTPUT
> +		$output
> +	OUTPUT

I was a bit sceptical at first whether this produces the correct output,
because I wasn't sure whether the first line might be indented while the
others wouldn't be. And that would only happen if we indented with
spaces, but when indenting with a tab it seems to work as expected.

Patrick

>  	# parse configuration values
>  	local option
> -- 
> gitgitgadget
> 
> 
