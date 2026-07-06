Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996223CEBBD
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319051; cv=none; b=TUk4Np6EQKSHf7yA4rov41w0w7IZN9qJH/v9zwQw1MBBFMSVvpJYjMk/xbUpTi7xcL2JpwTyBLg/wQtCopJc1q8OXLLt57u6prPt4AaNjTBD5j18xtVnmK331oE1kEIzIpIhXYIBb0CByPavLVeNyu/rilFSpKdIlyVGU9wdqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319051; c=relaxed/simple;
	bh=vr03F32QDdwRisxFkWJ3cya1dQ0ZM17+K/Jqf1IIVtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqEFeKPYcLqOJumra5GJXiFd6B2s1X5EzXHCMYO+hF2JTdDO6v61r0dE/Qk2qJy8eSHqS69xnLED3+9HUU5HzI8O1h768vczEQn5/RTKUW5BYQaErYD7FGPgVEQCenez9nlLuAph+TH953oR2qOI55CiuBB8GoN6AbbjaJdyHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FJJfK6d5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B58wVe2U; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FJJfK6d5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B58wVe2U"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D03927A00EA;
	Mon,  6 Jul 2026 02:24:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 06 Jul 2026 02:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319044;
	 x=1783405444; bh=lvzsWpBxcsC0AIb7iPQR1BzLE7Mg/GaGRy7dALk2OZ8=; b=
	FJJfK6d5mvxf4Ojz5QZ9XFul7m/bPl5IFnY4jB+GcY5mH3DatnndKuMugC1OppJ2
	rj5ekA41138S/1clbbHvIJK7+IbOVeeBO3lINQJpItnMYydDusVw8rEtcCWAW6Bu
	N049HjUluCRmrHkBpdJ6H4i4px5xh149rChGL3wWiHQPgugisN0a0+70F3tf9T4/
	tAKcWf3W3d6+BvpxHmwAbZ4CWWm7HhSmC31KYNKh001h30kKRupvLOxHZmTh9h6F
	KXgbikXj90i2CZz33Bk7m2uXaOrz5SkELXVc43zPsMBjHbt2FpZBKbD7mOvKwZ+u
	k4m6xtf8KYZI/gTrt2qEmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319044; x=
	1783405444; bh=lvzsWpBxcsC0AIb7iPQR1BzLE7Mg/GaGRy7dALk2OZ8=; b=B
	58wVe2Ua4blE1WfddsShBkKkGTESao3FHpCIvSccNtqaK55j1cLkLfxBQKbuwcM/
	iaZs8CwuPqe4byMZFLgyyPQIEf/lk4Frrm91CcI9A4OXZN+WmVySR/F1eynHxFU+
	h1lfrmbvXcHe/x4t0Gw0yJnMQwMThqsoN7GOI199Ykjtt1h3Nx8GkQyl6lps6rCk
	XCfCLbpxX392GpXh261vKhivUMZuYSDoB7kY5Xfpa1z12d0h/orUNIZwDf2MHLNZ
	QYVklDFHvikTbS1/HcDi/+F9nqjeup6J8tSOyv4VYOS8y0Iyo3xBFwDBfHmcAk97
	SkdKpcJJLU57PDbaIil+w==
X-ME-Sender: <xms:BEpLarFLAMEE2S9IOHmAk__Gv5XC-a_d7rsIQ9yyKvIowUlIssQxng>
    <xme:BEpLavMmetGmaUNvkEWyB3xqErW0BcGZGS3OC1TMfBxsn3638uMtyjlOJ2VM0QFBD
    B5-eG33NK8L0_ojdWMjKfgR70H-FfSwa0zovuflNUvxrW0eZzBzMg>
X-ME-Received: <xmr:BEpLald6FzW1Jp0B8eHPpBI0HGHGCv-ZAI90pHyDCQozRhiiRQKZ8k0bRXIba_Lu-Ty9fR5zQLNdl7yjbsZy2WnK17JjpxcYJe6ZWDkzxb0>
X-ME-Proxy-Cause: dmFkZTGejZaeofRKQvcGjHp0MhN/v5Fg57w5Ahf/VBY2zh9ZoeAwwAGkMcoFph3J7Bm4pY
    ZOZzmdQmpDS04POmvIWqFKgPGmN1GthhExVLjIBI6uJzOOaR/eOerkkXmu2qh62E2U3N7M
    UvEvpxaEi6qD7zhJuKVO72qeR3rrr+jns7SXChu9gexR6DCPqF/zPnpGoY4fp0soU8tRvC
    kRhaYo/Q86HLUuoFHADF83KuG2DWEvhiFHS5FFh20TYbBWXVsDc+l8Do9BXilGuQqBBDsD
    pwfDFdCkoDBb/yKhPjqhedWAsKMIREm5eEPm4y5sQK3qSHrjY9qBNtosm04pgbYO+xhza4
    ExyobU3tlSApdZdIbaULEyPbAobpLEivmJljqnXRr5lhcQ9z7ELdCJZStA8d+0XuM5a6z0
    ULA6y/L2MxJntokuNbzOf0M+n/E9xhPza/bsy/5iesW6AuHdNff1IZu9uBSmg/pCQVpG5e
    sC49FvnHFfu6En0jtZnTPyo6IaHfC09RxMTYh3fiGBwse1CApt1swqZaSlzf6iaQYh8gmM
    8ojRvy1ujiR4cb6ebWh7gDaw8ut+N/LDwOV6RwlhRj4TTKp+zh96xIvMwa1Ys4xKdt4AwB
    yFRCgJX03IK+/GO6LNwwKpfhIQ1jxcuB8pyai0lnyKjGvg6Itqr3lwKWLTjw
X-ME-Proxy: <xmx:BEpLaktrvnLqC5Wo-gz1Xe0ZbrO0hGCqf_Bugo8shqubi0_HuY_ODQ>
    <xmx:BEpLaunNshfhy5FjImFW3wGxgPjhND7VnylCTNUiGwb9I0kkKMLiOQ>
    <xmx:BEpLauxb6aB12hrnPqm5WLb8iCePAE9f9TAw6-_ZaccdhpFqlTNRBw>
    <xmx:BEpLaoNzu-f71WjGiLEMjRFS1NXtBnDJ3jhnjGvE5TI-zDTd41Cs1Q>
    <xmx:BEpLauKaNeqDfqbE90HWlpj3WBSbPDIwo7w8vbEQiEkSY1bD65wWlfoU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 01edc8c8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:23:56 +0200
Subject: [PATCH v3 1/9] README: add GitLab CI badge to make it more
 discoverable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-1-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

The Git project uses CI systems from both GitHub and GitLab. While both
of these systems are extensively used in day-to-day work, we only have a
link to the GitHub Workflows in our README, which makes the GitLab CI
hard to discover.

Improve the situation by adding a second badge for GitLab CI to our
README.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 README.md | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index d87bca1b8c..46489b0971 100644
--- a/README.md
+++ b/README.md
@@ -1,4 +1,5 @@
-[![Build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![GitHub build status](https://github.com/git/git/workflows/CI/badge.svg)](https://github.com/git/git/actions?query=branch%3Amaster+event%3Apush)
+[![GitLab build status](https://gitlab.com/git-scm/git/badges/master/pipeline.svg)](https://gitlab.com/git-scm/git/-/pipelines?ref=master)
 
 Git - fast, scalable, distributed revision control system
 =========================================================

-- 
2.55.0.795.g602f6c329a.dirty

