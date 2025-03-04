Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35C71FCFD3
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093540; cv=none; b=ejvvH23TxSLPrje2EkXRtGiesouh4fTsQIxroJRGkBbTWPPk6wh7sIu+xIUaWQVb7sF5wF+eSALr3GSYTu/Q2EI4tByJqcw/QNWyIVov5DChKQrPKs0IBh8K0KZkYl5qTv9dpnWv55qek2kVT6zaOFS0CQYxU0noUz3u7gkVa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093540; c=relaxed/simple;
	bh=KmOyVHl7cxWtDk29P6hboKJSxX85udsAeheEFTcUi0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uB7DZDN7zY3vfAwWkNdQ0kHKygRJIrXebRowei86WY+bYX4BBagJcaw80gV/tPy9mcCm7fbA6vUV7G+Qp+f3yPyEYLWdZKnxWzDSFFRPc1KNWxVeQ0MYkYYYmog2MlY6CaAKHPQXRd+ch3a5GqqzgqL/gkvmz2nJ/9OhsU17vtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aI00wYsE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6J4wPrRf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aI00wYsE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6J4wPrRf"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EAC0E1381135;
	Tue,  4 Mar 2025 08:05:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 04 Mar 2025 08:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741093533; x=1741179933; bh=GyU47ofQMv
	s1fMV98oT9qXwuoqfeRCfPzLX3/jtIP90=; b=aI00wYsEt6m1g+tyrLMNRlqpUD
	S/A+meFiliv3tkV4+ldLfr+JNpNa3paZ9LQvzvibBfrSSwtePhWlQtFhQJDLRNNZ
	Mbx/+51ZTKpAOLN6o3pUR67fmdtx1tHim80LMXiZhNBBAHMiJ5+Zcxkg6OqePkng
	cHL8b11R6J1xDKfYxSv1+MpOVGVbdKxNLdebtTKBWuLajDcaRJV/RW1vAbJ56KnH
	ixqd3HbmoenrqaczGV/3WODWnWO+9X+1EvtApq+d7vSExYhVXyKYUPEWVkVrP169
	0PvzMRmepMlkNnKOS5WuzNUyawdosGT3bqNxctRsCIE4RjWcU2UnQz4xvOQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741093533; x=1741179933; bh=GyU47ofQMvs1fMV98oT9qXwuoqfeRCfPzLX
	3/jtIP90=; b=6J4wPrRfVIk/h4TiMvYwwk0p1D4p7CvzBC/SAoDs0qIaFSFsK73
	uuL5Gir4NPfjB6zXUEet0WuYhr/NA1rYi0XQPB0016k1n3zYM5tqFVtqVZ4h2OiK
	kycATQbUFiEDyfksVTEBicmSDkHCRLvz4T4zVR6lXBGu+rc5BxhbO0i1wz7fRamF
	Ouny4RDcrjsx2ZTG9cXhIMJ9tlxygp23j6V6tW/yna7cnWBWzqmZv3dD4fyhdNtI
	HNMiRj8MHbZz4jM9NIfp0bYbXiqgigFT1xzjnewSdnXHNROt3eBhBOA6nkjY/cPI
	VxBfSOjEKAt1qdnVQ0Z+sJWN9dJJxM3R1Lg==
X-ME-Sender: <xms:nfrGZ9kUjhxQpdSl9YZ1HOSVDs1Q0sOu6B8GJayDf1e05XXrAesgrQ>
    <xme:nfrGZ43yO31LX0b434qVn_H0sQk4XhVa53e8vfzQZUdqckCxk5sBIgXfnt-tNaey6
    wrCGXdf43uLr_7zaA>
X-ME-Received: <xmr:nfrGZzpMzQVc-5OOftTdryS19ugypuNQCh1eIJg_Pxf7ZEccguOit4YsjWXiXoblAv3agScqobBj84qYFR2B_9mit7ffbZtwuisB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:nfrGZ9n8QME1-mO3ts2xSJoWa550N89dVSBOBU05OCiYpNdVFkl7gQ>
    <xmx:nfrGZ71iJi7rjWHLRM4Fp7BIXCV_nDKWrUxRoshOtD9byVdtXsB8GA>
    <xmx:nfrGZ8t0MJAzxhcOD7HRDgyf2081oI18rXtUbftRXncUjqGo96BQYQ>
    <xmx:nfrGZ_WtURW2vRKF12UUcHjx3ltbKPsqhWq7yfGm9UrH2vd_aSnnPw>
    <xmx:nfrGZ8yIyIrtlG8IwIwZJ4M5WmS5twqzt1iSlE_hWKuznat_zGdkSuzv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 08:05:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
In-Reply-To: <xmqq7c55vhj8.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	03 Mar 2025 15:08:43 -0800")
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
	<xmqq7c55vhj8.fsf@gitster.g>
Date: Tue, 04 Mar 2025 05:05:31 -0800
Message-ID: <xmqqfrjtt084.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
>
>> Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to format-patch
>
> Hmph, instead use "--rfc=GSoC" to do [GSoC PATCH n/m] and please do
> not pile more "extra" on top?

Or even --subject-prefix="GSoC PATCH".

Once you stop treating [GSoC] as if it is an independent prefix,
everything will fall into place naturally without adding anything
extra.

To put it differently, which one wastes more precious horizontal
screen estate on the Subject line, where practically only 50 or so
columns are usable?

    Subject: [A][B][C][D][PATCH 0/6] This is my first contribution
    Subject: [A B C D PATCH 0/6] This is my first contribution


