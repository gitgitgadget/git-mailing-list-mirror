Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF73A5E68
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443173; cv=none; b=CbafpmVtQup9BUcoExLPSH4fET6GwwJbsTq90M77cZAHmxbX2fe6Q6uwDDeuWof89MAfGPkufRVA1I1qGY27PGU0lOUpUoVPhZjEcTVukatzNiyvXIo8fVn891s9Xt7Az5Hod1tMItyYaVr8RW15r+3FPyWrVKItLWt5bwPCmvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443173; c=relaxed/simple;
	bh=fcauPCslSYYVxqPrNvcu91yr8vDe4jjNcfSXJnmKll0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/vpLIN0B93V0Xul93yv713oCGpkPB//YZEIFl/cMKG0XxaHWFJuHEYchzj/HeoAfCR3vYLp8BqLK0Il4WjlS697H46KCaeeHl79ip96A9Z1KTp7ZBGpSdCMewiHi/0w9OcADfOf2S2WNyTKvNemzS2To4OHW5lcueaFbePYLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X2XP9pOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1M0aScUI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X2XP9pOf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1M0aScUI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BB7831D001B0;
	Fri, 13 Mar 2026 19:06:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 19:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773443171; x=1773529571; bh=ARAHws2hvK
	zgRlMTVvSqm/JYWf1xhWhFOYXZ7i8kUOI=; b=X2XP9pOfjUxyT/ceWHU+mgo7pT
	TWiEpVTCNKQbgRwx4e8+xH7Ow3qedZmA1FvKVpvkJjZUG2E/fE6ThJsIqFSf8EE2
	mQ72fp9gKC/bVL+9gUd0xIdMspAe9xdimtSPjwmjfuEgIUMuscA8JK6jNxxdkfpk
	EIRYRzwjIZzal1akM64mbQ9Kr1OPdxIPGf9gWi+kCQuXXHtvJqjkTTj4r17cagWW
	AK7xb2sBzZzkaNtj+F7sItB0F9H7koNzjrWn2RpCCpwwzIxNRoZUwy/OVRtOFcIb
	rqkIuTWHPTJcHr6hZqZ1xhfy5ll3P4jddpAOhY1Mu5gstRvyojGVaexiWPBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773443171; x=1773529571; bh=ARAHws2hvKzgRlMTVvSqm/JYWf1xhWhFOYX
	Z7i8kUOI=; b=1M0aScUIQw+Rbf2wyZnWOlsC5ZGTC5mJDvDATgykUeJwstdWmC/
	GguR1edH/qcvVryGwgfhQNjH6JyhjjLhTUZsN1Yv++S28BPuRM7Xr5dzUHTgD/dP
	ODnttkE8KAaa9mj4zRczfh2KbFoMqq50yipcKC3MgGyh4cTVaTagog+D57GGyvsu
	PHhcJaNdn//Zj8BQh1BgQFba4EIw7dIqQjH7YRyWjbMRlB3YuVROYX+tD+NMdI64
	qchq8a85g8crCqfMKwsjf9y8/ixiRs9uPMZwliV1SXEdzhWGhsgsHDoBonr8tqK+
	DCMk+mmBwtSI1f0KW8gvSCnJ+Uye82uvvWw==
X-ME-Sender: <xms:Y5i0aYJNaL6MsWXQPHGTklHsMgzHv4Fz1Io0c_kfXl1kVHXxiFVKrg>
    <xme:Y5i0aSMsMUqX-QaA0FjxAuTOZ6iOA0dQLPR3Rn0MLYhUBkEvpbi8_KMjC3aMV0Ogg
    mphbknmzGndyAKWBnIqCfUUJHcPBEF-xy_x_URV4VEsgBdIiawKHg>
X-ME-Received: <xmr:Y5i0aYmYtUL1WeP4BEuGrsNmPxEhzFe4uAev6gz3Sj11Mo2MNyAfMLBSC9OoWfDeV9vWW3EH_ZU5by3_OhMb4j4rfJ3H1ZlnaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghskhdoghhitheshhhofiguohhirdhlrghnugdprh
    gtphhtthhopegthhhrihhsthhirghnsehhvghushgvlhdrvghupdhrtghpthhtohepghgv
    ohhrghgvsehmrghilhdrughivghtrhhitghhrdhpuhgspdhrtghpthhtoheplhhishhtse
    gvfihorhhmrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhm
    rdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y5i0aW4DEomteo4rozHs8m4WgTNjVjcS7cizr7Xi9RW73n-T3oNWmA>
    <xmx:Y5i0ac0HtaxrA0g0dAFUuEWDO-sT39nLDWNQsKrLmapDrGSsuTdvqA>
    <xmx:Y5i0aRGe-5l4cJvlfSL2MlBpdKszZzasuIrC7LPj5Z8Py2qRwAnEpQ>
    <xmx:Y5i0abghED5HovZTgPEFE_bHzSUvuKKxyVd8Y1unsQEpYYXthUBnfw>
    <xmx:Y5i0aYPojb_PpvGlVUtvcI0L3zxxHJPWW9tyTMzgBwV_b6okwiepE6SD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 19:06:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Stagner <ask+git@howdoi.land>
Cc: Christian Heusel <christian@heusel.eu>,
 george@mail.dietrich.pub,
  Christian Hesse <list@eworm.de>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] contrib/subtree: reduce recursion during split
In-Reply-To: <xmqqldfv1gxc.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	13 Mar 2026 15:51:59 -0700")
References: <20260215201748.889866-1-ask+git@howdoi.land>
	<20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
	<xmqqldfv1gxc.fsf@gitster.g>
Date: Fri, 13 Mar 2026 16:06:09 -0700
Message-ID: <xmqqbjgr1g9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Colin Stagner <ask+git@howdoi.land> writes:
>
>> * cs/subtree-split-recursion: when processing large history
>>   graphs on Debian or Ubuntu, "git subtree" can die with a
>>   "recursion depth reached" error. Reduce recursion.
>>
>> On Debian's POSIX sh, shell recursion is artificially limited
>> to 1000 calls. You can check if your sh has limited recursion
>> with:
>>
>>     #!/bin/sh
>>     recurse() {
>>         r=$(( r + 1 ))
>>         test "$r" -le 1000 || { echo OK; exit; }
>>         recurse
>>     } && r=0 && recurse
>>
>> Depending on the history graph, subtree split can recurse deeply
>> enough to encounter this limit. Rewrite the rejoin-deepening
>> algorithm to reduce recursive calls.
>>
>> ---
>> Changes in v2:
>> - Rebase on master
>
> We have seen two iterations of this series without anybody
> commenting on it.  Is it a sign that the topic, or possibly "git
> subtree" itself, is of interest to nobody?  Or is it that it is so
> well done that nobody had any comment on it?
>
> I don't use "git subtree" myself, and I do not know of anybody who
> will scream at me if I break it by merging an unreviewed patch, so I
> can merge it without worrying too much about fallout personally, but
> that is a tad irresponsible as the maintainer ;-)
>
> So...?  Any volunteers among those who have a higher stake in the
> program than I do (which admittedly is not a high bar to cross)?

FWIW, I can see that [1/3] is a benign clean-up that should not
change any semantics.  [2/3] talks about the variable $sub, which is
used elsewhere, is not protected from getting overwritten by running
the function inside a subprocess, but I do not know if updates to
other variables (like $b, $sq, $repository, but not $fail_msg,
$hint1 and $hint2 that are used only in this function) want to be
seen after the calls to this function outside (and do not want to
find out myself---I'd rather want to see somebody else with stakes
in "git subtree" to verify), but otherwise the change looks benigh
to me.  I have no idea if what [3/3] does is sensible or not (and
again, I'd rather want to see somebody with stakes to double check).

Thanks.
