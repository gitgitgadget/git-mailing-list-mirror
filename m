Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F547FAFE
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938634; cv=none; b=HoG5PjM61YcNTsUfBB240E56o9aS0pp7pOaSBEXN4U26efqM9XTwFjTmzlTBMRDKjFF+Dtkr74Y03UqlNXwDZxZZqdDQc/4MYCMo3y2lpdpMFQ7jbCrF4f9dKMZfeU00GmlwB6mQD8SQM8/9YyZHsj39948fmgbzBHsEbTeeyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938634; c=relaxed/simple;
	bh=Y72M4KvMmi2YJxKHsqVcLPB4zWAkS+UvufEMjsY16Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkPln90qKYYCp5xsYaxDFZ920YzhCp3jfGUI2Sbkry3fiBWvzVUWC5bLhru7Y0ynsqOm7yE0Nrbh8blmTfvm0Qi/vM9/2XtLV9FX/ccxwo/z6d6ZPnuZz3qLTpzW1JmLr75PKtuMFneNuDGgNC+1RHZ0hBhHVG6QfnEOBcarMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CcHIAJn9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8htaovF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CcHIAJn9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8htaovF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1546B1400037
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:57:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 06:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790938631;
	 x=1791025031; bh=taX9u/NoB4n/YVASnqyj6z9LRWAY+v54IUh/QgmAFfc=; b=
	CcHIAJn9H9isS9WHxeiEVDRisJRsOK7cxKq1TxB/7ZQ7B/IQIO0PpUyRnuwChK6U
	EGDBXyxFi5B7sib3xE4sB4WnvsX46TbK4WKjbOKhH4VS+nD59WyU1N9my3UruacB
	juj3MrsW0PfN5sDHExOtgtEH9ApVaiEtQwDI6NJfNGxDI5X/7jSohRTVSgbWpCNO
	83ebnqUC81xU1aVTHSrNXUpF5zMlbZ6Aby/rIDuJ79vmZzs7qMnwrMd7gJ1PkNAO
	x8mNXjMpIcqBKpy8nupq+hXqegxyOOLHr14nUaJvM3Qg4NhYLJmeLVKTMn6emA0K
	gHAA2fJigrwwi0A6rRDZMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790938631; x=
	1791025031; bh=taX9u/NoB4n/YVASnqyj6z9LRWAY+v54IUh/QgmAFfc=; b=n
	8htaovF/jo8g6mMZ1OIpjS9Q1e5bwf1J/0/prmTKVul3czVi859uzPSOvIeHx0av
	MPL1AHJI1Rfucrn4K3NlN79Jn2IpZJ3I3SdKLMYZ13sQdZd4a1YNJ219Zn1Udfov
	wdG3/9LD+FTgfvDpgIXQyi/bW84NhA/3U2CelzYDt7SryQLn3mZarir+cd23FdaE
	5nzR07SBYcgbXvhkv267Ss54lTKPw5XEr54wU6mYMFjMLkveCxjZ/N5aQpqwn9lt
	JKyxtAiQFQ9w0ydmEeM/LMOvBMq6AvAYji+tm2Mo2lpGeiBIuAYev9FBMHFOsGhE
	Fx2eYKv8uAfT9yp1ru5Sg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790938631; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NnfFPy5VwaNIPLjM9m7sCv5st3OD5g6tkDxO8exnoA88mWd
	nv00imlgFdIcN+Pz6Tqs/m//1WMw5++660L2sbl9xa7OYUCLABuGklZGCDeGldXQ
	Ea53hvH8lWU0I8oWhn8bfvk6UZ7g6EkR8CLyrIJP8dhslDQ7n30MGt2o7+zORpTg
	T7yJh4vRDpRGtGUZW1nSKaZ84t24/XnBwfvGNFne48wYR/5W2gVXELFw1eC9Z6G1
	KBXJPKpkhmMpMhi3RQL2M12gZl+SIKibvSZAbjheDiK7Nu52yycq1rcQFX+bmtHk
	N7b8+BStcr2chrLVG+9iQKKr3y7aGYyIVsthj2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:TxP7hPqCSrtzlUo4adhDaRS6+fi+BpCu+ZnV13jMzb0=:Y72M4KvMmi2YJxKHsqVcLPB4zWAkS+UvufEMjsY16Lc=;
X-ME-Sender: <xms:Bo6_anUv4-D7yXQd6E7rEPSDMakWneMIuWte7opUdJyFye9-lonQZAg>
    <xme:Bo6_amkTaXZPC2x0HPHg_KwfIX-yv-VS7LSOT5fhcfOxNeASDMIKpAEfOeFFLV8uA
    azQkhFFE3Ir2KOx4yZHuYN02mlM60sDlrFAywVFyqgW6ePzHsKX>
X-ME-Received: <xmr:Bo6_aoan4zINBBQd3JwDeqq5Bq8KPu9iXJ482f2s31nMwHWnC9L8Disvzc3j94LKFAp9wxHmN1TO1LQYeSlZX9OwiKPXnfLDilrNBv8>
X-ME-Proxy-Cause: dmFkZTEfI990rL73GTGAmThdLxScm4Lczxc9Fcs2Y+Na5JMWw+rXvv8aVon2gm/ecJBvSu
    ujTcAXX8eoS8JV7O5th4VOAfqshrUKPgeALO1EjYiuPGDgffCIYjiITyQSvuI2CgEuyoGP
    hbnA6NLHumVU+9seipZONk3u+0Immk3l8J0raDnE6x8fLQQJZzFUzymJM3DyYhnpjOrBRJ
    fx2rIiL/SEQ21wMuNA0umU9eTUO3rsEReK1HhNxJAiFtCvVoKglshFGkZJOxzusECigdYG
    E0/QqlFzLGGNFHUbdmR8e2r3czg9ZYry4FzeVROZ7f+F4pPniGrherDL/ksSGW2TtnEnM+
    WGbzLGirv342KGHNY8SCyuj4whdURIr3T3Ax3IoNTA+iomF79o7Ew1iiEBFQzmoBA88vAH
    Oc4ootA+LPmdaimmVoIz5HKva+qTWVvWesr30fljuaU1h2COl3WnyS6tnaSClbor9Wn5y0
    oq0x7XChrdbjjsqDo9xJYRoHlN+AIV2pMuwWdJd3v1gJLJz7HiKXrsP5mPHHRu4CuEUeB7
    DudjBBJ+TCfTFonD05sAjmAQlSdOYcrjmrhmzJwYRg3AgYTRQMKEu7uZJw6q33+VGzL5VC
    fJ8OjnA0P2zEjmCmEEdOFj2SLHo7kxUKGFUBqkLuW5IYxFcxonetur08CXTQ
X-ME-Proxy: <xmx:Bo6_ahPGGLCEex1jO13ZjFesA8RH1LSsrGzgWYzl7Un00py6HBpnSg>
    <xmx:B46_atadRv2gCGl_G2a7H_JGzstMFOQT-8kM5UrtXs5sqizFpMmRIA>
    <xmx:B46_av3FvazEOCycj37D5WC_X27Rml2BuXWQPH-ZM3k9DcR2nYv-Lg>
    <xmx:B46_ajeu1X_3dgaWLc46WWLG7ZClsSBNW4Cehp5jZwP2GGW-IZq0qg>
    <xmx:B46_aj4xiwgl4ORpN8IFW_Jtdaxroh9KBWUud-VAKCPS3u-mx929p0jI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 06:57:10 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] format-patch: learn --[no-]range-diff-notes
Date: Fri,  2 Oct 2026 12:56:37 +0200
Message-ID: <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/format-patch-range-diff-notes

Topic summary: Teach 'format-patch' options to tweak notes output in the
range diff independent of what notes are output in the patches.

See patch 2/2 for details.

This is motivated by wanting to turn off range diff notes, but the goal
here is to implement it in full generality.

(How many of us `git format-patch --notes` users are there out there? More
than a dozen? Maybe just D. Ben Knoble and me?)

I have implemented this behavior for myself and used it for many
months. But that was hacky and only suitable for one person’s use.
So this is a completely new implementation. In other words: this is
new code, *not* tested for months.

§ Changes in v3

From patch 2/2:

Remove repeated and redundant `test_when_finished` on
patch files:

https://lore.kernel.org/git/CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz/T/#m06803e233a2e385e694432d45ecf402f7a67e482

§ Link to v2

https://lore.kernel.org/git/V2_CV_format-patch_learn_--range-diff-notes.cdb@m5gid.xyz/

[1/2] format-patch: simplify get_notes_arg parameters
[2/2] format-patch: learn --[no-]range-diff-notes

 Documentation/git-format-patch.adoc | 15 +++++
 builtin/log.c                       | 62 +++++++++++++++++++--
 t/t3206-range-diff.sh               | 86 +++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+), 6 deletions(-)

Interdiff against v2:
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 640c5dec52e..679a707c873 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -860,7 +860,6 @@ test_expect_success 'format-patch --range-diff-notes=not-a-note (no --range-diff
 	test_when_finished "rm -f 000?-*" &&
 	git format-patch --range-diff-notes=not-a-note --cover-letter \
 		main..unmodified &&
-	test_when_finished "rm -f 000?-*" &&
 	test_file_not_empty 0000-cover-letter* &&
 	test_grep ! "^Range-diff:" 0000-cover-letter* &&
 	test_grep ! "## Notes " 0000-cover-letter*
Range-diff against v2:
1:  977f9c2e97a = 1:  977f9c2e97a format-patch: simplify get_notes_arg parameters
2:  bf66e94e376 ! 2:  748759ca021 format-patch: learn --[no-]range-diff-notes
    @@ Commit message
     
     
      ## Notes (testing) ##
    -    CI: https://github.com/LemmingAvalanche/git/actions/runs/36231842902
    -
    -    This run is on a previous iteration where v1 patch/commit 2/3 was still
    -    there. But that is just a rename. So I compiled and tested
    -    `t/t3206-range-diff.sh` and took that as proof that the full CI/build run
    -    is still valid.
    +    For v3: only compiled and ran `t3206-range-diff`.
     
      ## Documentation/git-format-patch.adoc ##
     @@ Documentation/git-format-patch.adoc: case is to show comparison with an older iteration of the same
    @@ t/t3206-range-diff.sh: test_expect_success 'format-patch --range-diff with multi
     +	test_when_finished "rm -f 000?-*" &&
     +	git format-patch --range-diff-notes=not-a-note --cover-letter \
     +		main..unmodified &&
    -+	test_when_finished "rm -f 000?-*" &&
     +	test_file_not_empty 0000-cover-letter* &&
     +	test_grep ! "^Range-diff:" 0000-cover-letter* &&
     +	test_grep ! "## Notes " 0000-cover-letter*

base-commit: 1a3e64c6c4a623626ff0687008732a8e007e2a1c
-- 
2.55.0.793.gc667de3f2c5

