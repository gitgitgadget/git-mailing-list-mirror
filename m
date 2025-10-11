Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150E1E552
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760203744; cv=none; b=ADQqi1/kCYLESQHgIbWZEdivBVwfIgclvFkNswvNThIwBNhy6Yrc2dONQecs19El96eBx+LIk0cf6d/2/eVozLmht0HsGmCkpX2JAUGmuol4sH4raqYdZnVkol97Sq4c4U+d6VHvjFKRam1HE8LQU6Hk6U4g9Xah09dot2fmhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760203744; c=relaxed/simple;
	bh=JIWpo3V5JP2r9OE3aN+pwp6efIw/6V+8VOjWGWjOnbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=REQ2YNMPcpGFDCuQcIAc2vkMRGjtZ/xBZaoWpBIlVcB2F0LvGjnN+/KaSXdu1O125t0N96n3NmghKMKhpWDL94OMA7jp6Ez1S2hryu1Y8UCXnCunqUKPNRRYDOfqZypmfTYmL2wirjDLYXoIEUXqDGzb+pEagwdSFO0BRVCJbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BvCi9yGE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2hbeUCd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BvCi9yGE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2hbeUCd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 229AA14000F4;
	Sat, 11 Oct 2025 13:29:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 11 Oct 2025 13:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760203741;
	 x=1760290141; bh=+rZMU2eSs/VpsyE8BAEKnLDpQxK/IzjBbC5xxRnJqYQ=; b=
	BvCi9yGE/wxldDyiTF/KHdQ6foDVJ1LvePaxd1rbKn+utf+T9Ju7cM2Xm11FtgV8
	dFgu7t/7uovZxOZt4GXdaMUaiYc4hlVIvS3DAhqySzGyaBOjFbHYO8bnfjLwC1M3
	HHyIH9YPmC+meRtokFJYHFc5/UgtnfGLAkBO/6vIMwxy94eqRAoGBuM3WyBtjKoT
	nDp7gKb9De7zXwQExioYOquAVDsV2nzMyx1T1mCjDJLUWWPmT2U02LAPHwo5eN7u
	9dQnwWHkv+rmwzSaMLxitmUC+4RdvwQiqsydxyrIuLeqlKeLVcGRziI3EoCigOEM
	35H8OUAPDMerG9M9vwF1aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760203741; x=
	1760290141; bh=+rZMU2eSs/VpsyE8BAEKnLDpQxK/IzjBbC5xxRnJqYQ=; b=f
	2hbeUCd2N1D/EoJYWO1PV77zDFolzTop45Jp/5FuRjCrizzD37f/Af6WelLDBaj8
	D6WgVuJF2kW0Gs7DyqGFpqevAtDDyuFivuXbFIZ0IBchBmy+7xw3VveId07M1L8Z
	7tYUQkT+/sn0JMCTBa1870mu3gQ5EHzGGp530SNRWQ3RQMC0KBdILd//ndeVb2Zn
	cWtkU6hqu1ZQJhPiuQ2I4/MmcEwqAnAsKiXokZ5PuF/qIC/2bO83D7QIsX4X2+KQ
	5drczRL2OTLlRIsOM68vIdGkVjW7lxyIlypx3SiBjnIzQWRsjvNWgW5gH7VanTQF
	uAasidOsNOaZFgpuxZXWg==
X-ME-Sender: <xms:3JPqaA0GjN8tyCXvL7mbk4LveLxFb2ZMs3YAXMRMvKzvM0eJ5lCzsg>
    <xme:3JPqaMp-uAj_z_iLNCTF7rvccmECso8shWIDHUUojA9duemmqCudc1VOzQHjNIXAo
    HM29FIsf1r_1VYSeK7iGAG0h0eicGwocUnj7qZhVP45ojOyCKYg>
X-ME-Received: <xmr:3JPqaIIOOs0gww_7iySTl-uwL0r1X2nGrRAqq0JeNaZhbUpve7l7iBfcOYeoq8hmQUpDIS9hRLpt0IpCBlqK8v1RbQh8poIVBIZi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddvhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesgh
    hmrghilhdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegr
    vhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehglhgvnhgtsgiisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhurdguvghnthhonhesghhmrghilhdrtghomhdprhgtphhtthhope
    hmohhtihhsugeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3JPqaATLl9HTofYK95aB9EQjLlT83NHFzttcv2QHzZ0TWGZ4RLhIFA>
    <xmx:3JPqaIMWUAduKcpqml6dbOzUR9QYIJy-6Ax5mx5B2VVpMnkPF3PREg>
    <xmx:3JPqaFXGgb7CvkyK1aqbh4x996DRQ8-3hDgDX4_6oB-OHXL4n8m0jg>
    <xmx:3JPqaLjxvb7fXWshAQfcRMqD-lxN-1WM6NaP_T7uLShdnSJEtfoDiw>
    <xmx:3ZPqaHSPY65q1tOitM7OrmrwFGq9renZWP6vRJS8fASKHvwre4SEG9bk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Oct 2025 13:28:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood123@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmo=?=
 =?utf-8?B?w7Zyw7A=?= Bjarmason
 <avarab@gmail.com>,  Glen Choo <glencbz@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Denton Liu <liu.denton@gmail.com>,
  motisd8@gmail.com,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] doc: explain the impact of stash.index on --autostash
 options
In-Reply-To: <CALnO6CA0SEGrzsrS_yqZ3Ztep0Gi=zPFjjGzSW94EvDW8RZ2Bg@mail.gmail.com>
	(D. Ben Knoble's message of "Sat, 11 Oct 2025 10:44:22 -0400")
References: <b36d2dbf-7cf4-46cd-81bb-b502e0eed380@gmail.com>
	<d4a277b6b0695d86636562f4c07efae17f9249f9.1759755379.git.ben.knoble+github@gmail.com>
	<e77d07d0-c26e-4d91-9777-ebaffffd764c@app.fastmail.com>
	<CALnO6CA0SEGrzsrS_yqZ3Ztep0Gi=zPFjjGzSW94EvDW8RZ2Bg@mail.gmail.com>
Date: Sat, 11 Oct 2025 10:28:59 -0700
Message-ID: <xmqqy0ph5ov8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> On Thu, Oct 9, 2025 at 6:55 PM Kristoffer Haugsbakk
> <code@khaugsbakk.name> wrote:
>>
>> This follow-up patch makes sense.
>>
>> • It reads like a logical continuation of the previous commit 9842c0c749
>> • The log message is clear (and with no spelling mistakes)
>> • The markup is correct (list continuation, links)
>> • `make lint-docs` passes
>> • `./ci/check-whitespace.sh @^` passes
>>
>> On Mon, Oct 6, 2025, at 14:59, D. Ben Knoble wrote:
>> > With 9842c0c749 (stash: honor stash.index in apply, pop modes,
>> > 2025-09-21)
>>
>> Curiously, since this is also the base commit, referring to “the
>> previous commit” would also work if this patch is indeed applied on top
>> of that one. But maybe that contextual reference is a bad idea?
> Generally I think so, but that's just my preference. Once commits have
> stable reference points, I'd rather use that. But I'm not attached to
> this one, so if we end up re-rolling, I can adjust either way.

That matches my preference, too.  Use of relative "previous" or
"next", unless they are in the same series, can make things
confusing.

For example, you could say something silly like "The test added in
the previous commit revealed age-old bug.  Here is a fix and more
test", and the fix may be important enough that it wants to be
forked from a maintenance track that is far older than the "previous"
commit.

>> This is over-specified IMO. Like mentioned this patch could be applied
>> on top of commit 9842c0c749. Then that merge commit will not be
>> reachable from this resulting commit.
>>
>> I also don’t see the point of mentioning when things were merged in in
>> the commit message.

Yeah, that is less useful to me (there is a tool, given a commit
object, to figure out at which merge it got merged to the mainline);
I didn't think of a way the information can be useful to general
readers.  If the mainline merge was a release or more ago, then it
may make sense to say "commit X, which appeared in version Y, was
broken in such and such way, and here is to fix its breakage".

>> >       If this is set to true, `git stash apply` and `git stash pop` will
>> >       behave as if `--index` was supplied. Defaults to false. See the
>> >       descriptions in linkgit:git-stash[1].
>> > ++
>> > +This also affects invocations of linkgit:git-stash[1] via `--autostash` from
>> > +commands like linkgit:git-merge[1], linkgit:git-rebase[1], and
>> > +linkgit:git-pull[1].
>>
>> According to these
>>
>> • `git grep -- --autostash`
>> • `git grep merge-options.adoc`
>>
>> This text exhaustively covers all commands which have this option.
>>
>> ... which might mean that “like” is an unneeded hedge? (it’s probably
>> not intended to be a hedge)

You have to devise a way to somehow ensure that a list, which
happens to be exhaustive right now, stays exhaustive, if you present
it as authoritative exhaustive list to your readers.  But as long as
the list covers the use cases majority of readers would encounter
every day, it does not make the list any less useful even if it were
not exhausitive (and does not pretend to be).

So I prefer to keep the presented text than making it sound an
authoritative exhaustive list and add maintenance cost.

Thanks.
