Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B118FC80
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190801; cv=none; b=sn8dLzGzxHiGDy1q4KAPZySBFCWlGpMLf/Bj9N51hd0FNeIKZlFmdEw8/xJYUrLzcXV+a9xs4TIVeFlPXCxFMwapFp50mm7BOJFQ3lZXRr1LFJ9nbOW1OUncNBoOI0xO3pviQV+YIiUGSvUBaBCifg1vuqN+QzY7nCwpmeXe5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190801; c=relaxed/simple;
	bh=deOTI3CAXLDqcJ5uOmOx/DBD8bKoVKV6pKPPHCVqrok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KAFF4ns1xOHo5tyo+JMt1P5trIbnhC1saZHWZF/VxxZrHucH4k4qx61KJR061tgoGUsuXP8RohtRUMMucgrhkuHWJAGlQ3fbOIeVuyW0kKqycDsNIxyikTnev67JRdhUsXvifTI/2zumYt1QHI063xNXZuknzsJg12NNrVPtoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MZikjRq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xYMs8XRF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MZikjRq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xYMs8XRF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8624514000F7
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:46:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 16 Oct 2026 18:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1792190798; x=1792277198; bh=WcFkb6AqZniBmtQaXXM3pKn6uT5T5o13
	sMQH11py6qs=; b=MZikjRq4JMfofwFZh793n9nZB5JdG9zOgdm6RD9LothtgDVd
	E3xDRQcKHiF5hAmr9ufEhbNlxkVM0O6qfJB6gmtB2gRp0fNMS+Qv8mqi+FRFiY0F
	lY8DAYcU8adsJ5exK29BGmWAZEUo0zPqoRCYYsJhhhXjOFwvcDnRYOUUVxmlqh/D
	xuXrOW7bpZ5itW358OS4Iuty+lXwZarTgepJKMLkH5tF7Zt9ajJ5QGxLC1Sp8cQd
	n77HdF5WldBb8+pjQbv3w35EaY4CwOH9QJipumUQEMFoFCoynlpkusZbRLltegHc
	ViRi2ztQOD78mL43cj0zOjCCKbjjp0Md2TXnbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792190798; x=
	1792277198; bh=WcFkb6AqZniBmtQaXXM3pKn6uT5T5o13sMQH11py6qs=; b=x
	YMs8XRFNu7iheNLCQhNQv5OnnVz4MvmkXYFlTofN9Xw0WaBoDPaJeSpPB7Xp7GMd
	amjhI+NZqliQzpvhf9q1pAvCMFOg6f/TARWeV538v7vUCOaFGMHsAUOS3cmMfF2U
	HAey5REHEe45A0j4NUv95+zIXXc2ygYRHmVG6CIKMNpt5nW0wcs2mPV3ZaGz+rPG
	EiipddxRejxO0Ij62y6RSPBC3QX4MBrY91+DeffAeG7X4+/PmWXvoV2Cng05B3ks
	Yofs9unjrHc3ii4xd0uy4o5t73n31BjMWBw1OBZdieNWpv/gEvDe3yud3DwNNZrt
	UBy8UpM4crUFS6wPqpCSQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792190798; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UkfdkZoE9lkVJJS1Au7h/F2F4FCDV3EZ7i1QJBykCVh8fr6
	GjcYsTDtyYEQROrtSNnyOKP2j/Yl0Adpp/GkaLLeDhYc30dmSA+BvRv4NtKjArqz
	bFd2LYs2vb10mvheW3uOribT6jcA6rCD7CDHFvxkNkEg16npzhbFHBdKJxIgdkIV
	6SoFqAmGKQqXdW6Rdq5yCZqCy9mztReoc/8XhJzJpS4uOlukcfVLogfv5tegQuQl
	SN24xOQ0xSYAveudrkXpMStBwhmc0YT11mJMcCpneNRWO9R+BvBBi3/CKBhfZYfn
	ntinzAIBJkcDwy+zCS6JGjWbVX7dqj4dFpcFLcQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:q6TLeCciq61IfEbvrOruHPy5thUBVgSGogvC3cWO10A=:deOTI3CAXLDqcJ5uOmOx/DBD8bKoVKV6pKPPHCVqrok=;
X-ME-Sender: <xms:TqnSagw4RmuPCbD6ym8MN8RjTOfEJoO4rG-jgVfuMSdMYgMxmiw15Q>
    <xme:TqnSaqRE5K7uSMuOri6juumOKEXqTjstydGyJ0q-WGsnn-VFqb_iopHQyRukdbJc4
    OsyE6cZpr8wEas6DzW-RGdxsX_A8osTjjQi0AlxuwS51VGXKhvWUu4>
X-ME-Received: <xmr:TqnSav-HVUC1zQip6oWbh9h4-kAxjWP1aTwOzLQNJ1UJ0JAlGEGes9CAtmVVujc1G3pCHm7RJH9o4baF2wlgkLNvyprKmPc-GkHe>
X-ME-Proxy-Cause: dmFkZTEZ2vKYWVPw+WPUySJI74mlH0sNyf9Bpns3N87SoI/GLpreT2EriywlI9z5LvA642
    O0vd4sfmCrrtyyi/DE0yVPOvBwc9jpDp2+80QILBLymuYNWTICp1qfDBQPiuvtppq6+YdA
    Mad9qhS+LPboJKE9+m19vNZMBflMEZyKSsvwS8U+W0YjwIQoZvZ+v8psDysr6AdpYY4FL1
    OSqRC8YkuDAmLZH5vmhZRVA9BV/Zb11DccBFAn6yEsbJ8eci3n27bpnIHf4fyCD1HYwfvR
    fcTnTXPZ/EMDJ/s0ZT6WkU/K4OLmvIczmbwmEsrnlWBxmhP0eN+GerG8pdK2XJxVUkP4n6
    nWtP0bNpQcivblxBgZqGR6Q3VK4oODYDMhRY7af429KeSMp9XIPRoN3L3/mX5oX8UlZBiG
    GhqWDx61BHY43vpfJLZygCHKmitfHmyMkbMA09pzwp1xiv8OlhbfzhTkEwoAc1i1MsJsiu
    aSRGozGvVzIyV29XUejRcK8XoIhO87myVzrIb8MBbq4AjPTxS6WeUZVAFh+oStjMZXB0db
    siYUtTjE8JoGTe9shZPBnnRO8hLxr8TFh+HA5ONlGOrDnpARkwRRAbdWGvGcyif7xwdXD5
    MGHbOVoPyKlutM04moDLGsqHcHhv8MrMrgOPTrsK3zSTFl3lkANXkD8PxUxg
X-ME-Proxy: <xmx:TqnSappKiOXzsT-D6dMO-Pv9gkWm1ayoGEAdo1HFagy9P_yFkv-yeg>
    <xmx:TqnSakmdzGnGGVPf14b-vRCwrxH-0TDYHuDbi5_yoUBpXYuvceStWQ>
    <xmx:TqnSaoJ5UswQl9pxK5E-eXj5kKCVf04nrQuyizCa5IYJ2Czgm_R34g>
    <xmx:TqnSahw7tbPdPknNzbI67GUFSZT6zi9dyy0OQtAE8V-l9ijuyWQS8w>
    <xmx:TqnSakI8NIzx8pZuLnOLtnrB6M01ERnYfJc0i5jkY-T6bHFDDsQwugH2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 18:46:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] github-ci: update macos jobs to macos-15
Date: Fri, 16 Oct 2026 15:46:36 -0700
Message-ID: <xmqqfqy5clgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

GitHub from <no-reply@github.com> address keeps sending

  Subject: [Action Required] macOS 14 hosted runner image is closing down

and suggests to update to either macos-latest (macos-26) or
macos-15.  As we do not have strong reason to pick one over the
other, this patch picks more conservative choice with hopefully
smaller impact.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Not tested at all and I do not do macos myself.

 .github/workflows/main.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git i/.github/workflows/main.yml w/.github/workflows/main.yml
index b229739be8..d69f6f2b10 100644
--- i/.github/workflows/main.yml
+++ w/.github/workflows/main.yml
@@ -349,16 +349,16 @@ jobs:
         vector:
           - jobname: osx-clang
             cc: clang
-            pool: macos-14
+            pool: macos-15
           - jobname: osx-reftable
             cc: clang
-            pool: macos-14
+            pool: macos-15
           - jobname: osx-gcc
             cc: gcc-13
-            pool: macos-14
+            pool: macos-15
           - jobname: osx-meson
             cc: clang
-            pool: macos-14
+            pool: macos-15
     env:
       CC: ${{matrix.vector.cc}}
       CC_PACKAGE: ${{matrix.vector.cc_package}}
