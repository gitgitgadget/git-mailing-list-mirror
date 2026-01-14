Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25033D6E8
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431009; cv=none; b=ednB3nLUq+RVDGBJ0ymc6cdZs71fOZwPQkSlDiFbqnXpC9Ylj4rBN7vFCGxFW8BRAbPBFnKeIIfChDnvZJzVbwQQqtayLVjnsbN4PXJDGVrVEby0BtYiu1b7FC9BecW0fW9AEIARXNIfSDq9Au0g/YWu4Xf63niK0mTykPV2vLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431009; c=relaxed/simple;
	bh=CrvvtBqAc28y4tg5ndAKoMNFeyCKZ6Rww8lWmzrqrfk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CDkGIGtPQo7IFuEKT/oB/d4HINCBTxR3HZsxL/GC3ajBRWdtCs3ec3WUb/7sww03OYTQ1L8faF/4foPsHaQDLkYlyWinV12cMZZtM+MYGkHeCO1WpVIMTGfQjWlyYVvlNsgrDBcnIYPokuAmDFGNrCs+zcixF9M374/7dWiO5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Os441Rn3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dljDPUTt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Os441Rn3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dljDPUTt"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBFBE7A012C;
	Wed, 14 Jan 2026 17:50:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 14 Jan 2026 17:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768431004;
	 x=1768517404; bh=/MnuYKoFVuPtQcX8lGfrdWisOlH1Z9h+WKZ2AZ1j4z4=; b=
	Os441Rn3bo52Mzr1NhSoVgwNM3EfkM8vOfAbno83+bVQmyLYDQZqxeuryKurEUwR
	GJmmlrLeE6Rx1xI0s4Cwc5KmTxyj4p4EbUBgT1yvMh0OM0SUVr8vNJd7W2LdpC1m
	UhrTN9GXOaRF/5v+IOjt926Yoys58E+QKrxdIBFiWr1/AR/WmrDD8Fd1Tgp00C2h
	eddgeAQMqhhIcfqrxdeekbMNz9kM9PWhcaNSbeRwgT+6J0cUyIhjeUCIZIX8iEhI
	hgPPThREsmqbYAriO8YiIte4+OsJBKyW8YhL4MAbsBIkWO0lfc+OMDmvebH/rATY
	Y1kDxFyYjFEBU4JFODwdWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768431004; x=
	1768517404; bh=/MnuYKoFVuPtQcX8lGfrdWisOlH1Z9h+WKZ2AZ1j4z4=; b=d
	ljDPUTtPRLN7WIyFfqzgK1N1qsMrYL+kg2X7/EM4Qm9Pm3BMr/w3ABYerUc2XFq6
	BrTzUHqTPqX/rf/yUl6XY5Dx0JBnrxTICNvbB5oQdEhHgqysuc5QT0nQmWRP05vZ
	mRVq3fuHm/e+Lqarabuk/CoQ0cRMBpuq2gVpl0Ch5g3HBOCkmpB+LelclKwlGSaf
	6CYbLl7/YGMe9i2OBIHdJJV0YxG3YyLMuTkum1T/BidU0Sg1gvDxkmkZNNEEXL21
	sX8+pXsY7qoGpYtVzXu8aAh1zm0WyEHxSkoFDFRg/3mvvYd8LI63SFk1FIkmYcIs
	5XccUY5AptIMSN/uRVSyQ==
X-ME-Sender: <xms:nB1oaVTq0phcvGp32xS3kOh9WGXDKPXDyoHjdle1oKnnvKfAbqfVTg>
    <xme:nB1oaWM1lx_7XAmC2Kokvkk0eVfc0DeBXpa3ZXUW7xaQNxbUJFPBnorbqNW_nzbkD
    WuOsjoEYUjpMAgrG7_8ULgfqkuWh-SUYDu2jwDnCBw3AJis2jgAYQ>
X-ME-Received: <xmr:nB1oaYO1GpPGnzpwYRzlJKUgQ3SbxS0bv8msL_mAGkhkEUgQC4wHKZPkSMP3c0ccLYDMESXLdhMg2Y5wP1KjgmtqexDHaN_QRxqZQHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeggeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorhgv
    nhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:nB1oaWt-AXmvj8dCzr8w5jNYMhPURgftfnpjrdlMnpeKr2KCrauyGw>
    <xmx:nB1oaSVxPJxnACgMjAqIVwggaZT15VOWnKkzzk8Z3lJsJ-G_WbUq1Q>
    <xmx:nB1oaevrEELzN3YfiBPSvFiYIOXcunK3BfDDZRGPPwXPg8HqTzB4SA>
    <xmx:nB1oaeWeoAkWLYtExECPV6mqokNq0JBiLzsAPUFy38hQ1HDIK3Zd_Q>
    <xmx:nB1oaWNZlSkRO8nDpjc0ajPVTccT_H_zdmENX8xrbAVJvIt_Rfl_TiSU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 17:50:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 1/1] diff: improve scaling of filenames in diffstat
 to handle UTF-8 chars
In-Reply-To: <aWgYRkv-YsuekdR_@lorenzo-VM> (LorenzoPegorari's message of "Wed,
	14 Jan 2026 23:27:18 +0100")
References: <aWgYRkv-YsuekdR_@lorenzo-VM>
Date: Wed, 14 Jan 2026 14:50:02 -0800
Message-ID: <xmqqikd3ermt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> The `show_stats()` function tries to scale the filenames in the diffstat to
> ensure they don't exceed the given `name-width`. It does so by calculating
> the "display width" of the characters to be dropped, but then advances the
> filename pointer by that number of bytes.
>
> However, the "display width" of a character is not always equal to its byte
> count. The result is that sometimes, when displaying UTF-8 characters,
> filenames exceed the given `name-width`, and frequently the bytes of the
> UTF-8 characters are truncated.
>
> The following is an example of the issue, where the 2 files are "HelloHi" and
> "Hello你好", and `name-width=6`:
>
>     ...oHi | 0
>     ...<BD><A0>好 | 0
>
> Make the filename pointer move by the actual number of bytes of the
> characters to drop from the filename, rather than their display width, using
> the `utf8_width()` function.
>
> Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> ---
>  diff.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Two comments and a half.

 * The change needed for this is surprisingly simple.

 * You already know about samples that may exhibit the issue you are
   addressing.  Can we add it as a test case somewhere in t/
   directory?

 * The NEEDSWORK item addressed by this patch is one of the two
   NEEDSWORK items added by ce8529b2 (diff: leave NEEDWORK notes in
   show_stats() function, 2022-10-21).  Makes me wonder how involved
   the changes would need to be to solve the other one?

Thanks.


> diff --git a/diff.c b/diff.c
> index a68ddd2168..271ace5728 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2859,17 +2859,10 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  			char *slash;
>  			prefix = "...";
>  			len -= 3;
> -			/*
> -			 * NEEDSWORK: (name_len - len) counts the display
> -			 * width, which would be shorter than the byte
> -			 * length of the corresponding substring.
> -			 * Advancing "name" by that number of bytes does
> -			 * *NOT* skip over that many columns, so it is
> -			 * very likely that chomping the pathname at the
> -			 * slash we will find starting from "name" will
> -			 * leave the resulting string still too long.
> -			 */
> -			name += name_len - len;
> +
> +			while (name_len > len)
> +				name_len -= utf8_width((const char**)&name, NULL);
> +
>  			slash = strchr(name, '/');
>  			if (slash)
>  				name = slash;
