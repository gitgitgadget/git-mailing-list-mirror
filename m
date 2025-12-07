Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE71EA7FF
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 00:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765067893; cv=none; b=kl6/8HzS0dT1BAgiIfFiSPzv60v5XYiDuw20Z9WDnP2f8XPV9jUFd3nVTWhdN5gMwFrbNo9jykhNkkBvmDvqagEVyaindNrkAdNEGWBLu4aIyh2XqaIvFtKlwmcKpbmGXJJhJZcEl69L2mxBBq/A4oGgb+JZTJqWX/RzpkdbhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765067893; c=relaxed/simple;
	bh=6/jymCef/yFn6LEhSR0bHE3o5DJ5fcLt4cf2+Fo9TEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h/dUNJx+LcBxtTo09tyIQ78kMvQPHld0tr4VfgyEF4CjRsqXC2GkAsZeoTpOqcVJhtQO5RjpaX9KdUViq7oTbHTQnPBpYhv/37T7lbrrhXC0XjtBXX+7KOArsdhPJC+76yAjBnf0d+8pW/dHsLbuwdaSW9qlQ97z/S4kwnoDYXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DqowF3dq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBe22vdO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DqowF3dq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBe22vdO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9AE32EC010D;
	Sat,  6 Dec 2025 19:38:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 06 Dec 2025 19:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1765067890;
	 x=1765154290; bh=7f8YrUQ3iC9FPsTObc5l/KnEx47knuq/YITUXH8aINs=; b=
	DqowF3dqgghKCU/TVRzKafR+p6+QGIgJa2MJelAzTsFmhbaeGxGtV/I0aKVWseIP
	KmZ3CbSHtxUfvMQalQ2xGbj4/pWG8zqme5CdDOlAlo1ecH3XHO60vrWucmUmoILn
	rCMau8+BHJ84XGpeFMfrZFtzt1o2VoanbrJdupCv9hNwRJg9+u9sYhVnewyv9dLd
	ECwbjHYGk8GU6Ikqp+N7chCNdyJqG0gvparOn8TVQYucQCvdDmpQkvbRofBrk8mp
	Ek/ZfiHpITfUvySzEysTi+iGD2gxsIOPxwY0BS8TG20I8kYMiG8SbwXFSyAxNkZn
	/di/c/IZYcmRsTXfihYHfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765067890; x=
	1765154290; bh=7f8YrUQ3iC9FPsTObc5l/KnEx47knuq/YITUXH8aINs=; b=R
	Be22vdOxaPgbgJf5hPGDg1/tcn1JyhYtGZGhBHQTd3I0XyvQxFkYQahQsMhk8jx7
	FP8p9FMzXIChST8ehBoN8uNpwsp7XH4xKWeFUW6RsLUDeyuJRPq1qzUXrkHj4EGF
	h+kP7WGIrkcEC1x3SvwjsnRPoD/OYEpGR7B1h5VZ8mSE6xsgAQh2CB+F+9XAjE5I
	ItZymh8jjq3UPcAh0aNnQloUOrQpRE6fNQAUkdXrRktTgNco5PKaz9wwGRJv827s
	CGGonLo2UJt5YitNU5yBT1p+74nch427VCXHtIn4PAQMhuXQoL6UaLxlzAs/60/z
	3za8ar1xHxgTQaw0jNu1w==
X-ME-Sender: <xms:csw0aZhdqgg5yC8aOSz3i_CFJirbEiM_-uuVBfbp5iYB0AgCGzBMYA>
    <xme:csw0aU5Q7fPkODjs9Nz57VTTzc9ogo-nyrEVnxp46IMduKIptXaq06RchJOvS3C5a
    yUd-JhlpNTBmRqf16hZsw3HodZzijUXukzE9SRWW9dJ24jQkNChtFE>
X-ME-Received: <xmr:csw0aRbYK2EefNUgVywk-72hdVqIh4LcyAHL0vvKPtRQXdUYnz9P6oTSoTZuyBeCbXefs-gCsyOA5zoZl5P4po0vPT3BqsvRJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephfetvdejheduheegleehfeeivedtgeelfedvffdtvedtudffieekieeijedv
    lefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsii
    gvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhifihhkthhorhdtvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:csw0aZ7vt5FKLypKo7chE4gWY1calkHnCt_1ca45wVSEcIdARQc3pg>
    <xmx:csw0aUC3VmscYcK9ALvb5JbMmTgHsTL8nbgAwEr3-hAqSCIknVEOCQ>
    <xmx:csw0afffiw92dWAjRu1AwNlhwqXX2DPeLPn31Ywf5_IkFeG0pXpeVw>
    <xmx:csw0aTKOs0nSVExVxmwbngleHDOlmHkHgNDDNVZdjZsYvfCTt-x1dA>
    <xmx:csw0aVLD5HnwmRcSlLxo24AKOKrO3ecWDjqhshxpFepTnAGHl60HsFmb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 19:38:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Wiktor Mis via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Wiktor Mis <mwiktor023@gmail.com>
Subject: Re: [PATCH v2] completion: complete "git -<TAB>" with short options
In-Reply-To: <xmqqo6onjfwl.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	27 Nov 2025 13:59:22 -0800")
References: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
	<pull.2100.v2.git.git.1764174391776.gitgitgadget@gmail.com>
	<xmqqh5ugmu8d.fsf@gitster.g> <aSf+yrfJo8dRIkSo@szeder.dev>
	<xmqqo6onjfwl.fsf@gitster.g>
Date: Sun, 07 Dec 2025 09:38:08 +0900
Message-ID: <xmqqh5u3nn2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> know what those short options are good for.  E.g. I just learned from
>> this patch that the main git command accepts -p and -P options, but I
>> have no idea what they are doing.)
>>
>> So overall I'm somewhat negative on this patch and in general on the
>> direction it takes us, but if we do want to go in this direction, then
>> it will definitely need more justification than this.
>
> Ah, yes, I totally forgot earlier discussions we had long ago, e.g.,
>
>   https://lore.kernel.org/git/20070205024704.GB12917@spearce.org/
>
> Completing potential values for a single letter short option is one
> thihng, but completing single letter short options themselves,
> unless the completion script can offer a short-help somehow, e.g.,
>
>     $ git -<TAB><TAB>
>     -C (chdir there before running the command)
>     -p (enable pager)
>     ...
>
> I agree that it would not be of much use.

We did not see any more comments on this thread during my vacation
;-) so let me declare that we will discard this topic.

Thanks everybody for particupating, and thanks Wiktor for attempting
to make Git a better system.

