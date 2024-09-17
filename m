Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3CB158D8F
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726567676; cv=none; b=rOdVHBWSOhbqIEukMOadnnzkoO+DJomQMcc7sVRuD1IOz9LZ8NFxVJpSRHOmJjPeoa9ZQqRceNf6rm9mTMbNzddtUFLefbFVBgk4oBT8Qr6mrmb0LTt2PRQm2lCbPVu5eYfFDM8ZxJm5YDG2jbassEw7UGaZKy4UXu0zPUD5s+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726567676; c=relaxed/simple;
	bh=gNdUOeS2b0oRdduoo2Vf04A4OhOAdHW7pIv5H+Sf/UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO6pQ6zyk2jvWwkx46bWSLFqsj/5S4I7HQD+ttN5qcLNZ0HwJVIXMwzXDldxbcX2yPex1puR7vT3c44XFXoKKLK7fBPJ8HzQBy61r0CZ7UWHOC1BL7bTJO04mh96QXJwtfycxpSNLOETdhoh8m8RUbDqW8QolzNoMcuw8QvOWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hYet1whw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UaCAf+Du; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hYet1whw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UaCAf+Du"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 43940138048D;
	Tue, 17 Sep 2024 06:07:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Sep 2024 06:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726567674; x=1726654074; bh=706Lz9rQKP
	uZ22EjS/DRTI8AmNCB8am0tgozCErRhIA=; b=hYet1whwzbn99ipAuEhFOElgh1
	9jRzsBJLPDn55vkuPhdpf4dMSLjnTk2JHQWC+dinwoab7YbWq66Zh+ZRNbw1qtwG
	SWQgL59NsBpx7Cax+3w2Q99iLi4jEJl2yL6vcM8S9GhXHiQiAbK/1GrXj8VgvGT2
	zvYJLEWQrM5TjT2i9PvywqeY7C7XyGdzQi9VSEo2pOZ6I7Fq+9o6jlz6Xpm36ASZ
	mS9oAtEo9eDq7NxxOF2hP9XBNsgRjIauNXzm7YM+xIDCKF9FaQPEuZ/nE7K4JgdH
	OfnzicyjilgBbUf4InR5Dx6PejULSVAIBJyeL+K9AZx+WfvxYihSigI6vcpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726567674; x=1726654074; bh=706Lz9rQKPuZ22EjS/DRTI8AmNCB
	8am0tgozCErRhIA=; b=UaCAf+DugArJC8sQPOOopE5G1Djr2uh6LiYWDtyCBxHh
	ZzpxuNJ0FV3mN4YN9Yipd8Gu7wbuUTTpDwTGmX/RZfs4wOEnbv0NhZrjox0EYRdJ
	V7khpW4CYCLZ7i7QOsztafOOnf0MWKky0jd/rS3lfygEpYErRTmkvwyAahAvqwGU
	CUzvJu5s0o6hxsPWSUOGNnAfw7tYjFqVD8V11lZ5UZGLiRiIAthGK6229jJ4EOt5
	U5nj97UgZ25rokqtCUO6QxELvf6eYpwizuxeZ7kZCWWIk0Hrusk+Pv76AlxAvLze
	U75ZNWdG9oYvwymDMywasB1dQl6Ab39qpMHRIG72yQ==
X-ME-Sender: <xms:-lTpZq03Ay7ALDNd_TMLISQA2Rts35zF1OfWub7BXjQTWROa2LD1IA>
    <xme:-lTpZtE-1hxOgAKw9jWauIMLYurnT_bJLGTtPob64VWJdz4TTd9QdVScbuMYeuzen
    JMprc6QXWVy27gr9g>
X-ME-Received: <xmr:-lTpZi7dtOH19S9XuM2g0WKrnDLrc5ADJ9w8VL_gzNrjp6VgL8Q83Lts4RzA0U9mh0tim6ZRGOK3MkIAGxfkIs3onUbPAO17-14_Kx6VeR_n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:-lTpZr3sBKiKjW8A5kfoQw91wlW6DTHaCJSFpOmrfKCb00S8Hwbvug>
    <xmx:-lTpZtFeSlfbEMGPIq6vUoZlcEfnZikxj0DC0HwW-bZW98_s6ogeUQ>
    <xmx:-lTpZk_BbCMG7QIxSIIhKQ_1nuHfyN_cwCRgP9IqEI5hXITqPgmnVA>
    <xmx:-lTpZinabPR6dJHnbHO7Vb_9q0jS9TxD19-9qQXZdRYa-LWMRxKHIg>
    <xmx:-lTpZiQVerHB6wlRrSpvbHCY1kqUsWvcv7qWsQyORVTy1HhqOg195Zcb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 06:07:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8dc16aa7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Sep 2024 10:07:34 +0000 (UTC)
Date: Tue, 17 Sep 2024 12:07:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/6] apply: reorder functions to move image-related things
 together
Message-ID: <a713a7aef0302a6c844fb36890c4ca60ad8a77f7.1726567217.git.ps@pks.im>
References: <cover.1726470385.git.ps@pks.im>
 <cover.1726567217.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726567217.git.ps@pks.im>

While most of the functions relating to `struct image` are relatively
close to one another, `fuzzy_matchlines()` sits in between those even
though it is rather unrelated.

Reorder functions such that `struct image`-related functions are next to
each other. While at it, move `clear_image()` to the top such that it is
close to the struct definition itself. This makes this lifecycle-related
thing easy to discover.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c | 106 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/apply.c b/apply.c
index 6e1060a952..9dd2f4d215 100644
--- a/apply.c
+++ b/apply.c
@@ -285,6 +285,13 @@ struct image {
 	struct line *line;
 };
 
+static void clear_image(struct image *image)
+{
+	free(image->buf);
+	free(image->line_allocated);
+	memset(image, 0, sizeof(*image));
+}
+
 static uint32_t hash_line(const char *cp, size_t len)
 {
 	size_t i;
@@ -297,42 +304,6 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
-/*
- * Compare lines s1 of length n1 and s2 of length n2, ignoring
- * whitespace difference. Returns 1 if they match, 0 otherwise
- */
-static int fuzzy_matchlines(const char *s1, size_t n1,
-			    const char *s2, size_t n2)
-{
-	const char *end1 = s1 + n1;
-	const char *end2 = s2 + n2;
-
-	/* ignore line endings */
-	while (s1 < end1 && (end1[-1] == '\r' || end1[-1] == '\n'))
-		end1--;
-	while (s2 < end2 && (end2[-1] == '\r' || end2[-1] == '\n'))
-		end2--;
-
-	while (s1 < end1 && s2 < end2) {
-		if (isspace(*s1)) {
-			/*
-			 * Skip whitespace. We check on both buffers
-			 * because we don't want "a b" to match "ab".
-			 */
-			if (!isspace(*s2))
-				return 0;
-			while (s1 < end1 && isspace(*s1))
-				s1++;
-			while (s2 < end2 && isspace(*s2))
-				s2++;
-		} else if (*s1++ != *s2++)
-			return 0;
-	}
-
-	/* If we reached the end on one side only, lines don't match. */
-	return s1 == end1 && s2 == end2;
-}
-
 static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
@@ -373,11 +344,17 @@ static void prepare_image(struct image *image, char *buf, size_t len,
 	image->line = image->line_allocated;
 }
 
-static void clear_image(struct image *image)
+static void remove_first_line(struct image *img)
 {
-	free(image->buf);
-	free(image->line_allocated);
-	memset(image, 0, sizeof(*image));
+	img->buf += img->line[0].len;
+	img->len -= img->line[0].len;
+	img->line++;
+	img->nr--;
+}
+
+static void remove_last_line(struct image *img)
+{
+	img->len -= img->line[--img->nr].len;
 }
 
 /* fmt must contain _one_ %s and no other substitution */
@@ -2419,6 +2396,42 @@ static void update_pre_post_images(struct image *preimage,
 	postimage->nr -= reduced;
 }
 
+/*
+ * Compare lines s1 of length n1 and s2 of length n2, ignoring
+ * whitespace difference. Returns 1 if they match, 0 otherwise
+ */
+static int fuzzy_matchlines(const char *s1, size_t n1,
+			    const char *s2, size_t n2)
+{
+	const char *end1 = s1 + n1;
+	const char *end2 = s2 + n2;
+
+	/* ignore line endings */
+	while (s1 < end1 && (end1[-1] == '\r' || end1[-1] == '\n'))
+		end1--;
+	while (s2 < end2 && (end2[-1] == '\r' || end2[-1] == '\n'))
+		end2--;
+
+	while (s1 < end1 && s2 < end2) {
+		if (isspace(*s1)) {
+			/*
+			 * Skip whitespace. We check on both buffers
+			 * because we don't want "a b" to match "ab".
+			 */
+			if (!isspace(*s2))
+				return 0;
+			while (s1 < end1 && isspace(*s1))
+				s1++;
+			while (s2 < end2 && isspace(*s2))
+				s2++;
+		} else if (*s1++ != *s2++)
+			return 0;
+	}
+
+	/* If we reached the end on one side only, lines don't match. */
+	return s1 == end1 && s2 == end2;
+}
+
 static int line_by_line_fuzzy_match(struct image *img,
 				    struct image *preimage,
 				    struct image *postimage,
@@ -2804,19 +2817,6 @@ static int find_pos(struct apply_state *state,
 	return -1;
 }
 
-static void remove_first_line(struct image *img)
-{
-	img->buf += img->line[0].len;
-	img->len -= img->line[0].len;
-	img->line++;
-	img->nr--;
-}
-
-static void remove_last_line(struct image *img)
-{
-	img->len -= img->line[--img->nr].len;
-}
-
 /*
  * The change from "preimage" and "postimage" has been found to
  * apply at applied_pos (counts in line numbers) in "img".
-- 
2.46.0.551.gc5ee8f2d1c.dirty

