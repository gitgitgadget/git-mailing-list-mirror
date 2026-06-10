Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E435F164
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781130215; cv=none; b=ZqkdfaBqJKRuE2qDjUTSU2riJyYf+e6IXmvOUYEKmKaiJKU5/L8CbwL3pCPhSqOId9Y77J3b/tJRrnYkyDgQi3+UZ4HkW2c4oDMxx++apLcJKhtV14N1xqdtmfcgMB54jOcUzARtO7jdBLPESqM9ukU9FE1bGvMkRxoozQpD+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781130215; c=relaxed/simple;
	bh=jSyGX02dfNFCyQCF6UZ4X2nqsG204IjUFrEBZWa+ttU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bytV4pOsSA0cUJG8K5kAvG5XNcjfXmaHrUYtOi/Uj91ThgJwUo0HoU7R1MBz+HDFUvDXOL3cw3KBi801R1Ys/96tDy47+pVX2W5bx90IylhKFcPbn0eAxZg0kcp0tnR73WuunzkSNuXoLDEh4VQPJ4INhsIv7ivsSYrvLVf3G1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TMzmwAdk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bkl9aRfN; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TMzmwAdk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bkl9aRfN"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 682A21D00078;
	Wed, 10 Jun 2026 18:23:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 18:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781130213;
	 x=1781216613; bh=6hTjWhIxAil8q8rCM7VIvOlXnT+vX4zfYAiLifVBMEQ=; b=
	TMzmwAdkpjxquv8CAwXWAE4unZOEBYuNF4uowY8ADKHWXuaP86oMxgSM62fvsi2t
	+IBOfLUY7XDEg9AfIY8uDAmlbAIY79+8g4W0njBzmEiFktAvEl0/bk7ji599u5K9
	yVzD785MBD4pCRFcoHUbmEiZ0uaI7ytUlxLQgiR3QKYqfhTd4kOGpa07cK5zUM74
	I0515smjAWGT9Y5aSBLsS10hNHxTgV2ffkzEf2Ue6c8jZEG05Vz9fppGhcRQ54Ba
	hZjIHw1ZeP7j6QYxqDm6FcNJJfvjyKEMPkmtX3aL943TYfJKrNPxuL0xMFmyzVL9
	cSu0LR1NTWaXUTwx8epXkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781130213; x=
	1781216613; bh=6hTjWhIxAil8q8rCM7VIvOlXnT+vX4zfYAiLifVBMEQ=; b=B
	kl9aRfNnRv5h0llBmO+2rKSh8WpvDfBZ1OHPy2NHtMGtu1lGRBHHDW30zyFjRgC+
	Xc0MlbVI3zWZ7qWQ1qxtbcgkSDpBzDdjAmHnXhfpO3I8o1Zm9hgzcVanV1n4h3Ld
	oQGiW/G4UZVw22OHu7FKjiEB3peJxrH0wEEGyhRUZ1UO733XJaESGreMnGSz0ypb
	6bQ+TVxu2XInYQdlWpTqg8v8dOJeaKlu3a/STXYmi+TrkxzW7h9mvSGdP2JI4O9w
	SU/31HzL5JrUvMAugwa0d9MgYMBLE/5ld9XwMTSt7GaMhV6JfCdD/F9eFi+Ooogb
	7EAGgb0YG8CUaEA0nLxCg==
X-ME-Sender: <xms:5eMpav_cgq9R5FWNNJ0qZdccAg7TzR_VCWJjOgOd9lvK_6C77uaPgjQ>
    <xme:5eMpahvS7AL1OgBVqHKdv3yQeEgO7bAsyfl-9_ZFP3IP02ugWwtN_LV9b-Lnw_fYH
    McVRjdCdNeEP3uyls7kTRD7wb4mNDZkb7xyQgckwIrBNS-jXvyRBw>
X-ME-Received: <xmr:5eMpaqqtxlJcYZpRZ4a4DBnMpC-0wXt2NJOMvrQdqKGTyYZCqWec_2fIJiI2B_TesVuUA_J1-Ag2_CO_JtDiYD2sJ61eOvnrZaMjWbqCjkzLh8n33DjQImOrNQ>
X-ME-Proxy-Cause: dmFkZTEuzp3KKBn7AMpNkiUqx7nkmzpOcQnlZKh+EjhB0tl2hcQWLy/Vp41mo1Uy0mK2OC
    saFPiNrE/21c3YyBIP8u6dc9vQQGza6H/29w5f3nyKbgA1rsGQsG5sDcuFQeWxO6SEacGf
    SUd544wv1Z7K/AfH/15jIj5T8TBXnTX01CztV+3qCw/WC+tftNgIHB0U5FUHNOUXAixbkK
    5E4pn5FkC9EzMPz/heteaHmUDvhWlMI7PdmSZQx+ktMZdvimnyepM/Ku/ivY4VKQSq4FYI
    JXOlW79tVbM4aor6rIneEz77lvoEhjSVUG0VhHehozL9cQSgZaF4nqqYWWwsmMWXr8IGF8
    iFlA9W9Jk7RAlesVLrAKBglEi4wENiOFHZB7bhB967Zbv5GCSGjAWvr44dZfWEA2nV7ygH
    6FLO2sI++i6eotdI5h/7u9IKa9/63UZ69ItD/6pyuB39VKel+TWyKfiNsU/KC9H/PAqu/6
    5tQJnHUimPGE+9cPivoaj9CLBndQpkQUOxT6XuCVQJ2h2KegtQ2VmozXACe/Ep/ImGZSXS
    dfosoW5WthWlZDLeh4XGOmloK/o/E71QspMYRY+nVnGJBROl8EEfOzajiGDE28mrMbEgg4
    WFtaulLcTfxO15qtu2stTitkOSv0b7SR6Us9Qomaa0c10q3pHtchDB1QlsIQ
X-ME-Proxy: <xmx:5eMpamn2MGu1izKvQJewe3edPj-nh5tsvg7LNdzlsbbEuTgCbIddBQ>
    <xmx:5eMpamy-zcETZr7DKtyLhyb1HV5gKmRHQU8rX5x4Jpx3_Y7uvjWY6w>
    <xmx:5eMpamkH1y5vWT59PsIe07gPIiBTrbZ1tRFQju2e3-t7lCqDQqVdrQ>
    <xmx:5eMpancwl-Bw_uyWa6y0xQmoQa5pXks4OFBkl-aWy5Ob_3CoHymmuw>
    <xmx:5eMparVWnR4vdAbiBU-saWYVNb2OXqlMAPLuKz2F4dlC5qiT1gB2_QJo>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 18:23:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/6] SubmittingPatches: encourage trailer use for substantial help
Date: Thu, 11 Jun 2026 00:22:44 +0200
Message-ID: <encourage_substantial.8f4@msgid.xyz>
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

Trailers beyond the mandatory s-o-b are regularly used based on my
last two years of reading the mailing list. Moreover, reviewers might
encourage it.[1]

This is also in line with the project crediting both commit authors and
people mentioned in trailers each release; “Nobody is THE one making
contribution”.[2]

Adding trailers is already encouraged, but in the section `send-patches`.
Let’s replace “If you like” with outright encouragment in this section
so that all trailer discussion (except s-o-b; see `sign-off` section) is
contained in this section; a link to from `send-patches` makes this
information equally visible.

Now we need to make a heading for `commit-trailers` in order for the
HTML output to make sense.

At the same, it is important to temper this recommendation to a sign-
ificant enough contribution; in my experience beginners can be eager
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

