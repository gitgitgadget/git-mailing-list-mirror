Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78A17D346
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233154; cv=none; b=lC00wsJsLp3M0Foz1VAxU6QaMvmxRp2/WMqU2bvSdqjK+kq1GeIaTM/e+d+1rQUngq+9eZAAsGls+2TTD5XLyyQ/xg5i1D4LRLvQ3iONvtUlgLHQKfWS8dtY0Mmn/AF5y/lDxcZQGUWJtQbC/UuSMFC7uHxbP0zVCrOkLVbraag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233154; c=relaxed/simple;
	bh=DZPpcu4DqYvkAReI8RISUARXsMfdL4TUtMbkKJR75TM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRuNS815dqYadY/HfoFvFM91DxN8nxqJWmM8Kt+XtkenqEBoiKtIGLaHCqys8IrLTlQIHx/PVD2aJWX2w+PUdNoqj8NFN8JGQU9d+JX+0/TIa0vJKeyntck45tgdDzA7+mwb4CXPwOm6H1iJDYYoD//JbWV7XUlZpBAxI9VOXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iRIuRbu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rRdnh9YP; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRIuRbu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rRdnh9YP"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0CCAA1140125;
	Mon, 17 Mar 2025 13:39:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 17 Mar 2025 13:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742233151; x=1742319551; bh=LcrI8T11z4
	+N4HDtT87gvOOeTKH4go9HPFsWgT9Bq/c=; b=iRIuRbu6mI6ljEfqC5L6XZljjo
	pT7DAHgTxL0ITtCoCe7w1frrv9Jgvmmv+Vl3ORYlhBYkIgvd7oHkyRwuap4Bo233
	A30GrXvzsVPQWbJo2xWOE0jxPpBDe7EL6/2h8Y+bR/TXY9496h+MkdM/SCtYzPon
	eMB7vKcmzcM14Jpvfg2VK8EcX2fSoRr2xbeO0X+mun5C0WlzFlpjzGtqb+zOpCbf
	E+YX3ufA6DsRt+81O55++BHzdGtuLyC4ERQw7yMQMOCk+uOzjdMDARNM5TviVmLS
	F8Xg3Rvs5eDCxJBDcxLFIcYeYK5Hr7FYySatU9xDj2JM40k2Jqcm9SdpaJ8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742233151; x=1742319551; bh=LcrI8T11z4+N4HDtT87gvOOeTKH4go9HPFs
	WgT9Bq/c=; b=rRdnh9YPBAKOqI4S4NDSXpfq7OfEoA8R4MhsGKxI9nhzC10SID5
	yGP/TG83Y+PQYbuIx3YgGS+TopsD56QbAR8Cq7xa4JScsD/FBXs7KhKtaqPXT/gl
	6WlPBO4XADzSKp02oQR7gQBLr/wgbfi5rcD+RYhXeZgQlbsLfBQp0csgR4d+99ky
	P/wBYd3l26n4OQJX+0O7GhCBVjQmr0zg6ssdVhTG46Kf0ThDOu5TFekxzO9Sd/nl
	NlAIuVOx4hJMrlNnrnxdNWSWJciFojjcxNq1x1YI0Y85oIq5BmvQPQJ2fNLeDMWQ
	IBFO1tnscdWacF6GDqia1i3nwZcRxqgFQFg==
X-ME-Sender: <xms:P17YZ6MfIMJ6AtkUA6SlN8O_04AicgG9Tzt4YLyoXYzcEM2Z6sFVjA>
    <xme:P17YZ48GVFD93mFLidFbYfSpwGs-ISti-cHPG3HIJ7L6_aoDnw64vfOpeIWLf-VlH
    kuKXdxZGn4i9Mjpww>
X-ME-Received: <xmr:P17YZxSd37YbHkf3xrs-qc3ISqsX9Bj8xckfYAqmNc-FNNDMSHAD8a2OXgqIxA0UVx5-Vulpb0rHepxRrpgSRgEyfVzb9a8uGQwyhDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugesmh
    grnhguvghlsggvrhhgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P17YZ6tFqS8pb68CTHgcGaptpbcEipC1lpwdTChu-9tZFy_0_0FikQ>
    <xmx:P17YZycQkh9qhQOG7d3FdzbgSRGUUWZGy0pKIwitT7k6eTLI9NQQfQ>
    <xmx:P17YZ-2GjuJPpKfJGd-pMOhOm26ecnkNFAwCIOHvxKDpffjV4KTLhA>
    <xmx:P17YZ2_yAd8UEUqMTZrJCeao3oZJQiPEZ_sTnBeHDwC0rdKbhp9Mmw>
    <xmx:P17YZx7Az0TjWknfonb5tCNI2qW1ULrsuHwwaf0cmBc8rrwfrY8FAD4H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 13:39:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Mandelberg <david@mandelberg.org>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: git switch --force vs --discard-changes: docs don't match behavior
In-Reply-To: <xmqqo6xza838.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	17 Mar 2025 10:19:07 -0700")
References: <bce5a500-76c4-4462-8f99-b17a6f21f7ec@mandelberg.org>
	<xmqqo6xza838.fsf@gitster.g>
Date: Mon, 17 Mar 2025 10:39:09 -0700
Message-ID: <xmqqiko7a75u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> I do not have a strong opinion either way.  It may appear to some
> users that giving a finer grained control is a merit.  Even when you
> are willing to throw away changes to already tracked content,
> getting stopped when you may lose a totally untracked thing might be
> nicer.
>
> On the other hand, I suspect to many others this finer grained
> control does not give much value while adding more confusion.
>
> I am obviously biased because I am accustomed not to have this
> distinction and accept "checkout -f" as a reasonable way to force
> switching to another branch discarding any and all local
> modifications including untracked new files that get in the way,
> though.  But I do not feel strongly enough to say that the behaviour
> and the feature itself is misguided and we should rip it out.  As
> long as that "finer grained control" is working in a consistent and
> explainable way, I'd actually vote for fixing the documentation to
> explain how "--discard-changes" is a bit milder than "--force'.

It seems that this was designed from day one to work this way, or
this was buggy from day one to work this way.  Take your pick ;-)

When 3ec37ad1 (switch: add --discard-changes, 2019-03-29) introduced
the --discard-changes option, it seems that it was intended to be
truly the synonym, but the code change was done in a somewhat
confusing way and added an extra bit (a new .discard_changes member
was added, and is initialized by the value given to the .force
member.  Many existing conditionals that looked at the .force bit
was changed to look at the .discard_changes bit, but not all of
them.

It did not offer the protection against overwriting untracked files
in builtin/checkout.c:reset_tree().  The .reset member was always
set to 1 to allow it.

Later 480d3d6b (Change unpack_trees' 'reset' flag into an enum,
2021-09-27) added the "protect against overwriting untracked files"
feature, and made it pay attention to the "force" option, not the
other member.  That is where this discrepancy was introduced.  In
retrospect, it might have been better if 3ec37ad1 removed .force and
kept only "--force" at the UI layer, internally used the new
.discard_changes everywhere.  Or it would have been even better if
the commit did not happen at all, and added "--discard-changes" only
at the UI layer.  Then the discrepancy would never have happened.

The author of 480d3d6b Cc'ed to ask for the original intention for
reference, but that is merely to satisfy my curiosity.  At this
point, I think it is way too late for the original intention to sway
the conclusion, as existing users of "switch" may be relying on the
current behaviour.  The best course of action may be to update the
documentation to match the behaviour.

Thanks.
