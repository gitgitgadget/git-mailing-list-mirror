Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B134490C0B
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453694; cv=none; b=ZE+R7DXGxZ6/YnN616LwRAhl6zvL09zSEY//Bff0mK5sbreTcWpI9QhfOOolYxCfjFatqpyvl5kU7956iToTg1aHqGfFxYPJlYke8Q2A0Lf3WnsIEBTEx5tGUlnYDDuvrTHODuQVRJbb+MJLLgOT+oK+SY596d0hvvThoaCpzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453694; c=relaxed/simple;
	bh=hAPZTCzdxbvZhcricbDB1oxmg0KHCMU/2spEdvPSqRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gSKpM7yqJgyvBt5RW9VY3LUDd1yPjP19vgRjR2zyLmO7ofza5XB9ex/WRWE2nLsk63qOrAc5Kq7UhL3BOf0z8criE1QisAKRMAamHfSyeLuprJECMAHmZgYkd9ti+54iGy0BOg+Mr2ZqK+P08hi0oLxZVqQ4i3Bh8GqJKymEd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fjuEE7YB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9Wi3s1F; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fjuEE7YB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9Wi3s1F"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F15D1400116
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 06:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1791453691; x=1791540091; bh=n8puCMe9rx
	ZDwQtv9C2ogX6mtJ9lZYFJFi9dotXs5rs=; b=fjuEE7YBhpaiQcSeLYMKNe6+Y5
	81jrcqjpmoqAOjvHN7FPwCws7OvN2+9fUyAa6hSV73JfvconoDhchVRHHzmVwXAT
	KN2tnn0oFRTFvavV6ve3cGZKYRx59AXBjSL1aNnb4B2SkwgNVNm8oCDVvdSi/dTJ
	TiKi33mwPXjiH6r44kk/JZ0A+ohb0BGgAhDa04TRr1qq8W5xI0Ob6R6gFiOOeUZj
	52DEUHiZ98XHAypaxRXpUI+PVo2jwYhPKC47w9zXny9oCmBVV7uFuCMt+83NLzGY
	kDDI95myBDyJuLIV5vYBtHURGZqhL+RXgjpeu025gXD+MomWbGvadpn9twIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1791453691; x=1791540091; bh=n8puCMe9rxZDwQtv9C2ogX6mtJ9l
	ZYFJFi9dotXs5rs=; b=k9Wi3s1Fq5S6ocZg6Bcx6M2neckrO1HyVuOJyYqHmkzu
	JtPurP5OIRudv0lRgsTumklWcRNMerj3vjrawrD89rthImYD/vDxVqhFxsm+FzM5
	f9YMY/ybF9dQ+NtcJpGJfILgys1Kj9gJrU9v0gvoO9Fs3AKFMPO1T6vZ7MoZtPWg
	SrQo+vke+VEF5FwodkOBx5nSBBDnJWx6iBKgmWgXHQowtbsdDxfIIhfYd989DYK7
	eCEq/+nLJP74Ngk69RDzaWxYYuaeNn4DjsKWBB2eaXVEWLqa/moeOF+Mjwh0MGTY
	drviN+0sMFU09f3Zn/yfHB13mWU/qkZlvA+4P8XktA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453691; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Jem1van0BCAi9ezUWCA2tNMKMwEPcZf4sy0ymKdxNPpjd96
	vMufM2ke4DsX1Lc13Jp5rSf7HC36lwLwJCMj+ybgZMN7WJSQJOGj89vgNF5haqPg
	Ri/AB5QQmUEh99H/Zdrlyrjzr4A1DEqI4+alFN7s7sZtv38IW4/9w9J2ee+s4JTh
	cH/nI+sl8B171P3DpTerSU0nfUZkFjjV6l5aHOneJUfwY2oqLywZP5AYfHOZKoB/
	38vDt+Nof2edZUocjy2VMPB3Eo9LupFtgROzmWzTJVVc5KcrMD4qjlmap0yMGIRi
	jtBK2QAdzxFFbV8JR7L1XKcw/E+Cs1b0jsDYmog==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:Kn7KlWkDIQmPrT9hCGJN4u0t0lzlhfNJF5dujZGgElM=:hAPZTCzdxbvZhcricbDB1oxmg0KHCMU/2spEdvPSqRQ=;
X-ME-Sender: <xms:-mnHaj2SmqQiL5JGUNwgjxaXZ_mzP8H6fS1UKJwUm00T2w0EAFQ6Rg>
    <xme:-mnHapgJQV0fSdOe5w_wtTyc06AXSiq9A-fkqHDGLw5bwgAsJhtClwpsh8n9XmcUD
    1NoLytvk_SDpJlkMrqqLW3jpjnzI4DaiPsG8TPcZcxNLiEPbcuxBrI>
X-ME-Received: <xmr:-mnHahSu7f8Xxacq_gaCxUf9NF5Q4lYWwsfLLO4hu3U5klo9bgOVsA>
X-ME-Proxy-Cause: dmFkZTG3LQ31xjMfVtHchAZsc8vpHlMzrMkyLKj2MohAf8LeklgF4Y8kYiYSftgtq9OAZS
    xQ7vqXviO/kzzLZm0CJyVNQAvKNBR29f9pi9A3ekz0elZgX5YrhJSEgryxS07QjRDAaoX7
    pAKeBzPZYoGeNtjhNpcNwagsS96IFS+Fq5G7lhBvY/jgfhoN9Y5UtIUHppX3du3WORSOiE
    NSxaPgBYjgPSfT/QD+vg/ZBKYEMfvenF5QtIi+Q8/Mb99ZTjU2Wc1Id8cAE0WozK0vT/A5
    aJfRpekh1Fomz/0Cl66SghIdFxnTUX9cyDURK3koeo8pkmqxrRWT3cP1AxVDAROkxLseI5
    YccKy5YV9REVmQ4Bp2EZUBOR7WmJ/cIvVrMWDUunFbjk0eLpr/1okqjIo08vRzAYoVN76N
    IWiwT7RKBq9eQtJWrO5oRg/VquoB+wDGBaqU3GXwU0N2RHdbMT5b4gG0FHR5VXSquFjWx3
    QxfruNpX8RKEP6IkSOuOZztMwSgFqmE395zUXos+EIulA3H4pS3GS6uz4JBOdbaA0yJF2u
    CfQOUkfSccNaiJ08pnLA9gdnJ4kqLtWM2/AHiDu2lqcyxsK27pJR4JY45Btqx47PeKwyKB
    hxt6sN+7NfHapGBVxtxNna0x9F/gJjIh+TqFIE4lw0DOj5Q6zC+nO0fzB6aQ
X-ME-Proxy: <xmx:-mnHaiia0z04TIIT-f_NzKRlgz0MB1pXBUUpQ9QsdQm-abE6F50jyw>
    <xmx:-mnHap4O2qYjJPDG_TiAxrVT3gMFaoTtqt1Y7xsfDabVX28B1fSJgw>
    <xmx:-mnHanCuM3xTe2r3ypHVHsGA_NzKwQ9a7rZwviiRxc1V_vX9XT4-YA>
    <xmx:-mnHaobvzK1lVjThmmZzSXbyv9VN6xcNRLUlSeEBTHcH-xn75voOIw>
    <xmx:-2nHauSQrMYi_xW2dMShcbevvNpqNz1AFzvhfzrLrvuyONQtbfa8P_pP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 082339e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] ci: some housekeeping and modernizations
Date: Thu, 08 Oct 2026 12:01:18 +0200
Message-Id: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrDsQbdHSq5QudPyjoxBDRktBv
 HvTuvwW7+1kSAqjR7FTwltNl5BRXgqSsQ0DWPtsqlxVl87dOc7Gojwum2EGooaBb+Ib38q1c72
 nXMYEr5//9fk6bVs3Qdbfio7jC3MUSeZ3AAAA
X-Change-ID: 20261008-pks-ci-housekeeping-4cf7fac3b0df
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series is a result from the discussions in [1]. It fixes a
couple of smaller issues in our CI and bumps jobs that use EOL Docker
images to instead use supported ones.

Passing test runs can be found at [2] and [3] for GitLab and GitHub,
respectively.

Note that I've also merged the Meson changes (ps/meson-improvements at
ce4a600322 (gitlab-ci: fix hanging MSVC jobs, 2026-09-24)) in there so
that GitLab passes, but those are not strictly required as a dependency.

Thanks!

Patrick

[1]: <20260906151137.GA328152@coredump.intra.peff.net>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/687
[3]: https://github.com/git/git/pull/2445

---
Patrick Steinhardt (8):
      t5004: skip SHA-1-only test in SHA-256 repository
      ci: fix "fedora-breaking-changes-meson" job
      ci: drop unused "linux-clang" logic
      ci: switch away from unsupported i386/ubuntu image
      ci: rename linux-TEST-vars job
      ci: switch away from EOL'd Ubuntu version in linux-exotic
      ci: drop now-dead Python 2 coverage
      ci: drop redundant linux-reftable job

 .github/workflows/main.yml      | 12 +++---------
 .gitlab-ci.yml                  | 12 +++---------
 ci/install-dependencies.sh      |  8 ++------
 ci/lib.sh                       | 13 ++-----------
 ci/run-build-and-tests.sh       | 10 +++-------
 t/t5004-archive-corner-cases.sh |  2 +-
 6 files changed, 14 insertions(+), 43 deletions(-)


---
base-commit: 8e383dedc6bbc4fd7bbb203512fbf2eafc151e04
change-id: 20261008-pks-ci-housekeeping-4cf7fac3b0df

