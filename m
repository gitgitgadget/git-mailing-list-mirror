Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D741429B
	for <git@vger.kernel.org>; Sun,  7 Jul 2024 18:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720378100; cv=none; b=To72Y7SA0nLsydyBl/jvzeaciAwYzAXirIwzIarG+DSdfCjySvPBkxsGDE/9J6FpWogbf7pDdHuqXSFtxJmxLGzriieuBEzKrZIwrFX8phASzyQ4mCxewJb4u+0gzULopauTYTeiSecDFRx6F4z7yVwNokpwv23V0HfhwIlxp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720378100; c=relaxed/simple;
	bh=vyUpFUCMDmRE9Yv/oxJkuoMk1YXvd3kM1mtZ9ZD2hzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tv539DRZ6UWJyUXpxg/UP7O9AyVQhP/6PISXcNjJ3m/iYISNIHG9ZO+ga+kRhKYIAJCCNJqp0zG4TWvOpZbkHgvVWMHLHce5tghMvcHENwD9HBN5qD2LNNCUaRv6qx/1gwQ5dU11kzHjkDrH49A7cFodAEoCeJa5GW7EGF9nvIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+7a+TaM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+7a+TaM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-356c4e926a3so1970191f8f.1
        for <git@vger.kernel.org>; Sun, 07 Jul 2024 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720378097; x=1720982897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L85iWjle6+r6fzASrXk2gQYH8NY9w+xdChjssxFgto8=;
        b=I+7a+TaMR0Ztf8knyjpmIXHdZTZObFVHUydV0+JsXK5KjA8Ojqx+Y35P/QFF8bmJ8K
         MJLDpRquAf2aZhWbmyI8kCC4+tgwF/G2hJf0pvxgF3wMBf0OeEwBzj7EwIwuHmz6F366
         Gz4j3uVOz0DDOmM50bZus+f10vIxEXW5hexhaRnJpbUVQMs8WKja8mBqjPJVYl3XvzRA
         fxas+c5Q1SzsyGwq19XGGmiRoZ9XYLTtJzwF9TSxXpngc65UYh4GcQaXzAy7pYtjR/sV
         cyp1rNhLNptZMSa6UkeRLMrAwKejMisg3Kya/56aCSMXLTVGxQV92kYiLGfsmRVKqv7O
         IjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720378097; x=1720982897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L85iWjle6+r6fzASrXk2gQYH8NY9w+xdChjssxFgto8=;
        b=CvLb7G876CuMoo+3jrpL+GxFkdzL3ZENf5hhxSAidlkQGhT0Cr79NUElWmz5ipvcUk
         G8qNYMYbVzAKw07wFw4N3Ow8NNBt8zF6WsiCamuGDqnhpF24g4ODbOtO7l7SGEZAGxLH
         /N4tBlcrVX6ORJ36DuZ3eZ4U5D6zuRbr+2bRrJ3p5lhOdVFW5NYa3ypR/7efeRPA57I+
         RMetdUSfo5KljweYLNqUWkhDyzkDjlnLksQ7iCObI/1e1SnRr17adtfBHRqETn5971qB
         l1Fw6JxtuxSthQOXo5TOXome6k+BdhaSx++tNfs6QigYrHbBvZbRYDGW/2mYpnmNRZW0
         5pyg==
X-Gm-Message-State: AOJu0Yw5na/Nt3k6OvuEOXditOivKn2TNKQaBRBD6difR1ugzXdBE1fW
	sRq9r8RDmcDDa6qJ7RYRNtstbVtino6/iKJJtNp3r6xk/egBJL0EndttPPm+
X-Google-Smtp-Source: AGHT+IECuVfUjy0Yls9OM4QSnNHA4TBuG5UG6QX8aiI5819AC+GeXja8EpZ7Q30teh/cjtH/xSC/4w==
X-Received: by 2002:adf:ce81:0:b0:366:ddc2:a14a with SMTP id ffacd0b85a97d-3679dd30f51mr6576027f8f.40.1720378097215;
        Sun, 07 Jul 2024 11:48:17 -0700 (PDT)
Received: from archlinux.. (237.red-83-61-184.dynamicip.rima-tde.net. [83.61.184.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36796a6053fsm10856654f8f.57.2024.07.07.11.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 11:48:16 -0700 (PDT)
From: =?UTF-8?q?Jes=C3=BAs=20Ariel=20Cabello=20Mateos?= <080ariel@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	=?UTF-8?q?Jes=C3=BAs=20Ariel=20Cabello=20Mateos?= <080ariel@gmail.com>
Subject: [PATCH v3] gitweb: rss/atom change published/updated date to committer date
Date: Sun,  7 Jul 2024 18:48:13 +0000
Message-ID: <20240707184813.33166-1-080ariel@gmail.com>
In-Reply-To: <20240704164547.94341-1-080ariel@gmail.com>
References: <20240704164547.94341-1-080ariel@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The author date is used for published/updated date in the rss/atom
feed stream. Change it to the committer date that betters reflect
the "published/updated" definition and makes rss/atom feeds more
linear. Gitlab/Github rss/atom feeds use the committer date.

Additionally, to be consistent, also use the committer date to 
determine the date of the last commit to send in the feed 
instead of the author date.

Signed-off-by: Jesús Ariel Cabello Mateos <080ariel@gmail.com>
---
Changes since v2:

- Fix line wrapping in patch
- Also use authored date for processing loop.
- Rewrite commit message for clarity.

Thank you, Junio!

 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ccd14e0e30..b09a8d0523 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8326,10 +8326,10 @@ sub git_feed {
 		my %co = %{$commitlist[$i]};
 		my $commit = $co{'id'};
 		# we read 150, we always show 30 and the ones more recent than 48 hours
-		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
+		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
+		my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
2.45.2

