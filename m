Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C8A3ED137
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275910; cv=none; b=qUeuWz1op8SUUQX7hVFuzABolfBJBn2VVHKZm0uupjVbY+l4ca600cRTiownbdZ2tHmCJgKHZXFC6Y4Hn7Frq1AtlBw1PArT1f3/FzIRAAolaeWjh9epo2Ig+ix3pGbFtlXG8UFmcjI1eXbud+hsy1xA/FnckXdug+5la0IGZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275910; c=relaxed/simple;
	bh=Fl2TDJBA+sE2HaCnJGWQRamXokVv6uEeRUQpJ3aqARA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FkXiTZZ4oML0T/qW3cNfM3H/CIzupYNsyzKckYI4BuGslZDLyILF/ELul3yuxrhbhrdcNku0cAsxK4hKoiOrlEKRBA1gyymRmT1goyqyM/fdoxMhLUABuuSbeUrhEZFFmprgyE2ut5XkhhhcsKwgRUyQTb+sTaggAyPFrx1WBrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LHUZFuqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zaem6iBU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LHUZFuqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zaem6iBU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 384C67A00EB;
	Wed, 15 Apr 2026 13:58:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 13:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776275906; x=1776362306; bh=YLRFisogbK
	Q5ql4AuJ+UXIoIOEr0UDbMtklp2kaqfxs=; b=LHUZFuqqzZpF73zomdNjdWRlp1
	GwLmGbZ7zNLYzz4z5r29X6kUMxI2FttUNi5iedPN7sFF7ubuGNV16ZvcfuWNtLiV
	gjPj+OE6VAU6OZn5uaN31dj1j0lknVWj0jtwCr+rX8M9HZ5IYhLqgDRnraFF4y4k
	Kfw8CUw4rMeyg+BWT/Lv0hBG3yEfMYNyDyH0aI5M234VkaXmblAsEwEIDW3PEh0M
	Oq08JXkmTNo+PWkBxhn6SuTRDgl1o6NNhoaUZXMET3laQQ+MrWbVn0Xl7cjHpFE4
	kOZB93RdcTRIW+0Hn5YQtGDTKFDfiwGfB4iZwgGTXzEm7wq2eILxEFy++IMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776275906; x=1776362306; bh=YLRFisogbKQ5ql4AuJ+UXIoIOEr0UDbMtkl
	p2kaqfxs=; b=Zaem6iBU48gu8iWqpx3+Z+P49Tkp1x45Ro222txhBg0N6srxcJN
	mwoXKHYtS+IL32OMLelV3ggNGYgoZqP3L60fW7PNBFsMuXj/pLfwmuX1p0c5oj6q
	1IPxPQHoad8S6A4s3i0BWC+EjI0lFIZggoeHYuoPe0dPv3OMwPXyeirQqLlC58bM
	XM7Vd4FpSws7SwviSAK0yLl7rebvsAQ7GaSiCaW2FG9oaorDJHeZ6YoIa3zwOdZe
	WPhFylB02j3dPl5UZRyVBBZHhUyq8gWDiO8EwMAtGy/7SHk4sB97rYqjfJdh1xL2
	qBAUpUF3zIwEKUDCpkDfJ6xgvLAxb2fPprQ==
X-ME-Sender: <xms:wdHfaRBViHLdiTFT3CnscVGCix0CG-O1sAQWFT1ZrGfuGPJYBfFevQ>
    <xme:wdHfaZn3hd0dkd8XlQydrkukHL4zeD6Gy7lPNcZqt_fxagYF9vgW6LpjTOtB6ql8D
    dZkxu4n5r-UHP8RzW09IYuh7zOm3-lkCu74YzHCs1T6NyTq72d5ug>
X-ME-Received: <xmr:wdHfacc9ZBExgMhDKbDTt_zyoWUs40Ev0DQw5U9D1-wZ4tGklPYIzNQxNuRr-b71vAW-4Fyrb9GXHp1fWq_VkDtMLFJ9H_Jhiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprhgtphhtthhopegthhhr
    ihhsthhirghnsehhvghushgvlhdrvghupdhrtghpthhtohepghgvohhrghgvsehmrghilh
    drughivghtrhhitghhrdhpuhgspdhrtghpthhtoheplhhishhtsegvfihorhhmrdguvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wdHfadQSDIuPWTbWNQfX0H5LRM-_R0HYv8yvcpcFS_Snb2GDvR7IVw>
    <xmx:wdHfaTs6C9R14YV1XMzUV_RcY--YZoKE9_hSCdZWYEM99AQKFridMQ>
    <xmx:wdHfaefqZayz_OhaJT359lSLguAtaFf6juiwW5KMIDeuaFTYtx_cGQ>
    <xmx:wdHfadYco_9d3Gztd6uUSkGn7xA7YvJHNGa7JAzRnynh40eXFDyDcg>
    <xmx:wtHfaZlRsF3RY7ToWnHmAtscMc4pU_MX3aYmiPH21KuZpEZDZ36dnuCc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 13:58:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Colin Stagner <ask+git@howdoi.land>, Christian Heusel
 <christian@heusel.eu>,  george@mail.dietrich.pub,  Christian Hesse
 <list@eworm.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <xmqqbjgr1g9q.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Mar 2026 16:06:09 -0700")
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<xmqqldfv1gxc.fsf@gitster.g> <xmqqbjgr1g9q.fsf@gitster.g>
Date: Wed, 15 Apr 2026 10:58:23 -0700
Message-ID: <xmqqo6jk6r7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>>> Depending on the history graph, subtree split can recurse deeply
>>> enough to encounter this limit. Rewrite the rejoin-deepening
>>> algorithm to reduce recursive calls.
>>>
>>> ---
>>> Changes in v2:
>>> - Rebase on master
>>
>> We have seen two iterations of this series without anybody
>> commenting on it.  Is it a sign that the topic, or possibly "git
>> subtree" itself, is of interest to nobody?  Or is it that it is so
>> well done that nobody had any comment on it?
>>
>> I don't use "git subtree" myself, and I do not know of anybody who
>> will scream at me if I break it by merging an unreviewed patch, so I
>> can merge it without worrying too much about fallout personally, but
>> that is a tad irresponsible as the maintainer ;-)
>>
>> So...?  Any volunteers among those who have a higher stake in the
>> program than I do (which admittedly is not a high bar to cross)?
>
> FWIW, I can see that [1/3] is a benign clean-up that should not
> change any semantics.  [2/3] talks about the variable $sub, which is
> used elsewhere, is not protected ...
> ... in "git subtree" to verify), but otherwise the change looks benign
> to me.  I have no idea if what [3/3] does is sensible or not (and
> again, I'd rather want to see somebody with stakes to double check).

So, yet not any volunteers?
