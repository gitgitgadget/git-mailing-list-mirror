Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636F1BCA0E
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862593; cv=none; b=c57pkI0BQjyjq2wXI19v77gvbEz2yYyeH/8ku/mwpNsyIKCeZUZcIUfKNAxNtx3kNp1UU1h01QvBd+9MICdlYJ+NLpRJWtvqKp0bMTTVQSQ47MBP0P0RXjNPyitWCJkqfVfLQPtcRoIZLriYy0+JmHP3+Kddoe9ExRQ1JMowzKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862593; c=relaxed/simple;
	bh=nGB1BJFe5QdwbNWjygRj2JBZiKVOi+FFq8oVBY3ir6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TUGZoNjjaDpiF69UNgMk4fnu6H2bZw510U6Je7KDvoSeqePqx80lO8pEvFbteMNrLUldBEb0CgQMPwSKcCi9A4pgWIPRnf1RR9/wNj5CQdNxppAqcp7HxTZ1s2figHPcrHZAwxII/C9Ogxq4VVoQClaS7VIiJNwKqGz1H+DuDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VZTTW7eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S5kemrrp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VZTTW7eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S5kemrrp"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27C0F1140132;
	Wed, 21 May 2025 17:23:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 21 May 2025 17:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747862590; x=1747948990; bh=jDEn27OYCT
	8ppQed0/hfPTwF/RQtQb8+9dXRDf/uyls=; b=VZTTW7eMWlJVilsQ+2OE6X1p4+
	RSH54oOb64S9rbmBp2J76dqwVincIx/w+o2WvgERsctm8k1lzPaQvmqwJYfJzLUR
	0CNdnJmS2m/jPnQbriShTR1RPmGZwQsJcxgjAJZ/Sr0oITp0waMOGIZ6SGPK6Rsy
	02tD1E8S3y2MG0cavueiwB2Zpw0G8jY1t8F1RRSXw7+voT0yfF9ZLV/QfAJviKWc
	EDLztPsWutvQAWyXGZcqqGiXxSjVqG1v+2sm4MncQ9QJS8TukZp/Sstvg1GIX7AZ
	bR6g1rs+SkURya53KY7J/FTFX1yN+DOul2NZwWbSUmVIswY9dKiSVFcfCQnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747862590; x=1747948990; bh=jDEn27OYCT8ppQed0/hfPTwF/RQtQb8+9dX
	RDf/uyls=; b=S5kemrrpd05kz0pQdf17gxZZLwbq3EuX3OvHxTAgBnXFzBdVu/t
	svOp9ckDwR7v0WUb1aedRXav32ZcXS8sgPs6pTXf3u094ZQfvBjwcnJsSKiifiYR
	zMfZ7a1IHWdr8YX6xZN3tK3adVMSjBaZOTGDqq2I2pkPYbCJyr/L5iXyeqJzr2IV
	CSLjybL1qLkDjT6xYRGaTn0iVvKo5I7CgF6+eamus6eeUOkHEV2++IUvKWQO74rn
	5RWsBuf2z7Hojrq1DogQJxij7e6xAqF79ForJkPUiWpJEaYHBGNAKVba022I305E
	+5Nfth/KEv0MGtdGUyMnW3nvJDE+28R+WNw==
X-ME-Sender: <xms:PUQuaO7ZsnHGR24OjcidtUAh290Q5FSNREz1ns3bg93dzx5myFPk_w>
    <xme:PUQuaH66UKx62hT3eFXChOGp75QiEDm20ndA3uRlfkhFqj0BLMgx13vWiq72BenAi
    Q_KjOzwQLCWcrRmgg>
X-ME-Received: <xmr:PUQuaNfzdA2oK-zNxpImDW_6mVawvJYIC6seBaHZmI-G8p-afgFewxOONKp11lIZrz9TYAzPHbVZguymuhZIW8W1t6Qpa6t9GQGvN_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegudehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghlvgigrghnughrfhhogiesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    ghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PkQuaLJo9k5OOYoGiYU5hvb2MlK5qFFriYwnqzhYTQ5gp9dSmbSG-Q>
    <xmx:PkQuaCJEVh3y65g6Mfd2sspBPqeAMUy-jRXeC3XUrozCPbeYpEpDCQ>
    <xmx:PkQuaMwqMMsqQyABs52bOz1ixwHhNsRtZ2PYGetfTTvCmI24pEseRA>
    <xmx:PkQuaGISo5g_jsZCcjmlhICQ67VL8FQFxtKMQuknz_4iyHLrxMCg6Q>
    <xmx:PkQuaPrn8fGZYCuXR3ygWBIpzsMP9JdzDrI98-rCVFB1hAHPI9mniSHC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 17:23:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alex Mironov <alexandrfox@gmail.com>
Cc: Alex Mironov via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] name-hash: don't add sparse directories in threaded
 lazy init
In-Reply-To: <xmqqo6vl8y81.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 May 2025 14:12:30 -0700")
References: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
	<pull.1970.v2.git.git.1747858585623.gitgitgadget@gmail.com>
	<xmqqecwhaemu.fsf@gitster.g>
	<CAC97EbxRpG1ecWcQ=yJHnqe7gXYG7BNo1sF9e9Kf-EOkDySfpw@mail.gmail.com>
	<xmqqo6vl8y81.fsf@gitster.g>
Date: Wed, 21 May 2025 14:23:08 -0700
Message-ID: <xmqqjz698xqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Alex Mironov <alexandrfox@gmail.com> writes:
>
>> Hey Junio,
>>
>> With respect to messaging I more or less copy-pasted Derricks message
>> from the original commit for non-threaded init: please check the
>> referenced commit. Let me know if another wording is needed/preferred.
>
> I know what you did.  Copying and pasting others fuzzy words into
> your commit log message does not make your commit log message clear.
>
> I already said the given message is less clear than desired, so do I
> still have to let you know???

Actually after re-reading what Derrick wrote in that commit, I
notice that you didn't even copy-pasted his message in full.  Here
is the message in 5f116695 (name-hash: don't add directories to
name_hash, 2021-04-12):

    name-hash: don't add directories to name_hash
    
    Sparse directory entries represent a directory that is outside the
    sparse-checkout definition. These are not paths to blobs, so should not
    be added to the name_hash table. Instead, they should be added to the
    directory hashtable when 'ignore_case' is true.
    
    Add a condition to avoid placing sparse directories into the name_hash
    hashtable. This avoids filling the table with extra entries that will
    never be queried.

Notice that the second paragraph here makes it clear that how extra
entries would not contribute to or hurt the correctness?  You failed
to copy-paste that crucial bit, which ended up making your version
of the explanation much less clear why the change would not affect
correctness than it could have been.
