Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41021E5B73
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680535; cv=none; b=igN0UtOZ0XVdwubJdITSkjtaBAyGR4JrMioQmLcrtFilrw9j/kginSjF0D4iLZ8XWXXu1i4eF9oeIRNKixnf0G131wVgkL/+C/niE2MVEATM/b7CaXJB4+3fHn1OAIpXjGx7QhnDPrIvhWfuGmfa3WAr9jSubGe/VHkuUvB336o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680535; c=relaxed/simple;
	bh=LJq4xrt3i1/puI8uLZvpNTX8AETofx4MzERuBfAubjI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e4AlYqItCUoAzMkdNZVQtgCvjoI3LHHXltSPMXaTrFD2r2XclnfWOouGvPDyLUPBsE5UVlqKVe4f8kRcfrl3Ogam5e8GYiFoFBuVt/aDTdl5UeDDS5XWBD3qYwDr37CWZuH2Huluxu/nxJOZRG+jcyXtEJ0ps7RlrS3Io2cc2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1F4qx0x; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1F4qx0x"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7825e2775so2239077f8f.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680532; x=1755285332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygud6yv8UuqbvrG4wOGDfrQoBxFV5+FZP10zXE3afRA=;
        b=j1F4qx0xvi8NGObpks521wWf/AuQvObkekidpS3u0G/NIIoEEne6i2yF9Y8cXWRVWV
         CqMZkNTVEDVhSYvkxiG7793HjAT8+0gH/rOynsq536K8jwj0Qx0raTvvZoJMLqQKaG6e
         FFS82Z7cdIWXXMM347aSBCdw5mVSSEEvvIxnux2NNbOtcZOGkqirY2AAu84EQRU7KGVO
         RDEMQrvUYDzihMf3Y4SdAtc/CvC+LJpB5pvME54y2GEvIkFwsdGgFPQbqQE3zVsY9kEz
         CzPvX/vsT4HnHLKvc5JOr7Z5QCUcbirXrBfslPfIwu0pbgj44SxUypWuEPa/13UuAQAn
         K1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680532; x=1755285332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygud6yv8UuqbvrG4wOGDfrQoBxFV5+FZP10zXE3afRA=;
        b=vvZCbpUII4oviuKQeogtwab8rMtPIQbK4ABqu5UBZZcUmgl0u6dAWKRyYiWVklENhA
         WFM6ciMx7jpW2VnZZTAE8R3BwCS4Xdc8OkCBPu/AhYtwLyYYuK1NhEeRzOEHPYcRGEl2
         Auv7OALlP2bizdwTY8Xh21q1GeW4g8U+XWsdrJLaoVZeR/BwBpAmKxtNo+lX/W2lNDti
         vevvQ/ajAr4D+URYm54FdQk+dGf6nSiYVsmKph1ia5lfdnP5xcnZBxlwevGjg+B7s7Wg
         dpI7h/pmWTKBjjFLlyuo+N/JGeocrhKgkKmJFcw/V+wN9U2vfHffVfTgoMvKhuuor/mn
         qH/A==
X-Gm-Message-State: AOJu0YxSZ1YNQzmMeTs0Penj3rt/H/d6ofloC3IgS37lpvhcvPs2XqI1
	h4P1fFlezmO56S+o2oqV0brsUi90D3BMO6uIwXuKpqzsqRwOEztm6+vOEamMUQ==
X-Gm-Gg: ASbGncuaLHQyYByU/N+jRD+U62dvJoIlapjdE8j4oI88m2Ri/MxH34VQ73C14YhAg1G
	meaIaDBoNITl9KLAtBoVJOis1fZeTm51WDQy+UFhjGE5PXF0N4E428Hml1mUPUP31rhenkNZcrB
	1q1DLrmJDLIJ4IfIChnLr7Wa4UumWQiReV1/qCowe3LytkfN1r4Aof08rAMLm4dy7dVbql4UNBb
	1GQH7lCGwVodXlYzNnu8eRt3aaZDGdvq1oK0FqnetmJuCCVa3IZ4/dKwPplTXfPtOyUM0Z2cp2+
	gJ8Xm4ewiLXcA4sCTaKdI2squo+YIc95Y8bl2lVGieTsBnSFMUXaJlT/uFXm1ZhBXsTQZDPpN1E
	z7/TVaTKiHd8TajYSNl1wnG4=
X-Google-Smtp-Source: AGHT+IFVtnsnp8rJNkKYk/ziVy0S4WET8V1x9bQ2P051zbtB/BgBK0aoY/ctTkP6s/ao57cf5UNYHg==
X-Received: by 2002:a05:6000:220f:b0:3b7:9564:29c3 with SMTP id ffacd0b85a97d-3b900b78926mr3705542f8f.49.1754680531701;
        Fri, 08 Aug 2025 12:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm31586806f8f.44.2025.08.08.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:15:31 -0700 (PDT)
Message-Id: <ad97cd9e6718be2540657c2c820f29b9efafa883.1754680525.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 19:15:25 +0000
Subject: [PATCH v2 5/5] doc: git-rebase: update discussion of internals
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- make it clearer that we're talking about three steps of a process
- delete a duplicate explanation of how git rebase skips commits with
  the same textual changes (it's explained in more detail a few lines
  further down)
- move the `ORIG_HEAD` note down so that it doesn't interrupt the
  discussion of the mechanics.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6a4b3dbd5960..5a49e4f2de9a 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -65,18 +65,23 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
+Here is a more detailed description of what `git rebase <upstream>` does:
+
+First, all changes made by commits in the current branch but that are not
 in `<upstream>` are saved to a temporary area.  This is the same set
 of commits that would be shown by `git log <upstream>..HEAD`; or by
 `git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
 description on `--fork-point` below); or by `git log HEAD`, if the
 `--root` option is specified.
 
-The current branch is reset to `<upstream>` or `<newbase>` if the
+Then the current branch is reset to `<upstream>` or `<newbase>` if the
 `--onto` option was supplied.  This has the exact same effect as
 `git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
 to point at the tip of the branch before the reset.
 
+Then the commits that were previously saved into the temporary area are
+reapplied to the current branch, one by one, in order.
+
 [NOTE]
 `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
 at the end of the rebase if other commands that write that pseudo-ref
@@ -84,12 +89,6 @@ at the end of the rebase if other commands that write that pseudo-ref
 however, is accessible using the reflog of the current branch
 (i.e. `@{1}`, see linkgit:gitrevisions[7]).
 
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped and warnings will be issued (if the 'merge' backend is
-- 
gitgitgadget
