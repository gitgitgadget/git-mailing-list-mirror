Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15D33260D
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126513; cv=none; b=Jo30ArEN2YGYB/8e5vCVJ6v6cWC67+fuq7aYh9Hxk+IemcEH7lHtMVeac99tPOxftoQv6fl1D7MANcLBN4reKAY5jme2DSf7BdhkCY0PXrsBmDKKNzcHYu1+VaTUmuZ0TjLTOYNOFOu2aZRxfub0wuUJvnpmBEz7W014n7459Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126513; c=relaxed/simple;
	bh=z3Dy6mI28rzjXWfn2qWRAGrahL8VAFPoMyZ3RKFaIZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDjf0ky73gD7xleZ4tx4ewMzR+l1qKzwxcmGhSsT6esyNdp9z1zdpRzUdKZx2oUda93OZumLJRvVaBNDT7xSwCMj8DOLmsNNgAmisffmDPxlQggd4end8tP1gM7Ie4cOzbXkoC+kbd9Z7QaT5LTKMxqNxt/uLF2YJ6N7YHU1TDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bbaCHvS6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JrnIULiP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bbaCHvS6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JrnIULiP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 76F9F7A0189;
	Wed, 10 Jun 2026 17:21:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 17:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126511;
	 x=1781212911; bh=S2D/u8pkX1cGVYnoKcBRg0bTVFdYioi/kr7Usnf5hN8=; b=
	bbaCHvS6Zm5MjZu+szMpty7b0OfC9+dpc63iiX4kzBWDzrHc/0u7MQ5m3Wmb+CH6
	lGAHpSG/bPn5ZJu1fTEhrUFuwAmzKJp1l7aOW4VRbMdSh+yX90N2SUW7yfnDNj2o
	g7Q0hS66k6oS79oAnCmIOfkZuPVmZ4rgRHQGUgUPueVYOsEG7wt8JkLpCEo6LInZ
	3dN4d+0QvWjJC7piX9jrL+YMPWUWthOtCwbAsx/OFQFvIZ/G6envJHC9HHTnl/LU
	HXvbXBGTnLhYe1rQLfGyxREYU4ZCMLWjjZtAnzaGJDlPdb3E3d87Vw0sPPJ+7EjC
	+UsWfESsbm5GUEPPnujpcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126511; x=
	1781212911; bh=S2D/u8pkX1cGVYnoKcBRg0bTVFdYioi/kr7Usnf5hN8=; b=J
	rnIULiPZLO7CCnuZJnLJhtdqjVNcp1f/GLZaaGJr76b5py4lqvorHxAd6WYRsQe2
	4VS9QfsrMVlCuV1VUOHqY52eFl8qYRFN7/YYPRZEmGlzucyV9k8i6lY4CbrIpg54
	go+okN/eMezH9i7z7LWtC3GnMkW0K+8p/00hkb/m+cLRq/vgSUqCCleCf7xXbYK9
	IYmT63leXwzrRKzhXvT0uf0xSc66+o/MSVAnDYrKtYLJ3keZkEqOkxdn0EvRKrfc
	A181urmTOU7UUW1gTwsDqHW0PkEyIk/ED6fEZFOYVRfKOPUWVws0bvFBQ6vMI7Gk
	QAmyFUt3RJpQE0UorHgrA==
X-ME-Sender: <xms:b9UpalZvUwEae5gw7IO4rSNlzrEVpQub38ac19SizaDWZS-P1ChNoFo>
    <xme:b9UpagHtRrU2J5bckzUjtYrFfOxfl7E2Czd9AT5V8MvMzqdi6XOInppg-oiG5xx7l
    DZb3P3iinAK3S5YIQd_crSD9-9R9etXs9YV8NtS0Vf2NaJzVyoluw>
X-ME-Received: <xmr:b9Upahwq0YudwKNIgTAN0mZdB6gND0H13PwK_-DG7lq10sB3RlrQLY_6vrEGCQlAk3ZofbjMJKYCxTrIM-5h_8ZpXuhruBDQ_gBYx68fsiwGampqut9HKxXHew>
X-ME-Proxy-Cause: dmFkZTGM8QA01UnxDC4BNcc6JKPwovYk0t9ZDkReZpflRHwJx9T3Edm9QpbAStmDAuKKHr
    UlDhqytl46B8Ohd2MG/5IB3cjTzm9PQqbddTpHeriH/HFgG/j82HZB0kR1UzpK1xs/S2BR
    063pwJif6f69j+n3NcrfVk9M6zkofrK6j7xfWMaQrX2oPr8iWPtNW6RLgQeT7hoawrPMZn
    r3RAvWAdeLDRdmaj/lot74F7o//LR38w1MTiOZmSEWLptcqEvbVjU8RRaiIChuA8GFNCme
    dfS2LX8pORrUSLMm+F9oD7/BtiXZfznFiHwDky+PVJyczCX1LubGdcKtmC+QI1B5fWC6au
    m0LRPz8GdEo81ABEEqcJqCy//9yJTF83+8CZ4lz724piKWIVTol4qGMB2MR9oAVVF7WEgV
    7ydgAtSc1Oc6jOPKzfhGapmlxEEmOueRLxJxxjCVaWMBP8fjupthBDfHmSjAeTqQjjNe4W
    BDVrQt46IZ/N2qsjns9Rg9Jn7jayD2wevzJ0Uf3JijB2tkjM+eaC8T0if3sg5Np3Obgh+V
    a3OfjwMLEM/qMIUOv1+UZTAbsdwwdjjLt9M99VffD11jrBqG72jhWT07lO5zXDIrkKLFTu
    4RYVxvja/7zlWyQSAkCgNb0rEeZRkGdWiK8wPDFEzp0vZTzPTHLIG83rPUwg
X-ME-Proxy: <xmx:b9UpaqmFoXF4q_Xm8_xfOo6ymmiaIvmt8DcC56GvrAUkHcuLUAJBLA>
    <xmx:b9UpaimOHayPYakvV2_wQPMhVEx7mczue5YHd27QkIlbQg7RHp0xlA>
    <xmx:b9Upakx8SgElAEPCCYYvgMbvwQJDyzM6HN-hUfVZzPszLPJcVV6bng>
    <xmx:b9UpavqqewQFOYK4rojwuPynMMVQQxVpBhxaVAwnUU6hS8qyIiCsXg>
    <xmx:b9UpatmO-Oc0DBZvfkN5vKXd1jIFaKWoF6giyZmQpxoZaDnSGZCQBhZB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:21:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 01/11] doc: interpret-trailers: stop fixating on RFC 822
Date: Wed, 10 Jun 2026 23:21:19 +0200
Message-ID: <V3_less_RFC_822_focus.8a4@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
References: <CV_doc_int-tr_key_format.533@msgid.xyz> <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This command handles the trailers metadata format. But the command
isn’t introduced as such; it is instead introduced by stating that
these trailer lines look similar to RFC 822 email headers.

This is overwrought; most people do not deal directly with email
headers, and certainly not email RFCs.

Trailers are just key–value pairs that, like email headers, use colon
as the separator. The format in its simplest form is easy to describe
directly without comparing it to anything else; we will do that in the
upcoming commit “explain the format after the intro”.

For now, let’s:

• remove the first mention of email headers;
• keep the second, innocuous comparison with email line folding in the
  middle; and
• remove the now-unneeded disclaimer that trailers do not share many of
  the features of RFC 822 email headers—there is no invitation to
  speculate that trailers would follow any other email format rules
  since we do not compare them directly any more.

***

Talking about trailers as an RFC 822/2822-like format seems to go back
to the `--fixes`/`Fixes:` trailer topic,[1] the thread that precipitated
this command and in turn the first trailer support in git(1) beyond
adding s-o-b lines.

† 1: https://lore.kernel.org/all/20131027071407.GA11683@leaf/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Use `***` as a thematic break instead of `❦`
    • Change to “metadata” instead of “key–value pairs” since this series
      version adds a paragraph after this one where we dig into this
      term. And “metadata” describes the purpose of this format.

 Documentation/git-interpret-trailers.adoc | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 77b4f63b05c..1878848ad2a 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -14,9 +14,9 @@ git interpret-trailers [--in-place] [--trim-empty]
 
 DESCRIPTION
 -----------
-Add or parse _trailer_ lines that look similar to RFC 822 e-mail
-headers, at the end of the otherwise free-form part of a commit
-message. For example, in the following commit message
+Add or parse _trailer_ lines at the end of the otherwise
+free-form part of a commit message. For example, in the following commit
+message
 
 ------------------------------------------------
 subject
@@ -107,9 +107,6 @@ key: This is a very long value, with spaces and
   newlines in it.
 ------------------------------------------------
 
-Note that trailers do not follow (nor are they intended to follow) many of the
-rules for RFC 822 headers. For example they do not follow the encoding rule.
-
 OPTIONS
 -------
 `--in-place`::
-- 
2.54.0.22.g9e26862b904

