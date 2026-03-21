Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC492EDD69
	for <git@vger.kernel.org>; Sat, 21 Mar 2026 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774069033; cv=none; b=eXTdWPFWmKX+6AV0STSXdNLrR8fv38/50yi1ghGMddyVlxELKrBOKVeYvnKIEjWVdj0Vhw2ZlsPMs0Q95ZorFJVAMgXAH5eZ6P5b7F9rdzu8pC7rnc181JH2qCyafLzH1rjpKMDoCLuo1A5E7VKX5t4ArCC2b1sC9Guc5sh/6QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774069033; c=relaxed/simple;
	bh=sx51x19k+FqnT82dG9ZYTCplQHTW3n3wb/nHzVy7PPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eoqokJs7N5SckD2vyeNeVtyv47zEfOypxszMg962kY3IGIsPcBjq1nB72iNSWrbdxOzUr4r6UknzkYfnhBTtXaeMCZz1tnyutPm8NR/PmAT35tAOJv76xpUr8vRxFpWcbdFgfeyqgDmd6vHZWunFs41KANsBY+kBe85q1+UGdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NJRGf8/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4awj/0B; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NJRGf8/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4awj/0B"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A7917A011F;
	Sat, 21 Mar 2026 00:57:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 21 Mar 2026 00:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774069031; x=1774155431; bh=D3TvcU98QF
	VnRa0Ne1/36VnPzngmqeMTFWpsmrDS1cY=; b=NJRGf8/zHEu4BrAO/40Znvn8pW
	/9hsD5LB44tIh12/AIQlO3XNf78OgHo8bv1eU+kWCnilEVSYCr6QiYmZvu5fdmht
	tNzPLd1dOfhw9EToLRFOsyVbxhBktK/Wo0VwDPF468mV1mHqQlEUvZHNWmQvuSNr
	U9IRwQMRdFzXU6f2ItsYmjRCUCUUEFRa7mCfh9SqqsigVOHrWKZOr/bd4Mfn26GK
	NRjMf5LhGrQeXW0EE6vMN0YfG3URggmL+Dj+CVc4ZYKoxAInyQqy3wFvyDE96NuW
	LfG786gIKAXptWh5igRFnNc26Otx0MtJOmWCL70wmmQaDIOIg4HvrrzPEVEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774069031; x=1774155431; bh=D3TvcU98QFVnRa0Ne1/36VnPzngmqeMTFWp
	smrDS1cY=; b=A4awj/0BG0X/REyyvDo9dSzn27AO14dYJdRvxCnZI71MwFJL431
	uEhZUvEVGZFismOFSKAY1UukZfax7Ray3qBvw/ztkro9uqKSnQ4alNM6nR/1doMK
	CoWNjhBGYm7rzmjgPXGadNnsu5PA8qJnW/LmAJYmxRRBivubpZeRuByhntSp7Cau
	7liH+EkGpxE8r/zGIOVRKfbhYKsQ6N0MOky9/Gi4jysPbc0m6pzVKG9Vzu5krlW9
	G+x76jY1n5mmfxJZyyeZZzXQnU3n7L26UMDhy7l4c7d3dABPltYPJbU35YYMdDBG
	PQOYbvVX84rpImyeZTCKUfdHdjVggC7oaWA==
X-ME-Sender: <xms:JyW-acLef0HFtnNB8aEHiR8gHcazBP_dIFIB_smk4f5kP24OZigLYw>
    <xme:JyW-af1l3VOb4tNyqrfUHu9ipxLJTEh9vl1qP3NLxjGGxXjXNyXlIkiKkOUE8ziDj
    dC0m_fFUhntlN9eZEIoYFoUXfgJbWS0VZqsZxo5y-CshBqeopY>
X-ME-Received: <xmr:JyW-aWgV5VLO79CLBVyEYPokoavSXcDN0jotjgNOxWAryWp6JG9t59fRkJUUg4rKrAOf9zYSOU9RV-H-feLvofK09ETY8QSFSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehvrghiuggrshdrphhilhhkrghushhkrghssehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JyW-aQX9kuy1V0imW71FXNHxrUd1fHKvd_BkyzOpeg33LbniG-LsAQ>
    <xmx:JyW-aVUI-sZdcY1ytFkoml9ntOrcslioZmfEevJfJNoCC3OJ-kiD9A>
    <xmx:JyW-aQgJfk90SS1bJAysV1JxLIQ4ChzetsMKAs_cvLicdh6NOk-fZA>
    <xmx:JyW-aQZ_L2YZQdOhyjAaZwOWX0Rn5yZ8ba1ut1Wtg9v-ory21d-e4Q>
    <xmx:JyW-adBCvchX9Nm89PNgi4_XChgKQM1QcNdYc_8yVguPmQNRHjuHrXwu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Mar 2026 00:57:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>,  Vaidas Pilkauskas
 <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v6 0/3] http: add support for HTTP 429 rate limit retries
In-Reply-To: <ab4RIZr7b49VKjR9@nand.local> (Taylor Blau's message of "Fri, 20
	Mar 2026 23:31:45 -0400")
References: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
	<pull.2008.v6.git.1773752435.gitgitgadget@gmail.com>
	<ab4RIZr7b49VKjR9@nand.local>
Date: Fri, 20 Mar 2026 21:57:09 -0700
Message-ID: <xmqqbjghdbkq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Mar 17, 2026 at 01:00:32PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:
>> Changes since v5:
>>
>>  * drop show_http_message_fatal() preparation patch
>>  * drop fwrite_headers, restore fwrite_wwwauth
>>  * move CURLINFO_RETRY_AFTER from finish_active_slot to http_request
>>  * move retry_after=-1 init from run_one_slot to http_request
>>  * replace retry_after_out param with http_get_options field
>>  * fix loop counter: separate REAUTH and RATE_LIMITED counters
>>  * fix racy -lt 2 timing bounds in tests
>
> Thanks, this round looks good to me. The main things that I noted from
> the review on v5 was to drop the old 3/4, and a handful of suggestions
> on the final patch, all of which look to have been addressed.
>
> The first two patches being unchanged, this round looks good to me.
> Thanks for working on this, Vaidas!
>
> Thanks,
> Taylor

Thanks, both.
Let me mark the topic for 'next' then.
