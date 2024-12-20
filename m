Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450C22332F
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723893; cv=none; b=Lu67RB7TEKQqUfrTVXxSwTrzbg/LLgoAdHZ9stpC56T3OfjugPdtwb/wxSAzjprTHdlIaOz5cy/RwZOqMWTMxP6twoOA+19s1aFfxJOV0j/rIbdy1XEdTV2YPtCRsCFjraLwuHjS2FbtDHv3HxDcnDpbxnFCVTOFwsWu2gwFifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723893; c=relaxed/simple;
	bh=xlwYu45PLvGxAt3Q6xUnrIxlyygvkVMwkzeqATr84ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMHRdHwYguWpq/2xK2Q98R0Gb398tVJGBSncExVQryCMemOZmDFgpJew56pNOvznZg+3kbK1n5MBlW4j1ZSvFze2hO/Fn643zh5HekJv/lpAZsW/4uFJPKuxh+oPk4ap5TipMbOpaoaqPM1gbTYTTQh9yqsktWeRx+N5LAUfP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w6ca04mU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4r2O0BCS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w6ca04mU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4r2O0BCS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 78F7C11400FA;
	Fri, 20 Dec 2024 14:44:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 20 Dec 2024 14:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723890;
	 x=1734810290; bh=xcYawtI5xgcx+Ciov+meI6WtNRDmG9hTD+BB2tgmuL0=; b=
	w6ca04mUxOcFKAkASjgOVbNlLEx6iRGUVGAQdBuilIPed8a5QJEIi9Wd54b97AJs
	Zs4NQ0f7yD9WnxN8n2i9w5Ye+w0cGsSK/wmFU0OaTjnzjvDDw7kpxUTigtvpcWWk
	VIQLpBFdmOTuDeJa6/LSI82ieuWrBsI2PwviZaU+kK36FzdXrJ69xsIU7CmeO9uI
	5TUaOlIpf2HiyqKJmWxjUEyRuqbis44rHfSaSo2ZV4/tnJBg89bObWG6sxj9i2N9
	Dg/pJ+YQz59oToCZSRxSd/UvlUqKAfax/FJ/j+fh4RsrQRqaXsvJbSxQ6o6dmaGn
	86SAwsYRB7B1X2046vhQew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723890; x=
	1734810290; bh=xcYawtI5xgcx+Ciov+meI6WtNRDmG9hTD+BB2tgmuL0=; b=4
	r2O0BCSRW93DqJxeF1teRzWEILsFtHmG1L/V1XXT/RhY/Sh2ze/0AmURmppmI144
	HS1b01SqpV74UZOlcjjp/okEiR2dZqqvnbK3vzbKigcNSsSQUIjXb8ed4H4wQ4My
	0Z5JI7WQO7bKAe+u4pLE2+ywnwiow34TbFg6uY35/1NzExSgHtmK6THT3ynS8WMp
	ew+FmQ2V60L3niSN8lKsjCep9jnbB9a7mlJFHhvMGfB38BciLAap0WkLoYRJGOEj
	O9q+fNhP66AwYm68CAv6ZbEkjq5y6lh0nmxmyIm9SFW0lwqOTwIJAAViv0totyat
	6ssd+h+CWGscKNu1RRPTg==
X-ME-Sender: <xms:MsllZ8S3ZXxwbqx3gsyIYO_CwJNZtEnWnJoa3w-Pw3p4EiC9lb8jMw>
    <xme:MsllZ5xyDwP0e6nFahheYFEbok43vNkstS41ZyrI7mIvqpSGwOKaUYw6-gvZ0N4xb
    mUvdLki_qoOXrZltQ>
X-ME-Received: <xmr:MsllZ51MvBXl4Bd_n-ksC0lxaD8-yciNIJblFNOx-XDqtnBi8DbOU-AOTSoUqhcOujNk03SHDUf1W8yB0C00BK78t7DJLrDu_QKEwqgE02LXc8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsphgv
    tghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MsllZwAZoXnEdSUdO26tptbaebAxNSOiHUY06QKg3hkR78Fx1cWE8A>
    <xmx:MsllZ1hpUc5h2-IuWQH1RmWtrzlWsMJDYVS5ok4rOfxR4EMTQH8SKA>
    <xmx:MsllZ8qGVevAcC_LJBN_-GsVKIdq-YwRNp95J92nrbvlZs_kwcy32g>
    <xmx:MsllZ4hxWeuE622FGHDfSswtE1sO7ZnF1jijzRZaTO0z1e9wnYiTeQ>
    <xmx:MsllZ1eppBnK3ghJ88rJjXRP1wfJUGRLZXcOGXSLDyVYbRpQHg5U0hJD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89d06767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 20:44:25 +0100
Subject: [PATCH v3 5/6] GIT-VERSION-GEN: fix overriding
 GIT_BUILT_FROM_COMMIT and GIT_DATE
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-5-1fd79b52a5fb@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Same as with the preceding commit, neither GIT_BUILT_FROM_COMMIT nor
GIT_DATE can be overridden via the environment. Especially the latter is
of importance given that we set it in our own "Documentation/doc-diff"
script.

Make the values of both variables overridable. Luckily we don't pull in
these values via any included Makefiles, so the fix is trivial compared
to the fix for GIT_VERSON.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 12 ++++++++++--
 shared.mak      |  2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 9b785da226eff2d7952d3306f45fd2933fdafaca..497b4e48d20f9d1d20f2db2a3aae2a92316b7ca9 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -56,8 +56,16 @@ then
 	GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
 fi
 
-GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
-GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
+if test -z "$GIT_BUILT_FROM_COMMIT"
+then
+	GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+fi
+
+if test -z "$GIT_DATE"
+then
+	GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
+fi
+
 if test -z "$GIT_USER_AGENT"
 then
 	GIT_USER_AGENT="git/$GIT_VERSION"
diff --git a/shared.mak b/shared.mak
index a66f46969e301b35d88650f2c6abc6c0ba1b0f3d..1a99848a95174c5e386c59321655937e7b7d8a28 100644
--- a/shared.mak
+++ b/shared.mak
@@ -121,6 +121,8 @@ endef
 # absolute path to the root source directory as well as input and output files
 # as arguments, in that order.
 define version_gen
+GIT_BUILT_FROM_COMMIT="$(GIT_BUILT_FROM_COMMIT)" \
+GIT_DATE="$(GIT_DATE)" \
 GIT_USER_AGENT="$(GIT_USER_AGENT)" \
 GIT_VERSION="$(GIT_VERSION_OVERRIDE)" \
 $(SHELL_PATH) "$(1)/GIT-VERSION-GEN" "$(1)" "$(2)" "$(3)"

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

