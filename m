Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC13BCD13
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788629379; cv=none; b=KQDtHeMV4aSla+EyINJ1TuIijeJBmNUiueLDcS0KaRP42gl4RQBMEJNM75URfI6TESHNa6tREAvA1/gDE6A2s3WuimiW7YV0W+3fkL85Ra4UIeQ7fLxGhxdQCss9AyeAWPEP11HB3pj4/0i3Tv4TywE7cVyn83XxTj/MfRXCO8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788629379; c=relaxed/simple;
	bh=9yRHj76aIQbUEq9wql5hyXAOzxZm2tMliUeIlqH4CiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRXUyhJ0zlJdxskk9vPmtaXG4t+AMoA1v+mma8e+bCq7rol2umWvPzTLyRQ5Nztp0kRTG3TcQGUon7I434zMjUMFgbxSMvd3ZzJnadmz2qTtMMtYKtWt8b0NqgKxE01e2fuUKlPfWhpK7ibuvLES6hPJqPjebyNPO5QznGrkQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=j/uui7Vo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j18cLHJ/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="j/uui7Vo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j18cLHJ/"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDC097A00FB;
	Sat,  5 Sep 2026 13:29:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sat, 05 Sep 2026 13:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788629376;
	 x=1788715776; bh=RU05SSxNZ9IKZdT4+Ed39o4BxN8unFFkrVVUbjgjiek=; b=
	j/uui7VoSKT1NfFZ8q6UBXrg7nwDeziCnHMoIWs8JWlGyVOSw5KyCuIx3ZNLCSy4
	+vWnByA+xloahGuQQYvaDASnTsud8AYkFnR0jn33MK+M1ID4vmrYujdRXX6T58Hs
	99aQXS8tgTY/gZstXLgmtdP1LR8A5Hjm1fyiyTjn1n6TcEXX3KSoPfR/ksoA0C8x
	INpyk/Gpf4FSVw7U/Rg5kya4dJ2W6YvssaP+oHAx6Cb4gXi+gBhYKoNGYJgWTRFQ
	Gh4i8oMPBoySpm/5G4JWtaAfJ0qT8v5Y7Ff8Qxhj35ERKKMqELzMXy0DntWkgVvu
	ia/UwI3OZZYambAyM7P/uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788629376; x=
	1788715776; bh=RU05SSxNZ9IKZdT4+Ed39o4BxN8unFFkrVVUbjgjiek=; b=j
	18cLHJ/fLXBQ2CZG8fhDVN1OQaHQwmaGQeUE1wzKEVIhVTxuj6w9o1z7XNjBhGqQ
	JrbXtqLCJNUeinvnY70cymyF/d27zTiYPkGSbFWwGWC/GqrLPDr7CVyPQC7RuRtD
	Vz6uodcOW2H50uAab1230ySxPII7rq5U7SfReVXVdgEFTXF/hpfCPP2BRGacqItv
	bgftSP9v11x0biGPbcNwFQyTAkiv0sKVDK9lVucTo1LijHtc7qYdBudjTRPsxszH
	4ycpkBQkBeDMm7SQDX2kc6iwM65MLrB2deCay6elDxnEUThHaU1mJeo3I8z4HpEp
	ux5nZg1zxm4cNge1PMy+g==
X-ME-Sender: <xms:gFGcan6ILT2axWFtD-58r17DDdcCi5DPfjh0g8VxUnV6ldsW5zkGgp8>
    <xme:gFGcaj4SW3CSpiGtuK5_BfD2BCOLQKoGIZioid4Yx_sOjxb54nguMN_Y7JPpEWkWQ
    ia6mfUIOSpLj186Be0EquF7NbQPGHTMJSij8gAHLUuR_GzzeOAj>
X-ME-Received: <xmr:gFGcajeGPKxBSlkbaCDc355PbDB5I_4T7LxuE-MEeJ_l2ga6oNn-vxWVCrt7RmzDlv3sp61tAXrmbz-vDXeUT98FFDrGEeIpZ8p-N-uyrt87DKQYUIGnjVU>
X-ME-Proxy-Cause: dmFkZTEotm6TrEcetlgUpWj2uj/UIr2I1BBNLNtx50zVR6LNPxoiJzguH9uTyT/QsvM6qb
    IJz8MzWhojBr8vNK4ks3TjQa9QiI6V+EoqvRJYYF/Nf90pPRInTROsiZLXrUo66jHOZFAT
    KxHbAtULnA6yzJAvHCaashSNHzsDpIofpAwuupmbvZkRoKPZjGPfxjZfONhhalS22oaYqy
    b+IcbApWqR8cFI9RwQNm++TH3Qc+E9vwnGwricNTdpgYGbIqWIFSIkJLHG8YIfOidqWDT0
    xYjlBgztZLD78/cci9IgyT6bRCelTocqerFLvT5c3o1FBB6XEjGotBTIXuXNTX3xCXJWKx
    BG9tKtnJPqGs6nGxIzUK+V0glrM723+x8oqs/KcFmMpYgRklZWxU7YDA0WgFlkL9AjfpCo
    P0adOnBuYwetbSxpLZDdRXvDyKLaVL3plOiaQkqNvKrbN11c3UQljlv6PRHbqApeW2aI73
    E+1/atbBG/wA/w9ae9QDgf4tWU+FrVKorb3LDKRAH31O7/mOtfKhH+t9Q5XxmO2TMq+/+8
    oidfkEELw4mOhJI6RmXE/DDiuPP4t/CfWBwg42LQTpzDscS+8UWZ/DfrN0A+dYvWrp6P+g
    epGVr/c7QAf8c6wBtaE05TkH64cRlNMKOjGAnqIJ8nkY2PURuT0CNFe07Quw
X-ME-Proxy: <xmx:gFGcanCdLvwX2dCmrdnGe9V5ootu2I3wKtXD8yFLQZZW6mQ65sbBrw>
    <xmx:gFGcam_ezDE4S0m5UVlx7VJJwUfd926ogzwDHRukNDVpbzYHyECQqw>
    <xmx:gFGcaiK9_OKTaFyvbyVvXBDwWWGdjJTDwj24XgflyHzgRFPum0N0fg>
    <xmx:gFGcavgmzBaudADkOjsgIKuinifRbNnql_UHBq6XEvGRkq30SURqAw>
    <xmx:gFGcaiFixMlqyVTpKy63pHAAvM_fNS9qepoUZ0dxZOgGIqGdXqLtAv-C>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 13:29:35 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3 2/4] doc: git: link to the gitdatamodel(7) tutorial
Date: Sat,  5 Sep 2026 19:28:13 +0200
Message-ID: <V3_git_to_datam.c80@msgid.xyz>
X-Mailer: git-send-email 2.55.0.13.g85d2d65e389
In-Reply-To: <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
References: <CV_doc_datamodel_advertize.bea@msgid.xyz> <V3_CV_doc_datamodel_advertize.c7e@msgid.xyz>
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
2.55.0.13.g335083658c8

