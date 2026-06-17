Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCBF35CBCB
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729572; cv=none; b=FTksBr37/jORN7Y8Rvy+/ljucAUY8Nkzj3JWsTupY74/C3mbAiIjkcCnXQ3/t77Gdb2+G5uArk4wu0iUPyyBs9SdeQ3Ktn3kVqd/OmPv8iUmsGkYUfhZUYL2p6Hno5WGRjUnrhdXHMbnXPbXPOrIxPErmPpmXiahGr+Yk3TpHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729572; c=relaxed/simple;
	bh=e1BmbRqiHQUjxZFcxhNnEctsoyMAklgRQIrD6cxqVwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r++9G2g0ywVHsSyl2h/kA6SPQAK8hgO5gs757lKPby/aJPr//T5ZDmNvYflXoirglgF6JaxhmsJnV6+EEzdHo0YVte5PgMftuo+xw6dOiLVMTYegpysKU3wks0G/xf+6HgVdseBJji5ZWoipyvo5r4XT+LDtS5ZwBfTpgcQDZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=FjHIZUUQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GI+Snr3O; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="FjHIZUUQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GI+Snr3O"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3ADBE1D00081;
	Wed, 17 Jun 2026 16:52:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 17 Jun 2026 16:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781729570;
	 x=1781815970; bh=/4OHZ/0xouwgUyAb4pm0SmTETX+mKWiaahcV+S2/eDs=; b=
	FjHIZUUQin9osvV7wA2f/+YolStSYwWCO7aWMDZ2bA2P/v+z7SGAr+t5lMWfidCB
	ve/ywdGSWkcGg38OfoIghsAFip0F6QB3bnFBGwzRmAsgSjA1+Gt1tPrUmoDSw35B
	OsPcwogXY5H6HW6yubzEnpYvdAl06yxg/jDDVUZeemi7sbl36YB+xEyYjo4ure7g
	poPKv1RclALmC/sxN1R1aWWzf5W3CmE/uMHFrKscY5InOkLMSOlO2KMSUL2wtNXI
	UtEZskxpCz9jRTukNyPFawqUcY3m33yFLeJxo2safFd+3G5m+SvTr3VEp652rNaM
	tGr+pBMlRo1kH450Vob33A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781729570; x=
	1781815970; bh=/4OHZ/0xouwgUyAb4pm0SmTETX+mKWiaahcV+S2/eDs=; b=G
	I+Snr3OiqsqfnenSwErgZNjDNLhOezW79ZFY+zQw4ze/dqpU2ApHo6PbMwEC/qWg
	NvAuQQmceHqthaN7amLU0FUWNgan3RNO7KCCIMjn03pHazQcBA030lRUgZ/OJSnD
	PwFlE6MWL4Xucssrv8jzOyfRtWhwlxsrhiC5TgOZKjce74MHiq8rO05nDcgqqFaa
	znaqqM9CC2/sC7s0n39zkype2k/BOWUn1G4+FDhPAT9/HP5XPE59+muWZdT0ONGP
	shcSYiUjnMqKeQ72Ffoy2U9CDte5OoaKotnt92JtmX5cBnH5wbkNvNyahOEfrbim
	MhYg2hgtSok1REzppIj9g==
X-ME-Sender: <xms:IQkzarrvFGE54GBR5JPk-k3C6cjb_dNs1zx1p6YD_2TZZLbXwWb9K3g>
    <xme:IQkzatEllSJiHGHe-t2sk-Z78QHSzTdcTtCrmqRHFpm7-XXhP_wcY4nh18HnBD0To
    Oh5CjeTifJkz8Xuy5kdedy1WsAKIhr0cNYCK1yI6NGAv4Q3zGFAYg>
X-ME-Received: <xmr:IQkzalnopAg3Mm3MPme8ErLHis_K2rdMp9YKLDjImrmkqh3G_KnujgkF_-5yOPtXR6oeEvCzK09oTnDQz_mvf9ZCeZdoCrrXkVB6IL4t0SUKyqdRO3lh3L6Huw>
X-ME-Proxy-Cause: dmFkZTEAjnDpsbzRqsIgqUIzTdGUdXEO+h9xpm0hY1dN4LwFENS4EJFVcwuriADNcp6bdK
    ReECXoThdiibEO4PfBlP4EZnXskCCGlFVljs+QWTGWdugrTxDeB0xglwngo+ifMTgYfarg
    dA8ezCyO/zUBY+ncNIiaTrvZsXuM+ybLIYaakNkHhC/Z+8BimpUvZkc83uOptf8kqduXAo
    zEHyViJ/quLL4Bz5PgqgYjvPd7TVfYmOWXM5XYT1NuQBsa70xgL3e1SfTupjlqKq4l895F
    w6XoysdE1Mac2nkUaozitwcXWPgBF6JBEm+nS22v5pUf890ittmxrHoz6cS54+jIjKWiMa
    RnuuBwoXxMiHFg5LvQmAIy6Z/uTwA1GrmvaXHONHRRD4YbajIUxsB3qF/YEqzsK1JoMLDl
    sY+V6ZA9b9X4DmXjW4XiBRA6IubHKmX9cjTBgXgO1caqWFbNeJttyoNyrq0qjxX5qBjxea
    N9zJZxROW6tve3vlq4wpNdI4V3/xYgmeOBP3WW6eHZA1v88o6KmpNnm4Ame2xlClxf7ZY1
    EA+wnfD/Hk0Z+SCUmIYRp08INMdUS/dXs2EPn7/pzRSo6OCGdokXJWz9Onx1B6cD5zAb/d
    s5iVch9YdOgck8mCPyzISMz9bOoibUjq1DLyg1qOL3S+0bzXbbtrbMGCnHwQ
X-ME-Proxy: <xmx:IQkzaolnzR9iy_4d-AnhaOvd4XYtf-ZI3gcmAnBbPKaQOHJ9c7K6ZA>
    <xmx:IQkzauumJ8BXAxxTr3P2GImWTYeCsOrjbrokINX0aZBQ94NUGSELvw>
    <xmx:IQkzajm1DiakiO8VuroYyTxOUdFSFJjTuwMZTBNroRR4lBHMQe5Z3w>
    <xmx:IQkzahtpc1cT4CAq5KqVW5otOKFpvNpJzhRzVB-nr7C5QXwMWp-0Wg>
    <xmx:IgkzalPQ1KTSgtG-SNF4tuXCt-xto1axKXpUYriX67iD-zI6xOqa5rEy>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 16:52:48 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/5] SubmittingPatches: encourage trailer use for substantial help
Date: Wed, 17 Jun 2026 22:52:15 +0200
Message-ID: <V2_encourage_substantial.9b7@msgid.xyz>
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

Trailers beyond the mandatory s-o-b are regularly used based on my
last two years of reading the mailing list. Moreover, reviewers might
encourage it.[1]

This is also in line with the project crediting both commit authors and
people mentioned in trailers each release; “Nobody is THE one making
contribution”.[2]

Adding trailers is already encouraged, but in the section `send-patches`.
Let’s replace “If you like” with outright encouragement in this section
so that all trailer discussion (except s-o-b; see `sign-off` section) is
contained in this section; a link to from `send-patches` makes this
information equally visible.

Now we need to make a heading for `commit-trailers` in order for the
HTML output to make sense.

At the same time, it is important to temper this recommendation to a
significant enough contribution; in my experience beginners can be eager
to add a trailer for everyone who replies with an action point that is
followed up on.

Let’s also spell out that these trailers should follow the Git author/
committer format. One might naturally just write the name, but in that
case it will not be picked up by:

    git shortlog --group=trailer:<key>

and normalization via `.mailmap` will not work.

Also introduce the list of common trailers as such. Granted, this is
already implied by the later paragraph about “create your own trailer”,
so this just frontloads this information.

† 1: https://lore.kernel.org/git/CAP8UFD0POvYDgGtEx8GBhvKkd8XzzWQsy8XxAKL9M3+uz3ka+w@mail.gmail.com/#:~:text=for%20at%20least
† 2: https://lore.kernel.org/git/xmqqzh248sy0.fsf@gitster.c.googlers.com/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    • Msg: proofreading typos, dropped words[1]
    • Msg: Avoid hyphenating for linebreaks on syllable[1]
    🔗 1: https://lore.kernel.org/git/310ef65e-b6c7-4d0c-a58a-0c88257143ba@app.fastmail.com/

 Documentation/SubmittingPatches | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 176567738d4..0b12badf86d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -443,8 +443,16 @@ identifying, and not misleading.
 The goal of this policy is to allow us to have sufficient information to contact
 you if questions arise about your contribution.
 
+=== Commit trailers
 [[commit-trailers]]
-If you like, you can put extra trailers at the end:
+It is polite to credit people who have helped with your work to a
+substantial enough degree. This project uses commit trailers for that,
+where the credited person is written out like a Git author, i.e. with
+both their name and their email address. Note that the threshold to
+credit someone is a judgement call, and crediting someone for simple
+review work is certainly not necessary.
+
+These are the common trailers in use:
 
 . `Reported-by:` is used to credit someone who found the bug that
   the patch attempts to fix.
@@ -562,8 +570,8 @@ when the maintainer did not heavily participate in the discussion and
 instead left the review to trusted others.
 
 Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
-`Tested-by:` lines as necessary to credit people who helped your
-patch, and "cc:" them when sending such a final version for inclusion.
+`Tested-by:` (see <<commit-trailers,Commit trailers>>), and "cc:" them
+when sending such a final version for inclusion.
 
 ==== `format-patch` and `send-email`
 
-- 
2.54.0.22.g9e26862b904

