Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A82F532C
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060144; cv=none; b=S/XRf+Hw6pZkSLCUQEX59ivMvcru2i8IigKHa26WSmvRsdip1YzS/6a09h0wP4m/gYLDxo+O53wD9k+bLtWyzbG0ZjUKvcXaSmseEdkxR/aP+HVTiOdQhfAE0u0mUQxuC/VL7Jd+jJvQyGPNTBuUKso7LlOLsanGyd/Ef8CmnT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060144; c=relaxed/simple;
	bh=LUVmdUEW7k/deIw4x4sLSQ/b/jF2TYp2dr918gmAADU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n2eOnoezaCOY8wd65X1s+mzF8e2DptiaiZhDfS4zauBW0WcjtOLvFrR22IjShrU1OUxOE0l61satuecAEd5/x73zwJDw2kKi3QE10twuL5XqUPU3JBbAN2B2aeq3+VeqiqpGvffxfFKEqQW0Uc6Iq765yH/SzcNxsS/LZzLEbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GlZYFUEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyoNiHxT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GlZYFUEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyoNiHxT"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F203B7A0063;
	Mon,  2 Feb 2026 14:22:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 02 Feb 2026 14:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770060142; x=1770146542; bh=uEdo1lRJeX
	FBJS1GNPxjykGijNQLeMuB773iGi9rvfM=; b=GlZYFUEWyIrcXL2Q7EYImTpNIY
	ZFLLO3la5uufeNQwCGv9kxGijHa3RKC+eTxeY/egCE3xXgkMRMZx5pU/kn3jDvzI
	IzqxNYGR0IgaKn9GqLDS2S7P2Axi2OPtW9CeYSJkmY9+7mc4gpBGHDKIIb2pQ5Qy
	0GmLGbUCrom/RcpMo52qt7TEWhMVf9F2tHEbLfcriuHa3XgTBcE6kU+U0ih0yEMW
	dWw1S3mXpjKpk4uG0UV4iNbnFul0ThhaH17C7T57+FeWeDdp8D5b87ZLKVfatOBI
	JdyvRadMZdI+Ttk2k+03H8+5LeIMwM5HiXdIaq+QoKEXnUUCseoQgGVr6I8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770060142; x=1770146542; bh=uEdo1lRJeXFBJS1GNPxjykGijNQLeMuB773
	iGi9rvfM=; b=KyoNiHxTX0Rf/bKsYJ4PxSiUlC696lc4XWFWh49gTK9GJEg7Mmf
	q1VoCKRP7vRfk52rkfh/uptbgvU1fr/1NvJVsI9S7RpFLln2SKyyaWPzev/j1OEw
	pqFwseDRtik4vS14i2l6QZc3odd1KRDfpVRutG71mkY5PKHOz5lJzjBVsp96DmGo
	Dv3c4ETFqoDHYOczInVD7fuOIuvJUkBGCYHcKm8EL2HFa7/ExIj05T/W8HmVhCMk
	VJFSSUjW54lBkIQTjekB0hW1nUcIIHTup6+1J0HaePATKKwIzq3WvPDENRpXIcB+
	1loxgj/ztSVXdb7iBuz+E5PGVqYjgWBfpWw==
X-ME-Sender: <xms:bvmAaQggS9QEtkrl6mDeDReA3oyT7dwulhEUKOuoRehMKzWrhwuG6A>
    <xme:bvmAafBytzKGmrIytXx4SwJZakjXEpNdz6bB3eLgeNL8LzdE6e7VWXHlq6r-n783G
    1h6ctFz1DFVoCRduIw_g2XxxpIU0cxRLpbsZ9ngN3UucbUdpQbPDx4>
X-ME-Received: <xmr:bvmAaVuG6LKOlfiNbjGCUOs6cNukxy7UjDOZSXrQuIkmcbu1cJsEE2EUbWr2VvZWh0gz86z3PxJSkShywPuvV1iYl6me3FPp7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:bvmAacY_dQO2zrs3d1snKcXu3rKJUAFyHPcK_SULuM5-jj4HCE_MCQ>
    <xmx:bvmAaQWJhjh5e0dCYr331IEtC76rJBOCUJNFYPEKxM99vGw6I-XkwQ>
    <xmx:bvmAaY7AljTw9KNv_4AcLd7w-SfnuHsRLRq6s6P6WIB8prPkuEoe-Q>
    <xmx:bvmAaThDrFfJ2AKg-kqC8oppePoUVvlJVC4Z0dVi8hcou4OE4J0kaQ>
    <xmx:bvmAaT7SGHZt1uZ6TPWbvJ0aka6RREtzP2S6cp5jb74GK4DubEZWLlyE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 14:22:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: A note from the maintainer
In-Reply-To: <xmqqms1ryov3.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	02 Feb 2026 10:36:16 -0800")
References: <xmqqms1ryov3.fsf@gitster.g>
Date: Mon, 02 Feb 2026 11:22:21 -0800
Message-ID: <xmqqsebjx85u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In addition to the usual version bump to say "the latest feature
release is 2.53 done today", this update includes a request to
people to build and try "next" in their daily work to prevent
undiscovered bugs getting to "master" and breaking their workflow.
Here are excerpts from relevant paragraphs in "diff --word-diff"
form (i.e., new words are shown as {+new words+}, removed ones are
shown as {-removed words-}).

...

Topic branches that are in good shape are merged to the "next" branch.
The "next" branch is where new and exciting things take place.  In
general, the "next" branch always contains the tip of "master".  It
might not be quite rock-solid, but is expected to work more or less
without major breakage.  A topic that is in "next" is expected to be
polished to perfection before it is merged to "master".  Please help
this process by building & using the "next" branch for your daily
work, and reporting any new bugs you find to the mailing list, before
the breakage is merged down to the "master".  {+This process depends on+}
{+your participation, as the way you use Git may be unique from others,+}
{+and a new bug may only manifest itself when used in the way you use+}
{+Git, not noticed by others.+}

...

Note that being in "next" is not a guarantee to appear in the next
release, nor even in any future release.  There were cases that topics
needed reverting a few commits in them before graduating to "master",
or a topic that already was in "next" was reverted from "next" because
fatal flaws were found in it after it was merged to "next".  {+The same+}
{+can be said to "master"---there were cases that we needed to revert a+}
{+topic from it because a regression was found after it was merged to+}
{+"master", instead of while it was still in "next".  To prevent it from+}
{+happening, those who care about the quality of the next release, those+}
{+who want to ensure that the next release will not break their+}
{+workflow, are strongly encouraged to build and try out "next" in their+}
{+daily work and report problems.+}
