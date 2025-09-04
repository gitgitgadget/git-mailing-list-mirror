Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046172749C4
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 22:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025831; cv=none; b=kUGCm8rjNPPlWbeu3E+LA1+H+WJTW2KjkUUzobkxcA/n2ZGlB4trxNV3+itUpV4WoPPVgVK8MqtuURUW+/LXnpc0257eQQ/KBLVDJ0TlGpT2mtqOwhZZAGrXFzSZzqJp5seEskHqDyAlRmHGYHUiJDIQdFcM+RTt+t9ha4tjErs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025831; c=relaxed/simple;
	bh=LVzcteWa+5K1zF0vwlWgj8kMV3kqw2ymAbn8MAudFik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IgcMGu5HmwYqEemrUcWQyPTSJoeIYzZ8g2Q6SWN6PI1het2khcmjnP/aUFGTYC++PSrDZ7wpjPbLgwjWUYOB/iVZhJFMv5D4/YTM7GPfAJ2QSFSqoDY170+zJpYrvmigIiyfVy3WfdI8jSWK2GTSBUQCQ4vFTlNCwMqdUnlUWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y2Ljyd1C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASHxYh/3; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y2Ljyd1C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASHxYh/3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id DB7B51D005A7;
	Thu,  4 Sep 2025 18:43:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 18:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757025827; x=1757112227; bh=W+VqJPd10+
	6d5I+jp3eDMX8HSeGOXkVq0aQHV3uPTEU=; b=y2Ljyd1CqEsW7UwQUBGJj7RIz8
	ukq1448ShbIPXCpQcsEKQDMUSDcimIpzy4n/72iJQNq2jL1MOSQfRXhhQXQJsNmE
	IbH1IE8rc6UfPRBCdUWrVk4ElOm8pFAioG95BZEICLpYSoUSn8PKZ3kuWFiYm9IQ
	8A2xNFoZZjCqtATvA+Xg7VGqWfJn3X6S/nYNTj1kDspmGpBoA6kQjpVbgnq/IykJ
	EkrdKxTAq3noofraLuAbh9sj4SakS2viI6gl7gGgv/d72PSQDxlFPDCetjvWdqHH
	TJAyF5WcebAisERpFa862+fl1kp2MoUn65aXtjxqPfDJ4PXGIpV2c+f4xAPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757025827; x=1757112227; bh=W+VqJPd10+6d5I+jp3eDMX8HSeGOXkVq0aQ
	HV3uPTEU=; b=ASHxYh/33vtd+Rwlck289sFd6zKbKQEBS3le2U6xLKcTjEaPC8Y
	sc57lvo/R0RVkNLXEA4GEhfNIpp//wBrb5e63Ab0K3wMd9U3XZatAOYBX29eR6mT
	INcCB1wg+LvIU734XvY1LncNhDKUxZDoJPMC7TK8F1upRyB/dsHcfS03t04abfIA
	a6dPzJqGwoQqMDMIivDtKC/xTMKUAAbzpT2SQ6H1RKZ9OEHhcTJ6+ejdyPs/5XYY
	OIDEsRqiHc+L5U0YYjW1Pt8vRNy7wNA0Q+Z7hPUWEgNiTEtWTbp0FZAfp7O10fCg
	kdCEanZ7BZY8CvFSNhnzZpHmKHXR+U//8gg==
X-ME-Sender: <xms:Ixa6aBmezjoPFwyRDppC1Jjwi2aFauIL9aoeIM2rE4C3k_PMgUMe-Q>
    <xme:Ixa6aFQh02FRs6mC4uhtTssV-K8w1gb2FzvjsPE395Va2jbgQ0NNu3I7V1vml20h0
    9giNWVEtEpkXe4oxA>
X-ME-Received: <xmr:Ixa6aIEYNMyCf1dGKs-EsEy_twWBcWXpwwSW_SMYx13hanHvJWVEYvEulk4bOsAmBppxr6pHPGc2yjgJ23RxEGYOmNmonCNmS-de5JU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepgefhgffffeduheeuleefhfevtedvvdffteffgeeiheehfeduieegfefgteeitedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdphhhtthhpugdrshhhnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovgdrughrvgifse
    hinhguvgigvgigtghhrghnghgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Ixa6aCEklJsnKKIItWbIe-fQv5MqVB4ZLIhUvq3BamPPEmg7QNtmiQ>
    <xmx:Ixa6aOQmJdJmJLJY8mPv0u7HF79rngrO3Y75l--p0Nw3lEDxlOtU_g>
    <xmx:Ixa6aLLd-nqDz3Lrx3FkU-C1tXuWHTa5jA8drXcDaZKPqOLRJQYVhw>
    <xmx:Ixa6aBZV5HqwO4nhBxDbj62oo4SN5lKcNmI5QtgHB7p2ap9KQs5nvg>
    <xmx:Ixa6aPBIrnm3gBjF4KwVuNzhz1dDHL78wXTIKARJfTtdF8YmK7W4WSVG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 18:43:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  joe.drew@indexexchange.com,  peff@peff.net,
  ps@pks.im
Subject: Re: [PATCH 2/2] refs/files: handle F/D conflicts in
 case-insensitive FS
In-Reply-To: <xmqqms7bfll4.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	03 Sep 2025 11:16:23 -0700")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
	<xmqqms7bfll4.fsf@gitster.g>
Date: Thu, 04 Sep 2025 15:43:46 -0700
Message-ID: <xmqqfrd17s9p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> So opt for the more simpler option, of
>> lowercasing all references sent to this function when on a
>> case-insensitive filesystem and operating on the files-backend.
>
> So when you are trying to lock "Foo", you lock "foo", for example?
> How would that let the generic code liks verify_refname_available
> notice that an existing ref "Foo/bar" would crash with the name you
> are trying to take, which is now downcased to be "foo"?  I am not
> sure if the above explanation is sufficiently clear to convince
> readers why it is sufficient..

Here is a quick-and-dirty monkey-see-monkey-do patch on top of your
series, and with it jobs on osx boxes seem to fail.

https://github.com/git/git/actions/runs/17477662700/job/49641377250#step:4:1912

 t/t5510-fetch.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 84dc68e5f3..76af769f5c 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -59,6 +59,12 @@ test_expect_success "clone and setup child repos" '
 		cd case_sensitive_fd &&
 		git branch foo/bar &&
 		git branch Foo
+	) &&
+	git clone --ref-format=reftable . case_sensitive_df &&
+	(
+		cd case_sensitive_df &&
+		git branch Foo/bar &&
+		git branch foo
 	)
 '
 
@@ -1566,6 +1572,20 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive_df &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "failed: refname conflict" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/Foo/bar >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.51.0-314-g9a15cfd6dc


