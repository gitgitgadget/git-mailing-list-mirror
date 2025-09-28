Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557F19C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097266; cv=none; b=NYMmHCYsO8MCYR0fWodVUF6FUiXGQJXDGXL/PJGZglRzOO/w38DctZY1qooF/P+OVpjhuQzysyE7Z0KZX2G10/nP3reLMnJYdPMpfWogfihvM0MnjgxNNX2FeEOZMXefzkfI8XYPbP+UJ6SN3aX1HPU0c7nt+sbsf1GffDD2Iiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097266; c=relaxed/simple;
	bh=xY/eJ490BAQeYqHpmf+TG2vF0VRDWF40x4nAGd0vlqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3NyssGqu8mVzeJnNT2HsM9YPn8Km+a70q1Xm94uSFADlvWteaQ0593sx6k/GH2MSm22Nzfq5aHoAS+0kMEeZwx3KqmadRhXx0QZvm8iceEYzRu/MawOL3kVz2M8qxQOOyu+rZviMiAih5kMYbt+HTbcVmpmgWXV0O0yqRCnfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lAvkBwqb; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lAvkBwqb"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-74625f748a0so41998907b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097264; x=1759702064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0EzgbwSyS0syzkbb7bc/WiCFqEtLN8Ec4uXlZLWRlIQ=;
        b=lAvkBwqbaKDZspSLWA31axxjzaPLoigPRrNt64RVqfDJ5umw4ymhzKf0GWjScXJ7Uh
         GJCswM0a3vjEDoEZa/hG6Jxr+bnDDRavmBiNM5m+B3ZbhgvGZoz6QsUXFd8ZPTjoO+L0
         oh+oABD26J/Zzlg2x5+jucIc5WDEbthltUrmJ9oea37zb/LK+0sjrevhUt3jvJkWVxna
         ZxSdyTYh8StxbbTwL/7ze/cEoEVGWTNxW3x7mPulnPHmGO8vnYfl3Ih9+lch49viiLmg
         mFIOrZmQ9C1YXyk3wI74eZK/ItezBbQXy3iJOK/6Q8mE0NY+n8JtOEeME3EwBQr7UfAH
         +pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097264; x=1759702064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EzgbwSyS0syzkbb7bc/WiCFqEtLN8Ec4uXlZLWRlIQ=;
        b=FCoAAkOGdjVaMcOmujRBto8VPINWrEW53UbmK2feb4BoL2JbyDp4Uv772qWllodPNk
         dLkt4lO27rL+fwUFH828Oq/RI7aWHOZR1XqXoLydpsSbyJuwk4lh3acUnoG/tsekmar2
         A4xI4kPfmd9Fyfc0DwuwWjC/C204Jxu0nZVxFUOcKPl55rsSmpV9LU2s/CBaB1ayBRsi
         HLjCJ1Mnx//rMTp2DgfYzzZ+yK9wK7TkRPB/JghJktq63hwyPzK/xyGK48eeO64h2YAs
         JzSWAHK332NDu3I9yeMPIJlzMVLoeIXUnIDG9NU3HpSwFmDdeJvwjZ2KamI7b/wQxykE
         EKCw==
X-Gm-Message-State: AOJu0YxkHogKDQ1sYgIVbkxgErGE4TsnIWkiZc5t6eiwWLCuVX3/Gtpn
	0h2ZjlJF71G+RkbxC2S+W0YemdDDVV5VxyT00isV79H3rRztWMsV/m5/mwst706GPC7p5A62kOd
	4mW9CVkKZxQ==
X-Gm-Gg: ASbGncv7i3eCczEezw1LuEtkMbQm9Jpx/fTDDBmuGUzxmAdtI/Cqk+5qg9KhDWhwgev
	SNfbsoY03cF2OZtEDbLAmLa4OIkkirFOGSWJU6z866rXNRRkxOj71/aiBsjwZSsCTdXJwk6dQ3G
	1vXBPw0cuV1DujtXdG2P5OGrNlNIFxEHOpQMGlR6VNQ+FkJ1GHhv/lb1FU2IVFRmbTKV5WAvzyr
	fj0JeB5Kp0yaARCasVE0HrzrimrfNqcbmy2BRLLBVIsG6OVLbYnJkwD0U0hvSx7Cq/APN+cqc68
	WTdM7NqAfPdcynpk8rY+QcELs7g2HAcd6zdk2LoNqWC3LzG5i3OFyAYXFq9c8m86wL1hn+IFZVr
	J0/yFN2Gda5W0ugYX7zW8kUp5EC9I8sd8lZDJmoz85XpawWpLLDLP+gi63etUtBJYk5n/TMtJ7o
	CAoVu9aN1byQFX/oQ7/z92wfOa2BZEalCQ8f7H
X-Google-Smtp-Source: AGHT+IG7QD+2sHtyyKlkNObgJ6JpKzW5KAmftoIwu/+Yk4Z354KphQIYJXiiJiJKSjaCZbk3vtbpTg==
X-Received: by 2002:a05:690c:6d02:b0:731:168b:f389 with SMTP id 00721157ae682-76404b441edmr149985967b3.28.1759097263699;
        Sun, 28 Sep 2025 15:07:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765bd407b9asm23243177b3.24.2025.09.28.15.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:07:43 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:07:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 08/49] builtin/repack: avoid "the_hash_algo" in
 `repack_promisor_objects()`
Message-ID: <f5a87f2a65796caae2f981b6fec32bdfd87e4e3d.1759097191.git.me@ttaylorr.com>
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

In a similar spirit as the previous commits, avoid referring directly to
"the_hash_algo" within builtin/repack.c::repack_promisor_objects().

Since there is already a repository pointer in scope, use its hash_algo
value instead.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 7d62959dc2..a7e94ed03c 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -452,7 +452,7 @@ static void repack_promisor_objects(struct repository *repo,
 		struct string_list_item *item;
 		char *promisor_name;
 
-		if (line.len != the_hash_algo->hexsz)
+		if (line.len != repo->hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		item = string_list_append(names, line.buf);
 
-- 
2.51.0.243.g16eca91f2c0

