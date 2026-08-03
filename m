Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0626741685A
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768020; cv=none; b=ael8XAFQ2t4XcPMidKpETKJOXEGxV+uwwWWgm94rmVmcGeQ2h7NcEFMvwjZHJjnSi6ygn9nrTxEB6HKNLRcicYdMTUFIsJO+ms9SkZw2oIuG9rXEIlm7jcC0vHPZd3BWHzj0CCpjr6VBgcdaTTzrjCtUWWMgs0AkZuFQree/0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768020; c=relaxed/simple;
	bh=YF6kd9hmLWVQKjBu0ToIcShnPDbAzRGZ7eJVhKyeTUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g771LBV6qTp6chcr6/WvzY9O1MnNNWgy3blUYJa6JIr4uqHLYyM8lxE4uAeZaTrpgrZNzQffJdrSOsYah5mk2cZ5mU3BkRPFRXgk5sZYQ082+9ARY7udL6iR+wtVSoaSLG2rtbaeo9seKfS5BJPEmRT3b0zv4ypn6dxMhI6am/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrBrtIMo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrBrtIMo"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a2e73a9so13157935e9.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 07:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768016; x=1786372816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=PrBrtIMoVRSvTV5PgmEYzcBDw0SeMjN0/NMwHxC4Gg7DRkkdTG0X84kmGJhFmu5YI6
         D+1Ry3PCigKgjyuBhG3l+RmDIyKGZ7TQVOXUZarfmIS0WU0+y/2qPWjST5+FzMDbyl+Y
         ezgGROyErHREoa9/rITDg/74aCWC3fA0cDC9rEXPI7EABE6DqRSnuWaAL5EZ3MGD+yvi
         7V7BRetETZvl1BErvDU3onkPj8ojo3GjKCg2vSQbLuYfs+W641uC2wsGSF2A7o2aLYAR
         rE12JCaKIZOoUzEIGzuhqXmqck7IcTJ3ztmNHa60HBg/uNAKNqDHHrm7LwUnbVVOpwi0
         hwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768016; x=1786372816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D6/sjT1kD6rW5fJpUKxpvE85ofDIionXj5ELrodhOLE=;
        b=nFUmfjTVjG+LOjgJCxiF4RKlkk8kfPXsMqWE6pZltKx9QUW27znvx4p9s5XIV9eqvI
         Eh0crvXwFenjwPy6gDisoj4vP+vo9OEI8xUUx5qOIlyK4DoII3oR8mOmV98ihjEi2rVd
         w7SFw82CuxjY2aJl3ClcBFjopy72zyqU0XA7EE478EUGMyTR5gBmwwPhMmGnLq8pDF5L
         otrLrhst6NaHogwLOhZCouIuDWHr28iKLlKtjf+dsnpINw58KNWH3ktfmT+qYNtmlQTA
         8X19WgB6RBaFOVMgSpvYwairTg4zMHlTvqG2CntrKTKb1UJj41AKgBOZyFhauRRfrrni
         r6cQ==
X-Gm-Message-State: AOJu0YxQT/6jQNa9nmF5o0Kmopne3rRArRJJfiwE01casfhWQswRCnnh
	V+xMVrWXUrTmY1mIr+LXs4m0UAUphwVQWtX4ImOReA+dezHdFYVOGnmf
X-Gm-Gg: AR+sD11o360mqC+8wi6mH5LfWhQQVUuiWRV7Fxz9HNJ9KKUyi3hAytZdVaclQR9f5t0
	18XJjFKm1Baw+aBzcNQELL23wuHRYWEGzW/E0aKyZz+6041KWwHQEBOwee04v2Te3ZZ4pnmiC9P
	79LswTzj7YvzpJcWLuKc6E2iCPWLjcze5iouJlSVEPOo//hNa57ZMkj19/EEYtImsvLJVPMI14d
	qzLwdjKrGrjgNEKWHxo8JScl8/mpMvJu7F22Cju9Iu0N/eoQ+PAEjZs/l+kQ04qrCSELEBIYkkE
	JgL03Pv+C1eVwxhBZk+Va9lC1rskd+VRvF8fWX0q4s4eXWHrz6vX9AH4oOLh8Owt4zD88OGk5YX
	kb5OG0hayT6wQoLWE9PUtdZguQyenBd+QaLNX57Zd/Mo+VTdhYFthlxd35B9nl3ZJ5prjSUyJc5
	kR81Am1UYyISCWYrJxSRI2qUwuo3zd1fsOE1iyGKb09xiNTR9xREhcSRyDr3bMPuNzFj+It6zAS
	eKGZb1euZDFXep7DZ3D9E3qBYgZgwR4vSK6QDQUEB+mVJuYtiBrQf7pa+3t1Ni9WTVu+uU0ni3l
	6+P8dITRLP2rbbBbamVBKOkVVwVQOiag6aTjlhPWRUyHYsOHXl/Yc1uuaMcgaYq7lFD/O7KAuuL
	/uGmIIijPvbkzsPxc
X-Received: by 2002:a05:600c:4453:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-4980c649c6emr220175605e9.2.1785768016059;
        Mon, 03 Aug 2026 07:40:16 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([47.58.8.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm106482575e9.1.2026.08.03.07.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:40:15 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 03 Aug 2026 16:39:34 +0200
Subject: [PATCH GSoC v3 7/8] serve: advertise type capability
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-objecttype-support-v3-7-7176fecf7950@gmail.com>
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
In-Reply-To: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
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

