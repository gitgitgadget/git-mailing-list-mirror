Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD8D19C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097254; cv=none; b=ACQ5TaevKjpjQFHL5Q7VjzIqUo4z6Cqk+z/wcDhT7ovBA7c2DeMLq/vxCUqAM7LWkU87rbYxHNcBBxBGNTJzPEJ7z7mwQik+i4saaQogNop3/W87nNweQTVUTo4fdy463mR+G8r3azfF/GwYksX1c5Zu6qviQYTSWGgG9IZqcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097254; c=relaxed/simple;
	bh=0cebgvk1hvJOjMgydSC60Q6qSltoe3buFNc3oqBasqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAJY5O+v5tKpGbgWNGWhGAT/FCrkqJPj2IPgoOX6Tba2Ayi4wcut8/CB/JTnKUb1LAFmeNL26qda6yUsBwqm0jU9b7ye/+l3GobJiCczqs6d8zQtmav1+BsVx9P9L76jiF5n//4dAR8jhr9IOaN+9fqo1VJglvCOoNQ1ZwjIwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=G4tb8Vdr; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="G4tb8Vdr"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-74625f748a0so41998007b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097252; x=1759702052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3QUol9OxTfOmThzmZz+0/3IqERsJaySB9Sk0117JcM0=;
        b=G4tb8Vdr7/aiQVte/YwJmJ0g3dRlRrmETrxpzHXk9R4bU7yNFSZ7VuLIYUe0xbLF+B
         GXBjB6OXrX/z9f9dKJLUZEnp93FX8qQuvr4b3ZXqoV+L4rgwXGg3YgRrgrOT0E20OXTr
         4QG1qn+Cnl378IMnZ+O34Q4M7S+/rD3b3NAWRXmt73+VQGx2nd7D7l/TK+YP043hbpjp
         qFZ/NF14z0r2cUazMan2uxtvjuXuo2/yRasHtwuVGGp8IakflxBT5OlxNEUmAJ295uJf
         hKEM8e4/fKRXv1U6d9fxvTlNW/VtM87/i+1cc2vFdUWP2Jhv76R4sEcRa8eFvU5tghAJ
         KVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097252; x=1759702052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QUol9OxTfOmThzmZz+0/3IqERsJaySB9Sk0117JcM0=;
        b=TcDJcFmtzjptJ0YflX3qw7X36aGw+ZeOyzXTTXrFbaoxcjxQS/vAQRVUymy+mF+sAA
         ObJy9We8dieUnRX6XWyvOCyzo7mzSCS9vmvh6N8HpkfHcf090XLOtpOx0bBlQ1yfhpAp
         kkXlgK9ng4gy6a+ZKe1+uPaHyXNjVkvAvQBbVWMuMcMYTGyOOZBNq2xv6QHIYKNoZr3P
         zYEc4oTHYYif90NcteWrlsceqeRc0DwaEtxRmUCgWs8FPKaPjxYPXel82etP3urLC1PT
         6sxztcOmPtTCdRfJk62AT7gZU+WDHdoIxXWXHv0wcv3lMs4I5eDWuSJWYYwWQokYrsFM
         y2SQ==
X-Gm-Message-State: AOJu0YwdX6VIJU5cBuex0gE3OAeMSPV5TzkdE1jkl5dxmGnLOCtQLxzJ
	Bx3UjFwEhjLyIbLEmMoaGg9U9XGoBJD8TGvCIRTChxn4gNKF2je7vqukNJk5HWY1oFM/iY/MNtY
	r8ga0xrk=
X-Gm-Gg: ASbGncu5K3yVplcL9hn9JtAEoJmJAKBFI3bnxTpLw3kSXXESe6oB9NUSba+fQdq8cGs
	kQjZKksf6KUzal+h0wUxxid3RE+atgfnul38vyx5n8+TuIMdO6MZgmw/J4cHXQo85qLvdcpi6HB
	55ACWAsncppWCB2DbK29MeXoC5gX5v8oGZuLSaNDySbCyIEWmxwqGb0hGfleNzUim9pREr0VT3o
	HEuBJh8L4t+NlWdm2CpoUxvK1k418GzZ575D9EVSon1FnTC0dwU1z2DQVUOAjJJwQ1freKyHHMz
	TEg2RgyL/d/RH8vIag9q3NrZHTj2btZP1X+S2qDNJoBl/yVTSeGiucs6M5Cki9UNWo6e0BRAdY5
	ijPVdmPM2T/9uolZETTVSw8IBsgc6nt/m6Bb01uusQm4hvUaYKPDM6cgBSNtbaQXH/tpMKyLT4B
	+UEqaKp3wmKI6MgeuYC80P+W90Fg==
X-Google-Smtp-Source: AGHT+IHTlR8aiXAFbzh8HYG8C1vh7gOIv6cMBLJCYakNj5FCias2lIT/SYd1OAAiLGt/zpfWIvK2nw==
X-Received: by 2002:a05:690e:1512:b0:635:4ecd:75a5 with SMTP id 956f58d0204a3-6361a8ad0bcmr15459687d50.51.1759097252090;
        Sun, 28 Sep 2025 15:07:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765c91dd8c3sm23048407b3.64.2025.09.28.15.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:31 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 05/49] builtin/repack.c: avoid "the_repository" when
 repacking promisor objects
Message-ID: <6190eeb066332d3ba19bdb141c01924e4c61ddfc.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Pass a "struct repository" pointer to the 'repack_promisor_objects()'
function to avoid using "the_repository".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 93802531e1..4f08b57ddb 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -407,7 +407,8 @@ static int has_pack_ext(const struct generated_pack_data *data,
 	BUG("unknown pack extension: '%s'", ext);
 }
 
-static void repack_promisor_objects(const struct pack_objects_args *args,
+static void repack_promisor_objects(struct repository *repo,
+				    const struct pack_objects_args *args,
 				    struct string_list *names)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -424,7 +425,7 @@ static void repack_promisor_objects(const struct pack_objects_args *args,
 	 * {type -> existing pack order} ordering when computing deltas instead
 	 * of a {type -> size} ordering, which may produce better deltas.
 	 */
-	for_each_packed_object(the_repository, write_oid, &cmd,
+	for_each_packed_object(repo, write_oid, &cmd,
 			       FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
@@ -1458,7 +1459,7 @@ int cmd_repack(int argc,
 		strvec_push(&cmd.args, "--delta-islands");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		repack_promisor_objects(&po_args, &names);
+		repack_promisor_objects(repo, &po_args, &names);
 
 		if (has_existing_non_kept_packs(&existing) &&
 		    delete_redundant &&
-- 
2.51.0.243.g16eca91f2c0

