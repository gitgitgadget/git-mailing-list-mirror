Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081F1E104B
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728420156; cv=none; b=RhWmfdwGSVHMezPth1BnAhHjAIaUYqPfj5LiOXIN56EUuY5098wFvbnYn4hVYwh5ZoArdfNrNHPae+b3H9NjL3Wl7F1BHq9u7QC2tHPVxhAZw1VjZAWX3/UYpRf50KP77RrKBpnVOFwYVEy2azkm7MnSRMAssqD8toVODwrsl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728420156; c=relaxed/simple;
	bh=v3Bo5PmrcfpwDBtpIbYqCDeYm2UaZK6y1NvNaGXF6WU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7/xSifdNRnaiNDphNae/+aUC0N0gTdp6ha7Aq1blSFtIS4tqS4yt5uiCHq9n3WQwVt+p6ZFOtB1yUEF+hAQvlsGLJnP56lJcwYTeMv3g9QeSZKUCbY9qH/Z5mDdzi20r9ClneqWZohwu6xeZz9jt3ZgwbcqtWDOP6Yr6c/9xI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Da+faUOK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S734101I; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Da+faUOK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S734101I"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 648211140171;
	Tue,  8 Oct 2024 16:42:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 08 Oct 2024 16:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728420153; x=1728506553; bh=/L7LP8O9nR
	fYDvQn0KpyhBVbStgix3E5Du5HkM0/Vdc=; b=Da+faUOKcHADOPvHhKIkWwWrlr
	CX8dFPWArL3UWK6IF9hvuQ6dSixBX1rGEwYZirFsLQ0BIddM5iuYuBTqCYzXDztp
	V47mLreuAFdJyz4Kv8er+48Qdmh5vzyDonYu9JLwpMgQcgQ5LWNXcjPdf1VDd4Qh
	hKEIM+UXULrl1IqeWHn1x+4ffgUTEBLiDPpzE7nm4TvUPUrqkr5wjXw/SEWc01G5
	6OuFlkMta7BFgn+FhJBOn1WYU2J9nTbkP32yjBvDH0mpqLKzCuvVut1/D0NHP1ie
	tvKvb6GfHgaBqyhyh55XXBb3pfCJlV+wA1/84PHGnUCrf6qvZMMeOZr2/j1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728420153; x=1728506553; bh=/L7LP8O9nRfYDvQn0KpyhBVbStgi
	x3E5Du5HkM0/Vdc=; b=S734101IqrkWe8914vP36T8YyboVi9hqyWhpxKCpndUY
	goH2O69WBPpI9IJx6QFax2u0k+UlxG08oWCZ2w+rh+YGLLELZSGpZS1QO2z0b3rv
	j6YTVVGdfagRHXoiw9VQblrjgKbIo+fjiZ8PMHANlBnVYJaQKQe0Mgjb+aFpEcfe
	1qhdEcvC0odkB8LWiX152EYKXeSprkAqwfkOP5MxMBfwaAhXnGQQnA0blN1MByUv
	rBlejyfA2JktN/QOT3Zacbr3ug13+LAYm/GAyhHQ4wd63TMejtxSkqLedIaLlJFE
	31pvKxhHU7ueNFc9PJAoe4XFu99WnbY0MyX1ipfogA==
X-ME-Sender: <xms:OZkFZz4zKSTtADgMrSwmaCCNXLdF3YK5vd4CAJDV4R_TOuXNg66_KQ>
    <xme:OZkFZ46hsrK0Bt-BGlllMYdtCpAnahSK3Lv3YH6P3sEyy2j8F01IsEA8x-UrFV_hC
    Ts3nl_Yn1NTNR8Htw>
X-ME-Received: <xmr:OZkFZ6e1fJ3yoc_hNND_0PfgEBDDAHwbcmlkgOOWGCpIHpaOsdfghrkls0Zdrzod7434QjudfJdgTXx1q0W2kiLYDG62Hle5weOw6HI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefuddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohguvgeskhhhrg
    hughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OZkFZ0LOJKYuXuDuf22RECT0hFc79O4oASpCgwPessmmJpAnhv5c_Q>
    <xmx:OZkFZ3LiFmycMMShhMkR8vCAKR8eKzw7Z9sG7jZO8fLeJcBx1TkA2Q>
    <xmx:OZkFZ9xyL7OZ-1GxGC5hNYZRpkHt4eRvovcaMcrM6xsw7_-M9_GcRg>
    <xmx:OZkFZzIh0wkgyeXYKehUiyY68HQ4x99ty03gAp3C-wOB9G-XAUNpjw>
    <xmx:OZkFZ9iLqDy0z2irIhJlgljYTC_p6v-awZWY8s2_Kfbz9oVJrRD_8_8p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 16:42:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  newren@gmail.com
Subject: Re: [PATCH v2 1/2] doc: merge-tree: provide a commit message
In-Reply-To: <b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Tue, 8 Oct 2024 21:06:05 +0200")
References: <cover.1728298931.git.code@khaugsbakk.name>
	<cover.1728413450.git.code@khaugsbakk.name>
	<b1ca5cae76845f84147d385cc5ff47f219cd471e.1728413450.git.code@khaugsbakk.name>
Date: Tue, 08 Oct 2024 13:42:31 -0700
Message-ID: <xmqqo73uz5qg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> Provide a commit message in the example command.
>
> The command will hang since it is waiting for a commit message on
> stdin.  Which is usable but not straightforward enough since this is
> example code.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---

Makes sense.

> -       NEWCOMMIT=$(git commit-tree $NEWTREE -p $BRANCH1 -p $BRANCH2)
> +       NEWCOMMIT=$(git commit-tree $NEWTREE -F $FILE_WITH_COMMIT_MESSAGE \
> +           -p $BRANCH1 -p $BRANCH2)
>         git update-ref $BRANCH1 $NEWCOMMIT

The shell should know, after seeing $FILE_WITH_COMMIT_MESSAGE and
encountering the end of line, that you haven't completed telling
what you started telling it.  Do you need " \" at the end of the
line?

I know that it was suggested to use a file with message, and I agree
with the suggestion, but then I wonder if we want to be more
complete and show that a file gets prepared in the example to avoid
making readers wonder where $FILE_WITH_COMMIT_MESSAGE comes from?

E.g.,

        vi message.txt
        NEWCOMMIT=$(git comimt-tree $NEWTREE -F message.txt
                    -p $BRANCH1 -p $BRANCH2)

or something like that?

Other than that, looking good.

Thanks.

