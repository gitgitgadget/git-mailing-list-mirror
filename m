Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370E41DEF5
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205495; cv=none; b=bTOUyKEZkHRVhAI8aZe2vkcZhJZtXVPDq9JDuuwV5aHdsGnNnvmXcimjP4bQV9r2Ub/u4Pv3BZNGS4vZYDBkmQaTfEbDUWHb1MpJ8kcEzx+akTbSzmy5avcfAdaCpAalc6nYaD3TQiJzgZI+2Hoi+BDcVLRDjP8M9PBGQZjj1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205495; c=relaxed/simple;
	bh=W7x/ZfpBdkwB8KZMXIH0+uSDgntM1wHt5aNADcLInVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s6aYSMHB8q8lxjnajQpTj2Uf7rMp/PpCVLxW6pq54oumQaPKZ8YAFerzuD5YbTKr1Y137yGEbQES7S7J15lFZN62s6RgJWkJT4gGDziTNm7aGdGZJ8mFuZw6XzvbxGJFAhBkKOgSTwzB9cJmcaehyjiQwroOjq731GCHbG3SZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZXAMQOmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b/QSOPPS; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZXAMQOmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b/QSOPPS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13AE01400074
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jul 2026 08:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1784205493; x=1784291893; bh=Iv9+aaLs9X
	u6oXwl1POcSY4rM9+lCFrXyi5ctZcJxhs=; b=ZXAMQOmkNm65PSFDGpeaeevBLh
	jHGSfidF7q2s2WOibMEjmHistbw1PgSonZYHcagqvvSy8Ik5HudXbE8o/M8ZShoz
	xnJWC+j8FEJjo3MmYbq0VyngVs4v1ZUS2Y4fVmNl0TsMXPk4oBl2J2949WkyJwmY
	oxMsXw6q9pDCWuZmwbgTywLi72K71mVYl6ASUkquUiV/YBpOodlJA9KhvQaUnPUz
	iIH7YEVYDwa7p+RZNXIHYnn8QI12NV95YsTTttlh76jJwwhspdTF+0CQ3LcJ76UE
	ijl3MW5csM6CvRvVSUDqK+XJ9lIbtNoFeikqAHztUFOKxbQgzoy+BnLSh0sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784205493; x=1784291893; bh=Iv9+aaLs9Xu6oXwl1POcSY4rM9+l
	CFrXyi5ctZcJxhs=; b=b/QSOPPSAlKdnCaGfOWe5jLodpWhvLz7cgk5FWhmdKqy
	ekRedvPPcgC8krlkJKYvL6xs3GWBek2ALi1HpTgzfDOgRZ6V2VPbOQqceTvvg3Xj
	LKJ64dYbEV+NsZlipwUMnf2aLRKiPYAj4wZcOCfqpogKEVqVc8dnt/8djFA41w1z
	bXtLEgytihtfFTmx1/JbN2UE3HryESG9mAzakBGMB+TDnrcP4nc7omZ4GEPtJeUs
	8NlSSA22iUM7sHerCFUcELV8BUW7q0pxBA+aawjHtjEYnNA+FaKiqMQv9pQRaT0j
	w5HFvStWZ3kl54yvW9nvpyAJS/Wh5RDLCgNVvPT5WQ==
X-ME-Sender: <xms:tdBYakXf2DKJy3B4n1BJu94y-TDFlSkKl8z99Xlby-sM4f_kgqjryg>
    <xme:tdBYavgiK89YIwquXG4QvsILGrlgH3iKmHcgMqZKimjpksu9Yz_FImAfgzgCGpTWz
    B4pDvuA5zmTiCSRDggZWzomWJHkEAeK0_4sredVtf24nAflP4RdXw>
X-ME-Received: <xmr:tdBYauAei78QpGyK3xrBcrENs866T-2D2PXtdhdBa0SyuBgTj5wFsTClDk2LXMkYMVhN3huZKKxVINKc7WJM4npdZ_XQXeL2UiAwhrei>
X-ME-Proxy-Cause: dmFkZTELEqCsKwfSmHzQrlmmDiubAxM04jkq7vK/FhLLS+IZansHdw1uz1rfwFV33e1JQX
    BE8wiwvgt0CdX87IftNHzHxSAQNXc64uktRTclT5ydCQYgcYESHnk7hskrSbRrLqPDIOLU
    gWmH/8WcPUtSRs8gFtV70bSLhhBPSBUNFz8aLDuqCZIKqqNLLPA9qqQ4Vy3IDdntnA9vl8
    mVx4E0e6ZDU/mpvDb4isiZ2BFyvciNxsBToekauBLe0uj15KrQq3cZEQCHOd8S2EpJTwEc
    eNRau7e9NXcT8NMpLWX/2RPJxNm/evMp9rgZBNynrtt8txvs3g8RAHHw6eW0tz2MZbrHGo
    6dY2jVfkKXNPo8FARDXI+Ql622t2pA8NkI6675qMv97ukzhmHRWS1zgkYE5VzeVI+DRLQ3
    yy5r52bU86d1b89IhpvzStHDZp6kIJYGJq8T0wwl0AFSQf0Jg2N9Qf87N/0v3xECmVMBLq
    E6ojCLYeSrgqvup89FzRsGYnuOVZEXuMwdf/jVu9eW8X8/IlnczVdRVx4cnNBpYDWc+ud4
    hmBa4WICW3IOYQr4DntRFG4zdTMwvfJESEaHFyY+9AQzNwB+Aj4rzOJFoxD1dpcHD+GeKb
    GYzDh986hBjQce2amMiLGv5xbnUa2Y0RrbHXiBwAo3GnMr7we+ldOyiL006g
X-ME-Proxy: <xmx:tdBYaofm7qpmkEnUhVEWGZoU850GurUHyAKANOfyNOefZBDYFiGyfA>
    <xmx:tdBYaudmbqL26LtuR4e811LMAiX4J_OcUOMh8uAilI6dOS8ptg4Xvw>
    <xmx:tdBYakhHFErU4MqJZysCUApJKYL2MJJBhqU6SjpwwbdJKoZ-FiEIDQ>
    <xmx:tdBYaiQTDPi0lbWTAldHx0QnqluKGZWbhqkIxHiB90y09PrwTx2fBA>
    <xmx:tdBYarnllbtgkRPaV-iScCEZwrx6foBocDFl2mf0-i_52AY7OGxwLm7S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3178af2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jul 2026 12:38:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] refspec: remove dependency on `the_repository`
Date: Thu, 16 Jul 2026 14:38:01 +0200
Message-Id: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJKVCMVzEuoAwwmtCmUxVDu
 LuDLl/y8zcQSkwCl2KDRC8WDouiPBXg526ZCHlQgzXWmbZ0GB+CiUaJ5PEdMM+kjEE4h/RBW3d
 uHCpTNfUZ9BE15fX3v97+lmd/J5+PKez7FzHzDF+BAAAA
X-Change-ID: 20260716-pks-refspec-wo-the-repository-24a6fd303548
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series removes the dependency on `the_repository` in
"refspec.c". Thanks!

Patrick

---
Patrick Steinhardt (3):
      refspec: group related structures and functions
      refspec: let callers pass in hash algorithm when parsing items
      refspec: stop depending on `the_repository`

 builtin/fast-export.c       |  4 +++-
 builtin/fetch.c             |  9 ++++++---
 builtin/pull.c              |  2 +-
 builtin/push.c              |  6 ++++--
 builtin/send-pack.c         |  5 ++++-
 builtin/submodule--helper.c |  2 +-
 http-push.c                 |  2 +-
 refspec.c                   | 39 +++++++++++++++++++++------------------
 refspec.h                   | 42 +++++++++++++++++++++++++++---------------
 remote.c                    |  6 +++---
 transport-helper.c          |  2 +-
 11 files changed, 72 insertions(+), 47 deletions(-)


---
base-commit: d35c5399e3e54ac277bb391fc2f6be3e816d312b
change-id: 20260716-pks-refspec-wo-the-repository-24a6fd303548

