Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598B4A49AB
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157485; cv=none; b=ZWe1YyXRW97pOdetzHGgBs2MLV+XfoBNki/kurzgOgx+SUTXSeVcbfcyMan3eaFUbpXXFu97DSVLtUprxRgeE0WJqPOIKjOwGbsSfc/9YFIMVfgmxqhirlKF5wVLzWHdCQ7ewO2wmVQMoy+zxVbGFaD871eRu4EzCZoruJPu74Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157485; c=relaxed/simple;
	bh=4wFK5FmJOJhqgfCuDlJURvJwnL1C3Jh9ELtQRlHXPa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2dcQGmRdBRzJ/q1XiTM2/YSyBwDQDmpzqVePA76ULo2Hyj0DxGa7Xo5i/WYQfcMpM+RgF0oNbKXPtzakrBCjV5hlF7/xO4+yRIFcYvtI26EhbdBHhSCgQTr6kd0kYY8Gsw8DzT1mBjUwznlZJytjGcpyAeZ0SBSXMQ7L6SaYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hTxCZTzU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crhAhUSg; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hTxCZTzU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crhAhUSg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2BB4A7A015B
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 09:31:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 16 Oct 2026 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1792157482; x=
	1792243882; bh=BkRjzu+bos/I3PFGM9TLtQHtPT6OmO9LZt+9Xo2Yq6w=; b=h
	TxCZTzUlu7on0cdzZIkMiBRFCkj4dsg9DQd3nSepF/VdnE2kvA/QpNuirZTgsKD+
	E5F9x3lVyALbbYBV/lFC+h9JCF+TVZjABnKR1BG4buSNXEp9SXvmmWBOA0Rp6/YE
	rH4xGUwunkWqSV4AzHxarbUEDjo0LFiySIizHgHbeESxNQmuehWELiQbWbc2ezxj
	Ncz094FVdEdkedJpqiT5dvRDbYKdkOAS1ayk/NDQracuJ/ttelWmfx4oPJEjy8li
	UIsR4DSc7sieqX8kGHiCEbt92+fpl7xVgfzFb+TmVC4NOl9BrDrvDbwfOqve0yF/
	jwwVHf6iKXrLfdzoNB12w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792157482; x=1792243882; bh=B
	kRjzu+bos/I3PFGM9TLtQHtPT6OmO9LZt+9Xo2Yq6w=; b=crhAhUSgLxBwv7tma
	rJZEa4h8oDrnQDr4d+2EpMMX4tKxSnb+oGOIlKaWhpkQxDC66RQF2V5KD7BlvNvH
	4w/ISMsXHcP2PhQi6iEqhsEJzJZnqOrbjOl2aAaNwFBKKYLxiHlVwLbTrbYDFxTm
	R7Ofp3k8A3fun4eW1Vws1DPyMyiaBZ2+op2rdY8HXGsn7es0M35EixpzlWgq839H
	ZadjA6LoSzx+KdG+47W9TYh9pJ5EklKAugAD5N4XqJX0ql/x8UmaF8PpoDh2HDZn
	qRcTGGie3TnALNmsGD287fHSHp+hj7atso4A96F7401UiX24s9+n5JbBV2lhWbb+
	xMgVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792157482; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Wq2jhCA8j3UvpgrA94P4fBPyTj0Q0IkBATNYAKVvV7MsrSo
	dGy9+hbj/aPiK5OMGlQhBzQW6OblTYjEOrWvw4seauQyVrfHzxz0RiwfF0PiQQwL
	oJ2nsQRIQUA2MpxdfQ/azMrNKMGMPEKYVU1W+XNGyG3m1wTkc5gUIhy/2pJVSgyg
	Hm0B++UmHnPLsqdil/+/LnAsXIjSu5qFna1NMXKRdq3VOKAd/PkYRwkB0CR+7cGH
	sWHilmjdqrP4/bgpeLtj5GWKYcimTbPJoqErKD+2Cdw0Pz5n7mjxJWEjDIu4Rm1c
	NW6AH0GvcVCPcBbL3PCPvk0p1ocX8k40+lYjpjw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reviewed-by,
	subject,to;
Message-Instance: m=1; h=sha256:Hho0Pp/jeEZwBz+UdMfE3NA6MM+uJt+znlSUtp7Ie1Y=:4wFK5FmJOJhqgfCuDlJURvJwnL1C3Jh9ELtQRlHXPa8=;
X-ME-Sender: <xms:KifSaoUeTSlj7Pj0mtHHgZJH_i6TWhnoKA6qlpqWqEs8N-fnyaOPTQ>
    <xme:KifSajdjCnN_tkBx_O_SHHkcSAAeyIeMgBPDJdQnKIKkHnlMEzX9rh5EraUH7nXD2
    5RZS8n-JqG5cmaPrxo7BcsnCEKTfzm-v_GBq3fO4CP9fozmYf_amlM>
X-ME-Received: <xmr:KifSaks7Vhy4KADqA78Bmk_FchRYEKHdMIPWH80haBMuTZ4liuT7_sRCkj8IH5oUTCUuovNbOoMsMgDpheIfIxmFv0JYV_E9aQs-3hUbgpsP_g>
X-ME-Proxy-Cause: dmFkZTF6m93v0iAVst1k9RCWZWM9b8ltsvtmKqnmjEqGaV74Kbbtltsw6gjIbSkGHD3afy
    WOgwCntXpyj/8sf6mLAjAWxe13DROOWLOQh8kHMRMUpoTOYcW3HFtAs8FYY0nPWXfYqDiY
    8SlxjAdMj7tCFkxQ7njCg3xOl2mbJVI7mr7shVJa+IgLyqoGNOiyFM+sS3C7lxWBvQ+ITI
    v0pFbbCCgY0i5LZQfuczOldwvLgBSMZkUjA08rRWyRMp7mwARi1+zaMde+hOb3lAulK1zv
    1VuAXL8VxGERvxt5a7LnE1KyeiRLm39nEvspmZI+QslZ0fobtdpIFkB+t8csDW2usf8efC
    xA/r1fPFBMsHe2chVNXrbq3J+B59qDich9sPMfFQ4vmN95TIbDrvQndtRcEvNIpVKeB+2a
    z2E2l6bZ59WwUDtSWCHVvLlTaspDjMLbV39YQWOHvOTGRbVTHZYyuGf1+hxytDJmPlZFZR
    1bMTFH/etGWy1+pZm4NRtsaFPMr5szzlSEp4ALvEW/Wki2w9SvlZc6EIT94vvT0eCZPHU7
    ChaTHnC5CQRgR8N0ps7YvifZWvvZACobhIYLxnpRhv5lw/4CjByXi9EGr9LTkWPDHCMZB1
    FgjvkhGO5bxwUKLeK2yngDFBUhLMrHBIx6mMu2ZMCzZ+/ep17QXsujhx+rEw
X-ME-Proxy: <xmx:KifSai_LwcIZhTFt7kq8AtqHdih-cFP7pDSGgPPdikq5Vjb9Q06fJQ>
    <xmx:KifSav15eU988uMzuJCQiQf6E5WsajjDkJ5lCQhdhkKnMQQdMWEUfQ>
    <xmx:KifSanCYitlyKhhftEZheWHyU-0brsSvXiUwlcSJUUUUnYikbezG7w>
    <xmx:KifSarfPcCLwhbNcwo7cpM2XJuR17yDBa5Y4s7NMOkBVTNEF1jx92g>
    <xmx:KifSaiNeTQ_YylIP98hPPAXVxHmcA6idPvMkevlVi0jA_CrgggOu_DMv>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 09:31:22 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v7 0/1] repo: add revision filtering options to "repo structure"
Date: Fri, 16 Oct 2026 09:31:17 -0400
Message-ID: <20261016133118.3659793-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015144559.3652143-3-markchucarroll@fastmail.com>
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reviewed-by: ps@pks.im
Content-Transfer-Encoding: 8bit

"git repo structure" provides a collection of useful information
about the information stored in a repo. In particular, it's
valuable for diagnosing performance issues caused by large objects
stored in a repo.

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to get
information about the specific part of the repo that's exhibiting
a problem.

Add the option to specify a set of revs. If revs are included,
then the set of objects processed will be limited based on the
rev specification; otherwise, all objects will be processed.

Differences from v6:
- Fix word duplication in commit message.


Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc |  31 +++++-
 builtin/repo.c              |  32 ++++--
 t/t1901-repo-structure.sh   | 197 ++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+), 13 deletions(-)

-- 
2.53.0

