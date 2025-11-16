Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451427F756
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313531; cv=none; b=n/k7UEbt5Dv4H2bL5Quer03yeCk5aF4rbZppopWGznYdAZ0rPtkZCwZX8YDkz8IInj0/jS2D03jJlkX8bFE2an3ACw1Vh+8ANE/UTlds7kaPQgmIvZ3XyZd+9aBMfQakMPQc3pLlkcmipnAmovA9DuXg/wN0oPu5LjHkNp9zI2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313531; c=relaxed/simple;
	bh=nu+crWoD9IE7lcQ55cw+MpoKOrD5FMD25srw9a1Ikec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pyn0Sc1P5SGNgKPE8K+926Fxvqk1Fkbt5D6YCZSoSHvASmHKRMYc0yE7J9iHQnXyP5ckxvfanpB8C39mP5RRSXbYpi9WUfTDxNR/hqds2vLKtzoJM5yPSUGoOkWL3EzBhhvg5cVBnY1EB+OA86t5xa9jXDzwlEzrBY5b7Ndiyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yr7cdRKl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2jqoAZ/d; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yr7cdRKl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2jqoAZ/d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FB0B7A0172;
	Sun, 16 Nov 2025 12:18:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 16 Nov 2025 12:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763313526; x=1763399926; bh=1N8wLDHpTn
	fpzwI2nwhv56RvrdPsvaRkB4UwMiGeqs0=; b=Yr7cdRKlG6djfB6xznqTLWzlKC
	eBxMF2FDiF/jEWbdCDMpT+jE/8kj4I5V7to19Fsh9mjrn12ShXutURZGAOfqF9F3
	JZoEcWlG8Z8r/qGv3coXrtVtB6NLMr4HXjp0O0t5cIrrf8xeATHQtIIoFeKUqqcu
	f5wzCtgBislvcFb5vOB9nQ/3LnaU/kwxw7MRoOLC52/FFxIcphr6mwGeCZs3IQTs
	xpyebHk5bIZZKHSiPQPrupBpht2cXJN3t+Tf/VghFAu0K1ZL5tzmu7FRD6+1NEPQ
	mW7A9XEs0FlfG40dai+vA5toAFuVrRMrz6V1hvgfqf9FbyIrYldz3VnGpvUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763313526; x=1763399926; bh=1N8wLDHpTnfpzwI2nwhv56RvrdPsvaRkB4U
	wMiGeqs0=; b=2jqoAZ/dXf0PlXinh8Kb/ndXs4kZXEKyqWoyKVhZP8YyiDhteFk
	szQ86bOR5PgBqjXMKMdLciT94s/oCZ8GvSV6C9LOIWyIHvrxZHdwbi82SrCRM9GV
	pC1aD/hfrS/ZkVh8HkwlTq72U3u3T6DhtTXcufQdEyIQ7C/4D92TowOpBLBr+1/+
	KhbR+4poF3X1lkzHWslYGlISLZnOpP4yEYEoD73+uMmjx/igFzS6x4eE35cSESul
	f4npxr+TWb6ry3L0UXs3M4gmwyR2GtIkLgw82lOB3Sf1XZ7fmH7Ev5waEhyXRteH
	VxnSTCBzeUjiVraFS65Rduey7KVOHgq7Gqw==
X-ME-Sender: <xms:dgcaaUzEM97xQ3NALha0aOc-ruYT_8zU6TdgOYdrO1QZFDjGVO1ANg>
    <xme:dgcaabjk9DAfH8CSztPjhQi6n56bxb3knLBaxhQswTsbJ1MOFVHcY1IEwsfKAbeb8
    WR8I5iryxL8_pF41ppX7UFQmuQmwCTNZslS4RbtH4m4CkHFY1-J63Y>
X-ME-Received: <xmr:dgcaafw1LTDqJ0D8m5mSruENqgskOB0vBorgwG9A-YqLlz3QWB8yhkZFROBAYuuPgMJLDrE6kwULxlDNXMGv3Y1Lw4A4NmfPl7Ap>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeiudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteekhffhffdvudetgeffjeevvdfflefgffeuffdtuefhffeihefgudegteej
    feegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpphgvrhhfohhrtggvrdgtohhmpd
    hmrghvvghnrdhorhhgpddvtddvfeduuddvledugeehtddqrhdrshhhnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosg
    hogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhojhhirdhnrghkrghmrghruhesghhrvggvrdhnvghtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:dgcaaeLfcdhfMfcrZqFF8cjZ8EIXMEz47G1tLp4mhxONcjCCxEU5Iw>
    <xmx:dgcaaWTgiuIMSWCoNrbVSCycC0xaUVl4syA2F7xrjvn_W22HCbusxw>
    <xmx:dgcaaWpsvjyHhg8KdAYAczlc-5Bh_uWL9y7XtJ5Ex3zFOdFWXDeDWw>
    <xmx:dgcaabolYjNDjur3YhkLL-FXfGpFuU4fxmTajVv8K8cUCRr5IDhptQ>
    <xmx:dgcaaQUx-ni0GCGHIn4e32nKMe1MX9CxG6iulLxv6thvURp9lgCdNVaG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Nov 2025 12:18:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: CI Failures (osx with p4)
In-Reply-To: <CAOTNsDwS2er+31iFt4EnhW_ZupPG+Uree_qobBVj9v1q1+0vPA@mail.gmail.com>
	(Koji Nakamaru's message of "Mon, 17 Nov 2025 00:23:34 +0900")
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
	<b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com>
	<xmqqv7jcgy8y.fsf@gitster.g> <xmqqqzu0gxq2.fsf_-_@gitster.g>
	<CAOTNsDwS2er+31iFt4EnhW_ZupPG+Uree_qobBVj9v1q1+0vPA@mail.gmail.com>
Date: Sun, 16 Nov 2025 09:18:44 -0800
Message-ID: <xmqqh5utdhfv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> The cause might be that the macos-14 and later images are for arm64 [1],
> but install-dependencies.sh still downloads the x86_64 Perforce
> commands. This leads to Rosetta translation overhead. The arm64 Perforce
> commands can be downloaded with the following modification. I confirmed
> that this modified version runs without any error [2].
>
> [1]: https://github.com/actions/runner-images?tab=readme-ov-file#available-images
> [2]: https://github.com/KojiNakamaru/git/actions/runs/19407172619

Ah, sounds great.  Or switch to macos-14-large, which seems to be
still x86-64?  I have no strong preference, but given that newer
units are all running on Apple silicon, perhaps testing with them,
instead of what was discontinued a few years ago, may probably be
still a better choice.


> --
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 50628ee2dd..16ee593d30 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -7,7 +7,7 @@
>
>  begin_group "Install dependencies"
>
> -P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
> +P4WHENCE=https://cdist2.perforce.com/perforce/r24.2

Just being curious, other than "because it is newer than r23.2", was
there a particular reason why r24.2 was picked?  It is not the
latest that has arm64 macos (r25.1 also has bin.macosx12arm64
subdirectory at the above distribution site), and r23.2 also has
bin.macosx12arm64 subdirectory, too, which makes the above update
curious if it comes without explanation, given that this would also
affect Ubuntu that slurps bin.linux26x86_64 from there.

>  LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
>  JGITWHENCE=https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
>  CARGO_MSRV_VERSION=0.18.4
> @@ -109,7 +109,7 @@ macos-*)
>   brew link --force gettext
>
>   mkdir -p "$CUSTOM_PATH"
> - wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
> + wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&

You explained this change very well.  I didn't consider that the
rosetta-2 may get in the way.

>   tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
>   sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4"
> "$CUSTOM_PATH/p4d" 2>/dev/null || true
>   rm helix-core-server.tgz

Thanks.
