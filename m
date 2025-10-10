Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A973266595
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112828; cv=none; b=ZZsSQLS1Gx4sISWZNzssatBGIhPWuXl5jwbnFcVZdBtLNfYoViPk+dwIqKQOffFY0orw4kZ+vKRhLQ30YMEQLgwhxiCCsupDoDFAzJxDI5YvNqrMQKyBNdaZVtAwa5U0sUiFckRMk5/swXme/1N2LtVx36qp98IpweCQl66PuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112828; c=relaxed/simple;
	bh=CIFyl1JDX2xdjLXmd9EUd7Qokflw9m0zNupOx8/0QM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eVG90bY0svCnxPHJoaR3SlpObyQwA4Q3pC3K9rsaft1pdA4gJkY7wXGwE3WI3/qKoQM9eSVNa1+tJxaE4UamSIke3g/+ylsBPNk7YvSuCkoaKZ4jowkO+eRoeBdHJgUpCyupO4zgBh+IZmjqwOm4WCGGZblslWwSRdd9h1YyTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hHaDcOGi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6N/kwtZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hHaDcOGi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6N/kwtZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 45902140012B;
	Fri, 10 Oct 2025 12:13:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 10 Oct 2025 12:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760112826; x=1760199226; bh=f+ydNCFUYl
	C0ebtO4M8fXhq5mkDNeNC7ORSUCLf9lVc=; b=hHaDcOGipAMyKyXwV/Kr9e9CEy
	/KcMZ2ulvudNq4ojLXr6rfmg7MzYa3tQWkL3Gg0XQVMwPIryIGh3VvZytiWFtbdp
	ef4oPGkKx9qBs2Mb+pny+yaUTgeoEd+evNR1jKYwJM5HTKa5V0TMQ+DLTWU8yvU7
	FwK8euo5z4ZAmVipqZ/gseo8pjAOuTKEo8RcjCVYyfZF4gjV4qkB8ACGRygJHPHq
	RhMxPg3EdPgKfmGFI5WHSZiFWrbwH5yd9R8doJ8azLNFt1+z4ktJYszOcfU8WXWK
	UeoUcWZcQ2LjkYTaVNOx39ml7U0Y19tgg8vZOD3pMXMOJs/SI8UTHaUcySUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760112826; x=1760199226; bh=f+ydNCFUYlC0ebtO4M8fXhq5mkDNeNC7ORS
	UCLf9lVc=; b=l6N/kwtZpyPiLlH7w92ZRftQraSi+9HW7wGtAq16ttGE+RRJwYH
	luEnBiCcDAB0Y26O39JYBGHENHCYdVoEDBFf6qdkyZBSwB6mANg3CO3/vWcfU8ZQ
	RRx//rfGSfzAk49tNxU1jcA0qK6ey1zUYZZICxEqIb839YsN11vEQzFTTu7dq8DG
	NDUrwNrEPBXX4nVQ2aQh678U17oPJIpnluG3C6ipnndm6IAwCKhYdGfmcN/7fNDx
	P4bmSxhJIu16YDwcPhyNWfpgx73u2Ef2oWpbMMeWBIX/6cUtgxModceQsN0n2VQV
	f1GoijcRB1rDxoCeF4EMif2COMvdPVMub2A==
X-ME-Sender: <xms:ujDpaJEM0j4VLTwbLyF1Wq-kfRc3StM5xm6Dgsoyk9mbX5hQ4VUrgw>
    <xme:ujDpaFVglC1-vfRJghKcRW8D80QdEBCP_sJYYVMFad4_UIYvdItvK2d1eKDTyZIDu
    _VnSp1P9eDpJyy5PeewdOMy78gtAvvyMNNBWTsPl_sRFEdbfvNNQg>
X-ME-Received: <xmr:ujDpaAJw_6gFc-rh4lnpXemr_1uhupYo5vSGuFDRllsIVhEFu8cyIA1M6htf1F3pILHHeT-l7SMA2REweBqS-pwdpXrqSejRiMuI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdelheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptefgueffvefhfeffgfevueeuvedtheegvdehueejjeetkeetjeeuffffjedu
    jefhnecuffhomhgrihhnpeguihhffhdqnhhoqdhinhguvgigrdgtfienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:ujDpaN-KXEpKelNNQ0ol_rMgjgUERr-WAUAC6jT2LJ5588bk-h1mtA>
    <xmx:ujDpaLKwAOPTurHVZItpvrINdeix3tOtsWGTJnFiuFyCokm57FUA8w>
    <xmx:ujDpaKl1udR_ISgJOiGVMDgE6vGaI-kXDPehnQpY0NZ95PPXT5boXQ>
    <xmx:ujDpaHMCZMCi5b-RpieX2dwytLON-bo4E553yQxa69sY6dEWSnc4iw>
    <xmx:ujDpaGUZU-mc0KC9lycburZ2uL0Aq1H2j6xnoUnTc86A3lgKT3HPmcDp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 12:13:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  <git@vger.kernel.org>
Subject: Re: [PATCH] diff --no-index: fix logic for paths ending in '/'
In-Reply-To: <de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com> (Jacob Keller's
	message of "Thu, 25 Sep 2025 10:17:54 -0700")
References: <20250924-jk-fix-no-index-path-with-slash-v1-1-6b2028c0de92@intel.com>
	<xmqqa52jjxyq.fsf@gitster.g> <xmqq5xd7jxpq.fsf@gitster.g>
	<de75e7f3-6c59-4f62-8d11-dea33804cc59@intel.com>
Date: Fri, 10 Oct 2025 09:13:44 -0700
Message-ID: <xmqqjz12ag5j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

>> You can squash this in, or I can do so myself if you like, if this
>> is the only change that is required.
>> 
>>  diff-no-index.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git c/diff-no-index.c w/diff-no-index.c
>> index c70f82b805..f320424f05 100644
>> --- c/diff-no-index.c
>> +++ w/diff-no-index.c
>> @@ -436,6 +436,8 @@ int diff_no_index(struct rev_info *revs, const struct git_hash_algo *algop,
>>  	for (i = 0; i < ARRAY_SIZE(to_free); i++)
>>  		free(to_free[i]);
>>  	strbuf_release(&replacement);
>> +	strbuf_release(&ps_match1);
>> +	strbuf_release(&ps_match2);
>>  	if (ps)
>>  		clear_pathspec(ps);
>>  	return ret;
>
> Please squash this in. I'll fix it if we need a v2 otherwise.

Since this exchange things have gone quiet, so shall we declare
victory and merge it down to 'next' and then eventually to 'master'?

Thanks.
