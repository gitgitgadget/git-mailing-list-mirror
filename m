Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45E19E97A
	for <git@vger.kernel.org>; Sun, 21 Sep 2025 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467175; cv=none; b=lw4yXH29cwtjR+5MDcMHBWayIVPcqZxoc8sHfiq+SAWS+biwBsq1E6dQfBwubDEnJwx4yAUtZ0rUKcUc+FeYB1LI6hYJ/Mo5Wv+MakNgaPLqwys0TCL/KDF8VUIT9SGXjwGcKLP+SHuE3REPWGuWoDB9XBsKJTjpsI+8ILQ2A0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467175; c=relaxed/simple;
	bh=WHQUJG2I+J8OFNFZqyRge1gt+zrmYOK+O/Dg8L9U6Zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MxFpSEY/v5nDi2h5lz8Yp81Ps6zJvV2yxVGRLo7zh5klgYf6yULsM616r6zOkjZ0Xjt5hT819RmpZDS636IMAjL7G7h1tF2oMFAVwjIR5VfWb1qhkKp6tXyzCupi0dBKfaOBP4r5zGoY+AZy3jSRXDR5yqD4FRI1m5E82CkX2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JSDu9M8e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nR1K1nXG; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JSDu9M8e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nR1K1nXG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E2A057A009F;
	Sun, 21 Sep 2025 11:06:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sun, 21 Sep 2025 11:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758467171; x=1758553571; bh=ODeWQYRqZC
	Y5N4aEnsuPyhm3003uEDXFJJVhtPeQpME=; b=JSDu9M8e2DKCp5/2F6TUj+NwAP
	IMiL1JIJY3LvsfWkMbGB1KIQ8OFqUnrmPe144xNw1yMWesh2Hf61Oi5d+j2sQYPw
	kxOcxBWBvQeUUXQexL2ghbiQc5u+gGFA79uG76Hh6J9HS8W5ERAArwn4p3kBqKMW
	bR1zKQxNRrRuFVKE7sPJr1dipjO7gkC+WehF2+vVhEpRnxun6HST4ZzCAH8lCp/D
	MOGdzpC2fDVUpzD0urQZKTGMh4a8kw5bsUr5fwtUWNibSwUXFqWqwqYxg8O5FQqn
	JNb6Y9R7xHLScfHYp08/u0J42fc4Xgmrc+dd32c0uS7TwO8h+xKOaXmjqxXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758467171; x=1758553571; bh=ODeWQYRqZCY5N4aEnsuPyhm3003uEDXFJJV
	htPeQpME=; b=nR1K1nXGC3kkrAW3uVSfJkcbR4kClRAIaJcJKJhL4nC4ep8zdhz
	uPbC8KJq05DNssSgG42KD5LCqc8C98sTCaozOIs1Og3h7PfyNeOP76GzYpF5ONbH
	1j+a+L2hWkkoG/aRDnFKtLRHRpWS/lj/+DH2Sci8PZGzod1p0IEvgWtDkmEGXFRh
	PyLmsr5WFiojf25X6Dv1xSTibftqcR9AcnAtAAOdGw7GzbfuhLF16lFU4rJqu3eZ
	eiZ+2UBRxNURWe6Ur4EkI+buMnzWIydymxFyMEruGOZ1MmGkPj62XvJZI0BlWFC9
	m0ycOxIyKk7bQVpnv5Hh5jNOHKD9GFIUwsA==
X-ME-Sender: <xms:YxTQaETDq594asR8IY4Cb0xG5A_1ypJ3huVE49CEcOP0o5aLwKp3Bg>
    <xme:YxTQaMVJK7ZVp0X955eOfndf_vGKiAVYAB-J--OL--Aehb8qTb5lgXXrpNsBAn3On
    mIRZzfROl6niaga5g>
X-ME-Received: <xmr:YxTQaOZ0cSVcNdHnPfPOfGhic2gQWjxI0KU5MDg04ImbTy6-7GO7gfFWaLHiYWYhk-U31QiIaDxc2a-QVTFi5qxH9dTDrj_SRfrm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehhedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YxTQaK2fnsUsd3OokOkxnHA54SQnmJrn4XgqJmO6fF8NVdqIuRbeMQ>
    <xmx:YxTQaIi4ETBc2CXw8NqtyiXsYsgKDl4XoTOJfSm64SQ9jXhbOcwgJA>
    <xmx:YxTQaGbVoPhskAJ9o-YwZaqxoM-OtKUNIfuv4BJ2nSlYGMgnTVMzXw>
    <xmx:YxTQaARnaaV4sMAruuIxOX1nExg4Q41Q1mtkguZ-3ySFYSPlRup8Uw>
    <xmx:YxTQaJvxtIMGlGJceWQ8QvAbOHgZyVth8bOVId8XxGpz0Q1X8gogzSu9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Sep 2025 11:06:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] imap-send: be more careful when casting to
 `curl_off_t`
In-Reply-To: <e1d5a85f70c514749304fe87efde271e9ed5a92c.1758457356.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sun, 21 Sep 2025
	12:22:35 +0000")
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<e1d5a85f70c514749304fe87efde271e9ed5a92c.1758457356.git.gitgitgadget@gmail.com>
Date: Sun, 21 Sep 2025 08:06:10 -0700
Message-ID: <xmqqbjn3x2u5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When casting a `size_t` to `curl_off_t`, there is a currently uncommon
> chance that the value can be cut off (`curl_off_t` is supposed to be
> guaranteed to be 64-bit).

"64-bit" -> "signed 64-bit", per what <curl/system.h> says,
i.e. "curl_off_t MUST be typedef'ed to a 64-bit * wide signed
integral data type.", perhaps?

msgbuf.buf is a strbuf, so its .len member is of size_t (so is
prev_len); prev_len is how big the msgbuf.buf was before the code
added some stuff taken from all_msgs, possibly wrapping the result
in html, and converting lf to crlf, all only enlarging the buffer.
We are computing how much we bloated the msgbuf.buf relative to the
original here, so this subtraction should not suffer unsigned
wraparound.  Now thanks to the previous step, we can consistently
and safely cast size_t values to curl_off_t easily, which is nice.

Looking good.  Will queue.  Thanks.

> diff --git a/imap-send.c b/imap-send.c
> index 4bd5b8aa0d..26dda7f328 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1721,7 +1721,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>  		lf_to_crlf(&msgbuf.buf);
>  
>  		curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
> -				 (curl_off_t)(msgbuf.buf.len-prev_len));
> +				 cast_size_t_to_curl_off_t(msgbuf.buf.len-prev_len));
>  
>  		res = curl_easy_perform(curl);
