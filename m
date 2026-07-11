Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BD62E7398
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798019; cv=none; b=M+qZcS6eghR80dRB6Htn6YuZiXQXyPRpFzud3rIQqUin6WIdk/U1ChiUMY/wPV2ZR2lHBGJnFKpzJAe1/Pbt9owt77PfT8d+WQ3MNsy3EnehSFB7VkkFTiIojySnJ65hhD8WpohFeKnwu3PfTtX3NaWuqKwx1KaPe7nw+CvtIUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798019; c=relaxed/simple;
	bh=SCaeR4cAK0GWSn8w7vwDEb7OhLy7C9mBIhR6XbBAguc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB+iqHzPdb1SvLGqfP0CY5z7aFyfjn5OvkWyshVjJ9jVGD5rg9XGV0j/3F0PZXX3U3QmA/JP31cZREClPVXlBKMcWAESj+T0qYi4jaPKdx4tAV5jF7jqoctlwo3O7tH0sKyKmEvuHkr/bKNbwbuexU5prZT13bZQ9zNrJWCaTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KiO0OTIv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pah/wwBA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KiO0OTIv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pah/wwBA"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CEB914000BF;
	Sat, 11 Jul 2026 15:26:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 11 Jul 2026 15:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783798016; x=
	1783884416; bh=N+Thit00d7oY7yn+I4n/ICVa6P0zza3XRgERtbnOfoU=; b=K
	iO0OTIv+3CS0ESEOnRYN1L7YTToQ5CxVhLibtc1SeqZ62E7ldBEWiKS4u6nzd3x5
	wXfl+mB4idvkdje6U2b/WXhRYCB7Mfepvc0hkMdswyS2o7kUJQZ6hrlBfOR3vASx
	UuV8y4IkasReiOtAQ5ISg/8qWCEmCHR3N3C9gjD77ugpYQOV9mHF8W+esd3ciMIm
	PjG+EG7fY7CCO5W5pxd9bdZVrKwE1Byfg8ScPxLRutuuSUeZNNHYWDXA3MnVOKya
	E2cJEV8FW8/MkuK3TbYDjF1Ritw6uA4KH0j7KW1BiIRAvY3OHkuTPKpRn3Grhqi5
	eG8gMEH1P309n01dE2+jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783798016; x=1783884416; bh=N+Thit00d7oY7yn+I4n/ICVa6P0z
	za3XRgERtbnOfoU=; b=Pah/wwBAvYd81cp9XkO86OAF5XykNFNRH9MjQ++3zj9y
	FbzaDNGLwA7NEYiO1x05vLAhosvFPL4LrQ0NR0jXoFweLH19tNN+iNQhNsygQD+V
	k1X402hFhkQ68DYi7kaY7r2Lez5+jEE6NLgWBBBapIqLOOxJUeMDHZJ9nvFpWLw2
	tB8eaozzY6P53tge4wncIdKbsS33oDfy2S529o407G1spJvDo/fpl0pyGG0c+9tx
	2RMAPcNZ8omXdjkpKQN+AndKCJUIc8nSyt2Y77N/WqWTUNPZt9oUTHDrmPeFJVek
	cuTJeKUqXxBHZk6p7g2OH7zzCxDkkDQQzMyV3wDirQ==
X-ME-Sender: <xms:AJlSapyc8ExV_0u6wTI8XDgDjeh6iIES2atfEybywqb6vqAX9_FYWQ>
    <xme:AJlSavR1im-1e4LBief5uF-n7XSv8Uofd0xuWzg_FkS4ctZOuCQ5kmOWGNjrB7i_e
    cbdeiVvaAcNkryx0MKZWeT6F2ZW9yEOEvceCRCdZga2lpcuRvqcdg>
X-ME-Received: <xmr:AJlSag9nJm0ZjsacwxPQTKsW8_qv0-aIymTg_OvdJtYLvX87m6Pq6SIn5eDLH6mWOQ8UZD0YM-WM4yaO8pFfCod41MmnU3rq31Yvzg8>
X-ME-Proxy-Cause: dmFkZTE66fHZ5SLaRnFLnsGCBs8gsPs3exxSbmLQmu38nNeYtOqyk7ifaawX2l8M8A421K
    QH2Ep+XavrE8WMoeChSYqazYV2JDRbKpIZLxzTKBen2Lj97G7VocIQ0HOXkOJ0nd0QYs6C
    5OjVPdNOJPLHP7ZSDGWi0PK3jMHXoXVVMde+BSx0l0gHBL7Q7iWtW3+an00bdX8hKWkjBV
    mn2BuTFvQiEOs9O6kXEhJ19jdHF3OybZ5gFZ08q6Gb4v70m//WTVCpSnD5tLa697SVvtfV
    JrMSy4l1OBBp3CFJ2qJmWyWrIoMyN5A+ZJ5PEtvTwt94Ee32mxdz8AQe+XCQEz68UsFjpX
    rhOhwwkKbC5QtYXS2QBHdz9+FcbyFLLcHW+Yae9RgD7Dmd2rVRMwszR1SKpUNycF0e4lQk
    PNct82xUIoL4D0eltQ1qVqUjNKcWnBP1cdBRPRKa0Zlvjzk4qCNGMoYKEx0MgINsntURoU
    5w7FhGrGPdnxWhL0T2pWeYeLSdXNMSgFYIyO/IEtxN+cpQLNiOyFPAo2xjlt5yFd9HHd2u
    NY69qStoGjRic18lMIHiYda+X1zs1DAe1w2ZfCy6juwQBZPwh9f4//5lgVQyqFUJYGAL8K
    vrBHyU43M7+N9MaK2/L8kYMUKzTcnFhWjYFO9xULG2dNN1KoubufFdJ/QPGg
X-ME-Proxy: <xmx:AJlSamqknyWe_Oi1M1ZxByQERgI6RQdSuyxU_coZWc8rzeF6zivfVg>
    <xmx:AJlSatm6Ltq9rNKgxQ2IiB629-cG1aK8WS_pknZvtRUcr8OcPy0CfQ>
    <xmx:AJlSatJvaO282I-QD0PrWYV41oKTJNJ7aaO3CP-xLIUCNxQfQFMOzQ>
    <xmx:AJlSaiz7GvcDeHKu6o5yhuc93SAROogijNjuDwx76UYWQQ4lExc2Ew>
    <xmx:AJlSatIoPEwgN7CiQ1zNbxza7v7GA6sf1__6Py8DatzakZ5830ANJlLn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 15:26:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/6] MyFirstContribution: carrying over trailers
Date: Sat, 11 Jul 2026 12:26:47 -0700
Message-ID: <20260711192650.2417665-4-gitster@pobox.com>
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

The maintainer will usually collect and add Reviewed-by and Acked-by
trailers on the receiving end, but there are occasions when
contributors can carry them over from previous iterations to the new
iteration they are sending out.

Document how this procedure works and how it helps the maintainer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/MyFirstContribution.adoc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index fc2ce2e785..988f0d4fba 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1509,6 +1509,28 @@ changing history, but since it's local history which you haven't shared with
 anyone, that is okay for now! (Later, it may not make sense to do this; take a
 look at the section below this one for some context.)
 
+=== Handling trailers in subsequent versions
+
+If a reviewer replies with an `Acked-by: Real Name <email>` trailer,
+carry it forward when preparing v2:
+
+- If your v2 changes are minor (e.g., fixing typos or making small
+  style tweaks) and do not affect the reviewed logic, add their
+  trailer to the commit message of the updated patch.  This lets the
+  maintainer know that the patch has received favorable review.
+
+- If your v2 contains significant logic changes or rewrites to address
+  feedback, do *not* carry over the trailer, as the reviewer has not
+  seen the new logic yet.  Mention in your cover letter that you made
+  changes that require re-review.
+
+The rule for the `Reviewed-by:` trailer is more strict: you generally
+should not carry it over to a new iteration unless you are resending
+the patch without any change.  For example, a new iteration of a patch
+series might update other patches while leaving the reviewed patch
+that received the `Reviewed-by:` trailer untouched.
+
+
 [[after-approval]]
 === After Review Approval
 
-- 
2.55.0-391-gdf86bf5712

