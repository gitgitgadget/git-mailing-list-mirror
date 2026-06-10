Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0A3451CC
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130288; cv=none; b=DCDuYzSnHArWZlUs/SMwvk/vezTM+5Mg0VsjahfDgNsDLO/IiRjhhsOuLoQEe+cq1AL9ET5xaRZCghasGDr9yvADU4HGpuGKWo8CxF1LAvFheVNfXpWO+Qz1Jd65y+CHuOqWb44o9qYFu5Obl6L768/bLJbYnXkXGyNVyVg8NPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130288; c=relaxed/simple;
	bh=HzoS/zijBPYtZsmg1sDUr2czwtHiviJSHvViKc8rE1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLqb4WzQIRcGhebc8LQDZmqbQQDtIyjCnzi5BIzl0UUWuIE76y5UUFQCD2VVjnV6hSxiJRovCSKxnAYqwPi7bdK0KUo9eqbZtx9/GoS6p+Oc71gygl0EmlJnbpCadn0eheiXSl8IS5R4XPxAeQK0cBJ1wL9tERHktyEzZAe5myM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=v7+l3WrW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrfiLFMQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="v7+l3WrW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrfiLFMQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9A35F7A0039;
	Wed, 10 Jun 2026 18:24:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 18:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781130286;
	 x=1781216686; bh=w27Wy6m6FCkMNKExBShM8HIEo2gi9WL/j9U33E7cD9c=; b=
	v7+l3WrWDakDqXKWl3PNFZofSl++eoP24IUSkfsC5AR0vP6Dn7L2/PrQmXLY+h3u
	NckV6FoY1tpIW1xIKfs99K3o1U+wLl3fc3Hi3pEGYrT1UKOZcpI+Hota1zeYUX8R
	g1vWdEjgypJfQ73qdDuB+OCsIT0u9l+aOyfJ3RHU/nj0tEbARVle6kg11QBZolRT
	+TebqVSdGlowoRh37Ni8NUM6MNzym2pVEJQr2mH7i3DdocjM8+lVoj4PcVlor/6j
	z+CJYxtUQexvIKzOM+fwNNEt8tqbX2WrKuf98BpJaCYH+jKOR7B4sPv6mNTAhaQI
	JxgEYFR+zLIPzLTRPEdV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130286; x=
	1781216686; bh=w27Wy6m6FCkMNKExBShM8HIEo2gi9WL/j9U33E7cD9c=; b=N
	rfiLFMQ8Sf5BUPJrR723DTM/Z4zoAMYbX2iGp23VXot+kBrCfyxtWJfTtIHnqA3G
	//+2r3SMtqcFYXznlDOgJnrMHUfQzIbu8sTNi38n0NyRf5MUUz2m5i8vDEKvYNJL
	X5Q+agl6/3jrTACwvL4lAohs0bfkMvSOn42L1JOLPZo6eSHsBZLnqkSFpNwlUpMr
	L6Oyi1pA/qNHrG6JFxRt+Yf8EXRBEi1tmQh7i8YWehzjORP7RdasQo6rvy03wyN8
	VGZ03RuJVZaXowUzU6r2hdBHzIsfjn/IGccmINouSnmRAaKS6M7WcsTDyz/mCX9m
	feyYnU2ZZHKhn5SevVGFw==
X-ME-Sender: <xms:LuQpatk5P8bkmrQj1AKXVyNqZBvT3v2kLSInz-NfIyrbAbaZo62nJ5Y>
    <xme:LuQpau02hJFNZBXDM6dzXK60EGojdoIcvRcl2ZQlCKmL5upPT6b2MfNbeCYZrKs7A
    OZjPVizWaNn7ETqV2UCBy7OS1zsKOQGF-tROVpx2sCbEXhM9_bhlA>
X-ME-Received: <xmr:LuQpahRHaRtQ7Jcj16-C3cau2GkE1WNeQvqvSnIHLbFUmDbH4T0sppSUP5dP9FBsq8Qm0FNtf9j0FrkQejHw_YfWq-U6egYy1OurWWtcma325fzYngsU5N_rBg>
X-ME-Proxy-Cause: dmFkZTGrSoxKMDviHz/3NXLyuxJgY3r0nCaXhrF+/SCsk+7E7K1d05Eg3FWgUDWheCGCcs
    SmbzL9uLRg7xf5+luXp4UKYxIubETIDCKenZt/rSaFsCKuykQ/nyeEqbHdsy7SNmqD76Dk
    cUC6r/Wc3LE2upfleP1fLWYRlSIrzDMSaUU/QWutbTUSJJEAFWs9opYZlVMVQklM2OmRxk
    eppMF/3DUDlBz6ou/7v9RHDJfP1QePc0IVV+XI1W6aGjl/TAFtwUhZE4t8NZ9BVkJsWr0E
    CEYr1dC11yG4TOMmKsN3h7V07zcuAv4fXfeJFrx6NNtxUXjJo7s2qE3Y+M/JY7EUdCybdz
    fTgNsXNAxTiL43snMrcnZis+WM1WIUj5a3PboFbhDVgetsEGiT9chExm2cB06shbSLfdCA
    458GSIFsPEN09gA8Lju/tF6mDxe1TltLG8Ug55FN/MEPGPAJ/w41aSH3cb9lU2doxFiBQk
    RD6EgFkTloDLQYWRtP8kL8T+aNIuvQY4WIeOBqGBV1K9MiGy2isXCwicm53/f+g8iEy4PL
    mM5Q5xvVssdk0ESWbGe8sEhiSfbXprakhOyZIAudb1O+z8C95vbmmA1HziFZS2jEa0RosZ
    S2oFD1ASgBDIfvpCZZ3NuUFI421W6bals//yG9zPONRibfSJEYAqWgLQ/epg
X-ME-Proxy: <xmx:LuQpaouE-UcxIp1o_5ZrRq5rS4mT_2AFa4fFAlLXAXc96nJ_ExCYMA>
    <xmx:LuQpaubOPHZvPtzQY4k8Fepd4IT3B-dTrPx063FtKSZ20hztRJPjjw>
    <xmx:LuQpalunZsef00gNX0cuaQHz-Bh4GXWXQm2t7EMc7jhWSWApyf487Q>
    <xmx:LuQpaoG2iS5gCHbxyqqngM-6GyLPKzDbSx5aK96rUSYy133RaXyt-w>
    <xmx:LuQpao8om0T4Npv7ugrR0o89EaBRBdbIEWDKlnqY2SXrTvd2Spb0pocx>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:24:45 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 5/6] SubmittingPatches: be consistent with trailer markup
Date: Thu, 11 Jun 2026 00:22:48 +0200
Message-ID: <just_trailer_markup.8f8@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_SubPatches_trailers.8f3@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
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
index c1d12e38b28..3d2e9ecfbb8 100644
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
@@ -488,7 +488,7 @@ Other projects might regularly refer to other kinds of data, like
 particular are not used in this project.
 
 Only capitalize the very first letter of the trailer, i.e. favor
-"Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
+`Signed-off-by:` over `Signed-Off-By:` and `Acked-by:` over `Acked-By:`.
 
 [[ai]]
 === Use of Artificial Intelligence (AI)
@@ -610,7 +610,7 @@ Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
 how to submit updated versions of a patch series.
 
 If your log message (including your name on the
-`Signed-off-by` trailer) is not writable in ASCII, make sure that
+`Signed-off-by:` trailer) is not writable in ASCII, make sure that
 you send off a message in the correct encoding.
 
 WARNING: Be wary of your MUAs word-wrap
@@ -630,7 +630,7 @@ previously sent.
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

