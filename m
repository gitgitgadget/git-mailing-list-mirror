Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1F3CD8D3
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140424; cv=none; b=AQ6MObLK3VBwknAS+dHk4QFHNQ5GOaO1rb35LBQTq2Ej30ydYHY5j+hg3Ns6w9Ujqxpx66IH1YPQLx1oUJY8lHLzmlVWS1spg9T43AgHDWIBLB642F0M83FmTG7zOxxnN4wxZeg5Jvg/B3hhvE7lbJuLIM4uJetlh+daWNRpsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140424; c=relaxed/simple;
	bh=9rTKenrLdvqMEF8PyehPuyoUNV4PUzaUef1YOGKLrHI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rWqxj5LaudWvgi+o0n68Y6U2dEt/phZ0uaEO6a93mnHvCEkEQOE5Kuo8nA9Jo2rDTw/rra8CDgBeu2e9Do2e0Ngp6Iv+uaJRwFzA3SarclBFu+vKOTyw6ncEt2NyVdpkcTJbxEwej6GEYCu8NXEAf0SEkSA2tQt9wXno17Kac7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0Axj9ZS; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0Axj9ZS"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89cc71f4311so11952246d6.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140422; x=1775745222; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dawH4QE158lj4sRDGtHrx0oqYiK6oDsVS2ww0T9lIw=;
        b=a0Axj9ZSRVLuQHNDNceud3DnykGDpnzNOkuRVT3vTGl9Sw+M8ksP9HXB9FOoa8Hf4m
         Jl5kRMkSsWTa2YdmM/WTYa7FudqvzudF8uTJDkzTRrFaU41wl6xFBcb1TtJksgIf2WRg
         c6wZ9PUzSh6qfmZlZV8u7kIT++QMk9yb8yku2weB7ksVJOXv2EJtzW+y9b/g1dDOwFCS
         If7IgxEG3u9Nor37/ZL9RpZXDAb+oriqOWuAJK3WbN3RxBWBvUYMLvL0kK2NycQA5C8/
         xA1aUxzXt617O8DuXY5k8ua2zEMEb+IyFmdAl7JQQRrIjMbZeA0txT8E7V4GxOm6F2xY
         Eh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140422; x=1775745222;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3dawH4QE158lj4sRDGtHrx0oqYiK6oDsVS2ww0T9lIw=;
        b=QoRYOrW1rnHXzxK3TxVmFoFXHuiXlAGYc8xbJpb6R/AcjgVcN9Zud38o2BWjFbS3oF
         i0DvI1olbN+ButjHAoSQFUA64K0/gfQFT08snz5+rKrt7YsWtEyRAl+iBND0BjkJ5JNP
         yXWe8T9T9kPGnpWlZMMpvF5ejQcXiezRVi+i2rnzCCA3/qTadbeJGeHr/HUO5dx9zU5U
         vC9mXPyl+lEO3ev7o4CycMP/FjkoOc5qMsXRccSji+ggkrHt1E40a3njYB5Br6RfyZJr
         I4muOI14yk4HDiQwDqt9PzHnDHf9h+9BqkdOSr9R78ttnGltzc6J2+QfdQwxWuGAyCdw
         nOrg==
X-Gm-Message-State: AOJu0YxRTMvyiC05k8hiFrRAfPVRBFYeJUrenFAUhLPM3e/QIyArOBst
	0Gs/5If5W+wCL2wH3QSo+lZ9I23Oe7PIZrKOW+4Plizpz1KYO9yspP6+TBt+cw==
X-Gm-Gg: AeBDietrZhYSaeLMxKbJj30t4ZA+L+cO4XdoiAqVj9uZVVOOsvR+4SDba4B+ts9s9vI
	HSKQwRZFpJyQy/FcN9z/wTc0p5kjxFYFyZz3qum8nqL2GF9gV5qX3CVUS7H2qRSMpXPBG8+0Q8J
	LDLFt5qv/J5gjUuSiN+SE5zHh/QvI7kZbE+fJdOZLNgoYAqPiSzGfRldEYhXS8Pjy5Y4/qscpgu
	tEQDh842t/DYnGzlaT3I8xnhtlhzn5Yoi0qWRsezdkWkUUd3YxfLEQ9SUIBKixjkUiNu5wknkM4
	IMjGzUIIPnRz3X0kGN0FNiDCUkJQ2OXTeCA1CSe2SojN8Zip9MawKh5VR4lJD0nnxBTHuSTj0hB
	Ahh7vw/3j/8mPfQqlpjDAHF5C+3DaPoZjN2wODr7xqQhwy+6RfQLir+oHwQfIQz0mbNck1wxQNd
	L2RkL4hJ6StHJlrddW+C0evzCFAeo=
X-Received: by 2002:a0c:f10e:0:b0:8a1:e3f8:b214 with SMTP id 6a1803df08f44-8a43999b3ccmr101102016d6.33.1775140422241;
        Thu, 02 Apr 2026 07:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593cf0691sm23965716d6.20.2026.04.02.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:41 -0700 (PDT)
Message-Id: <5aa3f2a225b9b22a026e0994f2eef583da9d26db.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:18 +0000
Subject: [PATCH 12/17] t5540/t5541: avoid accessing a bare repository via `-C
 <dir>`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the `test_http_push_nonff` function both of these test scripts
call, there were two Git invocations that assume that bare repositories
will always be discovered when the current working directory is inside
one. This is unlikely to be true forever because at some stage, the
`safe.bareRepository` config is prone to be modified to be safe by
default.

So let's be safe and specify the bare repository explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-httpd.sh | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 4c76e813e3..f15158b2c5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -259,7 +259,7 @@ test_http_push_nonff () {
 
 	test_expect_success 'non-fast-forward push fails' '
 		cd "$REMOTE_REPO" &&
-		HEAD=$(git rev-parse --verify HEAD) &&
+		HEAD=$(git --git-dir=. rev-parse --verify HEAD) &&
 
 		cd "$LOCAL_REPO" &&
 		git checkout $BRANCH &&
@@ -270,7 +270,7 @@ test_http_push_nonff () {
 		(
 			cd "$REMOTE_REPO" &&
 			echo "$HEAD" >expect &&
-			git rev-parse --verify HEAD >actual &&
+			git --git-dir=. rev-parse --verify HEAD >actual &&
 			test_cmp expect actual
 		)
 	'
@@ -284,18 +284,16 @@ test_http_push_nonff () {
 	'
 
 	test_expect_${EXPECT_CAS_RESULT} 'force with lease aka cas' '
-		HEAD=$(	cd "$REMOTE_REPO" && git rev-parse --verify HEAD ) &&
+		HEAD=$(git --git-dir="$REMOTE_REPO" rev-parse --verify HEAD) &&
 		test_when_finished '\''
-			(cd "$REMOTE_REPO" && git update-ref HEAD "$HEAD")
+			git --git-dir="$REMOTE_REPO" update-ref HEAD "$HEAD"
 		'\'' &&
 		(
 			cd "$LOCAL_REPO" &&
 			git push -v --force-with-lease=$BRANCH:$HEAD origin
 		) &&
 		git rev-parse --verify "$BRANCH" >expect &&
-		(
-			cd "$REMOTE_REPO" && git rev-parse --verify HEAD
-		) >actual &&
+		git --git-dir="$REMOTE_REPO" rev-parse --verify HEAD >actual &&
 		test_cmp expect actual
 	'
 }
-- 
gitgitgadget

