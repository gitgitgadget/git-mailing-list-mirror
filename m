Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139041D627
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828345; cv=none; b=lMtOZFVaftCclVGv71KSwrh5F++6PwZnk8FrzxFP1trSmaDTPNlIw7QF9K53YOr6uvwOubbXSRvpoV85CC+OOYXEUMJQsQVR6G+P9xYm6qpBjs1LUAfbMTARy+4uxMl2w0vIp5Vp0INiN6vIzx3a+kIwX7AzGEGFi+ZcC8+69jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828345; c=relaxed/simple;
	bh=fDfIjwQ+Oe8vpp1zCtbewE1rO1DkDeOhw7hMycoA9jI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p1dNMszEVvNsJ3XGdMXddy6+bzbhmVpjALRNauI6UIAkSH5oh8PIyHo7XfPFY6edOuWh8KsdRWx+w3YvHhRIIW1pCCPC1QUpFjZMSoWsp8GtVDAEWWsYA+WQ30p4YkR0/ewYtJmi0PPwM/2B3KIx8aHzDUzwqFZ3993yDHML5Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jN0SLqdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVF3GBKg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jN0SLqdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVF3GBKg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92B2E7A0148
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 03:25:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 03:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1785828343; x=1785914743; bh=n/X/rKD2wj
	sle7mkpQku7rXKKfbCEIUcRVzk1BbR7wE=; b=jN0SLqdIODG96S8H1rleAW7wmm
	ZxjrKg7UnC18RD+vuwg2TPbOYc73GPnNv7j1iA7Q/R9QmLvAC7KYr9dlM50U0F1O
	uN57gKx9xjdaxLSa8TbYDLaA3DaRqZ5WJ+PGJx9s5EVNFLlktYmVNdO1bsaQfpA/
	yU+qHTQYM1KurBHg4zZFKqbQSBSZwERSeSCvOXHScqw0GGKvPWNTSlQZe4fffy1r
	2DgZkEepuk7bhbEhLWvBjkyxoWfUOPEQMxFmRZLunLnl8J1ttcLBTLO4aX9P6Ub4
	5MCtxK/H2Qvfumh+LygcUgbFJh+S+VEzgA9OT23dMC3ljH3zWxsjmajGs7qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1785828343; x=1785914743; bh=n/X/rKD2wjsle7mkpQku7rXKKfbC
	EIUcRVzk1BbR7wE=; b=gVF3GBKgMSvNL1DipMDo+ah8KJaW09W9JGlkVgFAgaMY
	rsMoA0lxY8WsmHqOZFQCUSMW9mVmQsc9DGyo/1ruD7WDXQvkXlZ0W9tm69pctGTP
	8M8qjk1H6FcI+bK4R6sVLTu4OBxYyN/7CngHV+sijHZadDkNaaZ8+4N8o2FYuwDR
	Mb/QERbggWYifkMGrpw7RHiQMLBwNzGZj6UcpFdkTu4xqMAbcDnJVU0EsmnjKSex
	1Z5hKcfc6h0c2JHVL1eK2Le/fvuUiluIgSzEzkiUxNI8AZJ0d+nABsXUiOfM4pzu
	R7HlA7cgc2Zhfm5ko8Ihkls89M2g5xqllk4jSshuug==
X-ME-Sender: <xms:95NxaoxCg5ZAG9YzBiyLIRRi6g-oTquoSsMwHT-VDqf98V2hrhC6VA>
    <xme:95NxajMyXWtnwPIZSo7hD8KvtDcz0bGwt8abV6pmpGDPI-IfJo3TPPu5cHEH-y0JR
    uwZgjWbBPW99WpZl7kDMdOtkvqsIx33O3e81dlksoM94eq1XC7SDQ>
X-ME-Received: <xmr:95Nxav-c7m7r5wVKqd86logXDg97uGAVHOP1v_Z1nul9IqhXGO0jGNyan4uJ8HBGgp3DdLUhETyrnIVFvKYWtPu0XRdjO9Z4oMf6qW1b>
X-ME-Proxy-Cause: dmFkZTEu6h61h/4de27kvZgkop/V4OEcaCaEmwJyBl8rNlpPjDWCaqLrqQYJngDxeU0iVh
    BF1dSixKKxJYuTJy7Y/oUVmLKiED+qysyjFmPWVCYJfEQ3KKban8sj1mWpaQzV6gUhosEa
    BhFK8AULTnEfEvhfFrNoCdb2mv0F6SKoFHS9pcXUH6Bumde4t15gbwbLxWCA/ZgnB4VHEP
    3Ofpu8IrMcilsnY74xgdMnamEH3ph4rYWvHJnKBnmwmJr+mYR9qbv9jyjgOFkT8FY5ojtU
    93k+tiGrSjwCmFYwQoYj8GPOv9oolRk3vSyJBwHeYRLrrb1LR/dWhUn3y1Gfn4D5rxKWn1
    KjCQ6NidSmdwIhzZLVoMkYGYtpAX5VE9SRsYPSq7x1nAJitsLxFYhM2ZT+In8hgB+EvQKj
    9WOe2gWDdEdziCBRdBJ3RpJUCFMG1LK5IjbOVealQRRPRBMSYKOln1xrWawwxyZEy3jhq5
    kSG4zF/CcUAqcBXRzcMoKDfQWyqgjIwmsrHm5Ha2QSaO2UDP447mI3zTDRbaBkOQGnhr7A
    KGK7YdlSVrr39H2nJVnZ4tvnhcAsNt9Zw/ka18V2XvaVt/DKpmmWcN79vuQOmBIcpDXWT/
    sP7aqKruwA5hVd7HhHQOjRI6NEfNVOhStM0vYj4XcTiFf4ZEubmIOjPCWL8w
X-ME-Proxy: <xmx:95NxarpzL-IzbEP5K5AzWQhx-c1WFbuBNpyRIxxmM3nd_ofNRJOKmQ>
    <xmx:95Nxap5XyoxCCAHQJ24v_tSjMyK31g_8f0NrysZjSJjViSECotdq3w>
    <xmx:95NxajMvMkjc6UXRtB1NCvL4ukqjERLGyDKqxo8hLxVuowRSumKyWQ>
    <xmx:95NxajP0yJ-FIV1EK6dxli9MvfSIXx5OG4tcLTDcmmf-tpeKDT97fw>
    <xmx:95NxaqwlMF8gJHL_j6W_CbAyhTU11WC-kv6ADrK0rgYJD23Sn9TUUgsA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 4 Aug 2026 03:25:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 83f65a6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 4 Aug 2026 07:25:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/7] odb: unify read and write streams
Date: Tue, 04 Aug 2026 09:25:28 +0200
Message-Id: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB2wUWvwKuIiJmM7ilEyUQri3
 Zva5Vv8f4JQYBJosxMCHSy8+oRHnoF9G/8iZJcMqlDPolEVbrPg6gaUGMgsuHse2ZqYMizLyll
 lmlprDWmwBRr5c8+7/m/Zh4ls/B3hur5zcxH0fgAAAA==
X-Change-ID: 20260724-pks-odb-stream-unification-334dc2a75888
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

we have two different kind of object database streams in our code base:
`odb_write_stream` and `odb_read_stream`. While those are used for
different use cases, the provided functionality is ultimately the exact
same.

This patch series thus refactors these streams so that we have a single
`odb_stream`, only. This allows us to reuse the streams for different
kinds of purposes and makes them more generally useful overall. For
example, it's trivially possible now to create an object stream for any
given object and then write that stream into a different source.

The series is built on top of 5b2471720c (The 10th batch, 2026-08-03).

Thanks!

Patrick

---
Patrick Steinhardt (7):
      odb/streaming: track write stream size in the structure
      odb/streaming: drop `is_finished` field
      odb/streaming: support streaming arbitrary object types
      odb/streaming: rename `struct odb_read_stream`
      odb/streaming: consolidate read and write streams
      odb/streaming: rename `struct read_object_fd_data`
      odb/streaming: unify function names to create new streams

 archive-tar.c                 |   8 ++--
 archive-zip.c                 |  12 ++---
 builtin/index-pack.c          |   8 ++--
 builtin/pack-objects.c        |  18 ++++----
 builtin/unpack-objects.c      |  42 +++++++++--------
 object-file.c                 |  76 +++++++++++++++---------------
 object-file.h                 |   2 +-
 object.c                      |   6 +--
 odb.c                         |   4 +-
 odb.h                         |   4 +-
 odb/source-files.c            |   7 ++-
 odb/source-inmemory.c         |  32 +++++++------
 odb/source-loose.c            |  33 ++++++++------
 odb/source-packed.c           |   5 +-
 odb/source.h                  |  13 +++---
 odb/streaming.c               | 104 ++++++++++++++++++++----------------------
 odb/streaming.h               |  69 ++++++++++------------------
 odb/transaction.c             |   6 +--
 odb/transaction.h             |   6 +--
 pack-check.c                  |   4 +-
 packfile.c                    |   8 ++--
 packfile.h                    |   4 +-
 t/unit-tests/u-odb-inmemory.c |  37 ++++++++-------
 23 files changed, 247 insertions(+), 261 deletions(-)


---
base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
change-id: 20260724-pks-odb-stream-unification-334dc2a75888

