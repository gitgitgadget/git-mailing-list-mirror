Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02C3173336
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 23:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428996; cv=none; b=ZaUStqeuDg7ehBSf45R9AxNaGEJMbL9AACT+pCvNR/YB9M1bDqGog5cuen+zfOWcECYgmqZRC9fflqtVW5e674GRfTsWFK8iWB0KFgTy3/08g6EIftN+9cEWNp5bq/FxU+JBExXVsAiHUi1nyUx7Y4x0vLk5/SIU9c2bTbFJa5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428996; c=relaxed/simple;
	bh=CvWNeRh2yQqO98yQVHRgERIe4YjN3McRTl5KsJhnDB0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t3yMzDHMaO5ICTyHwCjz7++K7n1kSiYyuBFG1sJElCeMs6vEjC+gv6EWpqm9vZxInp8Qmgq/m4VRPTGgHuWJMry9YPr4FcTa0ldpFl/wGFT0OXS9hJtF2rzNI+yiUOqhNvflafvuf2Fzv0FzN8lY+x6h0mk2Eigtdmj/lFgQ7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kGZnSyb1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2eBoWT9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kGZnSyb1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2eBoWT9"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C07311400EE;
	Tue,  8 Oct 2024 19:09:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 08 Oct 2024 19:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728428993; x=1728515393; bh=r13qo1IGXG
	C1t0Klig/X7A9hOzrqc66WmAgGdQ3N6wI=; b=kGZnSyb19Y5Gsl4FaF35Sc9+re
	cp11VVLlxF+p6rBbgBuxbA4L2XlNnIhgFAM4a/OqaW94My1pi3IbhQWh4PfKJSGX
	495K/gCDb6Xe0s05GJrrZ3N9yseXxfaoHt0ge497hnDTwPcdv7ehH2bnlhQFMzG5
	t2ZEZJ38jqZGOvSzeUb4vSvMh8ZXTE8bnYc1scAR+sTE3vwkY0zaTtC/PPWPm5Ae
	FbYFgaRlLo8bjL4x6S5DYpo4KRfd/XMPziyBZHz0IF57IIsidH43PPIMlW2YOHc1
	i4D5iRpC0QbV8HJMOUp6Ix9DixGdJunWDwKAGlERql+/M5x3xfLfwxpDCZpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728428993; x=1728515393; bh=r13qo1IGXGC1t0Klig/X7A9hOzrq
	c66WmAgGdQ3N6wI=; b=A2eBoWT9ewuXZEVvVdoBoAHh305Gc1zOEYpRVYx3cZsW
	UAIYvFtIcN+02u0k4X91MH+m4GAEczhXJZuSBW7mv2x7owDo+WqVnToUShiAK9iX
	1ODoAzaqDiFRcqqE5GbNa72im6Mn9Yii6MbFemkAc7IOh5PvXz+faLHmW4RpCjQS
	w0pVYbz2K3mW4FwMwfPtXSxmFPbnXtmhtUChcAupRk27W0Gu3/oIX7BJJ2lO7QUa
	9yFWz+qnC3AzbIerp/1ZgvxEDCQ2SuSaWePduLKHjOZlswAaDwSz5UIWhYnQQ5ja
	7v6R2uxZg5D6DRSHIk/5i6GjXf0Eb6OojTLgIJNWBQ==
X-ME-Sender: <xms:wLsFZ7AZwn19xON4bx18UTtSdW7-IoSjvMgeZiMd8xIAAqhnMQN6_w>
    <xme:wLsFZxgs74RZHNcENZSChlwdYhL3VP8uPO32DNd-GMOjuMp0g4S9ukbKCCRrST9eM
    ubuWqh2PjhYy146Qg>
X-ME-Received: <xmr:wLsFZ2mu8-hwi2-01pJoS-ZfNhzqyKhg8os4iE3V1UHQi2UGkl_stUtLzwB7x3Zvc5VUr3VBPMruig_kBz0Xc2i-9gzRNo98oUJHN_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvvhhnuhhllhdotg
    gufihhihhtvgefrdhpmhdrmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggufihhihhtvgefsehpmh
    drmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wLsFZ9wEIzozaW6lYMFdC93bQ5-VkqxKRXsUuLa4ecZnxhRbsorcIQ>
    <xmx:wLsFZwR-WrYYWhIiNRsjduTZ_o5wVv6BsmEJte6iAUmseX79EB99Cw>
    <xmx:wLsFZwbcVRblo1d_QmeUmYluY-iDvSO0qiwC1suTP6eQHw2qVavhGA>
    <xmx:wLsFZxSkYSL69WZfQWKDOxONhtguRCoxYxA9hi_Aus6USCbNacDZ7Q>
    <xmx:wbsFZ2MhVIsgXzNw0JnsoZjkjdsGfJl13_FAsCgjhSR8GRSNHUSbADyp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Oct 2024 19:09:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>
Cc: git@vger.kernel.org,  Caleb White <cdwhite3@pm.me>
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
In-Reply-To: <20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me> (Caleb White
	via's message of "Mon, 07 Oct 2024 22:12:31 -0500")
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
	<20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me>
Date: Tue, 08 Oct 2024 16:09:51 -0700
Message-ID: <xmqqmsjexkcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org> writes:

> From: Caleb White <cdwhite3@pm.me>
>
> Git currently stores absolute paths to both the main repository and

As always, drop "currently".

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.

> linked worktrees. However, this causes problems when moving repositories

The above claim is way too strong.  When relative references are
used, you can move directories without problems only if you move all
the worktrees and the repository in unison without breaking their
relative locations, which is an exception and not the norm.

    The repository knows where its extra worktrees are by their
    absolute paths (and vice versa) to allow discovery of each
    other.  When a directory is moved, "git worktree repair" must be
    used to adjust these references.

    It however becomes possible, in a narrow special case, to do
    without "git worktree repair".  When the repository and the
    worktrees move in parallel without breaking their relative
    location, the repair operation becomes unneeded if we made them
    refer to each other using relative paths (think: tarring up both
    the reposity and the worktrees at the same time, and then
    untarring the result at a different place).

or something, perhaps.

> Although Git now writes relative paths, existing repositories with
> absolute paths are still supported. There are no breaking changes
> to workflows based on absolute paths, ensuring backward compatibility.

Good.  Being able to work with existing repositories is an absolute
requirement.  Are there good test cases?  I would imagine that you
would need to force a worktree and its repository to refer to each
other using absolute paths and then try to access with the updated
code, perhaps moving one of such "old-style" directory and then
using the updated "git worktree repair" and observing the result.
To allow such a test possible, you might even need an option to "git
worktree" to allow it to create these linkages using absolute paths,
not relative (and if you need to keep both possibilities anyway, you
might make the newer "relative" layout an optional feature,
triggered by a command line option given to "git worktree add" and
friends).

Have we considered how badly existing third-party tools, that has
learned to assume that the paths are aboslute, may break with this
change, though?  Or is this "we won't know until we inflict it on
real users and see who screams"?

Thanks.
