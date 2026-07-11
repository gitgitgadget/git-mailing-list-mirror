Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B4231A3B
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798017; cv=none; b=SfEBzSSSpEJtzt1Wh0HKz/Qo+7+5pGHq4/fXv7+2sxBd6GlKYbgMpTPehrH8blBszq1UGZMTlRQL0RNW04djWnfPdDDFuawQ3UtxLAM2oj6psXr8wIolPRu78cvgzNkSRl+zENBXyFK+w02eK8//wbuEIg+3rnPlEYxbzUGR1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798017; c=relaxed/simple;
	bh=cDsTZUTgQljqNlKMADx93GyDYoeXAuApdquDgGywuc8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+m537bJ7rSxsUSxk7LkAK1WXg7i4YtAMrXikGCXJpEDx6N9AWtMbA0kxsfMADyhAAZBhIw1sotRqvC6yobVO3WLxOjcs3ArhLZtPP7oXTz9h6FJsysKswMljo+WZN497T7IqOj3efxPBsOV2eRcydiAdqEXjDdzQKsMzkWNPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ifrIK5uN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhBhruZE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ifrIK5uN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhBhruZE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 329E714000C1;
	Sat, 11 Jul 2026 15:26:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 11 Jul 2026 15:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783798015; x=
	1783884415; bh=0EO1UK/BuIobh0Ol5MjR0tCcQWrYgn8TvlgPe+Os6qA=; b=i
	frIK5uN2/C7b/aEn8U5fZJel8ZLTp4aCkqGcBcCouCqLb7bFtuT4cHb5+aaxl65E
	4QGrEJHwncOzOwNT/k8F7SFdWaiaxNkudq/tCe3xcTEHsa18gvm/loR2awz+V4Yf
	lOHC/qJDudi/nMGXi91bUmN6kMQlQcgYzONsJsyVEQCLR9i1F1ggvSeYpHjdOhBM
	jd1IFdY7UWbaLFtN5te1xYTYvmdd3w1YIZKDJ5NjFYVCbgLYMDgcQ6oMv7wMrD54
	QeDqN6iy20sNYh6c+r+0iRzvavPMmd/rcSpTIDIE2je3I6QyfcidlgQIl+rj2TwC
	qcW5XwDJMauTOEF9FmZLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783798015; x=1783884415; bh=0EO1UK/BuIobh0Ol5MjR0tCcQWrY
	gn8TvlgPe+Os6qA=; b=bhBhruZEHDonL0pZwrNZ9i1PVXV+TKU80nSa5Mlft5qa
	zpoUDfxPatChwU7dJD+ugyZziNBCHUr9USO3tF82L6N0PVqntNVo2T1uPAl3WEul
	CimeeR387DoTuay2R4+WtqTprHJ607ES9cDFhhnTy4ksFqP4hICxLwAXO3NyPiKb
	3KYP+xgKL5qwA0rdAzwnnoppU+eopychV9qk0JBDuPpw+QgCEoubhI7C7KktoFP1
	Cy+pbVCBNvgomgphlvV5cdhwMb7w3R1AKTNe+UglHemQZnFFzyu7fM7/7dVsv4JI
	dQ/BOtGCaW3ORamo5g5+72YpKcJLIbOW7Yp5tiJIOQ==
X-ME-Sender: <xms:_5hSauL5Mwb9T4_FV-nkIEPDgmVfUpPAREH9zbiJDS9tXZC2MDo9wQ>
    <xme:_5hSasIQjofrr7Jm1_orFuEmScpeoAlkq8wCECy85Bp2Z1ARPKX-Hz8wphpHS2PVp
    GdhNTjqB2fdkVbGDmtiaC7MAXy792ACXh1WCu94PxDTsui5FAtX9n8>
X-ME-Received: <xmr:_5hSasVkrD0Cqx0u6c7YLTj86UJl_22ERR11hC3EoAz8qk8Si5pu6DYfwBrTZNWs7mCug2YXL6w-0Qk90ZQGxacrgcrRsQ7-rxJ9Y6o>
X-ME-Proxy-Cause: dmFkZTFJqDDiLOtZNK9IvspcieMba+1eLNTx4J7Cw7UAxOT6+ouPyrq6BGv8CmHUd2yp1c
    3LMnbIMYWc/oetxfu+mKHTLz17Exy8hCJVcRjfraJGA6VV5ICpS2oZCzWdS24PVZ+aLY30
    MyWDLG0gm/JKg0jlleOwkLmuavqw28VyOz2mUZP3kBlXWWbiFNtEgxOTnhjArRJLn4v9Wj
    kHHNDOhwlLq9Ne68NTTJxEAZclo3E+temZV1Dtje6ypm11Jz6233+i5EmhGrzCZCODkNrq
    f85z6kei2FP7RRJRW4N9tS+iJtQgbwn8ErEA7bx+HSh0jiSqZlcbsxbC3vQz5oeokJ9gjE
    CxrHL6z6ivHqPdZZWHDM+kYmDb3/L91DL+YqCfU97B6Fqi3ziSVhPrUOr6L5MKBTM7n3Uu
    jbn3fXQznWte/OeBX+iUEh5gtvVXbmrazquonyxlgGY1P9LinvatpjfSJV2ubnuinKp+KZ
    5tqCVOYc+HP+3egJUKGrTzqwTVnV7pxgpnw2n9AhFGQgyjt9cK1YfX04yBVXPfIp5SdsVe
    7c7PECkbBiPsj1+0R6sdjI5Jw0hynlxaHPo5pvLnu72xQDWi0Q6evGRzKhYuB1GGEH9hpd
    TA6AYnBErvSMv67Hk0O3wkmJvwMCY0mtvKWZES9VHMdghf5aOwf+I2G8bJNw
X-ME-Proxy: <xmx:_5hSauguZggJYvML6ZhhmZ3L3X-L2aJP5diVEyOcjvB6Y7ePfoNlXg>
    <xmx:_5hSan_mTLknHFj3-68uNCBTDfe00gZYlCzV3cyovyP0c-hkcPxfFw>
    <xmx:_5hSaoApgDksTOAYzuPLhPFMDO1NUiuWX9C05F9ZZOr-Z2iyZSO5-A>
    <xmx:_5hSakJeb774vUde8-MkxMeh5EGMMcfJn5nJCRVkjoV1vHn2KyjLMA>
    <xmx:_5hSahihRYBt9C__Hn8P6vOu_bfYy9KKLi6OtjrxgjzTl-xxcSB_UgnF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:26:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/6] MyFirstContribution: what if I don't get a reply?
Date: Sat, 11 Jul 2026 12:26:46 -0700
Message-ID: <20260711192650.2417665-3-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-391-gdf86bf5712
In-Reply-To: <20260711192650.2417665-1-gitster@pobox.com>
References: <20260711192650.2417665-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tell readers that pinging is a perfectly sensible thing to do when
they do not see a response.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 4832e5bad5..fc2ce2e785 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1438,6 +1438,19 @@ substantial rework, and mention which parts of the current series will become
 obsolete so reviewers can avoid spending time on them until the updated series
 is ready.
 
+=== What if I don't get a reply?
+
+If you don't receive any review comments after a week or two, do not
+assume your patch has been accepted or merged.  In the Git project,
+silence does not equal approval.  It usually means reviewers are busy
+or haven't noticed your contribution.
+
+If your patch is overlooked, it is perfectly acceptable to send a
+polite ping to the thread.  You can do this by replying to your own
+cover letter (or patch) to ask if anyone has had a chance to look at
+it.  You can also CC additional people who might be interested; use
+the `git-contacts` script (mentioned earlier) to find relevant contributors.
+
 
 [[reviewing]]
 === Responding to Reviews
-- 
2.55.0-391-gdf86bf5712

