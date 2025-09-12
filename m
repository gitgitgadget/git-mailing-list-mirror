Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D931691E
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703315; cv=none; b=EsB9VcbJd8xajzeEO03e+ZibdRnZUR/TgHHXz20enJWl2Z6s9+v2mYZNlKKsLX3Ljt7TunKfrm5VLjtB8KC69QNDzSOeeN5iL2akozXhy2NXtLMsLrnTritGp2j5zLgXpM+AwLB6VUaJ1ZXdeMk7SpU042GZkBxxBkQRzNrORKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703315; c=relaxed/simple;
	bh=H+Nl8q8NfRPXESPkH3juBtRdq7OJzfpd7qKarS28Ofo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LG+Bo+9nrKMZZLTtHOZojDEMILMIDYvHMyUzLmyPNvojphFrkGtEAIr7Dk8xpzjYW66BNUIe9Lb1UM6+sKZNrv2pkZczidBcXgyl08AE+I+KWR+OoAuIsuyMCXWinjgkBiPDCBW2ZK+5kbX1U1hCp7rpgN77CSoP2K4Nyx8JQ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/EHHxf9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/EHHxf9"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4103fb72537so23877525ab.0
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703312; x=1758308112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucRmRBc1WBCWMUWHuoNT36bsuSx4SHVYYTTe0qLfMV8=;
        b=a/EHHxf9SF66i2C6zxXmkcAjAlQqZTlK/fv10xAmCTSNGXhiXq9rInETmVlHf72BKn
         HLNXlyPfQveUz2Ut8qVIHdzzY3ZlYcJAO5cIyTeBfp3GpYmGYMH3lzZHuwiSUYhQOelw
         /PJqL99WmRt+y7Ch2TdhJ2iKVnVPnHlL9o01eotmee+/OvQ/zbdxvYQ3IRF1xS8RLG48
         +3i52/t5smz9AAtOvorRZgmYcM1s91TyDML83sQVpRsY/0QwGMFZOjuuBVXILpjyCkrd
         8pUhVxuG5uKUY7OEqkuHT9X2kRBa5Ucxfc5gXt9759NRno46ymmgPyBSsBGyIoBslFVU
         Vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703312; x=1758308112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucRmRBc1WBCWMUWHuoNT36bsuSx4SHVYYTTe0qLfMV8=;
        b=O5pxKn3GNxUaOu4m1LPpGBurOGpaYxNm2jVSPg90/Wz8wS/UPMBHY4ZNG65YaPunn9
         hwGK7daXX9X6qjEf4xoHUsCkRSMY6YDK4cY/o/mmTfED7OU7WPP5KS1y+X9NF18/LgBg
         ypZHUmmANRR4InqgRK4mtsjrLyWg0HB4IeXKhHg1YaGpJaDhkwxM8niPZQunG2MbZbvG
         w3XhKwbFFv/FHux9xBDqHIEcKzBqnYswoy13hYxG0UneyGNhz+ODxpBSlqvMtUDirGTy
         dq9grg1D6nQOm3gs4mYPXGQbRVELzjYlnW996fN9EEown7pjeWFHFoZAUKTuYzRk+s1z
         iYIg==
X-Gm-Message-State: AOJu0Ywi7PvmW59m2OfL5stllXU3J6/t6AAZPBtak/VytU9grwyQuAhw
	fHHMU148tZvJ+ypD53bfICkjoIkytiobCZ+iGNYqmhEZoh/y7uwtCpNHJQHz1A==
X-Gm-Gg: ASbGncsDv48n/3cpW96JFw8oiAR5zmAsHWz8UtlUk7kTbBZHO8Id41h7byf6c2XBYNV
	3CPI+JQEbmMGW3lfnk9i8AYlZu7hw+5AYBnT/9lgFkSm6te2XHXPEso/SK+A2s98TDwWIVHFB5h
	mRqhO1zPwdFzDl6mrZWCMNbSWGcY6FvTqz7VFCiKks4vaz0JMJyY2I79LJi92BILOP2gGi7Yajp
	7l+9NYEzWcP/Cip2EOrzHR6esd0jBpTwjP9ekWVL72jETQdK9ppcSOA7g2BVAXYQ7joCFnWTJXh
	KnM1c2CUQlEmyvfvdbyhFLPnoD7bnQuwJW8UUnLMa7TErNos4cz+kSoXH/aSJwn6Zd52Go7Cxm3
	T/fAfKCFh10BivMg1slPiBNgRlnbr23dK448Ieg==
X-Google-Smtp-Source: AGHT+IGFsqNCICkUm3zLTXTMUXswU2RQaVu6jwn/Sfc/qV/7gKq2XQJLlcbzVBflimOhSTzbqRjuow==
X-Received: by 2002:a05:6e02:1c0b:b0:3f6:56a4:1e13 with SMTP id e9e14a558f8ab-4209d5f8519mr51061105ab.1.1757703312555;
        Fri, 12 Sep 2025 11:55:12 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.157.180])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41dfa2e7e95sm23055805ab.38.2025.09.12.11.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 11:55:11 -0700 (PDT)
Message-Id: <270edd2b00e63ef396ae69a9a7e9113a54f0df82.1757703309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 18:55:06 +0000
Subject: [PATCH v2 1/4] doc: git-push: clarify intro
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback, 5 users are unsure what "ref" and/or "objects" means
in this context. 3 users said they don't know what "complete the refs"
means.

Many users also commented that receive hooks do not seem like the most
important thing to know about `git push`, and that this information
should not be the second sentence in the man page.

Use more familiar language to make it more accessible to users who do
not know what a "ref" is and move the "hooks" comment to the end.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d6..e73b64f61f 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -19,12 +19,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Updates remote refs using local refs, while sending objects
-necessary to complete the given refs.
-
-You can make interesting things happen to a repository
-every time you push into it, by setting up 'hooks' there.  See
-documentation for linkgit:git-receive-pack[1].
+Updates one or more branches, tags, or other references in a remote
+repository from your local repository.
 
 When the command line does not specify where to push with the
 `<repository>` argument, `branch.*.remote` configuration for the
@@ -44,6 +40,9 @@ corresponding upstream branch, but as a safety measure, the push is
 aborted if the upstream branch does not have the same name as the
 local one.
 
+You can make interesting things happen to a repository
+every time you push into it, by setting up 'hooks' there.  See
+documentation for linkgit:git-receive-pack[1].
 
 OPTIONS[[OPTIONS]]
 ------------------
-- 
gitgitgadget

