Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F027B4F7
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408526; cv=none; b=VeXkTsUa5rF4RuEiKZCZaQy5tBrSOffSAPFWZ+890Fgrmci7s0f0UgurKu07jbX6CEjlY9DN28/sHxe4EdKBq7mosXPXyglwiWhY+hhEM34hO88KLatNfFWbSCXD4aEJazHEjqcKEAJVHQTh8h2qeTwaK9SyFrW23yrfUCid/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408526; c=relaxed/simple;
	bh=VyeOJLZeBFvywlUn/6v1WugCMRGWH2lEdlqwGBDXLtw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iiY4IjTo4pOnu5tVjISssCTnhBDS+b7OcgAI8lfqOv8jUa9n63YXoOh8V8LQEaPP3maroIjItnYzWk+kCykWX1LmkoQbSEZFThM0xxE4l2QPRE3Y7HveigQKvg7BsEu3Y1e3h2pf9KUxFj1+EclopxD0JfHQQ4Fy4EVMdsD6fV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jObkStDp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xkcm/71h; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jObkStDp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xkcm/71h"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C3B371D0007D;
	Tue,  5 Aug 2025 11:42:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 11:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754408522;
	 x=1754494922; bh=u9bURdSBX85hfTMY6eEeO6kP9oRY1lNkBlmV7NFLOvs=; b=
	jObkStDpKAFViZ+7072wkCScv7k1KlTvMVLV3I1CrUg7CicXg0sCgJc3qvYIJqTV
	Tft4rvnksuDBE/F98W8B7sHDaQmRmBkKMOgJIhLTKH16pjAgsrEcWWGd4BkmpM80
	RcCEDZ/h0ZT66Zc0/YNK0OotcH+Wyk9WihkQj6OgXCVbcgqxjdgdf/6UZE6MijBV
	ThGlXV+s/OZL7/SzC+UOhPCM6F0DdVBBQXQui/bFpKelYUcgV5ATuPLjYgFLGSk+
	X0T/aWfsQKhj5TvasM89be7AuP66BfJj2a3IxwlAj+Q3o3ZlwTjVrrhBf2z1aZxz
	21//kZf0aRkvCDS7WbgiCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754408522; x=
	1754494922; bh=u9bURdSBX85hfTMY6eEeO6kP9oRY1lNkBlmV7NFLOvs=; b=X
	kcm/71h4YCgKcTwi/bv98r7HhTfXj9kSL+TNkNTawRMkmk1+yTBq33LnZUT38f2R
	SuG5i2PtAyK4caeHvgSdgbnfmESw/2tx/3U3xjQ+ZPXRGmUBwVGrma7EqsOQgPdr
	KuqjVQ1qxZBUu/WIMRmORSFI8IXWZ8n2dxrGj4qyLOy3lEKDmPsd/KFqiGYItQJX
	UUqboMiWkDRLswqjH6jL/iNLUYxAAxxnFAm6OY/r6Dxm1ObcVxRTq7cRueqyUS4/
	SsJjCrwdtJK3KMgs+TrCGenwF3CUxWlflcl+E6OJo3XTi6E0rla9B9FAH7CsaVqY
	iE7AwHbgELi/do37hwe7Q==
X-ME-Sender: <xms:SiaSaNnrfeNevWT18hV9y0lc52fkFcmwOJPoofsYmCzjhRYU5h2f0g>
    <xme:SiaSaDZveAaHM1n9rykW7N04yBgqO20s7-w_VWuuKjy5JirKqLGRrTNzGMpmGKX_H
    3bEbV5k_ov5czm2aw>
X-ME-Received: <xmr:SiaSaAPsGShXcNRqm8zeDHH-ZBsyqQSVOvzi_7UQacVhjDit4CqVzai2XYbopsEZTDONdpLtQePOOw4MKe0NCfVnjYEILzvKPyPPgM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepghhithesfhhmohhrshgthhgvlhdruggvvhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SiaSaAZlGTeF5vmw4HLKanyXwCaMrm5_SM6rSEmNcyfKWnbMrsEqcw>
    <xmx:SiaSaG21sepjMbf0gv1HuY1taoPb55svgTl1Na6DmWBtRMDi0y1PGw>
    <xmx:SiaSaOdAEeUg71vU2nnA2NVSBzDJNPKaf_La3t6xmemwzgSzFvR54A>
    <xmx:SiaSaPESyUrAKsdSNW5TpCuJvy_Uo6OHm3Xao1cW4A3BHToJ-aLoxA>
    <xmx:SiaSaCzwqw7PNAyark3B8ZmLqa4-dtxDjF0ToiLK1jwNBPLNciaZwXQR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 11:42:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: FMorschel <git@fmorschel.dev>,  git@vger.kernel.org
Subject: Re: Feature Request: git mv --after (new flag)
In-Reply-To: <4d08a37e-2c12-4e3b-b6a6-028e2d6c0a22@kdbg.org> (Johannes Sixt's
	message of "Tue, 5 Aug 2025 08:03:46 +0200")
References: <1fa7a8d8-3ae5-4913-b3b5-21d8f67e567d@fmorschel.dev>
	<0afc01b2-11a2-4f77-a858-7a444e8bb1d4@fmorschel.dev>
	<2f505f75-112a-4b71-bb05-ea0cb7731cd7@fmorschel.dev>
	<4d08a37e-2c12-4e3b-b6a6-028e2d6c0a22@kdbg.org>
Date: Tue, 05 Aug 2025 08:42:00 -0700
Message-ID: <xmqqh5yl3hdj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Johannes Sixt <j6t@kdbg.org> writes:

> Am 04.08.25 um 16:05 schrieb FMorschel:
>> This is a request to add an –after mode to git mv command to explicitly 
>> mark a filesystem rename after it has occurred (analogous to mercurial 
>> => hg mv –after).
>> 
>> This would allow IDE/Language refactor renames/moves and would make sure 
>> git still detects the moves correctly for keeping the correct commit 
>> history.
>
> I've wished for this feature several times already. Though, in Git
> parlance it would be spelled `git mv --cached`.

I couldn't really tell if the request was to make "git mv --after",
without any other argument after it, do something sensible.  

E.g. after the end-user did "mv A B", figure out from the paths
that are apparently removed from the working tree relative to what
is recorded in the index (like A, but there may be others), and the
paths that have not been made to known by Git (like B, but there may
be others), and infer what happened, and "git mv --cached A B" for
them.

I do not think we have that "match the missing paths and untracked
paths to figure out" part.  It may be trivial if you are willing to
make a stupid version that takes all the untracked paths by trusting
they maintain good .gitignore (it would roughly be "git add ."), but
even if you try to do a much better job and actually avoid adding
paths that are not involved in this "mv", it should not be rocket
science to do so.

But if that is not needed, then we can declare that we already have
it and move on?  I dunno.

