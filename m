Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB623D34BE
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368846; cv=none; b=eJz8deBVo+B062mVxVKbMmwGoSZUnJls1q2KxoO8hv9Cw4aGIFvKIL0HTQtdif5M7qI0rQlN7Y6EZflxho7IZdQb7SSmggo7rnYXwE9ekKJoOqSkUWIm6B7wi+3MFYpEz0PfvAkb4orcc2H9iO3ssv2cuNWU+lH44CYKokThJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368846; c=relaxed/simple;
	bh=/oi7/nJDnfOHdZf5Rp2Xer4TQDAspaG1UCnSzCesb1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hy2zcnM/bM6gPAvHjMLHt7E/GXrne7sP3jfDMosuxyJ7phhXMZ7u3lOjj98i6wNBej9YjsGQkF7YfzkAxrOwWDzjHF9NtOsMfQ0HrZ2eOJPuWkVErJrlcqU1SEsD7tY8vjAn/xXRGjl1g2gPZafxIeYnHiLnmv9wxHGNsRryAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d2D7+Hob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTx5763J; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2D7+Hob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTx5763J"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A2DE7EC0195;
	Tue, 24 Mar 2026 12:14:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 12:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774368844; x=1774455244; bh=85Cb3QJjQ6
	Uq2eEYctMHojtURzGunC89Kgae7U/+89Q=; b=d2D7+HobY3PvAFWbD3mQANaObm
	nD0tNS0YG/5+YRzFu+P2uKOMChVAGET9NiGdWyKh7ehsgXufb3R5srE0llSuJjV5
	5Kn0Idb5vWiypmS5qf5cwcE1IozGDsh+tbeWXDOEH8/p0+SzZCU4tOwKq0uLkbYp
	IMhNspDQXoP/F1bZpnVcW3AW9SKAFHmJe6f2kL6Gg1951aW5WXEXA2N2BIciWZW2
	eIyDJQ8reNqJfQZgzJddu8zGNgNVyRu+uea/DwpPNrwtjuOevn0MX4cMW2sIBIjr
	Jol/9PDv773l9D0Ug3MgSFkOs8As4V2cE9niWr3jFdYA7kCHe4Sh5tLsS9nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774368844; x=1774455244; bh=85Cb3QJjQ6Uq2eEYctMHojtURzGunC89Kga
	e7U/+89Q=; b=vTx5763Jude89Eo1NivoTrue3NWbymJDSq2CN6KzGFS1jcnBCp/
	5Qt7sMN92ghSH9nbCX6yQY3ef9g4J7HMgl4Mkgxw3HVj8dyKJLB6XyQHTw/fGV/G
	Sssf0R+oF59KZdSPBE2crGQPo7jPPwxYXk69/xLqLZpj/07FoFj+v9Pn5IqAgTGO
	Wza3ePy1YBmnIKCTL9fFpMx0vS8mBMFEqZgi26UdbVoziPTPMRAlmwFBkEMVT+ax
	gYD3V9dIuAe7ZeDYrETwT+C7TLpcj1KzcY95u9KOsCI/poY9dQ8hiaQsTMXqPqxm
	nuAMN9yxoBhTvqksh711mNZgGv6YSHEIFJg==
X-ME-Sender: <xms:TLjCacfRmVcEQPeG3sSeAOe78Op4fbdW0WLcx7ft1E7aQMVkO5vdOA>
    <xme:TLjCaR5d3GvHiPnnN8ngEE7xp9djjJZ3K4isWqtIx0RGS3gST6AYzr_Pb9epl_aRU
    _8IDiFMz8sZ3HNdNHx2_NpEppvEbJPPyrn4Q0Yjdf5TOlD0tQvb>
X-ME-Received: <xmr:TLjCaXX05wyDpYYl1_rwCr43kWfHZJY2UlvVc1hqC_VpxWN4kXVhm-QMJ4LwnMNZRB9UmEXe1NQ0MmWGrq_0c5RpfyUxUK_0Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegrughrih
    grnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:TLjCaY6jLZqZqh5Q6yvJqjONUV2ppuf_UU2Zz07pOxEtTg74XcgW4A>
    <xmx:TLjCaaoGvvfLXn-ReJMKrFtbBmUo8SKDl88wX2hrDrLnpVUr_KgdCQ>
    <xmx:TLjCaTmxzVUKuFlvENcZL6AqeDyotADqMeDh-idubh2Zgks3Il6kPQ>
    <xmx:TLjCaeMhYjJ9ob0zXxVqsy-uhy9WgFWU9nwr9VrY44vX-JSichEM6A>
    <xmx:TLjCaZWxjtUnInSLwf_9eFF9L0uLE3voaIu1bh5Kat2E8a6trYH5aWHT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 12:14:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 10/10] hook: show disabled hooks in "git hook list"
In-Reply-To: <acJNdKyz-ISsq4fJ@pks.im> (Patrick Steinhardt's message of "Tue,
	24 Mar 2026 09:38:12 +0100")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
	<20260320115211.177351-1-adrian.ratiu@collabora.com>
	<20260320115211.177351-11-adrian.ratiu@collabora.com>
	<acJNdKyz-ISsq4fJ@pks.im>
Date: Tue, 24 Mar 2026 09:14:02 -0700
Message-ID: <xmqqtsu519yt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Mar 20, 2026 at 01:52:11PM +0200, Adrian Ratiu wrote:
>> diff --git a/hook.c b/hook.c
>> index aa08c38c27..0e09b9a2bb 100644
>> --- a/hook.c
>> +++ b/hook.c
>> @@ -119,6 +119,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
>>  struct hook_config_cache_entry {
>>  	char *command;
>>  	enum config_scope scope;
>> +	unsigned int disabled:1;
>>  };
>>  
>>  /*
>
> Curious, this is now a single-bit int. I still would have expected a
> proper bool here :)
>
>> diff --git a/hook.h b/hook.h
>> index 92e9faf9bb..7c8c3d471e 100644
>> --- a/hook.h
>> +++ b/hook.h
>> @@ -31,6 +31,7 @@ struct hook {
>>  			const char *friendly_name;
>>  			const char *command;
>>  			enum config_scope scope;
>> +			unsigned int disabled:1;
>>  		} configured;
>>  	} u;
>
> Same here, I would expect a proper bool.
>
> Patrick

I do not know what an improper bool is, though ;-).
