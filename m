Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2932936D
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360210; cv=none; b=VL825Xx+nSNTm0kTYzGX2p9iCDKfh8+DeQ3Ay5tdNcLlO/lNCY0LrwaiKAnHrCO1kPg+eqUKf1JDsjnynN8bhgsklto0H6XGLdE9kM/fVESL/R00M9cz8CPWZQOH25IlDdBtmpSeaKqhd51lb96+0bH1NDx41mCJik56EgFOYNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360210; c=relaxed/simple;
	bh=XpAAc73LKvfzBqtvsVVmtnpadNKaVNCbhaQFknD2mSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMwKahCv2sELSZAMAL5DIlGq+Pe4R91p0vGT4AYGae3dGxQeGR8/gJVxWp4MtngwCcZ9GhdfR2Ep1xKk5igJeLd3zCc18F/687icHstlnxaJzKenrlFwGE9oyjZo+o0GvgZc+IrZoahjGGgkGNe0Duz7wvN3Q2AStHT4zItkYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I4OLMDdn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YWYjWza0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I4OLMDdn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YWYjWza0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A95257A01FC;
	Wed,  5 Nov 2025 11:30:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 11:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762360206; x=1762446606; bh=ZYFTEkypLw
	827TUQKaYOpjSUsGTVVjQyjm6xgmRlKnA=; b=I4OLMDdnSWXJWXAatebDtSdq4q
	dKBeb8g9p9D5Fu7EDOJb0l358BrjU6IGxqenzhr8JXundy5wB9i4R8mL8Qulq3kr
	htttDxU5LzJQTNAljAEVO6CHinoOFvqCBa499mCrOt1sn4U4MMzPQ29Kpi4lMvJW
	IPzuDJKbOV7kdfDm5J/KU85MDb7SWDx5y3Z0sK6mBuGoMVEat9QJPZw+RtrTBUfy
	ejUwi0VA69TqSviWRcLRXhTc2oJLP3JQOAmolZ+33Os1wxdF5b34XjJpEET+PqDx
	PBS8SS5wnPfAanqQBQ1w3iuFNacq38SO0Bg3P4jpf+zYWql3PAHDtZfko0KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762360206; x=1762446606; bh=ZYFTEkypLw827TUQKaYOpjSUsGTVVjQyjm6
	xgmRlKnA=; b=YWYjWza0d6XdkoM8LpyGbkhaX01Gzk3wEZ8Vaychs2pCw+7a6Bo
	qm+dlIKNRt2HqHDzQgbftbDKCc+nsAw8nz7/5KWJ2LargJg5yMm4zovUXR2qpyhx
	17NYUpkzo7zLUYCxJvoOAyg3a1cQGbDoXJciYFPPJsj4qtC9jVUrfl2vI/FKUsN3
	3rw+BOCGhzDPJiDl1oGeHtONFkRwn4MA42k5KvFmp5jjHwvUzh3K+Hs/IRrqiKeR
	NEh29nzCvTXUn2euedxMINixz3rWvG3iltle6ZGut8JHSQz4fa8sC5GArtD2R8Cb
	ibrzQbnU7FD1ZU+9rjILhPxHEAZi3qxt+dg==
X-ME-Sender: <xms:jXsLad-aUq-yayEC9UVeP7oPyrBNQevw2iYFJRTwu3_S6Xxi6FGqfA>
    <xme:jXsLaTN1hYrE7G6gaaR112SS0aU8swnu21XPFWzkzK10mIFveU8ejUB9WjwaI31Xo
    PGzl6bR-P5V_nTQtN5q3LB_3wS0XlykCzeXFgJroHbyvWLOLfMjDA>
X-ME-Received: <xmr:jXsLabF1OFye1-bUGcP3OeCvJwndUsJ5TgwuSeJD39JSlDoCkaQBmDYQCWIBSIIRIzWf-1S73alhmFMwNqG6ZJJ-d2qrbcDyPKKU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jXsLaRR87_511Ry76refLEchUMc0H7lsbaOnJiCijCrpm-w-ygwL9A>
    <xmx:jXsLaYsUG8aqdaWUqXFugbzsyp2lcBZDZmwL4K3V6y6UOlmuYch4Bw>
    <xmx:jXsLaZLikR_wjVuNPLjrzjumFYfFlTNwtiZWsVSL2i1Tfl5Cayp-0g>
    <xmx:jXsLadn-B0aiQRzZpx9m9tJYHBqch4xeDT2jLq3qacAQvt84HaA3OQ>
    <xmx:jnsLaXndvaefV5qmKgtY3v-YdXXusdue6LUtSC5eS78InL5jaJS6dPgC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 11:30:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Li Chen <me@linux.beauty>
Cc: "phillipwood" <phillip.wood@dunelm.org.uk>,  "git"
 <git@vger.kernel.org>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v6 0/4] rebase: support --trailer
In-Reply-To: <20251105142944.73061-1-me@linux.beauty> (Li Chen's message of
	"Wed, 5 Nov 2025 22:29:40 +0800")
References: <20251105142944.73061-1-me@linux.beauty>
Date: Wed, 05 Nov 2025 08:30:04 -0800
Message-ID: <xmqqecqcmohf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Chen <me@linux.beauty> writes:

> From: Li Chen <chenl311@chinatelecom.cn>
>
> This series routes all trailer insertion through an in-process path, removing
> the fork/exec to builtin/interpret-trailers and tempfile juggling. 

This description makes it sound as if the code before this patch
series drove "interpret-trailers" via fork/exec and tempfile
juggling.  And that contradicts the title of the topic, "rebase:
support --trailer", which implies that the topic is about the "git
rebase" command, and that "git rebase" before this patch series did
not support trailers, not even with fork/exec and tempfile juggling.

Which is it?

I see trailer.c:amend_file_with_trailers() does fork out to the
"git interpret-trailers" command and is called by "git commit" and
"git tag".  Perhaps you are updating the amend_file_with_trailers()
helper function to do the in-process thing, so that "git commit" and
"git tag" no longer needs fork/exec and tempfile juggling?  

That would be great, regardless of "rebase", and if you used that
updated helper function to teach "rebase" to deal with trailers
in-process, that would be wonderful.

If the main part of the series (i.e. [1/4]-[4/4]) needs rerolling,
could you be a bit more careful when writing the cover letter to
make it easier for even those who are seeing this series for the
first time to understand what is going on?

> The first
> three commits centralize logic to reduce overhead and simplify error handling.

... in what code paths?  "In command X and Y where they do Z", "All
the call flows that lead to helper function F by eliminating the
need to do G that is costly and replacing it with H", etc., is what
I would expect to see in such a description.

> The final commit adds git rebase --trailer, currently supported
> with the merge backend only (rejecting apply-only scenarios and
> validating input early).

Sounds sensible.
Li Chen <me@linux.beauty> writes:

