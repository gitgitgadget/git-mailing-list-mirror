Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC7F4FD7B2
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675814; cv=none; b=kZkuU3GjhxvAC7tYSExZ9CunomPOL9r1Ung+SMqn7aUn3cVE1FHgDHZO249R7ChhPDELPFCJcxT+TZ+XmGuPmXxBhWfEN8G3Rm6Cq/YL5RkFjp7hNlipIE1l1AH4vQS7MVAREzIkDKfRQOQIgbUMjK/M3M7K1LGt4fxYDxPMbtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675814; c=relaxed/simple;
	bh=ND8+0uMFQ7H96haMtnUcNkiP2F3T9yZVQwFvPp4XRPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=scBJEpGZNpA+p20Ka2Zq5uTRMZx12PgIPv8QpHvfKdFq9frB1lolK497dJuSAhDtO4BVbNc30v/LHbj7Dbxt2T1wtikCAGVQH3uqR0pBD+pcokZ/RCp0lNtDGqb98rzRY9XxDTTOCN/aB2e0zRwyuECeBCsE8IkZnrpw7pxu75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ia9nIduR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3Ww94z0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ia9nIduR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3Ww94z0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 31B037A009B;
	Tue, 29 Sep 2026 05:56:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 05:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1790675811; x=1790762211; bh=luYq1vV/IH
	/Oo/XrgpryioOLy7nCM6qkoN+7oBBgZ+0=; b=ia9nIduRC1J/d/DC6MJr+MxvM/
	/VGQjpNpSwetzZNInJZ36N0QrW0yth5enEc72CdD0vY/uaqLWTTN5CaC79MoeABB
	KaBV/TrSa3QaXyKpwzdOricnt6rRQaFUcKFFP/0EnXmLWOd/xXy1++/qhRcv1A6m
	NyxTqQxY6TnpV2p8au9DDpE/Ij6srIh3PsS7vvREqUEelJXZBH90E+ZlKou1g8Cv
	AD8m718nhvEixZf8nuO2BVy/MN/5z16T6J4hmn5/injw94dlCeQkxnD0bhWxZ7w8
	lk/k/XndVX+arOPzViYAb4zF5JAcZhpl/FnwzthpNnW8ixI3Q8F0m1qxQHBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790675811; x=1790762211; bh=luYq1vV/IH/Oo/XrgpryioOLy7nC
	M6qkoN+7oBBgZ+0=; b=b3Ww94z0RG3uH2waQ64S72IMCJ0eug7V3vhFNHXnlBDt
	dWGokjYWrw98BX47zHu5/TsoZhxobk7T0n5ofF2YIwq6r3q2ef2bg4x5FFx2eoE3
	qAJhKhPSRBiR7/WyoTKbssJUNn58LhPRB1iEnzANt+NWTZoVzNlNHsAiXjXXsADL
	MqsWKhnFbgwKiQ3lO+kBDhrmb8GpJ2ZkqZpqDgoKxZ8zmRadtlWBFnWRvAg1i/2b
	IpTzmeA1BJ//TjELDL1YL4SezPFsYlMVKr+nshYUHqyo84gBc5RtmTO6xJNJPjIU
	bRIZ/SMnkANSdPhUgdWooBaf4cOW05wdf2NRtS86ow==
X-ME-Sender: <xms:You7as92ycd0TY8UegMaKSofrHYfrBmFmgqWIIbQw4frE8taHf7kgw>
    <xme:You7ascTJAP9NcniixEnOx6MmH5ePxJrL7PWdeAOmzOiBQNZmMbFHZLN-JjXza1Vk
    idUrU4LGfZP_Uu9Y4HpEI_Pyq4NEyFlpmQTRe_zsyAgJFCx-tVAXw>
X-ME-Received: <xmr:You7alGx9vd_cNYcJNM8V4XHVmN87lML0IBTGtUBffD3QnvV5G7RhQ>
X-ME-Proxy-Cause: dmFkZTGMGOPkMvWl111hKcTRKJKp2yXQhrREVlEXfkjDvgvEh6MoVY6oSd2rPZ50DpVvLu
    QzC4M0GpKDsqDR0pUsd8BpI+no10pufzaro3t2ebzJigByEoGuGkG0GGOIM7DLgqTY+iFy
    8hdvYQ78x/ojP2VW+JX7WtiInioHhjgD95HroXNdCrExoJSFiJmuWbaQsNd1FFKraloIU9
    vzTL1gzmde6A72B3Ber2BFYqHeJPgZU2UoLJSJEs1CvaVPKg2PLzS7V7NVjT0Je4hHMjhb
    YfYQGXIKQeSLmY2Oo/0YiVDqr17xBwkKgUF+Ag4jwp/T1Hk7232gLXqOBxlYPyUEl5hkQ3
    UhYyTE4dcp5qIbzRkJwjCkat/oR1e2S5glKUDRZRUbFRIDS21hXJ77B7+XfdJQley0a3mI
    r9abDtf7l9oQMxgaglb2QcDcIqXEwvTKfjFSRFxnWEDvacIzmvZATIeJpwrr12x/ws5jBG
    729+iUQYboe48s6dYVK4n56WNq/S/dDHaPx7mGXy2six7VVj1EYcArZk94NqJqK1uK04v6
    xAFMlur+YvcG8+PNHFcLnsTSNmXCHoWEbGsTme2PS9j7WNwLBv3RfMoJfGI01smSNHoIOe
    C8l0Vp6x6Rx1zJ2hE7HXnXqHneRuJLFczVNPidLUxXoePFzNCzD2wi7O49+A
X-ME-Proxy: <xmx:You7aqfGlfZOd-OG2ZK5YgiVBnweBeFHsJZtHc-UHqzRnspTKe86Xg>
    <xmx:You7avGoBvBCSRkWu9XyIX9TWiL91aKsa6Qm2xgGlwfvo0g8teW2Qw>
    <xmx:You7ajU1-U2mZXjz3YN8vQ0xMpQ9iaG7AdqyL5tLhKe9O18EWGBVnA>
    <xmx:You7amJTr4mRO-ekt_4exKKafW3nXeyREuU2yFPpOu5LmyasKgJAcA>
    <xmx:Y4u7apB91VZH3aEOPSEuY-32g7PZWjh4BOJmyhfdIrK9qEfkoBLPq7gS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 05:56:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 091e00c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 29 Sep 2026 09:56:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] refs/reftable: fix on-disk representation of reflog
 timezones
Date: Tue, 29 Sep 2026 11:56:28 +0200
Message-Id: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTuQRKjEq4iLNJnoqE1KJpXS0
 rsbdfnB438bCBUmgXO3QaE3C+fUoA8d+LtLN0IOzWCU6ZU1FqenYKFY3fAiwcgLVh5pzYkw5jK
 6ivZIPig6OR00tM7U5rz8Pi7Xv2UeHuTrNwz7/gGrq4XZhQAAAA==
X-Change-ID: 20260929-pks-reftables-fix-timezone-format-93ecd0e7a1d1
To: git@vger.kernel.org
Cc: Josh McKinney <git-bugs@lists.joshka.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

it was reported [1] that the way we store reflog timezones with the
reftable format has a mismatch with the reftable specification. While
the spec says that reftables should be stored as a signed offset in
minutes, we store them in the "[+-]HHMM" format that we typically use in
commit headers, for example.

This patch series fixes this bug by making our on-disk representation
match the specification. This will of course make us reinterpret old
reftables. But ultimately, the fallout caused by this change is somewhat
limited as we only ever use reflog timezones for display purposes. So
yes, we'll display a wrong timezone. But it's not used as part of any
kind of computations.

The series is built on top of v2.56.0.

Thanks!

Patrick

[1]: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>

---
Patrick Steinhardt (3):
      date: add helpers to convert between "+HHMM" timezones and minutes
      t/helper: fix segfault in "dump-reftable -t"
      refs/reftable: fix on-disk representation of reflog timezones

 apply.c                    |  3 ++-
 date.c                     | 25 +++++++++++++++++--------
 date.h                     |  9 +++++++++
 refs/reftable-backend.c    |  7 ++++---
 strbuf.c                   |  3 +--
 t/helper/test-reftable.c   | 13 +++++++++++--
 t/t0610-reftable-basics.sh | 35 +++++++++++++++++++++++++++++++++++
 7 files changed, 79 insertions(+), 16 deletions(-)


---
base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
change-id: 20260929-pks-reftables-fix-timezone-format-93ecd0e7a1d1

