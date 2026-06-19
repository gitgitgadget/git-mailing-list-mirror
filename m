Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F40433AD
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884887; cv=none; b=BcF0Gl8ZNsyQT0tcDkVd486znfA9NM2RPWxVLHCdJ0uUESObNafTdXbhNwvfY7Ex5oNTfCNgTv6nMDa3F4xAder7D85pX+2rwi44yN0ybGV9dWa401SSqM7Kut+KRPlgYMdHl2cfoG0VcLrnqrDsWXKp/jS92RBU7Vepd3UhaVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884887; c=relaxed/simple;
	bh=XbJK/+k+I7fxVYDmeJGx4+Gem0+188qyM5Ze08cv7Ug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XqNEOdpBaRt8tP+MMHsXuJLkHZZGg0JcvhxDwrIJpIIO9HdbQziuW1yd4JRUI4r6DPsZjUu+X3OU5nUq6gP8thjJwO/UBSSdTZSprhU7fCWtoJ6R6Cieh5TdmZD6hAYxosd2Hyk5cCAtL6x9+ExQqC+672mWuk4FyffMgr7gGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kP7JZW5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/lfSBs7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kP7JZW5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/lfSBs7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C90FC7A00D2;
	Fri, 19 Jun 2026 12:01:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 19 Jun 2026 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781884883; x=1781971283; bh=tN1a/byI48
	1hrYArTxvtSXN/rhvHeWRnO4woGgWYmrg=; b=kP7JZW5IKwmxXBl0L7sbdA9ucg
	qOb8tGn8quETkHJyD4fc/pOZCR7gT1EAyynZOUh7xTFUEJUXBokxj40TIHPXkPPJ
	3l7JIBtTdJBRqespXaoInq1mrHqh3FL0KdVjrY6QLNXCJKS693MQGayleR3ayANS
	pwxNcrxHP9VlEZKOPv0vOpHZLGbXOn2rAXnGGdoL17EjQuNPWyiltwr2MBxdn6Cb
	OPbT/qgKqArqg2ZqoxOESAr0cdWgSkhv1TsX2s8XPrxhDCy729IpDDWhbE/UzHz4
	jDAwgfl8ww7YMrwPIDbc/yExjWNz5vIksbREUpur0N5OAlmTfKu/UvE1ff9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781884883; x=1781971283; bh=tN1a/byI481hrYArTxvtSXN/rhvHeWRnO4w
	oGgWYmrg=; b=h/lfSBs7s1xARNErlGHb1Am66s5R10m8qWB+vVFP/EnIw0uComO
	Yw0n1zBZ/3RCtx8rx089l378JAN7QTsyZCorK+jLfEoPF81oKm7qFnEgL6UON55k
	m5dcU5WrPabNeYM5javw7OLg1eO2qyTNU2qoFM+LbEGpUGhztQbMVrA8EDI9MGWB
	DhHwtNNlT/PMZsSNxhPPCfU5+scFmFeT8nuPwlk/UtnGD6wOCIlQD9y0L8bI5auF
	32NiIrS/Ao98IS6g8BJHGDCmqsShKJSfCOikzcPj+wMTmVvzklLXdKQkvDf+yRdY
	J05+vBxVnRZn4jROniHXLovwxtT+h8AKS+Q==
X-ME-Sender: <xms:02c1ak1qn3Sp4Wa3LtgVmLEotfcPS7dEsVlIrSYaeN6HByG4SoBoig>
    <xme:02c1ahV1K6UByrG4IYOcqQa0YwgExxfup2w_AIjJxtDfQ0rdAkEPdVCTOX6hY1hsc
    7SzmImLbdC0Aq-PARcSkouzsEijlr_yw8ctxAqt9uGB9QJa-nQE>
X-ME-Received: <xmr:02c1avKTUW9VJ4dz_aTIEKwCKbquC35gdIqS646FAyj4LRJGCPJoWdp8Byh6P3IMjy3rSdl2GpiM8Wz9LE7yyMumzxQ51oTHOAPo>
X-ME-Proxy-Cause: dmFkZTGplxq+KbPNO7T09a5HNOUdgIhM40CeMKLkymnOkSqM3A9n0U5hz0jm+wSQ6dA2Dc
    aD8kah6OK8ht7oX1DyhPaOsgIYjqr+Anrpdnm6ZvdCK7w9wQWZewHI8ziBhz9l1Z3HKAYP
    qg3hE5y2aqb+p1zny4pEt9T/1lAJ5CCZIfWH597YaA1iU9oBT4xb5u9MCLaTtrQNeW5mmu
    8ig2ALWj+OtZbq4spmt/e6vX+OtNzkBjKdDmT5jIFm+LTglY//C/JrQfPa3eK8eMvreFGK
    8hALFcJxK2Ssrd7MKle204E673EEoJalFUtETsSuwsbbZ9jynw3b75NUq/XZ4yjjLiS3QN
    N9a87KouBai5AbDwK/xRQlZac5uo2Gs+uf0cfS++lXqIFwdd7jUDbMfgh7LNIahDthzBpF
    ZfNTyPEjm36l0j9CdIhFYtaEbMO2bwEKkUqNf8HLzE/nAaMkMEKL5j5+qTDI0KyBcXIJmN
    QYmA3U0UzoiSopzqVC2vzSDx1Cx35FlsWMezBeXwNEls7J6nIMC7ez0bZFANqclO1MHPKL
    d0iuBNS30Dwwa8zDQf0fgcMJYqjUNJH6wZEfpAU4kfyvG5nQMRbJuL3ltHzsyRj5KNMZBD
    XZI6Du9B9Kr8RyKW3aFUxImOXqYgd4hFSRtE6ma+eeq/Siv2JZEFqbvr0t2A
X-ME-Proxy: <xmx:02c1aj3Ybn6dk13MgdqqtR4WY01jPScCulbIW0_014Vw0Vyw0a6lfA>
    <xmx:02c1al60afET2xmwJnYNLkfiYQsEwpqiJvYkR5cvl9QUECsRMBr3eA>
    <xmx:02c1as-fA9-br0LyZJlpkiaHhVa1ZH98btiSLun-doRZVFI_vfIfJg>
    <xmx:02c1asVgzX5KnpPi1yiu9gjOkD4mFSLU1AVYJJSVYbWvFMYT-ipT_A>
    <xmx:02c1athQMRo5zklCpQxWRFy5x8N77z71vVpkI65K-fwmwhtIRHgtZz4M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:01:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
In-Reply-To: <xmqqh5mymt8i.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	19 Jun 2026 08:42:53 -0700")
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
	<78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
	<CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
	<37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com>
	<xmqqcxxnsufl.fsf@gitster.g>
	<42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com>
	<xmqqh5mymt8i.fsf@gitster.g>
Date: Fri, 19 Jun 2026 09:01:22 -0700
Message-ID: <xmqq33yimsdp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> I was thinking that if I have feature1 with upstream origin/master and 
>> feature2 with upstream feautre1, then once feature1 is merged I'd still 
>> like "git log @{u}.." and "git rebase" without an explicit upstream to 
>> work when feature2 is checked out. If "git branch --prune-merged 
>> origin/master" deletes feautre1 then those commands stop working. Maybe 
>> it would be sensible to update feature2's upstream once feature1 is 
>> merged (which I think is what you're saying above) but do we really want 
>> to force the user to do that by deleting feature1?
>
> Ahh, reference with @{upstream}.  Yeah, that _does_ make sense.

Oops, hit [Send] too soon.

This reminds me of the discussion on a separate thread on "history
squash" and "history drop", that squashes a segment of history

    o---A---B---C

into a single commit (i.e., "We want to remove A and B and keep C" or
"We want to squash A, B, and C into a single commit")

    o---X

It is natural to consider "X" in the new history a counterpart of
"C" in the original history, but what should happen to refs that
used to point at A and B?  Sometimes it may make sense to drop the
refs that point into commits that disappear in the final history,
sometimes it may make sense to move them to point at the surviving
commit, sometimes it may make sense to leave them as-is (i.e., refs
still point at A and B in the old history, preventing them from
getting gc'ed).

And the safest behaviour would be to ask the user, i.e., notice that
we would get into this iffy situation and abort, asking the user
what to do.

Now that safest behaviour in the other topic translates to

 - Notice that a branch that is deleted (because it itself is
   merged) is still depended upon by being @{upstream} of somebody
   else, and when it happens, fail the operation (i.e., do not
   delete the branch).

What are the viable choices we can offer to the user in such a
situation?  I think there are a few viable choices.

 - Make the dependent branch no longer depend on anything.  Asking
   feature2@{upstream} would fail.

 - Move the @{upstream} of feature2 to the branch that "merged"
   feature1 and caused its removal.  Asking feature2@{upstream}
   would answer origin/master, which feature1 was removed after
   getting merged.

There may be others.  And there may be relationship similar to
feature1 vs feature2 that is not @{upstream} but something else that
makes a branch still "depend on" the other branch getting deleted.

Do we also need the same safety around "git branch -d feature1" by
the way?  The "-d" option with safety checks the same "is feature1
already merged (to its upstream)?" condition, so it can protect the
feature2 branch the same way, by saying either "oops, you cannot
delete feature1 because you still have other branches like feature2
that depend on it", or "ok, featur2 used to depend on feature1, but
because we are deleting feature1 based on it being in origin/master,
we will make feature2 depend on origin/master from now on".

Thanks.


