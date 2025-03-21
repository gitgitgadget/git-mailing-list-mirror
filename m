Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CDA433A4
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543513; cv=none; b=fpegqDseL3wJMl4GHZ36LJ767p+Z7bFzY41XzIB0/aSdkHXBMiVK+UKlfOAe9qwe91eR9FBAI0LzC6uymtxGFuaObokqLuHfhYwL29PF5JC+dKj2BhgGmxMKXlelqpUcR9leLSG1UmX56naXfofq9QmCyoy2f3CyLlkNDPLDBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543513; c=relaxed/simple;
	bh=SKjKvnAExAf6e7zWdxs6MZQLPNJx4Uzl+urPZB8oWkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o9mbIwQ5GJzCxhR7+MTIM3U6sMg4eTm0KqP7E/TTHDWS/CFzsX6lL57K0QbzupueEAVc8cceTo9p6nBlUNZot6oYwUoFnB7RmGU/PPy6cv7Y6bzKEJH+7CX5O1phbLfrk/SqA1ebS7msLfbLiPxC9D+5jFpjlHolvYYFhuGLZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o7eZ5POp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GW//j29k; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o7eZ5POp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GW//j29k"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54ED711400F7;
	Fri, 21 Mar 2025 03:51:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 21 Mar 2025 03:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742543509; x=1742629909; bh=zYBzUM5yOZ
	J15o3G2b2dU6O/zG0MvAUN21fiK3+h0Hk=; b=o7eZ5POpkCUlkvuLzzCBtadbh2
	cXfn74NSmf/Z1bJVdYv1KBsdD551XIH76jK8QP5pQr7IhLZVNpmpiZrjN0DdI9qY
	mukBrrU65Ao/1GJJI++SYs4UXr4tTmg7P9YNoUCNks3djcxaSFqDE3ACudo/uFwJ
	F82diF3Wzx5O4Qt3TGriPmJwVk24G/PBGUd61dB++OvLjQ6OJ0gX05MzRPblG/Rt
	3h0pQgbC7wEbkVPaHcV+JrZrRp8oNnhIkAxmjzV9gIWVS3/DIIEax8UWDj1SrtrY
	2kTbo00OEZNnLW50EFdP67y+ucpsGW3amqZPhzgNrT9kic9pzwgaosah9G2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742543509; x=1742629909; bh=zYBzUM5yOZJ15o3G2b2dU6O/zG0MvAUN21f
	iK3+h0Hk=; b=GW//j29k2v16jysBuvLVTQ+7AyXtZtaYRDs2jtqGjxC7fILFpZr
	5ahGQL/2uINGhn5/PhnZUwBdvuStFr8+RGdU62ZS1QIsMBjGo9sgqEhBs0OUdpoj
	2t0TCepLUwZq6FqiRkqSr+22je0hOXRP6GVcal5OE+CjzAu6P1YDh0tZjVCw/k6N
	UE4N7f65Jdqw4g70tVFCCtIIyaqOjf1rZPcXDwI2OZ5xOapsYTFsvKKLDYY9cfjx
	ocsMJKgTtV6xS3SrkEyN7yb8pISqpQmX87dLoMgsanZX6WVT8E8WZjM5H0hHZyg+
	oUeS6yJH+5IOvQ+i3gsWt8wi6rULhRElE9w==
X-ME-Sender: <xms:kxrdZ9bswpvRwC1i9mHAwkWKbSrDHbNQAHasv4WjsP1lfbxwKnzaWQ>
    <xme:kxrdZ0Y3BaShoDYRKHKNjOGBu5v-z2nJDFS1chuIsRGjAgCCoikN3vnxQf-XQgupE
    PR4oLg-N_L0i0-qAA>
X-ME-Received: <xmr:kxrdZ__EySXPZxTyNcpaoeiXk_rJy2iFCfkwkWyZqHpRT29Kvk4GyjeGBiign3emo8vpkTEG-P1RDKdeQnqw1we-YWXU3lcF73hy3As>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kxrdZ7pm3V8xapw27sI8Cq91Tq5vS3InuVVZYTcD8cNqXQMSLWyK3g>
    <xmx:kxrdZ4qdS_f_NiV_qYW9mklp1Es6lpijG1mjupa6YxItKyr3TWAKXA>
    <xmx:kxrdZxSs2qI5bzEPkQNZHclgfnZ2unw3ShKauZ-UhMQRBaIuIThwqQ>
    <xmx:kxrdZwrOwjrWx1Wo-J1ucC1qTda81Xxt5odisB3hLC4MsILTqtxtdA>
    <xmx:lRrdZ9A6H19MYKRB4TKCbMQj58kZhphDvLWlPWMJ8yFAF5xh27kFYV3->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 03:51:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: ps@pks.im,  git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] ci/github: add missing 'CI_JOB_IMAGE' env variable
In-Reply-To: <20250319163328.525284-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Wed, 19 Mar 2025 17:33:28 +0100")
References: <Z9qNNq0p10YJCZYo@pks.im>
	<20250319163328.525284-1-karthik.188@gmail.com>
Date: Fri, 21 Mar 2025 00:51:45 -0700
Message-ID: <xmqqsen6vn1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The CI setups of GitLab and GitHub use a common dependency management
> script 'ci/install-dependencies.sh'. The script install the necessary
> packages based on a combination of the "$distro" and "$jobname" env
> variables.

It seems that CI_JOB_IMAGE is a GitLab invention that is defined
automatically for all CI/CD jobs?

The range of values for the variable seems to be names of Docker
images, so presumably they mean the same thing when used in GitHub
Actions environment?  I am just idly wondering if ci/*.sh scripts
running in GitLab CI/CD says "Ah, we are using ubuntu-latest image"
and does one thing, if it is always safe and sensible to do the same
thing in GitHub Actions environment when CI_JOB_IMAGE is set to the
same 'ubuntu-latest' value in this workflows/main.yml file for the
job (otherwise our desire to share as much as possible becomes
harder to achieve).

> The "$distro" variable is derived from the "CI_JOB_IMAGE" env variable
> set by the CI configs. In the GitHub CI config, some of the jobs are
> missing this variable. For the 'Documentation' job which depends on
> 'meson' being installed, this raises an error since the 'meson'
> dependency is never installed.
>
> Fix this by adding the 'CI_JOB_IMAGE' variable to all missing jobs. We
> don't add it the windows jobs, since they manager their dependency as
> part of the CI config and no further dependency management is needed.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Junio, not sure if you wanted a patch here, since you already had a fix
> yourself. But I'm providing one nonetheless, feel free to drop it.

Good.  The one I did was an attempt to blindly sweep the issue under
the rug by patching merely one thing, and I consider that this patch
is the true fix for the root issue, so the other one can be reverted
out of 'next' (or removed from 'next' when it is rebuilt).

Thanks, will queue.
