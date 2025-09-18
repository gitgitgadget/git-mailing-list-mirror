Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20030F94E
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209998; cv=none; b=r1nvpBDspJWtBQr5mPqIg3Hzw9OAeOCDuqo8jtn8bbzkXazjx/wyQxvjafC0lDd3MB98y98Hf9zdP2w0loyQj4OR2F702zy/YHZtxkagKD9qw7kaRuLB/yAAVbJQTm2HgGBIDupNOcaJ0FY9LqifhEctjXPEFRMTLoAV1Zi36bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209998; c=relaxed/simple;
	bh=i0UVCHqL7UQ4IDqaKWahd4Rt7RqjFE44atekxL/9HlA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vnoi/seSB1HzVFV3HKxvBRu4HThQ/1ELa0tuj6xMJ8krSZRSvZJwRjkNmvNU/yGOwbrYmQVe/97FONsg0bzV/cALzEfItD9j1dAiKkwTgbr46f8pO5rthhd0aLv4DyKzuQz6OL36WtE0pUY5PBEpexbrNIGf+aYjzbCsJI1o8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S5wuf2dQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TGLlTBz2; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S5wuf2dQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TGLlTBz2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B07A514001D1;
	Thu, 18 Sep 2025 11:39:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 11:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758209995; x=1758296395; bh=KUmtPb4IMq
	2RxGlNMkr/gkxIHnUpvi4ZYYkcWAiCoY4=; b=S5wuf2dQvB5Wto+U8bogwfN1Jo
	qag3OMJofn2ygwgDIiTT4a9LrUYKkdG9J91JbYliYGEJ58ex15zo4+Cf5IM+pscy
	i9J45KIErwr3j0D7TXVzpktBjewo+Gv7l2rDlvyqIfeR4mw6RF43yy1OI/72ma6x
	rc9qqx4IdxrZxfXj80RJwh+15KAJ+BvhzWdMtga3Mb3W2JZGAObsluMM3550uHiU
	y/PWm+rp9U2P8LKTUHcwl00N7Gs4WRecopbWAIyRP6gmVXXWHZTvgseR6U37F+nH
	fl53pv3Kf0w3vYyEDQxRX3enR6ekFaVEbZ0vbvI6fiW44Lw7unmf1lksi/+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758209995; x=1758296395; bh=KUmtPb4IMq2RxGlNMkr/gkxIHnUpvi4ZYYk
	cWAiCoY4=; b=TGLlTBz2d5AoMGKkXHa5TEubXjfDqg0hrZrAe9/WKWySxCLol+M
	cnRyRi+j4v9z7kbwt2zIb0iVwSLB9lyJ4uFL6IXGYTi31Kr1EKzSfrljhAjrvHII
	CgogztQxVI9oxyNtl8XkPhU/HNXKLRDAAhC5PliBR+VpW8LfkgQzQkurC2Ff0AQ5
	gYrHqS2hhl0nBSuljonIAb59wlbcdWG0joVakSWhw7nisyJB5jL3yugzrkJxMOa+
	wLSPhVGqvydBaKMfoq934360KhX9JYy/b7LTZMEGdsPsUTxKomZnJM5OBRRrCqrD
	kxQHFanZsQpl6AOjsg3uLLdGumsJYw2WE+A==
X-ME-Sender: <xms:yyfMaPWlAyQAJdf7yrokyYqlTVP9Wa653kj3kjSWlKD2IWQfGYVIoA>
    <xme:yyfMaDFalrNYX7hkgivHU1IyIS5OU7t3n40p2JNvE1qiquUatcYKagVz3KFLQGqvh
    zV7UAHTT3yNlfO9lA>
X-ME-Received: <xmr:yyfMaB2X2bS4B1hx5y-Z_TgY0vkKlpgLmCBQSnP0udqmCuvBaayCp8xNyyF6qUN1iaO-2YQuZ3eHKDeaPw8j27DfCd9GHvZ-DEkmnOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yyfMaFMiOyjkKPH2B1sEEpV7ROJmOxcbbEH193b8UTZkPC293lG5Hg>
    <xmx:yyfMaA6JhOT29RqD0rueef_gy7x4kqJsUAdVMPxiX9CLlsrQg2GmyA>
    <xmx:yyfMaP02sjLI1QnHk5CFKWOdodCXDMSQPb-Y178V2MBtzeChG28Ohw>
    <xmx:yyfMaBz59cEuxKT8j01JwtDywNzpF3Xv7K6vd-xqZViegFxcCCCV1A>
    <xmx:yyfMaIlpuSe7DFj4S5lHc3hRrUXYYewP7__0w3P1bkKMT4fE9P9us5HZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 11:39:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Meet Soni <meetsoni3017@gmail.com>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSoC][PATCH v3 1/9] refs: add a generic 'optimize' API
In-Reply-To: <aMvigMLPeQE-n-o_@ArchLinux> (shejialuo@gmail.com's message of
	"Thu, 18 Sep 2025 18:44:16 +0800")
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
	<20250918054704.544254-1-meetsoni3017@gmail.com>
	<20250918054704.544254-2-meetsoni3017@gmail.com>
	<aMvigMLPeQE-n-o_@ArchLinux>
Date: Thu, 18 Sep 2025 08:39:53 -0700
Message-ID: <xmqqjz1v93cm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

>> diff --git a/refs.c b/refs.c
>> index 4ff55cf24f..2ea6fd2218 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2282,6 +2282,13 @@ int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
>>  	return refs->be->pack_refs(refs, opts);
>>  }
>>  
>> +int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts)
>> +{
>> +	if (!refs->be->optimize)
>> +		return 0;
>
> I don't think we need to check `refs->be->optimize`. Even though for
> some backends, we won't do any optimization, we should register this
> callback instead of assigning `NULL`.

Yeah, all the existing functions at the refs.c level simply assumes
that refs->be->method always exists, and it would be sensible to be
coherent with them.

Thanks.
