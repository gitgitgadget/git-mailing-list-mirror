Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4709265CCD
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247237; cv=none; b=Uh/fx44SVHpQQV/uDjpXuDbzEWe6dghqUoNXbZ7yD+FzYYAdOI/E0obMAgDp7Tt1ZAldRfxbkuwSYyyZEXOSvhU7tQMd/lIjdg2BLdUjdE9k94x8PGtg4yz1srvyfJVC/jdH9EqWIXPIFNjdfj9+dTZS/vo4GpiRWrr+ol9GdoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247237; c=relaxed/simple;
	bh=HZSscRMeyiRqjQ5e889PkEcWFuhd7LyvuCEjq90nKt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TNroLkccykJ06tAv5PFlBMYZ8+7Ypxo8+5fNDHlylLyUxB8feiFGnffRlwvaDcDOjFMwXFVZWFi3SH6ce8m2WS7o8oiIiKUTfBqQ8j4f7AzzVhjQ7UqgvUZLYflBLDXTh1cjDSKuMOSpSMvzgCIjCPgVOm7+ePuIO9izJgRfve8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bIl3O4OR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jurHi5h8; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bIl3O4OR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jurHi5h8"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B3288EC011F;
	Tue, 30 Sep 2025 11:47:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 30 Sep 2025 11:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759247233;
	 x=1759333633; bh=jKygv4NdbM8YgWA8jj3M+2ggzsFvfiWktqi7g98++t8=; b=
	bIl3O4OR366JWcjj/U3IpGOFG9ncPlQ1pjKOO0Hi69DLPZd9ICTozK90TZE0dC2D
	P+43g1WVISkXERybSenWGeyxl76PgJ8IRuzYR+wDMVLMdr4xBALu1w3T/J9t2gGW
	rsnvPu2l1oVVY92L/T5vfyv19feGD7SJNetYCahGEkY9NSSyZaVbz0JmKkyLw/bc
	cSVCVS+bIZ7eDu8UkJ9zFv3r6CiMSGCoQFGmyALvM5U4t7NsGnKl4rfkXb3zIdYH
	cS495buYm71y3lEGnTb4piNzaLazBwKldmnNvK6br//9KrjtIyq6691WNW2QfFnZ
	osq1ySCbc5UiTJjzLgXE2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759247233; x=
	1759333633; bh=jKygv4NdbM8YgWA8jj3M+2ggzsFvfiWktqi7g98++t8=; b=j
	urHi5h8jrwYqmxVcDGMA+dhoLMLGB7RhHYTEZByK96onjysKMBNWfjD6lnMkuxqA
	r92DjWRab/hsITJUUn1n5NATlV5mHm6n39juPRneNAlxWsWMKCsZHLisH122Ruk1
	HRYMHbI0wqwcVcqxqpm65boNdtZMO3bVOsYeIzdtswi1cMytFRJ15UPiQ5vOe5Bx
	Kobh1+cDCNzfpXDJTDqqHfLYQ/9J7gBkKAcQsMg2vlYYXFbnVAcDgu88DpdmaAIS
	dmgH/wQSxCHkxT3nPhAmLAlLZIxwB30SZJX1XSxf9r0GTjssKG6SXx2uKde+3ymz
	1XM7JOh/jaK9X54tjNzpg==
X-ME-Sender: <xms:gPvbaB0bAujVgGu3V2QH_YdkpRXHzlFacxxDUT_gAuXCDWqFCxveVQ>
    <xme:gPvbaO9_Ku3mdWQlyVqmeHZL5sWYsEef_Cnpb6wDZEaUr1nRbsvr05FMeGj_A-_m2
    1lOjoHDhRaboLRuOsRpWMDcmUvNriXMzWnelhExM83FfFSOEPtu4g>
X-ME-Received: <xmr:gPvbaKPFb_-GQtfi5XTK4TFtgaqREWDE4-8H0shj8s-vHCa9T_js1voaX3WPrTSGn8vZ_VGfvcahjdt4os7Kn9-0mIfu7jhwVdDv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekuddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhhsuhgthhgrnhgvkhesshhushgvrdguvgdprhgtph
    htthhopehjrghsohhnuddutghhohgtrgesphhrohhtohhnrdhmvgdprhgtphhtthhopehj
    tghusghitgesjhgtuhgsihgtrdhplhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gPvbaKfCDEDgenfXKJHhpayEfzNz8422-OKh5HHX0L1sRI7dNjG1gA>
    <xmx:gPvbaBWoWjVc8FMc2qMZK3Vdr0BSHhN7l_KpPgR18riSq8yd75aQTg>
    <xmx:gPvbaKjI9FdL8SCVsE2wSwpCILPGbFcQQCO6Rs0vOVU-Zsx0afTqAg>
    <xmx:gPvbaI-nmWDM5FZBjIO14YxJOTZEmi3h-yXsL_n07udpfQZ-jxX79A>
    <xmx:gfvbaPMZlQTeVFRrSOhmAyuPp7zfaLkHrmG4Zl5dVhzpJlhV4VHUrO1y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 11:47:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Jason Cho <jason11choca@proton.me>,  "Jakub T. Jankiewicz"
 <jcubic@jcubic.pl>,  git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
In-Reply-To: <aNuxUqDMNcZZs68n@kitsune.suse.cz> ("Michal =?utf-8?Q?Such?=
 =?utf-8?Q?=C3=A1nek=22's?= message
	of "Tue, 30 Sep 2025 12:30:42 +0200")
References: <20250927152824.3132af88@jcubic> <xmqq4isn96s7.fsf@gitster.g>
	<aNglDzeOT5_4ZbdV@kitsune.suse.cz>
	<KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
	<GY1ni5SFkgBgVIHm9HoO9dtLuLWbUPCv5mjcsy5VGi09PyRLV_gv3MMw2zsinKpi5Aon9J-LESzTUuwMOUNLRRLqyXM7ON-98WTzhH7RIYY=@proton.me>
	<aNuxUqDMNcZZs68n@kitsune.suse.cz>
Date: Tue, 30 Sep 2025 08:47:11 -0700
Message-ID: <xmqqzfac3pts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michal Suchánek <msuchanek@suse.de> writes:

> On Sat, Sep 27, 2025 at 09:26:54PM +0000, Jason Cho wrote:
>> I think the best practice is to not add a work tre within the master work tree.
>
> And is that best practice documented somewhere?

I do not think it is documented anywhere.

In fact, I do not think the inventors of the worktree feature ever
expected this end-user expectation that checking out multiple
worktrees of the repository *INSIDE* a repository's checkout would
be any useful without confusing users.

IOW, omission of the documentation is by an assumptionk that nobody
would imagine doing in any other way.  

We can and should fix it retroactively, if the lack of documentation
is not guiding our users in the right direction.  Any takers?

> IIRC there are some VCSs for which it is common practice to keep
> checkouts of multiple branches side by side in the repository directory.

I can understand "side-by-side" but not "in".  Next to the primary
workree (aka "initial clone") would be more common.

> IIRC the repository directory itself is not a checkout in this case.
> Anyway, there is no obvious reason for anyone not familiar with git
> internals to not do this.

Meaning anybody not familiar with the tool would do any random thing
outside of the usage pattern that the users of the tool have been
establishing over the years?  I can certainly understand that.  But
then, creating a set of worktrees, one per branch, next to the
primary worktree that checks out the 'main' branch, would also equally
be a likely layout, I would imagine.

Thanks.
