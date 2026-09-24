Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AEB346E59
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241581; cv=none; b=BFdR0SijlNUZvA2Lu1K481w6YVxlKOquO3jxa/S8dUtlzCshDxZVlV54hIe+nEADB1jblk+rFao2ZyFKQXs3djgL2tGyZGGjEcxWLC87SIUeutPB/SSwiiV6j6+bFOut4rp5H5t4WZqqxSCyDcUDZFIBbojpQxFyx54MbQTlIkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241581; c=relaxed/simple;
	bh=kAakvSZB1DfHp6X6kD4pxxRsyBaPFzU1arh17IFtdtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FzqDxYXE4BlcrHLqhAy7JQAR0iOgaL0PkdYB89OviT7nrpcrxna/yizfCpED2tVeJupk/2lhNSE2U/ASi7oIsnOcXzXXHnVlvwUhMPwJOqcyY2BOTkRiZG9SbiF4JHeE7dNEXm1iL6fRqKwzBDq+ohz12kmWLOf3DaJJmCC92Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w7Oy83+8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TJGHLln6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w7Oy83+8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TJGHLln6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F23F6EC00AE
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 05:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790241577;
	 x=1790327977; bh=W0d2Z5VXq6etkEp9QSGVyASsKrEB3JDcDE/MxYeMN1A=; b=
	w7Oy83+8y+TBZ5pARpEyOf/tGaohuoPObV5k0vCIYzDHQFRgNHoUvIns0spaDktm
	Teh4PHmjFvbli5OUj3Bz8U77clIAB25RcRMUdvrXZanUEivHhVjL6XRK7Xx0EAQX
	wKD8HCRxw5khb4L1vtZoC2rOKhLdaw+SxYPTJ4ed0zeGQYvR5dk00EnPyVcw8saa
	2Zb0BpSW3y5eM0QlZzy6qwCpcXXrJ3a4Ok42v0xhBLL7+BehUuDZyB5citSrbYPK
	BekREmsg6+4bmAcNsVQB6NiEjuRfzaSdme+oLgy/zghMu2ffluVwUxyU+fVD23Sl
	8s6lKM5XnIW4onN8pom/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790241577; x=
	1790327977; bh=W0d2Z5VXq6etkEp9QSGVyASsKrEB3JDcDE/MxYeMN1A=; b=T
	JGHLln6LldwsGi0Nwg3PoR702H+X4ENIgNl6sUr7t3RdbKq6S3DOLX6C49EXQ3vX
	KMwQGLP0M+yEFHTVnLnn9AMiWvLzl83LbOkLRdUT7sAuwhN+KSJ0h/SYDF/KjmWh
	S9oC4LB4VWgkk6LTCZYE7twSH0/cUtCkuXXHpdInd3ByXv9I4/f8xB04O2ieNxoh
	+cLA0Z1MmRmQznOl/ah9d1W5Vd6J689cokLdkUrfcTOvGCSPKKCKvFxNQvTqAjDn
	C6o+ktpWR0P8bfgrV8KxP+eq8nEuZNn3rcpu94JBTG+cd73pgLzDWhg1IYrelasL
	GCthcyYM/JFBjC/iyQ0Mw==
X-ME-Sender: <xms:Keu0ajelyM1YRR5zMlkQD1aRrMzuyXlyEUCOMLQQabb0ZgiaDP8yxg>
    <xme:Keu0agLXMYqGRDHnacd4FYQcvoK6-9mviGusgW7sj5KghCH9rCyt2TVR5NqFjS6EM
    MPqGLOzBkWjRNpyIug4zhLY8SHSqTQxU_o5cbnQgQu0Ff5WM9T_aJA>
X-ME-Received: <xmr:Keu0aiLDXgw4_N-2FMm2OdSoO6wdhxgFe9ECHxfZkLHY0UU2N7Kpp0AfF4U8iS5cOtWGcCY>
X-ME-Proxy-Cause: dmFkZTFPodOiLWcdqf6sGstU46dIiqXidIFd9cR4fooPG2VzhuQs4sgHwSSL0mI+zYrJki
    puKwTM6PzOLvhrOnHha7/ZqJXKFWeUZ7pL3PmhkuvlpM0SAOkWbZk3xZQvHRMhKdNhwt4b
    RD3a0i1KaVTQhiwtqarc8pf3XfoXA6W5MTyTZacFoe6F2umLNsXJ1ouYl3pIUvkblQZagq
    My5ETPa7FIKiTyNS2see97qCZqfu7GXNWEANEz90j9Xl651gCUX4FzvDgltnokz25gMaTM
    HthS5xNHFJNXlc52D+rP6WxTTQ+lRC0R4uRCl7fXgiak8N0bh0v8/Rl7rSKJ4fouMiwlld
    QT6h/gB6b9nATHx+Z3/DWOYJERTu7FXhTuwucjrp2VbnpeL88DU1mUJgvOSk7ebor8Fztz
    /oNTwLJGTKN3rreY/6UCZlNTkN8SyEyIWm9VhGQNsAPXWSx+2qS8QIyQJq2VE0kyhfkF2T
    TC5XVu9Y4+tO3719YnwQFtztCS9cOV1gwTrzaZcbGzBl7obuzovwoSjPKoBA8wM6B3wHfg
    5ZRDrZ3pKIm/ZHLeRmwbvGHaIMjOHKxE7pBk3HNoObXlE+7Y4uO1HuZj+6noz/603jQi4S
    4dlIaCjX2pHZPMr4pJ9e/ofaOtcxDhLuZS84VbMQ9JmB2/L85PaC8VX1TyFQ
X-ME-Proxy: <xmx:Keu0aqEidy_nmNnnLrPbiCXH2hvfJa4HuOeZo72dvJF15okW8G8SLw>
    <xmx:Keu0avlZZ2ovnzLV2Z26PXhKddA4RQnS_kWKfTPJYnXJzR1u636Mwg>
    <xmx:Keu0avLxDco0AjlJpumepGgOgjHRsOkcFoQqrQ6st10VhYOduYT0IQ>
    <xmx:Keu0aoZ5ZoWQtJGfFZc3BEJsAAheXUaVgaPSiaQDJcIkZueWlUfzHw>
    <xmx:Keu0alNcbW4I11FhtAI5z6gIqjIcqVHoC9t-HZI7pGWAwanA-7JyQyw9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 24 Sep 2026 05:19:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 43d52ce5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 24 Sep 2026 09:19:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 24 Sep 2026 11:19:19 +0200
Subject: [PATCH 1/7] path: drop useless
 `safe_create_leading_directories_1()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-pks-create-repository-stateless-v1-1-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `safe_create_leading_directories_1()` is being called by
both `safe_create_leading_directories()` and its `_no_share()` variant.
It is ultimately the exact same as the former of these functions though
and is thus quite useless.

Drop the function and inline it into its callsites directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index c3a709a928..69b06c9464 100644
--- a/path.c
+++ b/path.c
@@ -829,8 +829,8 @@ int safe_create_dir_in_gitdir(struct repository *repo, const char *path)
 	return adjust_shared_perm(repo, path);
 }
 
-static enum scld_error safe_create_leading_directories_1(struct repository *repo,
-							 char *path)
+enum scld_error safe_create_leading_directories(struct repository *repo,
+						char *path)
 {
 	char *next_component = path + offset_1st_component(path);
 	enum scld_error ret = SCLD_OK;
@@ -884,15 +884,9 @@ static enum scld_error safe_create_leading_directories_1(struct repository *repo
 	return ret;
 }
 
-enum scld_error safe_create_leading_directories(struct repository *repo,
-						char *path)
-{
-	return safe_create_leading_directories_1(repo, path);
-}
-
 enum scld_error safe_create_leading_directories_no_share(char *path)
 {
-	return safe_create_leading_directories_1(NULL, path);
+	return safe_create_leading_directories(NULL, path);
 }
 
 enum scld_error safe_create_leading_directories_const(struct repository *repo,

-- 
2.56.0.rc2.329.gd58861e689.dirty

