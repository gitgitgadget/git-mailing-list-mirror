Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C1339B53
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622297; cv=none; b=Sbjh+Bi0cG+VqYOlFXEnqny4uC8bIGNJYtXuPnkesJ8Z5VTWa+XJSLAzl3iWG0I6IzxSeWY9L8Qqya8oOSjuYAYGk2zMepHS8pKv92NKdCgkUWSN70Fr7rZqKk2l62/CXL733UQziO6n0I4EHHuuyXaqDfBAxGQN2AKG17WwsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622297; c=relaxed/simple;
	bh=WEescj7TTWWhiY4klbQZLlQ04/4DV2OhZlTG8hpO0yE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E6+PfWUceh5nCVIjTYSwgAb9Da2dFrjtpfOl9sbbRVDyzMga5BaOwFhp22GSEgM355oS6AO9c0TXDNyomtHBdJiMS+4YpnkekNbzweVhfg2n26mu2PndTFpIN+XvbiknM7uQW+NT0dUPRyAoqpqueDXGOcNIXhvpI3AY7kAhuUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eLk2UrYY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0Qv/Kt3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eLk2UrYY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0Qv/Kt3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FE8F1D0018D;
	Thu, 16 Oct 2025 09:44:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 09:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760622294; x=1760708694; bh=kJhtwBOC2b
	DRGQBfSI/QG5KdciVI0vg//tn9XR5xkp8=; b=eLk2UrYYqCV+F/MGopJBIlGIsb
	6usR8MlFXgqfISje2+g25lAxrs/gP7b/l/iMKH9el3d7ied2Sf0rYKe4lg0MRzIQ
	CzpQHz8xGncd+Ku694tJmaG9/9NBrke+nQkrRwiHSy6622HgLN4rr3mDi/UHmWTI
	lrTkN2MqQwx7y2REIgerWedNZaAbU9lczgjudSet23bgZB4wrSk0S/70pndY7lU4
	SDO5wNPZvGFW+ARlWAFZ5tJ+CiecI0sMGnCFOp6ZkqwZRMGXFZN5gkn5gEGybeLf
	oEJfbTTrHN3JcNErUyJI9BYoz2XUGm2rXvAux/vtwoBVomu5oICU9eRvgnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760622294; x=1760708694; bh=kJhtwBOC2bDRGQBfSI/QG5KdciVI0vg//tn
	9XR5xkp8=; b=e0Qv/Kt3fg/UxrVfVJWBtjao7zhE5AR4Og3cKeJFBxVTP2654+C
	lsenn7ocYyt+rywvrkih8o+0L4q/o4yCzCCvgk2XHr8xyyT3+GMkBSHjktFFveX7
	FWV2bFtCwsf3z/P/A+LclNPdGK94S7XlBRYO+I+0girHA3PobMimA2veBmYp52Sd
	dIA8ehOoMgpbBanOtnzdrKmI3FRlFMgZP2hpAscDrc8jytFl2oHevuqiVGo7iYE1
	n04gwrTJrAzS1reGtbIS3nr+RBQ5e5A6H/aWv79Qun0M/Zzp5yoBxu03UnvDH5mZ
	cth8KQoVaT94h3NtDSAsHkd67JSWkeXD7oA==
X-ME-Sender: <xms:1fbwaDXpUC0J57fKNAWXamLT513WqcI83aJ1H598GoqB9BjUJoh7oQ>
    <xme:1fbwaPQqRud_GOwCVY9FSWI0gfB39LZQh6kDTNVMFJ5_BxUreF7Ij920SiRaD7wsc
    lLoL0-1adv844Lve0aTzfFEy7Q2N6IL71JaKKTkhE1EpljIW0rvkg>
X-ME-Received: <xmr:1fbwaJPcKv0fE-jIKI9lgX0Nx6Vqd8KmkmhsCYVNd6ka-tKoSd_L2B9wirc9eEYOaqfapb5fNZhYVvh6HYvkQx-oSLPTjJqToRyn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeigeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhi
    nhhvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:1fbwaFRs3QJLWwQ_YQPCytFLPmBWI9Wh4X59LymqycyO7NDAbxSk2w>
    <xmx:1fbwaPhmgEMDYCj-bzm7YMgxnnPMvaMw3EFG2u5U5KS_qqBIOA6BKg>
    <xmx:1fbwaG_G_qWsETFYtCR11wrtQerDMNhk2NQuffWWQj7jx21NqOeBAQ>
    <xmx:1fbwaOGtHtLKmM-EfVuKQT9MLcTC-I1vyTjnbJ1ybkrUZc28zmLu-g>
    <xmx:1vbwaEb4st2bfKeK01E-Ffdq0b_VHizrUQeCMTaHgPOG6rSsAKyjM0pm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 09:44:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Martin von Zweigbergk <martinvonz@gmail.com>,
  Martin von Zweigbergk <martinvonz@google.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will
 be removed in 3.0
In-Reply-To: <aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Wed, 15 Oct 2025 22:28:20 +0000")
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
	<aPAgBPLH4QYa0ceP@fruit.crustytoothpaste.net>
Date: Thu, 16 Oct 2025 06:44:51 -0700
Message-ID: <xmqqh5vz7ygc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +Support for "git diff X..Y" syntax will be removed. Use "git diff X Y" instead.
>> +This will open up the syntax for a more consistent interpretation of
>> +"git diff $(git merge-base X Y) Y".
>
> I feel like this is going to break a whole lot of existing scripts and
> probably more than a few forges as well.  It seems especially bad that
> we would add it back in the future with a completely different meaning,
> since we'll have some people that use 10-year LTS distros that go from,
> say, Git 2.51 to Git 3.xx, where the latter reintroduces the syntax with
> different semantics.
>
> We've never really changed the meaning of things like revisions or
> revision-adjacent code in the past and I think those kinds of things
> we're pretty much stuck with forever.  With that in mind, I don't think
> this is a good idea.

I do not think X..Y (or X...Y), if accepted by commands, would never
change their meanings in the middle of the commands' lives.
Teaching "git diff" to complain and barf on X..Y is a possibility,
but to do the same for X...Y, we would need to come up with an
alternative syntax first.

The same for "git checkout master..."  that detaches HEAD at the
fork point of the current topic (so that I can "git am" in a new
iteration of patches on top).  As the syntax "git diff master..."
is symmetric with it, if one were to change, both should change to
the same.

Thanks.


