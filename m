Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D239E9D5
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252231; cv=none; b=Yh8QzPgV9h9Y/1bRUFXsI41W4V6X4tEgOncwnkcgiexduKpBdExt4zqNdLQygCXv9BLMihJfYucjm/a1HpU7vCEtguEgouxQ5xzkKfshKY7lq+QSmjyoniRFWjAPHcHSeYGCFbTZYdFNLesmWCeXrhUiMqiUTutl8TYLFOYSWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252231; c=relaxed/simple;
	bh=hfteQ79bmiD6DqoNmKZyeQcPrOMI8YpUrq/eLV/UDyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaYI54iUjOpCC2NQjqM1ttsiByaPpa5nYojgoFDPjsd5Fqljg5bu2CVMy73l+tSdFYLsGYOR9bhS4zp/jtsNbbC/+pe+XKgmtoyPCJ6FIo/HPHCF+t40ncMz5IENCI+/LApDdGAelRpcpdTqofEYcxHzGblJMquHUpv+03mvT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QN8jzEXv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDDJicD4; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QN8jzEXv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDDJicD4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CAA357A0141;
	Thu, 20 Aug 2026 14:57:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 20 Aug 2026 14:57:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787252223; x=
	1787338623; bh=9e+GwyluL+nAB4fDLcyPhqezmcDqsDh7D4EdhHiro3s=; b=Q
	N8jzEXv6iHWnEyZzAK0Nfw3GtwmP/b3yHeBAOiH6OOJKhth+VU9rTJNrrnWU5iXk
	B365HQHrfVyeXwjXuxTNfibNecO6FV0eZS60qDBWa2KFnfws1GOty5qYi9SrxlT2
	d6d6wKh9NDLqgRl/qiZzKb3uvSsBpEECuq9teeHUBkZrogVXnqkVg5utVYKkosfr
	k2ujh7j8ZBhKAcSmaoFyI5OnobSsd6H4SMGZp7f/jX2grLJxI9a0hOfa/kjra0Sf
	y1fQ3BPivNwKqp71gmo3cqaWrZh/IlUTvIbj6FB1FLpr0QGm/fhZ6/gDt+RMGZpT
	xUENPCMlzt+ViE3HzwxyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787252223; x=1787338623; bh=9
	e+GwyluL+nAB4fDLcyPhqezmcDqsDh7D4EdhHiro3s=; b=lDDJicD4CjVVHtbb7
	jVhyH9MBaxgVpovwfLs9CIyP3hgGnscxSvG9su9/Fya7ZBDbZ+kYOb+U3w9Qwhrj
	Bt45cGpayviFqRz3R2Cst/cCqErixn3iUVJw5fdJNXMm0fia+/MFdz+RxbzZzKTk
	havPeR2SgDPq+irMgJRKzk172ZtScx0FoxwLpisK4ETzb8xiY6hEWJM68mXRDN/f
	2mhUWhTf5kJnzIPoc1mlmsa1WtWNcFiQnlf8c7pC8k6oHTWSVyZj/C5MYtV/1bSo
	ZkJDKwbdKLiq18b9g7rEX9M4H+iaIHrFtrPARW3Pc4/JvBZVhdAJvBF7zGdvAtg6
	syPgw==
X-ME-Sender: <xms:_02HapurMZr2n6BsTgn51YzekazjGHjV4x6QmlMezee6CPFhHR0hWXQ>
    <xme:_02Hap5KCZbkL9STN1f0IugOqcuSap-ZZuoMj2PoABpzYEzBCdZzn3TRxOAicWlpq
    _3AA_Gzn9ugUiCPH5vaSfvJHK8MqSFt8P1SwRJXpPmnmKDT0H9HIQ>
X-ME-Received: <xmr:_02HaqLBJD0Lf5VcAZhvQlPJiTOY0t4u_V5I5A1jCrF8GfsTvz08tvnl8oG4pyQs9fYUPxai3d9dR5kkH5ILBDNLpGTP0EHKWuPWoix7VG0X15RdjuNrwlI>
X-ME-Proxy-Cause: dmFkZTGk+DhYl7Z4N4mHID6Zyd4JeB/ObpvH8QZTXeEB5L3TA0RQEcLGqJsAwWpZ1y7nS8
    LjbHLm//8t2IlIw+S773LGW9Ndn1YzWiPSTpXnzFHsJhXQAWSfAEhpQ7Jck4rnwipXT+g5
    Yd1w9+gFquLwJ/8NAe6ihUbGGD5vJA6RStceCIFrVhgT9tu6Q6B2oVVhJatjJ4phkkEHW9
    j9+k4x/IZAkCQrB27n0IzSJJokVSWq+hWLzQm76VeNUJ0eAjfRIdS62O5FqpKOVLA3GlpZ
    tTGibq32AjcmMm1voEDjFAaMRBWCADup3b59yKFFS1fRJviniiCkgovvUUjwGVHpl/Gxb6
    muN7B36b6XFPQac9bxt+rjzz8xPufV2JXXf+ZmP42La9438EqPx8Gc/deRuePz32KwKPAG
    ln4bs9tF2Yk80fxiYeuVTjKzIac/fqGzNd6Ruac4vcwKEwQa94VYCrl+Hh6vcvgChH6Da9
    ZrQKFiM6OyIjtJ45ucPx3TY2I+AOk5KcDkQRb8jpr6w19ikPZdsxGRERGaicdcMQB28dbt
    +bWLepseDmGE8M87Qva4f6bbhUdC7A6IwakVAZy9GbGLHQUjwzxB5f4C92Q2weUg9MiSii
    Dkgve9pJFd2+9a7CUeJV4dLcWFW+JRp1DusxD2sDMyBGQ974/LzNg6fHe8aA
X-ME-Proxy: <xmx:_02Hap6BwPR0jtIjApx_mOOIUEQ_vXDpZjxd937qFUGxLnfCaAh_6A>
    <xmx:_02HatyfdBZJZ2irlRP1h2_PW2_zwwkBIxyXgG6Rwpc2Fe8w20EL9g>
    <xmx:_02HatY5qYgmrVFgWyy1OeBJ40HydEKtdBM9yhy5m5wSx_35rEXDsQ>
    <xmx:_02HavTtHo1FDR9Vh17foBR8b1jx5S_SLwmtz8Gk1dUcK2kSpuaIqQ>
    <xmx:_02HaqBfBLmJaTe-S7U8FlMJKbxzZXkU7q79Xm2iuFYdzXaUNd7yiuBt>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 14:57:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH 4/4] doc: datamodel: link to the glossary
Date: Thu, 20 Aug 2026 20:55:24 +0200
Message-ID: <datam_to_glossary.bee@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <CV_doc_datamodel_advertize.bea@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We linked from the glossary to the data model page in the last commit.
It can also be useful to link the other way for readers who might want
to reference more terminology.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    But: maybe the See Also link is enough here?
    
    > a comprehensive terminology reference
    
    This is descriptive or aspirational. Either works.

 Documentation/gitdatamodel.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index dcfdff0346f..d588630e633 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -24,6 +24,8 @@ Git's core operations use 4 kinds of data:
 3. <<index,The index>>, also known as the staging area
 4. <<reflogs,Reflogs>>: logs of changes to references ("ref log")
 
+See linkgit:gitglossary[7] for a comprehensive terminology reference.
+
 [[objects]]
 OBJECTS
 -------
@@ -300,6 +302,10 @@ $ git reflog main --date=iso --no-decorate
 4ccb6d7 main@{2025-09-29 15:16:48 -0400}: commit (initial): Initial commit
 ----
 
+SEE ALSO
+--------
+linkgit:gitglossary[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.55.0.13.g85d2d65e389

