Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B51E8324
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291547; cv=none; b=bA9tkBBADFlgOe5pg5vJUsMOKAKcZvM7smIy5WQ4qlfCRiTAjWfBSjW6Od+MoqXD6uxTiNt4LmWu2W5r0HRYvsoUrxNTBqEqKQFt+MgayaxPqOYsuDhfqsYISeOf1qksLUxYenj6inydgmkzgdGAOm8qX5ALlOyDx38aVgZV+60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291547; c=relaxed/simple;
	bh=qgVYzyGey/FPz8gC3q6VJ96ze1ARWOz2ZPAIlXdsyns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oyVaZsPawoV/py44xlGQazKeilkObzg5Ba8A/5vsy0GNxj9dTvFOF3PvPCeZx0ma2Hzj4xiHy5B+lDqSgfS9J4c03UfN2Mp1imP8FJVsna5u/YJmStd28R7eDIP6OmlGEgmOLfr0E0LkcubG1+Jc2AsgWrIWCrksIF6CwOnaXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S7mRPHgz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hixv9Yi9; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S7mRPHgz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hixv9Yi9"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C4865EC03A4;
	Wed, 23 Jul 2025 13:25:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 13:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753291544; x=1753377944; bh=2KmfyykWLz
	qVBkBvP1SX/P5iICS97cCr8ruoeUYllHo=; b=S7mRPHgzgY+PQaGoZiN/cMbbda
	PsdPo7KS/HfUx8ZKAutyu63LurLEGiTvUFw0WNNMY/jd2b6Qvz2ZEjj0PL6OBh+d
	93cu3CUelE1TiedGcL/0MZMiXGdvrjFhx9pGQhZ8Id5cyUedL/Nn6gum+kNIBB6l
	nFh6k2iUT+W7XZNISaTwh9LQ1+r86y0Gw6GwfOeoL+W0HVl8GXw8vzq34yP5rNPV
	jpkn1VnpTBmpSM66JYXWZ1x9Dy1tfwLNyPeYk9RoTKk0n/lRxMsPanqQx9A4MH8j
	755rCTXHbUmvbBn5kzer+ClBCQOfbS/Yvfe0wpmtKtHZEk0hwj5ZkVtHt2ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753291544; x=1753377944; bh=2KmfyykWLzqVBkBvP1SX/P5iICS97cCr8ru
	oeUYllHo=; b=hixv9Yi9ZigRDmDcLsOH4ltzSr2LcN4l0eSbLoZz3BG7ZRJBJAY
	r7OJJH08vqmi2oFqvWRH0cumZgSkPyoBBUB5KqhwpnTRhH8xqjyi4PIFMGiWkT1v
	rshhijvng8Sb2yUy0sRE8nHJ9U4AOCFnTl/WwsJIjkcO3lJsvuYcx+CTaZonyZws
	af2pNCqdUdRYghuOF+wJEkbLu2FqHHYlMNZfNdv1nT8XPR/6SoYz7kmmLnA0pIm+
	4VaTH13yyp5qGpRx5k9Tdtrw/Rlby4BYE+sIVBDbvi3CwPltbbSkUQuGpHUFQK9r
	59zQnfANjacTs5ebOcSM7LL6YpLmBhrZIXw==
X-ME-Sender: <xms:GBuBaE81LEdaFoWo0O93_f7P8Fyi5g09QFgXrvQBqqRurwydeLdvvQ>
    <xme:GBuBaKSIz5deUma0VMSu6VdwHauBwNesAmGrQC05-VjxygQupXIESk1rtnxjJ0jFF
    Yx6bUeQ4J79vOwTng>
X-ME-Received: <xmr:GBuBaAf0_9VNM5-4uavrq3cIxUriWy8JfqSPy3QDkkvh5AfjMiE3xr-NcEz-OX03uhzS-iH1elQRQAlgkqS3-yA5Rym6egOGjWULMBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrh
    hgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshht
    vgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GBuBaGAFYmOqgPVBCbp-aNnp2hT0tZ8AbasXyh6RaYfgSaH055A0CQ>
    <xmx:GBuBaKnpXejOeUpXWAI2ytLTT7C9IedhUlx1GGb23x_pMcr4cbE8Sg>
    <xmx:GBuBaJeukLnBdcJyuZHXJ8uuhayEh9TZ7vDFgb_mnVKBu47gYc8MQw>
    <xmx:GBuBaGT7EnMWDMqm3Gp8rvS9UGu38QffJ-6dc3X2J4t767uSl4g5ZQ>
    <xmx:GBuBaFwG21jtFxp8zmmVxIdSpEe-tjmEqhiYwdYizs_eYknWUspbiJ-U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 13:25:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
In-Reply-To: <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
	(Aditya Garg's message of "Wed, 23 Jul 2025 12:29:10 +0000")
References: <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
Date: Wed, 23 Jul 2025 10:25:42 -0700
Message-ID: <xmqqecu6om3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> +imap.markAsRead::
> +	Choose whether to mark the sent message as read or not.

Is this something user typically want to use a single setting,
or would it often be per invocation?  Especially with the new
invoker in send-email, wouldn't it become more like "if I use
imap-send to stuff things in my outgoing folder, they shouldn't be
marked as read, but fcc copies send-email stuffs via imap-send
should be marked as read" or something like that?

> +	Default is `true`.

If we never marked these messages as read, then this default is a
breaking change, isn't it?

> @@ -47,11 +47,12 @@
>  
>  static int verbosity;
>  static int list_folders;
> +static int mark_seen = 1;

IOW, this smells problematic.

> +	if (mark_seen) {
> +		ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" (\\Seen) ", prefix, box);
> +	} else {
> +		ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
> +	}

Why so many braces around single-statement blocks?

> @@ -1702,6 +1710,12 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>  	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
>  	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>  
> +	if (mark_seen) {
> +		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, CURLULFLAG_SEEN);
> +	} else {
> +		curl_easy_setopt(curl, CURLOPT_UPLOAD_FLAGS, 0L);
> +	}
> +

Why so many braces around single-statement blocks?

According to

https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions

CURLULFLAG_SEEN first appeared in 8.13.0; INSTALL says we require 7.61.0
or later, so this may be OK.

