Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E48A35CBCB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729608; cv=none; b=ogMZqmdnymyHlyLOXqaZjThJhd8Qd4FD9DYKz2bPhbmFeevKPf6JFk13Yfy43gZ4ufc7js7n1HDxbFgVS26/dlFywdQH54mjRSnen+GR+3FiyGBjzfohNsLqqoRtdWXKRolSe4Fj8hiTDMEG7fXW6Y9RYFi+VK5mq8Z2nUDv6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729608; c=relaxed/simple;
	bh=pIxPyvtgc7O9/wUXwebfeOMV/SEuj6ckh79ILzxGFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It2ekVIi1YtBtQwOdVvWCKnst0c/mmGflabF2tVsY7z6nc7mr6x/l9K/uoqOVQ6W9QkguUGH6xzX4f5IyGROLMkZPETAH0yJfl9hezfOEDzl4iheDg68tmQGtq5FcKY4lnGIN1TK+haKiBP8g3ZoBWrB0XaH2JWTFOsfz/6Z68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=y0ptpMmO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ec8yWSCq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="y0ptpMmO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ec8yWSCq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6EF487A00F9;
	Wed, 17 Jun 2026 16:53:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 16:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781729606;
	 x=1781816006; bh=l/NOszBSrUgIAn6J2GWxTPGAJsJegQf8rdl+7TBAuNM=; b=
	y0ptpMmOGGJJTasvldBdMwhs8SyX6NueqZV1+Z0dUJVjD7FBXz6npTr3zMOx2E0k
	VAGc7muy7iVJMVpquva8QRPMkeWJVQmePX+DS7tui30yoxha3Eq/wzkIQguzsyw3
	HR1ptthB44sujywk7C0Mus77yBuWIERzb3i+aZhjngyfvSrR9ilppO5GfjY1O0HB
	Xo75Aja4DHzNnS7Y7IlmGJEAw9+a0RTrQH/H7MomXaet41nt2FdADfUM9G6aHv4y
	MJd/66SP7qEaUkgW+IPWEficv3mrUi3nMe7G2vyGk+WHXWMaTSZHe9WHkq1y4ZmI
	b8TOZeDEbYZU1zVcVKqdVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781729606; x=
	1781816006; bh=l/NOszBSrUgIAn6J2GWxTPGAJsJegQf8rdl+7TBAuNM=; b=E
	c8yWSCqXBwrnuKQDkM0Ny4WBfby7OM04StLpRGXTGcuFD565fjgr11W0TtxAAO3Z
	yMkB6UBjYTcJfjk5zQF/6AKQaD6JjcXJhDxykLzw0KLtDLCw2K02w5FjIO65uHdU
	dQmxs9ut7vbYs6xPZIoPKcq4wGODHcU4DeRLZoCDs56T59/873i7ovP6pJqR6Qh6
	wxJJmuXpfMM3hQBSmrxeTdcBF5SmyOToRjxiE7Ua6hrouaPOxFVAtO+8qgaaTYsZ
	3ckqrb+JFNCClya4oTbWH3MKZFK8ugbW3YVPP6yfq4efVgfKxew0sZjYCe9P6tHy
	9fHQs8eyJozw9FZz8cGJQ==
X-ME-Sender: <xms:RgkzahWyfl0yQy3HUnm4-1ixDdj2jRMxYPCUJFlGQGJz0aE3uG9CzM0>
    <xme:RgkzapCoHraMde3lySncv7Y5ohTzSeW3gWr8NlQtOb47qNAak7-0WHGww1Jn4oHIL
    DfweoyiXA4UARdKrCPd_7hmLv7Srtlxjr8rus31nSiYsAT6Z_Jk>
X-ME-Received: <xmr:RgkzaqwtvY_j6tdpZyQh4txee23RZu36RgP4abNDufGRtFtxSBsEr7gP9exuILQotM2-2r2df53zsg6fPaq2aPt88Kb-WUBwpTAt-dKGsbg6MRuJNz9fvwDRJw>
X-ME-Proxy-Cause: dmFkZTEAjnDpsbzRqsIgqUIzTdGUdXEO+h9xpm0hY1dN4LwFENS4EJFVcwuriADNcp6bdK
    ReECXoThdiibEO4PfBlP4EZnXskCCGlFVljs+QWTGWdugrTxDeB0xglwngo+ifMTgYfarg
    dA8ezCyO/zUBY+ncNIiaTrvZsXuM+ybLIYaakNkHhC/Z+8BimpUvZkc83uOptf8kqduXAo
    zEHyViJ/quLL4Bz5PgqgYjvPd7TVfYmOWXM5XYT1NuQBsa70xgL3e1SfTupjlqKq4l895F
    w6XoysdE1Mac2nkUaozitwcXWPgBF6JBEm+nS22v5pUf890ittmxrHoz6cS54+jIjKWii4
    E3qYExktzl+IxNFxgLbPCV0p70jPox//md6/XoBuHJ+D4NLOu0k4gLSNMlakNrvTzUG763
    nsq0mgjtTJuevaXJpyevJkSJjZO4b3tu6SsGB9E1iRMWAbMxbrpXIISsCQtvpfrdhD1UTS
    pJrygwR7Pd/vvAChhmiQCWMCZAdP1hrUurq2m25jwI3e0tU+VQ922l36n3wdrfI2WLtJa7
    zTtFgEpMRl9euounPqbXpNRRBOvWrreVLLDc5FmuwzVCMFkdv643G1M9joxPFjAy1IOnME
    nPJuH2c1iIwUNXy4ZovTy5bZoAO0vvzxgW1Bc3HonU+BgHlKEgYxJToIaPwQ
X-ME-Proxy: <xmx:RgkzauB971WP-1jqBw3SiJYSTWXJr81v0hptv5cStCdQ6IfWw13o2g>
    <xmx:RgkzavZT8XaMgdXIWL7lCcMh0E4Yqi9MOcDde_zoY2djKZO9ZAu50A>
    <xmx:RgkzauhEiTsNSVqnsFcs9oh8B1Gof2SsihojEUIpfPangdPrUsnsJg>
    <xmx:Rgkzap7QDdH5dsb8OQiOFQII6rtOAfig5NSwO4XpuGT8k5SzYiMeRg>
    <xmx:RgkzapKeKXy8_js0HjrSUIlA0RK3n_unzxyeArW2hHEVC55T2PS-2zTK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:53:25 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/5] SubmittingPatches: document Based-on-patch-by trailer
Date: Wed, 17 Jun 2026 22:52:17 +0200
Message-ID: <V2_Based-on-patch-by.9b9@msgid.xyz>
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

This trailer comes up often enough and the use case is not fully covered
by the other trailers here. For example, it is sometimes better to use
this trailer instead of `Co-authored-by:`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Do *not* say *without sign-off*; do mention the precondition that
      it is signed off, and cover the case when the patch author did not
      sign off on it
      • https://lore.kernel.org/git/xmqqse6tnho1.fsf@gitster.g/
    • Drop “without a commit message”. It doesn’t seem important. A bare
      patch is just a patch, not a patch plus a message.

 Documentation/SubmittingPatches | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 38e18982aa2..4a37bc29f5a 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -465,6 +465,10 @@ These are the common trailers in use:
   and found it to have the desired effect.
 . `Co-authored-by:` is used to indicate that people exchanged drafts
    of a patch before submitting it.
+. `Based-on-patch-by:` is used when someone else authored parts of the
+  patch that you are submitting. This might be relevant if someone sent
+  a patch to the mailing list with their sign-off. (Be mindful and ask
+  them to sign off on it if they did not.)
 . `Helped-by:` is used to credit someone who suggested ideas for
   changes without providing the precise changes in patch form.
 . `Mentored-by:` is used to credit someone with helping develop a
-- 
2.54.0.22.g9e26862b904

