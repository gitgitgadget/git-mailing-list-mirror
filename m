Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DDF19FA93
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097320; cv=none; b=FlPA1ydRIo+GPwJacxjOwclJmayGBofmMsytzbR5as/gSwyw7wa2ql+dY2+eHS0sHmleBC+edCAlX8IdKoYa46/aAdW5bAZIFL2ktvChTiDGbOn1Gx6SJu8i4Qa6zZkM/d+3oUqh3GZBohVRQYczIma54XRHI2KngmkAbWWnISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097320; c=relaxed/simple;
	bh=/SFWQfiStKUjkfipfs13yj3hZSnDhu2wrvmsOCpHw40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIY69MHnsudvUFf4U+YN4h9Id2oEP5HsXo6QGlOI9c1p5e/Z6jCYPhnDEcFKeeZ1Z1az+NWS1dqDVqvxwZKof/DhZKsrWSyPZiYG5LzjibmjwYhppd0inplT4cYrKjuh6GIvV5agCoQzpSTYa59Z5ZzfLF9OC/nkhWS/ZgsQuLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Wf71HGRA; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Wf71HGRA"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6353f2937f3so3018582d50.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097318; x=1759702118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m+d2dINJHY4yhntyueJTRcLgL/pcpCnEDKKfCNezb4=;
        b=Wf71HGRAwSPxYPNBBtsueXazAX912oClI0kzCoYoIrbmdZRczmFYOHsXGt4E58UJEA
         WiP+u7sJBSlNWAirs9NwzI3THdECzH+2yAkNxBDoGs9E0ymoLClWHksAoN7hqp7K1CwV
         MrjlbHaN8vx1qw/FS9piMmZSweWAyDX4+S5Hr0CCHR7o8f6wwCCd9wCmh0FF0gxB2hax
         eGoi6g8DtpBL/u65EWZnlUd2xTjitlrra3xtX9Zq6ZkYKtBfKiKxMlyYe/AbtwtMOFCm
         ljTZP5AMov6FZDZf9gRjmcsZRa3iqEqgedGsjMwsoiFTaclkPiFQbM4pmwrDpz27aBNL
         BA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097318; x=1759702118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m+d2dINJHY4yhntyueJTRcLgL/pcpCnEDKKfCNezb4=;
        b=gmPLuuMUbp+Xyw8Au7I/HyMoIWLk5yKZoxo2HFZyruoPZA4+syk5wFqq9990jwxzBK
         rR6i9iNpogHh/cikm+4l6aPqg7IZ76rvloeMz1hIMgiVYl5bpCPb9BQa9hCGPmOVt2a+
         b44ZxM3sMtKgtJicYR5xBJkDWtv2SPWw5HY3xQ5pm4Bsu5Abe8+22/uGYfhKcyyzbr50
         8bS4fcafQDhgKKtJJfeh6BZ61kuUGl278asKcJ6CuUb7TVM3bUze5H0azOcO3EPapqvM
         A7PLC0QvN+lXx5zMFqxXd7Hn4JmqUwufaMiMP3B0t4Mrt6cljdMtw5UxUl8clFeiuIAE
         Q3WQ==
X-Gm-Message-State: AOJu0YzTtaaEMGMUt0Qqq2EB50n+5O4eFSyhR0L6U3K/mgCcsLMH2MMC
	m4V+uIolvGQgSFCIGG8MT7Og8bS+EBktmYqfYbYWAhFkxexmQy1wKgRctOV9WvfbKrwuDRooZBT
	ufiN2FqE=
X-Gm-Gg: ASbGncvPbPh0vL4gtBdMAB2pMNzTyoWSjf04EorX0d/3OIC9BUguPGq3/8KY12pvvS5
	k78IPR75Tzi/rp+E6XqXVzYxtq4G3lWM7BUMHN3RKMPFFN4l3T+kPBlK21ixtFitNl8J4wZv4i1
	yNz3ZkKvxRfEA/TgOFKM5/DQaCM2xGaxBXxCqhyJLpcecMfIfddde4zla7W5xlcnDrk5Xd+Cv45
	Czn8u+rD/gXmOEBz4nqeXI08RsleK0dEO47rWTIXPSdKhcCtDFzLcZpvRmkIeDvHGI+EeVp/NF4
	Pt+1YQAclKtVgxcJgdfqNM7hSuvjA6uurPtWrj7Ei8Uzb+artxVYXSTfKo3wUVUICx57zgKYYtx
	XFKsc+eSIS4wzATIQCh9wS1/uWrnBGZb8IMFwd/izDKpkZ4edze5yEZnHTH+VTJICQ+Un7Vg+Zf
	rK2Dw5WZmaK0DYVKSUGDXvL64BYtF/P6I6JDNy
X-Google-Smtp-Source: AGHT+IGs3besbUwTyOKNkK+cKYR+gz2Ii1lhxtDt5+Z4gkNMz88jsjtyn0PUChuqBK0CWZBTIRAD7A==
X-Received: by 2002:a05:690e:1406:b0:635:4ece:2412 with SMTP id 956f58d0204a3-6361a8a52f9mr15833862d50.50.1759097317794;
        Sun, 28 Sep 2025 15:08:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-eb38393c958sm2931931276.26.2025.09.28.15.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:08:37 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 22/49] builtin/repack.c: pass "packtmp" to
 `generated_pack_populate()`
Message-ID: <ab0dc6668339f24787dc80d2dc05f0d31cfadae6.1759097191.git.me@ttaylorr.com>
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

In a similar spirit as previous commits, this function needs to know the
temporary pack prefix, which it currently accesses through the static
"packtmp" variable within builtin/repack.c.

Pass it explicitly as a function parameter to facilitate moving this
function out of builtin/repack.c entirely.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8c3a5f4f80..2141c43bd2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -150,7 +150,8 @@ struct generated_pack {
 	struct tempfile *tempfiles[ARRAY_SIZE(exts)];
 };
 
-static struct generated_pack *generated_pack_populate(const char *name)
+static struct generated_pack *generated_pack_populate(const char *name,
+						      const char *packtmp)
 {
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
@@ -271,7 +272,7 @@ static void repack_promisor_objects(struct repository *repo,
 					  line.buf);
 		write_promisor_file(promisor_name, NULL, 0);
 
-		item->util = generated_pack_populate(item->string);
+		item->util = generated_pack_populate(item->string, packtmp);
 
 		free(promisor_name);
 	}
@@ -896,7 +897,7 @@ static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 		 */
 		if (local) {
 			item = string_list_append(names, line.buf);
-			item->util = generated_pack_populate(line.buf);
+			item->util = generated_pack_populate(line.buf, packtmp);
 		}
 	}
 	fclose(out);
-- 
2.51.0.243.g16eca91f2c0

