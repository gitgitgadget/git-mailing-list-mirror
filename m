Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF11BC31
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137120; cv=none; b=ThtM7hy9/K0Mj9tBK7cVGTB0PV7kwlDTqL72QBxeTyK4izG5TorRhnIDbKFSEEjR6c3O/KW/aW7+UTDoHoG7LJG9NefvL3bcekPzmUS+WyH+CY7V0pYzChvSdI4/hnT53l5qxwyv/0mOi+xlBUFopPi+P/bzagiCkKiz/6DOHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137120; c=relaxed/simple;
	bh=xgr838zX71O+kRXd7GJSqLoQ+gJsDqZCVZIy1Rac7qU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aMhxA0dE87AjOaM3qbjo2vBWXWiJUQM6ugZG5gM/5HFjQulPrkhURTDpzNEeoBASa5OJxYMwhlBaURd1fC4ljx8zQItQWz2Uoi/rEQt8xnSY0L4OUbncXPsosgkVC5Rz8F5OV3PKP3URHTQ31KvYi8EOgk5xBT1ma2XTxVQU4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=OnYgpUcU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="OnYgpUcU"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707137113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HZNzb6AIc/vT8Zs1JKThHBMpYgYq430mn9RQRTVQ4jQ=;
	b=OnYgpUcUSxdqYNXnU9lXTY3V0wCtrVFYau5kCG/cRpu4g1OgGhxtztLWPV1bMrxWYhYw4x
	PoTjGXPd+PGsa5YUWsAzhv5sG2cYTVxqT9bJFd3u5t9zMpKI0wdxAQALU+zu66cU+kzC8I
	KMBy+LecDB8o1abV5vCTOdnRgfeMydjaks+UYKquvBSxmw6/oP/tVWiOZor2dTas1QTBzb
	dYdmMhLQi+ud2G8o5kwYmLU7TYjrVAtkur1t40oyK8QaMgpjg/xIFFan0fsd1KM2ZOjOc3
	Y+Arsz3AB+EHg0uc8S5qAi4V6xm8CvhSTP/1SIkDsMMMwDyqxJGUwhfJB+aLTQ==
To: git@vger.kernel.org
Subject: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
Date: Mon,  5 Feb 2024 13:45:12 +0100
Message-Id: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Clarify further the uses for <oldbranch> and describe the additional use
for <newbranch>.  Mentioning both renaming and copying in these places might
seem a bit redundant, but it should actually make understanding these terms
easier to the readers of the git-branch(1) man page.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/git-branch.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0b0844293235..7392c2f0797d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -312,12 +312,14 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	option is omitted, the current HEAD will be used instead.
 
 <oldbranch>::
-	The name of an existing branch.  If this option is omitted,
-	the name of the current branch will be used instead.
+	The name of an existing branch to be renamed or copied.
+	If this option is omitted, the name of the current branch
+	will be used instead.
 
 <newbranch>::
-	The new name for an existing branch. The same restrictions as for
-	<branchname> apply.
+	The new name for an existing branch, when renaming a branch,
+	or the name for a new branch, when copying a branch.  The same
+	naming restrictions apply as for <branchname>.
 
 --sort=<key>::
 	Sort based on the key given. Prefix `-` to sort in descending
