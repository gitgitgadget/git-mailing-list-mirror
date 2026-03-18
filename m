Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA1360753
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773857559; cv=none; b=k0dMAeBXosxweO6An1gM2+iI0r5IqgXSzPCnJMDg5L+3b5hz9oUgu27qa6D9hKus5GXFW/wWgzUZkX/Y+Aiw+PNRnTa5az0PDclcsPHx0ke9Mbq9jbHP6g2df5JoposaZBLUPq6NuEtYVrowJ7sm9GC5RJezQiRAktSVXqZ6+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773857559; c=relaxed/simple;
	bh=g5Nhc+3TRjhJ7Vzx3XNnlBp0zx/VfVn7FE3I8gzaR4E=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dVb9a1LfH4NUBW2iY6e4hUkh1RUmowuMEypGWJlpN+ABX1OfWbNITodK21NqjQQUvnwSppAiPhrfF2g36iaglZJbAyTaeKE4jBY4Vlo48S9vcoF/MHxTm4PsrIbBO5u9rqq18J+pdtn3iGW2v9GQqEqi675Q1hMblI6LzlHNUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpt6jcGN; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpt6jcGN"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0e38f3f60so642839eec.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773857557; x=1774462357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B8x+Sg+yRJou65dw/FaWHvXpueaAKvtaPi9YIcRl3qE=;
        b=Dpt6jcGNLkTZOkxq1L4JqoGTCz9rfxtDtraDefUsVe0VcIcDcRH3n+C65H7FcLXO/0
         Y/6MKAni9fGlzBhs4tPARoVgluM4tEHT+j11Mti0BAFnJQn40NX6FS4I5gwItUtmmR6F
         DOZt7KPgkKmLeYSQF+cEStP23yBnuKESKbreaGc8G3z/hRbTzwdDqxAA9rA9piBWyn+1
         ln35oOU4i9uhesmbyWVaIubBtcRfa0Fd0a7PfSdbt4sk17+OggSeb8z8XR6X9QQtHl2K
         E1cnTDaFrKZnznVjDw02dJt1DOTLjOCkMCaAJnfnmu5t2KjuqnrKFABKxngP7b6XAzYU
         Jvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773857557; x=1774462357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8x+Sg+yRJou65dw/FaWHvXpueaAKvtaPi9YIcRl3qE=;
        b=c41U7nX3D/vHaAp/6CbXqjuJam66IOAEzgeujZx465TibP8GsyrIXJLTXPNccau6XZ
         0Vczq7rmE68idX2QyJOOU67uw0Bx6V5AnrrA3n4zOkzUdKbg0q2gd9XkP6cY9uOIrI5y
         lK00B7SyXh7axViJw/RB1xFWaA1/d08Bqi/O1UiwqyuTlaHiHQuBLxvhtjXqCp07soZb
         dOWBukOlxzh/fAtgQVr3zMrE342BkJos+OeAeg9PfDzEL30jXCWzqALHdeqAhdHfD9b3
         YIiyKrUsqB/70e1DiDzvyE7GnGKKzFkCRHZ++ZCGPhJdKcVY9IN1eMIccKG+gjYn7bEL
         lsfw==
X-Gm-Message-State: AOJu0YweDRfiQPYynaZU/IFJq7cpg/Qh3Es5KtC+KiC6QZ0KocsJQ13C
	2gIvrlqrezOyAm8hGKX7WLsoK6Dle9el0Bs74AxS8sSk+ciEwVAfizr+T7tKlQ==
X-Gm-Gg: ATEYQzyQca8kWZvqACgd1rFSmpvmHaKgCynGcu1SuUZsZaojsKesTWhvmWAO6jFzPUr
	BT8VgGcgkVJcSGhUMrZ6IWOdC82AT6FU1GUxkHMPZ/9hUjug/Y+4Mmv5xzFe0EK7Ax4DBx3RB/Y
	k/gBuM7L85hhcbQAYvquRj1PowbLuZVl/lrsTvygA3V+07BCWYFGOblbPmrAGLUck1vGa3zUncs
	MjEBi1mQp2groPlharpQhmRQD8YQs2ndroaPEWs9Th0fdfoJ4ZPHOTGYJYkPieJVq6EAXq81GVV
	x/d3zipW2vr/obJia2fkaJEsMQ0AYDoL5Vqc/U+ovEF4xQXA5S4AaNxhF/AFGTrw3QeoeSYsJZA
	YlUBtYKWV3s/fCjuHP472X7EhrkPdNjoqE33fF0nAAX22lolGTfJf5C2wvJ8qE/G30lVGhcTBzj
	P70l/Xr00NDfP0KyOFqMCsP5nQ
X-Received: by 2002:a05:7300:3b28:b0:2be:617:1f3b with SMTP id 5a478bee46e88-2c0f3b6bf16mr288710eec.5.1773857556800;
        Wed, 18 Mar 2026 11:12:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.119.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ce5ddsm4634245eec.27.2026.03.18.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 11:12:36 -0700 (PDT)
Message-Id: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
From: "QUANTUM via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Mar 2026 18:12:35 +0000
Subject: [PATCH] t2107: modernize path existence check
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
Cc: QUANTUM <adityabnw07@gmail.com>,
    Aditya <adityabnw07@gmail.com>

From: Aditya <adityabnw07@gmail.com>

Replace '! test -f' with 'test_path_is_missing' for better
debugging information when the assertion fails.

Found using: git grep "test -[efd]" t/t????-*.sh

Signed-off-by: Aditya <adityabnw07@gmail.com>
---
    [GSoC] t2107: modernize path existence check

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2071%2FQuantumDev-CERN%2Fgsoc-microproject-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2071/QuantumDev-CERN/gsoc-microproject-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2071

 t/t2107-update-index-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index cc72ead79f..3bffe5da8a 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -86,7 +86,7 @@ test_expect_success '.lock files cleaned up' '
 	# the_index.cache_changed is zero, rollback_lock_file fails
 	git update-index --refresh --verbose >out &&
 	test_must_be_empty out &&
-	! test -f .git/index.lock
+	test_path_is_missing .git/index.lock
 	)
 '
 

base-commit: ca1db8a0f7dc0dbea892e99f5b37c5fe5861be71
-- 
gitgitgadget
