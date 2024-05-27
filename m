Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83D510E4
	for <git@vger.kernel.org>; Mon, 27 May 2024 00:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716769941; cv=none; b=RhaUgn8xoFc23RZsEq6VVrVHKmWrKH9x8siN+1mHtHnywXVcyWXFqWWDNC1Wj8UwGTrSJBqV20T3vaPZ69FpmrpReGD3yuMFKo5W27wz8rcbPN8JcHdf1nco7LH1fSkQ/ri8dete6DbCb20/i1dFBXJnQdjEq6tw6BiiCQPNW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716769941; c=relaxed/simple;
	bh=pDXRgrua6JJbUBTIL6Wugzrh2VWQLKVAmv7dGOEQyno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFJt7YjjON8rueYyX/TRRSL0xpN1u7dT8pNmsH00WUT51REldyPA8Uekawc0TvX7Sjp23tPB9tKBn2xLbzDrBSzGNLQTCh6uQ9Grt5H3iTUjTOqLwsQCdcK07K5a52CxUo3NZg2+RQLK17o+r2tGRc+0HjWzFHg64CZ4OVauM1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AC3ecsO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC3ecsO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716769938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
	b=AC3ecsO0AKUl8dRAZ3TUPFeRLVbFWpcgeJzQhnsFs0VXSmXqk0KelOnQaQFKDrhCVZdiqP
	7LKyMXzO2qTRg1g/NoursC68UkrfGMQBVtAs7MmDY8ZwFQttCAGPl8LAuT50u9rrIORF7K
	kYDfHdtTkoepO5HlbJHng/FoMWVCxs0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-OyOcHa2qO-6dN13i77urFg-1; Sun, 26 May 2024 20:32:17 -0400
X-MC-Unique: OyOcHa2qO-6dN13i77urFg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-792fadf7b61so379191785a.2
        for <git@vger.kernel.org>; Sun, 26 May 2024 17:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716769937; x=1717374737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
        b=tc54dTuD8WzWur/g72xVKBZ0ejpgxrEvAH3mj1wBmwTab35UB6f6NktBNP8nyfKvZ+
         O577eZSJbgDxRNIG2HpPtSnxVlls37ijWH/rLrevUsh9ICU7FjAYVykyzmMksYQES9JA
         4H533alEj3CfDH6gvBkfHZTEcLldpTRfnVkO6N6i3lZAWhVuDr2E8hjZ+m/yKddsqYto
         z7DuQyaxKboP8Z/7w4Ty7src7IBHPmStZwTXtAG+y2OtJVa5p/iq+CytsJeGVRZ3mFR0
         FntjbZqNsBF/B6UG2DdBo428gbU7yucXkLIKgJ2e9yMOhWl5qevfaXJl9ls9pRH5ASeo
         O2sw==
X-Gm-Message-State: AOJu0YyrXhimQBvjISBYYSw8qKcaYR12HJ9kqW0BJRZOU5mMkvHNxHtl
	nJWIWSCG0e3qukowJ3byq5VXhqolW0WdrNX/10TBwuAGXSdzIaei5IXlT7QAiBjv0MgAkTGg7Yk
	/0y/4nM8w7Jccb295Q8eBkWKZM+FjwMqkti1iwcQk+XusafhnJJP8G50ZniZ692rHbhVhaa4rBd
	32B29f70H5nkI9jWd+fo+DmZFEmCstMwF5Uw==
X-Received: by 2002:a05:620a:2551:b0:790:7fe3:9fe1 with SMTP id af79cd13be357-794ab11083dmr970700485a.68.1716769936488;
        Sun, 26 May 2024 17:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMZ909n/cKAT+wuv8+iAaOh/Go8D8byx+RMa7kS93f0+W33IngHLoVtjk5s6s5q9FQgqroyg==
X-Received: by 2002:a05:620a:2551:b0:790:7fe3:9fe1 with SMTP id af79cd13be357-794ab11083dmr970699285a.68.1716769936034;
        Sun, 26 May 2024 17:32:16 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdca88sm257509685a.66.2024.05.26.17.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 17:32:15 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v7 1/3] Documentation: alias: rework notes into points
Date: Mon, 27 May 2024 10:30:47 +1000
Message-ID: <20240527003208.1565249-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525234454.1489598-1-iwienand@redhat.com>
References: <20240525234454.1489598-1-iwienand@redhat.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a number of caveats when using aliases.  Rather than
stuffing them all together in a paragraph, let's separate them out
into individual points to make it clearer what's going on.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 Documentation/config/alias.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 01df96fab3..40851ef429 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -21,8 +21,9 @@ If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
 `alias.new = !gitk --all --not ORIG_HEAD`, the invocation
 `git new` is equivalent to running the shell command
-`gitk --all --not ORIG_HEAD`.  Note that shell commands will be
-executed from the top-level directory of a repository, which may
-not necessarily be the current directory.
-`GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
-from the original current directory. See linkgit:git-rev-parse[1].
+`gitk --all --not ORIG_HEAD`.  Note:
++
+* Shell commands will be executed from the top-level directory of a
+  repository, which may not necessarily be the current directory.
+* `GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
+  from the original current directory. See linkgit:git-rev-parse[1].
-- 
2.45.1

