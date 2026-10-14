Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420D49E5FD
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966644; cv=none; b=uGfVMUdAz8/6yKAyiGDG6IURzIQqI9Ys1nC4ddBXxDirqeE2Urzh4yE15IdG841KrGU8aM40xva47KsB6hS8WoaKs+oqimLS4GfLpkn37iYvBc/JVcaqtLHyQl8ic/vACsfRbsiKk99Bq4l9znSNbR5Tpu6FNVMLuNwcrLcWM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966644; c=relaxed/simple;
	bh=6rI/w18FBVqO37aAw3fY1GBXg5fGBcXBRae1E1Zn9nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnnMxdEWP8z1JyJeC8N1hzXqlp6Ou+qWwN4t+X7jYSDHH2LX5nRzbKNlD5qpR7hiW1M4opc1AOdtxxje5fWwDURHqCDOWjxkja4G3Agjiyckr85ua3Hcdwgwsk++xK2bGPKzoqkZmtvROFTgXXQG/U9JNA39iIvOhRiEjqVJCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVszeH1u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rnzwS5+F; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVszeH1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rnzwS5+F"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 004C9EC0303
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:30:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 04:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791966641;
	 x=1792053041; bh=ApmT+N8IukcXTpysj9yv6zRl36qdeWJysk/JdNWOTaU=; b=
	dVszeH1uhqhkmnfb3xeYF6YLFjURZll0uN60xPtUkkiNWIyaCvvqusHuKVMbLg1D
	vRkgF3JeSB1UYQQqrX1ydONSgoQ7UZrQh3kpaPbkBoGYTqlASD7KzvjWzbomwUWP
	cnt6L/8ZN9CKy7QCgtgL4nSXyu/7QPMNq7E3M4nPW9+jJgtMl0TBZulu6oypasvW
	VhNS+ST2x4DeGDzuY69BxdjLOPiCaFA45Jb9cP7p/NZMkJNb7SVe/Rq3el+X6dTr
	8NIBIMwdm2VzWblk603APRrYblWWPDV7jskQZNHhM3c7KLuEoSNmDS/k7pu78bsW
	/r6uzCrQB8+uVVQv9cprNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791966641; x=
	1792053041; bh=ApmT+N8IukcXTpysj9yv6zRl36qdeWJysk/JdNWOTaU=; b=r
	nzwS5+FNAQBjblaq+xFN3nYNxrUIKiSQh+XBaq8IqxwUwiE/wVkLoinqaiTnu7Sx
	uizNe1oNAt6JHiNYGflJHyllC8CqpSa9ja2rhxtZoA1AZwl7js1imzKeuT1yIP0A
	/s7FlvatJSQDwshjsuaKxuZIzdDq6X61BQN5N3TnnP5I0yg0E4v1sPl8NGq5dnQA
	Gs1KJER6oX09v7avGFjT/5+wBQ7RAy6f/cfgA7xa95CZvHCnbWg6E7qIeAMEuwd9
	jTm8Va3P+MTW9ocK2OsDPIX1GPQvKlLcjwyx0e9BKQicrMskAhys4nkFQvERNIJZ
	nYPHT5gdX0Sphmpr2ZJbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791966641; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FCyqgcF6yfPRBnPixTfNLsuH+m1raQnQo1Lwe4x/K07nOIb
	yQn5e2Ub0u1RhuozfHF0BRObI4sPNCdob+fm+2OmUsd8uwa+W7ylANtd+L0DBghM
	zOpaDjWHLM4KOSe89HGBnzUe30WvxbPsCA5JDCcoD3LCzec06dWsDTpCnZ0B7fXq
	sQrpBkMmG0IOjWegTNATej7DO3O2rlYR4USuK2aQy4p/eEm51sAdDZhscJOJVOQM
	vuc6QNX0GNfhWcnRZ4/Wpyffeq+hWOxX5J1iBBmdlg20DhXgbq8RrvEK6+2lkO2j
	dI4El4SNrbZ5hSnB3zvXPf1AHyck00pyUD6VZMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:c7/oT+YpZNlal550xtxIqQLigAyxoXyrWg112MGt1Gg=:6rI/w18FBVqO37aAw3fY1GBXg5fGBcXBRae1E1Zn9nc=;
X-ME-Sender: <xms:sT3PavOtQMhewoPoiJK6MX7uUjkaR4MuHowbB9-B35bDAONu-k6ojA>
    <xme:sT3Pag1JA5GUW4sPWkH0_bvaeVkmrteX7pRm50NGhrO-UDWdR-yJLmtbiUWbSY_Mh
    po7qrOeBTydHiR_PoO_F8WpebbYT0fJLtRUy07v0BWvhFp_z3jIPw>
X-ME-Received: <xmr:sT3PamlbFvNMCCM1lzR7gvX2zYphyOsr7PfZu5bPdczWz123Bfa2sA>
X-ME-Proxy-Cause: dmFkZTFiXFj+FBRzh9HS/srF0SxU/3tlRmBXj9wQFBopQh3IFYJMfA+RUJUfDoRGuNt1KT
    0rl/kzbB8sYSM9TDGX4EVTusgs4+ZnUx/1PLczw4a541VqzKaCGYPukpYUQHVzjIc/aMFf
    cmg2rG7xHEahxp8TvqD957x0FXuNJBsVzxoSPBbR8Wv1EBIOjDMNZ5IblLdHw434hoaPei
    2IfpGBQB4XY5UK3hklkouyTooFIaMQC51vcUKxTV4cExYv6h01V6uRodCalZ79DgjJY/QK
    3oY4RJ0CTISZilN+VrAVJftpDGR6lD7EN9S6WMQqRb2G3fHmErx8LU0ncFWSAdN+wtJJjk
    e8fkdhsDr1xlAY22FkutgLqOH1VMBx4mm+QCAgh4V7IPJvujb5EojrtJeGxk6s+Mf+/Dgp
    1c8ed/TqFlCwDtfVQ6SdiWaAWi4BzDefYddMsnIlzYufIW1qSxNCHOLg5d4ywQeuEVBUfy
    E5WUuU028JEf4T1XVJCds6Tewqi2O+0qd7H10/IWMRm+TFpLcwxbFHOsYHn5ZyjnXxhI1k
    CpOreD59lVnJYyeQho8hrwrc+BI3jf9PxpyrD4p/xIFnX8+IzJHbl2oa5KBq4sqyshvGzv
    ufi5DIbuUOOV2g4zPjfvU1M+sL52/nxiPndQY0XpAIbH0WrgfaiUqfHSkPYw
X-ME-Proxy: <xmx:sT3PavVrEm_5Au9kvQYJtHSmzE1yOnfPdvFPPkTQwsxlRm2Pzi9GaQ>
    <xmx:sT3PakvSxwi51-JAxxhK5x4RjLLV32-I3a09R3EqqNFh9SQAFEGwOw>
    <xmx:sT3PaqZFJC-_6ZXXq2k28noLQ5RgD5FKsZ9-2KqgdRJKucQgtolZcw>
    <xmx:sT3ParUTRijeRtVXT_ogFAGDZV0pjHkp4DTCmMAN4Tav7xyVxIPwmA>
    <xmx:sT3Pat07xOjZenFFXkdQr9g6C5teCOjzrnkLU96p1DW9oBAQ7vn96tuC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:30:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 66cc5c3b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:30:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:30:28 +0200
Subject: [PATCH v3 2/8] ci: fix "fedora-breaking-changes-meson" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-ci-housekeeping-v3-2-04c24e1f480d@pks.im>
References: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
In-Reply-To: <20261014-pks-ci-housekeeping-v3-0-04c24e1f480d@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

The "fedora-breaking-changes-meson" job exercises Git with breaking
changes enabled on Fedora with Meson. There's a typo in our CI scripts
though, which has the effect that the build does not enable breaking
changes by accident.

Fix the typo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6a3b43b366..bc5058c917 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -18,7 +18,7 @@ almalinux-*|debian-*|fedora-*|linux-*)
 esac
 
 case "$jobname" in
-fedora-breaking-changes-musl|linux-breaking-changes)
+fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;

-- 
2.56.0.212.g129ede20d9.dirty

