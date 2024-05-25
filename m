Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6C19E
	for <git@vger.kernel.org>; Sat, 25 May 2024 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600141; cv=none; b=VO5hbFQWfK554PXegIOJLWZfOwZr0HJfExQKFEHgcM5QRD4cgsr6mRu2+gqvzmwg7SPpWeGLfJSMb+il/K7ZqNkJSv18FrFMsuWIBY2DRU1PqISvNNlqYBdlTCmur5PeJ3tL8YSjBOwoEdJuvO4AP4Vka2f9EdTkQPxRJ0k6VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600141; c=relaxed/simple;
	bh=pDXRgrua6JJbUBTIL6Wugzrh2VWQLKVAmv7dGOEQyno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiuBvusg32tuTes3CXMz9DJieDx34NqlLEXzCz2jhbZ1bsTTcCHBo/Mu3Jr1F0l7TVxwDAHIomJgsrcrF8zGjXYAm5/VsSFJzLQZE/Qbd3EZ05Ycf4vzGJKSO2ge770YoopwreVOLVMGgztHFhjaUe5E36FttnmTRfz/IHhHy84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA8piAN9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA8piAN9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716600138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
	b=KA8piAN9E/YqRbHLratxG2WfiJ0d4R+sKbO6XZPTowCv9/d9yDvOBfhflAi5UR2VxkvbiC
	fX4QrU1B+Wl5LvK/v9fExzcNP2sxKBxjjye1PG6kfiuyN0w8ZtAjijkhjpXHbIFAx0UEGH
	XwoHXMszcldrRyZhK6DaKvBGTdIlTLk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-sKNiUhirPnusTP5FN5VQnA-1; Fri, 24 May 2024 21:22:16 -0400
X-MC-Unique: sKNiUhirPnusTP5FN5VQnA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43e169f2a4aso19289451cf.1
        for <git@vger.kernel.org>; Fri, 24 May 2024 18:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716600136; x=1717204936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
        b=apWZUsOklNlFAxAkhlwu0A1ptSi8ZLeQtrhrmJqiwgoH37/Njwmpcizu00OkFRX2c1
         IIs/shPhaIupPup41DvTspfpZeCpResq9WjrUfrEpBr6uy4mi6EAF8F2dqkUWz66hQVK
         cmDP0MbhnjXevP+ev0iYYTPRZmEL6PD8jEaGt2yHXSHwuiHThErOhUzt9cYxVcqAglu5
         z5GqnW9l036Aa+kavtiIiRntISYBsg0D/EMkIxIZLmopmEejQ656V2403bEcNM07680e
         wN4eu8Gr+gFQbgtvP4ZLveZO3NYKGPquckahaQ2tkhem05wlGynxycB4llCHJGON/YQc
         WLyw==
X-Gm-Message-State: AOJu0YwRoglH69gCgbhjtPdJLENcolDbAI9KWwqyyTHGcOjucKw9ypav
	6ek+nqh9Enf5sbxwKPfODMHA9ZSnkzvCDbgWvk95wqEvmUXlKdAVeORfenj5UJ/EbKI2gNNxuNu
	XrSxYx2pcyfcGtIxUEzuD30IorruP4/YLQrSLJLr2YrxtP/vqYjF97Uhnx5ix9vaLSa5RBE74Nm
	HALk+HJvRK+6OCCNMDWLudpvd6yUWaWun5wQ==
X-Received: by 2002:a05:622a:14:b0:43a:df49:f8b7 with SMTP id d75a77b69052e-43fb0ea56a6mr38948041cf.36.1716600136075;
        Fri, 24 May 2024 18:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPX0IvM4ng2tgbvwYv1V1qkbyBMQM4BSD20qWIWkQFUtvPetMtbh0eCjQFv7dmH1tbamDI2w==
X-Received: by 2002:a05:622a:14:b0:43a:df49:f8b7 with SMTP id d75a77b69052e-43fb0ea56a6mr38947881cf.36.1716600135450;
        Fri, 24 May 2024 18:22:15 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b6a79sm13347841cf.13.2024.05.24.18.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 18:22:15 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v5 1/3] Documentation: alias: rework notes into points
Date: Sat, 25 May 2024 11:20:50 +1000
Message-ID: <20240525012207.1415196-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524073411.1355958-1-iwienand@redhat.com>
References: <20240524073411.1355958-1-iwienand@redhat.com>
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

