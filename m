Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347523AE1A9
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765681; cv=none; b=eVqFrN88pM8AOicQpikWFkfvgtYphphATQDEYZ1oVQ+KTuMu0Qi6d4UoKHdZPryOMEPtX3dAumy2mNbDegaspZ1DxGad1G7x64RS1ULhZlN/p1FJ5BLGc/bhFyCMwW2Rt5Hwy5CsdG5uRqJv9NpcVZVh+K7LdsdWXVQYfInbE0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765681; c=relaxed/simple;
	bh=70tNLq0aMmDje4cuLD4A3NCXKGt6fT/AG1ExdGcFSb8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Y+Z/0ALocSVZGZFwGXAEdVLpSY/UJg8EChwuwkDtrqgnHCaE5Q4dbvWDrf5SfjHhWKhY5AD18uQKYTHRLF7mOF4xzZUKBkug717332/xoixEYjXxHDe6XiAINfxjUgO+cuxRbaJZMcTTDouN7aPUsCaEqcjrxCJknk4dXRdSSzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=grb+icjo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJK9SAP8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="grb+icjo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJK9SAP8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 89E231D000EE;
	Thu, 18 Jun 2026 02:54:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 18 Jun 2026 02:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781765679;
	 x=1781852079; bh=tMkYh4s/tcXyiWyFasVo9R3nntQTGnrREV1FMcor9Xc=; b=
	grb+icjoDeYspUSd3Wy76Y7KKVPaC+lfdUuHZjotB4qvNnUm3j4ghvuCQkyHjCvC
	pLZzx9E3CDkDgs9H4J7Q47f1X7UiwsSJVC0SU/XbVYcAn6RojM8w2Jp9vatpkTjq
	HJ5wrWrCsg+JEKeUEzzDVQs5rEXuj0kotIydXlBfu/VKhIWfhOUGoXJjBZincdtY
	SHOcBjjbzJfRqE5mqZM/IF6pS7JZXRXWHLk7lbBLQDnqSBvj4SH5kOPN5bI+WunG
	3X165Ol8J7tk3X+2exQhIuXucmg4C7VBfOpPfIggZ1wOdMQhK8mgnk4p+EVOe4Ty
	WVm52suOqrP222mzORUGQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781765679; x=
	1781852079; bh=tMkYh4s/tcXyiWyFasVo9R3nntQTGnrREV1FMcor9Xc=; b=X
	JK9SAP8Yy2HEM4Vclk8VgQRGY13G4dw39vYUL8jGEP4IqkXc9KxHjOi8Ns2B3iry
	/xg0zzt5vsjPH9WSSHYQBeDQEARiHYl9ExriPTZsb/8dCIEPBWJFbzFHM6wQvT+2
	p2ACScLRqhU9L6Leu1X3rl0vIQqIpjAuO21OMQTSdFi6JAopUS/qOKyzHqqzR0y5
	78SXam8tmtnmj0laGIy8kJYD2taGYHjZ9Zs2hle0byBI8p90a3SdvbeWhchGoi0+
	I21a4tigEmSOseOJzDQi9xsM+/kgInARSmKIeTKWfGFipXeOFYtwLWFVQ0UZk3eR
	bCfscQ2ZoHJ8nRElQPEEA==
X-ME-Sender: <xms:L5Yzan5hHMl3S9e5mCllkUzX6NFvV_hz43SqOseW-YBEkuJVxepXJw>
    <xme:L5Yzaj53A6iegZXzmFnPD-GGTPnJakD8WTIDARRCTvv8uI_cSPUC1uPN5axsCnvwc
    MmYH_ixAf1Jiq6p51yUaCD2x7hU1WWPon5ZbCC5Z5A-I6SM0YX_hA>
X-ME-Received: <xmr:L5YzajeHrcV1RHpKZvGf8TkdNDILZzIuREggHOT6T1KJd8LlRpyoeNVzQZBVeIEtQpcSWjLDFwo1FQJbZkoUqZmqIKK-EhE31mamon_ujg>
X-ME-Proxy-Cause: dmFkZTFo7Y+ChjXjacCUW2FKdSXFlDl6Z1b0gr+Dr+IvwW4hWceq9g2UsMgdjOhPvarKJw
    h8FCJBM5UobVgyAbIXS30kOV3e9aMujaXOa3i84H3cuVk0cq/VibKFtcwcm83EfsAL80sw
    Hk8nOHRQC41/90T2eGXWRtEGsA+rHnsnLHs5Hfg9NWdAveYUts8XNtgwP5P8K2LkZWb7Xk
    colg5XM2zaFcCdB/EzkZvnuIJ/QjDBeGi5SbsSfUoOze9yn0rGbhn2yIkbVvcBeV7aI76/
    /YyYWgiLZGqvnNQ+/GFQDdBdmmVynRnC/iozVlDoK+8ajD5s2UrIq6df9s90r3MtLgcFQV
    1h0kdWhNuD2vljPnOSFwepaWyn+RpdmLp9IGfJo6tBkQtiHiLukxKUXTj6siZts3rasLNh
    ZGRluGJkvCl1zBJr6VZQ9RgDpmSDjsnrG+Fzye/z22T5bCjnf9ieZp+7X/St2JIkeEsAN7
    EDgPowADB/9VdrqhTLoxzyg13Pm1CEna0jE3Gg+l9tmk7gqD8DOKOK4TkoosyAuCSSBTku
    h2dAXnj4mL+TnqVP1gxVlXejPsBQod5BmudZTiTsy3TgMM9cCDjZEEYL91CzIq/yLVQlBL
    Spyl6tGuCOMAJpFQKWZCj3JRVdaAICwx+U3vgbIGPHq3OUaM5PXIs8AkIY2g
X-ME-Proxy: <xmx:L5YzanAKMkR2mdzUMj0Pt2putHMENxSgL0BZdPzW6IkdiICFuCbmKA>
    <xmx:L5Yzam9HMGtQzOo8iJhAVzQngAjIS9n-4viN4xB4XF3_VWolPnV1EA>
    <xmx:L5YzaiJypm5WkBZbHGuHJe14V15Yz2STOY9m2z97S_bZw51KvQZ7Yg>
    <xmx:L5Yzavg3rOIBwUTEQhE9HIIyu2rPijD1iObyIcgGsLUH5w6dSk_S2Q>
    <xmx:L5YzathoCU87wBYj_2OAvy7hHox-F2FhmzRZU3KQhwoAP4dqcy7IGsk2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 02:54:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36b76467 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jun 2026 06:54:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/8] refs: stop using `chdir_notify_reparent()`
Date: Thu, 18 Jun 2026 08:54:29 +0200
Message-Id: <20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWWM2oC/42OQQ6CMBBFr2K6dkwLLQFX3sO4aMtURiOQFhsJ4
 e4WNMYlyz/5/72ZWEBPGNhxNzGPkQJ1bQr5fsdso9srAtUps4xnBS94BUZCfw/g0QXQsaMabFO
 Th7YbyI3p3muP7QBaonYCa2O1YYnWpwW9VtP58snhaW5ohwW/NBoKQ+fH9ZUolt7XKvhmaxTAQ
 RW2LKThwsr8lGYHerBFGbN/qNoOzRLUyVJJrauqVNUPOs/zG1qZUeZCAQAA
X-Change-ID: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab
In-Reply-To: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series is a follow-up of the discussion at [1]. It converts
the reference backends to always use absolute paths internally, which
then allows us to drop the calls to `chdir_notify_reparent()`.

Unfortunately, the series has grown quite a bit larger than anticipated.
This is due to a couple of weirdnesses in how the reference database is
constructed with an "onbranch" condition. We essentially construct the
refdb twice and loose one, but we never noticed because the chdir
notification subsystem kept the pointer to it reachable.

Note that the first couple patches that touch "setup.c" aren't strictly
required. They are a remnant of a previous iteration where I tried to
solve the issue in a different way. But I ultimately figured that these
changes are worth it by themselves as they simplify "setup.c" a bit.

This series is built on top of 1ff279f340 (The 13th batch, 2026-06-09)
with ps/setup-centralize-odb-creation at 42b9d3dc9d (setup: construct
object database in `apply_repository_format()`, 2026-06-04) merged into
it.

Changes in v3:
  - Reduce the scope of applying the GIT_REFERENCE_BACKEND environment
    variable even further so that we really only do this when we end up
    applying the reference format.
  - Fix a commit message that still referred to the dropped last commit.
  - Link to v2: https://patch.msgid.link/20260615-b4-pks-refs-avoid-chdir-notify-reparent-v2-0-f4854aa99859@pks.im

Changes in v2:
  - Drop the last patch. This seemingly destroys the whole purpose of
    the patch series, but after Peff's hint that this is actually a
    performance optimization I'm less inclined to drop the chdir_notify
    infra. I still think that the remainder of the patches make sense
    standalone, as they simplify "setup.c" and clean memory leaks. Going
    forward I'd like to investigate the idea of introducing a `struct
    fsroot` infrastructure that uses the platform-equivalent of openat
    et al.
  - Improve a couple of commit messages.
  - Link to v1: https://patch.msgid.link/20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im

Thanks!

Patrick

[1]: <aifAVpxanV31KUpC@pks.im>

---
Patrick Steinhardt (8):
      setup: inline `check_and_apply_repository_format()`
      setup: stop applying repository format twice
      setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
      refs: unregister reference stores from "chdir_notify"
      chdir-notify: drop unused `chdir_notify_reparent()`
      repository: free main reference database
      refs: fix recursing `get_main_ref_store()` with "onbranch" config
      refs: drop local buffer in `refs_compute_filesystem_location()`

 chdir-notify.c          | 26 --------------
 chdir-notify.h          |  6 +---
 refs.c                  | 28 ++++++++++-----
 refs/files-backend.c    | 22 ++++++++++--
 refs/packed-backend.c   | 16 ++++++++-
 refs/reftable-backend.c | 16 ++++++++-
 repository.c            |  5 +++
 setup.c                 | 95 +++++++++++++++++++------------------------------
 8 files changed, 112 insertions(+), 102 deletions(-)

Range-diff versus v2:

1:  ea89bedaa2 = 1:  2be38c1e02 setup: inline `check_and_apply_repository_format()`
2:  b87f1db13b = 2:  7fdcd81bb7 setup: stop applying repository format twice
3:  f72a8dc251 ! 3:  2162480668 setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
    @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *no
      
      	/*
     @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
    - 	    startup_info->have_repository ||
    - 	    /* GIT_DIR_EXPLICIT */
    - 	    getenv(GIT_DIR_ENVIRONMENT)) {
    -+		const char *ref_backend_uri;
    -+
    - 		if (!repo->gitdir) {
    - 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
    - 			if (!gitdir)
    -@@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
    - 			setup_git_env_internal(repo, gitdir);
    - 		}
      
    -+		/*
    -+		 * The env variable should override the repository config
    -+		 * for 'extensions.refStorage'.
    -+		 */
    -+		ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
    -+		if (ref_backend_uri) {
    -+			char *format;
    + 		if (startup_info->have_repository) {
    + 			struct strbuf err = STRBUF_INIT;
    ++			const char *ref_backend_uri;
     +
    -+			free(repo_fmt.ref_storage_payload);
    ++			/*
    ++			 * The env variable should override the repository config
    ++			 * for 'extensions.refStorage'.
    ++			 */
    ++			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
    ++			if (ref_backend_uri) {
    ++				char *format;
     +
    -+			parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
    -+			repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
    -+			if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    -+				die(_("unknown ref storage format: '%s'"), format);
    ++				free(repo_fmt.ref_storage_payload);
     +
    -+			free(format);
    -+		}
    ++				parse_reference_uri(ref_backend_uri, &format, &repo_fmt.ref_storage_payload);
    ++				repo_fmt.ref_storage_format = ref_storage_format_by_name(format);
    ++				if (repo_fmt.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
    ++					die(_("unknown ref storage format: '%s'"), format);
     +
    - 		if (startup_info->have_repository) {
    - 			struct strbuf err = STRBUF_INIT;
    ++				free(format);
    ++			}
      
    + 			if (apply_repository_format(repo, &repo_fmt,
    + 						    APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
     @@ setup.c: const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
      		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
      	}
4:  17bdcdb4c5 ! 4:  14daa680b1 refs: unregister reference stores from "chdir_notify"
    @@ Commit message
     
         Note that this requires us to use `chdir_notify_register()` instead of
         `chdir_notify_reparent()`, as there is no infrastructure to unregister the
    -    latter. It ultimately doesn't matter much though: in a subsequent commit
    -    we'll drop this infrastructure completely. We merely require this step
    -    here so that we can fix the memory leaks ahead of time.
    +    latter.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
5:  c2f13a487e = 5:  89fe37ebe1 chdir-notify: drop unused `chdir_notify_reparent()`
6:  730e4caeda = 6:  4a96b70db4 repository: free main reference database
7:  1dda77cd19 = 7:  e48fc2d69d refs: fix recursing `get_main_ref_store()` with "onbranch" config
8:  6d969bb023 = 8:  37935d50c8 refs: drop local buffer in `refs_compute_filesystem_location()`

---
base-commit: 255322df35357168daefec8523a3cdc849edd6c1
change-id: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab

