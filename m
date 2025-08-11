Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FD6157493
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754919953; cv=none; b=Qz59NQyeVpGjbo3h1FL7A5egYc8tFqzV+y7GQVoyET77KTgNolQro7mqykjckVyJxvDd3mu95ltZGZ2hVD1FdP4ELI/RExZWyzF2E3f4cM6NHyK6aDBexJrRSaFNdPKPBpMUfOCHuobG3Ar1QdoQnD/WXFP1nhhMyH6zGnCebUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754919953; c=relaxed/simple;
	bh=nUOThbPINWuWvyg0f2sIhUtStSpNsCRkUiv+hAS+CPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2yojLrKp/MN+upBmublN2DJ9B2WAJ1qL397f0wZY/9zDQtv1b27NU2noHlOBcreO3li3U8tsPeHNkpvCCDYyxvwf+lQmBV3LdUOHmWo+bd+aWASOsVSxPS7bVy4pQLs4wNSFlGG1JJmHf92EMgS+qag0Ate+hPVp1INO5S1kFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FmavOLRd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlHOwRbL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FmavOLRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlHOwRbL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 799A41D00094;
	Mon, 11 Aug 2025 09:45:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 09:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754919949;
	 x=1755006349; bh=4tewpSR+5hF+K41wZEh8UaYQpySOh4zLjn0CP2nb3wE=; b=
	FmavOLRd6CZGn+09SzCov28d1rlCo6ZOqjBbojevn1+rBJxe+znjFD52wmfaLRwV
	IhfKnkY7hHe6VVIDuUfD/gAva3MdGQg+9TYb7QvrACBYXn7DOfUqkPCv00E4zxUn
	1Y8B4Gt6C3iC2jsMPhUbBWxPjI8uj1GqfnxlWyGF2IieXsARhTjfg2oB3WLrXsJD
	QnjYxdP64NPw843QRZOJnZa9xQb4LifJHcWZLFbg64A/D0JISO9SJiVrPTsPxt0E
	fJURgmjpjlFfArpC6Vt6octvs480enbzkslGPGh7Y1EH5hpF3g7degQR3hbTrz61
	ED/ZKManS2gB/zxm7xDkew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754919949; x=
	1755006349; bh=4tewpSR+5hF+K41wZEh8UaYQpySOh4zLjn0CP2nb3wE=; b=P
	lHOwRbLdoeCqSkWC+BC89qGciJRTNV2AORcbSI12D0UaaYyYHs8ryXwtr7LTA8eD
	CvwYx4oT3LXbFTwF78zqKqrmiN6o6jqtyJrw4b9p56+Xs1I8wHPyVoirM3tTAUPv
	+zBum+/9m7QLhPJ//OtcX4ACAO4/Zzy/Dx0iKoRhKhtS3Gphi8tzkc1XC1Ckm89t
	DzFVuO/DJLjCrVgAFa0HOZDAo0C2VbHJKWhSmZhEec4cDZ93I+Y+7ShGg7XLzKnN
	wbFSNqocJCD4ePlwn0LKHC6ZoCV0jCpSfSAj37dKCMBALASBlOBNE0Narv4b5a0p
	0TJVhBya3G/MuA2hEGwIg==
X-ME-Sender: <xms:DfSZaAz4ExaefLx2yIeOIUz0jxgjmhwmPLFQjIi70zI7nkYaizXpYg>
    <xme:DfSZaO1yVdgr23-XhSI6VERvlGZo3K4ky9hazaLH-1b-VmnALEZR_qOkFTnV6mc3a
    ibzsaQDCdMNjwBmpw>
X-ME-Received: <xmr:DfSZaO7qPjNMshuNs6ttzhvt6fF2uw6S0WAv-2ukeNqhW5noyJdhsRYdrER5eW8gH_3aqrtrrYo_3pfPuT0CKgwtY4j2qZxnQYuxkn0Pc2c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrg
X-ME-Proxy: <xmx:DfSZaBURhf2qqJzQj9K056VUX5DVpdeJ2q8Y1CR4PDg4pBcCiTDamA>
    <xmx:DfSZaNBx88LCdS4T9LVU0351nT9OO055h-kT9mbFLePprKv45y3wWA>
    <xmx:DfSZaA5pk43nkVv16DGhtp_ZRCFzv8PJt0T9gcs76T6_J2NIhFZ9Kg>
    <xmx:DfSZaIw1O9Amdmh93G7sPXkLg3B6hqWIWivTtOh3JQFD1W9exmqoEw>
    <xmx:DfSZaDjOmbXpZRJVXXcBDYr9w8F8pMacvSyYScCDFnD8-JonlzrVlNKi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:45:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2138227 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:45:46 +0000 (UTC)
Date: Mon, 11 Aug 2025 15:45:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 5/5] doc: git-rebase: update discussion of internals
Message-ID: <aJn0B-RNjLXjmqKl@pks.im>
References: <aJmt1fv66bO_ZMpI@pks.im>
 <FA86B191-AEA6-49AE-A04F-EB736DF4845B@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FA86B191-AEA6-49AE-A04F-EB736DF4845B@gmail.com>

On Mon, Aug 11, 2025 at 08:29:42AM -0400, Ben Knoble wrote:
> 
> > Le 11 août 2025 à 04:46, Patrick Steinhardt <ps@pks.im> a écrit :
> > 
> > ﻿On Sat, Aug 09, 2025 at 01:14:17AM +0000, Julia Evans via GitGitGadget wrote:
> >> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> >> index 50c84f138212..c16ee37b46a7 100644
> >> --- a/Documentation/git-rebase.adoc
> >> +++ b/Documentation/git-rebase.adoc
> >> @@ -65,31 +65,31 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
> >> assumed.  If you are currently not on any branch or if the current
> >> branch does not have a configured upstream, the rebase will abort.
> >> 
> >> -All changes made by commits in the current branch but that are not
> >> -in `<upstream>` are saved to a temporary area.  This is the same set
> >> -of commits that would be shown by `git log <upstream>..HEAD`; or by
> >> -`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
> >> -description on `--fork-point` below); or by `git log HEAD`, if the
> >> -`--root` option is specified.
> >> -
> >> -The current branch is reset to `<upstream>` or `<newbase>` if the
> >> -`--onto` option was supplied.  This has the exact same effect as
> >> -`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
> >> -to point at the tip of the branch before the reset.
> >> +Here is a more detailed description of what `git rebase <upstream>` does:
> >> +
> >> +First, it makes a list of all commits in the current branch that are not in
> >> +`<upstream>`. This is the same set of commits that would be shown by `git log
> >> +<upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
> >> +list of commits is constructed.
> >> +
> >> +Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option was
> >> +supplied) with the equivalent of `git switch --detach <upstream>`.
> >> +
> >> +Then it replays the commits, one by one, in order. This is similar to running
> >> +`git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
> >> +are handled.
> >> +
> >> +Finally, it updates your branch to point to the final commit with the equivalent
> >> +of `git switch -C <branch>`.
> > 
> > Would it make sense to convert this into a bulleted list to further
> > highlight this multi-step process?
> 
> Nit: ordered list, perhaps? Unless we don’t use those in our manuals
> (away from documentation at the moment). 

Ah, I actually wanted to propose using an ordered list, not bulleted list.
Thanks for correcting me.

Patrick
