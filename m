Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB09239180
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354146; cv=none; b=hll/N7jIoteMuU8FGCgDG7T3p2BcfSfcVcPKT4dxrfYPyRSIp8Ycfh/MT96CEKhp4e70sflCnuwufc1C2GHoowjSpCv5d1lbH3bNVHm/N0FhbsFoSjJ+ROLjhGc+mxmO0lqMXN4e9vOq6VkjNv1Q0a/1BDej+4OaLakUhBdg4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354146; c=relaxed/simple;
	bh=63sujDndVvxw5UZIb+WwwWQnNazFv0jAYkv6F491zrc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O4Zn87JPh+SiQWMMJ+Tnt23vv02CeXqiHHp9ERrwJXFOa/ebxkiwpq5fnpxbfc0v0l1Sk7xceRInfkl6tHSs5WUFZMiAeRasbs3FNWMwrbJsNDzDI9wrI84AtBphE4homfYe3uU3QnXPEfIczUFDgSs3voKnWSSvMYnwH8ZeeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNE3zbyL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNE3zbyL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso192718a12.2
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733354144; x=1733958944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hoyx8wVzwQ7G5MK6MR+TA9RALs3frZPdevFJjpHa30=;
        b=WNE3zbyLRyPO08ucIXoQW7hstq7Bf1TeaifHKLpnjXbh5el5bZmoVF4bPFLX6rg6si
         kf7boIT5G0/7IMGUXrZxYqDRfTC9pN0MsejH6cHrFKeaC00LD88+3EOIXWUv0o9RPf+F
         9VJDFr+9y7XmnLoZx71yq2pS6NNYJDafz12VB7OC/LhUgDoOf8GVAapwRmbv9UKsvYFY
         JJWbuuPeUYJfiAWTBzHOftJDqQ9KHvZijh7PxRCDKcFgWcbOHscvNZJAwinAHQLO6fau
         5mtfeoW4l8l/We6zKunQNuUasN0Tl+h83OjrajMH8DcArnf0bNa7rsPEZsI3Cacfz6fk
         9TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733354144; x=1733958944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hoyx8wVzwQ7G5MK6MR+TA9RALs3frZPdevFJjpHa30=;
        b=R5OsyCJDBpqOCAhyMB2fY+tB6NTon82A2mnGX6/4o0bztgvcgag9QBdA7ytHgen9Vg
         5SyuYb5QZbSp2zgkSuaZo6N5tMGFbaLuhaIOCpJgvVaoJxPA2A7Kc5n3dPtTWLG++Xad
         Dm+FAUCdMFQaXddokj3cySLDRN6XkKzq2BH80JkLuz4U8Ybi9RmcrItgJzvWjauJgYn+
         fASn47Shjgy6v2/ENtnlkh8FO6RPrNencZ3wRKa5IHx0aI37vVAwkQyeCdmSNkpsO0TC
         mkuS5kg3e5PciqXxay3rjQpKQz8+pxS64HOFPiNphyqVXC2FCOfjrsjILhLNrzSJ0vUo
         X5ag==
X-Gm-Message-State: AOJu0Ywmf8d5p0SZa7gIeOzCKZo1BOGeYtP5Y2RIl6Marx75vzR5iFlc
	zwtEttN+Ki7NRsTtKvXIUVYpynox29JGyZ6nVkZn2KOxZcj+nFpAdan1Y+BjGjZT0sXwKcI4YTL
	K6nD+aD7OZGxtzI1S8OMZt2fEsHXoaMonZdUWPklqmHlD/Yp3b4OuFjXNY3ywZ/OxxRVtQI/YPj
	y7BxbqLwN0u8wsiw6HqyyesJM3Y3nK7asoCVlsfZI=
X-Google-Smtp-Source: AGHT+IFUexna+voPnfS8f6apovENFN9FL+Gdi+MjQd1NA0nY0e/WajB98gMu2ZbPydRLccvjXhOaO6yuIpjG9w==
X-Received: from pgbeu12.prod.google.com ([2002:a05:6a02:478c:b0:7fc:2404:1fe9])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:258f:b0:1dc:5023:e8d9 with SMTP id adf61e73a8af0-1e1653c587amr13609855637.25.1733354144471;
 Wed, 04 Dec 2024 15:15:44 -0800 (PST)
Date: Wed,  4 Dec 2024 15:15:42 -0800
In-Reply-To: <20241106211717.GD956383@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106211717.GD956383@coredump.intra.peff.net>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
Subject: [PATCH] fixup! describe: stop traversing when we run out of names
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: peff@peff.net, gitster@pobox.com, benno.martin.evers@gmail.com, 
	benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org, masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"

Don't exit when we run out of names if we also set --always

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/describe.c  |  2 +-
 t/t6120-describe.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8ec3be87df..065c1bde6e 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -336,7 +336,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		return;
 	}
 
-	if (!max_candidates)
+	if (!max_candidates && !always)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
 		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 5633b11d01..9aebf09d3d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -715,4 +715,18 @@ test_expect_success 'describe --broken --dirty with a file with changed stat' '
 	)
 '
 
+test_expect_success '--always with no refs falls back to commit hash' '
+	git init always-no-refs &&
+	(
+		cd always-no-refs &&
+		test_commit --no-tag A &&
+		test_commit --no-tag B &&
+		test_commit --no-tag C &&
+		git describe --abbrev=12 --always HEAD^ >actual &&
+		echo 13 >expected_size &&
+		test_file_size actual >actual_size &&
+		test_cmp expected_size actual_size
+	)
+'
+
 test_done

base-commit: a4f8a869558d59677e8d9798666a23391f0b4ca8
-- 
2.47.0.338.g60cca15819-goog

