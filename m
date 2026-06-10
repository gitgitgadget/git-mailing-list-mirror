Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0540D580
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126590; cv=none; b=As03VEKcKi0YK8GoR1H7ydEm3+Vs/cucWfOxxCkQBaogSp3MVAlGwh/+yZqGhhtqDNOfg1YU7Vm5im/gY/5uNIMa3bAz808fEy/IpTs0+HtZ2RK7B9NlvLk8H/P9NTSNt+Spx1/6BFBPtDKfqpHkehVINfzuGRnuPo/hPGRthps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126590; c=relaxed/simple;
	bh=KEUeetvBmqco//hb8irzdmN8VmjqKCdfBoXQMOulP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcuWA2Uu3TszfO/xxgz3lKAm2lyoSmQxRO9poO8QekOxNBtZ+mEuKwhdka1fsX3tHcHOAtVTYebpgu1fMabdeBNmta7+oRjMufNavBKUzEynFTA2GhpSFuA93FYn22p0NG4Z4eCvheM9UHc3MPce2FZauPmechWE5X9lPJMg2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GAN0VZNs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RUSl1ycM; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GAN0VZNs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RUSl1ycM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 426B51D00077;
	Wed, 10 Jun 2026 17:23:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 10 Jun 2026 17:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781126588;
	 x=1781212988; bh=jxrKangvivPusp2obsixyHt3aGOpoZw5xvjgh6lCr0g=; b=
	GAN0VZNsjQFO2EOtTDdLeCaEgYq3wYmuQBA3j1Nj22FuQDTFYE/L//Tz3mrrQFa1
	J2fx3JokIznP62e1ZNClCtQUeKDYRdPiCKDYSqrV3EJ4eMNo3E4F+ZTU+qu4Y20T
	jDEOt2xYTPKgSIHAk0C0pt52WmYeEY3WyFdxz5ExnJwutrsZJckhn9b8XoEavXwB
	yuc2kEBlskthcFSikpi282iQWm2W6zSqBhmwWDZT4rBin1zOU/eSrgFzyrf0fW2I
	kf+yKg3te2qY4NnHEu1X75xaJCPvCr40UOJBG78T60bH7pdBf8IEqyCuZRlhdk++
	jYSDNWuvfQLbBtP6nD0BeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781126588; x=
	1781212988; bh=jxrKangvivPusp2obsixyHt3aGOpoZw5xvjgh6lCr0g=; b=R
	USl1ycMqFjYPYYw8fwR4n5rzvYxId4oavUIYFICmQiA+Odg1/z+69XgjmkdpcVZl
	mwnIr/41kvCJc80PoyvvOlLPXzOH6zXJAmQLE8RfHQcr8sbMz317vht8SR0rLXXj
	tN9z+BLQgmseisSmIG59JHLCHxGjNbfrkRWjPBBM+TNbinG/0EMhfaHTt1mJyeUb
	m4F8Gpl+NUgep2Sz7SjFtVzXqNcSvwb5BFw6vpZ8IWHnxV9t2DY1x6eaCrfqncOl
	HIZcp0HCMXhTxDG3rOCos7v00tEEsK8uGzSAXUGiCMO81N2c3Qi3Py5HGnVBm+A4
	w+48f2zo11uvCA7XxoN8A==
X-ME-Sender: <xms:vNUpao7xHvntNTsilsHaCybIcaO1QS13ut6dGVENhdnCSC4JHP8rGa4>
    <xme:vNUpasJx6LDuMdAEZ_MMhJaeu9jw_nYt66LddfOK5X_CFKeEmlKsepRtCiWQmk5Yy
    oYY05iU_DfSMHJoAwMUAYGhLagXOUQIzOOscbflmdmdlwIn-y-2XQ>
X-ME-Received: <xmr:vNUpapuXSC_aBo1nlXxVFxKLqMTwsXZqi4uvsU_UTamfJA-RNBY8CfllxgJzQwvI8ziWlfdk9mdpc2Xizu9yxp3ZA7ypcdRnUs9bbiWKpw08xAUo6YeuzzMK2A>
X-ME-Proxy-Cause: dmFkZTEg1vhUucWyl77EAlSHnbS/tG/Xdyuf1fVvwxqRm5N2Kkj0nFdbLoRmSgOau6FJCF
    sOpiaPZWXghfSyLOC3wEFOjSiZQa8L7UGGb6qYVEjrfrm7SIzZv9CVhDa5aBeVCmPW972p
    SXsCZ7O7qqCndN2jJh5AyROUtKx3zScXsDOEbYMuh1olOFJVtOFtHBlsa1/kV2tkVIc1M5
    x2ergAsqdsLTlH7PbZeEu0x/llSIt3+39ky9rfErTf8+HVWrRUJOCLZFS3vHrWk+5dKTL2
    dgPKqHMqudwxzHU0py44J0G4KrU8jBF4qzAXyE8dDppggCQh6/RPJNxlFndEDMyG0v5mNJ
    HBGjLfj+U4bK5OVsQQhcebXh8A3us3DbLfhaXTUFRGkmXF9QPWytrbkddQmq0D+osNFxsz
    2qCdoQEafVhhirdi2UDnGgnJXSvk9DyojtnZRc1ME3J60XUBxed7HaaTT08d+oy5xm43Ar
    kl/U0xtUxNLg/eQy9zzZiIRoWXLKOuVlmppG2WR3myaCk9ZqBXJUo7h+Cr9Xxz2Rohi1Xg
    6CT8wn4ZnAxZauguHZXMpSPHcGnBsGadYHeMoiGn2NuTPMAVrMRXRESQ6zdKPo044bQMMc
    ke4ssw4OTDYWY20ciFQ9dTlZWl/le2Rdc/5YY9pQI01Ib7nCl92WpEQksiGg
X-ME-Proxy: <xmx:vNUpajI9sRU8QyTdP7HDMZK1g8qJ7AViBQXqnQz5ymH9m5WFjFZhsg>
    <xmx:vNUpaq_OPoeQa3qu1-EfBwtiCg0PB1QZkQEHnHUpCTYiYPm8tLmKqQ>
    <xmx:vNUpakyaEKGpm3qIoX-wH-KGqmBT86h2RHcNTGTxFXRzaIYakpzkmQ>
    <xmx:vNUpav5VnBjq7gHH9UPKom5CRSc5OTb7tukgRCqcnte4N5R4XOQDNg>
    <xmx:vNUpaq2rvMKP5U8ox6NyBmRAInRsVgOQj4PcsaldRDeLUsL_VuXi0he5>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 17:23:06 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	jackmanb@google.com,
	Linus Arver <linus@ucla.edu>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	"D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: [PATCH v3 05/11] doc: interpret-trailers: explain the format after the intro
Date: Wed, 10 Jun 2026 23:21:23 +0200
Message-ID: <V3_trailer_explain_format.8a8@msgid.xyz>
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

You need to read the entire “Description” section in order to understand
the full trailer format. But there are many nuances, so that’s fine.
As a starter though we have an introductory example.[1] That turns out
to be crucial; the rest of this section talks about the mechanics of the
command and only incidentally the format itself.

Now, although the example might arguably be self-explanatory, we can
add a little preamble which defines the format in its simplest form as
well as define the most important terms.

Note that we name the “blank line” rule since I want to use that term
every time it comes up. It gets very mildly obfuscated if you call it a
“blank line” in one place[2] and “empty (or whitespace-only) ...” in
another one.[3]

We will define the format of the *key* in the next commit.

† 1: from d57fa7fc (doc: trailer: add more examples in DESCRIPTION,
     2023-06-15)
† 2: `Documentation/git-interpret-trailers.adoc:86` in
     5361983c (The 22nd batch, 2026-03-27)
† 3: `Documentation/git-interpret-trailers.adoc:93` in
     5361983c (The 22nd batch, 2026-03-27)

Suggested-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2: [new]
       • PS: Suggested here: https://lore.kernel.org/git/8E736B70-424E-48AC-A6D0-9A8B091D21F6@gmail.com/#t
       • (My tardiness on this topic has made these reminders necessary,
         if only for my own reference)

 Documentation/git-interpret-trailers.adoc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 7329e710e1a..bcd79b19bd7 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -16,7 +16,12 @@ DESCRIPTION
 -----------
 Add or parse trailers metadata at the end of the otherwise
 free-form part of a commit message, or any other kind of text.
-For example, in the following commit message
+
+A _trailer_ in its simplest form is a key-value pair with a colon as a
+separator. A _trailer block_ consists of one or more trailers. The
+trailer block needs to be preceded by a blank line, where a _blank line_
+is either an empty or a whitespace-only line. For example, in the
+following commit message
 
 ------------------------------------------------
 subject
-- 
2.54.0.22.g9e26862b904

