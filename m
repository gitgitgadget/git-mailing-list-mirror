Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8D347501
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833806; cv=none; b=NVldUbgiHaNZFOQ1CxKrqE7S/kFtRnASnmgL4HrvAfZh1wINgxCZG2mv9zNfwVitjQokcOOaw3ofCzPlObuwWLOKHmjTeOvuvcGiYZO6xKHEh82Rwx8nQ67IWUC1VtKxQxrZQ7mDdWVG89P1ZZs83Owd0+my7FnI6V+qf3Xe5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833806; c=relaxed/simple;
	bh=QUEN0+qBIuRFLlHDS+wzgqFKUKVqiOH6onb3Drg46hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGFfYiaTIxLbCj3YRtJSy3bSsAex/angFoVhcKJs0I9+CTIcuhDgZpeeQHQGotoWaIToyZjrD9KGSNNVgJvkoreXJfn9XYrHJmihViG03IHnCxh7Bu3SChtig1VKdja38LSZr+UEVbGhAYxK0COw2cCHTX56CKHvRGr2DCAkqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hrr2Gb4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mr7gW15l; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hrr2Gb4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mr7gW15l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 76253EC0476;
	Fri,  6 Mar 2026 16:50:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 06 Mar 2026 16:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772833802; x=1772920202; bh=hxml6Bv+1k
	S1Ytb5mnBevNpKxzmOwEzmKaZyxiw+b5E=; b=Hrr2Gb4p2HAftzkEoCikEfPAF+
	Id8nU88HZEuUnkoV60PUxbx38wSrf14N7hn61gHnJ4MzX6Mi1PdXd14zQ885CTlU
	2t46vslGQMJn9JNOKRln4GAQFCGgeu5hSz/KZbn0zFq/4AUnIJPdCBH3uyFotbJH
	g/GgWE69gPwzlyCN1AwVqdP+Oin7aqxgmaAaqnNnGwmTelEJUhXTL5M0pf7tor12
	h+tFOYMMpDRsICcFiavo4Gnop6nA3QuGYIaMlKwUF7X+y7nkrGFo8baSBey+iKrG
	JNAqBWoBDGtmFwHJMh/WSSIOzBaAjiJzIOv14/0E9ZCs4fDuqd6jvJr5jr3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772833802; x=1772920202; bh=hxml6Bv+1kS1Ytb5mnBevNpKxzmOwEzmKaZ
	yxiw+b5E=; b=Mr7gW15lHv5ye6hHok+SHCZChDCSEk4stj/A47lJ6bkQmcnJf4+
	g3LQsyHkqmlvz5oGc0ggT9TGrv3SVPFgff4gsOSiL0vpx6XiGfnkJVSt6w3oZ0q5
	LcUNrk42BSrLvFL/4ylgGuAnqFyFwev1Xz+cMliQgBGdun0ynwWPfe9PhNhH6tpZ
	dUlZR2ii+X42fX1x7biaMJsSPYcmj+pgYmDWmFzeqWUSU6Vg3JiPSmZZ+3pFgAb5
	CDW/za02U5IcDdQm/IW9dvlSiGX8H+owJfko/5eZEvWoo+oM99y+aujvw4+ZtCEt
	bZQx9Xoh5qIag5vEACb/1lvGtsro1bHT4SQ==
X-ME-Sender: <xms:CkyraVxqhyNtK-nHeDcKsZc9p4O7HA58XhqoWbvCTrUGj8XvgAaczg>
    <xme:CkyracLXM7pW-f3QwGY6GKMUjGs5zD96unS4DAO6y907w7Z3kSSFN2LJPN-NQQQRc
    WwwdThG_aaAvwcKsxKrxt_kTrCxgUP2POEFf3w6HIaHLBE0Ku4KrQ>
X-ME-Received: <xmr:CkyraXq81aFYbKVbGPUj5wUou01RVlyaGXrMUhf69bdDoiVrnP6dwdo3pdTjROR1cwW65VlcLxBPQnjfYpV3B_ITKfiL0qbvdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghrihhkkeeksehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhhrohhikhesuggvlhgrhigvugdrshhprggtvgdprhgtphhtthhopegrrhhonhdr
    shhighhfrhhiughsshhonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:CkyraTIGcAFG0CC8-TUvJYsO-85h5MQvR1AAp0Q3q_j7ptLbz_Cm4w>
    <xmx:CkyraURMcYnwJ4_yXwsjGZT8XoUIOu79f9E0VFDutN6lDj9ugVjbPg>
    <xmx:CkyraavqbpqfJ18cdZtmG54PHclceNgxIE91DLTK3BrvVNjvTGUFqA>
    <xmx:CkyradbU7F19MuOEz1V2h9Mc9y0Gu6KfShHev-_9147vtPh9hU3geA>
    <xmx:CkyrabaqzgMwt6Vj9NNGjibaZ-4tAd5Nu-ZPf4YPlEGa6YFsbP4w3jFd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Mar 2026 16:50:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: erik88 <erik88@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  Aron Sigfridsson
 <aron.sigfridsson@gmail.com>,  git@vger.kernel.org
Subject: Re: Git reference git stash
In-Reply-To: <aarHnK-oPHlx_hCw@Eriks-MacBook-Pro.local> (erik's message of
	"Fri, 6 Mar 2026 13:29:50 +0100")
References: <CAB0c_PjtTs8dWJCoUnQfCUM_YOaK3e3FcZfCgWjTOLcNWj-6nA@mail.gmail.com>
	<aao1hFwJYpJymY3o@exploit> <aao7uLxQ0ir0m6s2@exploit>
	<aarHnK-oPHlx_hCw@Eriks-MacBook-Pro.local>
Date: Fri, 06 Mar 2026 13:50:00 -0800
Message-ID: <xmqqv7f8y6ev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

erik88 <erik88@gmail.com> writes:

> Pretty sure git stash push is the only one which does pathspec
>
>     git stash -h
>     usage: git stash list [<log-options>]
>        ...
>        or: git stash [push [-p | --patch] [-S | --staged] [-k | --[no-]
>                      [-u | --include-untracked] [-a | --all] [(-m | --m
>                      [--pathspec-from-file=<file> [--pathspec-file-nul]
>                      [--] [<pathspec>...]]
>
> and pretty sure it's relative.

In a very early days of Git, I suspect there were, but in modern
version with ":/" (or :(top)" pathspec magic, I do not think of a
need for any command (unless it cannot work from anywhere except for
the top level of the working tree for some reason) to insist taking
pathspec from the top, not relative to the directory where the user
is at.  It would break the <TAB>-completion if anything insists that
the pathspec must be relative to the top-level.

It may be a very good exercise (this can be done even by somebody
relatively new to the community, I think) to see if anything still
insists <pathspec> from the top.  And change the documentation of
the pathspec to say "unless specifically spelled out in each
command's documentation, pathspec elements are taken as relative to
the current directory" or something.

> Sadly, git stash list does not allow a pathspec, despite the
> [<log-options>]. But if you want you can do
>
>     git log stash [<log-options>] [--] [<pathspec>]
>
> instead, which is handy sometimes.
