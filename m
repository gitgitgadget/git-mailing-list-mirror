Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A657224D2
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439109; cv=none; b=ZSOrcSXcv3sUuo6R+gtzmcIdQMCWl6GYIcHtd/LQNzWk4Tn8/cM/8MykSdKfDoYbN1jRBa/6MKDjBodk1RQBr7iZaNutBRqGWDdSBMxRDPi45PYzXmXYajMsQsw18fiwxyaXD+DeDDbg+6UADD2JlYsUOOJY51yR7bv3zDzjssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439109; c=relaxed/simple;
	bh=pDXRgrua6JJbUBTIL6Wugzrh2VWQLKVAmv7dGOEQyno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWBQ4kBNZ//DAgidrD25VHWDfy3UjDKtof8ePXCAyx+gOAsc+ZCZC7Eerlk+D13R4lppLz6CvqwvOrhPEm+Z26Yn/qde/htQLwcXLWhkJrBis9ONN459zolbM+F/eshZUm/9YmToWRc5NfBGpS+gzpcMGPpSOKbtEKgu2YF5r6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlmUzIqM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlmUzIqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716439106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
	b=OlmUzIqM+HBkESmn4K77MWKVre1tj0uZ93FYhFWXa7ctfqFE7QSVmlaxl9+P6IUoDlYeuz
	BkhSIrILQzkNJsxxpH73n7jtHXQ29yG0xT4WvTMo56X1IN2KlSc4nDLcLC8Y3thZCfs5oQ
	kjGijIjcvBea/zWEfU9yR/BeWIRqnUM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-iOpYBEpGMxKTtmRA_dMi2Q-1; Thu, 23 May 2024 00:38:24 -0400
X-MC-Unique: iOpYBEpGMxKTtmRA_dMi2Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ab895670easo12479086d6.3
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716439103; x=1717043903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
        b=MVhB/1D2p/tNTZ3i4LvpC12X5wNc6pIthgScpBLRXXOVSidsZSNo8x4g2CNLDu6Sk+
         eSCkf6/RlBtemVlPbOrT180FXbYjfll5io+NiIik7w23a0xoAApR55r983TzPDu+z6+Z
         TAECJIVmv1JstkElc4iHFt7zL23lHcQmVJZ6WBvPHnLa8xz4Juwps4qHfmTYhmvZ2KI0
         TI4yYY4fGeW5v3fY33yhkEUZ8eTZAL43QbENPr423LgZrSj+a0igr90PDa95RfhlTb40
         UBbwWwMsW5z2OiWDafM3K+ELx+YH20ivvkzZXOAp5zJLspmqX1CNywuQIIuyeE9OojT9
         6ESg==
X-Gm-Message-State: AOJu0Yz/5xjsXRwl8ZBs3+fKMjXbHhPB00NSFgiTwTUIkipq02ty8Am0
	5dQcZCP+ZCHc59VZWuAie+6VBCdpyXjNJaEBofKpctbAH2hnJFRqklsmdS1KTpHQ/VRw2t8e4Ud
	H7HaPHd0hdDHyAIDeMz/j7SuAZq1GrLfSGaXSaGuACiB3DnrW0eWeqOuA0187Pv2Rz/h+v6mUFE
	GoYCMtTkGeTMsRu1QxjLyz4To3h/++PJ6xVg==
X-Received: by 2002:a05:6214:2b9d:b0:6a9:944b:8fdb with SMTP id 6a1803df08f44-6ab7f332cd8mr41945616d6.9.1716439103501;
        Wed, 22 May 2024 21:38:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnyDJzfncR0vX/Z7akPB5lCWFE4if2Ta4owJ1X24hkBaX47JMjGiI4QwWTiWlQUvMSST2IDA==
X-Received: by 2002:a05:6214:2b9d:b0:6a9:944b:8fdb with SMTP id 6a1803df08f44-6ab7f332cd8mr41945466d6.9.1716439102901;
        Wed, 22 May 2024 21:38:22 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a35969bcd5sm80952706d6.53.2024.05.22.21.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:38:22 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v3 1/3] Documentation: alias: rework notes into points
Date: Thu, 23 May 2024 14:37:54 +1000
Message-ID: <20240523043806.1223032-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523042143.1220862-1-iwienand@redhat.com>
References: <20240523042143.1220862-1-iwienand@redhat.com>
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

