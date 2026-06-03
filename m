Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E7402428
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469958; cv=none; b=J6pGYBEi/BNhNzmQhzadEscM+Z7XoIydDx6Yhx0gbwapWaPyaIFVQUXP3eXrSucO8DXhm4gmjYMOSsBG7U6y+BtJZKoCtDQrp0DXd58TuheDm0ABseNA1/XKaB/wBpbKc4VqdeLu45W2vei3Q5THay9waxZYkADouTT2Mbr8jwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469958; c=relaxed/simple;
	bh=iXN0yxaiWBtb3QkxjaN8tx8akdXw3cSxW7ZcUjdR1IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYpnJ/oBK3x5j4oNuNUKaKHBvGwYFsKZ6/0AFqGobd8czCQz7UhPZyzD1Fdfyjqw3i00pFqv2PinrS0qGWG8/PlumV2thsoxIZ/YguQjVHile5dzz1xx3mLinr/vkO6Dl5w/gxmhn/1pJNTl/lHCED0GZ893mRiwKrOP/kJAO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SvW7FvBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9W2TzSk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SvW7FvBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9W2TzSk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20FF87A00EA;
	Wed,  3 Jun 2026 02:59:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 02:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780469955;
	 x=1780556355; bh=6z5UIUunx8/kgKcIHx8CDjmRfsAzHQY7D8L9/D4tzeE=; b=
	SvW7FvBM/RxZUXXEYiiA1dBLZP4gIeGyH7D0xMbCUPIFEnXGw6PnBE67GQ0VWE9K
	EKzmJ1SUMYO4YAkLg1AKYPyEgyb4IFJUvTkA9AIbc+628K/19sLabIL45HGB+fHU
	1kPUBO+O3WWcs528E5Oy3J3ER1DkETHkAT8GfCVKk9x4Uxamd8e8Gx6ftxIwbZcD
	y8X9IIOIK9Y2Ueaz5/1gupUOBLf+N1Djccl2oKwUuSPcjoTc5MSmnGFkC/cqghUj
	SYG+ma/LtZc0Ol4G6Yz0ZWBhnWcQoBEXjpodG/rEC58rR6Kz79TTqiM+ySwzbxsO
	tt7giW8mn/6wR1C6V4Ix6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780469955; x=
	1780556355; bh=6z5UIUunx8/kgKcIHx8CDjmRfsAzHQY7D8L9/D4tzeE=; b=Z
	9W2TzSk02grjpj8cDXBOxx7e1oA62PUW3XeO5RcKStNR6DdBuusRgwPrmPRorZ/2
	B1mG34v/A9mqQXNCi31TJ+tYkOmiXXEBI6lvA6Yc0IAmoG0El4oP5XC1hxxWdBhC
	q8JYFA43woF5A/PMdN/m3BWsphzastXEhFFeKeaED8JiyTfIiny9FWdPOtx4yTRR
	jHROB5x9n2ykAncGJIH33s/Up+i5FPeLmACjuc4KEbYxmZXE92CyKVk7yM2Zk1nb
	imep+9GxLLfh+mViHdSraejxwdMBD72CQUAqeCWRvg6kn9Ygpv98Qiq0kDklQDOB
	aLiMdQudG4UzllRlsocaQ==
X-ME-Sender: <xms:w9AfauxSSuOR7mzRpqqm4aE6ZxfKT1GjA2sGKnp18qTHcbSdWAA78g>
    <xme:w9AfaryAViwLsfS_K__RgfRg70zpNEMzmBwa4nRYHHhM0NUvTG_VXQRbvFx9aLPwm
    eNXCpT7LU78UbQ5uHAHqvpYhf4vKmv63wND4867_Rtvn-NnihXeVw>
X-ME-Received: <xmr:w9AfagZ144I1w2Qqt6in4wRj8O25rVuM83DJImqMVrqprzDuShYd7dpEUK1NqIvn4qYNaRx4mTOWOQP_mX5g4FHAVnGY59www1URG1ohJDSP>
X-ME-Proxy-Cause: dmFkZTFVGbIzgi+0hhi5S8Sp2B1BtxVkoc7MeFwUQybkjQx/BSlPxrd+m6IFgSIHc9RWiM
    W/jq3jcPnNU+w8yBwA2lwfkgkZk7YikjuOGoOSLwH7z9gJsDpII3bi6t8X/9n1snNcQxWh
    L5Vh5+fqBsmBPvvhq7VasJmJEwJLlYtMO2rx5YQjEF34RS2qJ5EdBfqzKfoSeV7/1dRVHB
    3Cs2zqTfh+Ph1/V/wHHSrUEEJ2rmfMiVu92P8rVerwvaWUo2wK1UQktEOPVyPFZ7c91Ty/
    AmJLlTPNl0FrdhFC9nD3+hdlRA4WOfEFOZKjuoTgXUBkH/9QCLMiZc1OWMEGEICBj5mhT0
    HnvwNDz8JfbszPzahEfFqPsNpndGoEXRanfEvIRkdDQEWH4khJDcqNUlVUStOWvs269ZQB
    4IQ2ku8EZZuow3eKjgffLV5opRambJ8xzv34YRnkCXTa5kRQs+39CkGr2dBJxMS/Qmkms7
    aFmBGVCAmud/5ayXdLYMrVnZMCsAG+FfkmFb0vtISwvjRvcDihD1mrSMXFSysxLGpvCA+O
    IuajNEhTpykdvKPUSr7Zjda7KRcJq8t2aShv94sTsGgUyS+jI/7atIuXf5ahywkJKw1Yhk
    fPWJL607NZTytbsdNqUvmLdIu8eAY2et3dzVQC+ht4BminANF7FuN6r1vIFw
X-ME-Proxy: <xmx:w9AfakWRgC-yrsP4piZ4vl9tTYwIcjMm0PuQHAs44pWjurxEPR8ybQ>
    <xmx:w9AfamggF9Q54WQwGEFe-41tPyDuWAbyaZP0FwDDlLd2kMCcV_yRwQ>
    <xmx:w9Afaqt9RxzMQC-ofSGiCAGvFe7JLlzEp4X3AEG3OBYi2AftVOyRlA>
    <xmx:w9Afan5-v7E0_Hvfovdevl9o8Mpe5twyeeIwoYRofJLv1Zdx47sgDw>
    <xmx:w9Afam97If_uJ9h-9txaz4M9vs3NRwXUQPtXWKtDY_IFF08_lQNC47kE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 02:59:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a253f4a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 06:59:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 08:59:01 +0200
Subject: [PATCH v2 3/3] b4: introduce configuration for the Git project
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-b4-v2-3-a8aea0aa2c23@pks.im>
References: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
In-Reply-To: <20260603-pks-b4-v2-0-a8aea0aa2c23@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.15.2

We're about to extend our documentation to recommend b4 for sending
patch series to the mailing list. Prepare for this by introducing a b4
configuration so that the tool knows to honor our preferences. For now,
this configuration does two things:

  - It configures "send-same-thread = shallow", which tells b4 to always
    send subsequent versions of the same patch series as a reply to the
    cover letter of the first version.

  - It configures "prep-cover-template", which tells b4 to use a custom
    template for the cover letter. The most important change compared to
    the default template is that our custom template also includes a
    range-diff.

There's potentially more things that we may want to configure going
forward, like for example auto-configuration of folks to Cc on certain
patches. But these two tweaks feel like a good place to start.

Note that these values only serve as defaults, and users may want to
tweak those defaults based on their own preference. Luckily, users can
do that without having to touch `.b4-config` at all, as b4 allows them
to override values via Git configuration:

    ```
    $ git config set b4.prep-cover-template /does/not/exist
    $ b4 send --dry-run
    ERROR: prep-cover-template says to use x, but it does not exist
    ```

So this gives users an easy way to override our defaults without having
to touch ".b4-config", which would dirty the tree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .b4-config         |  6 ++++++
 .b4-cover-template | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000..fd4fb56b6d
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,6 @@
+# Note that these are default values that you can tweak via the typical
+# git-config(1) machinery. You thus shouldn't ever have to change this file.
+# See also https://b4.docs.kernel.org/en/latest/config.html.
+[b4]
+send-same-thread = shallow
+prep-cover-template = ./.b4-cover-template
diff --git a/.b4-cover-template b/.b4-cover-template
new file mode 100644
index 0000000000..ab864933b5
--- /dev/null
+++ b/.b4-cover-template
@@ -0,0 +1,11 @@
+${cover}
+
+---
+${shortlog}
+
+${diffstat}
+
+${range_diff}
+---
+base-commit: ${base_commit}
+${prerequisites}

-- 
2.54.0.1064.gd145956f57.dirty

