Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1034B154C0D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487128; cv=none; b=nuSMG9Vb7hR10AMNCXemH4kfw/rMHYrV/+aWyGTJePH/kcttCdzOYICx0l5Am89cGX+NKiY1rTSBCvTLOxYbCyxQwv0EpFuy+V0fEeXtvucFrT/OssKoUr+HXa56B+fLYmjjMAajN7F5FiOTdkxrG7GQhYmbKk2nZCd5FntpJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487128; c=relaxed/simple;
	bh=t0Wl9y9UVVbb7rOhju12crA9TEGEmBEmdJuW4V0vTLA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bCzNzZPlWoJmW4rAKqdNRtUgCXduI+w16UVe0XdtWmgC1EqfhcioVUbPVB611cH88c3MjWIGibpqMMf4USc2vkpDfk/GmXFamt72gd04H252nZjikmecD48HrrZp1gmDnhEr1WzYDaPJGRKRDFoVdT1t97u9tcydvmWoTtpZrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rdunlm5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E5JRsyq5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rdunlm5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E5JRsyq5"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 638721140235
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1726487124; x=1726573524; bh=EofC//tY1xtsQ+OEXCpYOt6ozGlAXd9d
	WjSLV8fNisU=; b=rdunlm5kZbGZqMFJEBYvedp7nDl/jHkP4clGJAMeuw3Bg1WQ
	MyFdZpiLl8MPWizd9CLlUL9aVtCaLBnvWpPCs+iha472XksnjN9j3IKtaKw8W9mB
	0ccZVPavkeN1pZq4qA8zCqoN3ZewWiK+f9ZwG4f3LZtBBYugM91wgYDLDFqA7LhU
	dlOfA45uT0337ZcoVLhpjRBClSKl+i60E9zfSS5ji2vaPFwNo+h5ypgXGJqBi4Bw
	ZQgpHjR5KDHKPBDOTrYL2jP4E/0X1ReNw6q82RCyq3jJzWEJ06mDjjU++XUWYhJd
	HohpUk1qvOsnjj+JzxHEUZu/rEPUI/zsok20CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1726487124; x=1726573524; bh=EofC//tY1xtsQ+OEXCpYOt6ozGlAXd9dWjS
	LV8fNisU=; b=E5JRsyq5FDmUhkYzIyjlZ214NMXRfXH2tdz9bITSsSCn32U1vJ4
	XHDff8xofZQgHFnyAkkgN0vFOWHBrSgZtyQaoY5nDTO3JnTbEnW9lc+ZLXYF3dsC
	h896GXabeljCuJrjD4zvm3YOeUeWXk7rYC6kFo4MPvlYG4z36JBquoGbAc9Q5+xk
	LB49zTmN7QtIuj4tsSmqFAdIUdG/qSaIKfcn547mxgenla8O/fL6VhzMe7Q/nF/e
	/9v0TjlquBntEL8p2HEoJeVnDWZ9XRS5gT8V/3jQ4E/04P7Xy4Y0muIIv+Hfj0xH
	TkuJwY3S9b7qOiqKvpI+4H6uh5K/wBF5Gmg==
X-ME-Sender: <xms:VBroZhfkoOz7ZZMlDwGvo-fR9wDLXLdeOrfnDO9dewTI78TBAgS2Tw>
    <xme:VBroZvPjl8w45lsdHZfMqYpO5Rh9i5ZffxSedqD40HcDIYnDJHlJsGy-v_7Euxh9-
    I0uEkaloQnNL5hpkQ>
X-ME-Received: <xmr:VBroZqi43Ggyi9OmdEk75Ru-vWQO9PmF8HpEVtnIYFke7shFkqBCttS90KsgIO7b5Qcomhnnqm0zSjYGGCuvZvfBmwqvzHEahRfc_gNjd6skJwtT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleejgeevgeffudejhf
    evhefhjeegkedvvdelteektdduffeijeduieduffevleefnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VBroZq_7pCOr9UZiiDbeHHpPF6NNFFcVNXkm_Gtg-6kptS5-DgsewA>
    <xmx:VBroZtsn9moCOfIfeC1UyGXmUPhddXifTzuYfXrHJUN1RBXKEZtG9A>
    <xmx:VBroZpFWaNs-fycTYSyC95SHGOfobnv_mzlqofkt_w2p_dxw6nkWEA>
    <xmx:VBroZkOzfCdNbKb5hONubQ7HftisnzvUgjVPOQjch1GZNLk9dIwKgA>
    <xmx:VBroZuUtOD0-Tfy6BItxKMPZAs0s6umsgMTjBR_lb6QEtXYNovoZAyNW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dab46715 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:05 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/23] Memory leak fixes (pt.7)
Message-ID: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

as usual, whenever the previous part of memory leak fixes has landed,
here's the next one. This series brings us down to 80 leaking test
suites. The 8th part is almost ready, too, bringing us down to 48
leaking suites. So the end is near, and I hope that our test suites are
leak free after the 10th part has landed.

The patch series is built on top of ed155187b4 (Sync with Git 2.46.1,
2024-09-13) with ps/leakfixes-part-6 at 46f6ca2a68 (builtin/repack: fix
leaking keep-pack list, 2024-09-05) merged into it.

Thanks!

Patrick

Patrick Steinhardt (23):
  builtin/help: fix dangling reference to `html_path`
  builtin/help: fix leaking `html_path` when reading config multiple
    times
  git: fix leaking argv when handling builtins
  submodule: fix leaking update strategy
  builtin/submodule--helper: clear child process when not running it
  builtin/submodule--helper: fix leaking error buffer
  t/helper: fix leaking subrepo in nested submodule config helper
  builtin/submodule--helper: fix leaking remote ref on errors
  dir: fix off by one errors for ignored and untracked entries
  builtin/pull: fix leaking "ff" option
  diff: fix leaking orderfile option
  parse-options: free previous value of `OPTION_FILENAME`
  diffcore-order: fix leaking buffer when parsing orderfiles
  builtin/repack: fix leaking configuration
  builtin/difftool: plug several trivial memory leaks
  trace2: destroy context stored in thread-local storage
  submodule: fix leaking submodule ODB paths
  grep: fix leaking grep pattern
  promisor-remote: fix leaking partial clone filter
  builtin/maintenance: fix leaking config string
  builtin/maintenance: fix leak in `get_schedule_cmd()`
  revision: fix leaking parents when simplifying commits
  diffcore-break: fix leaking filespecs when merging broken pairs

 builtin/difftool.c                            |   6 +
 builtin/gc.c                                  | 131 +++++++++++-------
 builtin/help.c                                |  16 ++-
 builtin/pull.c                                |  11 +-
 builtin/repack.c                              |  57 ++++++--
 builtin/submodule--helper.c                   |  26 +++-
 combine-diff.c                                |   3 +-
 diff.c                                        |   7 +-
 diff.h                                        |   2 +-
 diffcore-break.c                              |   4 +-
 diffcore-order.c                              |  19 +--
 dir.c                                         |   6 +-
 git.c                                         |  22 ++-
 grep.c                                        |   2 +-
 parse-options.c                               |  22 +--
 promisor-remote.c                             |   2 +
 revision.c                                    |   5 +
 submodule-config.c                            |   2 +-
 submodule.c                                   |   9 +-
 submodule.h                                   |   6 +-
 t/helper/test-submodule-nested-repo-config.c  |   2 +-
 t/t0012-help.sh                               |   1 +
 t/t1414-reflog-walk.sh                        |   1 +
 ...common-prefixes-and-directory-traversal.sh |   1 +
 t/t4008-diff-break-rewrite.sh                 |   2 +
 t/t4022-diff-rewrite.sh                       |   1 +
 t/t4023-diff-rename-typechange.sh             |   1 +
 t/t4031-diff-rewrite-binary.sh                |   1 +
 t/t4056-diff-order.sh                         |   1 +
 t/t4204-patch-id.sh                           |   1 +
 t/t5310-pack-bitmaps.sh                       |   1 +
 t/t5326-multi-pack-bitmaps.sh                 |   2 +
 t/t5329-pack-objects-cruft.sh                 |   2 +
 t/t6004-rev-list-path-optim.sh                |   1 +
 t/t6019-rev-list-ancestry-path.sh             |   1 +
 t/t6111-rev-list-treesame.sh                  |   1 +
 t/t7061-wtstatus-ignore.sh                    |   1 +
 t/t7406-submodule-update.sh                   |   1 +
 t/t7407-submodule-foreach.sh                  |   1 +
 t/t7408-submodule-reference.sh                |   2 +
 t/t7411-submodule-config.sh                   |   1 +
 t/t7420-submodule-set-url.sh                  |   1 +
 t/t7521-ignored-mode.sh                       |   1 +
 t/t7524-commit-summary.sh                     |   2 +
 t/t7601-merge-pull-config.sh                  |   1 +
 t/t7700-repack.sh                             |   1 +
 t/t7800-difftool.sh                           |   1 +
 t/t7814-grep-recurse-submodules.sh            |   1 +
 t/t7900-maintenance.sh                        |   1 +
 trace2/tr2_tls.c                              |  10 +-
 50 files changed, 279 insertions(+), 124 deletions(-)

-- 
2.46.0.551.gc5ee8f2d1c.dirty

