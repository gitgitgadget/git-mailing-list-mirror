Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95564378D8C
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592170; cv=none; b=PUKdScT6ylbkCme8HKcgFZJwwij6ofTab0TNmp+4wmmEg4vH39ZNpCOtW4TQwvdiKaZTC/d6uVUprGk1cIZh+XB+CTN020bciaD7eiuiudxWqn4/w/QK4+TuRYXu+fFIPpQrB3rzDkbL8RWJ92hzqQbsOzOKqBM6FuHs9LqzirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592170; c=relaxed/simple;
	bh=fsVo4Q4Va/BffcbZK7Z89r6tRGCIl6HstFXCBq9Zd3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8NVf1MJkY2KONjrHFEXkj+PVeWC63WS6W9kH+l1Ycl2MdA/EUaxIq+SV9jRJNd29jIeCmV66wK9/0OXxHHD5LpA+jt7+MHM90zGVfcEQ3sKohQuifqO1ycirtJUaWF3bZI25ZvqtGIX1AUYLasMBUDP4VUpsS1ek73zAhNPEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=PLFmNm3q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xt8n+qgz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="PLFmNm3q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xt8n+qgz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 93CC9EC0018;
	Mon, 28 Sep 2026 06:42:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 06:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790592167;
	 x=1790678567; bh=JjfV+I/gmG3sgOFXBPBEdZjUm5LX7FaFQIWwMPnY/rE=; b=
	PLFmNm3qs8rAOyChJtQzjtjFvpCJyCk0bDNFz0FRGu+qcsoJPe7B0rrm2H4fl3BT
	sSU03mX8oRECjT2EdiJxM8CoGVm18HWCppq633zanaDxohssK9+7kkT5xGf25iZw
	7RFZ1oCx9a5ezY5UPQfJjLEA4GWGM7umZQI7IrRu7r4ltp9Gcr00s7ugckjsxqDs
	MKXemYV2sjH1OcE3nyJHbGQOScvAYYYSG7QMnGMnOwofoLjzKEkSFwOz4rS47VFq
	LrDBm7Dbq4xr0c7CxoqQICYz/lFNG5jicFSbjtjgYcqCIBdjKT9R7ZzdeGnZ2M5V
	H6/5BN24lGRGd0Mu5CE3GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790592167; x=
	1790678567; bh=JjfV+I/gmG3sgOFXBPBEdZjUm5LX7FaFQIWwMPnY/rE=; b=X
	t8n+qgzsU6dl/v7M3uAObXNguDl5bxs05Wh/FbokOc5fBjLQU/lHuZScy4YvYz2P
	LwyEzODm9M9SeBns1MWTJoK5fWVpi0KiwaPzBS9UqifPpUhjrjuNe3Fulh9XWDik
	7uoebYZChkZT13HohKdocxef7bge17ZsmjZ6qah/huHyhZoiQI5sHQ/R6P1qH8mZ
	qhpvdju0jB77lu+V3JYuzE9j1Oav29PfvCNENmuK4TDmdxaQ+W9+VGt3r1cje82c
	VuQ+6Gdh7Fo38komRNu1He3yathAfX/QLjrVMJYcyXxIvt9FF66S3fIBXwJ+n6P0
	KFrg6zuhAi9HGf5Xm8TLA==
X-ME-Sender: <xms:p0S6amkPF7ceYwFGBHUsFl3ra2u4jYQgmrByTI7NWW7drkXIG-d0Cm0>
    <xme:p0S6alTdR6GkEhXVZuAXhNvQ7_AMqB8QTBIIWUZbOB02k8Ta-liWONkkM9-tKBzmy
    chzGaikbtBiBDDuOFUVBPQC1B7c_v04fkqGdAE1-32oSbznFFasPiM>
X-ME-Received: <xmr:p0S6aiC9YFIuRBQq0Mcz7-rZ_ogs33rpQY72T3-9hxCHx7gmlwMI8jXi33YzG_wW1Q6B4XGA0iOpG3bacKMHaXizdotezVod2tjyHZY>
X-ME-Proxy-Cause: dmFkZTEcQGIQV2SChG9y5UN4yfcO8vYoDxdzDSLJIOh1U9SKfkfEaE3hAZuyE3ECYjEf54
    ghB952nQQadiJxZm24zdXwCT32jGA64OiJPtmcmuBeudviJQUxA7avascDj7R1sbpfcxBL
    CHSnLE0qNpZfNzkrrhorcKf0KwsgfRNLdArgLGS2cyW7gNIq9xsw9dWz81LSzvrk3fI7Sj
    6Gt1mYKSjZOtuz55bE+WDa1kiA+JEHhthUBKAZB/s3xS3QpxiPLhY6zEhxbd1R0jaU8UMq
    Fl8w85Njsnc7IoMoNGfBsQwIzIEIMEMxMdgLULzJB2NDzwyRPflrE7ErmXLSE3kIxMNupM
    amaADT+Qy9ZpdMrUqGArnyhY0OEypL0TP3JaCGfa5eyfaIvvGCevExznPkRn5acwIq6hhK
    6DQ6IkSJamYLBE/yWxNmS+Df+dRZQs2foD7Owp2nx0QfEL+YjEMRERNB3YKqpYCMHZSU5B
    gTzVGmA26ZNNCYwr4Zie/ao64nNOBRHUvrK6RPSufTyOnKATb7jlV1N8al6j7pU2HUj3mE
    wGAdWoAiX4UoIXlGa/YZvrjEyr4Awa9xqBgvXi3FFQmqvl/zKRGX2u8PpDTZ6BLvUacGh7
    M6pdZ6x/OYon8ApSQZWlj8yDsrsgiKfG4Dm9/XN5sXNEFMeV5djJihtrg8xQ
X-ME-Proxy: <xmx:p0S6akTKZf_LMuDdDVmJsjMQ5bflkZjSc2j-SmZYHpcXJsQbo7mhzQ>
    <xmx:p0S6aoqyIQvPYOrp0QoQ5vkzb5qGaTte1nlPOoOLAypi5qwfCw_rDg>
    <xmx:p0S6auyBilGgZTArrQyR8_I_R65U45miScjfM_l7utiNRJbiltH21g>
    <xmx:p0S6alJjFgSN4OLHeuhLPx8iKekhTxyma4HANMUZVSKkE6YkUGRopA>
    <xmx:p0S6alaFgLUCyFM9g5EIntq2xYZ2U585Q9EwzG-YI7thQ7j1DDqJUpVM>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 06:42:46 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 4/4] doc: git: mention gitbreaking-changes(7)
Date: Mon, 28 Sep 2026 12:41:28 +0200
Message-ID: <mention_gitbrchanges7.d20@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Users are the ones who are impacted by breaking changes. Certainly much
more than Git developers who are already plugged in to the development
channels that discuss the trajectory of the project.

We have to that end already made the breaking changes document into a
more public-facing page, namely a regular manpage. Now let’s mention on
git(1) like the other user-relevant guides.

Like last time,[1] use double-spacing for sentences since that is the
existing convention.

† 1: 5745353d (doc: git: link to the gitdatamodel(7) tutorial,
     2026-09-05)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git.adoc | 5 ++++-
 command-list.txt       | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 6f0075f9188..6a4ef2dff5c 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -26,7 +26,9 @@ See linkgit:gittutorial[7] to get started, then see
 linkgit:giteveryday[7] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
 in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
-learn about the data model and important terminology.
+learn about the data model and important terminology.  See
+linkgit:gitbreaking-changes[7] for a discussion of breaking changes
+planned for Git 3.0.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands Git offers.  You can learn more about
@@ -1204,6 +1206,7 @@ linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
 linkgit:gitglossary[7], linkgit:gitdatamodel[7],
 linkgit:gitcore-tutorial[7], linkgit:gitcli[7],
+linkgit:gitbreaking-changes[7],
 link:user-manual.html[The Git User's Manual],
 linkgit:gitworkflows[7]
 
diff --git a/command-list.txt b/command-list.txt
index 63ae2a67c94..1b7236a62fd 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -213,6 +213,7 @@ git-whatchanged                         ancillaryinterrogators          complete
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           userinterfaces
+gitbreaking-changes                     guide
 gitcli                                  userinterfaces
 gitcore-tutorial                        guide
 gitcredentials                          guide
-- 
2.55.0.793.gc667de3f2c5

