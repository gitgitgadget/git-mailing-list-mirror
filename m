Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733538838A
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300567; cv=none; b=HnL7czL4DXgaqrilFiaGm6FCEclnJDCZCF5xfMkm1uECXFMC73+W/ssiUHjYBLybvlxbhSFW22/ZL+I1IJUw3yL4cwP7ng97xc2Ky0elTfQzDzp3caEKRn9xaNIx3HyDhLvkO40yFkUxHuvou4faEIXjjQtSBKTIEuQQHm5sndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300567; c=relaxed/simple;
	bh=WNRtes65jhA8FWY4CeWwHFo6duOSMy0W6Ym7QLKTOgU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SEZLmnd3SyMofN8b5Kbvrhel6nuUJeNeGJwIIzcF7MRHaUWsJmOvLpeP9JyH+t1bYCV5GyJH8t2SWsqnrskAn47FirJgQDoHsUO/ajfpRCWvgGQkvznn/GddxvK+RrYmxNfbvjZFLkr03W3NTao+jFOzBM1U3W720yINC+ObFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tKFRkkSu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuF5tCxR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tKFRkkSu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuF5tCxR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 210B514000CF
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 03:56:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 03:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1780300565; x=1780386965; bh=XEN6hJsl5T
	XyvSlpgAY1T2Y/Cw5ORZV+yPYS0H2XcdY=; b=tKFRkkSuTY0WfwQsouxDPsYM4N
	9CCnsBEWE8hBPzfi/UkvSV75A/p7BmFFEUx3Sm128SIIKnmM3W80TxzfRMp+6YiF
	HJ2Gw9IYMrvwTmivXX7YW3EQBNd56GR86RxMtfSc4utjg9AFccT3Iysy7Mloy4gQ
	98p7YI7TCfn6n1uILBOhzZL6BUcuB1UahB0PAVGupoYC9J5qp5c6mobTi11bKAL7
	YgMfTJJhE/bDvG+4pYyoNUhq529ARbHFQjFk8Ng9M/twuon168ecXytRzF/Gj9js
	ZSyHj9xv3kRLXXs4R7i8/UCkGh79A5CKrQyQYtWLwJB9bb1PVTWoQnsPHSEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780300565; x=1780386965; bh=XEN6hJsl5TXyvSlpgAY1T2Y/Cw5O
	RZV+yPYS0H2XcdY=; b=IuF5tCxRkO77D2AiBoIMZFqJ82nG5SWtxxXsrEmsd/V2
	tW8GUjI3eQU+/DfF79TnZpsLky79GT/2yzS9qPOGegaTUdQmejFAQntxQMCIS+83
	YrQTHiC2cxKvmsRCjla3RUIFxVaziz0Hf7EkPN1Wa1DJpZiSQncQfUMYFTJSqVMg
	dFcoqTZGl6UhiUCADAnmn9iqtJn9QeFAfYeXHvVuIyF1aPbeE3aePROg8KSlcsKt
	A03H1+2G0KgLvhiW7uISDFXQtsdOfz6EaiOkOU7u+R6DAYcA4HhSZ4QEyhfFTK+/
	RlvYSIul3aGWfwrzJBLGY1St5FV8FNgdz1+NEZdhxg==
X-ME-Sender: <xms:FTsdatUUiyy5HTOL-CV127jqcF-G6MMp4h_HuDbZZau-p91HbS4JUA>
    <xme:FTsdakhR63wseaEZSb1ZfxuHtM5Eq8TuL7Rs2eB4D-zcPkzEphKfia-aUw0XLsR-c
    uLD9wJHQQZUhmjXWW4D68wpXj_uzWgCWRFIztPlqC4OQonBDZXZig>
X-ME-Received: <xmr:FTsdavC2unVQNp9ECZkT8bkoc_T2oTXeS3SwUbrXynMA8iu0PWbr-ukgmB4u6T50XHOhM-gN3UEctv2Etf3rBGczykc00FYSgLSabuYxm1zT>
X-ME-Proxy-Cause: dmFkZTE5ljiuiek7x1YteN42RnVk+bpStIfYV9LngajjWAMtm8sNZU3BVrSsCGWNMCk5hA
    Vet8KZJ6tUFjogEJiI3Vx9a39Kp663eXLtCjB6TwZzF2Mtc1tlu6ac7EWjT2Dy/Cwgr597
    wNuKuLLGZOLpiq48wWvft8BIq57pScvNttloaQAnUjJOiB1IkSvSbZO5AqrB07Odkw9N1l
    RjfhOLCNctFw4mjgyKbUwIqPJBo8f600zbx92jTdSr+Whw0hWW589u2x4tOAX1DLkinI6Q
    QSSaBGxVuZLv5Nhu0+hxaC2+F9/xFBJ6tjjA+Vp8Qp6FV26TIuFG5EkvwFFVat62PDj6N5
    GiiVzkSnGI5h/RI3c0asru4ZVbO52n1NfIooS61tHDLdrCzk0tgeNBxSto9iPLPIl/tN0S
    G9WdqxTgY5DXazAqwlGmDUeKm5ud3uVnZ4P9aMKPS4X2anvyrwR82J8HhKZdOLmG9mLoNh
    04GowUa5cG/gIpfhfxkcXL3Ks26yjFuiL5q311wopIMJMnKALyQidvzgfZo3JEKC7rzZHC
    PUbjpNu9n7veBXdFEo22ndw8QeUskRlL9yJ8H0jMvbCjPsoHupLI3NByEErwDYekGp8+mg
    ZJWjLPqNuVv1XECjyvnZdRdUO7BQHCqSztVk8WCWMhMEkZ1lTsTguEb58rWg
X-ME-Proxy: <xmx:FTsdalcFkQ5Ej7ypq8i1r21NPPmx7EBrqMVKPDJC_jtduGJmMWH3HA>
    <xmx:FTsdandl5H1EbAm87ZW71KCi5awWSb0PBUqFq9pNR3xVFAWkZ5jamQ>
    <xmx:FTsdapgKx0rpSvCoL2TTjraSFXPEw_YvCwflqF80q1Cu8BQM90sBEA>
    <xmx:FTsdajQcY02H819RcFZOWpgAIAjfndKxeQDwf6mK4HGJr-YnGtIrLQ>
    <xmx:FTsdaolYPUJt4gk57e-ldZ7JQUh9J4FPkz8gYQdZVqNlCctfk_r9LYj5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 03:56:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57f898bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2026 07:56:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Deprecate git-init-db(1) alias
Date: Mon, 01 Jun 2026 09:55:58 +0200
Message-Id: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA47HWoC/yWM0QqCQBBFf0Xm2YFVwqxfCR/c3atNwSY7WwTiv
 zvZy4UD95yVFFmgdK1WyviIyisZNHVF4T6mGSzRmFrXdq5zDS9P5YglI4wFPEthSTbRc3Do43n
 q/eUEMt8+k3yP9m34s779A6H8grRtO0YbfKN9AAAA
X-Change-ID: 20260601-pks-deprecate-git-init-db-c0e8d7f8b94e
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series deprecates the git-init-db(1) alias in favor of
git-init(1).

Patrick

---
Patrick Steinhardt (2):
      builtin/init-db: rename to "builtin/init.c"
      builtin/init-db: deprecate alias for git-init(1)

 Documentation/BreakingChanges.adoc | 3 +++
 Documentation/Makefile             | 1 +
 Documentation/git-init-db.adoc     | 5 +++++
 Documentation/meson.build          | 2 +-
 Makefile                           | 4 ++--
 builtin.h                          | 2 +-
 builtin/{init-db.c => init.c}      | 8 ++++----
 git.c                              | 6 ++++--
 meson.build                        | 2 +-
 t/t5502-quickfetch.sh              | 4 ++--
 t/t5503-tagfollow.sh               | 2 +-
 11 files changed, 25 insertions(+), 14 deletions(-)


---
base-commit: 1666c1265231b0bc5f613fbbf3f0a9896cdef76e
change-id: 20260601-pks-deprecate-git-init-db-c0e8d7f8b94e

