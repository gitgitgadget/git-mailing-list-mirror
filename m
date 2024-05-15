Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C08315AD90
	for <git@vger.kernel.org>; Wed, 15 May 2024 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800876; cv=none; b=bkK4u5Ta2JMpdqEZutXu3IosIFNWPE7JlqmcG9e5lnVl3ca0kFJUf7SRI1wD+YhK2D+c/7qtzADkVpauIla0tfzYtnqwZLtBvgmj/7GB29RtZYZ6PYWkaQkp+ssuxWwgfA2jD26rzJdMeCOvHm1JUdEa2Co+yEdyTkDZX1V0pfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800876; c=relaxed/simple;
	bh=IP58TgRDssv46Ow1ZB9SY/ezEN387JvE+NjCeBFgJx4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jxd+fY6/jEUQmWPye7i9sWw8uFxdWzx6k3gTDuQd4dp6uLNVk0C9J8Lsjuc28XIWQKWr/9Wo+A7VZ0tmQ3qAuWnYXFiUDIArcQ3OyP0AEotA+AUh9Vd0a5EazHGCVm4sEeQkGf6cYmZ6kOBLrWKffjM8BuQ8udWMeArzUlqZGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBTAx7De; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBTAx7De"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e576057c56so52559641fa.3
        for <git@vger.kernel.org>; Wed, 15 May 2024 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715800872; x=1716405672; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YE+yuvJK53dqhT33Vf1e6JjQ0Y9K1FWd4mICZj3iDc=;
        b=kBTAx7De68UvF3kg8YtuR8DvygQeCg90zy9hZ0M9B7o4+BQVPHhu3cRsgyfZCUiK+U
         D21PQxgvvNcQRC7vzlnofcvUfjrbxCRb5hlMNuR+J72wbZ9cFUfrl6bvRAiyrsbOUo7I
         b/YeryFI/Y1DJajYfvEQC0eTGI+/RbTIdVpte9m+92BbbF7uACPs2NjAos6wnp6apFZ/
         kAltwC3zWQs+1fcXprzxar6uOoUGsriTKPRBsxw/bWAwhtV0WP775ot80zSwKWWo+p6h
         iMxNR9uzVokY6Cb+vTqg6RFXQhO2gxjsrNzs4AnMikkvVn0Jlk6N6K8Vb71BEpahoRqt
         GpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715800872; x=1716405672;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YE+yuvJK53dqhT33Vf1e6JjQ0Y9K1FWd4mICZj3iDc=;
        b=rW4g1C3KxipCgEBQwhhU8Z8FQE6KV+JAQzKVc9Zm1z4PxyoisO9CdIQ5RH8aE3HkYH
         KxGqmR4U5FsXCWn1DXqTw30aR6/Gb4yNwV4mAxkSekcltIqE/PI3bu60LJRkoq8QCG3x
         yMJUjXPFUvOkmTNA4NuvkBvAL8nj6MpUs6egwprbrsxnIBARFf+KvBqmsqo+fhNFSl5m
         1x79LmsIyGzJE/xu+yTjTwOMjFQWe9hS48A1qS8nahKBqsqwmsDupdMDa57aIYCUx3hc
         drwbEGK2I57Z++bjrwDO62+TsbE3DlhJGHx9eeah8HRM9ZMB85FQMvx4GrtjvhaTYVBE
         zolg==
X-Gm-Message-State: AOJu0YzX4ITEtQMwyfWOojcsvIu/YMFX6TYOjpwttIwK7kD9WacI2jqa
	trXZ1vYelEZhNDshSXd3NCvMb88YF9kXT3fTaJP3RRSg7HYvR5y1LSp4eA==
X-Google-Smtp-Source: AGHT+IHE0EYqvuhbeNaLutNMJyh+jPpzZRYE932xsSulM17WSww29zjWYYBLRMaD8aRczYvtqF5o4Q==
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr114734171fa.3.1715800871514;
        Wed, 15 May 2024 12:21:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f9bc3b12fsm142309165e9.0.2024.05.15.12.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 12:21:11 -0700 (PDT)
Message-Id: <146b0ae9146f2c575738cb0d6a5008b766aa0c57.1715800868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
References: <pull.1729.v2.git.1715428542.gitgitgadget@gmail.com>
	<pull.1729.v3.git.1715800868.gitgitgadget@gmail.com>
From: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 May 2024 19:21:07 +0000
Subject: [PATCH v3 2/2] osxkeychain: state to skip unnecessary store
 operations
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
Cc: Bo Anderson <mail@boanderson.me>,
    Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Junio C Hamano <gitster@pobox.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Koji Nakamaru <koji.nakamaru@gree.net>

From: Koji Nakamaru <koji.nakamaru@gree.net>

git passes a credential that has been used successfully to the helpers
to record. If a credential is already stored,
"git-credential-osxkeychain store" just records the credential returned
by "git-credential-osxkeychain get", and unnecessary (sometimes
problematic) SecItemAdd() and/or SecItemUpdate() are performed.

We can skip such unnecessary operations by marking a credential returned
by "git-credential-osxkeychain get". This marking can be done by
utilizing the "state[]" feature:

- The "get" command sets the field "state[]=osxkeychain:seen=1".

- The "store" command skips its actual operation if the field
  "state[]=osxkeychain:seen=1" exists.

Introduce a new state "state[]=osxkeychain:seen=1".

Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Koji Nakamaru <koji.nakamaru@gree.net>
---
 .../osxkeychain/git-credential-osxkeychain.c          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 0884db48d0a..6ce22a28ed7 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -12,6 +12,7 @@ static CFStringRef username;
 static CFDataRef password;
 static CFDataRef password_expiry_utc;
 static CFDataRef oauth_refresh_token;
+static int state_seen;
 
 static void clear_credential(void)
 {
@@ -171,6 +172,9 @@ static OSStatus find_internet_password(void)
 
 	CFRelease(item);
 
+	write_item("capability[]", "state", strlen("state"));
+	write_item("state[]", "osxkeychain:seen=1", strlen("osxkeychain:seen=1"));
+
 out:
 	CFRelease(attrs);
 
@@ -284,6 +288,9 @@ static OSStatus add_internet_password(void)
 	CFDictionaryRef attrs;
 	OSStatus result;
 
+	if (state_seen)
+		return errSecSuccess;
+
 	/* Only store complete credentials */
 	if (!protocol || !host || !username || !password)
 		return -1;
@@ -395,6 +402,10 @@ static void read_credential(void)
 			oauth_refresh_token = CFDataCreate(kCFAllocatorDefault,
 							   (UInt8 *)v,
 							   strlen(v));
+		else if (!strcmp(buf, "state[]")) {
+			if (!strcmp(v, "osxkeychain:seen=1"))
+				state_seen = 1;
+		}
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
-- 
gitgitgadget
