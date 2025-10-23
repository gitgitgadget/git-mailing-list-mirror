Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACA3446CC
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240000; cv=none; b=qTraTx7+QOHaUfJ2zuizCDIg3TuXeHC5NbnTPSVvIGXpMDB2ULyx2vTuBNxIgA8NN+oOv78HuNylJ3KLFOY3e4ap2IeqJGfQYZRos8FIJ8/0oWIbbZqYBz2LUgIKzXuVqY6fVmxRdaKd0I7/q0WMBEPp67WJYGQO6bu85YOsuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240000; c=relaxed/simple;
	bh=P5qz+w5ci/o90tEadE5w77UqQ1RJzLA0z4VBtdFAisg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jw4vZ+ziSBkKeQD+1+Ck6c1fWFsvdFLdm7eA228cNhmcI4C5uuePM7BTg8NK5apYmL7ruE3t8cIngIekoaGbAfWeUfL9pbJ//P4Mm3VQmytPZLbfCd6M09XCQpvOnnDfoFeyvGs49qzt/cOA8IVOeWyppUL2+lT7Ex0V2obAlW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KMTa3ky1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vsk8z/5V; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KMTa3ky1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vsk8z/5V"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 67E8AEC02A8;
	Thu, 23 Oct 2025 13:19:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 13:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761239996; x=1761326396; bh=wS9Z6+7ffA
	mQVFrq3BsFWXTHzk9xk8EY5dwK/+xIpQM=; b=KMTa3ky1HWyaqSmB8xrVkiGENd
	5Sm4rPyKqke1uE99eLHBDsXAf3Tk51kGPAmCkDvj12s5/uta5ZAC7ewm75Yq4S8t
	HbqgmaX+3ci8+QGNo3fkFFhapf2XNAUUen6e3uiZNflYEwYwBM/Oj6K3XdSF+m3m
	85fzE5KI8PLMi8xo6MoEI9iP2kaNaHYuWY+wRpAHcWmpFI8Nj9rE8joroPw/gpJI
	ExwddmPkzLxei6LHEp5eteO4LSBwO2P/Ip1jiDmyMYEyrw3k1NTPwGyhC8Mu5MmH
	a7lFoloh6iVFYEmvkJPquG0BnTUEUqsyo2bEUAtAP1JP52esWCFHt0e1W2mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761239996; x=1761326396; bh=wS9Z6+7ffAmQVFrq3BsFWXTHzk9xk8EY5dw
	K/+xIpQM=; b=vsk8z/5VbNNg7lwM2gNNC/YAKpvUnM/mHwQOk6/VtU2j1ALT8CO
	T092MFMJRHgJtTUb7/uht6TIiCmiU51mQ2h4INQTovyqtlRmJZJI/ThZemN+wh+u
	gQ0LG3SeEkjk28GABU7IcTkwErUlLys4XVYyO7RN0F0AkZFkl3ltGRduwfUSBwpt
	3l8kXviiIFFZ98HKIPs9aER4Txyfn4MMf8N0DS+dQ3fUBDnzaGSlpitovarlYH/g
	jhOi8XkN2YJNbJDvrGn9Q82UI2TYzX8DzJPhn71SIIb12mwSg/BANR1fofWzK2Iy
	MVk4tH/lQhzX1Mu4NFTIuidZDF2xMXLKi0g==
X-ME-Sender: <xms:vGP6aMdsSrPhc8kNDbMj-Ja80yOCXZCRkD3B0swkU9QcfHLPSSvitg>
    <xme:vGP6aFEBDCmo_GNC011P6n9QoJBNkV3LJicsuel-tPmMVVdEiU8jbq1skSsRfVzs1
    A2WijoZ0-ZmMFBPNle-a8cry6kY2g7HwoQIE5wAkAZTpbCf8pkLiA>
X-ME-Received: <xmr:vGP6aF3oCVtCk_ITohq9O61nFOYMTMOKDMJsNrnsFLZWeia5SJRqdQ9RO3v0rPvy3CZeIyREV12oDwhXlL7ehtV2uwNDmI459f64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqjhgvshhs
    rgeiiedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vGP6aNmnWAtgUPQZ-XI2tZtaJerNhhgNFe122wonXnWqQLEy_v3Lbg>
    <xmx:vGP6aF8qrprVZQotdoHnMtQdj7zW_6C89_Ry6Z3P-yU3lyea1_rdrw>
    <xmx:vGP6aCq-ycvPKjTufZy-huDhkQu_YDQid0fpCJcn_BpadyjZgMV0zw>
    <xmx:vGP6aOn7sBYGbBC1mEYpXLvF_-3gsf68af8H5ZII25P3aWCxp-W8qg>
    <xmx:vGP6aE3zbIuA5KaEITENTlVFsfC27tQ4jIHLuZgDLGoyXKuKzDtIREsh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 13:19:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: QueenJcloud <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [PATCH] docs: simplify help sentence in MyFirstContribution.adoc
In-Reply-To: <20251023124801.334-1-qjessa662@gmail.com> (QueenJcloud's message
	of "Thu, 23 Oct 2025 13:48:01 +0100")
References: <20251023124801.334-1-qjessa662@gmail.com>
Date: Thu, 23 Oct 2025 10:19:54 -0700
Message-ID: <xmqqjz0lv8lh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

QueenJcloud <qjessa662@gmail.com> writes:

> This commit simplifies the help sentence in the MyFirstContribution
> document to make it shorter and clearer for new contributors.
>
> Signed-off-by: QueenJcloud <qjessa662@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 91c6296ffe..f0768bd03c 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -26,7 +26,7 @@ useful additional context:
>  [[getting-help]]
>  === Getting Help
>  
> -If you get stuck, you can ask for help on the mailing list or Git community channels listed below.
> +If you get stuck, ask for help in the following places.

I do not quite understand this change.
Where are we getting that longer and less clear version?

The text in our source (both 'maint' and also 'seen') has

    [[getting-help]]
    === Getting Help

    If you get stuck, you can seek help in the following places.

and the above text has not changed since it was written in 4bb4fd42
(MyFirstContribution: add avenues for getting help, 2020-01-24).  So
there is nothing to "make it shorter" there.

Is "you can ask for help" materially better than "you can seek
help"?  As a non-native speaker, I cannot quite tell.  Both are
equally understandable to me, so I see nothing to "make it clearer"
there, either.

Puzzled...
