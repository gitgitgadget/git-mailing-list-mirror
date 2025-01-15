Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0389870801
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954920; cv=none; b=Zy3gOXl/E79kXvKh84fFP11jM1XXJmBcXgvIvv9ubrloutPzuyyYQaN32QCa1Iz/NT5tcFOjGOPD59xUqQWxiOSfMd2SVrJJnbKqLEEiFPOgICHEiRpu6Yo176PNWIyEJx6nHtB0x80uLA/qfrZgyVMXL9gUs+q1fGgEVOkCR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954920; c=relaxed/simple;
	bh=frLt21mSG4O/fiz7rwT0Y0hdr0pOk8SB24dLrEslwEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kUl+NP660JDOTT2JgEbECYwEENYxzpcLLhf90NQP7L/Ws/ImVm1KwR3n80ze9qtVEHQaDTe/s4tLhssPqPZMQODP9A09gdFyPFMjM54+YaHNBt83/iIoS67Xq/nY2leY/Rs3kHP6CawJc/OI9dxPUNYW/7IvbqDbUI8WbbXtxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=htiLGHh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKFQq9wP; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="htiLGHh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKFQq9wP"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EC1AB11400FC;
	Wed, 15 Jan 2025 10:28:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jan 2025 10:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736954916;
	 x=1737041316; bh=RiKgjKWnAXP9tN+04X3ErsH4q3s3idZl4pjHCb02xDo=; b=
	htiLGHh6nrHNL4/feQeEvHEo/erExQoncoSIeq0JkXvzn8gl0+ARRDiTOSroe9rc
	zRfRijchRXqdXxKU8CUAA3hmEmeGBXVkjf1A92wQ9/1fFCQTjIXbWwJpb8MMWnTH
	mtqdpXfjf8yC7Jtq7Z0D4H8KMvTogRAOFQ6PEGYEPZgYjfdNIrnBcRQt4AmcC4e3
	YAWtTzI8+JeZlwi9oWUtgpba8hFg/jJ9kPt0wzLShCK6sBP+Dw7GRZ1hpRbnrQB5
	ssqibc5c3DDU9kFW9pp9Nf9kGCndEWOr+msBwJocZ7rcvfxFJj6XAV+0GxCJKEGN
	u1/FZtuFfMn4Q7R9DRKPuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736954916; x=
	1737041316; bh=RiKgjKWnAXP9tN+04X3ErsH4q3s3idZl4pjHCb02xDo=; b=k
	KFQq9wPWEIeh+MDEskm/LsXhWXIkpeOtkPKTMibn3qDHLM+kAVDx/9VA0hVkiRm/
	7qxEi/1S/Bz0QJBABv1WBv5aabDkirS4nlzye9nBh86EBfCW0UdZjZ5dzq+16t9d
	D0RiqKOIf7hlNUyvl/9dO9/bVHsbzf8T+XU7v0dVF6zpm52K8WkrTytvQ3yx/ElP
	OCrbQdZBw1JnDkxBbxELpSfV9/uVpnDJ1g1i47cZDsO7uPNEmrpPaBBoaEBQB21+
	r0GaQrTQCBhDTcWnwjimtrLQOqYZbztEX1rdfVvj2NDJkr62c0F4eksNV+C4eBV/
	wVqAXM7+z2pmocfsNPopg==
X-ME-Sender: <xms:I9SHZ476pz-wrVNlaKCTAh48DkfbOx55lB_XgYx3DqdS-nVW2VaskA>
    <xme:I9SHZ55ef2znni1vNDDy8WDC7DTaRcz2Tce6eJ2rAtTBFwroHOa1WayZ-SJnoMQRQ
    7wuHliNQ30KxWjjtw>
X-ME-Received: <xmr:I9SHZ3eVRdZjCC3Rgk_gw09z_BhOYWgXwcA9nzV4HPBLFXcJB0EpvAxFS18iN8UGk1oAWgSG5a09b1loXJBVdbdwUeb576y-_mQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmtggvphhlsegtvg
    hplhdrvghupdhrtghpthhtohepjhhonhgrshdrkhhonhhrrggusehunhhiqdhmuhgvnhhs
    thgvrhdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:I9SHZ9L5gAD90mN_6WDJiQGckGtBSlPanU_JEFnpUhFmahTw9Rqy8g>
    <xmx:I9SHZ8LOOL2NiAfMoUYrfi5v4nUEhYyz6A3Tb0omo7IuNhZDxj73oQ>
    <xmx:I9SHZ-zwsPKJqcn2ydAwA4hH1JUbHSY-zIgxtR6fTHMaBh8cT9-BEw>
    <xmx:I9SHZwIu-IFcIEvzibKOZcrhJFhjCY78KvAuG_9DpDNIfGXRtFiV5Q>
    <xmx:JNSHZxG7zB5fbuWURUeTROiWfg5CDC3RFjzUOStHBQFC9H6k8MyHmG3T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 10:28:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>
Cc: "Jonas Konrad" <jonas.konrad@uni-muenster.de>,  <git@vger.kernel.org>
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> (=?utf-8?Q?=22Mat=C4=9Bj?=
 Cepl"'s message of
	"Wed, 15 Jan 2025 12:36:15 +0100")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu>
Date: Wed, 15 Jan 2025 07:28:34 -0800
Message-ID: <xmqqed1414gt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Matěj Cepl <mcepl@cepl.eu> writes:

> On Wed Jan 15, 2025 at 12:22 PM CET, Jonas Konrad wrote:
>> What did you do before the bug happened? (Steps to reproduce your issue)
>> I opened a terminal on Arch Linux with a bash shell and called `git 
>> branch -h` to get a usage overview of git's `branch` command. I then 
>> tried processing the output with `grep` by `git branch -h | grep list` 
>> which gave the whole (unfiltered) output, i.e., the displayed message 
>> was not processed by `grep`.
>
> And that is exactly the correct behaviour. In the world of UNIX,
> where pipes are normal, utilities should send to the stdout
> only substantial material, ...

If I understand the case Jonas reports correctly, he is talking
about "git branch -h<RETURN>", and the "substantial material" (I'd
rather phrase it as the primary output in response to the end user
request) in that case is the help text.

Somebody may want to go over "git help --all" and for each of them
try "git $cmd -h >/dev/null" to find those that give the help output
to their standard error stream.

Thanks, both.
