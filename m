Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665E1304BF
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726470608; cv=none; b=kQlNp3PL+68jcXxokK0j6b7nZLovltpfWSrNu9mCVVpJrLbwUy2lUAeFDp6LCOltLk01wk076ka2cunWbe3wbDCqE/nfT3ULftIUrNGDlbOFcgOZU9fKE1CkvgWMLEyrj3hQAW5A6WibQ0XeTV+xv5KgPKWJgj67VqqrU8uuy+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726470608; c=relaxed/simple;
	bh=3nI4CqOs+chapfnU4DQv1QfUIWAKuxEfOIDb/xmlOUs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2R4ZRLAPhV85Yq5LOmRD3lGQe59kVyneCPHS896yGlu4DWtZb1KgokSk6bSDy2tFIvwIomSHNOQD+te1YJSSEjT96FIXOtoXmYqhVV4qkdEKapV0S8nPOzN+FRN7OCmmWaEJFiRH3SmwjhsA1jmOjp5pYXMy8W65SDh6cXi4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jJCVOPyS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPJwrNDM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jJCVOPyS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPJwrNDM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 3BED21380295
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 03:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726470606; x=1726557006; bh=s6dqyJk8is
	OzgfPJnJexXQmW3TTZ2lDfq8B4wJujwlg=; b=jJCVOPySkgFnraxGvY0p1CecEA
	I3fOBLuQrrthFKHFDGt6ps7m2l344SeH2BDvPO2PxlruInPbiTY54vlTNtOSJphw
	sv6Mu/myUhlaBg9u4pBY6+cGQH5L0d2uHfG3HeyDa2z4tTTeci/uU99wr/Dz9wk6
	RRDlQGSeTuF1p/xvDiYBrqna2SGA3OYzcOz0VPTimzGSavVBYfXoA9YeKQjOP3hk
	nBErHSUJBceDRlzBs6BbvVstRK0EGY2hEHUtJ2++sfS0wvOeLTfQ8fP7VdQjWtSP
	zBy58fvv/fRSFMFqE23HawkZa3uBuLQHj602cE8/jJNMYG2+tGe4RfIlQlKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726470606; x=1726557006; bh=s6dqyJk8isOzgfPJnJexXQmW3TTZ
	2lDfq8B4wJujwlg=; b=NPJwrNDM7QZjDuZtnNBx4toTnIJo5yoveX7Njzor43FD
	QVxWxYu4XqGB+rPfWXwYKBr8jYe6XSOC/YLST1J+VMn8gJ1LHacugtcHaixBIYak
	pKfyr3jwsviAr6vjyvhmlVgLKVcgel3OYiQ2HmA+lLCfavGmIi8UAH94O4BNXZzx
	aQqX6FQ2frEYMiNhxlnGHaQZ05Sw7NXpKfjQZNASZSQIhzFV7S1MhbEfWo2AfuLJ
	AVlvP0lYgiV1PZZI4ve+TIYrdqilEpdMLyQJJ4Qho/OMrxEoRG29DmNUUVhOBaVh
	NAgvXEhxDWq5MPRnvJBDHQaxpNYmmI/Lu8jWwk6LLg==
X-ME-Sender: <xms:ztnnZinEIuVUSOJSXh8OLS-8L8FiCJOWmlqk0LSATvT5HZA2NkO1MQ>
    <xme:ztnnZp13zHfNNm3lWY4koqhlW24_WPASReQyR2AjouKDcxlgld-IyBWQQN3AzPjCs
    _Aw2PpzsrCfVPrYjA>
X-ME-Received: <xmr:ztnnZgpUohfHWyq670iEJjrlYBXbQUDf0NpT6stGJmVnyc1Avn-d_7rqW1ICEu_Fh3bjZdSdE5KyxFz3k_j91VhbM4ZurSsw6i7S6uU9MagKYj0y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ztnnZmkwulEeA9VahiEQI44hjm1aDeKAStg1pDvP7jOu8Q0Cj9kqgQ>
    <xmx:ztnnZg231P74tCNlBF49T6PgjWhyAGjCGdyBPKuEsJ7VSJlBzE4SBg>
    <xmx:ztnnZts66iORVIQLtOobK57RMzoXb4a4Eu3i6Sn8h-91x_HNR6TGqw>
    <xmx:ztnnZsViHVrePZ0VWaXKzMXpUBDzj4hhQTuVGsXNUwxDbosoLvGZ2A>
    <xmx:ztnnZt9_lX63gmdq_uRppXyOC4C7pcpIrU5CPhsAnlZRe_wjsWCK4wxx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 03:10:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2bc95fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 07:09:48 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:10:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/6] apply: rename functions operating on `struct image`
Message-ID: <3f188412f61a98890798999b1351e06ca191c195.1726470385.git.ps@pks.im>
References: <cover.1726470385.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726470385.git.ps@pks.im>

Rename functions operating on `struct image` to have a `image_` prefix
to match our modern code style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c | 61 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/apply.c b/apply.c
index 9dd2f4d215..ac21c21297 100644
--- a/apply.c
+++ b/apply.c
@@ -285,11 +285,10 @@ struct image {
 	struct line *line;
 };
 
-static void clear_image(struct image *image)
+static void image_clear(struct image *image)
 {
 	free(image->buf);
 	free(image->line_allocated);
-	memset(image, 0, sizeof(*image));
 }
 
 static uint32_t hash_line(const char *cp, size_t len)
@@ -304,7 +303,7 @@ static uint32_t hash_line(const char *cp, size_t len)
 	return h;
 }
 
-static void add_line_info(struct image *img, const char *bol, size_t len, unsigned flag)
+static void image_add_line(struct image *img, const char *bol, size_t len, unsigned flag)
 {
 	ALLOC_GROW(img->line_allocated, img->nr + 1, img->alloc);
 	img->line_allocated[img->nr].len = len;
@@ -318,7 +317,7 @@ static void add_line_info(struct image *img, const char *bol, size_t len, unsign
  * attach it to "image" and add line-based index to it.
  * "image" now owns the "buf".
  */
-static void prepare_image(struct image *image, char *buf, size_t len,
+static void image_prepare(struct image *image, char *buf, size_t len,
 			  int prepare_linetable)
 {
 	const char *cp, *ep;
@@ -338,13 +337,13 @@ static void prepare_image(struct image *image, char *buf, size_t len,
 			;
 		if (next < ep)
 			next++;
-		add_line_info(image, cp, next - cp, 0);
+		image_add_line(image, cp, next - cp, 0);
 		cp = next;
 	}
 	image->line = image->line_allocated;
 }
 
-static void remove_first_line(struct image *img)
+static void image_remove_first_line(struct image *img)
 {
 	img->buf += img->line[0].len;
 	img->len -= img->line[0].len;
@@ -352,7 +351,7 @@ static void remove_first_line(struct image *img)
 	img->nr--;
 }
 
-static void remove_last_line(struct image *img)
+static void image_remove_last_line(struct image *img)
 {
 	img->len -= img->line[--img->nr].len;
 }
@@ -2322,7 +2321,7 @@ static void update_pre_post_images(struct image *preimage,
 	 * are not losing preimage->buf -- apply_one_fragment() will
 	 * free "oldlines".
 	 */
-	prepare_image(&fixed_preimage, buf, len, 1);
+	image_prepare(&fixed_preimage, buf, len, 1);
 	assert(postlen
 	       ? fixed_preimage.nr == preimage->nr
 	       : fixed_preimage.nr <= preimage->nr);
@@ -2874,7 +2873,7 @@ static void update_image(struct apply_state *state,
 	nr = img->nr + postimage->nr - preimage_limit;
 	if (preimage_limit < postimage->nr) {
 		/*
-		 * NOTE: this knows that we never call remove_first_line()
+		 * NOTE: this knows that we never call image_remove_first_line()
 		 * on anything other than pre/post image.
 		 */
 		REALLOC_ARRAY(img->line, nr);
@@ -2957,8 +2956,8 @@ static int apply_one_fragment(struct apply_state *state,
 				break;
 			*old++ = '\n';
 			strbuf_addch(&newlines, '\n');
-			add_line_info(&preimage, "\n", 1, LINE_COMMON);
-			add_line_info(&postimage, "\n", 1, LINE_COMMON);
+			image_add_line(&preimage, "\n", 1, LINE_COMMON);
+			image_add_line(&postimage, "\n", 1, LINE_COMMON);
 			is_blank_context = 1;
 			break;
 		case ' ':
@@ -2968,7 +2967,7 @@ static int apply_one_fragment(struct apply_state *state,
 			/* fallthrough */
 		case '-':
 			memcpy(old, patch + 1, plen);
-			add_line_info(&preimage, old, plen,
+			image_add_line(&preimage, old, plen,
 				      (first == ' ' ? LINE_COMMON : 0));
 			old += plen;
 			if (first == '-')
@@ -2988,7 +2987,7 @@ static int apply_one_fragment(struct apply_state *state,
 			else {
 				ws_fix_copy(&newlines, patch + 1, plen, ws_rule, &state->applied_after_fixing_ws);
 			}
-			add_line_info(&postimage, newlines.buf + start, newlines.len - start,
+			image_add_line(&postimage, newlines.buf + start, newlines.len - start,
 				      (first == '+' ? 0 : LINE_COMMON));
 			if (first == '+' &&
 			    (ws_rule & WS_BLANK_AT_EOF) &&
@@ -3082,14 +3081,14 @@ static int apply_one_fragment(struct apply_state *state,
 		 * just reduce the larger context.
 		 */
 		if (leading >= trailing) {
-			remove_first_line(&preimage);
-			remove_first_line(&postimage);
+			image_remove_first_line(&preimage);
+			image_remove_first_line(&postimage);
 			pos--;
 			leading--;
 		}
 		if (trailing > leading) {
-			remove_last_line(&preimage);
-			remove_last_line(&postimage);
+			image_remove_last_line(&preimage);
+			image_remove_last_line(&postimage);
 			trailing--;
 		}
 	}
@@ -3103,7 +3102,7 @@ static int apply_one_fragment(struct apply_state *state,
 					found_new_blank_lines_at_end);
 			if (state->ws_error_action == correct_ws_error) {
 				while (new_blank_lines_at_end--)
-					remove_last_line(&postimage);
+					image_remove_last_line(&postimage);
 			}
 			/*
 			 * We would want to prevent write_out_results()
@@ -3181,12 +3180,12 @@ static int apply_binary_fragment(struct apply_state *state,
 				  fragment->size, &len);
 		if (!dst)
 			return -1;
-		clear_image(img);
+		image_clear(img);
 		img->buf = dst;
 		img->len = len;
 		return 0;
 	case BINARY_LITERAL_DEFLATED:
-		clear_image(img);
+		image_clear(img);
 		img->len = fragment->size;
 		img->buf = xmemdupz(fragment->patch, img->len);
 		return 0;
@@ -3241,7 +3240,7 @@ static int apply_binary(struct apply_state *state,
 
 	get_oid_hex(patch->new_oid_prefix, &oid);
 	if (is_null_oid(&oid)) {
-		clear_image(img);
+		image_clear(img);
 		return 0; /* deletion patch */
 	}
 
@@ -3257,7 +3256,7 @@ static int apply_binary(struct apply_state *state,
 			return error(_("the necessary postimage %s for "
 				       "'%s' cannot be read"),
 				     patch->new_oid_prefix, name);
-		clear_image(img);
+		image_clear(img);
 		img->buf = result;
 		img->len = size;
 	} else {
@@ -3533,7 +3532,7 @@ static int load_preimage(struct apply_state *state,
 	}
 
 	img = strbuf_detach(&buf, &len);
-	prepare_image(image, img, len, !patch->is_binary);
+	image_prepare(image, img, len, !patch->is_binary);
 	return 0;
 }
 
@@ -3542,7 +3541,7 @@ static int resolve_to(struct image *image, const struct object_id *result_id)
 	unsigned long size;
 	enum object_type type;
 
-	clear_image(image);
+	image_clear(image);
 
 	image->buf = repo_read_object_file(the_repository, result_id, &type,
 					   &size);
@@ -3589,7 +3588,7 @@ static int three_way_merge(struct apply_state *state,
 		free(result.ptr);
 		return -1;
 	}
-	clear_image(image);
+	image_clear(image);
 	image->buf = result.ptr;
 	image->len = result.size;
 
@@ -3636,7 +3635,7 @@ static int load_current(struct apply_state *state,
 	else if (status)
 		return -1;
 	img = strbuf_detach(&buf, &len);
-	prepare_image(image, img, len, !patch->is_binary);
+	image_prepare(image, img, len, !patch->is_binary);
 	return 0;
 }
 
@@ -3671,15 +3670,15 @@ static int try_threeway(struct apply_state *state,
 		fprintf(stderr, _("Performing three-way merge...\n"));
 
 	img = strbuf_detach(&buf, &len);
-	prepare_image(&tmp_image, img, len, 1);
+	image_prepare(&tmp_image, img, len, 1);
 	/* Apply the patch to get the post image */
 	if (apply_fragments(state, &tmp_image, patch) < 0) {
-		clear_image(&tmp_image);
+		image_clear(&tmp_image);
 		return -1;
 	}
 	/* post_oid is theirs */
 	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &post_oid);
-	clear_image(&tmp_image);
+	image_clear(&tmp_image);
 
 	/* our_oid is ours */
 	if (patch->is_new) {
@@ -3692,7 +3691,7 @@ static int try_threeway(struct apply_state *state,
 				     patch->old_name);
 	}
 	write_object_file(tmp_image.buf, tmp_image.len, OBJ_BLOB, &our_oid);
-	clear_image(&tmp_image);
+	image_clear(&tmp_image);
 
 	/* in-core three-way merge between post and our using pre as base */
 	status = three_way_merge(state, image, patch->new_name,
@@ -3740,7 +3739,7 @@ static int apply_data(struct apply_state *state, struct patch *patch,
 
 		/* Note: with --reject, apply_fragments() returns 0 */
 		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0) {
-			clear_image(&image);
+			image_clear(&image);
 			return -1;
 		}
 	}
-- 
2.46.0.551.gc5ee8f2d1c.dirty

