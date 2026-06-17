Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6335CBCB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729627; cv=none; b=CjqUKK4r/yVADfIa8TwX/SmgRG/yZD/CXHY8Z99tyq+i156sbBc/mcrcUI3F42YZMBdL0Vx0WDfxF6SNPoS0lwxCgBdcXg+YS7gUiFiuDC8uynLOS6JfrkF/3t9pMTFRbJiquS1wPWWljOahDQNfulLbRGlr40XPnlRrC2epewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729627; c=relaxed/simple;
	bh=W/QuvzcH3IiUXibbkZoMEscb9qyYJJrKLX7ImLhyuBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uieYFr9Bd+vIMWUNBMhJVuX9yeV6RDC63vwOpT6ESpv5uvLn+GlMYVXIlYSlFD8dkv44vT4LYNcOUwY3gSAdlZkGQZlcL8azZXBWSV55vMW0ecVF/AmUOrCEdORxha2m94VtFMhcYD6vdGyUCHZPqHqpvVUSBWR8aTgCWra2wXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EAdSFKLD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8e9AnZh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EAdSFKLD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8e9AnZh"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7028E1D00126;
	Wed, 17 Jun 2026 16:53:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 16:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781729625;
	 x=1781816025; bh=MxS9oqtIengn4+8LzWY9Qte6REhdg5lbYkOAnPjRLgk=; b=
	EAdSFKLDXhKvb3yoag63niNSpB81YWPPLgkCGvoo9Xseedx92kEV01EGzpSshpdb
	PvNiuHnCPHFJjrH9GBaPahqJy+gA0tMaMWqrjjE8naHqcGmQbZNywRaiGUxYeKLd
	swRVn+FuWEi1zyv2yY8oVZAABShVjxyadi91faT1SojbEFTdyp0IVhdGud1gDiS7
	5DOjzm5Rbj5n3O8AWKDljhRt0ucRVaSS9GmxVugRWsa2ZMbyks0hvdIXX4FSgH6c
	6dPDvWgHGWJwk/81UHzjtiI+KsXgkif2CAog9Kv40dEvv3yyRaNEEDLmAjh8v+nZ
	d0WtOrEm1Bfp8oOBvJxm5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781729625; x=
	1781816025; bh=MxS9oqtIengn4+8LzWY9Qte6REhdg5lbYkOAnPjRLgk=; b=O
	8e9AnZh9g0ihZI6bs56OmP/7UuDIdXv5lGf0bSQCQBKKJ+8/StPd2nm4WR53GQ2g
	DuBcqVzSz83A590RWtqcGaO59osZsj41UzYVavi0F/mdq0OlvcO6wW4fNxlwNL53
	75yr6R9epSiEpnwc5Wtwe73No3kHvd7/3UGADYCuhce4EMxtecGHueCAVQyKQ+lI
	xmMI4Aw9Co8iJIYbkgthrjK8eDVqsDVwh0tfPl2GIYT18Z3oI9XRDNz9Zhz5TBBm
	zaF22QYmwi2V3+lKut4Q/F9LimeHlZBz58xsg6SlXLij3Kdz23Gi3jusGDsfFUBk
	A79GSK3nMS/n46QzY7AwA==
X-ME-Sender: <xms:WQkzakVXkO6rWJyjkviy-T9bN_zj5yULwrKkO8bTNCFpNVKJzgZ39Sw>
    <xme:WQkzagAeSz1YrbrbRdeEGGW-AeBrHbtHMRyzy-5TV2V6PSn8XoIQLQNkwmRGdXCLG
    BWb0ZVa93k2I1DDkwDXCDTlXaB3UY3Bw2VXdPc0jnqkknG8Tq8B>
X-ME-Received: <xmr:WQkzalzObXLd72JaEeQ3FSt1x0Tq6rRwcMwkktRNDC5nbMz-HkEVmEywPymADaco38IF6UzTyUbvpRqHlsKD5tMIjDAXTIj59mYnpWVpigCs4GW5Qv2Gc7zPKw>
X-ME-Proxy-Cause: dmFkZTEO2tGp9+RNAXoNZjD7vck9e7XoDTeix7UuHGOrPqX2HojPyOvz4gRue/zdlT5sUT
    QFtle9nYY10dA/mEbX8ANWlI94IxdHmCWly0dZ9gC+6V7bbl7dpB2R+DzdJBT3zqW9WqEI
    Ii3P2/D3cenj7FEatKVzEnwXKCJxS5EhOnHdjqt81fZiJucLJA9ScPKWxw168Dl4Jck9to
    Ux95fKW1KceGhAmzxrMDV35gGlX3avo2qy2kx9m4IKI/FVZGj/rVvI6rOktpN/CDXeCm6p
    haoxWgy285acfQQcZjf9243J4uYTvKRK9Rh5L5j3Nr+yTjV4CfU4kTqMNEgpfB31L2B9V9
    K/R3gBetqBcVt7TzeMAZrc6yj2fHJoRFY8OQ7I8gJxXtnNyWx3Oe7ao3zAoGLnTH/GIk3w
    bYb9CeQ9rPESWQQTLU3ornrgKPfRVW5/BCcSURbj0Z+opbC3ZPA7AF0J/AHlnQT5wylnga
    rYm/0elbsOkLm5DnInr3FVkgI5a+HDz2fc5fsS3HQJJiOKczaCvNfmTuljjIp7dZx8H7zM
    RxG+ZMZBYD4ctiUMJmbNgI0LG18lomqn1FexZlg2iUmsYARcs3wSwaG1hPonhA0/B0yHFM
    PoAHAU5qxWR0rvSkRk/e87NcScHeGqSZat8u4bPLjlDO4OsJRtH4aRarXenQ
X-ME-Proxy: <xmx:WQkzatAIwk2AhqG8xHKb7TPnxEkPBzHU8dn5rAsBl1bX_1-GmCW9BA>
    <xmx:WQkzaiYcqlm9CPjTL9hthnjQ4SVWZisuH8oe9_rKjgE1Pn6d1Pee2Q>
    <xmx:WQkzalihUfT5hxDKaqlxynBqSYgYP0ldLsq1v_vEGWf9lcUW9Nj-5Q>
    <xmx:WQkzak7Mqdh3g2iotFf6Qk_8ph_MegGfQEcuwILdPr7reE3yaQK_aQ>
    <xmx:WQkzagKMbSvYQ_23Rk8KfCC98DSi5911gpSo5zgcRrvZtO4vNao4LcDp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:53:43 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 4/5] SubmittingPatches: be consistent with trailer markup
Date: Wed, 17 Jun 2026 22:52:18 +0200
Message-ID: <V2_just_trailer_markup.9ba@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The rest of this section and (most importantly) the list has decided to
use `<key>:`. So let’s use backticks (`) and a colon (:) throughout the
document.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/SubmittingPatches | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 4a37bc29f5a..cb2df3cfff6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -374,7 +374,7 @@ or, on an older version of Git without support for --pretty=reference:
 ....
 
 [[sign-off]]
-=== Certify your work by adding your `Signed-off-by` trailer
+=== Certify your work by adding your `Signed-off-by:` trailer
 
 To improve tracking of who did what, we ask you to certify that you
 wrote the patch or have the right to pass it on under the same license
@@ -411,7 +411,7 @@ d. I understand and agree that this project and the contribution
    this project or the open source license(s) involved.
 ____
 
-you add a "Signed-off-by" trailer to your commit, that looks like
+you add a `Signed-off-by:` trailer to your commit, that looks like
 this:
 
 ....
@@ -421,7 +421,7 @@ this:
 This line can be added by Git if you run the git-commit command with
 the -s option.
 
-Notice that you can place your own `Signed-off-by` trailer when
+Notice that you can place your own `Signed-off-by:` trailer when
 forwarding somebody else's patch with the above rules for
 D-C-O.  Indeed you are encouraged to do so.  Do not forget to
 place an in-body "From: " line at the beginning to properly attribute
@@ -433,7 +433,7 @@ your patch differs from project to project, so it may be different
 from that of the project you are accustomed to.
 
 [[real-name]]
-Please use a known identity in the `Signed-off-by` trailer, since we cannot
+Please use a known identity in the `Signed-off-by:` trailer, since we cannot
 accept anonymous contributions. It is common, but not required, to use some form
 of your real name. We realize that some contributors are not comfortable doing
 so or prefer to contribute under a pseudonym or preferred name and we can accept
@@ -485,7 +485,7 @@ Other projects might regularly refer to other kinds of data, like
 particular are not used in this project.
 
 Only capitalize the very first letter of the trailer, i.e. favor
-"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
+`Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
 [[ai]]
 === Use of Artificial Intelligence (AI)
@@ -607,7 +607,7 @@ Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
 how to submit updated versions of a patch series.
 
 If your log message (including your name on the
-`Signed-off-by` trailer) is not writable in ASCII, make sure that
+`Signed-off-by:` trailer) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
 
 WARNING: Be wary of your MUAs word-wrap
@@ -627,7 +627,7 @@ previously sent.
 The `git format-patch` command follows the best current practice to
 format the body of an e-mail message.  At the beginning of the
 patch should come your commit message, ending with the
-`Signed-off-by` trailers, and a line that consists of three dashes,
+`Signed-off-by:` trailers, and a line that consists of three dashes,
 followed by the diffstat information and the patch itself.  If
 you are forwarding a patch from somebody else, optionally, at
 the beginning of the e-mail message just before the commit
-- 
2.54.0.22.g9e26862b904

