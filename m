Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708621487ED
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654193; cv=none; b=XtbDNX5iqMGH/tPJbhfdEDWy/rTvFe2t5Xvn3ESO44Uhq7FNMhmo1RPQ9txarywGztiTH1WECBXS3KWPHFiz0QhTng5WfcI8NzpiOGnW7a3Q+LN3e2/EJw0qQ2unYBsQXAEckAXtrZoVJJdmpfSq89TlWFVmsEvl/c8VQM4MVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654193; c=relaxed/simple;
	bh=wpt443Wd/cwOLS7enBRtokPw9n9R6WOSZlt1kMg67J8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POyAqrFaRMvUzBGDmwRhmR0SuK6XPMWGb2jYr8vJmp9Jq61mhStzWrivgMWOcwexU1+ckpwTkXM8+HujXzrHChuuk3jq5b1b4Fh5EPUJgIyGBFrXcugFeo9+RTgzAEsPhg+zLqz0WZ4SSIbnxCwxLZUD7EkIh4jbMNeTIS4JUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RBsMGWmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zd1CfNAy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RBsMGWmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zd1CfNAy"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 66DB913800E8;
	Thu, 23 Jan 2025 12:43:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 23 Jan 2025 12:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737654190; x=1737740590; bh=TDpJ2RqpQd
	GhW6TIq7E4mrukVxVAjstZU7kFFghc6FQ=; b=RBsMGWmBXRIBT8KJgN6OVNHt6C
	MDudGfi0kqS6jLGfzM4Ggg9L1EdTg1usAsP0S7SMb6LIi/R4QTNcHLIeM4/eMR+E
	bJ/UmZSOaZsO2R4lXUp5oQjObyPCwutPrEuBYYa444fJD/OfIVX/a4LmlbilTjEV
	aBclRmNW2w2NZVvGcz+XSBXaF/dcPpyt626xB3ivoMqlV7r/UsmColAAuVIiClpu
	K0NyG6G66oMNrHt3qhCUI0aPuEpBLCm8mXVa4kLKM+ZBScctre8SA12fsvw4F1aG
	A1AaiYJNpciE2RJQXvWM4KYMKio143NVryAMFDFg+tj7VataK+LWfYRTOHPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737654190; x=1737740590; bh=TDpJ2RqpQdGhW6TIq7E4mrukVxVAjstZU7k
	FFghc6FQ=; b=zd1CfNAyKUHRR90uOcvgawwcXMECmGr9fyRfUMGuEJldt98dIcJ
	LrbphF1KhkTw0ysw269JnrS5MOIvVQPaQRWsvDrdVWi2yMgIZ635Fa0LtUiHyo9e
	CNuCOPsS6ADTa41qxeRm73NHr/wN9RvaUhuAJVafdz5RGpqH1k/ckVQTcWGCMZBo
	6IqHnx70yUJmkNpsxxNPYcuwKev79JIcXz+XJTN42pP1CB1nYmv6Yb+qyr3wJ7pU
	nTPyghwF/MJ0dlMxcRL9fl8eUPgv4gSx0TWDzAUYxsQTFmng4aC4phROlBnHkczH
	TZcZlrpH1YZyG+nBZ+9GFdLtSkwB7TGrBaA==
X-ME-Sender: <xms:rX-SZ8Wd6Bo5YTzY6aMyV6sJdj7jh122tFQdrUkMyVRpce8EqCQYMA>
    <xme:rX-SZwlHXAIbdN77t8R0mscyN-4j7T532eHpoQFW4vyiGoRiQtZAcR9GsLP3-4ipH
    LfzQ2MMJlnkJ1jAfw>
X-ME-Received: <xmr:rX-SZwatyCocAcy8PbNc2-sXAxjo2UNQI6jl1OQqw6j_Dy1mDWPQ3OgcsnqvvKT0fjMjN5VS0Rsx5hhHgstigzUPcBTM90Bhbo-H>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    nhgurhgvfiesvghmrghilhgtrghrthgvrhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rn-SZ7V7UH2JI3xaxLPFPCTlGlDeK2HeDkPlOLbpVbeaCK6L95yZ5g>
    <xmx:rn-SZ2kOieeC6AVdHCsDJY0tsfZNjaOyYqgKhyUUuFq34neO0VBBYQ>
    <xmx:rn-SZwcVAJAx52jdnG-CbCbjg2cme___UQbhPHzZnye3gIF20TzeOQ>
    <xmx:rn-SZ4HP_kmM4zEhAFi4WWU6xrQ5oRzJU1XoE_zpT53aQkEOFse-Xg>
    <xmx:rn-SZ9suGgItil8-dW3tyxp2eeCr7CfGpL12WZ-lJG8k5p0h0I0n0Jws>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:43:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Andrew Carter via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Andrew Carter <andrew@emailcarter.com>
Subject: Re: [PATCH] docs: indicate http.sslCertType and sslKeyType
In-Reply-To: <Z5GOfwBR7JBloIs0@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 23 Jan 2025 00:34:07 +0000")
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
	<Z5GOfwBR7JBloIs0@tapette.crustytoothpaste.net>
Date: Thu, 23 Jan 2025 09:43:08 -0800
Message-ID: <xmqq7c6ltoib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-23 at 00:16:06, Andrew Carter via GitGitGadget wrote:
>> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
>> index a14371b5c96..cd39e182527 100644
>> --- a/Documentation/config/http.txt
>> +++ b/Documentation/config/http.txt
>> @@ -216,6 +216,18 @@ http.sslBackend::
>>  	This option is ignored if cURL lacks support for choosing the SSL
>>  	backend at runtime.
>>  
>> +http.sslCertType::
>> +	Type of client certificate used when fetching or pushing over HTTPS.
>> +	(e.g. "PEM", "DER", or "P12"). See also libcurl `CURLOPT_SSLCERTTYPE`
>> +	Can be overridden by the `GIT_SSL_CERT_TYPE` environment variable.
>> +
>> +http.sslKeyType::
>> +	Type of client private key used when fetching or pushing over HTTPS.
>> +	(e.g. "PEM", "DER", or "ENG"). Particularly useful when set to "ENG"
>> +	for authenticating with PKCS#11 tokens. See also libcurl
>> +	`CURLOPT_SSLCERTTYPE` . Can be overridden by the `GIT_SSL_KEY_TYPE`
>> +	environment variable.
>
> Are there any particular limitations on these values that are platform-
> or backend-specific that we should document?  For instance, I seem to
> recall that at some point PKCS#12 files were limited to schannel or
> Windows, although I could be mistaken.
>
> Do we also have documentation for whatever engine parameter is required
> according to the libcurl documentation?

Both are very good points.

I went back to the original thread that added the change cited in
the proposed log message [*1*], hoping that maybe somebody brought
up caveats but didn't find anything relevant other than that we
punted to add tests for this since it was too cumbersome to set up.

Note to Andrew, when referring to an existing commit in your
proposed log message, please do not just write its abbreviated
commit object name, like 0a01d41e.

Instead, use it in "git show -s --format=reference 0a01d41e" to
obtain something like

    0a01d41ee4 (http: add support for different sslcert and sslkey
    types., 2023-03-20)

that would help people to immediately see what the change was about
and how old it was.

Thanks.


[Reference]

*1* https://lore.kernel.org/git/pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com/
