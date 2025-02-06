Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A72248AF
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828687; cv=none; b=ga5d86xQqafRFPDd/l5lE3mtaB7gRTCI+9PIDlxxqrVC5xPQUdzZ5U0aEnOgkr+gnN7Oe0W/TfaHzuY2JUpzIn9GYCGhTbM4jvRZl3QOl+HGRTyaTdYVvcxByr+mSCXbT5HB61WDj6fNxqAfBHVafLq8X6jvTnMxOX2+XtVuDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828687; c=relaxed/simple;
	bh=P2I1ZjPpLXftC7jc25qEEOycTS19vk+FbvfgEXCHD2k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UaetYSdmw6yiIN1b8J2ibSvIKURN66KsUQss35V7jX7pbhUCDTR2E4UzGb62GnbRbGM4Hw7/x8s+K2ZLKM7A6EpSAxulq/cyeQvqqAq2oH8rd8EYXcPlUVi8sPL0YwTZ+Z8hYewgTQIlVrMCR+YCQT/GVdf0ZdNxTKqKBc9vNdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L8zJqbix; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBlR+r8B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L8zJqbix";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBlR+r8B"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A41B21140189
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1738828684; x=1738915084; bh=Tquxs1El62
	aBTyyPU8T1agogO2vu8UUl3/jDfNjndWA=; b=L8zJqbixxVHZWygPuuuRCCDTc1
	J1IDtgcVGxGx0F8O5BRAXT37OcesmF7ov5QC00fz0b7W2Rp2/z9sO8gYh9QNXei6
	pURRNUbEk1yLYifPFf90/cdNWcgis2ZEem5izjasxLzmF6bfFM5C1/1nOLYstcGz
	cZeJCZvcjAP4BvgazCP0+R5QF7NC9n81MpsgeBp0SYLrujBmEJjvIGxz6cvWw/rC
	2JKfSBACyIBfDcH1WsbsJJO0judivmrxXLCy75+eZFlad9ltJm1lrPB73WCIQ9jb
	TEO6cXakvFmQ3PdvVObVD/cNh9DbRr1mTuEKg8x73dyPiRLkJjHgD2O53/rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1738828684; x=1738915084; bh=Tquxs1El62aBTyyPU8T1agogO2vu
	8UUl3/jDfNjndWA=; b=lBlR+r8BPSdmLRabcY3HIiJszYRod7MJC68fpJnjkxIp
	k+SR5G8A0MVmyKEd106k/M8vHjtSaA/geETWw7OCJhz4pjdi6IYBtsbE1O6XHfR2
	Tv0TDfRwsCVVl0urKanIglzuybBYJ2XCMRuAhWmoDSuK/g60HB9hztyLlJxGFGsT
	+FeW/9vmUxI76du+oYK0/SzCCW350Ff/AYm4YE++NLO95fLK6ky6GqO/z/vYCfH2
	bca5ZPjyOg0cz0JnEb4fdPWkHfef+9EgK4hsYIqHVdd/Pl4wMjfP0U2ytvnSNeJc
	Csa/W95kmAeiQ8hFuhLUV2cEEmUaG4MYIw/0XkcM2w==
X-ME-Sender: <xms:jGukZ0IosbS6PA1rurY8E9MujH0R-oqzmu1PN6AvaO0TQayd2ImpcQ>
    <xme:jGukZ0KMZ7qYWEl7xFrTP_CaT6WBgiiqibEdA8C6cm1Ag5nI9XAMhATshSntjLqsu
    Y7xf4wg92F5XqYpyg>
X-ME-Received: <xmr:jGukZ0tcUuZkSTjKXkX_ocY1867LaU5J4LTmVPbnC3h83IiH_1mqMsT43vKfgYQ1DbtQ83oo4kKluy1-rfctaCE27cIM9MGZDe64BH2hj8yY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuff
    fkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtte
    eigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jGukZxYaBHTXxp7GQSzhIddgzXcHC7irEXtFFdxkggoWV36HIqeFdA>
    <xmx:jGukZ7ajunEVPJ1ECtiYsITpZccCVk_nec5cKjKH-9Xs1iTyXYfH_Q>
    <xmx:jGukZ9DUO1wweoa7aLTQXf8bmE5QnlnoH8Xh7tvGxXlzh8S7i2u9zQ>
    <xmx:jGukZxYOCgm_e3bS2OYHy8WL1iES-xd8qpr41Ci7meWVD2Nsk2TZjw>
    <xmx:jGukZywSQAvnqGh9XvSblhWoc6CBm4AOdQazOvHzpgXbHhUFsqC4H0FA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0de6dcc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/16] path: remove dependency on `the_repository`
Date: Thu, 06 Feb 2025 08:57:56 +0100
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIRrpGcC/x3NwQqDMAyA4VeRnA3UToXuVYYHXeMaBjYkRRTx3
 Vd2/C7/f4GRMhk8mwuUdjbOW0XXNvBO8/Yh5FgN3vnBedfj0qN8DWUuCaNmwZIIlSQbl6wnBop
 uDWEYH2MHtSJKKx//w2u67x+XmceicQAAAA==
X-Change-ID: 20250204-b4-pks-path-drop-the-repository-9ed0f9956361
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this patch series removes the dependency on `the_repository` from the
"path" subsystem. The series is structured as follows:

  - Patches 1 to 5 unifyf the interfaces that can be used to retrieve
    repository paths (gitdir, commondir, workdir and submodule paths)
    and adapts callers accodringly.

  - Patches 6 to 12 drop repository path functions that had an implicit
    dependency on `the_repository`.

  - Patches 13 to 16 refactor "path.c"-internal code to stop depending
    on `the_repository`.

Thanks!

Patrick

---
Patrick Steinhardt (16):
      path: refactor `repo_common_path()` family of functions
      path: refactor `repo_git_path()` family of functions
      path: refactor `repo_worktree_path()` family of functions
      submodule: refactor `submodule_to_gitdir()` to accept a repo
      path: refactor `repo_submodule_path()` family of functions
      path: drop unused `strbuf_git_path()` function
      path: drop `git_pathdup()` in favor of `repo_git_path()`
      path: drop `git_path_buf()` in favor of `repo_git_path_replace()`
      worktree: return allocated string from `get_worktree_git_dir()`
      path: drop `git_common_path()` in favor of `repo_common_path()`
      rerere: let `rerere_path()` write paths into a caller-provided buffer
      path: drop `git_path()` in favor of `repo_git_path()`
      repo-settings: introduce function to clear struct
      environment: move access to "core.hooksPath" into repo settings
      environment: move access to "core.sharedRepository" into repo settings
      path: adjust last remaining users of `the_repository`

 bisect.c                    |   2 +-
 branch.c                    |   7 +-
 builtin/am.c                |   2 +-
 builtin/clone.c             |   4 +-
 builtin/commit.c            |   8 +-
 builtin/config.c            |   8 +-
 builtin/fast-import.c       |   4 +-
 builtin/fsck.c              |  10 ++-
 builtin/gc.c                |  25 ++++--
 builtin/init-db.c           |   8 +-
 builtin/log.c               |   6 +-
 builtin/notes.c             |   9 ++-
 builtin/rebase.c            |   2 +-
 builtin/receive-pack.c      |   4 +-
 builtin/remote.c            |   6 +-
 builtin/replace.c           |   2 +-
 builtin/rerere.c            |  11 ++-
 builtin/rev-parse.c         |   6 +-
 builtin/submodule--helper.c |   4 +-
 builtin/tag.c               |   2 +-
 builtin/worktree.c          |  43 +++++++---
 commit-graph.c              |   2 +-
 compat/precompose_utf8.c    |   6 +-
 config.c                    |   5 --
 copy.c                      |   4 +-
 dir.c                       |   2 +-
 editor.c                    |   6 +-
 environment.c               |  27 -------
 environment.h               |  11 ---
 hook.c                      |   3 +-
 http-backend.c              |   2 +-
 loose.c                     |   8 +-
 midx-write.c                |   2 +-
 notes-merge.c               |  26 +++---
 object-file.c               |  14 ++--
 pack-bitmap-write.c         |   2 +-
 pack-write.c                |  10 ++-
 path.c                      | 166 +++++++++++++++++++++++++++-----------
 path.h                      | 191 ++++++++++++--------------------------------
 reachable.c                 |   6 +-
 read-cache.c                |  26 ++++--
 refs.c                      |   6 +-
 refs/files-backend.c        |  10 +--
 refs/reftable-backend.c     |  10 +--
 remote.c                    |  21 ++---
 repo-settings.c             |  44 +++++++++-
 repo-settings.h             |  14 ++++
 repository.c                |   6 +-
 rerere.c                    | 101 ++++++++++++++++-------
 rerere.h                    |   3 +-
 revision.c                  |   7 +-
 server-info.c               |   2 +-
 setup.c                     |  70 ++++++++--------
 shallow.c                   |   4 +-
 submodule.c                 |  15 ++--
 submodule.h                 |   3 +-
 t/helper/test-ref-store.c   |   7 +-
 tempfile.c                  |   4 +-
 tmp-objdir.c                |  17 ++--
 worktree.c                  |  49 ++++++++----
 worktree.h                  |   2 +-
 wt-status.c                 |  42 ++++++----
 62 files changed, 639 insertions(+), 490 deletions(-)


---
base-commit: bc204b742735ae06f65bb20291c95985c9633b7f
change-id: 20250204-b4-pks-path-drop-the-repository-9ed0f9956361

