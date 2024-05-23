Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22488273FD
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438121; cv=none; b=XAudfYeKuZw5cYSjadrFgf5GsmUohY9xzvgA6h9EkctL0aLGDd8uN3P7auDV9asY63wLhM9wWhP4Q+zMqnwrRf6CKgJnCBOo1yQnjwNXyqY1D35b9BfnYXzxoYpX8OHleKCmMcGIRI226w/25SxuuWxlt/baY3puH2TYuggctoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438121; c=relaxed/simple;
	bh=nZGOCaO/XYrjYwmmTMJFxQbkww/8y97A/ZwnXbuAFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeeYCEwyIjz/gNGwa7IVLIX8a0DHC8skhZ865rWLNMRfggwFjOsfyvosLXTkj7nW29kcQdG5cgZ7rh1/pZ/ayOuKmlVloysVnAZPCxYqGLG3gTSa46L1duk3DR4WeCAD08zqcrYl46+JdxPCOOu1vy2kEaOv4MmNKEg82CywEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJQnj4Mk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJQnj4Mk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716438119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yV2xFmpXgf0YMwvxbETIiihVXVglQJa/L7LbJ2xpF0U=;
	b=cJQnj4Mk8QhsQ7Kf2SfG9R/g9poGqBWyraviYE8PxjCBnOWeauyIFMBpcdescdoqpqB6hd
	LdF+wOCJgpkuaWS75pa+HGLt+ZuiXh3AdphNv7QN6aZdWf27/lM0nje8vxjvvvbYd0aADu
	eloZ93oBnwaDIN7cVhzmBNCWR6bnydU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-OyD0kNWwMa-Mw90CObUNoQ-1; Thu, 23 May 2024 00:21:57 -0400
X-MC-Unique: OyD0kNWwMa-Mw90CObUNoQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792baeb223bso1868135385a.1
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438115; x=1717042915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yV2xFmpXgf0YMwvxbETIiihVXVglQJa/L7LbJ2xpF0U=;
        b=AWit8Znkx1Ov7/PsmjFcL3qe1RmeAdyZwRGZ4NhXQNxkkc+z0g4XbViXRE47+cye10
         l6IwtQAcKh9Yjv5geIzdQMgjniQ3xiKBwZjezqQ3rFnhMKoAVPm75D+UgHMOsEQKMXzz
         tWaK4fVbGbvdomPRDbdTS3hZ4vjWmqBsItOh8U4lvLcEFx1MzyHxorJ4/cIKKFOhiPBI
         4LQNILnOXENh130L3rYKm8S/pMP8H/LXuXQ2vR5LmASS7jC6MFy7o/U6LPuS7owi45/N
         KX7w/9i1CXjsykJUDqZmWFK4esjy8U0wLFP33m+4r+HCxqzc26huA3PI1gHIms4JnMDy
         Nhnw==
X-Gm-Message-State: AOJu0Yzv1Mal652kJwUyByuPRsj0ctu+wnzUpyhv3sFW775Ulm/pVal5
	ck62iKdXUsoQlI5X9hwWxVGK1qlSiuSPur9F70ffD7TENDZn3TqCrl4K90s6Ii+tBmfGacHGwnY
	RxwhcbamyvzLP9Vo4XM+juOY4QdY2qxEB/oobisA13DHwqCQoVYOSPUm2F4hd3aaVL99xT88pdY
	Nmqxh+yz5xIRIJdYIPoTJ0vaI67J4H6HUHMw==
X-Received: by 2002:ae9:e40d:0:b0:790:cc3b:fe65 with SMTP id af79cd13be357-7949941cbfcmr523345385a.10.1716438115695;
        Wed, 22 May 2024 21:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZIPqF/DqV07HSYFLxxCxsQmmdobWdpQrbs/MTdQ2323YdTgTwGdi9ALEsuw6f3jPjtrA1BA==
X-Received: by 2002:ae9:e40d:0:b0:790:cc3b:fe65 with SMTP id af79cd13be357-7949941cbfcmr523343485a.10.1716438115198;
        Wed, 22 May 2024 21:21:55 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794807f4465sm412760385a.62.2024.05.22.21.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:21:54 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v2 1/3] Documentation: alias: rework notes into points
Date: Thu, 23 May 2024 14:20:57 +1000
Message-ID: <20240523042143.1220862-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522024133.1108005-1-iwienand@redhat.com>
References: <20240522024133.1108005-1-iwienand@redhat.com>
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

