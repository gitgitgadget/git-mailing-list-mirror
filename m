Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1922C9D
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781847956; cv=none; b=IywmQrgGObcSc9u4ztrZON7jas1bYYXcVlYWPphgaW/mpxrOposc9v12Kieawoo3A+WlkgXGYh3BYqikpslr8SfiYI/WkckZvyciaAzMzOEt/+1wLNhiHTN4B0SKcP2S9ceSXtamLe6Qsd1GrnEroCIhQ4WjqNOtCPhaEKMNwHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781847956; c=relaxed/simple;
	bh=O86/eUEMAmliqx+lUmOQ4CTgTgKgWy5e4peW+J333So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5H+dzseFpi0XliVRRMD75X3nPWB5pRqnR2xJhNiFW3TiD+ECdpwuz60rrQlBG1LdXf+6rgkwp5a8JidWUmaCiL5GrknGzK+2NahC4O2fumji61R9KJ2E8DwUSi1P7Aotr8bCeRvt8iVTSbS/0DYZQ7tLkNLKPa3u2KSOMfei0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kHkVqDJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQX6tivn; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kHkVqDJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQX6tivn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5C48314000B2;
	Fri, 19 Jun 2026 01:45:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 19 Jun 2026 01:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781847954;
	 x=1781934354; bh=ITXB4AtxTmwB5YRp7P55q2HFTSkGosouVW/hS4HDhxY=; b=
	kHkVqDJJyHDf0yWc1+RdMDmd7p4HpKdGrbxgTxoOGCRnrRH7d5+oDFgybWdUZk01
	cKOKzsvmJSB+/bYRoJbZM8ZAhCpFrFpmaLkwbPhB5aqwZNqAoRBo08yqsZAzyIGM
	g+66bAkda+uoKgR8CSNCGzpNBML6L9vgjupYwnBVz207x5c4Ic6hAUjpvuAXmWYZ
	KEtIzQW6E/CUp6TEpd2ZlZyf/QOrowe1OgjEFAPo2Ln/nk6lSCZrQf7R/DDeazaO
	093IanVmRtM+lo028shtw7nmt1LZB6ctdcoFYz/gosvTDB6PA2jGqvzDzRrUGVdC
	cAvgtZp+3Hrfqc59FBm5ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781847954; x=
	1781934354; bh=ITXB4AtxTmwB5YRp7P55q2HFTSkGosouVW/hS4HDhxY=; b=A
	QX6tivnlGRdkgMSm8rtK7u1e7Dj0f/HRNf/8CPuS1Fugmk7eGhzzKWRdHQdAeIzZ
	W6f+6yK2G5Wex4i/FNN8TzswGOmpOA4CKClw0X8V4NaaaRLafQFges1qpUSMzBrd
	kfIzWlhSNTQcZPBdu7w5sKhyMjzWU96axxpOfmDHxYN4QzgNZyZ2vex848+9+iIR
	kCnCmW1Y9vqf6AwKCmiB5js/JJeUTUbNuncDLT4doV+pW1JV4Hjgv3uGdJGxC43T
	2zCnJUSj7CTm7YEfq6/K1bXJzkEFZpRYa93sCBQoDUDw9A7rWdC8yXUTok6Q3xKA
	GcbkLHJZ5DKCTOMVI+swQ==
X-ME-Sender: <xms:ktc0aoptWOj9ypj4D8rncIB3Jom4Fbt2qzIQi4V_llhscjh0E2UHtb8>
    <xme:ktc0amGXGrn3DIk4YxLsCtjDkuB066N8jws7-a3PGR1AsvsLsWWvn1_K8nWOmsQ5i
    AJ3unGu4k6zbV_Lg73WaBNpfNVvCS_I-AcR7G1F8DTUFob-WymwAQ>
X-ME-Received: <xmr:ktc0aqmiPZThn7l2i84M1yXAk_Xg09WI0wXgppd6gODw4ppEdvgAgCVMUy7S63CuEoo5GH7cjK4a4R9bkS1Q5gVleDqn6Dy_TwFMcKTd851Wte0>
X-ME-Proxy-Cause: dmFkZTGZQEK4KEvmdy5HXBpi304qWvpeR54M7kR3rn0yoepEgJ8kjc8dWFHDjBXYjGcf6Q
    hHYRCiCpFb3sA0l0AmyruiiZKzumtxQ0lSixR9NZEj2eKgXD2xYAiM73Eqe9DBG24MgmY+
    gVfT8zJEpcqqxPdvo5uo5CvgRbXz52iDVwkZ2jAzywYD1MpkaqUQUBu1fcUkqduX3ljzjb
    qe0sZzkV1D66Lzy/KIksNF2z66uc3od/ZMqWi7fH84vVTUkFoIZVvlNEvr+MEDnw3KitK+
    kwe+QswTYwm4uoT6dGM+hMxJKs7gaPqIv2k+Pc6L/bnZgbhR2wN8Pr0YJuIyHxYIgybYlr
    z+77hJzUH9tkj9csLoCCS6hzbnS2LOsl5Ti3G4wdkCQ5UsQ47zvD6Gju4BtOI7PRfuUpf0
    o1OKQfFTl2HfDrbMOrH6TN4qKdXdT1nPVY2Bq34+BN5I9u5A7rrRwk3nCSiAIzUVlyfiwj
    0Bx2iaNwjK6r1Yk1tdI4EPS5PBL8iL2zxvyu22kO9MvMmd7CYplvvc1tIFXEorVQ9dFuuW
    sC3a9AERcUpdhmjT8n7vkCvSxt73Yo6Lynfq35xHxn1+DDxXVfg0qw1XOMbm10F2GASygR
    iXChVJq6KaEX+94uSshZaIQPFWa1NpFcEQBiq8sAeul0t5I1LnUUKf0VEy0g
X-ME-Proxy: <xmx:ktc0apmb-OgqUENWnRwmgG8LlBTF-q8kgjsYq9k_FJrCUFwxsILTvg>
    <xmx:ktc0arsxExfs_P09WY6UJrHS-eK2pj6eedl3CNiryszSq9tBka-IhQ>
    <xmx:ktc0asmvzx7vigm4rkKkOeBfQhDm8fmeeVNLthrHZUMtyqwsinggmA>
    <xmx:ktc0amt4e3_ro6E2PSOi26L-1Nsg2kdRqJKyOtcogOdorUiWBqHg3w>
    <xmx:ktc0auNJQq3nlHdMxchuy-mqTKrIWkd-ocsaCimybmxgwdSBrasElkZS>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:45:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/5] SubmittingPatches: encourage trailer use for substantial help
Date: Fri, 19 Jun 2026 07:44:50 +0200
Message-ID: <V3_encourage_substantial.9ed@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
References: <CV_SubPatches_trailers.8f3@msgid.xyz> <V3_CV_SubPatches_trailers.9ec@msgid.xyz>
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
    v3: correct anchor placement
        🔗 https://lore.kernel.org/git/xmqq4ij0vo8f.fsf@gitster.g/
    v2:
    • Msg: proofreading typos, dropped words[1]
    • Msg: Avoid hyphenating for linebreaks on syllable[1]
    🔗 1: https://lore.kernel.org/git/310ef65e-b6c7-4d0c-a58a-0c88257143ba@app.fastmail.com/

 Documentation/SubmittingPatches | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 176567738d4..4e8dea4eaa6 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -444,7 +444,15 @@ The goal of this policy is to allow us to have sufficient information to contact
 you if questions arise about your contribution.
 
 [[commit-trailers]]
-If you like, you can put extra trailers at the end:
+=== Commit trailers
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

