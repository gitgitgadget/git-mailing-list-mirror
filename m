Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C12F387367
	for <git@vger.kernel.org>; Tue,  5 May 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985774; cv=none; b=INoc7kfQXqXlF0EB6Vf/hg8YtUnZDQDW+wkeMEk4P6m2nfwGDaUrrW2pqIYT38YI14Jfxy+UKPu20LBuFz3BrWMaNnFztsfDoDgTY0zyGm/yRfL52mOPcrfQNSoeQay9z1GoBh0BixTsVI9SvBdLR6JRm3RYed1kX5RJBOj9B9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985774; c=relaxed/simple;
	bh=NTfvrGFq29pDDIVvU4NGUowzjX80XK5PXu+zoL3HmMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MjGirLHEJMcZUbrl4UZeit7csjiI93VGSMfKMdTPi6zpRqbx1w4xsxgoRDD39LrziZMluqE25f7Ce9a9EdEZpdqnn0YML5iS+oF0vGZGxUGGutTKRw35xtqwZsoKDV20qSE9YbpadHrSsMtF2hvkim3qDlo7oa+kckXuOuZkamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=woi4LTgq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EUIgVixD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="woi4LTgq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EUIgVixD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5543A7A0125;
	Tue,  5 May 2026 08:56:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 05 May 2026 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777985771; x=1778072171; bh=iXR7Br4JwF
	YPkpLmMmU1cmz6lSA8l8Q/bvZSyj9sadQ=; b=woi4LTgq04yNbo/Ui+/pcLD5Z/
	YwjAgItJND1qcwVWl7HKCPOfQ/xvEEJmwiKo0GXFS+BCLjB5Llfurt1DegwRcwvi
	Zk27kDowsdUkRBvacsbYJApHVkU7D4sZgT2fgJF/twd1OBLJVO1hpqimuiCh5QmW
	8qXp7m+dib99jFr520PEC2Y1voXJQLgOpgEy4yUrPOxesYJOJoHlL6SaHcLyKPCk
	kbiRWVJsgF25q1xi7Xf3QLLW7hLglMPvy36BkopETbZmc67HD9uWqgcu7AlgxG3z
	eFpgyzejXx7wq7h2llKjB5NDgr/sazbtJC0d0+/rTRyc3HPEyOZ07IEFeYyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777985771; x=1778072171; bh=iXR7Br4JwFYPkpLmMmU1cmz6lSA8l8Q/bvZ
	Syj9sadQ=; b=EUIgVixDa7RpGS3RKQe6OzhyDzK0kFwcwbI65x5CHtmzXHwJucr
	klqEKVPfS2Oj92P8RxOtkNPiRRgTofawrcSmNPE/pqlDORgGkzUmzmf/oXwDNYbv
	Nv/yQZnwyul7xiI7Xa+r/XzsxK8ZlgPVbqB15qfQA8REcrS43DSwArsV2aakHC9w
	lUrhSQanG/L2heDjotdRnmKDXMr+vMWDgxQEqH9ZJzydlOZOtNw6auogUVtTpm4z
	SchmcbKypQFxqokxxM2hDoxj93CRtRho7eVcHvsDCMOLfcPSP5KxhVVuQsQtZmlG
	nPK880G97b5EyFxZv9ChbUXObO9D0o4IK7A==
X-ME-Sender: <xms:6-j5adk0DBFYQKPDhBi3GqfVrcaqtHhmecE9lTuEe5V1yXlzo3rssw>
    <xme:6-j5abF6hx6ZKydH4iOmX8rFhjR9j7YF7E41EzcJX1oXf5LTdq8cmU8FZZbtiZMWE
    xQ4HkUxBRg2T0GTgQo0jmtUsqacN-Nbhk4KdftyFuUSzVThKiln>
X-ME-Received: <xmr:6-j5aV4fWjzx1ZIp1EXLJALHC5brtKtPnCfXrtBYxUH_EaqKPujDYeCx4iIzLLcVI1AqrKR-hdODM8GGLFdKoLgsjOf0MFcKcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddujeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtsghovghgihesfigvsg
    druggvpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6-j5aTk95afbdAEDeX3altsJGLXs7aif-d6oeouknDzxirUIWl4gow>
    <xmx:6-j5aaob3ZeSeAxXLd3Wl7ePhyQ65_voN-_mmb7nK9qvV6TUC4RSfg>
    <xmx:6-j5aSvjBI8o_S7WyBwoykd7FJCFYIUcTqe9WGkcRb1dUvVcDsJYLQ>
    <xmx:6-j5afG2q3L1E9sOv4j-zRkFazVyy7ADjIyuM3sHjSDUiZpZlxDGJA>
    <xmx:6-j5aeSyvJVbBdif4ricbfnlEiySosRMsOX7VgIoc-DynZP4vnmMh7rm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 08:56:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/11] ci: run expensive tests on push builds to
 integration branches
In-Reply-To: <42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com> (Derrick
	Stolee's message of "Mon, 4 May 2026 14:35:05 -0400")
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
	<pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
	<1eaaa7fad7a1432dd97ffdd7c45e8162f61bc302.1777914508.git.gitgitgadget@gmail.com>
	<42f96e54-7b94-4075-91b1-1c2447b93322@gmail.com>
Date: Tue, 05 May 2026 21:56:09 +0900
Message-ID: <xmqq5x52nhg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

> On 5/4/2026 1:08 PM, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> Derrick Stolee suggested [1] that expensive tests should be run at a
>> regular cadence rather than on every PR iteration. Gate GIT_TEST_LONG
>> on push builds to the integration branches (next, master, main, maint)
>> so that the EXPENSIVE prereq is satisfied there but not during PR
>> validation, where the extra minutes of wall-clock time do not justify
>> themselves.
> I like that this will be run as part of regular updates to the
> important branches. The important bit after that is whether or
> not a human pays attention to the signal of these builds.
>
> Junio: Do you pay attention to CI breaks when you push to
> 'master'?

Well, it is way too late to notice breakage when the faulty update
hits 'master'.  CI failures should be noticed before breakage hits
'next'.

I often notice and complain when I see failures on 'seen', and
sometimes I help original submitter by bisecting, but I do not
necessarily have enough time and bandwidth to help everybody.

Quite honestly, the best place to give widest test coverage is much
closer to the source of the problems than in my tree and mixed with
other topics, i.e., at individual contributor's CI.  That way, I
presume that GitGitGadget can also help submitters avoid sending a
faulty series, reducing the load on the list and the maintainer.

Ideally the CI tests by the integrator should only be catching any
mismerges and unexpected inter-topic interactions, as they cannot be
caught by contributor's standalone tests, so I do not mind widening
coverage of CI tests when I push the integration results out.  But
so far, the majority of what I have seen and reported back to the
list have been something that the authors should be equipped to spot
in their topic without getting mixed with other topics into any
integration branches.

> One way to help this procedure could be to have GitHub CI
> failures trigger new issues, which could then be more easily
> viewed and noticed by the community watching the repo. This
> is of course out-of-scope for this patch series, but could be
> considered in the future.

I think a better way to help would be to arrange the workflow so
that we do not even have to trigger an issue, and stop before the
patches leave the original authors' hand.  They can of course ask
for help saying "here is my topic in my fork of the repository and
failing in this way for macOS that I do not have access to.  Could
anybody help me figuring out what macOS peculiarity my changes are
tickling?", or something like that.

It would be best to find problems early, and make it easier for
individual contributors to help each other by having a concrete CI
failure reports in their forks that they can point at when they ask
for help.  And CI run when I push 'seen' or 'master' out would not
help as much as CI run when they publish their forked branches would.

By the way, please expect slow responses as I am (officially) still
mostly offline for the rest of the week.

Thanks.

