Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACB5680
	for <git@vger.kernel.org>; Mon,  5 May 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478678; cv=none; b=H/0ozC0/7eUm9XpnOajT/UC2w9cD6Liu5o6nER1+gglV9g646CoJswA573UtRAQmI6yypK7mjCXut1bi3KrxneZcOqtc+Ino+0HL8hnERv45RnH0ZVHlub4ZJzMxODHoIER2YvhdMdkaaO0Mebvcg+E4IvUu+GJuTs57xmJFey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478678; c=relaxed/simple;
	bh=kiPsnbRllHslZBKzXOWtKgJ75zv/8Zu2+AkWC7vf7Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nZ64RWjRCB2xB/vKagBp120C4EcfAO2CYwjhgSS/tRaPTmnwBE1O6mZUfAcI/YuxgxXCx1+MW3VlgTE1YqyFxOAsxj3U5+VJslZGnjGmGPeqPNDtD+4Rt+X5wAJDSf8uj2LIpwF6whPQR8bL8WKHf9nxtVCj0SUSevbx4rs6vBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=crwwTwfg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYiE921z; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="crwwTwfg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYiE921z"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 126D311401BE;
	Mon,  5 May 2025 16:57:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 05 May 2025 16:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746478674; x=1746565074; bh=Z6kI/yus5A
	k8gkSqbwwL/jNVZc/2Qt+K4Or7Bdlqw0o=; b=crwwTwfgGrafLMNS1WyEfGl1ne
	J+S3ynKBd1cDtXA1+OXmhWTj8+cgrWKDcCN87K02z2rvT4bGN6xnXTiZvcCOeRZ5
	1Kn1bvi0GPGBDeM3S/LyRBeDyy4Jv6xIHNiTWD8Tzbey0HmLbY7E5msL34t3Isir
	0Zw3Wl25AkLdoa0lnOvoFMkR5kf5PRbuAa39dMu2CZ2sv+2dTTgqj9hRmV5aeDPE
	szSOo90k05cd5VKIt80Hdisnza1VFgDi5P10vMdxCRpiGlJEL/mwHqmIGEqvpcAN
	n/c/eZEPxe9Y75qMcuVm4GgPCvDcgSQpd3Pl5/24tYYPCK5PoaofkZf0DJzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746478674; x=1746565074; bh=Z6kI/yus5Ak8gkSqbwwL/jNVZc/2Qt+K4Or
	7Bdlqw0o=; b=TYiE921zWyHk6AgWI/hr0G7//A0h64oJXpRGOfrW53VLgYDpmB9
	SPv+Olse5wVujweOWuSORx3fuleDrbKZlr8MC3WYgtsk2UDJA0U0poyOD/PXs/hQ
	1moBYu46VwIo17tutFE3v6+DBme9nPeQoZoGnTdPbB9rr37TuJe5MUEsIT04PeIC
	6RyyXyyLliQhiwW21vbbSTzSZ+jiOSSpS6noGHsR+q7xS9+6dW1LRl+3gUFhIeh4
	P2zxWNVtThpUw7TOFQrz3TmnKMOTXMGUNztMJAN2t+P8qu1C0cmEuWTn2VEybG8f
	n0VLKGO6/u+41uaDi3ZlxUcDgjSk1rIuj7A==
X-ME-Sender: <xms:UiYZaOqXnnKwPRhuGspu9PIdRFvGOQCKtDIOx2BDcmV1P_ON3abSfA>
    <xme:UiYZaMoGsYlXy_7S-qJExonJWp8-KuDhVXVqgCZxbtbts-XF0-u4qMUVZxmF-yyPo
    _rH-qB2icvp6MfOcg>
X-ME-Received: <xmr:UiYZaDO4ERKQWXro4IYVUqVBHgv7nGOZMk6itqclYfOJ0meqVLMj4o-3pBnsHze3BVTeJmwWqQ9_jW3qv60Inf0rRBuvlaelsjUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UiYZaN6r8Op1HnDJMw8rzqJ0Of_ilrnUZJ5EwwYuHxIhp6w69bEO-g>
    <xmx:UiYZaN5lznMmObWlsN4KTKbsacRkBElS5zqyqfzOJPDmFLiUScOH6g>
    <xmx:UiYZaNhv9as9BkbO_uFEm3c5MdkcgF_HVqomDh_jYdW_dfMXdz7Viw>
    <xmx:UiYZaH5AupcvOgv6YI0Nugk90vqnWbMDDPQlzRfeFz8_4n7EcC8V4Q>
    <xmx:UiYZaMIjg-hraUiX5rezcBl1jH7IOa0vRsB7BPfOkDmWxojXnyqVqvcU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 16:57:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] whatchanged: remove when built with
 WITH_BREAKING_CHANGES
In-Reply-To: <aBhhDAZTLJQTIQSC@pks.im> (Patrick Steinhardt's message of "Mon,
	5 May 2025 08:56:12 +0200")
References: <20250501225958.2947677-1-gitster@pobox.com>
	<20250503005814.3030099-1-gitster@pobox.com>
	<20250503005814.3030099-6-gitster@pobox.com> <aBhhDAZTLJQTIQSC@pks.im>
Date: Mon, 05 May 2025 13:57:53 -0700
Message-ID: <xmqqbjs6ojvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 02, 2025 at 05:58:13PM -0700, Junio C Hamano wrote:
>> As we made "git whatchanged" require "--i-still-use-this" and asked
>> the users to report if they still want to use it, the logical next
>> step is to allow us build Git without "whatchanged" to prepare for
>> its eventual removal.
>> 
>> If we were to follow the pattern established in 8ccc75c2 (remote:
>> announce removal of "branches/" and "remotes/", 2025-01-22), we can
>> do this together with the documentation update to officially list
>> that the command will be removed in the BreakingChanges document,
>> but let's just keep the changes separate just in case we want to
>> proceed a bit slower.
>
> We'd also need to adjust Meson so that it doesn't install the
> documentation anymore. So something like the below (untested) patch.

Thanks.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index b109d25e9c8..815b0334e53 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -510,7 +510,7 @@ lint-docs-meson:
>  	awk "/^manpages = {$$/ {flag=1 ; next } /^}$$/ { flag=0 } flag { gsub(/^  \047/, \"\"); gsub(/\047 : [157],\$$/, \"\"); print }" meson.build | \
>  		grep -v -e '#' -e '^$$' | \
>  		sort >tmp-meson-diff/meson.adoc && \
> -	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-pack-redundant.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \
> +	ls git*.adoc scalar.adoc | grep -v -e git-bisect-lk2009.adoc -e git-pack-redundant.adoc -e git-whatchanged.adoc -e git-tools.adoc >tmp-meson-diff/actual.adoc && \

Yuck.

> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index 1433acfd310..2fe1a1369d4 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -158,7 +158,6 @@ manpages = {
>    'git-verify-tag.adoc' : 1,
>    'git-version.adoc' : 1,
>    'git-web--browse.adoc' : 1,
> -  'git-whatchanged.adoc' : 1,
>    'git-worktree.adoc' : 1,
>    'git-write-tree.adoc' : 1,
>    'git.adoc' : 1,
> @@ -207,6 +206,7 @@ manpages = {
>  
>  manpages_breaking_changes = {
>    'git-pack-redundant.adoc' : 1,
> +  'git-whatchanged.adoc' : 1,
>  }

OK.

Thanks.
