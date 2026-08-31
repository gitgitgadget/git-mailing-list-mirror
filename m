Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AD23C0611
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158794; cv=none; b=V5DTa6F8LbAA9e8Vs2peEHTxPrcdN37W9o4Rh1AV0+EH2jJ8AQM4eTJT584OwmWwpyGhzjWZA1J8MusUu31X9z7/i4utvgfBX5I0URezPau5S+iJAStkdAcKeNNHckOGs8ru1XoH0ekRSWkZNmXYMxJ+GSlB9jYXbzB3hh89ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158794; c=relaxed/simple;
	bh=oN4DYx3nXmJ9+7YO5/If/G2e549QawIXSnExD+ROH6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDl5oW+lc26jA0B3LSBldqvRfACnP0dGLmtW4plqri0+mXRNR+nyLUJ2kMyeDI8wO0rYb/Tk8dIq8pYLsCdr8YKUtPzlFgwQZ6lB3nm11Zj5bDLw3y8vMpiP8RiZOaUzhQW2bEXHg/MnWO5V2ThOpeVj2jIdchTgoz6mulQADik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UkdoNwqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XRWOg65c; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UkdoNwqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XRWOg65c"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 090A87A0159;
	Mon, 31 Aug 2026 02:46:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 31 Aug 2026 02:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788158791;
	 x=1788245191; bh=2kVGgrBKT9Ts9/ajX8nTpfkFVz8Sxfj6bydJoHEK40Q=; b=
	UkdoNwqivbCJDKNpfu9VdnokmJlkZk/GBhM4ZNAksXX8LFPZIUSHZ6qiaSlLblij
	hJrnaSdZ3NWwhPJrcMtEIXoWUXEUxHDskHZmNo1YJYaZD4yV7NZKh+ALVDg4QBjH
	iamArql+FyJXqaojbC5dphfNUp0HVVqmncQMDMBmVv1SHbF9fsh98nihri3z00Fs
	iC/js8P/2VNZN+wIz4P4b62B+ZqCnnK7magjXUCQlKatmzRK2GrPjsGNnTp8UWgR
	YPtAFE0grDV373z0KJjtLCknb0PKJyG0983PMUp5mAXEI4xuOLZysnzyPjFL/yYF
	qf7krJBXRzdWoZfd9Ti9/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788158791; x=
	1788245191; bh=2kVGgrBKT9Ts9/ajX8nTpfkFVz8Sxfj6bydJoHEK40Q=; b=X
	RWOg65cMTeB2Z2eiXSY/Slb5ELCvdcwQSr1NRC7hY0kSPKIJeph5CzjHoBYGoZMe
	cTl7lsoYuarpImnatmx8b8nJdRlLuRUo8GkjeA7kRlhW4Ih9WhnibTCzHxpHxdF9
	Dz7KoIrVqahsl29B7FfGTK0OWps3UlvOaZFEdSxksDBoSayNKWi7EMiJGbjzadF8
	vnivGvhCCO4xoHdvj4f2uqY68psRhC6WXbYgOpoemIQxYPX14C6Nl0FlI+rjTGGz
	D+TZfhwPveuVqkUfW5Jb541n9lAQqj/LCZ0MBELwBot0we9n8ku4mA7Mu9vLXkQ2
	BEHRGAbSjHj8/vJL7QpeQ==
X-ME-Sender: <xms:RyOVag4apPONkOFmVQZv7bnWKaNMFJJFK3CsPJoUdJKJ__loO7Zbsw>
    <xme:RyOVan5Lwy1iANRfhPefvpTwbC5HC5QAHfaymVlyCS6c3xpMW4023572aLmcmyFTo
    oJsBicgnuqR1WMx0oZI7o_S-FzNaee_MTkkfw6wy46oG0R1pToq>
X-ME-Received: <xmr:RyOVatFOawIoBQQdC-gmDho5oE9RahczkrFbgRh9xPw1Y_a4E1JUPGF0BhLR6WoHExoF2A>
X-ME-Proxy-Cause: dmFkZTEYVf0dL7UGrcJrZICBDSB3LjjfPaqozSE//v2Uk+wmrGGsN1vPAxnqAgkLBIQ8YH
    jkGm/0q2QCpTLzGMeN0PR1MeaTkM5EPaoEuoMhHzPGrgkrrahxb2HsmJ1bVk4UiWR43FR+
    opCeq8ZwOupZwyvgFz/5EO1rlWMX9ymY395FZ4JB8b6N4ddSX0Lf/ccWyhtowb9unYs78i
    q65B8tbD9ISvvMC186S9fuYl1A66bWAlIet37pjlPsFSIH2y9YQw83JMBRERaOog6/NRAV
    yj9dTKgCGRxgJt3f7+n8VX5/0i3r6oQenmQAn+SILo/sIBIqcd93oq/gzZ6ziXimOnALqW
    TcqAG/neV/4r7ReJFprzMrbGL6XElHwHc/oowaDPy3Kl+MQ9UigFMnqNo2NJ0MYlvD41iJ
    BXnKnmx+VOIjePk9sAeA9zuS7TJi6Hmm+0QvhyN11JpKKDOKaHntngn9YQ1ET4HBhRaO+z
    vi//xZrpO6RpXwYfw4NlnuyZ04SwqqApPTvy4LkF9VOk4m7A1vVQfX/SvGk6tfEpKiG/kH
    M8u/Z2alrQfb+GmpexmDWLOh78s2h9SA69FJTQvKLGFRdg7P14yj7WwWWAW3itHDgx+dI9
    hUoEiCPG3BLBEoDNDG1AKBKaLkBWcq00EEGkNrjr27w8GDaWEZbe0PbFWP7Q
X-ME-Proxy: <xmx:RyOVagSeBn920Wl275WKJ_GD8A6Rmnf7GjZ3djl9sUO3NuNnX8cKIw>
    <xmx:RyOVamtdPxUCx40X8CuqYh9TKNSKBJj-Bue36FhE47-m_scOCTJxkg>
    <xmx:RyOVavzTJIBdYsFfTDtAAeifNYKk80Ldix_Q6DIpmnFQjvw3pVGTpA>
    <xmx:RyOVag5dB3YLDRBaWg8gaszaqnIKgLTDAswmZqdMPDA1VkASxq6gXA>
    <xmx:RyOVajLg-5F-OGPd7I8riGHgSn8EkbnCaNUFPDSUTGr6LbTHcx9E6Z92>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 02:46:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 465a6c49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 06:46:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Aug 2026 08:46:18 +0200
Subject: [PATCH v2 04/10] builtin/fsck: don't check alternates with
 "--no-full"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-pks-odb-source-fsck-v2-4-f9b16ef4957b@pks.im>
References: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
In-Reply-To: <20260831-pks-odb-source-fsck-v2-0-f9b16ef4957b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.55.0.979.g7e5102b832.dirty

