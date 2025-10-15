Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89D30E0D3
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567294; cv=none; b=hfAuup1OX+kI4jpXNozS7K8m6zoWbWtNl5ULumfjbOvmM2SVKb1MvSWxy+H4u9YK4sZ0cxmJaotXkay1FEmOpuswQKOgkmBSe4MPySpZmi8ejB9RFhPaVrWTDjZ3/M5UStPeQJ8u9Xr0Czfl4VVzCK+fyQbzACqlvcRLqXIGpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567294; c=relaxed/simple;
	bh=hvRP/sjkzSUatcG5zjCoQ+/HChy2+iKYMK9rQF+dx84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmseUWgkBZSWV1/VqjiN3N0XE2oCQI8Wlg9KUR3G0u93y9XXdicwDf9/P0Y/63wr7pI3XZ4hxnMjIWS5IjGmlBtT4F9ld/3n+V2hEILDSd6csmP4rCaZX6uIAnjBKqzumd0idKiWo13v6dvyY+cUzqPOjOUVxpmSrahlYsVR1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=FZOQCmfI; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="FZOQCmfI"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7814273415aso857067b3.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567291; x=1761172091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/DoGjmjHjK7uZhO2yH2LtlsRWMJAQ4cHhjvob5dQcE=;
        b=FZOQCmfICUx4NzkWXdcIciBfWtIyW6hCsZNtESSfkmeXVd/x8zENYqcydd6XUF1rlY
         yU7EzCiKIFlZiCP0abpKl18GKxSzbFv9C25LdHh6hk1PBqSlxeErdanF+uhMoLsUMzcn
         uv3QpoIU9Yi4I51D9Jsaiqkcgkp2hsKTt4lrcnWX2i9Xa1K8XQ5dlpNb2EX4Mckz7VHu
         VxClVtlLHv/8V6BBUcEmCiClVuxMkTUSw5triQyoMLILkr+od4eZ27IAEr7iY09Y6XfH
         ExqwwEAVjE9B/tFqKMakIbC1RUxkbXvgIqxEUN97HPxbMb7C97QigpDObT15oDprK3Yl
         UqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567291; x=1761172091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/DoGjmjHjK7uZhO2yH2LtlsRWMJAQ4cHhjvob5dQcE=;
        b=ZlgYn73HqhPNlfq26aLvRnojJDVRpKAzq1uPbRRp7XHmjqc/ZJgatdVrrsTWNSTjXA
         sWP5WEyS9nSoFP+ZT8TDhVYDr4gwDY+GN6PBOBrlIvp6SiFtWhlq4ZGTejS8Pppn6AJ6
         cWhDDQVPc2qvQyJ+SjhvZvaamhs1U4PcdLnVopQMvhvPSq0g0zMpdAj90eZD16TFrpq7
         9nnUO+aYw0hU9ehb4FzNYZIloj4ESeXzf5ZKF4ueNKIp+kEYRB4WpMqlrMqUl1bQ9Sek
         QGhEquBTVfHpP7A4Ct6e0QwdyzTQHSYtpNWRXGWl1ij5UG74h7Tp/MRlwU4lm45Rcm/q
         bkzg==
X-Gm-Message-State: AOJu0Yyg03wo5jceuoAiTnW7nJfqZujjjBaIMNElgaTGXTMNh4uHn6Yz
	bqX/ZInKA7d5kn0wRbJkywjBu62WHT/HKBpJe6oulrrJg4K+3ybNXMGgyukWSvNG/2OhGtqwMzz
	6XU6MjeT6Rg==
X-Gm-Gg: ASbGnctEJT5hNOHDoEVHiJNyltnKiwt9RztSURNJJMwsq8cXXtWitONrTiJmz85ZOgP
	cxPAEPQnyvg+9LxqItsrOKNlXPPPAXXLX3i+/83ZcCLo80kiMA4vZR+f//2PZRi7kw6SAh22omR
	AFTmICjCl32ArIVXwQt5YyMDLI6l3QMnSLg0FpexhCvC93FSNYHWGHQujpOPSM9ojVyAwyCyr20
	BerOZVTa0CIvXVIlg4DWSPIp5jCX37BOTlCARtTGlxBHOFlM8DgcObuo2EITlym7XD1nzmtRQzL
	SfDGStjik+7Jjr8ll0EJHmgxEBX2yJEoCTNXA86sgRylQ9afLoEgDU7KENT6N9pWFNC1vpqx8nf
	mnJ6bEK8Nzn4PCruIPi/hdYdUZZiXKIh+E7H+8WlRLeMONH3OPCaFxz8OWFYDhlc8Y8MSDWnx+/
	nqI9EBVoWMDP3n/UhX7/ofvuHfgrxhvCatA+w74tv6ll0ednMTmbHH/EcZxJmpIWJOOjUidYh93
	t0YFGoh74Gox6Y/Fg==
X-Google-Smtp-Source: AGHT+IEswcAMIrJKcojhXkF/hxRT2WKtbPZKWrr27OoBq7q4NMy/etxUJL6yDxCImjy9l5TIcDCSdw==
X-Received: by 2002:a05:690c:ecb:b0:750:1c8f:e5b0 with SMTP id 00721157ae682-780e1404dc5mr272896677b3.6.1760567291392;
        Wed, 15 Oct 2025 15:28:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-782931f6613sm2584727b3.48.2025.10.15.15.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:28:11 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:28:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 17/49] builtin/repack.c: pass "packdir" when removing packs
Message-ID: <4e2a152ebb3fdc592a60e7e68232af056a51113c.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

builtin/repack.c defines a static "packdir" to instruct pack-objects on
where to write any new packfiles. This is also the directory scanned
when removing any packfiles which were made redundant by the latest
repack.

Prepare to move the "existing_packs_remove_redundant" function to its
own compilation unit by passing in this information as a parameter to
that function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 31137cf711..c5a88eda12 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -209,7 +209,8 @@ static void existing_packs_mark_for_deletion(struct existing_packs *existing,
 }
 
 static void remove_redundant_packs_1(struct repository *repo,
-				     struct string_list *packs)
+				     struct string_list *packs,
+				     const char *packdir)
 {
 	struct string_list_item *item;
 	for_each_string_list_item(item, packs) {
@@ -219,10 +220,13 @@ static void remove_redundant_packs_1(struct repository *repo,
 	}
 }
 
-static void existing_packs_remove_redundant(struct existing_packs *existing)
+static void existing_packs_remove_redundant(struct existing_packs *existing,
+					    const char *packdir)
 {
-	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs);
-	remove_redundant_packs_1(existing->repo, &existing->cruft_packs);
+	remove_redundant_packs_1(existing->repo, &existing->non_kept_packs,
+				 packdir);
+	remove_redundant_packs_1(existing->repo, &existing->cruft_packs,
+				 packdir);
 }
 
 static void existing_packs_release(struct existing_packs *existing)
@@ -1659,7 +1663,7 @@ int cmd_repack(int argc,
 
 	if (delete_redundant) {
 		int opts = 0;
-		existing_packs_remove_redundant(&existing);
+		existing_packs_remove_redundant(&existing, packdir);
 
 		if (geometry.split_factor)
 			geometry_remove_redundant_packs(&geometry, &names,
-- 
2.51.0.540.ga7423965ad8

