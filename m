Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C478C98
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986071; cv=none; b=LU4yHiNh8cRS7kgM7wfGx7fLO2UO+GYFRSoxETQre1T7+1lHtMPbJgUZhn1Yt7DrP6GeY4Ba17UJ449JuY6OayNnXGD5RM+CrSebCSI2lZk8UkMucaaOItJbAYOXfSYdeUoSlJu7uC0r1T7GJvpXrZTPCnw9PWElTwEUXyPee54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986071; c=relaxed/simple;
	bh=P2VMmYb2N92ifJDg/3RWAO/iSxL/5b85Gf+Xg4ygcdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QQsWVluQLYy1n8evq+z2x+lLdt5G04LYF/m5S+XjIj6S0c1zbnYgguet056kvL71nUnQCMXwN1+RZwnnODkWP+Qykm7uPh5U8Y7/KGiy0rqAOCao/12GhzldWFwamvcKD5UFKSh8Sn7TM+0LGt2COQWERcWuuDctTT3Q8WB+eZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2BMALEwT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2BMALEwT"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de549a4ea65so427950276.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986069; x=1714590869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7MAdAleVDcOuxioqIMH/DlQEsXKWAG/gLCFJ1yj6s0=;
        b=2BMALEwTizvi5UejCunateaQrap56zj8TsskoQJJGl2DRapFQBEmePov9Bbrm1jvce
         FMBkgcqDytLK2h12CVjSg6HwhLDWTfrhcef5TZCmiMaSll2h/vYp7n7t2kSu8M1BXwUy
         7O0Bj6EpAVwxR5LjnyuAowlnL1gm7Fwqfkj54odbhT1H3/b3TNvr9uvXCsnAoc7Hq5Ar
         PoCAE8TwuUYMcCx0BalaT1HofXfsHHom15wQX/UsmZfiA7B8RX1yUyqbX2v5cB+zT6v5
         D+i9ccIeLjyhsS9PwvBPVm/ZPenpadIQrDeX4ihm318qqb3O/svCYF1ZgkXcE3hV94/Z
         yY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986069; x=1714590869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7MAdAleVDcOuxioqIMH/DlQEsXKWAG/gLCFJ1yj6s0=;
        b=p2j+/P8JQwGgBNjCPvwW7P7nYAuTs4Qv0YY7PgCr/pcIsyNRvjYBgogLX1wmpsyPGu
         5O0kUEzYz9sOE4dj7NE3LsEIyvyY/NLNcadYgG/zdlBd7EFGOj7wSgrr0d1rZa4NgJSN
         8XHM+hFcxGfDmR8l2oH1RRyieqECBdtzql6Nkf0GODXHrJoiQRi2Ys3QrEdG0ZnYROsP
         7TnGrj2b7zatwLKogyTDFUdFieB8uiZg5xinNjRIA/HZ3p71Tq4I0pCdoMp7/LEnbDiF
         kzhLRynSUu4htpDhcOKPTkVhIzrZ6rakPTs2JfcbICzaNM2ndCCI+xc/s3wgEKJ431BD
         Ybdg==
X-Gm-Message-State: AOJu0Yy3BXBYE3U0eEKqxKOQFXWcONh69KI5GqNoWYTBTy2983U9/JZH
	vHpVhlB0K/J5LxYMez64S7IWNaA4Wb0aRXcDMDUq6/z8yv6ibuoGC+3iteKA7Ns6c8RniODgtvD
	qNNCO/nzaxm/Pid7UXifu2biPnNHglJKYLh7u+8KuHJhFGNgI6q8QRrVBcXH8LD2pzZC2KBhtrQ
	pdIQJrfa1YjNh3vrfC7W0ivMvO9ZZ6ZXCYple5CqE=
X-Google-Smtp-Source: AGHT+IFChwla5Gn/DRLonfN9Qdi2oBjbQ1qleutAJk9D5dTvEP4QGJaJBSZjzcIUjEIH8GbJqLque/Yz28s3Vg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a05:6902:260f:b0:de5:4ed6:d3f3 with SMTP
 id dw15-20020a056902260f00b00de54ed6d3f3mr1075444ybb.6.1713986068688; Wed, 24
 Apr 2024 12:14:28 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:13 -0700
In-Reply-To: <cover.1713985716.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com> <cover.1713985716.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <c562515293d883296b1732fa1691369ac03e3213.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 7/7] ci: use test-tool as unit test runner on Windows
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

Although the previous commit changed t/Makefile to run unit tests
alongside shell tests, the Windows CI still needs a separate unit-tests
step due to how the test sharding works.

We want to avoid using `prove` as a test running on Windows due to
performance issues [1], so use the new test-tool runner instead.

[1] https://lore.kernel.org/git/850ea42c-f103-68d5-896b-9120e2628686@gmx.de/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 ci/run-test-slice.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
index ae8094382f..e167e646f7 100755
--- a/ci/run-test-slice.sh
+++ b/ci/run-test-slice.sh
@@ -17,7 +17,7 @@ handle_failed_tests
 
 # We only have one unit test at the moment, so run it in the first slice
 if [ "$1" == "0" ] ; then
-	group "Run unit tests" make --quiet -C t unit-tests-prove
+	group "Run unit tests" make --quiet -C t unit-tests-test-tool
 fi
 
 check_unignored_build_artifacts
-- 
2.44.0.769.g3c40516874-goog

