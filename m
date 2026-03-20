Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F03033D8
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 01:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970520; cv=none; b=ePMhx7RdqPWLN2rBenfDNZTR3MgXc35qqDqHca4/pkjAjo7OP+0MR2pC42X16Rf3/OzCJNj43j7izwkYwLI8ZFnuZpL/WeSNl9EnL3K8qOwM8/qnag3z1Sw91S7M/0QFKqqFYUk8cOgfXSeGcvNkritAudHu6SKL+3XSN/8VLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970520; c=relaxed/simple;
	bh=BWZW/ggXFwvBi801VOxc8ukVJmP4QH+QX3VPisOV4/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DfUrkzgP6MtNym0oHC0qo777evlMEQesxK1tQjjaWJ48HeBtq7XGoSNfGBzLyIJr6xpTE+pBKyHIKSnFE5rntmu2eGdRMDQPyZLlpIHFBSsgpKMDuF2LMMLmhYzhD43lxPsDPER+Gitzb/ljrvRWf3JKDMToy9l9nRZZHEd77A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOFC0aZR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwWlBPSy; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOFC0aZR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwWlBPSy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1459614001EA;
	Thu, 19 Mar 2026 21:35:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 21:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773970514; x=1774056914; bh=w8fg32M+A3
	8SUpvfYNv6/xXJSH7YqT4MK5HQNQr3Y1E=; b=kOFC0aZR+dV2JO2lN0idZ9IG0y
	jAN09BmBm8KCWBDKslvQcnazEr5q7YJImtOj3m4umZ+Xd6GTdKSX8oNkwjunKx+9
	jZPqjtpaCbYpTpC1nSqJJWxNExDrv7Kp/7bY28YGDDiBFVjCURdJKPN24aerSt7T
	Nutk54li1ZTeK5mmC8Y1WPLq63QKodbQDAEZoGsXxEmkRik5eaBhyE70YhCT/Au3
	qGhmNKJJv9g4jc1scslU6C4k+YHVjfYLeHfdHhanVoNpuVI/lUucXGgMAQ8g1eza
	nxq5zKpS810jbIFD7D87ReY7lIyMLPmgfT15ZSlGSg7RnH+Yr+DM2oXvLYeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773970514; x=1774056914; bh=w8fg32M+A38SUpvfYNv6/xXJSH7YqT4MK5H
	QNQr3Y1E=; b=JwWlBPSy+8NgBmUMGViiB9PbREQN6XctqIxdVw74Xv3Np+r7EtI
	8BOmsmc2mDFTi8tP/3aY5bAURCsKIrzVk5ItqWTdR4sRMhi4WqXhnracQ5q0X+7G
	PZUuXv3jvyyDXOgTc8EpIoZYa2D//s/HLaVHuLAmHpQJBUjYe6fsCVQVaWBRP6El
	Mxpct8klv8NIoGZx9oFL/vkg3E+99gj0D1GOGnQ0bxx4yE2ai1dLwr3ogXo/QUxo
	G5OSxV9Z8wO4zEi5Z8F+LW3hxY8PDPOAhxs785h/XEIY5QuUWpOn5GLQE10UTpEC
	8xEFzL7pK9zZ8CMwgl6PlEGRabxagbjoWNw==
X-ME-Sender: <xms:UaS8acATEW3cyfDcSyaaVpcib6HFGIAa4sPf63ajpAbLBV2yst30dQ>
    <xme:UaS8acX2I1ajviUWyrw2t42ND0OXqJuhFE9EYwo3hipVzRwqC6tQvGEg3MfTrOqUU
    cMMGMg8cwtP8FDkmRhaM9dNTxFetjm3oEckYJPiyseDll8s5BQ5LA>
X-ME-Received: <xmr:UaS8aaBF4v3P6CjahXiV8k0yZSoCbqujpRfqI7EfqF5aacIRKDy5Cc1v4rbs-sIr5m4KKF8QrkOq3FgV8DUZ37db77zbYPe3vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:UaS8af-y-6EyXotU1Bo3GodsTuNf1L00m69Q7g5TArNXmThNZVwJKw>
    <xmx:UaS8aRFk-8cx-nXX4i8BpNeXkW7Jj6KvbRYJu4eXld-UJbahJZ971Q>
    <xmx:UaS8adPHyRrGhpSJeZuf2ax0PJavX1NpgGjSRllaELpClA49_KCMFw>
    <xmx:UaS8abc5CIXSIW7BHRE6tYL4MYQNv6Gu4i6iNZ4AB1zeFvgTZJFqhg>
    <xmx:UqS8aQ-Oow5_eWSEAj4f82JazIugOieDmnFTZkMv5ONjUa90o9Yp58qL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 21:35:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Subject: [PATCH] object-file: fix sparse 'plain integer as NULL
 pointer' error
In-Reply-To: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
	(Ramsay Jones's message of "Thu, 19 Mar 2026 22:49:06 +0000")
References: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
Date: Thu, 19 Mar 2026 18:35:11 -0700
Message-ID: <xmqqqzpfgu5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Patrick,
>
> When you next re-roll your 'ps/object-counting' branch, could you please squash this
> into the patch equivalent to the commit 2b24db1110 ("object-file: generalize counting
> objects",2026-03-12) in tonight's 'seen' branch.

The topic being in 'next' since March 17th, that is a bit awkward to
arrange.  I can queue the fix on top instead.

>
> Thanks,
>
> ATB,
> Ramsay Jones
>
>
>  object-file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/object-file.c b/object-file.c
> index 35be7e58cb..3708b8f18d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1941,7 +1941,7 @@ int odb_source_loose_count_objects(struct odb_source *source,
>  	} else {
>  		*out = 0;
>  		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
> -						       out, 0);
> +						       out, NULL);
>  	}
>  
>  out:
