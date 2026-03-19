Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60F3FE656
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773959075; cv=none; b=gngSbhX2vPI0gS/rhGKwqzbKBIJrJ9Zt83adp5FUz6R+DcvOKZGEGORkti7h8WIwxqvgeK2475oaSKBLcYEdiaCwCercRK5GrfkZd8an585a1ULo74fw2mOOUFkzG74rTejTKxyulufKcgBVsKCthjRA2WIy2gas8aVzGymeCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773959075; c=relaxed/simple;
	bh=8u1Vge9AEVni6exkFhRyROf6lJZZ8jMn4SckFPWYpdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fu/us67yuabWWTI8QYfxFu/47kPCmT1VCSx0KgYwgcjGpB7uEEMp+5+zO6TozW2AARFlzc2bjuFcfJmtese0MGbpBUP5Fg+f4Gs9805iRW1OKwIIJN7pKmPyWpkWSc6n/zDFJB7LO95H55WIrKr43HNeESggKM8fP8TEqtsgFTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UMBetPOr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UMBetPOr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a60975dc5so16206107b3.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1773959069; x=1774563869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjNX3JsWM7XbrGQc4xh9L4jqjoTxZ6/G80a3pUxuQ6k=;
        b=UMBetPOr6UJsr929Stq3CVvPxllCFGJSGLBrZbDP5nPN2CfwyEKAyU7q3gmjcXWm17
         /WE2HvkIbOVHBOH9Rt9kkvee+J96WbV+Ifur1fl6peuwOP/NOtRKQEyy6LiCsCuZWatM
         Ul0keGDmTHb/TO0QDAi+tZ+AZJHXhNPcuFfemwp5NN4BJ17KmuvIGAcZrHUZemHVoTUt
         idUgC7qBefSDamETgUhZbK1j1AQ/YKWmYaRMnn93rQrJvfrfNXmbBnDhg9i3yt1fAlXr
         cS+gb0d5Sr45LYTPtKR9ONQQ0Q3YQ3qp8EyT6nT1FdthiNt+A53V4sVSHYz8PghP/Hsi
         ToZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773959069; x=1774563869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjNX3JsWM7XbrGQc4xh9L4jqjoTxZ6/G80a3pUxuQ6k=;
        b=OabkP0zNO+VoCbDAdZHI5Jv7fDWPX2qiMUmZVLurwE//m5gxiJedwAUaGmoyB1Vdja
         Loofs4eYxnfBkojpA3aeIo6U63T6npz2oGRcXn70x3NYMfgmAGWFpqwKGYNFkSaAfrpG
         Pp97a72JQvDxGAuxkD36kTFFroGPPo/Y8gTmos7zveZ2BbM3GNYaU+fSWEJiBWzELv0q
         IzGk4/tIKAn/UIm+P4SLmUs12N23ku42IMFCPI6X97DM3JGMNsDrixoQ/6n9u457099I
         XpGC5RO0Cet/MZ737WQ6zGDGliCJIQ0RusapExZwS+hkvGvrn1h6fdYX7LeQNuTjKvaj
         1lQQ==
X-Gm-Message-State: AOJu0YwZPKrtTfv2xQp3Z5aG0z3EYPHujRYXRP8mllPhoTYGFm51krG8
	gSjT5uIw3waFAsL+7JNJJotiUFaFDwNAJlDdFsPRugWYMo706BE2+zsVyT88XpfregotIbwoo5Y
	C/vHHX4/9GA==
X-Gm-Gg: ATEYQzxk706Pj1ZDQezeeKpOV1Gkqy3eMoXe/vfOuylmZTkiVV+jNiEigRoY2tuCUo3
	C73oZAIztLdaGe5jo98TY4g679NwjMDd86YDAnwud581PVIHgPC7znVLAOVMRjl4mR1rHgcdF9E
	tVlspQ5Zu6EQHtnyBjolu5TqAlS3EoaTzsLbp85BiH42nXbE4PREX2Zfr/qi2WwuhX61JNPtIVL
	/10+TLKg1Q+qtWBfrEDCLrerkDAv2HhPygUTy06KEb/ysO0+4OzeLVGmd6ApcbJlXgB/eF6BlGg
	bEP/3VSIXd6nDeEuPTGtdeFSoyjIXtiyU+6leTTM6gYllBeyIYWemNxYkOPc5iHeJrY2Kkg+bFZ
	xZ8D4jHXKJVrkH2Bni+RD9QsqI5wrwJ2jHWZItlgHRVTS3puuRBaV9iO0MTjtI7q4d+9M0Q61WI
	/fze85xDCqFbdGQLYN3m0svbutHNOvVxnQ7LY/Qm9hYOiblCv96JLYSnn4B8hnMLIfWSNKhFk0F
	cztF97DCK9cNBHFMu4v7eLulYmdRA==
X-Received: by 2002:a05:690c:6d81:b0:79a:67a1:3e3b with SMTP id 00721157ae682-79a90aa0259mr9291577b3.8.1773959069289;
        Thu, 19 Mar 2026 15:24:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a5ac0sm5401937b3.9.2026.03.19.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:24:28 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:24:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/5] repack: mark non-MIDX packs above the split as
 excluded-open
Message-ID: <c4fd52e751a2eb9f9283f6fe1f360cf1f0793942.1773959041.git.me@ttaylorr.com>
References: <cover.1773959041.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1773959041.git.me@ttaylorr.com>

In 5ee86c273bf (repack: exclude cruft pack(s) from the MIDX where
possible, 2025-06-23), geometric repacking learned to exclude cruft
packs from the MIDX when 'repack.midxMustContainCruft' is set to
'false'.

This works because packs generated with '--stdin-packs=follow' rescue
any once-unreachable objects that later become reachable, making the
resulting packs closed under reachability without needing the cruft pack
in the MIDX.

However, packs above the geometric split that were not part of the
previous MIDX may not have full object closure.  When such packs are
marked as excluded-closed ('^'), pack-objects treats them as a
reachability boundary and does not traverse through them during the
follow pass, potentially leaving the resulting pack without full
closure.

Fix this by marking packs above the geometric split that were not in the
previous MIDX as excluded-open ('!') instead of excluded-closed ('^').
This causes pack-objects to walk through their commits during the follow
pass, rescuing any reachable objects not present in the closed-excluded
packs.

Note that MIDXs which were generated prior to this change and are
unlucky enough to not be closed under reachability may still exhibit
this bug, as we treat all MIDX'd packs as closed. That is true in an
overwhelming number of cases, since in order to have a non-closed MIDX
you would have to:

 - Generate a pack via an earlier geometric repack that is not closed
   under reachability.

 - Store that pack in the MIDX.

 - Avoid picking any commits to receive reachability bitmaps which
   happen to reach objects from which the missing objects are reachable.

In the extremely rare chance that all of the above should happen, an
all-into-one repack will resolve the issue.

Unfortunately, there is no perfect way to determine whether a MIDX'd
pack is closed outside of ensuring that there is a '1' bit in at least
one bitmap for every bit position corresponding to objects in that pack.
While this is possible to do, this approach would treat MIDX'd packs as
open in cases where there is at least one object that is not reachable
from the subset of commits selected for bitmapping.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c        | 19 +++++++++++++++++--
 t/t7704-repack-cruft.sh |  2 +-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f6bb04bef72..4c5a82c2c8d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -369,8 +369,23 @@ int cmd_repack(int argc,
 		 */
 		for (i = 0; i < geometry.split; i++)
 			fprintf(in, "%s\n", pack_basename(geometry.pack[i]));
-		for (i = geometry.split; i < geometry.pack_nr; i++)
-			fprintf(in, "^%s\n", pack_basename(geometry.pack[i]));
+		for (i = geometry.split; i < geometry.pack_nr; i++) {
+			const char *basename = pack_basename(geometry.pack[i]);
+			char marker = '^';
+
+			if (!midx_must_contain_cruft &&
+			    !string_list_has_string(&existing.midx_packs,
+						    basename)) {
+				/*
+				 * Assume non-MIDX'd packs are not
+				 * necessarily closed under
+				 * reachability.
+				 */
+				marker = '!';
+			}
+
+			fprintf(in, "%c%s\n", marker, basename);
+		}
 		fclose(in);
 	}
 
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 77133395b5d..9e03b04315d 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -869,7 +869,7 @@ test_expect_success 'repack --write-midx includes cruft when already geometric'
 	)
 '
 
-test_expect_failure 'repack rescues once-cruft objects above geometric split' '
+test_expect_success 'repack rescues once-cruft objects above geometric split' '
 	git config repack.midxMustContainCruft false &&
 
 	test_commit reachable &&
-- 
2.53.0.614.gc4fd52e751a
