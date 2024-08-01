Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F713B5A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525192; cv=none; b=P5L4LDjLhaJ9eORjXIucGa+pz6abOq1ggWzInqF2w2xxgU/FJe6lRAdJalG31VUTdZP3LhbrDxSY4Tzjzmeh0b+Xcfqpq3uYDAD7VJlZBrMa7d6ijWaLZTVY6zcSodWL6QeGcjOYw+QY9P8kby0bjDDqQNyQiMJ9xj5CaGkbC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525192; c=relaxed/simple;
	bh=4S/eeYa3WSAOASAvQOCp2KZZaz7om+5BeG3DmzjcW/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDOLNqywsBRlfWPiNicoAAbgfxw7JMP1ypGt8EgkgFyjLdOvtZU5udnqJW5+o28kxK65Ce6BlWS4o9Y2Dvjfs3jnXXLw9p3LrUT/++h5EwXH5SHc3aBwCyT43/kCdWQnclht6SS1lEazos1ci61hn7VhMc+jsA/OmEdoFtzdmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS5M/1IK; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS5M/1IK"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d150e8153so1552732b3a.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525190; x=1723129990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=ZS5M/1IKPeo6B6/JOlKPVWL68V3kqgqyOo0OJsaUyPK9von/xPIp9wgxh4aaTC0BUJ
         Bpev/16BVHj27NZX71qbVyEZPMZqBz2At0Xr4hyBz6oXFriUFj8q5Q0S72ReCslcxwCC
         3h1TCz2wnF3kTGvQ35jaFzIdWg+8E5krXcCe5a1QOjdvxJD0q5vAZTlc5OxQEPaoFXgC
         d5dJoTOn4N54Dl/vmSiM22aTG1ZLOTgU1wJMBDR7nyVzgeZ93mZmUHlGyn++xWuFllSs
         pKp94IGUVyJR9rHjNV3Z02AJm63ge0dt25e9Si+X34Gy3AA/qOYrIus3QYPzrTvzk85/
         1IyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525190; x=1723129990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UDRGCnen2eMRIWeoclWfDlQnsmaMv5ILJOERPNxlb4=;
        b=uce9fVPc99/0SESt4KRaJhFVFeY01fbT6kgFQeHqbUTbgeKsb4JQsjJ0Zm5p1qLgVd
         bHVgwR0JA54LV6x7puYet2yLj2XaX2IVmZFai8yq9SNiEh6wmqzP/qNWTXvNy0aAQ3oV
         JQwXEH/JlvKB4IT+RsKG9kqgpWbPzaBdWQjEs19YsDhyLyqQ+SIHRy7BrE/SrY++isZI
         4yZCTboEg5pLRhNOieqp/EW6cZnT6D9xXvmMzirMr9uvzN8r+KfANH6sZPIfVKVhJKJl
         Ulc67DWzM+a/+pk9Ge5RDljuAk0GH9iNK3jBUT7JasbBe95WVD2yBUPaDhYgLD9G2JIZ
         L+8Q==
X-Gm-Message-State: AOJu0YybfQ9vlm6MqNrgEGfH7G1GFAAODtPKvWaSWJTOOVs8OD3u7l9L
	tqhhEaj4dcG2xtpftKCCYtuloWnqZZtvvxnoV5RDe/RmArfaZY8xsWXvUw==
X-Google-Smtp-Source: AGHT+IGX+BKBUZwbi9IIKRe3lxNQDJnNQ5wLfVRQ4cA6X9fqASpf7mD7nkxs+OIQaFjIs90AmlGFdw==
X-Received: by 2002:a05:6a00:8583:b0:706:5daf:efa5 with SMTP id d2e1a72fcca58-71065e9d3d8mr2470000b3a.9.1722525189590;
        Thu, 01 Aug 2024 08:13:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f9ec7acdsm12108329a12.66.2024.08.01.08.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:13:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:13:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 01/11] fsck: rename "skiplist" to "skip_oids"
Message-ID: <ZqumHEP4OGR4Rr0E@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

The "skiplist" field in "fsck_options" is related to objects. Because we
are going to introduce ref consistency check, the "skiplist" name is too
general which will make the caller think "skiplist" is related to both
the refs and objects.

It may seem that for both refs and objects, we should provide a general
"skiplist" here. However, the type for "skiplist" is `struct oidset`
which is totally unsuitable for refs.

To avoid above ambiguity, rename "skiplist" to "skip_oids".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 4 ++--
 fsck.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index eea7145470..3f32441492 100644
--- a/fsck.c
+++ b/fsck.c
@@ -205,7 +205,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			oidset_parse_file(&options->skiplist, buf + equal + 1,
+			oidset_parse_file(&options->skip_oids, buf + equal + 1,
 					  the_repository->hash_algo);
 			buf += len + 1;
 			continue;
@@ -223,7 +223,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 static int object_on_skiplist(struct fsck_options *opts,
 			      const struct object_id *oid)
 {
-	return opts && oid && oidset_contains(&opts->skiplist, oid);
+	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
 __attribute__((format (printf, 5, 6)))
diff --git a/fsck.h b/fsck.h
index 6085a384f6..bcfb2e34cd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -136,7 +136,7 @@ struct fsck_options {
 	fsck_error error_func;
 	unsigned strict:1;
 	enum fsck_msg_type *msg_type;
-	struct oidset skiplist;
+	struct oidset skip_oids;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -145,7 +145,7 @@ struct fsck_options {
 };
 
 #define FSCK_OPTIONS_DEFAULT { \
-	.skiplist = OIDSET_INIT, \
+	.skip_oids = OIDSET_INIT, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
-- 
2.45.2

