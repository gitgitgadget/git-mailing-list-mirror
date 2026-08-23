Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8126374E7A
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484823; cv=none; b=Q7AIaubWQv+zat0DjtqRKvGXA+7WebQlZeIyf0vy138p14pxt/IQSfjsxDfmCuGuz5jijlPT6D0wbFdsnKwQ4RVhnvs9gW0YPFBJ7AzVoar4a291wOKXVSWzzvMRC9sububeicXOLjrSz9wzPsG7OyZ2KpWey2oRDteSODD9SYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484823; c=relaxed/simple;
	bh=hyViv2qde8tcnX+wE7O5Q+4amyYL/6RxTWfctgeErtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liwGGv0/joFTkrPut45C5mfZGZ71Iu4crgTmjYyeyF6B0O9Z0lcePdrYmw08Th5XNIIjKoMx2+KPe6FysMV92pNFcszgVKk+MOTwAHWrafW73z/ZK3OlHiL5fRrPb5rIc9fGFGT+D33mxaNZakcwG+dgsyeUG6iuF+WEOL8sNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LausqDgd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N7BYVs6h; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LausqDgd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N7BYVs6h"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8BA7140007D;
	Sun, 23 Aug 2026 07:33:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 23 Aug 2026 07:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787484820;
	 x=1787571220; bh=xlonEJuSDp+PJH6kWeOvNLVWq2PsNuNUqj1oT+tBLNY=; b=
	LausqDgdoh8dUX3r5kPIUGD5aqmSVFR85K520X8LB/6tWpakbm7LGkklDv2myG15
	5XnFrd7qJ6a9ZksWe/+GGKt3xGLR6xSZeFFHM96/OgPVo7p2B8E3YngNhPUcndaj
	GJw5bTnuNCOHk9ngCQMWlz9LQRcHYOAU6MgRRdb52sjjkcPEbeHbfgpMlomji83L
	K3savobQjRE8vc3Khk/JeXr0U2QQ9U/Hw4APCCidQj0zCGxudcYEMNe0yHctrLoC
	OvMeynS82RfxKHmaBmh8niTVLX56etZKcVXoEwxwAfD/h/BA5Kx4wA4DPOPz3YG5
	GU8dOv1SDTe0/cHH1U5CjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787484820; x=
	1787571220; bh=xlonEJuSDp+PJH6kWeOvNLVWq2PsNuNUqj1oT+tBLNY=; b=N
	7BYVs6h6labZz0DdUaDo6bea+CFIkBA3jc8iePvoEm3ELllBdPVJD+GEYDFO56zg
	GMa75evaHp4yZRtVPbEoSVTkgsTHyGhXeLKD3B70Y/2JuYAwt626qCgLRwERBhGZ
	kKjYX97D0nMv9OsdCnp3TdobDu9Hf+EQ8Oo/vRKinuJGL+00+x5N7tscGNzfKQSr
	ln6Ky1VyPgors0KJ6vRKhPLZTM7OXMB18FamsBJPIA0ap3gcZJyGXRZFErfATCLE
	PM7zglESK8i9hRZGiT1uSrPE7b5B8EAQIkrEi3ABDcJlgeNU3VM81VI+WwHVuISH
	bHZxK4jJtJR20qbmYY/Aw==
X-ME-Sender: <xms:lNqKancwtXYz56IiZ7ZtUEmigWEFN-zfJRo_SoJS5lR7IL27JurdtdA>
    <xme:lNqKakNNk5fFjTFCrD_Zjz69XYhHwVh2l3rMtT0dayQ_tymA0zCYGfWFfuvz-mMke
    -CxTLWvaR6xfq2sYLybxoDxoHZ0b23nf0N41uqaelguwWmRFU9lSQ>
X-ME-Received: <xmr:lNqKalgl0KIuLV1vbQ27JwUQpojEz4zFNeSPLCTDmnJipZIZ3VXYIfHWqn1xJ_whWjv_BzU8zyBXDnv5PLsAJkIHZA5bARQxwOq4vv2KfZVEGuq0rChBTAY>
X-ME-Proxy-Cause: dmFkZTFfJ3LWw51gC+1cNjjS7elSyMDiWlFQmemF9lL0fYBM851lerZ4k4xRpiBSwH+R4W
    451qFezDmEOh/Q2iNE0YpVVEhLqcRZIYIMEfKUsMRYfLsN70n8MCVcKIIP5iNzo/OF9k8Z
    fpkSRYckclG3nWrEIc2nTsZmeGYZacUh/bilZPpsd7/5XNbDlC1z+gpc5B1AqV8g4FBKlh
    qtdJLaaDVn3Lbohj3KaFI2eEBTQAueJYOGHkEvYCEAMAPuP/aGoIJOsCSQlWi4r8M5SVdx
    kruf2sb1J7RaWe1iK1BrrMIOw8tEjP3YPCl0isvLjM8e5VHZGSZQCdPIVrWXokv2cacTMZ
    fkMP2PJTVLP3R65hbG4xXvioB/00Oe7qn5xiMX1S37vS8fbsIuliU+QzE9yY4P0KEbHSGf
    P5CEspZly2swhjVVqPWepHRgXE0FrJzSHdZo2zfaht2d6SwRkkYz7fYgpIVmZcZVsTVGUs
    +2poFcPtKGYtL3qu0VX+SCKn4uwf/qw4ty5dIxkn4rMhrtnG97qmqnAZ9X07Rs5nMjppqY
    w5gP/LqgvyJ1Onu8OR4yaGUfQ1elxGGWRA1wDo5lHntpHT2ccNb7jN6FLwvCnjKsqFHKeG
    9bY4QhA6vigdiScNvqrpcYrIhcYxSoAR1OAYRZMq0ty41dtuf0T0PFTcar6w
X-ME-Proxy: <xmx:lNqKan0EbepPtwu6xr_oVyDFLJz_82xt96FiWa2YzRbAOhanjJA2hw>
    <xmx:lNqKavhs8PhimIKxAMldzYkoCOi7AhOUGsMqYzTEXcrXfUYHll_6QA>
    <xmx:lNqKaneDe9Ndz5PBWXNtYePdZlFlW00V51nGzX82natEWRnr4BVnkg>
    <xmx:lNqKain3Uu-mQqeYjg0Q0dPmPYc5JRfio5nFUFmWTjXt4_JbV8qmkA>
    <xmx:lNqKasIlI-6nC6TyoaQhzOsEQTngfsFrnYRiKkdFTUAAJaH1KS2eSCyR>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Aug 2026 07:33:39 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v2 2/4] doc: git: link to the gitdatamodel(7) tutorial
Date: Sun, 23 Aug 2026 13:32:47 +0200
Message-ID: <V2_git_to_datam.c22@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V2_CV_doc_datamodel_advertize.c20@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The previous commit added the first mention of gitdatamodel(7) here,
under Guides. But there are also other sections where a mention is
relevant.

Let’s mention it:

• under Description, since it is as useful as the other tutorials
  already mentioned there for those who are interested;
• under Terminology, since it complements gitglossary(7) as a
  pedagogical rather than reference source for the core terms;[1] and
• under See Also, since the other tutorials (plus the user manual) are
  mentioned there.

We don’t need to mention it under Further Documentation since we now
mention it under Description.

† 1: See dee80940 (doc: add an explanation of Git's data model,
     2025-11-12):

          `gitglossary`. This makes a good effort, but it's an
          alphabetically ordered dictionary and a dictionary is not a
          good way to learn concepts. You have to jump around too much
          and it's not possible to present the concepts in the order
          that they should be explained.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Msg: Correct section: s/gitdatamodel(1)/gitdatamodel(7)/[1]
    • Msg: Missing “is”[1]
    • Msg: Correct “on another page” which refers to git(1)—the same
      page that we are changing.[2] This is a mistake from my own
      iterations since this started as the first commit and I had to
      reword from: not mentioned yet; mentioned with `git help
      --guides`; (realizes that it is also automatically included in
      Guides now) ...
    • Msg: s/other places/other sections/[2]
      🔗 1: https://lore.kernel.org/git/aohDFdjPU0t2d9_8@pks.im/
      † 2: Self review
    ---
    v1:
    I have used double spacing for sentences since that seemed to what was
    already in use.

 Documentation/git.adoc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d2..6f0075f9188 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -25,7 +25,8 @@ and full access to internals.
 See linkgit:gittutorial[7] to get started, then see
 linkgit:giteveryday[7] for a useful minimum set of
 commands.  The link:user-manual.html[Git User's Manual] has a more
-in-depth introduction.
+in-depth introduction.  See linkgit:gitdatamodel[7] if you want to
+learn about the data model and important terminology.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands Git offers.  You can learn more about
@@ -469,7 +470,9 @@ Higher level SCMs may provide and manage additional information in the
 
 Terminology
 -----------
-Please see linkgit:gitglossary[7].
+Please see linkgit:gitglossary[7].  See linkgit:gitdatamodel[7] for a
+discussion of the core data model, which includes important terminology
+used throughout the documentation.
 
 
 Environment Variables
@@ -1199,8 +1202,9 @@ SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
 linkgit:giteveryday[7], linkgit:gitcvs-migration[7],
-linkgit:gitglossary[7], linkgit:gitcore-tutorial[7],
-linkgit:gitcli[7], link:user-manual.html[The Git User's Manual],
+linkgit:gitglossary[7], linkgit:gitdatamodel[7],
+linkgit:gitcore-tutorial[7], linkgit:gitcli[7],
+link:user-manual.html[The Git User's Manual],
 linkgit:gitworkflows[7]
 
 GIT
-- 
2.55.0.13.g85d2d65e389

