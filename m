Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54411408635
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103448; cv=none; b=LyyVw81Gmmwxn4WqoMwykBHd9a5kSqLKDR/3f7rndXKz5IRN5SMEGw0uBS9WmM/VhMpOlu4wphMm56J0ZLfBPcGTmV4NC4u1/Q0S8uYaDizGnkkZKveDPXzgUozxP5NvNQGTl+8VXbdyclq22nLpn7Og/VpIWUjSwulC7wERQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103448; c=relaxed/simple;
	bh=JsZqlL3+wZFkdPqfLAIhimuTVy3ZyZQ9rX+2Jy95Obw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QDoL5EWJy/y4ZI759b1TyoflvzT/jAC0MkWSoLqc5o3Gfb7o2Y/Q2mgh0spgfrYUZsm9P/uj+34TM7zv6QC1LMdtp69pK9J5fK4ZCipYs/LMm3xKIYRRpawRbrPWs2ZfITRmIOHCPHzqyY8BgpQkGkl724Dv7eFehf3rlpnW50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QVbeY8PC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xx8mx8Pe; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QVbeY8PC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xx8mx8Pe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 27802EC0086;
	Wed, 10 Jun 2026 10:57:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 10 Jun 2026 10:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1781103444; x=1781189844; bh=qORi1IQaVm
	rvZpSIdp3jEHNCBLKVwotiLc/1o9wFGGw=; b=QVbeY8PCnflGoLwup+DFhzJPDl
	uwYBDlqNugNyvxMMGvBuoCm21Wz0IEWtVbCY2YFmFJlhpdf2V5MSqI0CDiRl75d3
	esB9HYe5MQjPxqw/+AzmyWUiGyQVG53Tw3BY1njG6XRo47EPNZ2DFOgsqYTi25nM
	My/OkQsStl8zFzMgkoHhH9T+KERIZ6W10/w7bxwMAOhR06iNM6XFch3GUXWzgq4e
	29afo6EiMNX8KfP8TDP2wKcUJAwU+qHTKx9c7qViSHXUfPdJwt2eJ5osEBuBUxpm
	1Ty5Tpk4UTsnuF+5x9Jh7W0P4HiIs5R/LBQ/R1eD+Ntq96GbI3rHn5KaIAGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1781103444; x=1781189844; bh=qORi1IQaVmrvZpSIdp3jEHNCBLKV
	wotiLc/1o9wFGGw=; b=Xx8mx8PeA+TP2v9xGxuAmGk3dchpNH4RCH2A4jQUqS/A
	IwwqEnA2OVURrER3IUKlvFzA3wjFTCvAaQCOF51P9cLA6tbC9XTWh4T/CvqPN+yI
	IbdxDS6C09ut5eeIzJuwTGK0osoaAj2yUC/u0Q+yhQEULw/uqZC6YN/ymwn7Mj62
	dWuvAjK4EmJQILnXZUvGaY4ZzhXPlju5DOu5i+t59h+UlqI+DPT78HhHARmZfWhh
	nEjMEwdhp6bd+pMFoz7lLW2PZ1ixYuW2cy+Kb9cwBs+KhcoqsVOm+OqxFHLeybj9
	aWIhlkUsnenAe+OGVnVr2m/GjPhsXuiuTxbejN8RkA==
X-ME-Sender: <xms:U3spatgSPO9pTCuW1XWTFz17Rnlb7QFqujvBPvspgvuU3sfxSBSwHw>
    <xme:U3spaoC1NV1Ie9hgA0WAoxyShlOwL3bdIl4g57tatAiEHJDYIddENulQEy4HpPJmu
    77V0MSyf2IuT1ziaUYtDjl1nBzHQntT98q4pSjkhLUlsMvUTxU2vg>
X-ME-Received: <xmr:U3spaqs9OHdpsH1u1Q03ujf0-5sxrTqWM3oGnTsrEBDIo0NvgD5UEihZhG7XkhETw03FYm8or7TbfdqDmZVsmO8NyvkrQUyJ0sKdahB1ew>
X-ME-Proxy-Cause: dmFkZTEr9q1hk1XMioTPXCGlf5I02d6fqHtlkI6YwV8PzzF9qLE0dMmWXuxowDb93hly97
    cOBFyG/j50wmJVrHLaterDy/BukheMoDUd548NyUm8r2nBcqj0EhEZYenCfVGB0DiuqdoX
    vvTpEh68nJNF7ymJeJKOAvIqJaSqBLewcmr0j4H9iPMOh9M61am3lK6jZApzzF3Q8ojVQx
    iXbx0X6d1CI5TiQvYeQtdNF5doHx8Gg5xDwodmkeDILLn4iYztUQmIoMhJGsRTnVFYaULU
    /aq8icG6n9zvKBbKGHIjSuRokTNwxPN1LbhTjlYEd2VE3kiccZIzFxhQyuoDs8Fe2JU7OX
    0/Vwg68ivfpHzCFVLhGfI6t4VJmbkSh3Ywj/ooqF/ZrzsUCdxoIYgNSuVbgTvOjMZRNzLa
    j9JAUN2xMGBdVexCzrmBGkxc4CVF9EgpcSeOxlObemAhY1J5P2eo+6fVlb7BinNh/FrHhM
    JFPWYIG3rg7TK8Lp2MZUnDonWs/VYWMLDs1uOuruwN+YAvQY/kr9T0Qv24PYdRmarBy7g/
    3ATUEj5MsdERzncO4HwmHwxWyOVFgXTac2QOhjTkqVv/pOlo0RrEQTU9/k1Lje3Itye5Ff
    K/8U9URjb3xVKhx3LB0dSZNYAWPIX4dM4ZOGyPCKs5jTMv35p3Vaidwq8qHQ
X-ME-Proxy: <xmx:U3spatYs2JVUQuN_fDRAjSNMZmg7izE2gBlOFKRjtD2beb7bQYH4SA>
    <xmx:U3spatXYYdgLeKbNv0jBb0JdOeY9wVb-9gb10cY0GH2eiX8WZLx1sQ>
    <xmx:U3spah6cbEJlyD_LaF9bFGtgIbu1thx5_naaIZB-Wva2KW4kIB-Xmw>
    <xmx:U3spaogfvqcSM7dz8KozI4oidjsrX7rO66K-1dDZJv7VhLeVUGZt3A>
    <xmx:VHspalR7TpfXxKVBaFv1HMJlKvpkNtjakp-D6Odl-zvlC5JmQjVKXIT8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 10:57:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b1d4056 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 14:57:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/9] refs: stop using `chdir_notify_reparent()`
Date: Wed, 10 Jun 2026 16:57:06 +0200
Message-Id: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJ7KWoC/yWNQQqDMBBFryKz7kAUEdqrlC4myUSnhSRkUrGId
 29sl+/Bf38H5SKscOt2KLyKSooN+ksHbqE4M4pvDIMZJjOZK9oR80uxcFCkNYlHt3gpGFOV8Gk
 +U+FYkUam0LO3jiy0Wm4L2X5P98ef9W2f7OqZh+P4AtYgElCLAAAA
X-Change-ID: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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

Thanks!

Patrick

[1]: <aifAVpxanV31KUpC@pks.im>

---
Patrick Steinhardt (9):
      setup: inline `check_and_apply_repository_format()`
      setup: stop applying repository format twice
      setup: don't apply "GIT_REFERENCE_BACKEND" without a repository
      refs: unregister reference stores from "chdir_notify"
      chdir-notify: drop unused `chdir_notify_reparent()`
      repository: free main reference database
      refs: fix recursing `get_main_ref_store()` with "onbranch" config
      refs: drop local buffer in `refs_compute_filesystem_location()`
      refs: always use absolute paths for reference stores

 chdir-notify.c              | 26 ------------
 chdir-notify.h              |  6 +--
 refs.c                      | 35 ++++++++++++-----
 refs/files-backend.c        |  6 ---
 refs/packed-backend.c       |  4 +-
 refs/reftable-backend.c     |  3 --
 repository.c                |  5 +++
 setup.c                     | 96 ++++++++++++++++++---------------------------
 t/pack-refs-tests.sh        |  6 +--
 t/t0600-reffiles-backend.sh |  4 +-
 t/t1423-ref-backend.sh      |  9 +++--
 t/t5510-fetch.sh            |  2 +-
 12 files changed, 83 insertions(+), 119 deletions(-)


---
base-commit: 255322df35357168daefec8523a3cdc849edd6c1
change-id: 20260609-b4-pks-refs-avoid-chdir-notify-reparent-a4eaf1edbcab

