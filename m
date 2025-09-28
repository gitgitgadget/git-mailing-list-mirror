Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04380284888
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097343; cv=none; b=uB1ZBhjbszaa3hLOneblR52H7Au+/yRs+R9gfMcJv0BprmLrvm2hCR5p1f+BbhEQT0fM5bulrW67EYLEKvsmQQCn0TaPoQi7xg92myf5WFuuVsc2/EpkXyReeFl4f+CxsRbYQFzwx2wrjgb6AW39MajF3Ot9qzt/kCsHybF0Wxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097343; c=relaxed/simple;
	bh=odozPIaCfiXwn+ZLb1hUr+2zb1VnYDuNxXWIlUVrbgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwuY0vlnV19AP9cLUQpFGRh0gICrRn2Ju4/znsuSCGTJzSbL5DOKSRdrEbLj72DFabKJoSC1QB6zULHZIhdIVNHaFigMVFNIxSlRAMPnRFa5eubzJGXi6ogmTREDcp+bK5jvibB8VrVIh7gZWo4gBQMoxcw7hBpZ6nxucLXJhs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cSD30RDG; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cSD30RDG"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-749399349ddso48400567b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097341; x=1759702141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrHhPoappGaOqGLiv7s91/480TJdZi3XKBYYaFMDiWk=;
        b=cSD30RDGoJc+f6XY63GUgs71iuukanKzaaxW+qsOSa1RCKovsyZ/PD1LzXHWsOUKee
         Jl0JXo8F46YET0/P0Ht/L2+Ywvwo2y5MZMGfdfc+RgJQDPNHMs6iDGf6CsWeutzqnBSZ
         8020hhr7i6kdHj05EH/EwgQyTGptOVHwaMMe81qzfGxjllLAOyhUuJbm79LrHa+cF2l5
         l75uDA2MLcF1vJT+Jf6XgIvQYCB4tan7U3nUy1RAl7GKNHyzGk3ecrstEVeNYa8Qx3NV
         MNUHGvS/lghBljqSEJdvdi8eyYYMT/TbBS4+UAymyQ8j0kMVeNFrg1nRmBUcusd/UPAT
         uDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097341; x=1759702141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrHhPoappGaOqGLiv7s91/480TJdZi3XKBYYaFMDiWk=;
        b=jwjFcuktNB3O/A/KglQIkoZeNmumZUD/qS+eb5Iu+dIeGqCSbKhvcaiBk3QSR402mH
         bzDVgjeKgSAhTHwbmEgjWf/W57FzHFLiRpKwEIVYOWOvQaxWmrME0DwC84M5ahNM3dLn
         QXe20TIS6hkN9EznrDTJz1p+RIdlnSX7UEKChkmc1CMjGtXXSaBwwqVKSnvxLbqsHPKt
         EJcGd7Oi2M7bIK0sgW15AB1wHMp0Xebi2tyX0rS4tgHAhdSFFe59oZ4LvvY6V6Wxrk1g
         cmHdjz73QkGPan+emfrVyjNXXG4icHnYKjCamHFkIOAUK3FjqR67OwVF6FwOo/agKWhU
         H1PQ==
X-Gm-Message-State: AOJu0YzHgdrNt2l22SFxQBfYFip7ufn9O3AvaQBCk4LJkY+8rj6JYBaA
	B4hVfxkbx0me55V4KccBAteSSwdc1z8BteWaDObTgYFZkNr6p6PG15wd1Vn1V6KnphEB5ugHIxT
	66GP0fUf5tA==
X-Gm-Gg: ASbGncuRFUZ8U7yWLk/xtPQdOxyEiqsgsztwbJC2ITLkQz1Nrbn+6LW7PRUcgC3vj/r
	bZkXQE2K3bvEZ+S4hZwg03SZceb+lokXQk8G/7Y2qFfOaufRLY0HyP7/cC7dHAYDqmgqcJZh16o
	77jeYKlz8LHJgTNKgzRYh+sKQanTYGgBZZo+WQeCtzCw66nYh5ZdrXIZCWL+8VRmkQA9aKdcoHH
	aX79UF2kMBOtHpZEY9yQFrLslZ8u6Uise3BBTMQ7Qh+03u7CqaobudtqV6iMz6bHajj5Whcr+Nb
	W247wgxXiB8vPTMh3yjT7ld6CkTIhwkhPfwX1Qf3X3nB7H5y1hUL4I3lDsbn5SDK1KTTGWlzCLa
	7+35V920aIu9wKJv2v1o61il/YeCUJ+UUlf0GjR0K8UKhyeZXgInL6Nm3OhjHCJEEEAWXgVdUAZ
	ynd0TN8AOIZNOTqEFTjhv+hv7uyA==
X-Google-Smtp-Source: AGHT+IEaRG6sJbHC7fBJlvNsqatm1PifRSSjmlcl5JAVRCHPgzIDfdN4tagdju2Ct+I3nmtHSTI9jw==
X-Received: by 2002:a05:690c:9408:b0:77c:c08b:45b3 with SMTP id 00721157ae682-77cc08b4b81mr19600677b3.2.1759097340858;
        Sun, 28 Sep 2025 15:09:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765be19ade9sm23174007b3.27.2025.09.28.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:00 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:08:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 28/49] builtin/repack.c: pass 'pack_kept_objects' to
 `pack_geometry_init()`
Message-ID: <8408fd8474eab618e37a96203084bd2b58e4eaea.1759097191.git.me@ttaylorr.com>
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

Prepare to move pack_geometry-related APIs to their own compilation unit
by passing in the static "pack_kept_objects" variable directly as a
parameter to the 'pack_geometry_init()' function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2ce1ae3364..60dce45556 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -136,7 +136,8 @@ static int pack_geometry_cmp(const void *va, const void *vb)
 
 static void pack_geometry_init(struct pack_geometry *geometry,
 			       struct existing_packs *existing,
-			       const struct pack_objects_args *args)
+			       const struct pack_objects_args *args,
+			       int pack_kept_objects)
 {
 	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
@@ -1063,7 +1064,8 @@ int cmd_repack(int argc,
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		pack_geometry_init(&geometry, &existing, &po_args);
+		pack_geometry_init(&geometry, &existing, &po_args,
+				   pack_kept_objects);
 		pack_geometry_split(&geometry);
 	}
 
-- 
2.51.0.243.g16eca91f2c0

