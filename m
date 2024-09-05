Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A913AA2B
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530923; cv=none; b=mrPtGa7UC5NYllSmk/LNMEqSXzqLZ7EZL0ACvlP8+yfy0eYN9z+TYnfpCultTkZBi87+TdlkdC/VJfNNgixvzqymPAnFbC/7+ZGQ2Im1iloinwxkEnOukrfHVea9CHFkiOSYh8hsRO1NtDmfPvnr8TyXnpbJ8m1B13rERndT5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530923; c=relaxed/simple;
	bh=dfSncIQYsxbVYU22CT8MpiH8OlNm0caPrMS3l0wM+kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxwIB6gH8JdUQiXROcMMsOHJ0B+oN3H2lnxjP0SgxbWKZXItMv1+NZOqwkVmcYjMNhMexPe6aefZwBnhPXfGuwRduVHyOZkdyVvDpabG3FPctt88V0QRT0taSNQ9P9LUHkfpPNmgwSAMo5loo/IuudcovS35brx5XxrMoI/3l9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W66oCeHH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WcJfK8ph; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W66oCeHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WcJfK8ph"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04D911140290;
	Thu,  5 Sep 2024 06:08:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530920; x=1725617320; bh=7wVzbAGmIT
	Y8WY4pErr7OHVKoHYH3SpSF8MssuYfkdo=; b=W66oCeHHNkbG3tpGLFVjOW/R0T
	LkOfZx9WPmGraLBq4LdyKgYYv3qYqAKbrA/1YJKy3if/MPFr9TF2ImNvK058131I
	47y+5JMaCYGkKp79X0KWHIkt8SKszdHLrrH97/9EgD5ClAXT7hBUQ3j+FvEF66Y6
	ueZ4N64qKhxcEEb2gRpohcQE/IIv0eZfExvsLv+GlOAWLb8RwqoiWBn8AZgyUpt5
	hQs/OmgxLi9GA36otcAlgM6A4Z7koIj8oGKa7LBeSuoHU5vGFAkVb/aBLn2MGEHx
	FlZtPu6JH7qb7RXrK3D5t+CmmgQ8GWYen6FoAI6Vgu1nLoSPf3vaXSCeD8Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530920; x=1725617320; bh=7wVzbAGmITY8WY4pErr7OHVKoHYH
	3SpSF8MssuYfkdo=; b=WcJfK8ph3BtRK8BWBky9IKn2q8at6UNuuAPvlLNwQTzb
	UcitFK7LT1BmLH4BwBEnaR7JXJy/KMeqSEKrfM8+Jzq+fWNyaznPJiQ6BBl+mk7M
	WK7YR32MNWYDpLypBYpe0M0MnD9bkVzKrDuptoGzL4QCodrx03FGhUiRjVeOCAok
	f/dNO1LzaYNj66WH1X1QCkq5fEeuMAgX7fwgIT8/DgeO7GnduFhwNoE4jd2Ulr/C
	hwrbm3mBfquIdnuV+iElre09C16ZRJsUx2IzLq0IRD5tAUcswfWOHwzjyjhhW9xw
	gX/J7/p3kJggmhFw3WnalM9AVEN42dn6th68mI5UPQ==
X-ME-Sender: <xms:J4PZZlGqKlayFwY5GNTezxG2mLH608etIX88xCRGxjgagb1oBJDbWg>
    <xme:J4PZZqVm0Y0F9abVtFZgiuoCcdus21Z8nDR8CqpXvrvjcfhqaS8pAQ4TCulx7-MWl
    0RyJQHas398w52kAg>
X-ME-Received: <xmr:J4PZZnJK3TEBT5CAIunJ5AihjOKN3nCRV4ev6sO1rb01StUxHtiUGSVuFBImfqUaOrAIz-JRiiBZSv-d5osmxhR_O89KJn55Dr1tmxAebUk0Anw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnheptdfhieetveekgeegkeelieffhedvfeeigefgvefhtdfh
    gffhledtlefgtdeijeehnecuffhomhgrihhnpehhthhtphdrshhhnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:J4PZZrGKFs40tH0QHbmo90p-TXO6FPaBUsVJa9Xy-xxYofEVPscBGg>
    <xmx:J4PZZrXXo5WXFDjIkpyg4g0IlfWvAb_q9x0VtaNLa2imN2c5PdTxIA>
    <xmx:J4PZZmMSUjycE0e_Yd7G7MK5pZAeUbKc8-E810Yv9d6VyVbYIKVtXA>
    <xmx:J4PZZq1XWKujGEKyo42ESeJEIBjTZzaNLYaRc8Ybly2y_ohiHBggLA>
    <xmx:J4PZZtJFS24EOa8ZyCnKMaI1VcZ4-ldY8oxPnJ5L7xB3HSCmWcw3IZOl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 92865320 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:26 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 00/22] Memory leak fixes (pt.6)
Message-ID: <cover.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

Hi,

this is the second version of this round of memory leak fixes.

There are only some smallish changes compared to v1:

  - Explain leak checking a bit more carefully and document the new
    `GIT_TEST_PASSING_SANITIZE_LEAK=check-failing` value in t/README.

  - Some more trivial commit message improvements.

Thanks!

Patrick

Patrick Steinhardt (22):
  t/test-lib: allow skipping leak checks for passing tests
  fetch-pack: fix memory leaks on fetch negotiation
  send-pack: fix leaking common object IDs
  builtin/push: fix leaking refspec query result
  upload-pack: fix leaking child process data on reachability checks
  submodule: fix leaking fetch task data
  builtin/submodule--helper: fix leaking refs on push-check
  remote: fix leaking tracking refs
  remote: fix leak in reachability check of a remote-tracking ref
  send-pack: fix leaking push cert nonce
  gpg-interface: fix misdesigned signing key interfaces
  object: clear grafts when clearing parsed object pool
  shallow: free grafts when unregistering them
  shallow: fix leaking members of `struct shallow_info`
  negotiator/skipping: fix leaking commit entries
  builtin/repack: fix leaking line buffer when packing promisors
  builtin/pack-objects: plug leaking list of keep-packs
  builtin/grep: fix leaking object context
  builtin/fmt-merge-msg: fix leaking buffers
  match-trees: fix leaking prefixes in `shift_tree()`
  merge-ort: fix two leaks when handling directory rename modifications
  builtin/repack: fix leaking keep-pack list

 builtin/fmt-merge-msg.c              |  2 ++
 builtin/grep.c                       |  1 +
 builtin/pack-objects.c               |  1 +
 builtin/push.c                       |  8 +++--
 builtin/repack.c                     |  3 ++
 builtin/submodule--helper.c          |  2 ++
 builtin/tag.c                        |  3 +-
 commit.c                             | 23 ++++--------
 commit.h                             |  3 +-
 fetch-pack.c                         |  3 ++
 gpg-interface.c                      | 26 ++++++++------
 gpg-interface.h                      |  4 +--
 match-trees.c                        | 10 ++++--
 merge-ort.c                          |  4 ++-
 negotiator/skipping.c                |  7 ++--
 object.c                             | 14 +++++++-
 object.h                             |  4 ++-
 remote.c                             |  6 +++-
 repository.c                         |  2 +-
 send-pack.c                          | 52 ++++++++++++++++++----------
 shallow.c                            | 15 ++++++--
 submodule.c                          |  2 ++
 t/README                             |  3 ++
 t/t5516-fetch-push.sh                |  1 +
 t/t5526-fetch-submodules.sh          |  1 +
 t/t5531-deep-submodule-push.sh       |  1 +
 t/t5533-push-cas.sh                  |  1 +
 t/t5534-push-signed.sh               |  1 +
 t/t5537-fetch-shallow.sh             |  1 +
 t/t5538-push-shallow.sh              |  1 +
 t/t5549-fetch-push-http.sh           |  1 +
 t/t5552-skipping-fetch-negotiator.sh |  2 ++
 t/t5616-partial-clone.sh             |  1 +
 t/t6132-pathspec-exclude.sh          |  1 +
 t/t6135-pathspec-with-attrs.sh       |  2 ++
 t/t6200-fmt-merge-msg.sh             |  1 +
 t/t6409-merge-subtree.sh             |  1 +
 t/t6423-merge-rename-directories.sh  |  1 +
 t/t6500-gc.sh                        |  1 +
 t/t7703-repack-geometric.sh          |  1 +
 t/test-lib.sh                        | 11 +++++-
 upload-pack.c                        | 22 ++++++++----
 42 files changed, 178 insertions(+), 72 deletions(-)

Range-diff against v1:
 1:  7c158acadf4 !  1:  fa62d0106a5 t/test-lib: allow skipping leak checks for passing tests
    @@ Commit message
     
         With `GIT_TEST_PASSING_SANITIZE_LEAK=check`, one can double check
         whether a memory leak fix caused some test suites to become leak free.
    +    This is done by running all tests with the leak checker enabled. If a
    +    test suite does not declare `TEST_PASSES_SANITIZE_LEAK=true` but still
    +    finishes successfully with the leak checker enabled, then this indicates
    +    that the test is leak free and thus missing the annotation.
    +
         It is somewhat slow to execute though because it runs all of our test
         suites with the leak sanitizer enabled. It is also pointless in most
         cases, because the only test suites that need to be checked are those
         which _aren't_ yet marked with `TEST_PASSES_SANITIZE_LEAK=true`.
     
    -    Introduce a new value "check-failing". If set, we will only check those
    -    tests which are not yet marked as leak free.
    +    Introduce a new value "check-failing". When set, we behave the same as
    +    if "check" was passed, except that we only check those tests which do
    +    not have `TEST_PASSES_SANITIZE_LEAK=true` set. This is significantly
    +    faster than running all test suites but still fulfills the usecase of
    +    finding newly-leak-free test suites.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## t/README ##
    +@@ t/README: GIT_TEST_PASSING_SANITIZE_LEAK=check when combined with "--immediate"
    + will run to completion faster, and result in the same failing
    + tests.
    + 
    ++GIT_TEST_PASSING_SANITIZE_LEAK=check-failing behaves the same as "check",
    ++but skips all tests which are already marked as leak-free.
    ++
    + GIT_TEST_PROTOCOL_VERSION=<n>, when set, makes 'protocol.version'
    + default to n.
    + 
    +
      ## t/test-lib.sh ##
     @@ t/test-lib.sh: then
      		passes_sanitize_leak=t
 2:  33bc728a345 =  2:  611a29d1ca3 fetch-pack: fix memory leaks on fetch negotiation
 3:  a13db9777f0 =  3:  0d969962a39 send-pack: fix leaking common object IDs
 4:  92fc97b3db8 =  4:  834a184c855 builtin/push: fix leaking refspec query result
 5:  77023421e18 =  5:  17b0c4b577a upload-pack: fix leaking child process data on reachability checks
 6:  b4b65c3783c =  6:  872f39faece submodule: fix leaking fetch task data
 7:  e3d1ac1712f =  7:  3cbd6fe808e builtin/submodule--helper: fix leaking refs on push-check
 8:  7fafcc53d23 =  8:  90647301de5 remote: fix leaking tracking refs
 9:  1446e42f0ba =  9:  bb845fc9ff1 remote: fix leak in reachability check of a remote-tracking ref
10:  138a5ded35a ! 10:  a1baba39bc5 send-pack: fix leaking push cert nonce
    @@ Commit message
     
         When retrieving the push cert nonce from the server, we first store the
         constant returned by `server_feature_value()` and then, if the nonce is
    -    valid, we duplicate the nonce memory to extend its lifetime. We never
    -    free the latter and thus cause a memory leak.
    +    valid, we duplicate the nonce memory to a NUL-terminated string, so that
    +    we can pass it to `generate_push_cert()`. We never free the latter and
    +    thus cause a memory leak.
     
         Fix this by storing the limited-lifetime nonce into a scope-local
         variable such that the long-lived, allocated nonce can be easily freed
11:  a1fca8104b3 = 11:  ddebe2f6f6b gpg-interface: fix misdesigned signing key interfaces
12:  922b8640a55 = 12:  242f6b76db3 object: clear grafts when clearing parsed object pool
13:  ec9a5143241 = 13:  4747042cb6a shallow: free grafts when unregistering them
14:  2a63030ff09 = 14:  d3996c92d80 shallow: fix leaking members of `struct shallow_info`
15:  920db3a2912 = 15:  66ed1151449 negotiator/skipping: fix leaking commit entries
16:  19eb9073482 = 16:  78c1e5e1772 builtin/repack: fix leaking line buffer when packing promisors
17:  017713f5a9c = 17:  d2e108040fd builtin/pack-objects: plug leaking list of keep-packs
18:  0722cb38ea9 ! 18:  9fd891f5222 builtin/grep: fix leaking object context
    @@ Commit message
         builtin/grep: fix leaking object context
     
         Even when `get_oid_with_context()` fails it may have allocated some data
    -    in tthe object context. But we do not release it in git-grep(1) when the
    +    in the object context. But we do not release it in git-grep(1) when the
         call fails, leading to a memory leak. Plug it.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
19:  b37391c0d6b = 19:  84b68affa0d builtin/fmt-merge-msg: fix leaking buffers
20:  05461e3b1c0 = 20:  bbb8ab20229 match-trees: fix leaking prefixes in `shift_tree()`
21:  da1c23a9ccf = 21:  db0e7a8733a merge-ort: fix two leaks when handling directory rename modifications
22:  3d30c727fbc = 22:  2368924995f builtin/repack: fix leaking keep-pack list

base-commit: 098ca6ba562006675df6a6d0948400d2d955458b
-- 
2.46.0.519.g2e7b89e038.dirty

