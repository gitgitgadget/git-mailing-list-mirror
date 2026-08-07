Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B3443E4F
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140452; cv=none; b=TPFKa0iVDlASY+LpOPnsWcIXkEC5xNz/i72qUjxUiz+uPrghIvqzg0JYYRWp8+NQUAvN2TsN6S3Yrdb03U0oZdDnDyovZUkI9GCeqVg4ZHGBJxJki7YTSA4TpTdaAymYmMClmd7IMpWhjcG50j4RchMVuWwQOS4VTgPKKhlyvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140452; c=relaxed/simple;
	bh=YF6kd9hmLWVQKjBu0ToIcShnPDbAzRGZ7eJVhKyeTUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUJH2LsJ53Nbx80xlMMZK7+k+G2VhYA0hLyBTlYdPuC+CmrODvC/F4L8CbATTPe0bSvwHXSIZabYBoXQZupBxBdBNHtSi/DKIkWM7HKwWGH95BowVOSL1WlvGAiagEkyq2VDSiQWOhzUXOAZrjrJKu0ddwCJovNmHdd39Bu1SAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdeytB2E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdeytB2E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495437bb891so234435e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140449; x=1786745249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=DdeytB2EgVWklfcTzkMcI+/9cmipbdyeJ5PqRax3EPM5EPuvwHUd6ltYbg6m1y5S33
         xLMKkNI9rMNb1x5ZjzLQmVevUNsWiAjcXEYgk8AePO88gNxHl7/ABmAZ8BJ0v3OextLb
         e1xC08RaWKer4XPQhnPr8l9IXg3u8mjR0yRALAfxHhqSMXtvZdRHBYg4lbOlIO5Atide
         0QMmzWP0TFifSYMpb5/wfQ6XJqTJlyNguNcERo/v6A4q6ZXb6/fHuM2dPhIXAKQrenOl
         z4V17YPI9RjIryFdzISfOU4EEp/a6F3n0t3pN1Llef1Rnxw0YnIilB6beYX8Idmrknyy
         +xNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140449; x=1786745249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=V1Df9+V8asvk0E+R/3phFYMFmjz/hhuP64TJ9CHgooE6TGfT8IwxrgAfXl99x+XKAa
         kVYwvoY9/uAOSdvxm28+ZkMOhMk5g5OJkPgFrowxKXEwqbgdIiDDI3wRCa21HkEceM40
         xjzS76mpSNM1TJNlHdgNvap+rJoFPowT1mlKvM2xz9ukMXm6OD342ojbKXXiHsFxiYKw
         YirAA8euY/wmue26t5jV71t7xQNfkVBJjcntUwpotSjDtvg912HsyRl0o7UIsAb6PoS6
         tsozYnIVjgGP5spZ6FfJNAjtwr0dPq0HjfsN3e9jSork/Qw2itS9i/b9jXyON6Xs2h9k
         1mcQ==
X-Gm-Message-State: AOJu0YzC9oU1H9KflFet05fMzwbM8UPGUp4LfSkk8OPktENzCJYGd0zF
	RnIvngHdHDvRO5J6vYzBxVZSrqyu9SJ/gDB6q55WtMTisDktBZxR1Ccn
X-Gm-Gg: AR+sD13gDu5fIGL3Ms3brP2/FAkvgDuu9LS0djWvuqgp/YN8e/2odxCzi++CKjKx9gf
	35Pw1eWAgcIkfQF/gmGmPezOFACClX2Mc+PBAjU4zauZBZ3Kl7Js6/NBqIjF7Wt6M+9e+/Z8QZz
	lVAY5af8CL+XrAUMXdekOyxkru5P3RDKPQTPhAVHWG2smVd/MvvcIp4U99a9iA5AQNopJtk+Wkj
	Pm09G+uQquSXn4pqHI6VybSSpCwQsg2djvmm7c+8E7BXerkFlOyuSLmWDdYdEw/Z1Magm7+AOIK
	9h3WXnm9pjfiVpOipBxrAoiI9u80+QGx6nqaAzw51KqxqdP5TJaFn6wxWRbvJBAhbtrZWK9mFeu
	6KbVkgygzzH40ijAElgWfLFaECx/B8LP7WvzR9nHMekE2aSibNnT/MiK1ml/lYyXtc9ODEpktNI
	9WS0Mu03jhWMbe0NncOi5kM2hQGqXtGZPc+56BLtz1IsSawJO7gtTslwR2//9+V960ezRu8vFEG
	FWKjNreYRe2ghD4JUbb5vu9xJ9YIWzg9+DaOLh5i6woEFh3HvEDwytR0p941D/rypAvKsjIpmJH
	A6BmEhHfDXQLIe2KgRfGcx0wjcG/BUm522mBMoKoNFMvFYnOI4NanZL68Bg6ybVtcjURK7n5b17
	YRzf0Cf8cxAGbniki6PXiyHqDmaDxaNqQe1WYRGa77BjAFdXVjLm9Dzv/7TRC/HUUtLIY
X-Received: by 2002:a05:600c:3b10:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-49962462c19mr13461425e9.5.1786140448700;
        Fri, 07 Aug 2026 15:07:28 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b4499sm69478545e9.3.2026.08.07.15.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 15:07:28 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 00:07:04 +0200
Subject: [PATCH GSoC v5 09/10] serve: advertise type capability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v5-9-86f22bec04b2@gmail.com>
References: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
In-Reply-To: <20260808-objecttype-support-v5-0-86f22bec04b2@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The server and the client can handle type requests but the client won't
ask for it until the server advertises it.

Add type to the advertised capabilities so the client knows that it can
request it.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c                                |  4 ++--
 t/t1017-cat-file-remote-object-info.sh | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index 2b07d922b3..2ce513cf2d 100644
--- a/serve.c
+++ b/serve.c
@@ -97,9 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value)
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
-	/* Currently only size is supported */
+	/* Currently only size and type are supported */
 	if (value && advertise_object_info)
-		strbuf_addstr(value, "size");
+		strbuf_addstr(value, "size type");
 	return advertise_object_info;
 }
 
diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index 116862f9d0..190c45eefc 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -7,6 +7,7 @@ test_description='git cat-file --batch-command with remote-object-info command'
 
 hello_content="Hello World"
 hello_size=$(strlen "$hello_content")
+hello_type="blob"
 hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
 hello_short_oid=$(git rev-parse --short "$hello_oid")
 
@@ -19,6 +20,7 @@ unstored_oid=$(echo_without_newline "$unstored_content" | git hash-object --stdi
 # file name is hello, which is 5 characters
 # a space is 1 character and a null is 1 character
 tree_size=$(($(test_oid rawsz) + 13))
+tree_type="tree"
 
 commit_message="Initial commit"
 
@@ -31,6 +33,7 @@ commit_message="Initial commit"
 # An easier way to calculate is: 1. use `git cat-file commit <commit hash> | wc -c`,
 # to get 177, 2. then deduct 40 hex characters to get 137
 commit_size=$(($(test_oid hexsz) + 137))
+commit_type="commit"
 
 tag_header_without_oid="type blob
 tag hellotag
@@ -44,6 +47,7 @@ $tag_description"
 
 tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
 tag_size=$(strlen "$tag_content")
+tag_type="tag"
 
 set_transport_variables () {
 	hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
@@ -256,14 +260,12 @@ test_expect_success 'remote-object-info does not die on missing oid like info' '
 	)
 '
 
-# This tests depends on %(objecttype) not being supported yet, once supported
-# it needs to be updated.
-test_expect_success 'unsupported placeholder on remote returns empty string' '
+test_expect_success 'objecttype is supported by remote-object-info' '
 	(
 		set_transport_variables "$daemon_parent" &&
 		cd "$daemon_parent/daemon_client_empty" &&
 
-		echo "" >expect &&
+		echo "$hello_type" >expect &&
 		git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
 		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
 		EOF
@@ -271,6 +273,22 @@ test_expect_success 'unsupported placeholder on remote returns empty string' '
 	)
 '
 
+test_expect_success 'unsupported placeholders on remote return empty string' '
+	(
+		set_transport_variables "$daemon_parent" &&
+		cd "$daemon_parent/daemon_client_empty" &&
+
+		fmt="%(objectmode) %(objectsize:disk) %(rest) %(deltabase)" &&
+
+		# The hardcoded SPs between the atoms are respected.
+		echo "   " >expect &&
+		git cat-file --batch-command="$fmt" >actual <<-EOF &&
+		remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'requesting only objectname echoes back' '
 	(
 		set_transport_variables "$daemon_parent" &&

-- 
2.54.0

