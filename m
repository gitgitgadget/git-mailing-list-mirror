Received: from mail4.tt-solutions.com (mail4.tt-solutions.com [83.229.82.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EF19D8A9
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.229.82.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287322; cv=none; b=fwDR19w1JN/cvj+CyQcy89v8Ii5H0+nEKAUMiyHq0cfB4tZTYg+j/O1BwlRmzrepkLBfVHsahZ4z78IqLdc29bTgPkC2GOKtk3OqAM9ua5yFZUwBIHRKAJT9s+C5ID1fbxAkWNH9Pn1srVPSK/YGwuH/qUfLKDDU1mfAQ/GvxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287322; c=relaxed/simple;
	bh=xusodHVYtrkeE6DAAQBRKKB8TP7Rm9j9PM8zE1Ca1Qk=;
	h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type; b=C0CnpZvw1FATTDbYQ5a2sEzlsxHGD0xHwHH+/cDEo0HWR+Q6GgRuXAuVCodogtVQwOXsJqkrRH44YQjV0raJ5AVSevxokr0xRByzNoot87n4WDDZuKHhybXkS5htoAXlOES8MUUOtH5FjAlXhA9AdxdFmdFdHrvH20reZDiMxLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org; spf=pass smtp.mailfrom=zeitlins.org; dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b=NAjEJfx3; arc=none smtp.client-ip=83.229.82.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeitlins.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeitlins.org header.i=@zeitlins.org header.b="NAjEJfx3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zeitlins.org; s=mlr; h=Content-Type:MIME-Version:Message-ID:To:Subject:From
	:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xusodHVYtrkeE6DAAQBRKKB8TP7Rm9j9PM8zE1Ca1Qk=; b=NAjEJfx3T5o1lTdJuaKFnMLu1M
	R1o/OCDesWridRMVlqDxyabMBZ+78Op15YWZLQ9DR/mlf/ZEWkAeouzwKqbuYln+fcQc/dhHclYeM
	uvuvPWo+r+6ltu0gJFmd1MOag8hu3aP8+PtaHc3RkLbV7ChAoaYvLl2Sntifwaz5fiuerKh2wcFnY
	sSsjYKQdDXHdu/ffZC0OqsJtA3Z2I9tpTWvIW9Y0cnupvzkEjF5UYRh4LmvynD1yxKJABaXEBzavg
	u8n0R11QUjkO5ZEn6NPVuBu06ByS3BBgWFGCMSIWVjI7wWvqyExfkxzFVIIdrPQ0/S79mgkJGt4K8
	GSP1tv8Q==;
Received: from [192.168.17.23] (helo=dark)
	by smtp.tt-solutions.com with esmtp (Exim 4.96)
	(envelope-from <vz-git@zeitlins.org>)
	id 1tVHdC-005oI5-2q
	for git@vger.kernel.org;
	Tue, 07 Jan 2025 23:00:58 +0100
Date: Tue, 7 Jan 2025 23:00:58 +0100
From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Would it be possible to add an option to disable validating submodule paths?
To: git@vger.kernel.org
Message-ID: <Mahogany-0.68.0-2854301-20250107-230058.01@dark.tt-solutions.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="8323329-468703135-1736287258=:2854301"
X-Mailer: Mahogany 0.68.0 'Cynthia', compiled for Linux 6.1.0-10-amd64 x86_64

--8323329-468703135-1736287258=:2854301
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

 Hello,

 In e8d0608944 (submodule: require the submodule path to contain
directories only, 2024-03-26) a check that submodule paths don't contain
symlinks was added to Git. I understand that this check is generally useful
and helpful, but I'd really like to have some way of disabling it for some
trusted repositories and _allow_ some of their submodules to be symlinks
(see below for the rationale).

 Unfortunately, there doesn't seem to be any way to do it currently and I'd
like to ask if I might, perhaps, be missing such a way or, if I don't,
whether a patch adding an option to do it could be accepted?

 As to why I'd like to disable it, it's the usual story: this change broke
my workflow (https://xkcd.com/1172/). I have a relatively big Git
repository that I use as a submodule in many of the projects I'm working on
and I used to just symlink the corresponding submodule directory to one,
primary copy of this repository present on my system, instead of really
initializing the submodule. This saved me many gigabytes of disk space and
is also much faster than reinitializing the submodule every time I start a
new project or, more frequently, create a new worktree for the existing
one. And this worked just fine for many years but doesn't work any longer
as any operation on the repository, even just "git status", now gives

error: expected submodule path 'submodule/path' not to be a symbolic link

as soon as a symlink is detected. Under Linux I can use mount binds
instead, but this is much less convenient for many reasons and I'd really
prefer to just keep using symlinks. Would it be possible to (optionally)
allow using them again?

 Thanks in advance,
VZ

--8323329-468703135-1736287258=:2854301
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQx+vLQdOwioQqkxtoG6kHeT2wehgUCZ32kGgAKCRAG6kHeT2we
hk4MAKCpdxkIfotyokBrqfMPDt6+au/eagCeOdt7GgBDVI4wJCoezBAjtcfO36M=
=EEzp
-----END PGP SIGNATURE-----

--8323329-468703135-1736287258=:2854301--
