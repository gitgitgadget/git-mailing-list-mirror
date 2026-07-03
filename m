Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA1E37DE98
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070661; cv=none; b=n6faiJGud6p8CxWbqaoPMh4r5Gqx2Z0P8dwZEk/jlbWJ3otUseP9eah0rfngL6bVZasrd9ed999deoqKB1N3OJM+IiHDf5RPK58xKwkhavdxZHrObtqefLB5osOmJy8KL+W2p5NdF+bfCiC6pq2zx3ERl6pyPqOrA3UI+LV46XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070661; c=relaxed/simple;
	bh=vr03F32QDdwRisxFkWJ3cya1dQ0ZM17+K/Jqf1IIVtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uckJ6HtccTBwOlkkb23H9R6LJo+bXG/Le9PN7O31b78rZJ4sEWtis3xfhzUPAnfH5GeMpoPxk1aqE7Ev0LK7gpYBSVw5kOVzjRNQqm61PKrc7UMy+H+vStg0nWAg2nUEHL6verkwohKZJ3e6F8izvRy7m6V5BEvu0d2sUblkhoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kc/jFfzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJCmBRuM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kc/jFfzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJCmBRuM"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 975A67A00D8;
	Fri,  3 Jul 2026 05:24:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 03 Jul 2026 05:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070659;
	 x=1783157059; bh=lvzsWpBxcsC0AIb7iPQR1BzLE7Mg/GaGRy7dALk2OZ8=; b=
	Kc/jFfzwK7XbbACdviNorKCO2+vUIhmRZbu+yH/MC/wiPyTuJsOSfp6iMJZl1hLN
	2RCPll/BHOkFdS4ZTqMcdIk0EbqVZoyPAaOywA59zkojSDJPtoMHhRJv6MwEQDBp
	N6M0SoW7lUCOYpiP8IgWjWkg2F+HFNCBP0evWbFOh2TpC3Tm2swF+CbrAB1uk5qv
	/mC9ziTrohm8K9HEUnqzO2ifogzcMaZgGNCVqUOBWCL6k3qtVzJTa2zP//qFNJNf
	RlMuIfcYxpo4mBcri4A0cINY5rfwlNEvHGdeRNjJLBK0gJXsRT3BbnOZv/06vihN
	b4nNjsnM4Xlevg2XLxxR2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070659; x=
	1783157059; bh=lvzsWpBxcsC0AIb7iPQR1BzLE7Mg/GaGRy7dALk2OZ8=; b=P
	JCmBRuMHVTP4x3ghSDNfDzZxlmJpwqiPoVwzeCvxUp70GeQyZOLsYAWxR94E3DYr
	OwJajV4lOD9sZa9tldGRgudFJfvB1ypQPBxJ75RZbhOJYRePa+zbxmvVEma+ewRf
	6XEsxLNkz45gKYFC4o1Tt0CIwRkZbe/NQCMk3oZlEYUI6SLEk4/l8twGabdnQedX
	XI/GlJoXWbZZVeEZcg0gx4iOv+itmN/7feaYA/lxuMOY/t/7z3p8zj8VbRPgWvm/
	Gp7nydgJmvu90wBIUagz4yTq//fDQfW0e/J/CxHrat/4JS/LEkaSDIS1giS/gTjg
	esUD/mMn6Ux7mQHs1kj/Q==
X-ME-Sender: <xms:w39Har13dLug82nJSOZUENQmfFuDYOdxYTXqqezdRE401ZfukZ-S4Q>
    <xme:w39HallceV_C553qQ93dXkpclt6crkLQNOXlRoYGMZCN3sV8wOS0SLYcK58klwERP
    10jCFLjZednvaReRRbC5FrbcRrarI9nF5-j2p6KSXBfcmeofEcrxtQ>
X-ME-Received: <xmr:w39HaiVyUYVk_N_akHZHsyjvV3YifkS0JG9wQFDA6sNf1pLVpolifjU5zj9GdvRH7nKjwkOxc-x8EjpcdEhtcIUvzD_k8CBTV2SxT5GQ6A>
X-ME-Proxy-Cause: dmFkZTEfxElqLXwWzqiHeCZ7c9RP+SgGLbOJ4nGPbEDpsgeA57lI2dE6k2FkmsgXXn+9MC
    YjFCcMTwsG9CA1B2vhr28xKHUvSaVRmVf34EP/+mhapmB0qPmeXpm+Gl/g0Zet9OuZyaeq
    q0t+CxJa/z/hmHeZwfzPQC36HpfNgzm51iPiTdYRL1XugbqNSMSzqMwlc5inF/ACCEggh/
    JT1dfHqBkNZ65kh9EW9UD4t40m1GxIE46pHwQVh/gMxL294MgmpPpJjDsTwNEMW7QC3rjs
    Xq6A/vmnvEWn7OPRcryq4qOlhhTQH5KdX8nmQbdyeNT7Ao40HzDQ1TCyWioUS4SMahstuH
    fvNRviaf9VC0tnCnBnIePEeLiscaFeOX/cdq60FLyLLYtRpl7jgSutal/dXStVElz+89C8
    tuIz1ZQo+G6VKixRXygZofohyhFUUQHnocxLjEhtCvzurL0eXSlML97r/ubMxBccH9cKmG
    w0kp/LtDzuoBl5XtZwpLEi+utw4QYu/jtkThkXs2VtQvM79VG0p/if3S1Jtdoy6/pUDpWc
    MgOAgcA8AquBWDx/8vW9C2cSFQEf7yX5iMRGP3+9j4HmRi9rYkcH/ysbFZjmwGzQ1EZYSr
    0mKLUbpZxJeaGe2wxXqxx0jcZQIdFz3JQHHVK6Me17Vn1PUdSlcoxnzPliHA
X-ME-Proxy: <xmx:w39HaruUbHUz9KJBLAv98AH_dHxZ-7YGUie0VsKhHTvbuJ40YjHJmg>
    <xmx:w39HalavO9eIJ7BYDoiIgncBfsb565zuCPDFAQTvHacPUujx2pkpeQ>
    <xmx:w39HaqUzctGUHm7D5GQ61fCxFzGJLAzckrX8QwH4qikmTkTHLZiF0A>
    <xmx:w39HaqR8k3HhKOfgCifHzo0k9qcP0n6DOYDv-Xb9PI5kmagohCTpYA>
    <xmx:w39HasT9gphHmv9dcV2-KEyOQNTDixzI4YyolsLaR87MuAwqkyUA9iN4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb9472b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:04 +0200
Subject: [PATCH v2 1/9] README: add GitLab CI badge to make it more
 discoverable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-1-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
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

