Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6E17084F
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986061; cv=none; b=k+BzhkJGhVbxfReRXJDli5/X2YcRRy1OCOGoA3s0lNmqnw7Gjcg8uRYDriEI6Iw4CSmDcfZbkV7UcLfZtwfJpAd2hL+yiJ5ktQ9I/ujnJtQxDTGiADjpXVIG8ASv0UcRg5BEKQBTnPnQ9v9zJ8dUxzcOve7y2HXtRh7Erdel72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986061; c=relaxed/simple;
	bh=XUfdK6uEjMR3yASfKKo+hjamM/AQRNcX7ybedulMLwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cSNfC6Jf7aq02lviNVQZH558lyjIgrm/SeiJ4sPTZ2YMFHI9YUZixC8ahpwYEXq57DYY/XpnrgR6NhkR22pwkR35xt+L1+lOx6OkKtDlpOIWg3q4++FWCnEHMR/VQE9fxeNnSwnNDxXnPegr2T05VtJS/OeKeMy+3ghovpj11kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dix0gBFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5gn8W+tZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dix0gBFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5gn8W+tZ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE95A11400E2;
	Thu, 12 Dec 2024 01:47:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Dec 2024 01:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733986056;
	 x=1734072456; bh=UsXW2B96mi5VPsN8SLwY1I5/KbtRrunjz0jYUjqqb1E=; b=
	dix0gBFhACvIWZ9XNhsooCi0MJIHpQEGT5tR8cF/7+oQzW/fUUNpOqgScQx++vjS
	a4piGo5cGnRgMZa1lLWO501chIIpiG80yQi/WRB8X0EqDsY2Mqe29JdpRh2YQjq9
	JwwzdQJHHVLasXOdfpXXVO1WobyplOzGly7b+PphFthtrwjpYdVkrM2Rw8OQa6TR
	ceZGpsYvy1rzSs+5sziEOYWGuQLnxI71eKosA+Atfr6nGcC9f/rbBSnQF3IEB0jK
	WLPL9Dc1FyWz3pd0xNn48Im3S/hYO2U8oJoTN2bEakSjJOnJ6ddyweI66/oFyW2q
	V/B63DSrCaSIyM7EtnqIjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733986056; x=
	1734072456; bh=UsXW2B96mi5VPsN8SLwY1I5/KbtRrunjz0jYUjqqb1E=; b=5
	gn8W+tZjtaK1iysQrZvinlbGJ8Y0JQFjAILSoypjLrOmEsSGHo3Guvc/W7kg17i6
	h1yFCu1BRRXqLzQ0CNw59cJ+adco3vq2FPvg3xculQeO3r+5IQi7ntPJMvqCM0aZ
	nR2vfzvYnz/GBcjipSIDX++XtVBkmHBsOQ5d7Q8Qz6irVX54QznoMw5JgWkVn/FE
	UBNdFWuxB5OJ00qMOIq32faJISLdqxv35OGJgvinrFFDdytf6OIamucerMpDn8yu
	CWLS6WVv9I8o/dlv0v1uWFHCmXwafHG3CETP4do8gOv19VLSyR6cfy+lxOoIPCO1
	tULb6NtEW70xRzZNy+8SQ==
X-ME-Sender: <xms:CIdaZ-IedG-a0Y8Df7LBm_1RZmHKonttxPrza-7JVlbKV3TONE9_fg>
    <xme:CIdaZ2JOfoSz_S5CK_6jY_zdw8bIW5xznWe5siNEJt9Y4pmjodzooIBJ9CK6dxQA_
    tPNqJ1INQT-3u1-wA>
X-ME-Received: <xmr:CIdaZ-vD6xmVebxTZhqK8ByS-lMcCaHU09TgLyi2DwS0Hr0wT14LWp1NdRG-Gi_l-gL5MdOk8qdDYegnuT0cV2mVt2AbhAaKKQlVg63isvtGCvYF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdehfefh
    geffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhgu
    uggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:CIdaZzb57oarcKj7w0WRXxdTDKX8xlfZ_4n3Rbq8ZV0dbGZ0Vqjhmg>
    <xmx:CIdaZ1ZksvUU427Quk82xhtlVk-Oxx2m-Whz0rA1WiSV-JJz5P0ohw>
    <xmx:CIdaZ_CYSHdxuEh4VhRc3hq4XUCfAqshfm97JTD3qFqyg4v-STh0Wg>
    <xmx:CIdaZ7ZPLpPYk3JHI4BVcjH2U-FWA7qDqtSAXWajZCVZhmIprkIITA>
    <xmx:CIdaZ0XfuaAbB9aSNxRBN_SHvusNXau2J4U_At9Wk1cERlkxABPIPX9T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 01:47:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bc83a104 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Dec 2024 06:45:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/4] Random improvements to GitLab CI
Date: Thu, 12 Dec 2024 07:47:13 +0100
Message-Id: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPGGWmcC/4WPzQ6CMBCEX4X07Jpuqfx48j2MB1oWaYyCLTYaw
 ru7oDFejMfZnfl2dhSBvKMgtskoPEUXXHdhka4SYdvqciRwNWuhpNKoZAb9KYB1EMgObIXG3Sk
 AGlOiJbORphAc7T0tC07uD6xbF4bOP5YrEefpH2BEkJBXBk1WUprpYse2tTuLmRbVFwHlD4JiA
 skit02NuW70hzC9Cnq63vjd4d1ymp5zAo96DAEAAA==
X-Change-ID: 20241206-pks-ci-section-fixes-1bb91ceb50b8
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series includes a couple of more-or-less random
improvements to GitLab CI.

Changes in v2:
- Use "%s" to inject variable data into section headers instead of
  converting to echo.
- Link to v1: https://lore.kernel.org/r/20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im

Changes in v3:
- Wrap overly long lines.
- Fix a word swap in a commit message.
- Link to v2: https://lore.kernel.org/r/20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (4):
      gitlab-ci: update macOS images to Sonoma
      ci/lib: remove duplicate trap to end "CI setup" group
      ci/lib: do not interpret escape sequences in `group ()` arguments
      ci/lib: fix "CI setup" sections with GitLab CI

 .gitlab-ci.yml |  4 ++--
 ci/lib.sh      | 11 ++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

Range-diff versus v2:

1:  e504aa4a1f = 1:  633af36640 gitlab-ci: update macOS images to Sonoma
2:  021ac694ef = 2:  6b6c6b2937 ci/lib: remove duplicate trap to end "CI setup" group
3:  6e355e22d7 ! 3:  bd54f8e1b6 ci/lib: do not interpret escape sequences in `group ()` arguments
    @@ Commit message
         We use printf to set up sections with GitLab CI, which requires us to
         print a bunch of escape sequences via printf. The group name is
         controlled by the user and is expanded directly into the formatting
    -    string, which may cause problems in case the argument controls escape
    +    string, which may cause problems in case the argument contains escape
         sequences or formatting directives.
     
         Fix this potential issue by using formatting directives to pass variable
    @@ ci/lib.sh: elif test true = "$GITLAB_CI"
      	begin_group () {
      		need_to_end_group=t
     -		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
    -+		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"
    ++		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' \
    ++			"$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"
      		trap "end_group '$1'" EXIT
      		set -x
      	}
    @@ ci/lib.sh: then
      		set +x
      		need_to_end_group=
     -		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
    -+		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' "$(date +%s)" "$(echo "$1" | tr ' ' _)"
    ++		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' \
    ++			"$(date +%s)" "$(echo "$1" | tr ' ' _)"
      		trap - EXIT
      	}
      else
4:  bae2071e47 = 4:  41ad98d633 ci/lib: fix "CI setup" sections with GitLab CI

---
base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
change-id: 20241206-pks-ci-section-fixes-1bb91ceb50b8

