Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09518CBFC
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908975; cv=none; b=ZrDdrI488iUoSiUKFN7VfNRlrakchfxMYZb8bcAsSov/8OSS6z3Ae15X0Sf2rj0niZ/Hj8OjKttcqxRIlgGfsJd9huIWB+bd+DgoGPSyeG++vd8oNhiISdqtCmHGjZgMB7OVqhfv1ZM+h/b9OccKRe3X3zIZswiKQCqtzCN0sC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908975; c=relaxed/simple;
	bh=uNeR1hELJU/sG8zLZm8LVFc0MrqfuBgjyWfphE22m1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO9+SBcOWmTpz3xi/Z/cURY83z77j6uHRaicPKHJK+DBdVXOcPFZLeAJV9alQxzsFGAqRrELi7m0kRD3e15YV7lQQJufpkbmutO9diI2OJdbzG4U1RQp86dmu7Ci3sKcpDw+zs2ytyg/g4UIF1v7nONkUQWrg1dvwlLrdIOoNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j2OTUPaU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=foKBIGLm; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j2OTUPaU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foKBIGLm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B841913801C4;
	Fri,  7 Feb 2025 01:16:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 07 Feb 2025 01:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738908972; x=1738995372; bh=WK9VuT4GjE
	td66WB0wU7mFmpz+z8QexkwCA//JpoZf0=; b=j2OTUPaUICjyEX7BA52sQoUobE
	MxEchzV0FU2pqBoF7vlzKuG7iGq1izox4b4uoSLoMZMmBvphu2O7bpGqAlt18KmK
	/SrF+XhXexDAGYBODTzIej3pY+aDUSzkVZZLfsBOyBXUl72ob1uYwehzlisGmEYV
	jhWlIaVGwlOUHpn2VtYCJsMx/PmpAY7W5VqoLwiv5E1mI00rCkqQIKLbf6KzCtVu
	HIdQheUg5/1Dugk34c4slI4N2fvy7i09tsnEzfrXe6QIMebdPUQvpwXjT5Z67JmA
	E+I1NjLq/Mj/YhjLQb4Wy3aqPueBvKjEOmeZ4nOEHIRbt72Cj5/KY+naMQ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738908972; x=1738995372; bh=WK9VuT4GjEtd66WB0wU7mFmpz+z8QexkwCA
	//JpoZf0=; b=foKBIGLmASWu64P/WEql88qICjIQALrHOXD4ri7wEnN7X5St78E
	Oy3ojGAcWqJsYCavqGdmDRMIkgNPuoT0v/MUuWvSqGRRh5VvUa66NRgk3YCectl3
	F0VuokgvUZBZrkkSlk5CkQ128KznlU9tpofUt+b1ED2GM6oT3aReBdH/mlcgLLZs
	7uiMxp96pqda52bgRGojii2ImwYwuFmpLZDcvnXS5ynVpLYpc1pFo1w7kqxW0gNh
	VafYPwW04H7JaVwO/wBO0fx+oJoijrfLsB7hO0viOtfZR379VNfGfEwuf31CnOgB
	A7mCvSPOKwyRKUwnIeOEH34349Uz7nTK2yw==
X-ME-Sender: <xms:LKWlZ-WAgSKnt-QqpaxAv0Uf_XypgsUr3_AdbJtv2E5AlQbcqsz47g>
    <xme:LKWlZ6m7A7yOIzA1ORcy6YVlJe1weGvzFkoLH68tJeeViXzRPMmwIG4Bld-niSxiH
    7444XcfvF6K-1jgAA>
X-ME-Received: <xmr:LKWlZyYVXe3oVjMU_g3AlknygQ1DTTrb7S7EGz1JPy1O6zl-OGif_Et0cewH50tAHLnvSpTBQnfhrKgxL1MWwMp81NuEDinw5qEw-tnhzifX4Di->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:LKWlZ1WRjWlNBPEizatF4u0V-dBFzhKvTbaZ9kBsFqRTKaLnHws06A>
    <xmx:LKWlZ4kDeQ6iuA0qPAjHUQyMMYCXfmSuoEsBOIDe5qEtSDNqaBMhEQ>
    <xmx:LKWlZ6cz5nOTlmN-kYaMjlUoVDsnUpSdzWe6fMAuhYA1C8YFwBOZyg>
    <xmx:LKWlZ6GZ_Q0IMft0NGLaK_pSpo1seuezQNUfXg_LyoIOe1Zzg3LSng>
    <xmx:LKWlZ9yYY12F5uen--sODlrzTFa56j5gOanJEDxConnPO8xa9lmwqQO_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 01:16:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8e008fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 06:16:11 +0000 (UTC)
Date: Fri, 7 Feb 2025 07:16:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/16] path: drop `git_path()` in favor of
 `repo_git_path()`
Message-ID: <Z6WlKtA-zvi5HJOI@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-12-4e77f0313206@pks.im>
 <Z6Tcz79fVFGEe5Ao@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6Tcz79fVFGEe5Ao@ArchLinux>

On Fri, Feb 07, 2025 at 12:01:19AM +0800, shejialuo wrote:
> On Thu, Feb 06, 2025 at 08:58:08AM +0100, Patrick Steinhardt wrote:
> > Remove `git_path()` in favor of the `repo_git_path()` family of
> > functions, which makes the implicit dependency on `the_repository` go
> > away.
> > 
> 
> In this commit, I have concerns that I have already commented at
> [PATCH 10/16]. I don't think we should use "repo_git_path" in most of
> time, we may use "repo_git_path_replace" for most situation.

As mentioned in that commit, I don't quite agree with you. We should do
so if it allows us to reuse buffers, but if it doesn't it is totally
fine to allocate and free C strings.

Patrick
