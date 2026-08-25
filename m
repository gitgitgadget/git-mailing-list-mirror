Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1E481FC2
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668228; cv=none; b=NDkMN5v5kJAeS6B8ntmaZZJ2f3dhO84yQKPMl/Mc8IWKoRnrTp2ktQAF1bWoksh72h+/NI7ONamlOLPABEMWbS2oAStk14qsJe74uf9BcueQOccvtX8qy93Rnm+uRoq7c6YsE+p9pGVVj8cba6ZS+Ee0+Z5MrCTfSJTCgs2vwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668228; c=relaxed/simple;
	bh=6qpEaRR0QVNCf9JCKgOnY/4buTZWOkYW3PZslm7FZfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGdOqTV/MI79OmnHOzTYvUfa6U+0YwcDoaotwPKmzNl3tOp6VCkyyh+H5cD3ZnhJolAOZw0ARwqwwiSOvGW7RMFbDL6VXuIZCvK53YDwfskzuhXaFj1nf5OtCV/GqnZCDYpm82/CvyYN3eH5sl39lGnPORqfSelHZ/0LF+lXRto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S1HpTgFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PLLqUTap; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S1HpTgFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PLLqUTap"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1A6B17A0151
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 25 Aug 2026 10:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787668223;
	 x=1787754623; bh=vDNdRAH/KtL7xWgk2FkSnwwwfwQ/Cw4eZmBTIoW8fK8=; b=
	S1HpTgFLl0xYeSU37vHDQnAj4/GYXn4+/KvhdNz5D0L09IHAVPQwT6jYrS3lTtty
	8nJlLASYssbhXmPJQVckOywuVnpA0zXmsqlCzjnBpXG6BfEr+cqNgyQ0/BaysV4I
	XOI4cNyzibmZfNaF8iyqbBGI9IRmEwkpSaGuiYXNvvNo+gdzlXL+kq2NQdO8x8mN
	eYSiqcvLW+SsCw+FdSyXa1J5dboyPMzBEmn9wRgHO9kb/nNFvn7gm2NyZXqjQrho
	vJU5p+jP08baBkmNVy882HU+EeMWSq1B6IqMmi/niZcWc9MXu+93SH1ubI4B2wj2
	bjmguaYcuOiGS1UJJIQ+xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787668223; x=
	1787754623; bh=vDNdRAH/KtL7xWgk2FkSnwwwfwQ/Cw4eZmBTIoW8fK8=; b=P
	LLqUTapKOZ9OnyGmu1b5rnC4i3WP6XDmXwM5Dn9WNPABxjuj6sPA8bIBuOmW4WYP
	J88SYNdUN61VZEPnhjFhn8riOR7xm5h2HTnD/+JqR9hwMd6PaLcbM2QqNj2Arra1
	y66hKjxJdvzUnW053s5xbye2U++98Tfrm0pjO1HySW0wB4YYNrD6qk+4+i+qxCYo
	/VjV3jCSpwHs6P+MViTeTws1vz6TPtlqQK+ZIEWSiML4xKIqamfHm9sRupXBpZdD
	BXwd6SQATKDXAmFKmSrAzV37i8jCGCseuvEatAwOkNmCjMW6utW8A21VuiomuXCi
	x1AE/pMf6M0iuyYJDzBRA==
X-ME-Sender: <xms:_6aNausOXNcMDBO6Lhn8a30AS4JQpemsdknFKWho5FIZA-__svLV3g>
    <xme:_6aNaqaQ3ZjdmFkL848MyfRAD3GgbODzzzcPqhP3huABREKYUlzwa6ToPdLE1IJs9
    ggWcgZKNIyFwv0LzqX4N9RFouE8dP2op-9SnZURPuLBB_qK6USZYQ>
X-ME-Received: <xmr:_6aNavYldu91awQnnzdnDYo7I2KYX8ksEAL-K7JLvYtMTWkrCrO1cVXUMOlojSJ1pmMAFMy65_wWSfJkwLHvU25ZSrp3NknrzjK08QuwGQ>
X-ME-Proxy-Cause: dmFkZTF7di7P9fqeVtKyfLKbViZD7TBnl4srwz5Ve7VQBJmvFG7KMshIDpaCixvYPMRY1h
    MToVw8leZsp6NRTEnNkzR2GbnzhIeSkDMXyz6tF1rPG3WCmPgAfOp7w9ECiJnWNm3qggyf
    pLU70w6A34nyTdJBsTiO7P4+tQsyhOcfD6IbKuN50FcBA4BTbgRys6YYiGRQNZVpKGXBR8
    +Yz6NjycNLVfAEeHhUraj08VjNvG7b1J92ThlgvTW+tWd3AIJZcCqdUSRypwuSKWRIkp/w
    B5AADDwhd0O4ES96La8mcFBQZ+myORW03YyVssffHdRAHA1X5QkXTM5vsOoGZqFrWVlOAF
    SM+DvOkByzJ/Dj5Nql0JF81+D6jdnOZqqmn8rftFOSZO6SnLr0dHX8RwF7UNK6ZbP50MIT
    8IVdEuXoHo5pSiOzDS68EX3VMF0KCpGPMXxMGPXcxmscmTLhD2CafVTod7OuiocKU8ljwX
    J6PPzQop97Cj+pw/1Y4jELqIVuCa3WzpAIOIGVOxnD64UNEl7IKlkCVzixxFmL2OsAmMuM
    G1KrgazQWEy9fPno8Q2E9H164Sx/ZDvuqQ43zeYYlsCHKdTn8JlZtUGiFi3xoDyJJ4Sbas
    QTXYC9BO4aPhlpECZ9boq+ljQzY25JhH6+cDDx+lEPh0XqlDfw6+hm0om9vA
X-ME-Proxy: <xmx:_6aNauWuptYKwePXEqe0l1c_NxFcJcIQEfAlomlrDbqTp6Zk9yagvQ>
    <xmx:_6aNau0qW5j5b8wiCD_ovaHd33g7oJn9dadvd0jwr5WwzTjuaXdVcw>
    <xmx:_6aNatYhiaG12KGrJgjdCgR2230ImJbRWb8dWvgPHKg-qPOe0IzOoQ>
    <xmx:_6aNapq1ENBjVZrZ-kCFWXFB8KeISIVdbMDYCKhO-XSXpZptdAzbUQ>
    <xmx:_6aNapeBaE-2sQbVtMvnwq1LAOtDyc4QQ9X-ffUj7XQ7k3Ng9eyaM3qW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 25 Aug 2026 10:30:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 500e1e54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 25 Aug 2026 14:30:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Aug 2026 16:30:06 +0200
Subject: [PATCH 04/10] builtin/fsck: don't check alternates with
 "--no-full"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-pks-odb-source-fsck-v1-4-b756de0bf24f@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
In-Reply-To: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

According to git-fsck(1), the "--full" option behaves in the following
way:

  Check not just objects in GIT_OBJECT_DIRECTORY ($GIT_DIR/objects), but
  also the ones found in alternate object pools listed in
  GIT_ALTERNATE_OBJECT_DIRECTORIES or $GIT_DIR/objects/info/alternates,
  and in packed Git archives found in $GIT_DIR/objects/pack and
  corresponding pack subdirectories in alternate object pools.

So ultimately, it is supposed to control two things: (1) whether we only
check the main object directory, and (2) whether we check packfiles.

In its current state though, the flag only controls whether we check
packfiles or not, and if so we verify packfiles of all attached sources.
But we also have checks for loose objects in git-fsck(1), and here we
unconditionally check them in all sources.

The flag is arguably conflating two unrelated concerns with one another,
and it really should be split up into two flags: one that controls how
thorough we want to check individual sources, and one that controls
which sources we want to check in the first place. So ideally, we would
have:

  - "--include-alternates": check all sources, not only the local one.

  - "--include-optimized-objects": check not only loose objects, but
    also those that have been packed. Note that we explicitly don't say
    "--include-packed-objects" here to be more backend-agnostic.

  - "--full": implies both of the above flags.

This feels out of scope for this series though. So for now, simply fix
the code by honoring locality of the sources for loose objects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c  | 3 ++-
 t/t1450-fsck.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5132ff0f15..3f6056535f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1047,7 +1047,8 @@ int cmd_fsck(int argc,
 				    mark_object_for_connectivity, repo, 0);
 	} else {
 		for (source = repo->objects->sources; source; source = source->next)
-			fsck_source(repo, source);
+			if (check_full || source->local)
+				fsck_source(repo, source);
 
 		if (check_full) {
 			struct packed_git *p;
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 77cd96de78..1b4074304c 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -844,6 +844,11 @@ test_expect_success 'alternate objects are correctly blamed' '
 	echo "../../alt.git/objects" >.git/objects/info/alternates &&
 	mkdir alt.git/objects/$(dirname $path) &&
 	>alt.git/objects/$(dirname $path)/$(basename $path) &&
+
+	# Without "--full", only the local object source is checked.
+	git fsck --no-full >out 2>&1 &&
+	test_must_be_empty out &&
+
 	test_must_fail git fsck >out 2>&1 &&
 	test_grep alt.git out
 '

-- 
2.55.0.822.g20453c30eb.dirty

