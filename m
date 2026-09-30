Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733164DE707
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774952; cv=none; b=G1btQAHZB3tpqmxmQDklA/HfsPN/DN/qGFCTUMBBo8R/cnCm4Rj4whRUt4EUMrebNwPMSEI1N9V9qoOHJxQBF07gLVv1twBesqdrgnSgMIgopxkSs7DvWW2Zqq8uiF/c/M+59oEzZjp+CJOPG5I1ui10ej6YI1XqheSEmFby9/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774952; c=relaxed/simple;
	bh=6f5detvUfg7Fu+G6FkWaFeLFIWwUsKXkVl9WEfCqYR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckBNttTZ9Nq7eoQNjcY4LLT6kqcH8tNgKBhv8+BXpffR8q91R0BUzr7/QSvNflKU2WBDhu1iR3X7II5Hm1qDF26zwMxGAD9qX6Mu9NQcYV0YRcLRezI3sA3PCmOISFpXdEwuSdV2YBlM7infkchrygQnRpVre83C0YInFcfLFPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZQecO9n7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cilo6wAj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZQecO9n7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cilo6wAj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 03244EC01C3;
	Wed, 30 Sep 2026 09:28:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 09:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790774937;
	 x=1790861337; bh=l8sndPrMy6U06O9qCCtXkK3OiP8ABY0vogjRCTcRzWo=; b=
	ZQecO9n7XJTWQ2Pn/ob/NkWqm6YGu1v+TtSoOqLiaF+Zd0Vs7t4m61KQpuSqHfO/
	OrcB6gRIa20ySlp6GXob8gF/BA7rIzdhgUiKjkLbtdIyz1Ukicuei1MjdzsjzsjQ
	rKirT8nhVhkLDqRqwLOufZ47h18U5sjbL1ZRd2pXkH32WP7tbQUR4UWc7p6nfkOn
	9DSEox2iml+Bd9cCwF8mNVseKczqpMbHHSKL+Uk63Ho0CDgI5Dx6VW/dTd+Pwlyj
	P+1F5QgP4u4Q/iVk0F/bhSlvaxi1gSEJ+XDMdSSbmL8FisVbLosAZLJMabastiEg
	+m8y6QA8YI2InAIRYyzA/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790774937; x=
	1790861337; bh=l8sndPrMy6U06O9qCCtXkK3OiP8ABY0vogjRCTcRzWo=; b=C
	ilo6wAjMZPxCaACnV/NlubwlqBCOAMOCV5drM+pQIZA5JwPXZy/9e+fc3nOZSgU9
	MMUtF1tCSn5rBzu9DvtE/cXpjgifk7txeIV3XHmxdNT7IfK2Yhr8xlPWmOKeKArZ
	syFiFtN+k+e6SrrPFiP0X66B+OQcBCju0vefG1sAX8eOkm5OL+OKs9JGfJd+vVvh
	bx9o3Xg3JNFXrLuHIgQ+wDmB1LXHkyx/rQ2vi0FX7HQsq2wjXfji1P9PKzQWxDlb
	7y27MipbA8RCK4wNhtgvTiwJnNjfZ6vZJQJsGVfhOiUw3RjYvYA7hwq9mnCPeAL1
	cBRH8WKvlXOQ6ar8nHi7g==
X-ME-Sender: <xms:mQ69ajvqXaPEE3LWwEATNxdphGouivcY0tj5P7FEpfYJwuX3dAgyAA>
    <xme:mQ69ar60o7nrpqO5c_kNu4jD8dcQypPacKCPnWGFq9vJIfXbWx9ARk6TU_UhH1PHf
    ZyKi1ZmWHKunXzKFJ9g8K9c2RuyaOL8ueHqAXJfFbCI-d_qiYjb5g>
X-ME-Received: <xmr:mQ69akKxvLY0ewo4nOwW1lAWjaol7jkGUpKxzZ9m5lHnfk8vqYeivQ>
X-ME-Proxy-Cause: dmFkZTE0+QYzlK9dihxPFxOEeFly/D3OWNygZXb6Tat/6jl48D5ptIs0U1jMYcwq14X3Mz
    DoFrLLQAYN1ngbXuHli7kR1vUjozzYDUY09voZN7dZ9qz3X9kjELGJpxfssde7SPuQHRSw
    p9xsQdgSlvI7CfYaMLclHJHrb4NTsB12JobYQb0vhnenwukTsBnRX6J+REqkIMpPtbONmM
    Fy3HAj/eyRZZZP9+BBPIcYNK5sQzGulBcjknqXvFzzacHmvBlQNrCWLAkj0QgWS6ZID+OS
    cZ4b40eECkAcxGQ0b1sLCLciqXaShqVZr8/fQ6wrjEFasUBkyM1T7cqWeY98jSir+D+Etm
    liiiMqRAtJod/fR7jskipwKQAKgk19eSKim8g/ZzRs/gB8Zk8AeIOXM1aUgYEALiQ0ZEn+
    PY6wU5rCAiLcvaTG2S8o58RwZS+ZG/glYmjq/TQcWSM978rwNYu3Tch2MqdDjrLUVZXq70
    +FgMJ5do+hLG2dtPmO/8/+BvtF2+wQdxCCXevtqKSEuKCdvnnbDpPcsukQ0AI2s1REHDjx
    hCJYpQsLBobKVh8fV23+YQnTQTmxJhtIsLsqaUrN7HL27RbCf8m6TFHulopYFOD+7SEuSo
    OLG00uqeXgy2MCLxQrkbp8z9w+P4DgbFrdcIMEcJXDS+d0gDji6YXdHgXfYA
X-ME-Proxy: <xmx:mQ69ar5IO-PET5kZjh2SmaCcjrNIDFFNJu_4t4-EQazCmsobVk8cPg>
    <xmx:mQ69anwoIkGmneAeF10pPX0t_jeE4o6oyFLq-F2lQcxshPt0hB363g>
    <xmx:mQ69avYlzFC04SontAZjJYCU1OXKWIyqdyNABa2Xp73cxaKRQWa2YQ>
    <xmx:mQ69apQ3opF6BdCPEl6I2VPRrXW0QNF7EJgPiiJn2NWVICQRmmmUig>
    <xmx:mQ69asBZvjlMvLQS4CgCdJd7xM0oLq_Z2vjCrHFYUpdutDoalyKce0oe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:28:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb60f7cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 13:28:56 +0000 (UTC)
Date: Wed, 30 Sep 2026 15:28:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC PATCH 2/4] doc: gitbreaking-changes: replace msg-ids with
 URLs
Message-ID: <ar0OltAkeTiCx81c@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <URLs_not_just_msg_ids.d1e@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <URLs_not_just_msg_ids.d1e@m5gid.xyz>

On Mon, Sep 28, 2026 at 12:41:26PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> This document has used msg-ids to reference emails since its
> inception.[1] This makes the text a bit more terse, and is perhaps
> also convenient for people who can use msg-ids to link to messages
> in their inbox. But we should consider how convenient this is for people
> in general, now that this is a more public-facing page (see previous
> commit). And I suspect that most people will be forced to paste the
> msg-id according to the described URL template:
> 
>     https://lore.kernel.org/git/$message_id/
> 
> Let’s instead replace all of the msg-ids with complete links. That way
> everyone can jump right to the discussions.

Fair. The links may of course break if at any point in time
lore.kernel.org were to vanish or change its interface. But if so we can
adapt accordingly, also because the message ID can still be extracted
trivially.

> 
> diff --git a/Documentation/gitbreaking-changes.adoc b/Documentation/gitbreaking-changes.adoc
> index c6b974b6d8c..9aba419efc9 100644
> --- a/Documentation/gitbreaking-changes.adoc
> +++ b/Documentation/gitbreaking-changes.adoc
> @@ -59,15 +59,14 @@ make the described change that can be easily understood without having to read
>  the mailing list discussions. If there are alternatives to the changed feature,
>  those alternatives should be pointed out to our users.
>  
> -All items should be accompanied by references to relevant mailing list threads
> -where the deprecation was discussed. These references use message-IDs, which
> -can visited via
> +All items should be accompanied by links to relevant mailing list threads
> +where the deprecation was discussed. These links use this format:
>  
>    https://lore.kernel.org/git/$message_id/
>  
> -to see the message and its surrounding discussion. Such a reference is there to
> -make it easier for you to find how the project reached consensus on the
> -described item back then.
> +I.e. they link to the `Message-ID` of the email on the mailing
> +list. These references are there to make it easier for you to find how
> +the project reached consensus on the described item back then.
>  
>  This is a living document as the environment surrounding the project changes
>  over time. If circumstances change, an earlier decision to deprecate or change

I wonder whether the information on how to add new entries should now go
towards the end of this document. The target audience is expanding with
your patch series, and most of those new readers will not care about how
to add an entry.

> @@ -332,7 +331,7 @@ The command will be removed.
>  * Support for `core.commentString=auto` has been deprecated and will
>    be removed in Git 3.0.
>  +
> -cf. <xmqqa59i45wc.fsf@gitster.g>
> +cf.  https://lore.kernel.org/git/xmqqa59i45wc.fsf@gitster.g
>  
>  * Support for `core.preferSymlinkRefs=true` has been deprecated and will be
>    removed in Git 3.0. Writing symbolic refs as symbolic links will be phased

Nit: two spaces.

Patrick
