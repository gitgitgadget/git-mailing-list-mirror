Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF081FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097347; cv=none; b=qWUM+0NxC/+jz6ysDUcisujB3MRpBxY52YVABr4sebjYmCzsrgyUjiiQn9wU8KKJxnGWBO6fqLKWf68gbPnn6tK0dJUuudXV5ddTjb43IUyubw2CLMRr1YYdHAKh31U2bzxDc0rIBmILb2J5ntfyYzOzcK+6PXDmGmwZcivFxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097347; c=relaxed/simple;
	bh=MsGuUWr4wzTvNWqpmce1WUV+QWcQgt3wgKPNkGtJfDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luHzXGrY/SjuX5Mwjus5kdtL3FE4LiuOFcbKkHMrtncEXXIbGdveH3qwkW6MJW9upzFowAqVpBkEbRMR+Jt4knJyEiftBtbkrhOg59Sn9kRbOa5TbuAn+3Twh2pQJiMK1tuwjYo9oMeWIweumsZiaXkU/siqDGZz4Jcn4X4ibhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=d7KtgyrQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="d7KtgyrQ"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-77636fb28f6so7957177b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097345; x=1759702145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eM7iWZVxP/fF4CkVbHM4Jn/ohOtEZ6zPN9wEv4sxPqE=;
        b=d7KtgyrQA/1VyPUd8/hjUDC8zmf/Vi7BZZtI0Eo4rQSHNMZ/ErjsP0zBMyKjTvHhNh
         b4SYa16K73vs5375Y2UYwpAOkE+lIZUxdXPpHj7cMgBNM8UinVtIKcpa9GgTzw6Syw/V
         qOxyga5C5C1vLbqNoOBPWxWMMo7oGVfcpr89wzvvWbj6iow587dz27XihPNhwyrOoFuj
         kFEa7z8L7yeYMMZ+gNaD/LHPSOARWLMEGbBLpsQ6QC5UPzYW5sV67rKPx1R/MAMRRVKY
         WA+ivFSdxENz1TNx1P/Slfm4GHvNLu/jyxw9GgeSOPto0E0HaJ0KLJBaiHRNxDHy0TTZ
         Vs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097345; x=1759702145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM7iWZVxP/fF4CkVbHM4Jn/ohOtEZ6zPN9wEv4sxPqE=;
        b=Xljby8aCvxN8eUmMJ4NCYVzQPyqG33vF5IZ8l3V0BlzCfXSho/GiCJsPo6ss1hN3Ch
         f2hRB0ClbvCP53vZXZ72tAuDmfi/r2dXLl0bYY/8czBON+YIueNeGDdqMqG64paHG6LB
         v3h1ibzo8CadKB6vA/815I+Rh6pv9UGP1eHvPsG+b0IppJTaRniK7YKH4Bsd7OGS4QZS
         rWTQnc+uBDhQeOnKlRmGvaiBIaxOvKsk5tas4wsc/H9bB6Kx+Ns5+pPSG5psJwxmqvMi
         3ZA8tb7vnEkzru2Z3m5V4riW2PBkddRhG5wYBesOzjQY/genYqtLEr4d/Tz3RBx90s6M
         IGng==
X-Gm-Message-State: AOJu0Yyfp7T5vEi0XZpDJmsQUsQXUnzZPUy8EC3Tbz59pXhj7FijPl2v
	5Nm3O0+P5LEIqgjuc/dCNZJ949fwlG3T4Ss+wsMt/Sp4a2MJcSmL37SBrObVe2EcxtsJnXc8qRC
	pLO8/ATOooQ==
X-Gm-Gg: ASbGncsBn1Sc6RCKDRT0GmPTQYT4dgEjy3LMEE+7nH0zS6qF/7Z3/BrRT9xbdHdK5KI
	jNPCbhJqrCThHgN3Zr8hIHZqMV+TGp3MUS0yaQrzjRHvkUzG3oe7wAO6Eqr/2T1vmgxCBgmITb5
	p3L0NRqPL01QOmFvlfo4DgltpvnKsnCfbhprttU3csUNZpx3F5wXnX2Eh5HbywlqhOHKTu8MW/L
	U2vfT9OOwX7RMwlpH5qA7Hn3S+xuOglaD8T452TEp4xT462oONxCyx5mjgP0k9/Rwv4n4JLwb3f
	KEHBHBWdCspFACVcDzzp+y60NVd1XB4NuS9ZrdUupYfzz/3gOQ10fn4PXd1kP4sQ/7LM1cx4b05
	bHxeCPAIzAOlET79Hbdv6ojmbmlrGaX5okzCNDjW4pg6XCzVqj3R5ySf/YkXcyHTnAAkAHOOMcz
	5dJYxQh4UD97YMcJG0kMfhzsaThQ==
X-Google-Smtp-Source: AGHT+IHZC/R/hovMznkmoOpyphziBnV+lgu3FTye574fm4ugqj8Z6l6yxyA71bo/t18S5cDEZrAbIQ==
X-Received: by 2002:a05:690c:6109:b0:770:bb4:860b with SMTP id 00721157ae682-7700bb49270mr114841927b3.11.1759097344664;
        Sun, 28 Sep 2025 15:09:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-76b726bdd46sm17815297b3.22.2025.09.28.15.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:04 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 29/49] builtin/repack.c: pass 'packdir' to
 `pack_geometry_remove_redundant()`
Message-ID: <76be98b386e3dd5937114e3b4488fada21a9ae7a.1759097191.git.me@ttaylorr.com>
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

For similar reasons as the preceding commit, pass the "packdir" variable
directly to `pack_geometry_remove_redundant()` as a parameter to the
function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 60dce45556..9e2523d948 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -307,7 +307,8 @@ static struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geo
 
 static void pack_geometry_remove_redundant(struct pack_geometry *geometry,
 					   struct string_list *names,
-					   struct existing_packs *existing)
+					   struct existing_packs *existing,
+					   const char *packdir)
 {
 	const struct git_hash_algo *algop = existing->repo->hash_algo;
 	struct strbuf buf = STRBUF_INIT;
@@ -1327,7 +1328,7 @@ int cmd_repack(int argc,
 
 		if (geometry.split_factor)
 			pack_geometry_remove_redundant(&geometry, &names,
-						       &existing);
+						       &existing, packdir);
 		if (show_progress)
 			opts |= PRUNE_PACKED_VERBOSE;
 		prune_packed_objects(opts);
-- 
2.51.0.243.g16eca91f2c0

