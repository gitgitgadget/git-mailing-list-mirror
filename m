Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734362475C3
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399040; cv=none; b=P128jXqyQi9/DURxic69hNwP+BwxZyA4N0LQF5QOaNyUm43FrfBEMesHWLieXUO6eGRKVLyB8rADk5sj4hWAxQkq+xEBluRNkfTJGwVOtn4p22G2m7Ek54dv1+68Jru+MbSVuMAZWjZrGYY2c4+rDJp+bfznQOlX6W4366qf98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399040; c=relaxed/simple;
	bh=EFRlGS3XaUpBAhrlPc8yt1TrLKOkS7+PKGO6stDRsbo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=EYXbnUUFigeuTb6fUcAPkm3ffUoPdTjcp+BsDVvF/Kj5mKMQy9aNxlZz0Vws2lEPyJa8xWWP/cMULoTZXD3DpySWHiryyhivP1QQ/DhhxG9ddUJ3FnM8S5jc3Swf4NfSihLhXJtIQLZdoZH8lUhC4prYm3MpUE7gcbl0dSi7cNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NolLsxEo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NolLsxEo"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso3832865e9.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399036; x=1755003836; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTKPfqiztIA2fNz+ruzT9qUKZbuL519S/m9xQBwSB5Q=;
        b=NolLsxEoWBvK8A0fo00A6GDS28wtDarLoh1QRG3YpdC2H1b1zBTjJCt+m2KwEblyDW
         RyQyD0JWuzkuBzpKQykTL/xU0EpfszTLQovx/lRLwFheOPDdxb/5zHtSob/Lka66Nj9L
         aw/rdYM2rYOC77gLeFUDCfYryigWCy4nFRECxNVIjg+S4W5yWSlwTdxM9CLTA6TDuDIA
         BEW5lJPm+WfY+N5NgeZcERfWhn+Jsvny8u8OPhPSml6UrsJNRtIQQAd/JDca2mmyMWvY
         0b/TgUxIPQxcXsF07nJYMW/q4lWUB2wXvB0WOZr3jCwekBMic60LtXKF9fH08P/44QGV
         Hu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399036; x=1755003836;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTKPfqiztIA2fNz+ruzT9qUKZbuL519S/m9xQBwSB5Q=;
        b=WcwW1/gVl170IOFWAw4xUy9ObQqvPkAvxnx5KLz56U03Hj01G68oUgAPRqIzmLgr4M
         jtroL+BWkaqZDlCLEIeh7O2tgd1ZWVMncqgHTG442uPhJ5D3PjlR5TodV6Vweh9mDMVl
         11XQr7875IN9w1NZx4XpljbKFE+GYG0Q/rlxpqub9h5hXxkuJ1saW5P05zgzVj7A+jQr
         VwVF+ocYh5m4Is0FBH9soLwfBWF9oUT45YBJ4xrtD75zDdYQZm+zVJlCf3CSJOLdV6b9
         +eWmpndyPtz2DVZOUxCgf58HdLL+lFisTtfJ2aKS7nvqhdVGZjhibjl7IgyrKUig8e2X
         t9Ng==
X-Gm-Message-State: AOJu0Yy/+ZNeCrxJ6RmIrO84Nmy/bQ/AgZaqt75+luQ69Epa6FCLg/BH
	gYtnGJLTBuPN3BTw+lDj6dJtMX0xRE6OqZorcPX57osrOa5Dzq3KL8tXFLUzAg==
X-Gm-Gg: ASbGnctiyTY3i5Xy+Y3tM+q8/3FwcVQ5WN0pkBG4JtfXfdcVpC2M4Zs6MwOyy9AshOC
	Gsa6KqzXfQCSTIbcvBggfdqNpo+cX8CBNv1XcGdXDkT29rFhyI8AGh1ths7QJrcqpSe4bTw/CEx
	le3fHNNLZBm211vgds0KBian1Bl2BNRrx6KYykaPSftuzzZksBUej5nzlL0sce/pAND5SWP3cB4
	NwNsSga7wYPY4wRWupQ7zu7IfXN/L+3dus8jLJMXbi8TkACNEffuWqXBv+Xp7S56tBNDz33jEot
	XkPjl0G4YAPgPi7qW0wQ9D5wVkGpx5jD5VECjyxx/xNvnA3ieJvXoR3qE6aOGDtwIrEtg8I8WDs
	PRnFI3/viZnXei3Wk0mwsUiQ=
X-Google-Smtp-Source: AGHT+IH86bXmYAEZYdliL1tEBA4ZIMKeK2IdUyC7R8qLhxAA8SsqB6x87LEb2tTYK5wIqDLJs88wFg==
X-Received: by 2002:a05:600c:a05:b0:458:b01c:8f with SMTP id 5b1f17b1804b1-458b69ddf8amr102152695e9.8.1754399036188;
        Tue, 05 Aug 2025 06:03:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e587e471sm3637995e9.26.2025.08.05.06.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:03:55 -0700 (PDT)
Message-Id: <e79bd6a67ef2ea7247359b2449c7c313c7fa9922.1754399033.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
References: <pull.1945.git.1754399033.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 13:03:48 +0000
Subject: [PATCH 1/6] doc: test linkgit macros for well-formedness
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Some readers of man pages have reported that they found
malformed linkgit macros in the documentation (absence or bad
spelling).

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/gitweb.conf.adoc  | 2 +-
 Documentation/lint-gitlink.perl | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.adoc b/Documentation/gitweb.conf.adoc
index 1348e9b12504..64bebb811c97 100644
--- a/Documentation/gitweb.conf.adoc
+++ b/Documentation/gitweb.conf.adoc
@@ -178,7 +178,7 @@ $export_ok::
 	Show repository only if this file exists (in repository).  Only
 	effective if this variable evaluates to true.  Can be set when
 	building gitweb by setting `GITWEB_EXPORT_OK`.  This path is
-	relative to `GIT_DIR`.  git-daemon[1] uses 'git-daemon-export-ok',
+	relative to `GIT_DIR`.  linkgit:git-daemon[1] uses 'git-daemon-export-ok',
 	unless started with `--export-all`.  By default this variable is
 	not set, which means that this feature is turned off.
 
diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
index aea564dad7ed..f183a18df284 100755
--- a/Documentation/lint-gitlink.perl
+++ b/Documentation/lint-gitlink.perl
@@ -41,6 +41,13 @@ die "BUG: No list of valid linkgit:* files given" unless @ARGV;
 @ARGV = $to_check;
 while (<>) {
 	my $line = $_;
+	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
+	    my $pos = pos $line;
+	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
+		if ( $macro ne "linkgit:" && $macro !~ "ifn?def::" && $macro ne "endif::" ) {
+			report($pos, $line, $target, "linkgit: macro expected");
+		}
+	}
 	while ($line =~ m/linkgit:((.*?)\[(\d)\])/g) {
 		my $pos = pos $line;
 		my ($target, $page, $section) = ($1, $2, $3);
-- 
gitgitgadget

