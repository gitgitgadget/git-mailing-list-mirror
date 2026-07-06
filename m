Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997243D45EF
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319058; cv=none; b=r9FZeAUkJmz6DhnY6bfmV2JgtBPWYpEvc02x57kOPjo57nBi7QX0uHUiGF6c9Id+765IzNOa+LD2JzD87EpzYJ0d+6qsHX3qPonUKxlQnZmDtV6xc1dL+rPts7e4+AwWAir/7GSNdneMCatUhXrd7H6A6uTHoVV+yOE1RpFY/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319058; c=relaxed/simple;
	bh=M3zvRxenBErja+w52ZdbNyGrGqN8O4ySG5w4DEKJb6k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ljV8zmLjMNKJIWdRxEVbfgrrLFqA3wkJlV3MTwoy+FKCMJ6T2YGYW5GxdS7iBeaL1SbP70Ep/STUmVNs30+ekinB390wlxpEB38JxgNdmdpt3lDTvCbx1GIfVlb9zjU3RJ50D8LgRvGKd+E92V4eWmxc6qDrSnuUz2Tv4Rs/Da8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SDw1GGyW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gcl1jOKE; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SDw1GGyW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gcl1jOKE"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 577D67A00E1;
	Mon,  6 Jul 2026 02:24:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 06 Jul 2026 02:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319043;
	 x=1783405443; bh=rLwQb/wwzgl2+zeIT2tcmsVGdVpBpClm5Ka54hK8ZLU=; b=
	SDw1GGyWDPEA0aSiEkKdsltznqUBSZ+iUIZymZaAkO2XEFJeYSjLjgEcoKHt2K1g
	B2iWOt6HleoosjXst4VdoCJXc2xheBV+Um7Yt1RNGLhrNqpIzOhwc3Fy9JR6vPjm
	FYVEF7BsIqVNDUl5k8LBuMgHUHDZ+ZmBM+UoZXs8yLsQ2Hf0EnKM1QqZZsZgvu9x
	db0oHRx6W4LgG2BVavc565cEp4gcSdzwf41kv2ccUyKBTws05OcPSuWorbjUxD2w
	KNYvzhe2zmpke8qGj/5nVuFTgdyGZPdqhKbNYqC8VxfBTGTxsclKoNMZ0ZQLaxQY
	E9Inwx1bn+NlNUpGqlBVsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319043; x=
	1783405443; bh=rLwQb/wwzgl2+zeIT2tcmsVGdVpBpClm5Ka54hK8ZLU=; b=g
	cl1jOKEt7jCNPCGk2N+B0Jx6wZ2kckp1+lZHOIHHqddK2fJJatrhPtA7Y79VtiIH
	MESe3VrXyEJOoRi8XEnOo/9HQtVUN5LHe4vBc9iDTVqvVXZMt4sjlgcy9KImNwvq
	9dOYpSbRS53CwWAgsuLw9DpiauqECW9zVVWceL3tYE/pjfQwK6ifPQRk7RwhE14A
	rLtH9qXwk1kLdzenRyLlksU2EUbdQS+ltSxfSKwvKZ6pQJPk8Mr2t0g8UMrWg4/W
	1Xr7HNfyZ58nOkOjvA5sjpK+/DLAkDs+ZhjBhphyIHmtg46kaEnN0JH4jz+dBkc5
	sJEcGZHYGdSVY+YA1AQPQ==
X-ME-Sender: <xms:A0pLajO0Y6W4Rio4T0-EY2uTsEXsod3twvG8TlnIoUWKTtmnmY-zOQ>
    <xme:A0pLak1yinPhIThn-LKxSRvE8alP-nT7URkH1aXyd5f7AC-pTaoTAdC8qsjKZQ2_H
    u3SHq4leFjC_LJndkGINRY56k8O-AjHfT6KeToo5F1SaYo3V8FYvg>
X-ME-Received: <xmr:A0pLaqlrslxycf6jM2fS19vWJZZMHS6txuVBDsptUV0Y0XW3TzHn0MZpbatCSiNsh1wlP_YTAmeVgbKmbrzVlfBbW9Fszqve1DTz5d7JHX8>
X-ME-Proxy-Cause: dmFkZTEfvyAtm+DhtOo0aEy1p5O4na4nOq9dK703+XI40iMVMtuAnu9u6w6dwQFreLiITB
    MvvY8gBqQWz8pLjyEbOKVI1UDgIf/HjO7pnTgrNTYAxlutPKmNWXAEzFbl8EC8Y/LyjUSt
    91P6M3ZKL1Tsu7BPXWRt0tV8YIP26YDX1W69ut26GexiBSwLyDy0gS1opwjIB4CrsQPmEg
    omrcSXQT3WDbqbfBBjstWRiJPu+yL5UfwlAQ4uE+EMU/K3dYB9aSlewMhcBE7MdEPxpFwo
    f+19nJBsfDenGThLA62fdGxt4QhUHf1ZzROpjFfQOn/rphgHWrjc/uEob5orDbEhpFrwjV
    oDes/Ym0UFRO2+CTggfLUH0lDSsBslisogjtCGG+H+WYZmK7DvI9oIy7yeLH+R2JJdhe2p
    W/9xTlBHE6HRnW53PNvC8/puI41HcXsxeWcCtKAlbGtnPtBVZt0kxPCEFvBsw51FIPm299
    UKyr+g3ATmN6OP3vKDeI2ecfz4IkCGx1/hbLPsIA6atka3a7JRlNInvvoEsVhHtvpMstWt
    deN6YohVF6ba+UTjqMOIq2WS5k/OiB6JEwHuqlNc2VcUmyPffpiS3PFBnkmL426yGIOuGu
    QuzP3D8URKb+sgL4//0RYafEvNw2UfECBUoRKqC68KoviIGNETLwsOm8+NRQ
X-ME-Proxy: <xmx:A0pLajXXHhhUOoQLQQmWZlU_U4u6CmKNUg8Xp3JvWOBA5KZH2y-PmQ>
    <xmx:A0pLaov8bIp_RdPri2pIHAVBY3NhSPkGRtrtp2Gva0Zo6lmOjlX7yA>
    <xmx:A0pLaubCbDnxjDVIkZ27MA_mLoqrHKsprS6sNsZa7FDxJ4h05taKRA>
    <xmx:A0pLavXnqqBX2Jshkspd8pKG7HSoHireebYuLqEB1RItuwCCL8CTIQ>
    <xmx:A0pLagzxpTqVz2I0yQVQxySernGUL-MxIN7bQJ0-5ySiWY0CIPH2TubN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 05215d65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] t: fixes and improvements for GIT_TEST_LONG
Date: Mon, 06 Jul 2026 08:23:55 +0200
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtJS2oC/42OsQrCMBRFf6Vk9slrqkl1cpEiiA52E4emfbVRb
 CWpRZH+u4miuOl44XDOvTNLRpNl0+DODHXa6qZ2IxoELK+yek+gC7cZRy5QYghqBOejhRZKfSU
 LZWMgWaSQzjcpLNerBGRM4yhWJRIK5jRnQ0/UWba717YXdaC89V5PVNq2jbk9P3Sh5945/jvXh
 YAghRoVUmUqKnDm+KE+Md/q+Lct+sPGvW2CUmSSMBf8Y+v7/gFBbq0ZLQEAAA==
X-Change-ID: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Hi,

this series started out as a simple two-patch series that wired up the
GitLab CI badge in our README and GIT_TEST_LONG for GitLab CI. But as it
typically goes, tests broke on GitLab CI, which made me realize that
they are broken even on GitHub's master branch right now. Some tests are
failing in the linux32 job, and we only didn't notice because the whole
pipeline hangs.

So I had to go down the rabbit hole a bit, the result of which is this
patch series.

Changes in v3:
  - Fix commit subjects to mention correct prerequisite.
  - Link to v2: https://patch.msgid.link/20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im

Changes in v2:
  - Reinstate the EXPENSIVE prerequisite on t4141, as we still end up
    reading 1GB of data into memory.
  - Improve a rather hand-wavy commit message.
  - Link to v1: https://patch.msgid.link/20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im

Thanks!

Patrick

[1]: <akIfsaVMB_S6kfJQ@pks.im>

---
Patrick Steinhardt (9):
      README: add GitLab CI badge to make it more discoverable
      t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
      t4141: fix inefficient use of dd(1)
      t5608: reduce maximum disk usage
      t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
      t7900: clean up large EXPENSIVE repository
      t: use `test_bool_env` to parse GIT_TEST_LONG
      gitlab-ci: disable RAM disk on macOS jobs
      gitlab-ci: enable "GIT_TEST_LONG"

 .gitlab-ci.yml             | 13 ++++-----
 README.md                  |  3 ++-
 ci/lib.sh                  | 12 +++++++--
 t/t0021-conversion.sh      |  2 +-
 t/t4141-apply-too-large.sh |  5 ++--
 t/t5608-clone-2gb.sh       | 66 ++++++++++++++++++++++++----------------------
 t/t7508-status.sh          |  2 +-
 t/t7900-maintenance.sh     | 56 +++++++++++++++++++++------------------
 t/test-lib.sh              |  4 +--
 9 files changed, 91 insertions(+), 72 deletions(-)

Range-diff versus v2:

 1:  e4add14ea7 =  1:  afc7563e22 README: add GitLab CI badge to make it more discoverable
 2:  d762b4d46e !  2:  753e950eaf t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
    +    t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
     
         One of the tests in t0021 writes a 2GB file and then roundtrips it
         through the clean/sumdge filters. This test is broken on 32 bit
 3:  8d43eb2819 =  3:  f776e0fb5f t4141: fix inefficient use of dd(1)
 4:  fcd048f6f7 =  4:  9754b96a43 t5608: reduce maximum disk usage
 5:  11df7f2cb9 !  5:  0f2e28dc11 t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
    +    t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_64BIT
     
         One of the tests in t7508 is marked as EXPENSIVE because it ends up
         creating and adding files that are multiple gigabytes in size. This
 6:  a16bc1754b =  6:  d329a2cd40 t7900: clean up large EXPENSIVE repository
 7:  b2e6b0d517 =  7:  a336d4ce9e t: use `test_bool_env` to parse GIT_TEST_LONG
 8:  9632b19164 =  8:  cfff94c79e gitlab-ci: disable RAM disk on macOS jobs
 9:  a42c613012 =  9:  ed5e8807fe gitlab-ci: enable "GIT_TEST_LONG"

---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06

