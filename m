Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5412E5E
	for <git@vger.kernel.org>; Fri, 24 May 2024 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536071; cv=none; b=dXMlzLxOqF/Idz6tVlBI8bKaVUPcDIVJnORjHhkRqeD5bqFcQIvCpq/L472hpG/kyDWGbO0TL4ayJbZQf3qsNSo16ljlLSMoEn1hCmu8JkL49EsidhkuT76/S4RQJS4Mvd7X/N4dPaZzrAe0EDTMroEOsi6/182f1G85L2FFzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536071; c=relaxed/simple;
	bh=pDXRgrua6JJbUBTIL6Wugzrh2VWQLKVAmv7dGOEQyno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUTxnZjkDjNkMUlNhkefMmVXdbFo+34lZqhLgaK5vyFROB2S/+OgQqSC1RGG1MMu/z3DV+R6BkOrjNoyq86VBXhEfiFKunwgGW0e6l1uoTEMpQs0mBALGMy3h+Kub3EJcS6XIEHbyS65jQcVA2tfaiNX6J4I+/0ELbRYAB5T4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCS0gMBG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCS0gMBG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716536068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
	b=JCS0gMBGlkZLDopVOupHVRyt++BNyqj7/WXv9HmAjmqke38/lbHjbFED/4wU1rYgrL7mMM
	xslN5HDthA+A1GSnIg6cfv7c+7nYtmTPQaVyWKx+GW4fVtoJVcUDqALvQp607v1ta9qlfq
	CBVJH1JyPPfJwxpv02DW0dt6+cabyq8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-CbRcIfunOQC6FNT-TvIzWw-1; Fri, 24 May 2024 03:34:26 -0400
X-MC-Unique: CbRcIfunOQC6FNT-TvIzWw-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-62a084a0780so10807637b3.3
        for <git@vger.kernel.org>; Fri, 24 May 2024 00:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536065; x=1717140865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Amod9xU8lgw8FTf/FjDgMFSU+p0WZkQYZn85tjYS7Nw=;
        b=dZ5HjklfuFUfAoX7Q4byCLs9HLLuepmfWZhZFDzQrN2m13ycugc4wu6UMZ37qeujGX
         naz8JbUe8bEhihsdh4DXbdxpQN6hhMPr41zLnlhpiBOcCsQpyXZN+WlctpQQIbHqQqQ+
         k6nnE8osxjQUJUr0mhHR8N6YjO2XJaMhJ3D7xueHE06CZP/iz0rS3AY9VsiHd555THYs
         rAJ6wBir8uK1jl3K13nLc8+J+B60UQFxP6sTQus1nuUow0Rsfinq5RGJe61PneLYrvBW
         Qh0Wv3JlyBo35mNLsLk5dek+Rq5be2/HlezLGFL8ADRJPt8muPrGil8+jXt9U4g7MRXr
         QZbg==
X-Gm-Message-State: AOJu0YzuD0bvnX6bmHBv9PMf9QreF6g0K2s7Vvr+OnbyEkwuEShFUcd9
	LzXIh+IA9JShxLXRbsNVaA45RysR2ZS4/GjuZqjo/u32LoRvbnVnq8+UeKY0Wv4EhA/2vITjtIj
	K2yG0YZOOGxF0eHeNxP2gmiJrgTX2ITQXTuOefMVhKkxk2Q/TCTxArdUTLNiqzi43NIu7PQTlQ4
	o+2RWurOHHoL731h5IAwEHyFhBjn4UL6GoMw==
X-Received: by 2002:a0d:d8ca:0:b0:618:7a0d:d5ef with SMTP id 00721157ae682-62a08dc608emr14382077b3.28.1716536065489;
        Fri, 24 May 2024 00:34:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO4JbcNHEguqq4qtCH6sTQetlmuU7qoQrntQU2LF5X0pb2EUU2K6ybyfxbaGNmRp+Atxy1TA==
X-Received: by 2002:a0d:d8ca:0:b0:618:7a0d:d5ef with SMTP id 00721157ae682-62a08dc608emr14381887b3.28.1716536064938;
        Fri, 24 May 2024 00:34:24 -0700 (PDT)
Received: from fedora19.redhat.com (203-12-11-234.dyn.launtel.net.au. [203.12.11.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ac0710865fsm4893356d6.71.2024.05.24.00.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:34:24 -0700 (PDT)
From: Ian Wienand <iwienand@redhat.com>
To: git@vger.kernel.org
Cc: Ian Wienand <iwienand@redhat.com>
Subject: [PATCH v4 1/3] Documentation: alias: rework notes into points
Date: Fri, 24 May 2024 17:32:42 +1000
Message-ID: <20240524073411.1355958-1-iwienand@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523043806.1223032-1-iwienand@redhat.com>
References: <20240523043806.1223032-1-iwienand@redhat.com>
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

