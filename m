Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EE43B3E2
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162118; cv=none; b=O1nMjVgVWk2gGQAX2kAtstO+BY8OjmMaZq2Qq+5+w9pUuNjbrje+nOnRv0NeG57ltKhEQp5Crh10rSv5w2ialvEBKJSP50RCm91xqtYA/eb67Qvg9f0TelsE8NkB5B7rro8kgwg1zRTXiUDevBE/OqZO63cBB1bxhaHnWCQqrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162118; c=relaxed/simple;
	bh=K9Nc0B9YsRpio3Hw5aEmSPjQg/kSmmGbOKRT6NiJ0Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HVHE8p2MP+eSHfvdEVjx+e9m0VnlPqwlf9VlYXyyRGXXS5ZYN82s8AsDFZ0mqiBCyKufF4ed6RBFWMFLfdh6msxqAlrrmGQJhc/jTR9YlDetz8FHNb5gtOs2Nr1FRWa5iWOD895sUrRbCrOe/FTCFZumCLtOcw2+hoRw1TuZM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NvuUQcP/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ipGhg7Vs; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NvuUQcP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ipGhg7Vs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 92B951D0010D
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 10:48:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 16 Oct 2026 10:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1792162113; x=1792248513; bh=3seY+uS8uj
	wp/W8NjtLEszupkhGZ7a0JBqrmO/29nAI=; b=NvuUQcP/xmhwdiRRMr+ardnTl1
	UWa/wnnTlRWOW7a2nUC16YftCgRXoQboQs8bHMLVeQHwbhwjV7npUWZ0mqpcvEio
	R/nCNDdORvLlx4qPhod5yvfwJLI82bqeZ3OXqVDXb9GLa6BIgFvXvJRJXSQ94snI
	R1ydp8gVE+jGNCsfBlgIYO+mQ7qvmrvIq39Tm4wylND842fG6EDPluiAHwSH7+io
	up/VEEaN6iJV5hfniIBtjYO2NdDIALP+wTJRDdsFyR1pNjRZ/bxjG31O6sdXdIkj
	g6SbqrCgsb4dvTzijGUjo16Ll/adL6iu/WDc5u+aD+oC0Ygl8DXkqUlxwEvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792162113; x=1792248513; bh=3seY+uS8ujwp/W8NjtLEszupkhGZ
	7a0JBqrmO/29nAI=; b=ipGhg7VspivhwUOMFO2IOhaeaaDthgGBP267UJCxtHxh
	eUz0loVUz6Mmwkl0CiyPyxt8JOEpezMje4ADEsGtzVbtDo2bAjSoOgLDmKpdt/bP
	tnpWxL9IUgd++OC+DptlWFHmLAJ8XEcTfcgYDUuGepk0UOp1UB4eF0mhqz/W8L4J
	wYxJRfD11YXSqySGfETQGGxbuDT/D3nqDG3v3D2WmWJXb95ZxzfdK4o/qXhRpzmG
	BJTispd1cU31/RnuH6/3SCcKA5tl6Gm2L52F8LlEeyXEFsfP2UsNLjexUvp+ojix
	JhHyCxteQ7LhsOOm1b1jIAhCxkH9xswebPxC0TlRBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792162113; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HUBiCfjt2io4wKwix2KTRQwCk4kNnXbJNDlRFqRO2/J+3Dk
	ceSjVoBH3VOBc68KWWWIPRKCZVFR1wXP6z0ga1UO16uK4Pq3VFe2D3FFHt2tPthP
	EjKo7pC7AFPtV5sB5m7N7uwU/QhCzNZVWf+fbtjislq9HJMP2nPh/ftqhKIweTe6
	QQZDuetN2jsU+fyeiVGh230vfNkI0F+P71NjGzLeZ5ivKWtsdGlFsAZZB/sGA1RO
	O2OgQn+EFsjKefnKL4VJgmSsSG39RJpk2Q94DWgBqL5oCdEKnZeB82EyKBrN7SWp
	W9KTY1jNco4oXbAdKEJRB0hJDBVhZBFWcHe0tUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:N50Lz7hiWbSmSOlHOFaSSrI5UYZwgVHu+aDBQwA3WQI=:K9Nc0B9YsRpio3Hw5aEmSPjQg/kSmmGbOKRT6NiJ0Dk=;
X-ME-Sender: <xms:QTnSajoTzzzBdnBx-yetJt37L_gfPU6vJ82OZ36c8whle39esfE0Eg>
    <xme:QTnSajrrfM0NpSOPgoZciNlW4wWK5tfNLtc4wMiiZSOQeJ0mB2p6YFzI7qiC9wRmu
    0nTv0Z34pJzxBLiJUEXocniZ0a48t9djAdz9buOiZpQzAe-dij5KA>
X-ME-Received: <xmr:QTnSat05RxMJQkg6HhOzG6xPdI2rj3mAEXqc9TLvnpeatvGBqO2CFA>
X-ME-Proxy-Cause: dmFkZTGe5O/2l0iCt6HRF0n+1RWj/2apd+0/kwtjCl5J5BrNsjMZi+I7sESHCfHy7evrff
    DSjTt0z6W1g/eFbOLTR3zsV8+/dceDq2fhFdVOhH7zEGnO3LptBvybSfv7BnG52Aau+AWq
    vHhL021inZcUG0cA3G9kJTDb3UjQduwP6Yku9B2w2qG3wKrFpNaustwJyXX4XVJag0BNcr
    zdDJtm1vJFPiavt6aiIrYRegtXYXz/hl3T1aj16oDogbxI9cUna9qAnfwUR05bm6cVEybr
    AdCVizi0QiyY/lN/TwTtcICLLJRgjFSegRRzQ4GOlfWIU0dDtED5au6HnriJCuBir0XBTq
    0toh2jK0pHx3ic/ufMKwU6sDCPrjO3Z4YXZX1j21eCXkFDz5Uc2yxb+qjz//HzDI/3z4UK
    hI7iI1lIjY4vpjvD3qgIN0DMBJHJ9noq56kuxMEeSDZFQrzn86Z+s5bKmgcPUnD0EmORQ8
    f3BQWnnG9n52KjjmMfZPRACe3DN0QraB9dpnEm8uQCkJO5bJoTGnnhpCgrzOrHAO2lYc7/
    oVsnHaXFvVV5GOF9FOaMiHwQWzmnN3enyQJ60q1AxUtx30AD6aY8fgPeKZhi3DAD87FXb7
    3eaYn1kb7r9HsfTfBRISBH16atD6nOQbs0UO+pgrNByEHnB7sdB4clFyeF9A
X-ME-Proxy: <xmx:QTnSaiB65lggRitHSCt9l3dxXfFqtvLZnKExQrlNocv3UiqHdNDHgg>
    <xmx:QTnSalc9ISvXFPgUExWZxe8au7L1CjBf0MjhSbLD50sWOkGYrdplag>
    <xmx:QTnSangzD9ZU1YuBBnipEhPgtpzFGOLyOaH1Jbcp1c_oAIMKQszV9g>
    <xmx:QTnSatps6ypaYzipqC8Qf7zWUz4B46zUEbBXZWouIlc_6keRIjX9pw>
    <xmx:QTnSatYxQ_pNKlhJdckvh9vD4l4TsQTuzJLTKTiv8OjxW_SW7Yj1dEs1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 10:48:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31812762 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Oct 2026 14:48:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 16 Oct 2026 16:48:20 +0200
Subject: [PATCH] gitlab-ci: fix "check" jobs with large merge requests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-pks-ci-optional-whitespace-job-v1-1-f5693fbae1a5@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNSwrCQBCE4auEXtuQiRDBq4iLpK02HSUzTI8PC
 Lm7oy4/KP5ayZENTsdmpYynucWlIuwakmlYrmC7VFPXdn1oQ8/p5izGMZW6HO78mqzA0yDgOY6
 sGqAqe4UcqEZShtr7d3A6/+2PcYaUb5W27QOLNB4cggAAAA==
X-Change-ID: 20261016-pks-ci-optional-whitespace-job-ff1effc3fec7
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The "check-whitespace" and "check-style" jobs verify that the changes
proposed by a merge request don't introduce whitespace errors or style
violations. To do so, both of them compare against the base commit of
the merge request.

But both GitHub and GitLab use shallow clones to set up the repository
in CI jobs by default. So if the base commit to compare against is
beyond the shallow boundary then these checks will fail. To avoid that
error we thus configure GitHub CI to disable shallow clones via
`fetch-depth: 0`. But we don't do the equivalent for GitLab, so we see
such errors whenever we have a merge request with more than 50 commits,
which is the configured shallowness for gitlab-org/git.

Fix these issues by setting GIT_DEPTH to 0 for both jobs so that we
always fetch the full history.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

one more day, one more CI annoyance. The "check-whitespace" job is
somewhat broken for us in case we have MRs that have more than 50
commits. And while that's not something that happens for patch series
that we send upstream, it does happen for some of our internal
development branches.

See [1] for a pipeline run with these changes.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/703
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3f24835500..62737279d2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -256,6 +256,8 @@ check-whitespace:
   image: ubuntu:latest
   stage: analyze
   needs: [ ]
+  variables:
+    GIT_DEPTH: 0
   before_script:
     - ./ci/install-dependencies.sh
   # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
@@ -276,6 +278,7 @@ check-style:
   variables:
     CC: clang
     jobname: ClangFormat
+    GIT_DEPTH: 0
   before_script:
     - ./ci/install-dependencies.sh
   # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged

---
base-commit: f57c9a73884400380bddd172acc88b569834f909
change-id: 20261016-pks-ci-optional-whitespace-job-ff1effc3fec7

