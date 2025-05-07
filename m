Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EB1D7985
	for <git@vger.kernel.org>; Wed,  7 May 2025 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746593856; cv=none; b=RBuFCjwgYldH81QgDsWeayj7k2L8dYw8ST9TLQLE5O1qqdEkmKJHe/tKOiFt25jvJ5IURfBBi2HTTj9sKGrONd0SueqyKQIF5Ji7On/XhU//PcpIs6A8xd57nGxfn1o8Th94UqOyw+wzER/8bfmNtiLH9aTcobYXFRrfVNY689c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746593856; c=relaxed/simple;
	bh=RXx3kHzQoXkMTe+/IgdnnZMAem6WnrL/QhieN7QWW2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+aOOXCUcGA/axXWSQhEYsZ+7p8xcfaQdDuebp6EOZk9fX9iAc/KWvjaJ08pCD7uv22AlQNFru3DlUbxabfdTFkzivqXeqzJwU9DaIm+s4m4WlHnmQUeRcjbVlK1pfjaxaVTyLA26xN9y/wV9519rwF0eyQND7we3R/V2Um+/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=igRZHZRr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vguebu/5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="igRZHZRr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vguebu/5"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FD051140237;
	Wed,  7 May 2025 00:57:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 00:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746593851; x=1746680251; bh=w31gTjPcxd
	2qc+F8HN8VZig6JPLBSI0MF1SGFCl/UZY=; b=igRZHZRrC8av5m1JuJikXxh/Tu
	+nsIGJqxXQMAa6Fxqs/+aZ3vwm5WJyJmppUPGfW2QX64b0tMv/LxX+W3Ky46cBMP
	yRJfwP3VYy9ixqDyy18kopeBr2OTuubOAsqafFdpr/FvvQA94sLzACnZgbgh2DfU
	1qYwxW3gFTYGr0IYj7iRDQMgx2JDoK3wI/g3JjiK5YPqK9FHU8+THWY4mR7eM0oh
	jOL5VRGLwRJd4Ts4hp6qKaA/rKZLMH++iAacbIDtnDUZmHDxrSo1s2lknhxNulZ1
	n0plzRPNfj6pOB2tEvmk++TLeSx4W5e9XOmEOFWFk8PlO7Gqfbk+T/Gun1PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746593851; x=1746680251; bh=w31gTjPcxd2qc+F8HN8VZig6JPLBSI0MF1S
	GFCl/UZY=; b=vguebu/5HxgSnBKMeOcF/Mb/8eIhiEiV/4Qkn1c/6dE7RsC1QB4
	WRoDve1y42S8IUItrrRI5qLQfsVgGNX2mvqyBx9e/rGXdUkzU/78Ow/nNHaYVR/v
	WCjX935Zi/rKNAlyGkgD1aehBrTzihssMCB2RMLRELDUiaEPB952nHDQZxV348Yb
	/oMU0PcrauFhyPD05xCVuCej2/ERWJNAsc+w+Z05fKA1sZvXHF7R0P5KMqJbaGQy
	I8fo9gjLIrZaLvV/WFJUSmRby4D3Vlol6j57AiGvvRLoRqm4Bt/bUaZE4xa+X/kI
	/N10fKqPc+xSCSIDzKAQgwSN17iiLBH6akA==
X-ME-Sender: <xms:O-gaaIryQe6vaL7oDTqw6rDlmdYA4kLFONeLa6SQAq12tmZdPU8pHQ>
    <xme:O-gaaOpcKj3niZtZWFyF75PEh7U5lxP-qxbJF4CiH0L6K2hb19GBm0f5qV4QpPnwE
    bK4FjZ-cerVo-c7KQ>
X-ME-Received: <xmr:O-gaaNMjnKVWmqO-XnUlXEhP-G1CCv9V0BSCSwD-p-0nOFBaMG-rULq-rtbkym5ieIMq5FGllSJOPHcYEi-TFLZDfntpTYYwsqp30M6lcXeYJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtsgho
    vghgihesfigvsgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:O-gaaP4-EhGbplPm-EeVSyT2aKx1XUKSjscHp-9S-4ciqfb-1NCvjw>
    <xmx:O-gaaH7KyDstjFvkHzwzYPTbU0HJc7oPvvik3xA0liSMqUDldYVpFg>
    <xmx:O-gaaPgHekvgBF4iB9PUO_GI33J09iVwFlee5gEkDPIGbA4cjhWrhw>
    <xmx:O-gaaB7GW6HgQ8VVm77hcY2oB2gvTX_hVIXEl63TbV7LChAZURc7dQ>
    <xmx:O-gaaE_DfqSVk2l1NsQC1U6bfZMFUuchBalbUsU-i2D-uytbVm3T4ycP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 00:57:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4b856f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 04:57:26 +0000 (UTC)
Date: Wed, 7 May 2025 06:57:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] t6011: fix misconversion from perl to sed
Message-ID: <aBroM9wh7Oo0xMU2@pks.im>
References: <71fcb24d-55e3-40bb-9368-5b47aa180993@web.de>
 <xmqq8qn9fj8o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qn9fj8o.fsf@gitster.g>

On Tue, May 06, 2025 at 03:48:55PM -0700, Junio C Hamano wrote:
> No, this is not about a quiz on regexp compatibility between Perl
> and sed.
> 
> Back when cdbdc6bf (t: refactor tests depending on Perl substitution
> operator, 2025-04-03) rewrite many use of perl with sed, the general

s/rewrite many use/rewrote many uses/

> pattern of the original scripts were
> 
>     chmod +w some_read_only_file &&
>     perl -p -e "regexp to munge" some_read_only_file >some_tmp &&
>     mv some_tmp some_read_only_file
> 
> persumably because the author new replacing some_read_only_file with

s/new/knew?

> diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
> index b6f3344dbf..1dd1e50d21 100755
> --- a/t/t6011-rev-list-with-bad-commit.sh
> +++ b/t/t6011-rev-list-with-bad-commit.sh
> @@ -38,6 +38,7 @@ test_expect_success 'verify number of revisions' \
>  test_expect_success 'corrupt second commit object' '
>  	for p in .git/objects/pack/*.pack
>  	do
> +		chmod +w "$p" &&
>  		sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
>  		mv "$p.munged" "$p" ||
>  		return 1

Ok, the fix makes sense. Thanks!

Patrick
