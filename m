Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BE1519BE
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595256; cv=none; b=VfQACbGWNvxbzWIU4wDQ0dlB8g1/kwaV4aRN4qoqZdCd7DycTuMMV3yfFUxaGk7MWV1onfJLeZ6ZthVIp2SVMzfJgiqHZQFA/XQQFrVmHzD3UNaPeF5Vjtl7v2VMW4Elr/hhGfkt7/8u4RaTZZn8P8Q/jjsfy7GQjmEqEbOA7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595256; c=relaxed/simple;
	bh=6DVymf5fE9b56Df/i8UuyKNan+MxhtnkTISpeTeTtbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo1qZhSUj/JAcCCzB3RcmRYGxaCIInVzFTz5jggZM+BBnulDO9t6V65NtU1f5YCmj1NqYAaBYBu3vwYKnhjmvPNbW8V33o9bNe7ETpgJx5rjUQ5IfIlfsPJZmyFeW4ykgtp5uXj7tNM09Vg2mDiIkxES7EI8lgN61/mkYSrfUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=nH591Hi0; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="nH591Hi0"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52LME9CB018881-52LME9CD018881
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 22 Mar 2025 00:14:09 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tvkcz-006VLb-An; Sat, 22 Mar 2025 00:14:09 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Sat, 22 Mar
 2025 00:14:08 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 241b0d1c;
	Fri, 21 Mar 2025 22:14:08 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Karthik Nayak <karthik.188@gmail.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2] bulk-checkin: fix sign compare warnings
Date: Sat, 22 Mar 2025 00:14:04 +0200
Message-ID: <20250321221404.10727-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
References: <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-11.utu.fi (130.232.247.51) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWUgDCRocAAEDRllQUCgPBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=k1RuXFRFqtgudGPA8LyZbJlghkaZy1ejoE2diDmU7Zk=;
 b=nH591Hi0OHCjvRVpBluKk1+XBmtppcaasfodnN7/9ud5GLjPbNeSFuXhh9PSHys5AoZBgRSqvndB
	bRkXAd1dNgoaY1hd71kxDIsRCNPoT0hViNM+MYdoEvK1cDWz6BTLozNDWJztLBZLBJN7paUMLRkd
	g+K3/eE2JwCKi+4LXX/L6LLbU2TpqKWx7lqSQDZPRn1CzqwbLQe4w0FAVaYiAXezEHUFa/h5mdan
	AKg9rh6VvodqJe6KdUxbvtoYjjL1afciqRc+GDhxjlOzElU/51UX2tNQvYko1F44+wrR1mMG5RY8
	qq0aTsiBHmd/SDtraS3P0Jv2z2YiS+X7CR+pAA==

In file bulk-checkin.c, three warnings are emitted by
"-Wsign-compare", two of which are caused by trivial loop iterator
type mismatches.  The third one is also an uncomplicated case for
which a simple cast is a safe and sufficient action as the variable in
question only holds positive values (from sizeof() expression).

Fix issues accordingly, and enable sign compare warnings for the file.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
Intervall-diff mot v1:
1:  25b56dae76 ! 1:  289f3a0278 bulk-checkin: fix sign compare warnings
    @@ Commit message
         In file bulk-checkin.c, three warnings are emitted by
         "-Wsign-compare", two of which are caused by trivial loop iterator
         type mismatches.  The third one is also an uncomplicated case for
    -    which a simple cast is a sufficient remedy.
    +    which a simple cast is a safe and sufficient action as the variable in
    +    question only holds positive values (from sizeof() expression).
     
         Fix issues accordingly, and enable sign compare warnings for the file.
     

 bulk-checkin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 20f2da67b9..0133427132 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,7 +3,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
@@ -56,7 +55,6 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
-	int i;
 
 	if (!state->f)
 		return;
@@ -82,7 +80,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 	finish_tmp_packfile(&packname, state->pack_tmp_name,
 			    state->written, state->nr_written,
 			    &state->pack_idx_opts, hash);
-	for (i = 0; i < state->nr_written; i++)
+	for (uint32_t i = 0; i < state->nr_written; i++)
 		free(state->written[i]);
 
 clear_exit:
@@ -131,14 +129,12 @@ static void flush_batch_fsync(void)
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
-	int i;
-
 	/* The object may already exist in the repository */
 	if (repo_has_object_file(the_repository, oid))
 		return 1;
 
 	/* Might want to keep the list sorted */
-	for (i = 0; i < state->nr_written; i++)
+	for (uint32_t i = 0; i < state->nr_written; i++)
 		if (oideq(&state->written[i]->oid, oid))
 			return 1;
 
@@ -192,7 +188,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
 			offset += rsize;
 			if (*already_hashed_to < offset) {
 				size_t hsize = offset - *already_hashed_to;
-				if (rsize < hsize)
+				if ((size_t)rsize < hsize)
 					hsize = rsize;
 				if (hsize)
 					git_hash_update(ctx, ibuf, hsize);

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.30.2

