Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDE21171F
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409190; cv=none; b=eLchhRIaHwg64fVUiZEoYfHgTtyqCyWBAFz/BfzfACbzGrH2TlSOz11WEbig+tWGA+IQ9ca0RYKtaLkPAmqoOxLmqMKwTy0ogsF4wm6EJltZLw1BRIAPxwG7X8/pzPyiURCynEYQGo4LlPWYknEz3RXp1LWi1AHgc0wHWV/5cWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409190; c=relaxed/simple;
	bh=ARqhzJykWllEvNdoMoDezG8zSPYfVPylDxmjc60uwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2aau2db3Ut511ZrKlq4h72V3yMGc8sIrgVnJYxSoenpw6muMoLV1bpEa+7Xz9WZ0PrircC27fiFqkLaIkebO3A0KsjFwFy9ZhZd6RIIlDSeoc5mnknNj3hY3iii6cmjniSmy/QkHcaPRTNEMWvy9gCDom2YhA5U3PceAJDKc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sAJFXv1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbfYeAZX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sAJFXv1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbfYeAZX"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16F33114029B;
	Wed, 23 Apr 2025 07:53:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 23 Apr 2025 07:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745409187; x=1745495587; bh=gQXgdfJl0W
	K8NRXabwiboqkrOLG1rrbT4On4vqFKcb8=; b=sAJFXv1Gd6eV+1o2qJtJ6C02bi
	eKY7AC7kQhOwG5oOPUi1t6nybExKkYzzpmBF4sFS5oM3zUrdPMXaUFzPRvQDQlNA
	11CEiKvWpjbxmXgP+USnfBQOojvG01BLkm2dWLJ1ZQx9P7iF2tHXb0wyMtaRerQB
	5jRUdy/gn1Wtfu3bsjYv1xLYZoF4m2VKSl0L/zQQUJIGfnN1G4CAaNfHFrtPNgo5
	ilJUQdFh4sOEDRhtOTXey9I7tSG955ZkadfRl0DWMKkOhXIrhpE+PMxbQkSuabLU
	vm2uFr/YtbqcIq99N3czwE3je1s/azH0hW+jH6CKgZGDxBTvJpGZzBJm6DZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745409187; x=1745495587; bh=gQXgdfJl0WK8NRXabwiboqkrOLG1rrbT4On
	4vqFKcb8=; b=MbfYeAZX3ASHbkatIzcdVqgMoiJwrwKPqumM96qISRreDYMuzBV
	xaYsRIxJJewn5OZBu617+9E93y1FwldsQwXYTyVTo8j5Qhb9gX2bLMpIhAKlNoM2
	pOSFtxC2hm4HlW18bOAuQ4DvPjwVEdKKoVFJC8Y7qsx13sKzYF9sZCHigr2eCDkj
	F2p6SAG6+MO1WuX+j7LEsxqeh7bflAE5HxqslVCAWePi+N+InU1IaUqbye5ub3Kr
	pYs2oLZeeP0ALcYoOiZrim//MLPeUQDlpg1t/4N6olCeTdDp/fLUD5RGEYudprHs
	/IDblEIIv2pqa9/AT1P0kExfdrwJUFu5ZbA==
X-ME-Sender: <xms:otQIaKU-C65VHeFGVEEYc_TQ1xd--K1RsMBwgGCDmqHCKyG0S2SEBQ>
    <xme:otQIaGkGJFOjz047ExbOLvCmNjn_uwq_rifQAeFaEljs5hTj6iebOpQiRySoy9N7y
    uotAniT8VfuefnZyA>
X-ME-Received: <xmr:otQIaOZoRbLkSL2FYHuivDCrRIHyDRTN57PYinEpT3o6BDXZKWmrcXKUD52ROWCiSmU_js5HUM9Luopa6nSJoIqqBITInlQfC3B_9GX1iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:otQIaBW6t7BmgeWjqB0Wj4bDuoAQ7hat-IFPlxsi0hK2STYaYj-3Sw>
    <xmx:otQIaEndCE21FMUY2ZtD7ArLGF7qTiZcFqcQtFv7KNh4hJB25b1cRA>
    <xmx:otQIaGdqyJFcsZXR38RnuIolVj5OsUsWrgrN3HDW4EuVBppZZeocZg>
    <xmx:otQIaGFpf_3ryrbG0BbmfkLdZa5Y9DwFNPP2m2-bwPp1Nb_7TMLodQ>
    <xmx:o9QIaMC2ETNAejHgxgsQbb_JH7WaNCLuT54pjjoQ6cffiTEX915HXSOK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 07:53:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87713ded (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Apr 2025 11:53:04 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:52:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] u-string-list: move "test_split" into
 "u-string-list.c"
Message-ID: <aAjUmi4ccemvO7XT@pks.im>
References: <aAetW0dan8S3Fljq@ArchLinux>
 <aAetv8l8jrxvEywB@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAetv8l8jrxvEywB@ArchLinux>

On Tue, Apr 22, 2025 at 10:54:55PM +0800, shejialuo wrote:
> diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
> new file mode 100644
> index 0000000000..0c148684ea
> --- /dev/null
> +++ b/t/unit-tests/u-string-list.c
> @@ -0,0 +1,86 @@
> +static void t_string_list_split(const char *data, int delim, int maxsplit,
> +				struct string_list *expected_strings)
> +{
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +	int len;
> +
> +	len = string_list_split(&list, data, delim, maxsplit);
> +	cl_assert_equal_i(len, expected_strings->nr);
> +	t_check_string_list(&list, expected_strings);
> +
> +	t_string_list_clear(&list, 0);
> +}
> +
> +void test_string_list__split(void)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +
> +	t_create_string_list_dup(&expected_strings, 0, "foo", "bar", "baz", NULL);
> +	t_string_list_split("foo:bar:baz", ':', -1, &expected_strings);

Could we adapt `t_string_list_split()` so that it accepts the expected
strings as varargs? If so we could simplify the logic in this function
here.

Patrick
