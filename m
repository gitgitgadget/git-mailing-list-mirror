Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4277A639
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754242756; cv=none; b=mFNHWvdZeacezmPOj17xmZQ4+KNNHcdmFx9x4CyVaYFevIPUmBstc5ggHGkWtGSMmMKLgwR7Kcl/MlOweYKkbxIsk50WHrO35zlXWDilNMD8v/Gz7Xbp8WZtv3G5SrWnrsbFDpdEh84El/13lpSKIS6RXnrVqbot3bXUMfl0BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754242756; c=relaxed/simple;
	bh=65imJ4yA9y4gyqMv4WC2bFKo+Apmw8d0QsOFqirOlNo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYpM+/8GntH5pbETvCaEh9DPZmO5tahZXYSR7LzyOsX0d3iXNeATUuyLSl/kpmDjeFAK2uUB/qXEzFYJ4s23F0mNVnAuL3HgiNZlKl+yzjT7zlntbyPCj18yW7DjNpn7f/4LEEaq3y3fgpkkarrQ8QgnY1F+lQeZjGvgM4WnARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q1/MR4Vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OI/lxYE/; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q1/MR4Vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OI/lxYE/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 209CE1D0003A;
	Sun,  3 Aug 2025 13:39:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 Aug 2025 13:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754242752; x=1754329152; bh=pSdnXilkNp
	9+8Tcyd83a1KFNLWFzfrcQrOh7wMJ4W+8=; b=Q1/MR4VxVbTYZXqwnzWEAY+8fm
	cSnJroseYuLnWwK+bFGva/YB8RrwGr6YhD4ykJGVuneAMpJ8Uny3Oz03de5KnymT
	Z5mii4oje9Uo4BPlOfpT1XZ7fzXswNkzARRZJQPn8Nb7n7oW2wXyuETI6IQpePKg
	88dDnniiYEhesKrlDOm/GK6WKlTxw5/kMvGFsZyoQCD9Hmv/NPXDVO2YdZzP0dxH
	V7OaSmXDMlfiUf280WVjwq4LibPlpMxIaJ1+lRl/uM6Tcy2nawft38Yg/dCjIzGs
	9q2EcmrbPzxIukXp01x5xrbSaZdjdfnYkP7MCumCK6XBN1Jitac+FKQ9MN3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754242752; x=1754329152; bh=pSdnXilkNp9+8Tcyd83a1KFNLWFzfrcQrOh
	7wMJ4W+8=; b=OI/lxYE/gHukaBRgxIwf1E8cX/V1APVaCkIYXinC0P4ECFAoPnf
	S+sjI5TVHjpN9Y10VvcCSyl8tm0rMHTaKHbm4P0Pr+2qythbRSAzY/oqN2M3kLqi
	iGaoNhR22vLXCE44oMUHaMeP9DHSZ2ghYj83auE5zNpcP1DyxAKxs0+rlG/CT7FP
	B1rU1KX8J0uvt7LfaSmVwiXF65veomoleU2yVMYQdUfeqNxJVhmg9Sc8ho9WO6EM
	wPpSmBmxDByI/9XXaCwrA/aSgWIXT9DSke4L9eXNHuZd1POLbEQd24QDz7/HqoYl
	UVf0S4lTjPcwHxVE5lCu6cNyhXW6Ov6KQRw==
X-ME-Sender: <xms:wJ6PaF2UorOcCoCqFK1_FbPJiPNgYWB_YoU6aMUcn9wxmnFGkV14VQ>
    <xme:wJ6PaJB3zYzG6s85mYR7y2SlBXi4YdFQg5EMKSH0k-had2aXs2sH4npgCyHFzktCi
    WpCgdXC1RpOWskbaA>
X-ME-Received: <xmr:wJ6PaBhmkBpxSlQGVt0M9te7Zs9_a4DGCCG-_YLlJoQrSAEZ0D9cWBWXGqO_oe7rbZBuP_NWPGPfCOcLNk99-bIOWN_oxJiJuXrcCWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddttdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghhrhhishht
    ihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wJ6PaLOWkyFhshT9GrSR6Q6g49E2OzO0oOP1gJrxmkEsBh1BKYzWbQ>
    <xmx:wJ6PaB_69-wy8ktODM7lGFATe-8OChpEd1cTMfTmAeLwwQAlSzqWMw>
    <xmx:wJ6PaMeppKm2Fwlfz9OuQ1xeeGxJwUSHWy3yOKvMkMU_ARrBGP4MQg>
    <xmx:wJ6PaAz0zHOvbLCN5O691E1JNbQHfdM4VrgGUflX4ksWGi2S6n9jvA>
    <xmx:wJ6PaEArTizg9eZKlYhwdxk6dlSI823km-EkGrNAMQMesHHoerHpSapr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 13:39:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  ps@pks.im
Subject: Re: [PATCH V5 1/3] t/t1517: automate `git subcmd -h` tests outside
 a repository
In-Reply-To: <CALnO6CBCynikVcZq17SxOTfwuRMM86cv+BWQb0zZoOdMYX-72g@mail.gmail.com>
	(D. Ben Knoble's message of "Sun, 3 Aug 2025 10:52:56 -0400")
References: <20250721115519.140361-1-usmanakinyemi202@gmail.com>
	<20250803020744.1037392-1-usmanakinyemi202@gmail.com>
	<20250803020744.1037392-2-usmanakinyemi202@gmail.com>
	<CALnO6CBCynikVcZq17SxOTfwuRMM86cv+BWQb0zZoOdMYX-72g@mail.gmail.com>
Date: Sun, 03 Aug 2025 10:39:10 -0700
Message-ID: <xmqqpldce24h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> All fine, just leaving a note for myself ;) I didn't see any mention
> of the changed base in the cover letter, so I was confused. (Rebasing
> onto latest master makes sense to me, but I'm not sure what the list
> convention is).

Once you picked a base, usually it is a good idea to keep it, unless
making a trial merge of the resulting topic branch into 'master'
leaves conflicts that are not trivial.  And I do appreciate your
noticing and mentioning that it is recommended to have a comment in
the cover letter (or a comment after the three-dash line if a single
patch topic) that the new iteration has been based on which commit.

Thanks.
