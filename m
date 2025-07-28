Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C061C5D53
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753736392; cv=none; b=cXAwovxT/XDUybBjCRyFMHUIWhsS4aAujyH8Pjc+l9gUNLdWT9BPJJKgdgMoj6xQ0IxWHfsVOjuPkqO53giC9O/knx05P4ZkKmX7fWxaEgiGZvh+imSBRsUnRroj5v4S6I7CbB8XFy3LnKwbJl4tPW64kQuKBw+Ywpz4bTjK8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753736392; c=relaxed/simple;
	bh=PajQ4h+mRJRrnjcTdDCpYaLlzkBVPnxjHqY5erEp5tw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q/ABZtuiLtZUt8Z7fmFxHKDQm1R0hmO2BhQtE714S4mheUczHHsyyxRZFoQeNmYlT+jV1F4JBnzJnDgT+Mv/DD8/w014xcQpJgvCAZw87BSYtlr7/aF3S08F4Z2ZedzuCjaysiADIVr3oCF87AJuzpFqjFM6livXg/9EipOFLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lQUl7P5e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k30OGN8T; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lQUl7P5e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k30OGN8T"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7229A1D0040E;
	Mon, 28 Jul 2025 16:59:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 28 Jul 2025 16:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753736389;
	 x=1753822789; bh=RtFLZz9+VPEIfDBE43zxr6D2e10PpBruPV26hJ9w5ms=; b=
	lQUl7P5ehs6h22NfY2pGANVmDoSdqR9iWqrb7m71Fhpc8B+XoNFpwxwcYxCueJ2Z
	vEgx9mttHuFqi/iEBfZzmG5I6DpJsmp8WzYai+lCkyjtsZdyg3GaqOLuEM83AHR9
	DsBzbbfUpDei8QwpMsHSWfE86nwtgpNVEj6IFJKozd7C1RlSUK8FSxOs0BrJf4AU
	Qm2WBj29u2bUllVdvbc4KyQZr6Toq3oqub19+cTgk1aSw+fTni7kfAVnkFOOc5D7
	n/tlfGkzEkg3IdolKVJdvP4/oQgNyNFn3AvkQ8dN0TDVUBM5sF0SJwO/ONHAhiw0
	lFHiOXGAH778soRBhJAT6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753736389; x=
	1753822789; bh=RtFLZz9+VPEIfDBE43zxr6D2e10PpBruPV26hJ9w5ms=; b=k
	30OGN8TA+Q3GR0KcJM9GuUNv5Se+0j7tMd1SFItk9+QiCtbHZGSREvlZKLwC1SAu
	Vztkw0+1689vO23WnyIcRgbPzE5QoL/lp/CX8aXpiEV+Xz6WII6iSmbVdCDZL6T6
	UC0+//459aFTpKMD/7xWi4C0cKpfYrPfYbuYSU163NpfW9X/7hkJSqCqlAEK7hql
	dtfTFagb3fXqBRpOkAviOz5LEyqEikBUdnn59cFl1hK8z4QKq1gusdl3DapP1KjI
	Ilr8qjBlOtc4Bn30qOm+dpsLb6u0wh8iw9oPKH8Guj4RqXSfzLWNlYjkvN40LPxd
	+L8MAQyLAMGNv3awr6D0w==
X-ME-Sender: <xms:xOSHaAuuskhA8IE36zmm6hD9wCYtHQljUtUdTXAXv2Dv3MbGXDjFEw>
    <xme:xOSHaKa6Igx4t153aM7a6NXqk20lAWc868BqF4CqjvKKleAwpiljSHgDw8s-CCWRL
    UW_UyUDAQUebmdmrA>
X-ME-Received: <xmr:xOSHaHa6a9iO-n0_hxSWWq0iHy3k19IbjaAFItlCH4CJfbfdCtNAWVAjnGbW_b-cUeen2uFsdrXAygOS-3hZKj_y1qPZ9eIuJdX2yDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xOSHaLn2alC8e7g1hzRPQw8SuhCkfi46pIYy87LBsH2PR_UGqtbduA>
    <xmx:xOSHaK1AeRg3iapQKAbkj6kCTQi5AGjREBGlVyaTEeyNIclaHAKFhg>
    <xmx:xOSHaD1I-4MHf4rJclu89GSyg0QXG7R2AK2qNWGpRXr1iCzD532k5A>
    <xmx:xOSHaEpw1KVz9fqqtactBmy34uN3osTOeSJFFUp6TVjuoES2FPDFcA>
    <xmx:xeSHaENUXJ_KecRz4M45pD5cw3p_GN5WNPdpKX4zqHDZqRhVucUnpCDK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 16:59:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Justin Tobler
 <jltobler@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write
 new entries
In-Reply-To: <CAOLa=ZS6e9dv-c+tajooZa5qFZT2T+jqaJahd3BzVuE7H=5PwA@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 28 Jul 2025 13:39:05 -0700")
References: <20250725-pks-reflog-append-v2-0-e4e7cbe3f578@pks.im>
	<20250725-pks-reflog-append-v2-4-e4e7cbe3f578@pks.im>
	<6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
	<xmqqo6t4up5f.fsf@gitster.g>
	<CAOLa=ZS6e9dv-c+tajooZa5qFZT2T+jqaJahd3BzVuE7H=5PwA@mail.gmail.com>
Date: Mon, 28 Jul 2025 13:59:46 -0700
Message-ID: <xmqqms8ot4jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>>
>>> I tried `git reflog drop`[1] and it can deal with a branch like
>>> `branch`.  It doesn’t need to be told `refs/heads/branch`.
>>
>> That sounds like a bug to me.
>
> So `git reflog drop` `git reflog delete` and `git reflog expire` use
> `repo_dwim_log()` to resolve the provided reference.
>
> And `repo_dwim_log()` uses the following `ref_rev_parse_rules` to
> resolve the reference.
>
>   static const char *ref_rev_parse_rules[] = {
>   	"%.*s",
>   	"refs/%.*s",
>   	"refs/tags/%.*s",
>   	"refs/heads/%.*s",
>   	"refs/remotes/%.*s",
>   	"refs/remotes/%.*s/HEAD",
>   	NULL
>   };
>
> Which means we do a best case resolution of a given reference, but the
> function also checks for ambiguity and warns for it.

True.  But as I considered "git reflog" to be a lot closer to the
plumbing than to Porcelain, using the dwim thing smelled like a bug.

It also is OK to update the commands that do not use dwim-log to
also use it.  That way, the result would be consistent across
subcommands of "git reflog".  As long as the users are aware of the
fact that the command uses dwim-log, they can always spell their ref
in full like "refs/heads/branch" to avoid ambiguity check getting in
the way.

Thanks.


