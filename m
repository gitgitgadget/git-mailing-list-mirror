Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338C43ABD
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735828954; cv=none; b=SAeO3R5QlzEpuCKSli2ktCJG7TxH4TZ0VKYOu2YTVMe1kcV4I8O7IL+uCtZD9cUkwg/boMF6WnP5X3GOdSKCKNeo4IrVsNv3TVIE8R8AHHAc5DbjSTkKbnaPxDlmJQbRyL/5dQWgqdOenoREtrFcOqh0CP7yLyotwMV9KRFN6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735828954; c=relaxed/simple;
	bh=IL8XTrh9Z7wfTjHXyQLFJ+9lv0T4E6yz+zepTcQfddM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9R+i4xWmtlBNX/RpuaA7iIyBjvnR9A/Rsc5NL2LSp7BFkVWIKaTRXmggyDuEyvABI42Csbq/jCp/2PI90wYCBCRA8lAsPo8XHaet+yH6MCmkT2DEWtwss1IDRNBnn6uuViKPuoswH7M45aU3W7zpN0CFf1ohaT24ZCuucaXTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K8pntGjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hHVijDGE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K8pntGjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hHVijDGE"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 69CB31380181;
	Thu,  2 Jan 2025 09:42:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jan 2025 09:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735828952; x=1735915352; bh=zfIWD0O8pO
	ZjBQQ0fQcILKTbb+cMxVev7MtUvfeFmho=; b=K8pntGjIRBCBGJRN/j3xxtm5lQ
	/UP8i8X9U/9RlmemMylVWDhwV/zYtDo7EErbeBbxUDIajgTqV8iGuSy7fF3mm9iI
	sQM3DWVO5kT0dv4cb/uBmFuZTKQ3nDRMQaJiGtpKOm/q98+SwyuR/i4uJLvsDmAG
	bDA9eVVdowUYSUVJKnNK2M8Bl0+vdybEwq/oPjwk+a+JwkqOAUFJ+gYCbQPfMLDe
	tPvs/EYJ26iNfbg5u3O5WiDDpFOEp562mkDFm/9fmgQRkjkHH0eiKgU3DhZwZmC3
	3vib3yrFWbgtqgjO+OTEUXziQzbMutxFOcKhza7aRKSEZl/2oCw29qgj4qrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735828952; x=1735915352; bh=zfIWD0O8pOZjBQQ0fQcILKTbb+cMxVev7Mt
	UvfeFmho=; b=hHVijDGECE5VEL0MSFXmD7oTIFg6REFkt+7i0AMNRefH1XVB4Y3
	1UBfXxPFky5EgYbqm+h/9kUGDFki6AYWYprU/9qyEHf6jX7pesDX6xowo+7I1yv8
	5U6k9nijdeLKvpLbE1BnJ3KnZUf5UCfZgnMm4cnKR9LfpRBNYWQGia5NitehNcwx
	8/7NSAC1yXd40eLcTUzT3/jTtzgyenK8rijLElxgh0v1hZb5/agTR4IhPt77m+tM
	kqXEmeLQoesJAETKmbXcWykTRCurXja1lbGJejfF322p4WrN3POw60VgrrioTUiF
	aKPlb7FMOL6az3KFM/ioqBlOyNGmNnqsmVg==
X-ME-Sender: <xms:2KV2Z9wu-QtboYQsl0cLhLS8W4J4M8oJNp2r1ji6l-RTeKfShrbm1w>
    <xme:2KV2Z9S3-Dtr8DSkydytbVhkJT-N2lFkK0WIkgcMOIn8QZwAoKiSvi4bNTl7uYatQ
    7tpqvlodrLfaiEuvA>
X-ME-Received: <xmr:2KV2Z3UV30TpgXUglXDjmT1P4T7DjCQt0AWCnqbd4GouCNMitqWSLn3pierQCM-0inVRMwrk5cL8tWZH3mXJiMtMVB-wCov2cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:2KV2Z_isAkOySvaDbwOuR8Xn_YGClPDgbXQNLeKRAezdsK6TV7esNg>
    <xmx:2KV2Z_A5brBcJUtOeK5gYqvnORQOyDwNBsUiHKpJkytaOjJ_ZbYBMg>
    <xmx:2KV2Z4LnIjF2so7bEcYRBE6s0l2xE3lXAmtGFjJa1bzEufGv-Zh6Yw>
    <xmx:2KV2Z-DvUOJwXGIDK0CLuy7tyK5oN8zsFXW6lv0xDG8vcMEr92sJCg>
    <xmx:2KV2Z6-avJH7Xlh38yYyiae7ZtR0IQv2A-uSMsqkLDBAeKk0d7vr7GTl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 09:42:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in
 git.git (Dec 2024, #11; Mon, 30)
In-Reply-To: <20250102023224.GA3853144@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 1 Jan 2025 21:32:24 -0500")
References: <xmqqpll9xehr.fsf@gitster.g>
	<20250101191422.GC1391912@coredump.intra.peff.net>
	<xmqqa5cavz8h.fsf@gitster.g>
	<20250102023224.GA3853144@coredump.intra.peff.net>
Date: Thu, 02 Jan 2025 06:42:30 -0800
Message-ID: <xmqqzfk9uvjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jan 01, 2025 at 04:25:02PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Mon, Dec 30, 2024 at 09:33:20AM -0800, Junio C Hamano wrote:
>> >
>> >> * jk/lsan-race-with-barrier (2024-12-30) 5 commits
>> > ...
>> > This graduated faster than I expected. :)
>> 
>> Heh, it is before -rc2 and the change is only about tests, so ...
>
> Yeah, I figured as much. I also considered it of relatively low
> importance during -rc, but I guess CI false positives do tend to annoy
> everybody and waste their time. :)
>
> It looks like you pushed out the version of 'master' with it merged. I
> had figured you'd revert jk/lsan-race-with-barrier out of next, so I
> wondered how we would proceed (revert the whole merge from master to
> rebuild, or do a moral revert of the final three).

Revert the effect of the tip-part (except for the bottom two) and
then queue the new ones, which would allow me to merge the whole
thing in one go without losing the bottom two's effect (which would
happen if we reverted the whole thing first, and then reused the
bottom two commits to build the new iteration on top).

> Looking at jk/lsan-race-ignore-false-positive, it looks like you did the
> moral revert via fc89d14c63 (Revert barrier-based LSan threading race
> workaround, 2025-01-01). That commit's tree matches what I'd expect (I
> guess you probably used "revert -n HEAD~3..HEAD" just like I did).

I actually did "read-tree -u -m" followed by "commit" ;-) 

> It would be nice if the 3-commit revert mentioned the specific commits
> it was reverting.

True.  I should probably amend while I can.

> I wonder if revert should have a "squash" mode that reverts all of the
> commits (perhaps in reverse order of application in case they depend on
> each other textually), and then gives you a commit message template
> similar to git-fmt-merge-msg, where we list all of the commits, one per
> line (though probably with their commit ids in this case).

I am not sure if I follow.  Should "revert HEAD~3..HEAD" give such
concatenation of messages, something similar to what "rebase -i"
gives us when seeing multiple "squash"es in a row?
