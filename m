Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7CF2EBB9E
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196021; cv=none; b=ZFiWmPDuFhqNf+s4h8bRGm912vpCSV38oMMaNATIm1udjRerTaCSH4stjZL29U8oirorclpOi6iRnxwokkaCD6ooyrdyadeq0Oa28HfOvzuzwjN0kxxdctHDtltTJ82dusj4SPMngBzq/QOnHT95F4OVTnDH396xW21q0GmnGtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196021; c=relaxed/simple;
	bh=s9xHGxJcOHsrzvhFhYdDwgY11F0/kHbhJC/16SL7hKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pOiT2UVpRtbqIuMePUi/K1ptUaxAARW5wUjU0RIED49aHTVAALAfBWQMh60YQxYFRgymbmngqOOjcnTc/N+tVblblyf803/v/oAE3yTUfTa+au74jCAWPiFxk+AL6VazsGYqykXaLmQHP2aZyCaPOVbUhb1NKdhuJyHcKHcw6L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=myzjt76q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nDi991t1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="myzjt76q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDi991t1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 01A23140023E;
	Tue, 22 Jul 2025 10:53:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 22 Jul 2025 10:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753196018; x=1753282418; bh=N7tNVILg3h
	0TkNRDAZNn93ztNeRTbt8ip/ydd8MIBcM=; b=myzjt76q2FFFLQyOW6OSGp8OTE
	qebjz9q0xLt+eHZTIFeHP60oFv4yDHZSS4WztEqzXFmzbabxHRKMKRMswLBfP0z3
	HfW+RXxf/jHDniGwVao30rChpfCsx3yDz+qWe2APdl4EZqYwLLK0szxreBCFd5Vy
	Iqbk17ZV8r6MkU26CAZYdXB99or1PFS+k3E7FJh3KJeztaIgu1D0T9pW8+EpcfQx
	Ko943fZay57lA/VhFgTj/08MnNrCttPxm8Tp4v2i35Mx0gP6r49oWaQHxxKDcxhg
	Pr7GYqVSA1AbALZSmbm1YdiaobwbXewRdn5st76ILAmcxhnjh1AGmGz1ynCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753196018; x=1753282418; bh=N7tNVILg3h0TkNRDAZNn93ztNeRTbt8ip/y
	dd8MIBcM=; b=nDi991t1iR+7lsisU0/EsCQVuRkjNQC1RXFR5YfiWXOyF7ZyDuU
	HRkQFWXklepspIB8XDILAmQJf6a+F/g7Yyxb8uhK0CrS6wXPJivKw27ipm6020cc
	pTshMV61ZEAogixH7ssqz/XKM3w4UWQusbNfpH363Z7YrTR/JfPl/mRo+AXaarXn
	ZvfYjRx2WLkQLJNugRXWKfa+iyj53+VDsNXTDtPOdRkq3FCAgdVJZUj/+hYOYDTe
	qSm6w1NpcKy+tqf7WkV9a5gNnB5QJlaH8oRI2ZfW09lo++dcN3cKh9beoeAMVFWX
	ra+FqQjY0NOnSIafIntYhl1yuL1YNAzX0qw==
X-ME-Sender: <xms:8qV_aBddJJ-B8170vQ3jjO0DGRArqpWlijY-vS0tfDgJ5g_VMVLjYA>
    <xme:8qV_aJxaPJ9X29vxrDdovWLjPKpuztRhVLtVy2dcQJ9zk2GGM0fHSA1K-QejWioYQ
    LfyKd7_rW5lP9dx6g>
X-ME-Received: <xmr:8qV_aHHKCq8W4HehldjafZIYEflBb9SSu0_uFOwqmwZ53MaunJkcJJkbKIyq--FgCMlDSMD6lhZUKwMpIyMzET3FN21-7Co0XmgMgGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehlhhihfihkugdvvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8qV_aNzt5oQM9EqGRTjRNleKS2NQAbt0tFQbIgSlwsHo0quUEa85lQ>
    <xmx:8qV_aIs8bW3t5wtsc7e_XjVKNmH3QGj4vbW7AG078FL0a5yqgrGgJQ>
    <xmx:8qV_aK289p0G0ST051-EsETps0jWpTdEe95SAd4kZLjB48c5GnY0wA>
    <xmx:8qV_aD-qOgBY3mYT-xx-N2eLe-HwnGe1avh9xtDdw58ABmBjvm0MpQ>
    <xmx:8qV_aHNoUAyXzaGN9btubg5mIkcUyKsU0oS8zywB_1fGwOgYzQD6tMs0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 10:53:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Hoyoung Lee <lhywkd22@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] t/helper/test-delta: close fd if fstat() fails
 after second open()
In-Reply-To: <20250722082643.GD862006@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 22 Jul 2025 04:26:43 -0400")
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
	<20250722081219.1086866-5-lhywkd22@gmail.com>
	<20250722082557.GC862006@coredump.intra.peff.net>
	<20250722082643.GD862006@coredump.intra.peff.net>
Date: Tue, 22 Jul 2025 07:53:37 -0700
Message-ID: <xmqq34aouvim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Jul 22, 2025 at 04:25:57AM -0400, Jeff King wrote:
>
>> >  	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
>> >  	if (output_fd != 1) {
>> > -		if (dup2(output_fd, 1) < 0)
>> > +		if (dup2(output_fd, 1) < 0) {
>> >  			close(output_fd);
>> >  			die_errno(_("could not redirect output"));
>> > +		}
>> >  		else
>> >  			close(output_fd);
>> >  	}
>> 
>> Ah, I guess you found the problem from patch 3. But it should have been
>> squashed in there, not to this patch. (But as I said there, I think we
>> should just drop patch 3 entirely).
>
> Er, sorry, I meant patch 2. Counting is hard.

;-)

Thanks for taking a look on these patches before I wake up, so I
didn't have to ;-)
