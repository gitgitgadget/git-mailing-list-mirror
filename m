Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D02309A7
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624844; cv=none; b=AZ6dX+iubrmC9snYQN18HAFvzUghApxxIVdBMrPiZv/v4R30d4G0PcUU0ynC6tiIUEfGN07dxKl5mzqGedxDOkUBVXWCqnrR5ZYLwiD00eNw6tPBgqq//DF34kUndDWVMcdxzXKGhcD8AOd67DJYo5JgKNNVKfepRytGiM1xzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624844; c=relaxed/simple;
	bh=nPsd3vjuGwJmK+3XlBLffSGKpMtWJ/yJDX4mNG7tM24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ImTj8ft3FgGYhWF4TMjII+AB3skxD0BsHNUQ1iWewcPuZl9vssXMXgp4vBeST8bekG0NS7FPmPlXxSWewbwWRCorDyjarH8miYZNLVx/woAIUbbLwv3YGmd4UQ4lIfd7ccWTybg+504ROOtYbGBIE8OPv82MsVM+/ixUaU/ehqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1WINHXw3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0CP+pdkJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1WINHXw3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0CP+pdkJ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7112811401AC;
	Mon, 10 Mar 2025 12:40:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Mar 2025 12:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741624838; x=1741711238; bh=nnUwqQh0b6
	iLQTI9dYTe/4LrguNEmltDk+xWyUBIG9c=; b=1WINHXw3pYsNlnLdtmx9UgKqxw
	dMuifRXsPnM8CWVs8zxJwHdvKJbclGb9ON9KfTk7XotxdEaHu7r6RWTpLB1qWAJo
	Z3bfwM68tUj+jlVbzUYDF9nJfE+4J+X1DmHgs1D2vDmk9QEiJqtz2VTXmww/NHiZ
	ErJe+awMfVRFSaW7zhRvmt+LDt+DjuCzBp8KljWV7nE1+b0rDwTNRme6pTVZ3F8/
	wk7FLY3ftUkX7IBQMwsAMUpIAdXxFwL0tlIQrYgTh9/45M5QfJIoNxf26vF1xK8c
	0Qvp3dyngLv6V6yFad+fSGjZIGClA2g3jsPWPB36+DwVbRAf2e86ygSlkhWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741624838; x=1741711238; bh=nnUwqQh0b6iLQTI9dYTe/4LrguNEmltDk+x
	WyUBIG9c=; b=0CP+pdkJl5YBXXS938iZNxunkjU/Oj2Kuqzvax3wNrV+1X1jLLc
	O1BR3LnLmtVJ8qJ6gIYHvW1qvUIp3IaahSiJ0HdvWR2+PhJZEz9M6HDNnX1OgH1Y
	41RHNvWye/OWisJtbMib85BOb3atnBHP1m3QmAbtwDyr5Xpz+QcqDsRewCbP2pvE
	M3xtQT2peFkdzGtQA6sdN3fGTAoamlEaBPdfEFYNM7ax9kYJy68c4W1AOXG+I4t5
	veuprXg8Eh+dyaQG9j/kuMqvgzdfhLTBYCvj/3O43s2jaOE/Sk94ip4WLD4Yzklh
	H8EOHaPCpGf5Q5Mx6k0t16ppIJBtmbpXPsg==
X-ME-Sender: <xms:BhbPZ811B8QiOhxpfKnybSW-lIq8AiFL6eSYlYDFhbOvVGZnTxnWnQ>
    <xme:BhbPZ3Fy9dHxR70yYf01K97uDTY1JBcrw9Ss0cnAuenVaBoBproRerzIbNQkqFYUO
    SfbEioVqRN-K6bhuQ>
X-ME-Received: <xmr:BhbPZ06Y319tZadWa-Vl0vouIu792fhg9E5V929oxR5fLJyloO8Wbx-_i5ljysKtekMIUFcUB7msP59-RjEbGmhoC0ID7EbIm6tF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhrghtvggrrh
    hnrghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BhbPZ11Z1QVuyAusVaPluKDHndbTrbgT2kIXNBLNd_ntCG-ltg-sCg>
    <xmx:BhbPZ_FeIG4hWyrTvqZH6_y9CCh_O4QqX4Qki2jsYopL90bjltEcEw>
    <xmx:BhbPZ--OJ_5pVI4OcPCXoMjPxfUXV45nAaqCg-gRvM7nAPJCQAnNTw>
    <xmx:BhbPZ0knNDo23_gHpSm2dXJmzz3Rv22jodY6WIiT2ZekIMj9XXcjqw>
    <xmx:BhbPZ3BDE1Q7cCo2ChLrDus5TzMUtBqtOYwEbvJ4zaX0Saou-AxhNvAe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:40:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Arnav Bhate <bhatearnav@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] decorate: fix sign comparison warnings
In-Reply-To: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com> (Arnav Bhate's
	message of "Mon, 10 Mar 2025 15:21:11 +0530")
References: <afa6b428-3190-42ae-9eac-540c95b576fd@gmail.com>
Date: Mon, 10 Mar 2025 09:40:36 -0700
Message-ID: <xmqqikog96uz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnav Bhate <bhatearnav@gmail.com> writes:

> In two instances, an int was initialized and assigned the value of an
> unsigned int. Then, the int was compared to unsigned ints.
>
> Replace int with unsigned int in both cases.

And these places do not use a negative value to mean anything
special.

A simpler fix to the first hunk may be to get rid of the
intermediate variable altogether and always refer to n->size
when its value is needed.  The compiler should be able to see in
this static file-scope helper function that n->size would not change
at all and do the right thing (i.e. allocate a register to hold its
value at entry, if needed) without a hand-optimization we see in the
original code.

The same can be said for the second hunk.  The intermediate variable
is used only once, and one could argue that its presense obscures
the condition under which grow_decoration() is called by splitting a
logically single expression into two.

Which one is easier to grok?

	unsigned nr = n->nr + 1;
	if (nr > n->size * 2 / 3)
		grow_decoration(n);

or
	
	if ((n->nr + 1) > n->size * 2 / 3)
		grow_decoration(n);


> Signed-off-by: Arnav Bhate <bhatearnav@gmail.com>
> ---
>  decorate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/decorate.c b/decorate.c
> index e161e13772..8d5774fcdd 100644
> --- a/decorate.c
> +++ b/decorate.c
> @@ -3,8 +3,6 @@
>   * data.
>   */
>  
> -#define DISABLE_SIGN_COMPARE_WARNINGS
> -
>  #include "git-compat-util.h"
>  #include "object.h"
>  #include "decorate.h"
> @@ -16,7 +14,7 @@ static unsigned int hash_obj(const struct object *obj, unsigned int n)
>  
>  static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
>  {
> -	int size = n->size;
> +	unsigned int size = n->size;
>  	struct decoration_entry *entries = n->entries;
>  	unsigned int j = hash_obj(base, size);
>  
> @@ -59,7 +57,7 @@ static void grow_decoration(struct decoration *n)
>  void *add_decoration(struct decoration *n, const struct object *obj,
>  		void *decoration)
>  {
> -	int nr = n->nr + 1;
> +	unsigned int nr = n->nr + 1;
>  
>  	if (nr > n->size * 2 / 3)
>  		grow_decoration(n);
