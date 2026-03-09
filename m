Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E660637E2F0
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773098804; cv=none; b=LULMQZOgD8s31yz+7e7ps3VW1uthnueK4SpSiF+QmWcexOkePU/Z1Ottp1UuAyookSvoIP5Gb3seLGPLZtR7uX5tm0tet9r864QVmmJaGrlLzJTmjqfNxvxidX1ap0a1ndO35g+hPa5DwAsPtN5Bl7oPEaTQKhAoXBc/KwUf/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773098804; c=relaxed/simple;
	bh=nXBcZPoo+qUgKycGglKdWOJdKDIvBQp8TjFuL8S9D4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9aHv0+yZPzxrCJaT4ZLTiRuZXCkI6YUy9W5GNcKtN+/KUkzg/y4X6G+a0rbcKfO5LZmjIgKTkHHYvNvzhZ+rm9mrhiPAqQLrSJuv039P1OYWGfDNo/KmdhHGKqNkpIGyplKrL+m/f0G9/6ygI/CanPmMKGwORm2RIo3rd+q0QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ROK6LoLb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXuTEMOz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ROK6LoLb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXuTEMOz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0684414001B3;
	Mon,  9 Mar 2026 19:26:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 19:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773098802;
	 x=1773185202; bh=eeQJm0tGNgUiASKzTOGhP494ZbhaWBrirjhrp2NAsz0=; b=
	ROK6LoLbGFUZTI0MoYe4HJN2wRYEvhb7dr/E1DzhuXSeoGzxxBoHJMCKJVXtl2L0
	pKXxWQbOdgGRrkaCEKItlBmOG2LEiW/qx2SaN+HzIAH0qaR54CV5MN0ot9mXHR2r
	Ju9ZXh75C2Z1YM6SxLFbMXx3oxRrSMaD/fzhqJsqYuupjzi6jSBiF8MZUs1H6i39
	j5EhgrngCS0vWzxLrhbjJqhjcZvgxz2Ae/GIrDqJAilKOtF6cOpsq1QBuiL3UF7N
	pZ59kMn5TvUs2oyIhXagPyBgYB+718fhBIxFOeBOZI/o6zA7sUEiKYlHRjpHPA47
	kCAn7AHDhCRGNI26SQWtTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773098802; x=
	1773185202; bh=eeQJm0tGNgUiASKzTOGhP494ZbhaWBrirjhrp2NAsz0=; b=e
	XuTEMOzVm1Ypnf4LUGyxeBl30QBPbf4rOj6mRQKOpAp2HUESTxmcZAhddJJKjRQ0
	DbV4abF7lj3xb7EUdf0kXHT63Kw9S1qsRzyEvzy26KF18ksFAgu/Qx1NOzmf3pO1
	ICTfWTO6WWzT5Wg28vwASOcRm6CcxcVHp3oeiMPVWA5S2dWTau1hl6k3oMU+v8Qp
	uOWYLxWhAj0uj70d/y9tZMnAqai7O1dcQEqvECkTsChlKFcakdUZB90bet8kW+rB
	0/re7N0ha454MkWWEzlCUMVH7QAltBI09gGEMXTRYX5mVhW+UKuUeVNzTtLIRmFF
	cXgA6E/VIFy2FNkS1rKUA==
X-ME-Sender: <xms:MVevaSygKFgZprH12fFPy-mlFquI8DdHghRkD1-BN96BRV65vdDXnA>
    <xme:MVevaVuylYtOjzw_oNm47tBXIC9lFfyHzXR3wHzDYsXje2Rt5DnVbOveulQ3nOJ00
    BIXf7EIjCN6j2zoL2MmzLP2Sd70NwyFdXP8hEfjku7BSdh5hR-b7gI>
X-ME-Received: <xmr:MVevaRu7XHdR5yxJjSBYXCVLDmrWE4cmOAKjJ1c9gt3ZdwI0wG8rPHtB3mTQfpyCJm_plwHkFH-LiYquSDLiX_0vph4cG6xWEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MVevaSNwRPKCFB28qjlWBpc0XJednEca-q32jngQEqOeaFB22Y-2Xg>
    <xmx:MVevaX2siMjWFDvZkiDnayZi98oXPKB7WD0CWgLGATNfX1NQyVgElQ>
    <xmx:MVevaWNA96CgZsWu7T2VMTpd_Jwh0L8dIvsj_1cjUo1p8SGrmUg5tw>
    <xmx:MVevaf1lNlD2DH7lgu7N0VFhjF8MDWzt_hd8dyV3B6o6REZy7kgsag>
    <xmx:Mlevad1p2JiXG_W4d_uzRJSXPI3fYH_Ph6vmhp4BVG9KJ7GbNylelwDm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:26:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: spell out "replace fully to pretend
 to be perfect"
In-Reply-To: <32e7a75c-f8c3-4a2b-8865-ab48330fd4cc@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 10 Mar 2026 00:19:52 +0100")
References: <xmqq34283b12.fsf@gitster.g>
	<32e7a75c-f8c3-4a2b-8865-ab48330fd4cc@app.fastmail.com>
Date: Mon, 09 Mar 2026 16:26:40 -0700
Message-ID: <xmqqh5qo1t5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Mon, Mar 9, 2026, at 23:15, Junio C Hamano wrote:
>> It unfortunately is a recurring theme that new developers tend to
>> pile more "fixup" patches on top of the already reviewed patches,
>> making the topic longer and keeping the history of all wrong turns,
>> which interests nobody in the larger picture.  Even picking a narrow
>> search in the list archive for "pretend to be a perfect " substring,
>> we find these:
>>
>>     https://lore.kernel.org/git/xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com/
>>     https://lore.kernel.org/git/xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com/
>>     https://lore.kernel.org/git/xmqqr173faez.fsf@gitster.g/
>>
>> The SubmittingPatches guide does talk about going incremental once a
>> topic hits the 'next' branch, but it does not say much about how a
>> new iteration of the topic should be prepared before that happens,
>> and it does not mention that the developers are encouraged to seize
>> the opportunity to pretend to be perfect with a full replacement set
>> of patches.
>>
>> Add a new paragraph to stress on this in the section that describes
>
> s/stress on this/stress this point/ ?
>
>> the life-cycle of a patch series.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  cf. https://lore.kernel.org/git/xmqqo6kw3bjp.fsf@gitster.g/
>>
>>  Documentation/SubmittingPatches | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
>> index e270ccbe85..f6ec8a3dde 100644
>> --- c/Documentation/SubmittingPatches
>> +++ w/Documentation/SubmittingPatches
>> @@ -43,6 +43,18 @@ help you find out who they are.
>>    respond to them with "Reply-All" on the mailing list, while taking
>>    them into account while preparing an updated set of patches.
>>
>> +. These early update iterations are expected to be full replacements,
>> +  not incremental updates on top of what you posted already.  If you
>> +  are correcting mistakes you made in the previous iteration that a
>> +  reviewer noticed and pointed out in their review, you _fix_ that
>> +  mistake by rewriting your history (e.g., by using "git rebase -i")
>> +  to pretend that you never made the mistake in the first place.  IOW,
>
> Spell out “In other words”.
>
>> +  this is a chance to pretend to be a perfect developer, and you are
>> +  expected to take advantage of that.  In the larger picture, nobody
>> +  is interested in your earlier mistakes.  Just present a logical
>> +  progression made by a perfect developer who makes no mistakes while
>> +  working on the topic.
>> +
>
> Looks good.
>
>>  . Polish, refine, and re-send your patches to the list and to the people
>>    who spent their time to improve your patch.  Go back to step (2).

Thanks for a quick review.
