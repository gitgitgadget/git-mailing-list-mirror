Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21971DDA09
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410002; cv=none; b=EJhLfI4y9F5JmFonMrXv/Mpl/3NFAPOa0iDGfOEOlOH2siSgcyuQ5gWhCFEvpd2b+yjIpGyh0dptDGsbFJSAI5j8fSrOjSTW+r+/7BZx4rsAN6B/hz4oAc/fIvkwRZx3+BULhLmYf5x0CqbHFBVWBtugFSYtPjdPKlGssJSiffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410002; c=relaxed/simple;
	bh=XtOaDKJnU0wla129UPRox8JiuCOrT8HuXHVt5ANQAl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=A7pZzzZakTwkgz7kF75kQpsjf2IZ61cOq1tdOEhmP7HgTH9IGadQhQ/IPKSPikLqiUVPR88tS/xuYRtDSpgaLqAEFq2AE3pCO+uJl2wJUTa6meFr84bQMdABQiaqSxzFHtpxywAa6E3vqsbI8YjivcOa6fdzVflMhDyKsYKOWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DmfM3c1q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJ0o0P2b; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DmfM3c1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJ0o0P2b"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F45E13842AD;
	Mon, 31 Mar 2025 04:33:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 31 Mar 2025 04:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743409999;
	 x=1743496399; bh=bn3fJW2K05elcEdA8RC6h0+1uCGsx/XucUOykrx0HmE=; b=
	DmfM3c1qgZmp8GXCCsi6JTeFakdohQHqoNPMUbKd8csfj5cvuZpq4CR6T0m4tK/f
	/slxspNpVLLmGXu/FFD5xBkFrUvHCHu65zJKxZTNAhp9D5xuQ1uLsPYr/kmV+FC4
	jF1DpcICPfll2F6lN3V2ZLVlZ4e/qo7msQz+b6zSkjTNISekvb2PvH2BXf83IvWs
	efCncV1Mqsz6xwB1V82qWp5bNCp+1TwdcPp11pBK8qXcmoput1EVC2Z+uYZ105GH
	w9CbGHkrUbfZYhWQL31tIU9nxewQub1knUKVffYUhSCCn4bRDch7ag+2yGgatfaY
	Q0CENiVgiRKyfC73ZVwabA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743409999; x=
	1743496399; bh=bn3fJW2K05elcEdA8RC6h0+1uCGsx/XucUOykrx0HmE=; b=s
	J0o0P2bcz0w6+tlwD+21IkZkP1EUC97AmqI6k0aY36ayfLXZNlmsGV0yAAkH1cgs
	5jqtD5ZzOdrIOoGIQzQchZd8DXgZ8q3nVIpL/RYoHib2BjgX6u/HeDQ26Z1VQtfX
	LrJOTD9IL5IgPM41PPrzolBcMm/tGtVuF1nkL+7EBRSvbdmCiUtXYhu7XnohxhDH
	qdQae4upvO/1qFQjOvXxfx8MgPXp7QVNeslayXI0R1+snK0fpGBK0ATfg1uE8Ncl
	qrD/Kl3RsK9zflIxvlD6n+QWiIKbBWHcF8W9fFkAMdcu2poVtgt1puVGIwV5jUBh
	AFADkUD/hD7OwI5RU9rPw==
X-ME-Sender: <xms:T1PqZ2aXNMIiAu_XPwsyxZcqhWdYNtWzYhHY0E44NXOmHRBKenEFkA>
    <xme:T1PqZ5Y2aD4gOE5fh5LHUT6I7FBzUlrhgq91cGJC-eLB9xdJ99x0Kn82Ie0di4U1i
    z2XUeVGOf8tcv8UdQ>
X-ME-Received: <xmr:T1PqZw9aEpFcCGxe_NtMZMix4dslgVUVDVMJkGJBn2Ih7qKL_insY6Ua7IBjuvHKS2PeP22ElVtZhBu65N89cCtZRKec-vQXvXEucGbhEq8EPBsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthhgseguvggsihgrnhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhrtghpthhtohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepvg
    hstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhsrdhrvghpohhr
    thesghhmgidrnhgvthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T1PqZ4o-cY5cMAlwlanZP2IKUPEYFyxs5L5oC0gjNULKqLGIM5pHSQ>
    <xmx:T1PqZxph4_PyKHNUH_5wbb9A0YurlDdWFx6sEHQTSt6FM0b64pQwUQ>
    <xmx:T1PqZ2RQ7LH7AWmLB3SFJnLd0Ev52Gle_HniA4kFAJwRIzjGl8KmTA>
    <xmx:T1PqZxqkpVh1gbQMGFlD1BHKsVKjiN6wuyS8iCPyMckpb9DNta0xeA>
    <xmx:T1PqZ1KSRJc33H2zJb1nJCal9x9Lt00pKJRbIjt99jtTTx0He3sFIZa7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 04:33:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45d54ee5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Mar 2025 08:33:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] Collection of build fixes
Date: Mon, 31 Mar 2025 10:33:06 +0200
Message-Id: <20250331-b4-pks-collect-build-fixes-v2-0-6b06136808f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENT6mcC/42NSw6CMBCGr0Jm7ZhSBJGV9zAs+hhkIlLSYqMhv
 buVE7j8/ucGgTxTgK7YwFPkwG7OIA8FmFHNd0K2mUEKWYtKtqhPuDwCGjdNZFbUL54sDvymgLp
 WjSHRNvosIQ8snnYj92995pHD6vxn/4rlT/1rNpYokJS9WLKqGrS55uSRn9CnlL4cwwi4wQAAA
 A==
X-Change-ID: 20250328-b4-pks-collect-build-fixes-b5a6ce086b72
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Sam James <sam@gentoo.org>, 
 Eli Schwartz <eschwartz@gentoo.org>, Thorsten Glaser <tg@debian.org>, 
 Peter Seiderer <ps.report@gmx.net>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Hi,

this small patch series collects various different smallish fixes for
issues with the build systems. The intent here is to bundle all of them
into a single series to make it a bit easier for Junio to keep track of
them.

More specifically, this series:

  - Fixes an issue with handling "-Dcurl=auto" that I spotted recently.

  - Replaces Sam's "sj/meson-test-environ-fix" [1] with an alternative
    solution. The branch is currently in "seen".

  - Picks up and massages Thorsten's patch from [2] to fix generation of
    "gitweb.js". The fix has not yet been picked up by Junio.

  - Picks up a cross-compilation fix for Meson [3]. There has been a bit
    of discussion with Peter whether this is the proper fix, but based
    on Eli's feedback it should be okay. I'm still open for alternative
    implementations in case anybody has suggestions for how to do them.

Please let me know if any of you are unhappy with the way I have given
credit. I'm totally happy to change authorship or adjust trailers.

Changes in v2:
  - Drop the fix for Perl-less documentation builds.
  - Pick up the fix to use correct environment in our CI builds.
    Johannes mentioned that he wants to eventually get rid of those
    builds completely, but meanwhile this is a trivial change to make
    the jobs do what they should.
  - Pick up the improvement for cross-compiling Git.
  - Link to v1: https://lore.kernel.org/r/20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im

Thanks!

Patrick

[1]: <310a34bace801d288e369c6a01a8d04ffc4c3c06.1741975367.git.sam@gentoo.org>
[2]: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
[3]: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>

---
Patrick Steinhardt (5):
      meson: fix handling of '-Dcurl=auto'
      gitweb: fix generation of "gitweb.js"
      meson: respect 'tests' build option in contrib
      meson: distinguish build and target host binaries
      ci: use Visual Studio for win+meson job on GitHub Workflows

 .github/workflows/main.yml           |  2 +-
 .gitlab-ci.yml                       |  2 +-
 Documentation/meson.build            | 12 +++----
 contrib/credential/netrc/meson.build | 22 ++++++------
 contrib/subtree/meson.build          | 20 ++++++-----
 gitweb/Makefile                      |  2 +-
 gitweb/meson.build                   |  2 +-
 meson.build                          | 68 +++++++++++++++++++++++++++---------
 templates/meson.build                |  4 +--
 9 files changed, 87 insertions(+), 47 deletions(-)

Range-diff versus v1:

1:  4bc8060a975 = 1:  3e9137c2d18 meson: fix handling of '-Dcurl=auto'
2:  4365cfc4a4e = 2:  7ba983d446e gitweb: fix generation of "gitweb.js"
3:  02d6ae13dd2 < -:  ----------- meson: require Perl when building docs
4:  fcf2478bd82 = 3:  33cd3e490eb meson: respect 'tests' build option in contrib
-:  ----------- > 4:  1cb210c91a1 meson: distinguish build and target host binaries
-:  ----------- > 5:  3172db10a10 ci: use Visual Studio for win+meson job on GitHub Workflows

---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250328-b4-pks-collect-build-fixes-b5a6ce086b72

