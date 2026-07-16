Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D2C410D30
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205496; cv=none; b=Aa+0BOfxJXy8pkjlf5FpEV8tOyNVEsovd1rJX9Aw2MP1HqOe0JJbc5fOqGCD7k/tCuQzMe0QdT4guvHC6uE/6M5PBUUkk8BnF30htVTuhFM6ZYB2VGbzcGTSwOBL1E2hOs36A2HIFbxvot48mizSpvwLcm2PE+K0o5GTIVoiDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205496; c=relaxed/simple;
	bh=ehC/1vZYZEfKUbynXJqAPMpLNUaAa8dd1rm6zOLnSUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GT4vkhEKHNYA7/PJcDg7cK6wrhCf2ey1VGGRYzOxVlV444jtrWXn8BKRHTR2MdZ3wIrrL/EuZ19PlPXYEVNF2Z15QERtw9Fi33fpJkFDACQgf9TviNe4l0H/igsR8Acw11wvmKdZkiHa/5g57e+aMeQRBAsY9Qx6L4cgQ5lPsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GvyRhKwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pBzdMcJs; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GvyRhKwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pBzdMcJs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EF05EEC017E
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jul 2026 08:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784205493;
	 x=1784291893; bh=9ufar+WtvWMdMN2jyipzL6X6WeI0XsKbYDwS5mA4fZU=; b=
	GvyRhKwlQZSOBHCcBD2orUATOxpi1m2U4H7qtZS0cZXe/EfHxrwFW4LVIR7NVZal
	OrnSXdRTty13bU7daZNp7+ljsjXIG04mbJD8pIEbUaTA6Sbd6eEjKDQ1eyIjwXaa
	v/EFQSYNBIGM+S7bRBT72KqPJ2WJxpflZwkdSsf9PfSNRU4bSRk1uAmpVzc4AxrZ
	90jlICi7E9A+VBxGAVqzc9hgqXLVS80u2GDDEs8IrDrI2zZ4we3NXhXJjafnoreZ
	QmdDjt8Y5OrmvdiH6eqGcIENk+nOtRuFJOkBeNZxmUIbbDyh5Su7CF6JNdToE+FR
	8cG6gVyj9eiIT3kuzdhN8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784205493; x=
	1784291893; bh=9ufar+WtvWMdMN2jyipzL6X6WeI0XsKbYDwS5mA4fZU=; b=p
	BzdMcJsb99RdbguO0M0va4guoZWWBefwoltYlqjBEDaqJfiLj6Et7c/FsbeLwA7K
	lj5Rf4XqTu4SJf0Qq8biuySkXmncO7/kw5EDoauxivnuxlK3tZhdtFNJ7VmDU7lF
	eJWenCmdK9fclQDsooazMnzHymRnODF5ATqXsNP5mgX3PB3z7lUbim8nqGnnw05m
	IvbXwza2TbX8ESMH+AjrVT/GWeM1WcadIElEwK0RLs2pz5KpXZFEFBXEc/0w0BoB
	oZKWj/Npf1uQWaTjQz7Ke/vW5JMt34Y7531bMBra2nxV3KiuWb7XNZxOK6xKd9uf
	GkN5nOvGJLIL4v82YSqog==
X-ME-Sender: <xms:tdBYaqT3KCZDMN8eeKjVNtBow6YNpP0V-I2JWvGqNkDAGnA3AkStVg>
    <xme:tdBYamvdvjdbp9clAqf_rScedES_rjNdXYQr0XToZdebDBUkStMlJxZcYL8M5XKsq
    higoGHvhS8DCAhFYcUyGI6ySPe7EvlllmgqvVqSsxrJaa72dQmoTA>
X-ME-Received: <xmr:tdBYatfT-JursDsNeSXEKeMbZC06bSfuLZZy8u4tsybnPa4So8ldpkeb3N_xSITSOzMQ7RH_gP4MeVStKdpOWr8lv23tOJuarYCEyh-k>
X-ME-Proxy-Cause: dmFkZTEz1lpuhwAwq5UCwI/1Bs/prQsRBZGNgxNHjpAbj64iYIYNHhUktzNABdnbeBGlau
    rcZQucpg2cGuhmAx7a3A9FM3CV71G/yvew7BZl5RmldAR13IMKPvtNoIQCLfjJ+8WnQ/rx
    0J5ir/4CKkWPFUclrDUa80qC3oRBx4IHbJkrrarVM6pi0AIeJIGIGNY+bC61q947VeSY0I
    3tx8mcnza4bntrY5H/UCUJ0brNtvhkwZPtSm4cZvastLrUD5p8GtJsQ+R+boyqk65ty7Xj
    1W1+rjc919ernMTi8mlHfO70+RdwOdOAaHiqp9uFXAQiHwVe6blCLdrZzboberPWvH2hOh
    OhYMRTD5FVVKUjL9RYxAny/6xusRS45mAhEbqQnEIw8/kxe7gpgBwi5PR3lCmqRIRUxu8w
    l0Ut07vybcTM2OrXo+VbEBNVfpF9F+wSx48+Ju8IABN8eJMqMrrfSYtCT9f6D5HZEORv0Z
    yj7MHKgr7vllYqYmS5oytsFT9w3XJaaxtNzNb0HlX6qE+eGwK0VzR+xN2j9gHDRPjgg7Fw
    Hwjpv4G9y3qreR+nwDVniUuuihqBHL7yDTJASemqzHgiM+1C80e45mE8FKWbDc/O9fDs0j
    kCJqfFjahWL2cz6j0kH6zNWwuuVjelmybiEqc+BJ5uDmDCrkoRdmDJo2XoQA
X-ME-Proxy: <xmx:tdBYarLd7hvUB9JOb4OP0BDQhmK1Yzx4WlAY5w5MEBKC0VWa0oU17w>
    <xmx:tdBYajZGH92jNNTdzl-2r_k880rREHV3agmii1rcUurkASVZltSJyA>
    <xmx:tdBYautV2I7WAUOEIXZ7tWeJ5KGj9YeRmfNr0CmbdsjlI7gN84CBvw>
    <xmx:tdBYaovA8Dym0Sd3xzgXhJTJlQJRZnBSJovRJChFP4eEqfiV204-pw>
    <xmx:tdBYaqT9_Ys10kR4RIaU2WLph-HwOZGy8mL7DwhjO51zVb3DSjUBBr-z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jul 2026 08:38:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 755107b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jul 2026 12:38:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 14:38:02 +0200
Subject: [PATCH 1/3] refspec: group related structures and functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-refspec-wo-the-repository-v1-1-aa40844d067f@pks.im>
References: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
In-Reply-To: <20260716-pks-refspec-wo-the-repository-v1-0-aa40844d067f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Reorganize the refspec header a bit so that structures and their related
functions are grouped closer together. While at it, fix a couple of
style violations.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refspec.h | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/refspec.h b/refspec.h
index 8b04f9995e..832d6f923c 100644
--- a/refspec.h
+++ b/refspec.h
@@ -1,6 +1,9 @@
 #ifndef REFSPEC_H
 #define REFSPEC_H
 
+struct string_list;
+struct strvec;
+
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
 
 /**
@@ -30,10 +33,9 @@ struct refspec_item {
 	char *raw;
 };
 
-struct string_list;
-
-#define REFSPEC_INIT_FETCH { .fetch = 1 }
-#define REFSPEC_INIT_PUSH { .fetch = 0 }
+int refspec_item_init_fetch(struct refspec_item *item, const char *refspec);
+int refspec_item_init_push(struct refspec_item *item, const char *refspec);
+void refspec_item_clear(struct refspec_item *item);
 
 /**
  * An array of strings can be parsed into a struct refspec using
@@ -47,20 +49,20 @@ struct refspec {
 	unsigned fetch : 1;
 };
 
-int refspec_item_init_fetch(struct refspec_item *item, const char *refspec);
-int refspec_item_init_push(struct refspec_item *item, const char *refspec);
-void refspec_item_clear(struct refspec_item *item);
+#define REFSPEC_INIT_FETCH { .fetch = 1 }
+#define REFSPEC_INIT_PUSH { .fetch = 0 }
+
 void refspec_init_fetch(struct refspec *rs);
 void refspec_init_push(struct refspec *rs);
+void refspec_clear(struct refspec *rs);
+
 void refspec_append(struct refspec *rs, const char *refspec);
 __attribute__((format (printf,2,3)))
 void refspec_appendf(struct refspec *rs, const char *fmt, ...);
 void refspec_appendn(struct refspec *rs, const char **refspecs, int nr);
-void refspec_clear(struct refspec *rs);
 
 int valid_fetch_refspec(const char *refspec);
 
-struct strvec;
 /*
  * Determine what <prefix> values to pass to the peer in ref-prefix lines
  * (see linkgit:gitprotocol-v2[5]).
@@ -76,7 +78,7 @@ int refname_matches_negative_refspec_item(const char *refname, struct refspec *r
  * Returns 1 if refname matches pattern, 0 otherwise.
  */
 int match_refname_with_pattern(const char *pattern, const char *refname,
-				   const char *replacement, char **result);
+			       const char *replacement, char **result);
 
 /*
  * Queries a refspec for a match and updates the query item.
@@ -89,8 +91,8 @@ int refspec_find_match(struct refspec *rs, struct refspec_item *query);
  * list.
  */
 void refspec_find_all_matches(struct refspec *rs,
-				    struct refspec_item *query,
-				    struct string_list *results);
+			      struct refspec_item *query,
+			      struct string_list *results);
 
 /*
  * Remove all entries in the input list which match any negative refspec in

-- 
2.55.0.313.g8d093f411d.dirty

