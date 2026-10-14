Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28AE2F7EF4
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968041; cv=none; b=hmv1sExInZeRj6PT2lbJCEu3IWVaim+K/hKJqRzjs0SbvufPpHstku+ZpPQepir3F9mEZN5NuTDwXbZ6QOvX9pfOiiON9yKLLBqyFm6WQjemehnuC/gbB5t5teYcRc156x64bbMbaeRQjqQV7mtbh9FZGMjmujmWBDq9f3cBK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968041; c=relaxed/simple;
	bh=HNOEZdSmYg0p2ipsGlI/HubYtM78MeWirjPyE4nUxtA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=MLkViFQXQjiL2pJsf1LncLayg+EmSeMhXuPqfbJPUIXtCkiMVne1ixOAidcsJLqGd3d8qaUffRLp9BtnTQEilq3YvioifRgCbihCB7H0xiOvB8O5842ZN/TdOhHRBZevwSQyVrbSz/BR2gqgMZcBmp3Q2TQ4x8c+sBVwmvTLBIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FB52U5i3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vtmiDv+o; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FB52U5i3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vtmiDv+o"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BF5A1400101
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:53:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 04:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968039;
	 x=1792054439; bh=z4E0FygAevGku0ctPndEAh17+MEEO6WFmVdIqlNxtT4=; b=
	FB52U5i3XpHnokUmZiDHFyZYMpJdWFj4YmvjwYIkcB3xaESe4uyeIwJsVAvskNZh
	Zdv2iR3UKUPBl1LmbVptUsepcQyhvmzrg76nrcMoNJorWT/26tI0N+jbHxnUM1Nx
	G2hVN0thkrMF1XwfVYpzx3oLZhPWT2mtuhmWPI+5HCjUNToRETcujkXf2g59fUJ4
	vhsqemlMUDUSPsooeNCkez5QsO5tf4xdvkwO4+bH84iv9zM6mFxePq2nmH2yC4P0
	VDOpAmFS/VAOjYT1BAvC0H6s4zMgpeDxoQx6kfsxYyn94dZBvWk2z64RemMgTJh7
	F7CdAbsKIJXKsVMrl+YmXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968039; x=
	1792054439; bh=z4E0FygAevGku0ctPndEAh17+MEEO6WFmVdIqlNxtT4=; b=v
	tmiDv+oeStTJccqNdptP2xqRDi1hsizadzXm4JTzRvcH2m6nLKkHQpXeiFgwt2b6
	fkdRuCUuPQm0iZZKoLDmeJgX9o1hWfJ+ppfQNmWjvN73Nm98eTaPOFa3KSnhP+ns
	ZDQh/CbaKvHqlLZnqZmtU1/X0Fvdw1bYvBnlY4BXuJ2GTnmFQcQ3DVPSFX3xRkVu
	fIQHuU0rsEew9onOUS9ML4ImnF7NdPnjjCrv3eMW2CHmO+5Hb49CihIbppdfHGdJ
	kyeq944PO69rFVZ9au9ICVLbZ/Mcf897yFau3ZPOpppmzXgkytzME5bM257ucH/W
	QEj+LMFKLnzzeh2J5rT6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968039; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nG8PSeVSkvMfhFDHzTkjRzXpqm2gT8mWzcGwX2hgo3uX78M
	saCPX6KJtacoW1Ll8j6v08wPi5POXDjVJzidI++4BKBymUH8SXi9DicTlnM7Nu6J
	GTynCE4DlRzh7flL7ZdH8m8bZcf0H8F82G+eddP82/2k5K/EVt9ypA+az0pBA3+g
	Xfxq2tmEe9wM8lTQRje/PWZtu3JDcEr49rzB+mztno74FJo/rJcxG8KAgeHGTcRF
	gv1Xb/kY1KEJ/iHl6APLwNpk6ruzUaN4MOXfneqbu4K9N9f5Lk2xCF6IA8/LKgJF
	NQ9vI1gNFO9reKA3bq1cC545X+epUGBWQXuI6nQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uRzMQ3ip6t5N+MSw6SoQXQNEaJXmRXBGFGvSrGcfu0Q=:HNOEZdSmYg0p2ipsGlI/HubYtM78MeWirjPyE4nUxtA=;
X-ME-Sender: <xms:JkPPagbMv1TMGHrtzoHyGao48VEs8hF4JATpEErJ56F3bakewMN4og>
    <xme:JkPPaiYDrhNP3lwwpGl11lYYYPmb6zg7XbDb7sM078lApXT6mDxAJ_uykTt0atZk7
    FIrF5WHMNNYFXLLIFvH5AjxVdQuq8Mn6DXjXspeuNmnv8TRlOrOlw>
X-ME-Received: <xmr:JkPPav-I3QDIUBahmpK5mHna8nn5id9ZzyD4rQatvwSyYa_2b53DYg>
X-ME-Proxy-Cause: dmFkZTENRB+GSLQmB9zhIG7qZ2i3pKaOpkm6GR/B+mY2gd2cXkt3WFD+Ha/cj9Fer1CK7A
    iMkm+2MN7mSB4fgLERLaCLZ2WcesLHcAVPmapYoot9rD8aS/TUxAliyBzQys2+RLIXEuYj
    NQ4ifpfZvyAfpI/JSkIBf/y5c0W78LYO2ON3RMEQP54H9UKefGyQSQ9gG8g90ld2PZAGFu
    4EZpG9lfer7w09FemOElkquZp3eytj1qN2EjYqQLpqiqPX7uDQ3g+tmHjSsAnXP4B8sKx1
    bshwaRO+l2E2wdQDo4iZxqu8+4gwyhTO6Sg639NccfH7bxQ5aaO/vJ9vKiUamDt5D188f7
    KwxbfSx/pAtpM/u+4y9mc/MVWm9oG266NdR2t4ERhqcNrd2SpfWvfdIIOgj6nyaYYs1Iyv
    /0Ue4seGcCvmJzoOiwVvGvy8RpXEoWY6n1Zuz7zSpLDngFxrWZ4hWIgUEaBIB8TWWfUsuo
    9KMMSLESvnwWCtt0/NUcyYMz/tOH/QyxJ9+l3w/UGzNZf7bgwl/BjfYNBJ/by6zSEqwZfy
    9X5ET5mJ9OCymxTj289RIbE96ovXWnpqFqnlL9huGhRGz0tWDXjogAbVMtIXta1vG820oc
    Z3Vg0IjiO2DU0YzT+k6bRtI+eJ3pO/52hvVXuQPUi77MRW1oEuBE5zpwveOg
X-ME-Proxy: <xmx:JkPPaph8nK0mFT-dj3rqWEd4iVknCM2H2ef_mRbIcsx_CXx9oiBzmQ>
    <xmx:JkPPanfS8tzu4Z6lQ12bndyHaSBtlSjTSr_AwtzzHKdSks47N5d0sQ>
    <xmx:JkPPaorUxMI7gQrNHECMUFh5QWwtH63KKDqQGU8t_50ujV37HSBZtQ>
    <xmx:JkPPakCO5efMc_jNlf_TyPXuC1DKWcZnBSZnFfgBEkeE0XGOEpPAMQ>
    <xmx:J0PPaj0qNs77yVxlXtjdYkpGoTTEL7LZwIj5FGPzwZqRaamyrUmwl7jq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:53:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6cd36376 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:53:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] odb/files: cleanups and improvements for alternates
Date: Wed, 14 Oct 2026 10:53:44 +0200
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBCFr0K6tqYtpP6svIdh0ZapjGIhnUI0h
 Ltb0AO4my95730zM4KIQOxczCzChIR9yKB2BXOtCTfg2GRmSigthdB8eBDvG8s9dkDcdAliMCm
 frgMTxoG4lF4ftXPVqVIs7wwRPL42x7X+Mo32Di6tw2uiRUp9fG9PTHLN/Xyy/MM3SS64PYhSe
 K+s0v6SO3t8snpZlg8lKWEz4QAAAA==
X-Change-ID: 20261006-pks-odb-files-alternates-cleanups-11f686cc4942
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series contains a couple of follow-up cleanups and
improvements that are now possible after having migrated alternates into
the "files" backend.

The series is built on top of 6de20f6092 (The 4th batch, 2026-10-06)
with ps/odb-files-alternates at 0ba59c8453 (odb/source: drop
`read_alternates` callback, 2026-10-08) merged into it.

Changes in v2:
  - Add another refactoring on top to only fetch objects from a promisor
    remote in case they are missing.
  - Link to v1: https://patch.msgid.link/20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      odb/source-files: fix performance when reading objects with alternates
      odb/source-files: fix performance when streaming objects with alternates
      odb/source-files: make the second read an implementation detail
      odb: remove read loop for found objects
      odb: don't try re-fetching corrupt objects
      odb/source: drop `local` flag

 midx.c                |  2 +-
 odb.c                 | 63 +++++++++++++++------------------------------------
 odb.h                 | 12 ----------
 odb/source-files.c    | 26 +++++++++++++++++----
 odb/source-inmemory.c | 10 +++++---
 odb/source-loose.c    | 17 ++------------
 odb/source-loose.h    |  3 +--
 odb/source-packed.c   | 20 +++++-----------
 odb/source-packed.h   |  7 ++++++
 odb/source.c          |  4 +---
 odb/source.h          | 20 +---------------
 repack.c              |  2 +-
 12 files changed, 66 insertions(+), 120 deletions(-)

Range-diff versus v1:

1:  c576112f90 = 1:  bd071672be odb/source-files: fix performance when reading objects with alternates
2:  f4065cfc43 = 2:  3092e588e9 odb/source-files: fix performance when streaming objects with alternates
3:  7d10934490 = 3:  2a347fcc0c odb/source-files: make the second read an implementation detail
4:  e4b41bd118 = 4:  b5080890d7 odb: remove read loop for found objects
-:  ---------- > 5:  fd362349fa odb: don't try re-fetching corrupt objects
5:  bafbc979e9 = 6:  8384fcc65b odb/source: drop `local` flag

---
base-commit: ea99757de7d4ef6c7727431bfd7b6726614102e0
change-id: 20261006-pks-odb-files-alternates-cleanups-11f686cc4942

