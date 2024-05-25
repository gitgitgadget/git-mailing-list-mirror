Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E05611B
	for <git@vger.kernel.org>; Sat, 25 May 2024 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716680711; cv=none; b=fVhGo9OjOIJIgnh93IEaf/qJMYeVu7XW58o9W5cPS9AhwTmKO0q+DVYVbdZgH4wDuoI3BdT1Ywyd26WgAzuwTfWypEXeVpk/B4B0kiBHTL1zlic6OKC+J6osOFClElGkzsYaZOJCSv5s0xEX65OFWC55pCxdPJnrTGcBpc4+8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716680711; c=relaxed/simple;
	bh=pDXRgrua6JJbUBTIL6Wugzrh2VWQLKVAmv7dGOEQyno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0whGrlFSbVU1IsfVmnkVfxvRUney79L9w836Yh9OpZbw4bAMhiIyV7rkcZolr51X4ZO5MTO6hWV2TiZA7a1z4gekiKCGYU5kQD0SIfmtqYf+8Klhvu8GznHHZFSsvY6NZkniz+zBDOob94MIs09+stDM5NQJO90pukzQJQSZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BEyxS6rT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEyxS6rT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716680707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
	b=BEyxS6rTVkMT208o/oZ8zwuQlcJ9EY2nPd4kmv/wHnOnOfRQBKDO0GGs4B9eTc0M/Gk5IV
	C3nl4qBEwlAlkasOeQpR2z6Gk5w2jcQ0yWXcGP83PnZ5reQxK9mdn//+FRFaXEHeFgzhe5
	356qk2OdSq4CktbSwE9HUWWQyCYeHgo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-WLIwPibRN9iwzDko4kIrfQ-1; Sat, 25 May 2024 19:45:06 -0400
X-MC-Unique: WLIwPibRN9iwzDko4kIrfQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43fb05b2932so21033781cf.1
        for <git@vger.kernel.org>; Sat, 25 May 2024 16:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716680706; x=1717285506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
        b=lgFrUnkKlgI8Bv6eRiKqNeUKGCcr/EB4Kf/3TX3kPxDcd8OyYpabcRs9/ZViMJq8eE
         yi4BIDvEhQK3IVgehz1Onw5qB3GVqDbs9xnRVwRA511ZqXegtnkjpHdoxPP2ZEWow+nc
         vCA+bBL9IMKCyPQfTKCM87cNLrOQzhDtTBv/EuiZYVZG5nZBMQ+rGjZyUoyD5S8Vco5O
         EG9X91NgSvilaDOAnkG/Ab0iUwHEItgSLClncgArmQUTpf9tet3yGBUW5y8XHnk9vVs3
         clyXHtv/Z0SZKxnLgSjhNYJdo7Hv29BFMnDgJuHxtfonqpJkD0IW182C18M5U7Fb+sVF
         bzEw==
X-Gm-Message-State: AOJu0YzrJflq+0Uemq64eSof9ow9hlEQAeLrjV3nsT0aTBHDyoL2wU6n
	50xf0Ntp0+B7DVmqdwmQrQC3fDvRWO3zueJRM1FRNLTaM35fJVWB7mMF2AZkju2HO+9W401BDss
	IT+cxSJmrOK0Hmr/92OALqmSshQZIE9RAQVMvzgsIB5F8RmOR3H8tTvfD07BgRL//U1ZNsxTTbk
	GlEP7cGswuIDijSWMSB4kd4zIxJNSA360ndw==
X-Received: by 2002:ac8:5a49:0:b0:435:f8f0:2940 with SMTP id d75a77b69052e-43fb0de0f58mr65070321cf.22.1716680705499;
        Sat, 25 May 2024 16:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6kfw3Z2OPRSYGItajVECNSRJBD7Z8W3T/v453LcSBNeZYcY5eQ4EXimUm3/ACmlKnDaPA5Q==
X-Received: by 2002:ac8:5a49:0:b0:435:f8f0:2940 with SMTP id d75a77b69052e-43fb0de0f58mr65070141cf.22.1716680704984;
        Sat, 25 May 2024 16:45:04 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb182c636sm20553761cf.52.2024.05.25.16.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 16:45:04 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v6 1/3] Documentation: alias: rework notes into points
Date: Sun, 26 May 2024 09:44:33 +1000
Message-ID: <20240525234454.1489598-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525012207.1415196-1-iwienand@redhat.com>
References: <20240525012207.1415196-1-iwienand@redhat.com>
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

