Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4017C203
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868487; cv=none; b=ImpD3HVwYlrtLobXJxkO5oDGq2d82Bl3+Z3kh+sSv05FzulhVBmmexyJ3mBBI+dQWaaX3ziCRgQ+OLZm8fQir7FJi5GK5GVQFKgkERiLl29aZhLNQH+Um7z8PzJxDdm2SUdXC/QYUUmAze2eEOM/uuCR/gkbEXlEIAyF9ubepV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868487; c=relaxed/simple;
	bh=7LajxbGe1I2FEGU4SLLgjDhcZrsEUxHhzM60xvli8SQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=OwfFwSbVoGsSWdfdnCrYdSP3QMJrReyLFVelhfeUlYKFqNYCKTa/GWYiYrPc9U0/cB45twUki/NgnJkz8rMqdWNlC/8KgFt0yNykAkby6LLbIXaYaHyP5lEN2eWvyJrtm7TvDj0xes6TtyG8LJ7U8mJ1FD6C9ebfMINkEw7dB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jCQaIMW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bqg3QV7g; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jCQaIMW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bqg3QV7g"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2B047A0123;
	Fri, 19 Jun 2026 07:28:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 19 Jun 2026 07:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868484;
	 x=1781954884; bh=y9CSQyz/agd2vEwgvKqVewqQ8IT9yqHWf24nXOL6Ae8=; b=
	jCQaIMW6NRONYIeEa/mAVH1MA9XsdPltq7UxMkQ6e87fUAn+dBRmOZdrNlEjdKuj
	TpSD/xiEG86IN1zWTlPgjGTgTLlLP9c3wsmwPAbuUpDsgbbb0xtiwwa+77maJ+ax
	uWkbDkwzCK5q5mc5i6L+18SLZsYfYDgGeBktNPhvdXiA2gAsQUjRBNbZJke58VGH
	ymJ+7OHOklbCz2lppFcFOecJyjzFoXpflOGk89jJQ/4fL+JSasjvk/BT9kGPnv4/
	T79dHtSu4dPkm/iLF+qeIIS4RtEztCzv9/Vw2IihPuKM0JxyaU1nwaLNNweHfzh9
	/PXQeSuygIh/dSanTY1gUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868484; x=
	1781954884; bh=y9CSQyz/agd2vEwgvKqVewqQ8IT9yqHWf24nXOL6Ae8=; b=b
	qg3QV7g+v1UeJbuSh8ZylFCBMxH5EBv03UlJeU/s0G96574BGEajKBntKFYF2sje
	rN/7cKnt8VBU0Aq8ZlgdU5/Ek714YHL7jU//afUqLiF/RpLeNoMUz/UD7mJL42Ao
	84+0a37eo9ZPK5PRGRt6eNMTHM2hL2IVgDeS6It5fSKuW3zw+ApLP11u/xhq0GKc
	Ga0SsE2BUm5YIy4lK3O1SYWdrQeISj6VMz/PWt8qihhX0xkE8QRny8kSp3Qg5nmU
	kPUptA5afGbODXbbxgVEkku5MHDqiYx2tXCwhmC2xR4gy/gCus3g/VNIgpAs4oiB
	1VkIcipwngh5EjzE63bMg==
X-ME-Sender: <xms:xCc1alJD4IkmoIVrHWJTPrI7O2JBErQ2m38PYPPeQiWKvQWzvD6hrA>
    <xme:xCc1aoIWv7_dH3sJMR0F238bhTCH-yhQGzZD5EnHbrYu0a4L-Jlc7EIdLk8E6f2Aq
    kaxh_1KZ7EoCnmVv_vMFiEodclN5zLX93gCj29M5twnRSmjfnf3Dys>
X-ME-Received: <xmr:xCc1aitvVzyNGyk7edY5MrU520azRxgmyOyr0ft9YF6SWxVSTMDFjL7Yc7WfgcGwMPcA2T0Om4QlYTj_SfMszHoWLRen_1yveNWymjuv0Xg>
X-ME-Proxy-Cause: dmFkZTEtYwTR9NyZ7kWJeOx5U6J7XwgXgXlClryTZ15GtIQjtQXlrwo/FjzMuzSu6O3ARm
    zeOMyU5gIO7MTg9sPtQExFwqVynEci/xaXkpsN5Ouzkqdf9Udplpi6zTUQwh7X3CeJ5x02
    fFLWv1xoWoDkAoinIt+LKgh3PljUvx1U2WJJDnJysOSafJcrkuRiP+lZrQFLK1L5glGSSs
    rPCl8fyPTs1JL7xz5rk/MMII+pyRnhJp0l+VIj8YYEYjTAZPgi1EmlgCJ8jzRVN/dLsPK5
    jb2hzc2AX7D74Vf+HGfewMAspRscEH9j9reT9Pu7DEsgX3ulxbonIBuSy+FuBzvZfDXEBC
    8BI3zixEgTxPih+E9eQL+zqsYfrFzy1M9SOX6NHs6gVb8f1g8N3r6V+xBC33rIk3iPtOdj
    i/3jCLCp7PABp4xZbWJFJQxbbAZd9qUW6sqfR6NPI0Sgew2AKPkpTbkboUpMM3ortrSsNP
    eEi/27DuKSJHWygdEtJkLPyJAq+88Q3WuRwTO4lfRZUpovbm4sHHw/XVSeHPThZN07TpPg
    tzK32dT54JKZD6vDx6NcIccbcG6g69FUfPWV9QUS3lQNCV+2dHUKAmUpuiKUt+K+0SPfLk
    rDsVelIDIgH7oZ9n1P4AfjwZnLUyM0HnSgPDhXuTPC3z9SYWUXghUNmI9G+Q
X-ME-Proxy: <xmx:xCc1alQF391Q_xVmhiddMPOXOgcXx8PWOoYjk6Zmb9mCDY2AVCcbjw>
    <xmx:xCc1aoPyb0XIV4mfVdjW80y4RHJoEBVnlHsyCAYoi21KQ1JF5hH5Qw>
    <xmx:xCc1aqZB5p2_Ayv4IMPOPh5pLmqrBe_fxyQLp-H2l-F-k9rFHJpaAA>
    <xmx:xCc1aiwr-Bp2yIGqw-0NYWeYfnOuUTx981bQk6I46EfSN9PCa20-7w>
    <xmx:xCc1aozi88QG4_B8V3wcshJg0SucAzr9A8UwBoerlBM4UgGOekg2sd8A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 556363e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/10] refs: stop using `chdir_notify_reparent()`
Date: Fri, 19 Jun 2026 13:27:48 +0200
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALUnNWoC/43OwU7EIBAG4FfZcHYMUCDgad/DeBjo1I7GtoFK3
 Gz67tLVmPXW4z+Z+f65ikKZqYin01Vkqlx4nlowDyeRRpxeCbhvWWipnXQyQDSwvBfINBTAOnM
 Paew5wzSvPFzafMFM0wpoCAdFfUwYRdOWdsFft6bnl59cPuMbpXXn942Ryzrny+2Vqva931YlD
 7dWBRKsS96ZKFUy3bmdPfKH2CurvkftcVQ3dDDeGsQQvA3/0O4e9cfRrqEarXOBfMPdH7pt2zc
 fEzkKlwEAAA==
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

Changes in v4:
  - Fix the "onbranch" recursion at the root of the problem by
    explicitly disabling the use of the ref store when parsing
    configuration at ref store initialization time.
  - Link to v3: https://patch.msgid.link/20260618-b4-pks-refs-avoid-chdir-notify-reparent-v3-0-2a5669e8f486@pks.im

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
Patrick Steinhardt (10):
      setup: inline `check_and_apply_repository_format()`
      setup: stop applying repository format twice
      setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
      refs: unregister reference stores from "chdir_notify"
      chdir-notify: drop unused `chdir_notify_reparent()`
      repository: free main reference database
      refs: move parsing of "core.logAllRefUpdates" back into ref stores
      refs/reftable-backend: manually parse "core.sharedRepository"
      refs: fix recursing `get_main_ref_store()` with "onbranch" config
      refs: drop local buffer in `refs_compute_filesystem_location()`

 builtin/checkout.c      |   7 ++-
 chdir-notify.c          |  26 ------------
 chdir-notify.h          |   6 +--
 config.c                |   4 +-
 config.h                |   1 +
 path.c                  |  11 ++---
 path.h                  |   2 +-
 refs.c                  |  25 ++++++++---
 refs.h                  |   9 ++++
 refs/files-backend.c    |  48 ++++++++++++++++++---
 refs/packed-backend.c   |  16 ++++++-
 refs/refs-internal.h    |   6 ---
 refs/reftable-backend.c |  50 +++++++++++++++++-----
 repo-settings.c         |  16 -------
 repo-settings.h         |   9 ----
 repository.c            |   5 +++
 setup.c                 | 110 +++++++++++++++++++++---------------------------
 17 files changed, 192 insertions(+), 159 deletions(-)

Range-diff versus v3:

 1:  3ac83ba983 =  1:  3ae112f84b setup: inline `check_and_apply_repository_format()`
 2:  b6b15770eb =  2:  d03fb25a01 setup: stop applying repository format twice
 3:  5850f0602d =  3:  f437af7ce6 setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
 4:  e4b12483b4 =  4:  7704b7e5db refs: unregister reference stores from "chdir_notify"
 5:  4a78c5080a =  5:  545fe82dda chdir-notify: drop unused `chdir_notify_reparent()`
 6:  3f8ae36acc =  6:  5ac9f8c2b3 repository: free main reference database
 7:  2a22f9a2e0 <  -:  ---------- refs: fix recursing `get_main_ref_store()` with "onbranch" config
 -:  ---------- >  7:  0482470af1 refs: move parsing of "core.logAllRefUpdates" back into ref stores
 -:  ---------- >  8:  1b2f9d4ff9 refs/reftable-backend: manually parse "core.sharedRepository"
 -:  ---------- >  9:  c7ec7d887f refs: fix recursing `get_main_ref_store()` with "onbranch" config
 8:  6bc943659d = 10:  5fb782268b refs: drop local buffer in `refs_compute_filesystem_location()`

---
base-commit: 255322df35357168daefec8523a3cdc849edd6c1
change-id: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab

