Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1391255E26
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364218; cv=none; b=mjXE6gZCaxBrfBe1KKLfWz5+egd1obgU5UMdPU915IzAk1bRaG3BhdqNpUx8QvVTgpvxq0qtU20fg+TtRpUbHlf/l6cxzZdl94aXQ77jSZR8X5l8oF3Yw794tORrc6plTN3il39pejSmIaPoxG48zCS0XDfKqWErqLifrOiECMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364218; c=relaxed/simple;
	bh=Ew7SM6OnK6cAfmSeoQmArxHq1fi1MZbd/n1Zd/ZgmG4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JnRHs6k70xoIcfRpmxpMASPeRqpcxx32j88i9HAVwjFsVzO59+/F7+0W5moOU8/D0nGk8m4k4ce9Y58ZFfSH7IhiNReRvGDZ+QVi0NLD6qwY6T827qx+Uy9fV1IYvMDm0YsOWRCJEJEFc/g8aVHy+zNtJ/v3Sd85E/NjPMi9JUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=j2kIYssB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQuW1gqW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="j2kIYssB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQuW1gqW"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id D699D114012E;
	Tue, 27 May 2025 12:43:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 12:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748364215;
	 x=1748450615; bh=1csTlcskk8Z9frVuy/8O+ueuIrrAX0iD5GY431iFjVs=; b=
	j2kIYssBWE0BbxyJMeJCXeVrbaJ3aFJ4JixJIs25wFpw2jVp0R4Y1rXMETLzUs25
	N647gatyn7Q9BTKIwEU25t6rrsyNycIe7Hgm6/oox9zAAJv9rYYHih1af4qd3o/Z
	n7NV9NVghzMFsTLbcNadENk96r2eCQdBFMeYPnyyptEzLQDAJ0AMOQ91O0L8cc0q
	fxToq7GPfe2bLQZxlQB3ECuEDbhbKIAxgdMXZUr7bLOt/NLkF1Xa17L4izJqCM4W
	rZnIW9eCOXjBKEVHP0G+Wf1RbCkbneYZpavdmtfpU4a0tf0us0NWwHQ0b7sgP0zf
	6Nf3Efij41Bokjw7Dhvi+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748364215; x=1748450615; bh=1
	csTlcskk8Z9frVuy/8O+ueuIrrAX0iD5GY431iFjVs=; b=CQuW1gqW3IdzhB1xp
	ZI2L00biE8kVBbIyMdrelQrk4XyxNzDlJpxCJBp4mTO5O5tv0GaWlovTZqwLDzSk
	idZ4Q6DXQzNujqZsMaCnZ3e6oFIbhMRcSKKVTzb65p2Uca1SUAH209yEDkYFd8RO
	w+D49df9T8td01Fdaj0qzQLZG2ACG6x10TxXBmISSzRh/dp1VXlOFIspW/0gpCjm
	/DNucrCo1Qx5+XHpo/7TYjRbLo6U0Bssy/eC0q0iZg/191db/cqgUDIFy5/fg26J
	TVgJdR5Z1X7kOxV+07rX4BwxtWi5w7KA3ordLSZV9tmEJC9qzvVFntbmkDglK2/B
	nncsA==
X-ME-Sender: <xms:t-s1aFCWdP82UqWyx-cLI9zsiUzYm3TbP0h9I0FVWv6b3VerVlPOdeY>
    <xme:t-s1aDj8Zb3c4kNktVNmRYMHdUnu_XvOEWWU0ia1jr5EyeFX490qp8AreEfbbC2CA
    wdQPRGLjxbHI0KsxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdekleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhep
    fdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedt
    gfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtoh
    epvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhosghoiihosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t-s1aAkMB1AFq9gOCoh04W_yY7wOa-hOADdvfg5FPKer9-2bOskGjA>
    <xmx:t-s1aPyh_5L12LxKHXCZ_xuSswiYxhuV_NvFfRq0VbZRktYWX8aNHQ>
    <xmx:t-s1aKQk9FrMpL3AVOtxKsBowiEr9lPqutoukU4wOCNmPwh4GAZ3yg>
    <xmx:t-s1aCaO9ZJuQ4qPR-k6ixmJYHB2icsXUFNR3i88AHMQRNrLpD950A>
    <xmx:t-s1aBtRC6SlQq7KBReoPDpCcH2LYeje7PHbbOSDQWAqfg0Ik4vLEavY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6F7231EA005F; Tue, 27 May 2025 12:43:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tb03821b9b78eb7a4
Date: Tue, 27 May 2025 18:43:10 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jon Forrest" <nobozo@gmail.com>, git@vger.kernel.org
Message-Id: <09518eac-948e-46be-9cd2-64304e78af81@app.fastmail.com>
In-Reply-To: <1014npb$rbl$1@ciao.gmane.io>
References: <1014npb$rbl$1@ciao.gmane.io>
Subject: Re: "git commit -a" Doesn't Add New Files. Why?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025, at 18:03, Jon Forrest wrote:
> The documentation clearly says that running "git commit -a"
> doesn't add new files to the index. I wonder why that choice
> was made.

I think it makes sense to only include tracked files.  But (in any case)
when the option was added[1][2] it meant:

    git-diff-files --name-only | xargs git-update-cache
    git commit

And this `git diff-files --name-only` prints tracked files which
are changed.

Given that you apparently had to pipe filenames to a command that
updates the cache (obsolete for: index[2]) and then do a commit I will
assume that mistakes were more costly.  What if you piped in all changed
tracked files and untracked files?  And you forgot to ignore your build
artifacts?  That=E2=80=99s more things you have to undo.

Also note the commit message.  It doesn=E2=80=99t sound like an endorsem=
ent.

I have also not seen anyone really recommend using this option.

=E2=80=A0 1: f0b32737ad5 (Add "git commit --all" since everybody seems t=
o want
    it., 2005-07-19)
=E2=80=A0 2: And the documentation that you saw was added in cb95bf488b4
    (Documentation: git-commit -a, 2006-01-13)
=E2=80=A0 3: index: also known as staging area

>
> Would the addition of "git commit -A" (note the capital letter)
> that works the same as "git commit -a", except that new files
> are also added be something you'd consider?

--=20
Kristoffer Haugsbakk

