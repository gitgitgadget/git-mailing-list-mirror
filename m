Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E4280317
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540767; cv=none; b=B55XU1ngsUYG1BGwuKibHbuT47vW+IxYoamBvFUfFmdsQgQe9KZXdZ6rEWyaavoJm5Tx4F0gHGt88DXheBaQWdRApn9xtEhdtmMm478P9M2kLeeuzNkg0bFz866uhdgZjyl2HSve+kpU/XMwrpuGhrqyk08Ot7UMpX0zDHLOEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540767; c=relaxed/simple;
	bh=r09nmN7zSkS5da/u87JI8fNw9CM7WAhraOBQsE5N6hA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N/7g0sOCVdWDl6blaJTHRLC8U8Wb1WuGbQGsSUjw0vbSQ1Yv8Khm8vOBosvnVmoW+A8xLMrkSj2qlXtVesZ4SyhbiPvaX3z/YWcdRXT1LqllF6NLUUmEgaA3mBmQSI6PARF2HJgIWTGlDcknSS7p6j2z+EvuvZkImbjlisCcX8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EM90l6oV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qigLarJJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EM90l6oV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qigLarJJ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3583D11401EE
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 06 May 2025 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1746540763; x=1746627163; bh=/1+IxaCBRd
	E9g1sIPek7yKUFfQJXc8GmmnqVWBJNRrs=; b=EM90l6oVrqiANtzi8lj4yC+ZFq
	p+RcwTcn8vw+1hmWJ3scHvexT+Ax+xM8ODAPXO2QOg/2hic6rtuuTyPt7WMEHkBZ
	KcCSkxWFB0G2+uas8Vd//6teHlx34k9qAL1aD6JhUmb42XUo49KK6FMwpTLzRQO1
	U3gsaMPgtAFtTkqmlN9yETtrlh6DV8CmNIupQSQsODPUysYhyKOjuuFGiyNYM97J
	nHTZmuQsXoFFFZfjNzpQlsYpCkN/St2e8yvKfSHMvLDgAEHMdyzHF2/8PSSL8BQB
	HrwWZzkX1ba8a5Tvs/5Bde9vQ7pmkhzhufCsBmZc6kMRe8m3TxIcH9/b8N1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746540763; x=1746627163; bh=/1+IxaCBRdE9g1sIPek7yKUFfQJX
	c8GmmnqVWBJNRrs=; b=qigLarJJurNJIqCnSyB0DuEKyMtsvFgH22t3TZV2O2CN
	Cyvn3k7ty8wizvr2Dt5RdQlyhrbMiZ3zenXIcXbKf9KTAgJIIdL9kJb+ch39vprw
	Sr6y2FluR9W7Flv37MisAr6GX9XPRABWW3MR8QmBfMsjIYMVbtz8EzJmC8+5p+WD
	ZJY2tB5oHdUF0aS/uZM0QYbQGh+2qqfx0GlRND+lWZOQqxi44xPVnaoMBjldh5yZ
	0GW3Ub7zHhKnqFEmRNRc7c6g3eB1m4uynNn06Rp2nqkwCObPuHPPd+22dSe+5aeE
	97RCz59DbO4OTGlQVG6svCs5clB5n/7Yen/3rgKZaQ==
X-ME-Sender: <xms:2hgaaKiIzmjLTCCDp_sLCMq4cFPKxtTBtGTexpoP_iE6lzA14XjnTQ>
    <xme:2hgaaLA7jSGTt2gwj9k7bDCokENDQNWfNwZVHNAW1hybufNOpibn9yNXpSfY5aTY-
    _r-qNg9u0mkATK7EA>
X-ME-Received: <xmr:2hgaaCHiYspTgnlU-ZfU9-wDy_PyGBYmWmk3GDqWt2jHLldL-moUQLfWjU8SzvbOFXsPC1R6BXxpvACc9B7NImYjsONrCJxH1N4xSvDn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuf
    ffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektd
    etieegjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2hgaaDRak1x7UUZCf6UdFSwM_khe2EX7FF_Ak6i_N8Ww6UxXGaIZSw>
    <xmx:2hgaaHzk-0kwyMv7vBllmjzqgS--00LJPitGh9V6il-tl2JpMgTvdw>
    <xmx:2hgaaB5NvnrCDzR5RtG4c6xEcu_WBty5FoYaLtklQScSYh9YRPePKg>
    <xmx:2hgaaExblcrEjqHRmmnhlNuzBy4SSDcfN8YY2nFRhGzHqB4TOW6qTA>
    <xmx:2xgaaPdvwyS5jfsp3dXHdi6oLiNy4ceM4OtUVB4_UKRUl47GpgFVc5Fi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44bf1757 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] Spring cleanup of "contrib/"
Date: Tue, 06 May 2025 16:12:33 +0200
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEYGmgC/x3MwQqDMAwA0F+RnA3UznrYr4wdbBtd2IglURHEf
 1/x+C7vBCNlMng2JyjtbLxIRdc2kD6jzIScq8E7H1xwA5avYVpkVY5oRVlmTD8aZSsYo3/ELuQ
 hTz3UoChNfNz5631df6MTMkpsAAAA
X-Change-ID: 20250506-pks-contrib-spring-cleanup-bb23b15d6df4
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

as I have lamented multiple times multiple times already (e.g. [1]), the
"contrib/" directory is a bit of a mess containing many bits and pieces
that just sit there gathering dust, without getting any maintenance and
sometimes even in a clearly-broken state. So I decided to finally bite
the bullet and do a spring cleanup of "contrib/", which resulted in this
patch series here.

I have used the following reasons for removal:

  - The tool is clearly broken, e.g. it doesn't even compile.

  - The tool hasn't received any updates for at least the last 5 years.

  - The tool has a clear alternative or just isn't useful anymore.

The next step for me would be to spell out a policy around "contrib/" to
match what Junio has said [2]:

    Things in contrib/ should either move up (to become a part of the
    core), move out (to become an independent project), or disappear.

With this model, "contrib/" would be closer to Linux' staging drivers
with the expectation that a tool should eventually be part of proper Git
in case it proves to be useful, or booted out when it doesn't seem to be
getting there.

Another subsequent step would be to split out some parts of "contrib/"
to be hosted in their own hierarchy. CMake, Coccinelle, Unicode updates,
VScode and the like are all tools that are used during development, so
they should probably not be part of "contrib/" but rather of a new
"tools/" hierarchy (we can bikeshed the name at a later point, I'm not
yet doing that in this series).

There's also other bits and pieces that serve as examples. I think we
should move these into our documentation instead of having those in
"contrib/".

Anway, this series here is just the first step.

Thanks!

Patrick

[1]: <aBhZHA7av8bWH9Ac@pks.im>
[2]: <xmqq5xieq3fs.fsf@gitster.g>

---
Patrick Steinhardt (10):
      contrib: remove "remotes2config.sh"
      contrib: remove "examples" directory
      contrib: remove remote-helper stubs
      contrib: remove "thunderbird-patch-inline"
      contrib: remove "hooks" directory
      contrib: remove "mw-to-git"
      contrib: remove "persistent-https" remote helper
      contrib: remove "git-resurrect.sh"
      contrib: remove "emacs" directory
      contrib: remove "git-new-workdir"

 contrib/emacs/README                               |   33 -
 contrib/emacs/git-blame.el                         |    6 -
 contrib/emacs/git.el                               |    6 -
 contrib/examples/README                            |   20 -
 contrib/git-resurrect.sh                           |  181 ---
 contrib/hooks/multimail/README.Git                 |    7 -
 contrib/hooks/post-receive-email                   |  759 -----------
 contrib/hooks/pre-auto-gc-battery                  |   42 -
 contrib/hooks/setgitperms.perl                     |  214 ---
 contrib/hooks/update-paranoid                      |  421 ------
 contrib/mw-to-git/.gitignore                       |    2 -
 contrib/mw-to-git/.perlcriticrc                    |   28 -
 contrib/mw-to-git/Git/Mediawiki.pm                 |  101 --
 contrib/mw-to-git/Makefile                         |   61 -
 contrib/mw-to-git/bin-wrapper/git                  |   14 -
 contrib/mw-to-git/git-mw.perl                      |  368 ------
 contrib/mw-to-git/git-remote-mediawiki.perl        | 1390 --------------------
 contrib/mw-to-git/git-remote-mediawiki.txt         |    7 -
 contrib/mw-to-git/t/.gitignore                     |    4 -
 contrib/mw-to-git/t/Makefile                       |   32 -
 contrib/mw-to-git/t/README                         |  124 --
 contrib/mw-to-git/t/install-wiki.sh                |   55 -
 contrib/mw-to-git/t/push-pull-tests.sh             |  144 --
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh       |  257 ----
 contrib/mw-to-git/t/t9361-mw-to-git-push-pull.sh   |   24 -
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        |  347 -----
 .../mw-to-git/t/t9363-mw-to-git-export-import.sh   |  218 ---
 contrib/mw-to-git/t/t9364-pull-by-rev.sh           |   17 -
 contrib/mw-to-git/t/t9365-continuing-queries.sh    |   23 -
 contrib/mw-to-git/t/test-gitmw-lib.sh              |  432 ------
 contrib/mw-to-git/t/test-gitmw.pl                  |  223 ----
 contrib/mw-to-git/t/test.config                    |   40 -
 contrib/persistent-https/LICENSE                   |  202 ---
 contrib/persistent-https/Makefile                  |   43 -
 contrib/persistent-https/README                    |   72 -
 contrib/persistent-https/client.go                 |  189 ---
 contrib/persistent-https/main.go                   |   82 --
 contrib/persistent-https/proxy.go                  |  190 ---
 contrib/persistent-https/socket.go                 |   97 --
 contrib/remote-helpers/README                      |   15 -
 contrib/remote-helpers/git-remote-bzr              |   11 -
 contrib/remote-helpers/git-remote-hg               |   11 -
 contrib/remotes2config.sh                          |   33 -
 contrib/thunderbird-patch-inline/README            |   20 -
 contrib/thunderbird-patch-inline/appp.sh           |   55 -
 contrib/workdir/.gitattributes                     |    1 -
 contrib/workdir/git-new-workdir                    |  105 --
 t/meson.build                                      |    1 -
 t/t1021-rerere-in-workdir.sh                       |   58 -
 t/t3000-ls-files-others.sh                         |   19 -
 50 files changed, 6804 deletions(-)


---
base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
change-id: 20250506-pks-contrib-spring-cleanup-bb23b15d6df4

