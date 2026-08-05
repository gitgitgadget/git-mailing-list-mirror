Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D33A6EF1
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 03:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785902273; cv=none; b=uCabQ25z+GwbEl3u4od8IddCjHYQTF4TitabdpHctQxXYxlnkkVShXypALKX4jch/5U/0qrTDniqjCRGayS3D2QpVxB5qBEXQy05KmazUI5TMd9XHDiCEQJ4VkmYEcdKC1V9Tfgay/sXKMQHrKPoBx+p3iM7WEyYaEnsmlbH5T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785902273; c=relaxed/simple;
	bh=NXPnpm44ZAGei9+FLfD4xGdWVotEkPOxJ9ix50sS7j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNXUWUTA4Tv+3ETqKwrZuRSp47tvdkWQhQiQDGD1Kn9dC4+n/ArSB1i5RvhGwb+KjuTSUrjZ9h0LJ/wA2l8C+Y/YW2LGNH985lA6yBu6BD3fAJrqLCvFfRMMkADH007IzZvwrpI/fSUZVUXKN0u8f0pKzRtWeI2pCGnSfYxy8Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Tuy/TpNW; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Tuy/TpNW"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6688acd1a51so708735d50.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 20:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785902271; x=1786507071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqk2ni2NcWN7VxtKX1LvhX6EEw5DFCUh7BbY8rM/H9o=;
        b=Tuy/TpNW3rQ0trbSyCexp0AAlpB2Pe2pNX3YvkUVqO5FgBMlcXK6XQrxiOQTPYE9X/
         KNJI4UngX4IR6p3+597AKDtBhJjZdNT9sxJISc8HCKhxPq0ptwo786i7xe6kC0Bx43P6
         w1DnrTMTJQXN5HkHnwo+vZ4oFE9p1WrojIhxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785902271; x=1786507071;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqk2ni2NcWN7VxtKX1LvhX6EEw5DFCUh7BbY8rM/H9o=;
        b=Ch/tLMPDyIJji7wkp1jYsnoMh9dQNH0sKrjYwgW9i++kC+9MwcmV88pRrTdN17T9Kz
         fPx0c+OSYNka2SQlYcd7Tnb2f/2oDSS+faGIOTYjIWSRS1RXTTfcmQX7XsSCVKoUxz+5
         +/1MBrxsJ/G4HDU1dWoCU+BqRgP2JL+zVfIcno0y8PLSYgWdkQ0NLbC6YhJrf2UDM9dH
         XJWQURYVsteyqy5LqAX4xVje8ZUkDHA4serG1vJMZA0uOYzBhAKnfE13aDsWf19OYM1s
         slkfAQwXIYPojiPCZ1UMrOc0Dl+SXTlnjCmmWWeDc9vuH3LEslfB8kmi0P8XVw4lpo6e
         mi1w==
X-Gm-Message-State: AOJu0YxHw1SDBkQRotYLY1UCDUnJY5YLfdEmefrYmjsRSBIgxrxkMfbn
	SFQ6aVHBXeIVFYy9IBxeEcJi9gHXVainrQ8IadLIFY+aFpwJ2AiO3C858fooR+ZrfVCzTUMkkh7
	JVoMH0mY=
X-Gm-Gg: AR+sD11yIM03VLeBhyjV+4WVqZIQEgwxup9XOCxXLK+i8RdxPR6NSyPqGF0MP2EmMfJ
	kEHX9xInhIlR/0bSD9rJsbUNOWwJyLpFwWlQ6kbQfAh5HQL7Y/V7T/ze2dDuOl9YFhGpu/Yafmv
	S+aGEauI2Pz61FNv3kRh9/tfbqY1nIiRTWExoifLBYM7+udMXeVZ5PTs+0dbBfuPLLjM3B3/VJp
	XPW2uiWf9ILMPc6jk77QdgcXse1xVnrbU0LPOqQ4gpVB60tGSOU1lnkX5hgWubj9eQDuaKrvhlV
	c5mByiHXJFo753hFqhcNsLichjvS4qNdZ3mjraKp3lKrUN6ojoyrakMgrL7KHizlPHapFl8jU/V
	oKSj6OFMzMNqobtrckqYMEHe+u7LGSzrx1IgP7cqqaVr9Z9nU3NDUpzIe/dDC6PKDtePMYaQpb2
	Yw6EsBuX4ocDvC63OV9VumkSVQku2fgUo4Kzz/3iaOC49NU9iwEH5N4T0lqt8ev7NvF/s4rFuJe
	P33R7TnmchhbuTBr10ePtMaqHogIB0PmXb62svNaxYB
X-Received: by 2002:a53:c446:0:b0:667:f3d7:eb35 with SMTP id 956f58d0204a3-6699aa3eb17mr1736050d50.6.1785902271130;
        Tue, 04 Aug 2026 20:57:51 -0700 (PDT)
Received: from com-79390 ([199.47.143.8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6699136af8dsm2162098d50.2.2026.08.04.20.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 20:57:50 -0700 (PDT)
Date: Tue, 4 Aug 2026 20:57:46 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>, Ted Nyman <tnyman@openai.com>
Subject: [PATCH 2/2] maintenance: trigger --auto for promisor rollups
Message-ID: <dc2fffc37cead551f8036c9ecab5e52a4cbee37b.1785902237.git.ttaylorr@openai.com>
References: <cover.1785902237.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1785902237.git.ttaylorr@openai.com>

Commit 9bc151850c (builtin/maintenance: introduce "geometric-repack"
task, 2025-10-24) added an auto condition for the geometric-repack
task. It runs the task when ordinary packs need to be combined or when
the number of loose objects crosses the configured threshold.

Later on in commit dcc9c7ef47 (builtin/repack: handle promisor packs
with geometric repacking, 2026-01-05), the geometric repack machinery
started handling promisor packs separately, but did not correspondingly
update the auto condition.

As a result, a repository can have promisor packs ready to combine
while its non-promisor packs and loose object count require no work. In
that case, `--auto` skips the task even though a geometric repack
would combine at least two promisor packs.

Check `geometry.promisor_split` alongside `geometry.split`.

There is some fallout in t5331: the new condition makes a filtered
clone eligible for auto-maintenance before the test inspects its
promisor packs. Disable auto-maintenance in that fixture so it
continues to test `--stdin-packs`, not the maintenance task.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 builtin/gc.c                  |  2 +-
 t/t5331-pack-objects-stdin.sh |  3 ++-
 t/t7900-maintenance.sh        | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ed75c12c43..e9572940dc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1649,7 +1649,7 @@ static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
 	 * When we'd merge at least two packs with one another we always
 	 * perform the repack.
 	 */
-	if (geometry.split) {
+	if (geometry.split || geometry.promisor_split) {
 		ret = 1;
 		goto out;
 	}
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index c74b5861af..2a983e28ac 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -368,7 +368,8 @@ test_expect_success '--stdin-packs does not perform backfill fetch' '
 	git -C remote config set --local uploadpack.allowfilter 1 &&
 	git -C remote config set --local uploadpack.allowanysha1inwant 1 &&
 
-	git clone --filter=tree:0 "file://$(pwd)/remote" client &&
+	git -c maintenance.auto=false clone --filter=tree:0 \
+		"file://$(pwd)/remote" client &&
 	(
 		cd client &&
 		ls .git/objects/pack/*.promisor | sed "s|.*/||; s/\.promisor$/.pack/" >packs &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index ba5b359e77..fb5f2d8902 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -759,6 +759,29 @@ test_expect_success 'geometric repacking with --auto' '
 	)
 '
 
+test_expect_success 'geometric repacking with --auto handles promisor packs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+		git remote add promisor garbage &&
+		git config set remote.promisor.promisor true &&
+
+		for n in $(test_seq 6)
+		do
+			test_commit $n || return 1
+		done &&
+
+		pack_promisor 1 >/dev/null &&
+		pack_promisor 1..2 >/dev/null &&
+		pack_promisor 2..6 >/dev/null &&
+		git prune-packed &&
+
+		test_geometric_repack_needed true auto=9000
+	)
+'
+
 test_expect_success 'geometric repacking honors configured split factor' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.0.483.gdc2fffc37c
