Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA237BE66
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261783; cv=none; b=Gv1CkczhzEk8r0cZygUX6oTJynqUb/EN84YF76OpYgpgD5WQcAsNHeWEopHgZQ2aCldyoTVpvG0NN6+lQE5SJ6uAZICgPLvEYOaQI61PPhuZwt0vIzHe7jrlfgGz1w/lX4NJMwD1YzYbYwxgCAX6zYe1wbvHidKvWVmz0ZOeAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261783; c=relaxed/simple;
	bh=A8CZZGnALumgNzvjD07WLjz6qUhvfJl7TBwCQUQESEw=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PxufLXrQdNSIU7NbyYA1JdkmM/S47CQBj5i2Pq/a0HzTnYtnfB9n5/DFun0X0lsJ6UvG3EpRasi6ZBKZD6zuAe/FuVaBopOSpPg/kNehfPZZ8x3BKbtVmMpYLUM9ks2ah7A/mt+4Y2URLKB0ZWmZj7xJvGldn4jL/PfYhTmVp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jTDy4ScZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vqa5Q5KR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jTDy4ScZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vqa5Q5KR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F524140019F;
	Mon, 23 Mar 2026 06:29:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 06:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774261781;
	 x=1774348181; bh=XW2FNFA8S0h/JIh/TnC3z57KyhBmTFrq7WL/pCxPbg4=; b=
	jTDy4ScZ7gTY4LJR5dg1ZCajk74FWzVUJP8xXg5tvIPWPxDFAhjdisXtmgN5WMXx
	Jsh0PyZ30XdK6ei9OImjzOIN8Xh4o/huYFRf1hESLlH7M/TQR20nLt3OZgCbdG66
	f18+HAnbg9m1Ib59yza6wu8bQZsqGVCFNVPm88IWSVKUnPfryMwwXT9KVyNrcJoy
	ZaMjlRbZmXbsf1vCtJgNq0UViXoYmn7b5T45v3r+D16G0gfYXn6aixpKE4Ey3Ct1
	BCmJ1iSSHXe0c/Dp3vzowKuIppABNLiEG78dkmrGEiUMlvm+gZl1wi0iQoWvMwOo
	K1HbIJLB07oh/+cY1RI21Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774261781; x=1774348181; bh=X
	W2FNFA8S0h/JIh/TnC3z57KyhBmTFrq7WL/pCxPbg4=; b=vqa5Q5KRm7Ei5D9+p
	LookVuEOKM89FO7RGJpv6MSK+7/6ppEDKLQFZA8WkSPb9xD02AB5IKuELopx40px
	5q0z+J1WzfxXXljHn9RUcpfu8VDNVJUl8sjk9sABzDM941AI7iMuW08phjpA3SHw
	b76ytGFjQGqPxYRmyO8JfM76KAN52xKpn5aNpeQ1TMPgUspApkt2SFCS9RRdn7Zq
	R+7HFLDwMhwP8X7c71Ox9ZkITcetn/YOszOzxdokXKIjNSLpXhfghBGsd6DcPPvx
	QMiOlPYqSoJFC9c79tEuCw295DodvHsn4KrGPTOb2C7vaLUzidt4ICH4XiBy9T/M
	m5yPw==
X-ME-Sender: <xms:FRbBaRq101dmuisX7BzSMqoAXDFm997NOyn4CRS3jxnwxIvSMEaVvgc>
    <xme:FRbBaedLYPXKKXueEu3BxgpkqOD5nS4_4Zhi62EC__IuSLs7hDkxHuLv0w0feXwVm
    e7GjOl51kOJ_dwn0suGvOM8oGxfmSTzDkEf4lMDf7VoVwz7S3yjLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehk
    rhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdeigedtgfetgefhffetteeludevheetfeekffehheefieehudek
    veelveffhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrh
    hoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FRbBacWWPb8tyB4MqmnImoI3QR3VbKcLTiSjk8xloeuMrJwZYZYVOw>
    <xmx:FRbBaeh4JL6afCX9hXqVGaXlauEm9ejM6kkTKOod23BkYncAH9f_mA>
    <xmx:FRbBaX9ozkkSV_XGVNAjM86lEOD_ZEdKoHWQK4N6OGIKogP_os11ag>
    <xmx:FRbBaYCDcPPQ_I15TRjekwUwlxeBtU7c7PpCWLsDlgVH9cpls6piWw>
    <xmx:FRbBaT6Lv1NLM9qRdPS9t7J_jc3e_9yUy-qs9WQwlFwS72-oUQKOzKos>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 49F791EA006B; Mon, 23 Mar 2026 06:29:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1RdXUP4BKLB
Date: Mon, 23 Mar 2026 11:29:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Mirko Faina" <mroik@delayed.space>, git@vger.kernel.org
Message-Id: <73663cf1-3112-4e8c-a6ab-10a30670d355@app.fastmail.com>
In-Reply-To: 
 <7b1e5cbb243cf3421a4affd77bb45d31f3e7146c.1773959395.git.mroik@delayed.space>
References: <cover.1773530191.git.mroik@delayed.space>
 <cover.1773959395.git.mroik@delayed.space>
 <7b1e5cbb243cf3421a4affd77bb45d31f3e7146c.1773959395.git.mroik@delayed.space>
Subject: Re: [PATCH v2 4/8] docs/pretty-formats: add %(count) and %(total)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Mar 19, 2026, at 23:38, Mirko Faina wrote:
> When --commit-list-format has been introduced to format-patch, two new

The past tense here is wrong.

s/has been/was/

> placeholders have been added to the PRETTY FORMATS code without being

s/have been/were/

> documented. Do so now.
>
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
>  Documentation/pretty-formats.adoc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/pretty-formats.adoc
> b/Documentation/pretty-formats.adoc
> index 5405e57a60..67dc0f2a82 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -253,6 +253,10 @@ The placeholders are:
>  	linkgit:git-rev-list[1])
>  +%d+:: ref names, like the --decorate option of linkgit:git-log[1]
>  +%D+:: ref names without the " (", ")" wrapping.
> ++%(count)+:: the number of a patch within a patch series. Used only in
> +	`--commit-list-format` in `format-patch`
> ++%(total)+:: the number of tatal patches in a patch series. Used only

s/the number of tatal patches/the total number of patches/ ?

> in
> +	`--commit-list-format` in `format-patch`
>  ++%(decorate++`[:<option>,...]`++)++::
>  ref names with custom decorations. The `decorate` string may be
> followed by a
>  colon and zero or more comma-separated options. Option values may
> contain
> --
> 2.53.0.1018.g2bb0e51243
