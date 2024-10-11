Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A292F26
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624733; cv=none; b=GJ9gsdJQJddShCiNZONfn+jMImqTELyLceUdrTGy+KZ3/nYPgsrxBJz0xsnVpRGHdwLZWxypNnJ6hV+HBPN5jmb2rot3QSgCc3h2ImcDBJqOn71kNqsIUeICEifUC+1rw1ILl+s+/cDl9UVdbfA/weBJhmkSzXu+LS04Dox1nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624733; c=relaxed/simple;
	bh=EMpLDWYpcp4lO41clNIPwPX+YoGcILQGvwkqxwZB2Ew=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q0E55D+INR4Gmk4eapcIj6IKsFD3qFbnYgNdJ0gFFiwie0J9r4SqdfN8R/NMTs7jiHkSu5y8NjIanfDfXQq57XI0UPBLzS1nGagmTHsH5+gjgnZf75wqbEMUGMTUxjI4GWezKcey81CbyGPrIRXYjHU4Q/pGn3VBgydAGoTahvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JS+/GOxm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MsoFduWZ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JS+/GOxm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MsoFduWZ"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 05E4C1380123
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Oct 2024 01:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1728624730; x=1728711130; bh=rKyqG/ADb9urcY8UjrbJ1N9ruTHb0USR
	JubmYtV1FSA=; b=JS+/GOxmLii9o154zxBMrjQ3U6TdYCESn+3dfHVPtCm/kU0b
	cHW/ZbRDyLVAgmouF4+gsKQG+RwNKN8+1cnNGB0rDyWDxvzt0OYbyaFP/zPkDHJi
	osrACewyrcNWLO83KPi0c7CtKo6FWwsMb42xEfw+5XOAEFT2vo2PpgxKERoDGVUI
	Wjh4H1s96ePUdB6C6DyF//lFPk5VTjeQ3I+a2nNPvdsJ+ffM6TwcAO0owcJ/0Dox
	IgIbwkdhTXAHl14znN2aOklkzBO4lTJYg2mqdls4sg4KjW4FizY3o/K6HN6LZaja
	B27ATFBpShDRq4SPs+88XS2/Drp7OyDMxFbwRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1728624730; x=1728711130; bh=rKyqG/ADb9urcY8UjrbJ1N9ruTHb0USRJub
	mYtV1FSA=; b=MsoFduWZ867Xbb8xzNZxmO+QhazcKdYA1hnAg0ZgZyB8DYVxRy9
	RHgHcmp4pvY6uQnhu3VTVu3pFe92hxmaOIyvd+hCTiG31sfesbUWeRvr44sDpsgw
	/P0RAdk1SBhYwaq+sJNM4AmrdCbdDBpP/aLY5cL656hk0Li7AIX+YJShe/28muAz
	LA2VRcf73W1ME5uz43uEiHelLjII5Ryci9VYLGQd2WVC4r65X0r2+reUS4wIU7jb
	H3uvI5Wr9PeAymEvbjz2LNvCC/bz8eQ+lLp9ThPP5AHr9YxV/xNF5pB+qHecVPiF
	UaFFIluB2L5YTtcERFPDOtI3LA82OBhz3JQ==
X-ME-Sender: <xms:WbgIZ5BzlJ4DahGdjqKIn3SYVyyWsON4__P0mWPgMYWc6S2LHEDIZA>
    <xme:WbgIZ3iwvpXFin_PD9aFrKbPeUn1ZGlUXtz6iEeqxfve-Zl3kHC_uYGbPe-EswY82
    GAQoczwgF5yFEsk8Q>
X-ME-Received: <xmr:WbgIZ0lLvcoOOh5_OUycBcz7XnaVu74lShIId5hMJL14W91hQlSECie7jK2dYoWnqnA3fo6_s4WLZ7WuRA8R_kq3DAjxD-2mFFHPRW2HIjyfxPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudefgfeivddvtdegff
    duuefhveekffevgeehtdffieevfeffueeffeffveeltdetnecuffhomhgrihhnpehpkhhs
    rdhimhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WbgIZzwQbF5GS6c1CZprZOQOEpsswboo6o5lBbWQeL9dL51HCv5QAQ>
    <xmx:WbgIZ-SVLIbe8-BO047Knlapg__bGfA5yY84VsGVCYQ8dZOj7ncdqg>
    <xmx:WbgIZ2ZGvZYm1igoFlY-_LDyaNdbQKA62HH_ovsX9N2BfqjNcRUabA>
    <xmx:WbgIZ_QufAhou-RvK8u_rSdQFTwtEg4mGzE5On8pyifAKrq0PaDNCw>
    <xmx:WbgIZxJnBgKhuoKrf0h-ss-BWlH--8EFubmDloP36vYWu-FCoWMVrnhd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c4f6a61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:00 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/21] Memory leak fixes (pt.9)
Message-ID: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

here's another round of memory leak fixes. With this series we're down
to 10 test suites which are failing with the leak sanitizer. There are
two patch series in flight [1][2] that fix three more test suites, so in
total we're down to 7 test suites that we'll still have to fix up. So:
we're almost done!

Patrick

[1]: <20240826083052.1542228-1-toon@iotcl.com>
[2]: <cover.1726556195.git.ps@pks.im>

Patrick Steinhardt (21):
  builtin/ls-remote: plug leaking server options
  t/helper: fix leaks in "reach" test tool
  grep: fix leak in `grep_splice_or()`
  builtin/grep: fix leak with `--max-count=0`
  revision: fix leaking bloom filters
  diff-lib: fix leaking diffopts in `do_diff_cache()`
  pretty: clear signature check
  upload-pack: fix leaking URI protocols
  builtin/commit: fix leaking change data contents
  trailer: fix leaking trailer values
  builtin/commit: fix leaking cleanup config
  transport-helper: fix leaking import/export marks
  builtin/tag: fix leaking key ID on failure to sign
  combine-diff: fix leaking lost lines
  dir: release untracked cache data
  sparse-index: correctly free EWAH contents
  t/helper: stop re-initialization of `the_repository`
  t/helper: fix leaking buffer in "dump-untracked-cache"
  dir: fix leak when parsing "status.showUntrackedFiles"
  builtin/merge: release outbut buffer after performing merge
  list-objects-filter-options: work around reported leak on error

 builtin/commit.c                          | 26 +++++++++++++++++------
 builtin/grep.c                            | 13 +++++++++---
 builtin/ls-remote.c                       |  1 +
 builtin/merge.c                           |  1 +
 builtin/tag.c                             |  2 +-
 combine-diff.c                            |  2 +-
 diff-lib.c                                |  1 +
 dir.c                                     | 12 +++++++++--
 grep.c                                    |  1 +
 list-objects-filter-options.c             | 17 ++++++---------
 pretty.c                                  |  1 +
 revision.c                                |  5 +++++
 sparse-index.c                            |  7 ++++--
 t/helper/test-dump-untracked-cache.c      |  2 ++
 t/helper/test-reach.c                     | 10 +++++++++
 t/helper/test-read-cache.c                |  2 --
 t/t4038-diff-combined.sh                  |  1 +
 t/t4202-log.sh                            |  1 +
 t/t4216-log-bloom.sh                      |  1 +
 t/t5702-protocol-v2.sh                    |  1 +
 t/t5801-remote-helpers.sh                 |  1 +
 t/t6112-rev-list-filters-objects.sh       |  1 +
 t/t6424-merge-unrelated-index-changes.sh  |  1 +
 t/t6600-test-reach.sh                     |  1 +
 t/t7004-tag.sh                            |  1 +
 t/t7031-verify-tag-signed-ssh.sh          |  1 +
 t/t7063-status-untracked-cache.sh         |  1 +
 t/t7500-commit-template-squash-signoff.sh |  1 +
 t/t7502-commit-porcelain.sh               |  1 +
 t/t7510-signed-commit.sh                  |  1 +
 t/t7513-interpret-trailers.sh             |  1 +
 t/t7519-status-fsmonitor.sh               |  1 +
 t/t7528-signed-commit-ssh.sh              |  1 +
 t/t7610-mergetool.sh                      |  1 +
 t/t7810-grep.sh                           |  1 +
 trailer.c                                 | 18 +++++++++++-----
 transport-helper.c                        |  2 ++
 upload-pack.c                             |  1 +
 38 files changed, 111 insertions(+), 32 deletions(-)

-- 
2.47.0.dirty

