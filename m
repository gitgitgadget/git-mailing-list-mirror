Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BB1A5B90
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239876; cv=none; b=V+FeqW/VYMMORWKAdC7ubcPV2kRggLcQlSYsK5QmpuxfYbspvyeD6XfSWBoJ6UvjpglA7DfsNuZirmDZNwervthAt+Y0AbqsFKE5C48GJewL4pxlJ6SXX12Eg2QsPOq7wvnkxOV+r8DeJob+Xy44iONVDwIPdxCMcFH4WiLqmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239876; c=relaxed/simple;
	bh=ltNwEkP96hntp4BmX5DhUF1HBqDyZedQSSZYN3QXOTg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PfKpbLY69vzbVIqlk7QEsGTGYwBCVzqBSEG4itXAXuEKwWbQXcL8uPYSWmddvn4EMzn0LUlMJMCWVyMs6egDqVc6rPNvvRvTTQqIH4jTAoB1OCRN8tn/vepvF8hOxbdgWwQ/v0QTMRU+xqR3Bp7/4bTU0tZDJUIa6/WFSR9bljM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5bLe/aW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5bLe/aW"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e533aacf2so86393485a.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239874; x=1783844674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4Z1Zp9WEjEC9aDt6y5GGkYqroZgDIFfBL+aI8SAQlcY=;
        b=j5bLe/aWJutELmiyBYNlQc0posB5exrB1TeilynzDzHUBmTCBQ1UbHbG9x4w1a9dsJ
         9MSLJsAEvP6XwNl7rATc5D3mYQmXqr8lxIz8htd9ukLyrj11wyRlMbbdFapQ98PQCjwv
         brr0DAUM29kOXYqo6X1wbt7+EBlNGmc0JzQjFTW4qKC3x+iF7zEpKT5JDseD1xh067bf
         P8foIuKJlnCqcrL6JiB+YFYFqrnwxH8CbmO2oq8Jz6At/NS7BDnm6WI1u5tEKD1foOXo
         X05TR/YMyo28ABXYob6Q/fSQgaXwqp5kubxp2/CwttU+CZBwPRyiI1U/bwH3kysJionJ
         R0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239874; x=1783844674;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Z1Zp9WEjEC9aDt6y5GGkYqroZgDIFfBL+aI8SAQlcY=;
        b=qbpuzZrckAeuFjo5ZHsaGBQ/5jzMpKo0FxpR51Z6b6bO9UE86NwNC6IzcxvAGRYHBd
         ktkf8Wk9PypoF8Ya2d0Z7U7DjZnzkacNEm1aDPKBFjOHPvbLw1BLjc/TKqEmR+E7lTYm
         i28ssyYMSjpsicnVgZb+hmIC7ZXTXGLnTWIr/mImBIBPpHB19NgLnWmOtRG+4XwhmdgV
         LVFBPDYBy7R10K1rYs9lUEI59cI6pZV2qagv1Zhuqe9g8+ji0xM78dL5AJaA2EXJppBA
         5IYE0yTkERNklXJU3TeJx0htokH8xe/a7/kkfZkswjwm2zpnHYji/OFGAQ9SEUCCt0ZD
         w+/g==
X-Gm-Message-State: AOJu0Yw7+kcd25nPLiOTJcB5apIuKg11aI+7OrLI+kT/rGaaa1Kx2r6I
	Ob1PSBx3b4iytQ2WKeQbFw/vyzzXfe3SOj7qDJGBZJS2B2ia5tZ3FELBkt+UNA==
X-Gm-Gg: AfdE7cmY535ITdQyAM7whC2rnnlcr9+KTOZVfhup7sQB1LoNJK0Z40iDs/5bAS8/EPI
	jrB5/vK69vQMUyWmqfXmaSM63BmPBo/L5MRT3zhMe08XzDz4S7Q/xk4kRTVympCVvEMTwWoZ0XH
	vQW3laosDlkrwHWsnyiOPgjwOYXFy2/g0Lux6otu/AkZb4I3O/THOsK9fh/4Tl7ArlzWdkENXWj
	VJlHTvDfa3Lwv7CYW+lmD0b7sAX5cnyq2lVl+EEwPNiDON5YW569R9Mfntg5cNE9yiyTQY4Ip5d
	5zUGWTUMrYv8boQHmbpUNMm/nF5Nw7+WNuXYcGIgryt6sc8HRYKQYUAollFCjiE6RYZtDetlSwr
	aTwysgMCYjCj7PGOwynUAaoBdisgb1AdQzrKLo4o5NhbowYpGO/UL/Y4+2rSgDcomhGA1g8v1c4
	WXAmxG2auDGSA1/3a35A==
X-Received: by 2002:a05:620a:1a0c:b0:92e:6018:a86f with SMTP id af79cd13be357-92e9a48fdd9mr837325885a.48.1783239873988;
        Sun, 05 Jul 2026 01:24:33 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b804ccsm626583085a.10.2026.07.05.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:33 -0700 (PDT)
Message-Id: <80ae35227d566977ad21eb6e35f49e1ca5d5a940.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:18 +0000
Subject: [PATCH v2 01/12] load_one_loose_object_map(): fix resource leak
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

Pointed out by Coverity.

While at it, reduce near-duplicate clean-up code at the end of the
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 loose.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/loose.c b/loose.c
index 0b626c1b85..940a9e0dfe 100644
--- a/loose.c
+++ b/loose.c
@@ -65,6 +65,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 {
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
+	int ret = -1;
 
 	if (!loose->map)
 		loose_object_map_init(&loose->map);
@@ -84,7 +85,6 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 		return 0;
 	}
 
-	errno = 0;
 	if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
 		goto err;
 	while (!strbuf_getline_lf(&buf, fp)) {
@@ -98,13 +98,12 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
 		insert_loose_map(loose, &oid, &compat_oid);
 	}
 
-	strbuf_release(&buf);
-	strbuf_release(&path);
-	return errno ? -1 : 0;
+	ret = ferror(fp) ? -1 : 0;
 err:
+	fclose(fp);
 	strbuf_release(&buf);
 	strbuf_release(&path);
-	return -1;
+	return ret;
 }
 
 int repo_read_loose_object_map(struct repository *repo)
-- 
gitgitgadget

