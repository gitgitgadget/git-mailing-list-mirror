Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBF1DE3B7
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772490381; cv=none; b=sr2Sbcbmi24HHq2LKP2UGp2o/toGTuyDMPR4Xlr1Chv+5ywEUvvzubq0lTNttXx64lRL4+KRw9GPDW6FzOtEfwTvrsopAs5AuQ9SW8L5eaIuLuw0Y2sjzMu6pHko6+ScVpiSDZXjDqhRFX6dNvOqq4yuC9E2ZUuNbd8KNeUbqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772490381; c=relaxed/simple;
	bh=+JYqkr2GdVcJZE8YZiRqIHNdJWYRxjY/lGfAqCEWb/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D0p5ffux4U3S+TzgffI+8WTTbog8ZLpw21nQCTW8fG+9YBlsOTnDNbQu/qCPgi6kNeSbpuhIDt13I7aLz0c4oIV8p8rr4Kojy5ZdgfY+ksKw0qAiHXluwaGKi3YKWaGg5yf/uwgcPaEQ2Tr0O8Dal5WgKNveQNYYvqRvufADpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EmoGcire; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZMZufADZ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EmoGcire";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZMZufADZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 10805EC0A9F;
	Mon,  2 Mar 2026 17:26:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 17:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772490378; x=1772576778; bh=1j45QVcD40
	fGhDOc60ZVjd1Bcv5WyahKHnJE5YvPFJk=; b=EmoGciredY6iQhawLGx2gxgEGO
	MGzEFWIQXhSqXPw21BoGAftY8YpZekpcc1emBNdNc9H1p+1kHj3aY3+R3vhXJlNE
	TpgkwompHP7zPacEdyBYPCaqkhOmzdfo/VCqOnImWXCyLgi2ibcrtkSYEWYddJAl
	1ZgnESsaFw9QBx3Kcn/cy10Gq6EkXEde2d0uoC80fT7sDboKpqGWXOwGg+HDIIMX
	7yM7CruOg/Fh0uB+8v1xgllZ0DX0XUye80dJXOVpOuvHGrTIQoOAJ4AEn02y67ik
	8YDuxF5XXfyEqz5c0Z6Pd73li6OLU1WqDgfu3e8TzaOSo2l7EiHMBNyIohpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772490378; x=1772576778; bh=1j45QVcD40fGhDOc60ZVjd1Bcv5WyahKHnJ
	E5YvPFJk=; b=ZMZufADZEVxaLTGJKieCOh2IoLI2EaBl6Jw5hq2kW8LxOv0VCKh
	o8lgmKJUPWWpqpfTmbw7i7NuydLmGG1CA3xjcG+hL+b5G5AT7jTzEoA1GZ/2HQhd
	vE+rizuzyOLEwVo29caHJWsWtTCZMO/puhxyNEAXdS9j0xrPDuF4YVPjCWwQMR/a
	KVfDwZgRgzUlYNfiJDMBpSwD1UeH9B8V/TrNjZLxWIoCY/99e2taARmbw9Gj0/6O
	2wudFiss8rLJSGX5QaeIz9grNFsW3+OGBFWho7TIYNAW9OTlSG1622biwg79whwx
	4vskPIL0SuMeiJYO7fqZpFLw4erbzlMe2fw==
X-ME-Sender: <xms:iQ6maTehDHd0KBoIr4eDMxnAAOhCvRCzqz1CNZa7r4AAmkQGhhEG8Q>
    <xme:iQ6maQPPGr3Ze_dAGNsnLXfgopqTaht1G87eLKuv2Yn6otddPjntxl4m6tI5HfyIR
    MYDFAq3I-OL1_fe9ZFr2bSlR6nxjZfpfEhlhlQBvO0uaToaztAQEQ>
X-ME-Received: <xmr:iQ6maRjkFHmmyc6EO2QmGE2ku5wONZsKjz_yKqxqCY00TIkDacHce3y9mVPTnFiSqfFre2WH19MeP4zU6rVAFUKO9Pa0w0SioA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iQ6maT28EkJRXhfun8sCFUCTz9bj8dJVJl9Pqj98WKVocjh9_S2YIQ>
    <xmx:iQ6mabgplhLymEEJvSXL2dqdC92kGGf3KmfBmXzKqlX4yg2MlLPntw>
    <xmx:iQ6maTdhoScac-xQo9E6PFIpvETR9Y--OjdvTFh9HZAngebZBE-5mg>
    <xmx:iQ6maenhrLWCAonej-Qrtt-nFzwO1y-R44MbImxf9lMFytJNqH8DUA>
    <xmx:ig6maVAYHYbFdGXvBGECJOS8KutAdwOTzdKd8HI9nkwMp7-lvN3cheG1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:26:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/5] builtin/rev-list: migrate missing_objects
 cleanup to oidmap_clear_with_free()
In-Reply-To: <20260302200018.75731-3-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Mon, 2 Mar 2026 21:00:14 +0100")
References: <20260227234213.17633-1-kuforiji98@gmail.com>
	<20260302200018.75731-1-kuforiji98@gmail.com>
	<20260302200018.75731-3-kuforiji98@gmail.com>
Date: Mon, 02 Mar 2026 14:26:16 -0800
Message-ID: <xmqqbjh5yik7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> From: Seyi Kufoiji <kuforiji98@gmail.com>
>
> As part of the conversion away from oidmap_clear(), switch the
> missing_objects map to use oidmap_clear_with_free().
>
> missing_objects stores struct missing_objects_map_entry instances,
> which own an xstrdup()'d path string in addition to the container
> struct itself. Previously, rev-list manually freed entry->path
> before calling oidmap_clear(&missing_objects, true).
>
> Introduce a dedicated free callback and pass it to
> oidmap_clear_with_free(), consolidating entry teardown into a
> single place and making cleanup semantics explicit.
>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  builtin/rev-list.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ddea8aa251..ab5f69826c 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -88,9 +88,19 @@ static int arg_print_omitted; /* print objects omitted by filter */
>  
>  struct missing_objects_map_entry {
>  	struct oidmap_entry entry;
> -	const char *path;
> +	char *path;
>  	unsigned type;
>  };
> +
> +static void free_missing_objects_entry(void *e)
> +{
> +	struct missing_objects_map_entry *entry =
> +		container_of(e, struct missing_objects_map_entry, entry);
> +
> +	free(entry->path);
> +	free(entry);
> +}

Unlike the previous iteration, this makes the claim very believable
that it makes the code easier to follow to have the shell and its
contents released together in a single function.

Looking good.

>  static struct oidmap missing_objects;
>  enum missing_action {
>  	MA_ERROR = 0,    /* fail if any missing objects are encountered */
> @@ -935,10 +945,9 @@ int cmd_rev_list(int argc,
>  		while ((entry = oidmap_iter_next(&iter))) {
>  			print_missing_object(entry, arg_missing_action ==
>  							    MA_PRINT_INFO);
> -			free((void *)entry->path);
>  		}
>  
> -		oidmap_clear(&missing_objects, true);
> +		oidmap_clear_with_free(&missing_objects, free_missing_objects_entry);
>  	}
>  
>  	stop_progress(&progress);
