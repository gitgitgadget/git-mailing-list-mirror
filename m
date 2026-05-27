Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32D223336
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890935; cv=none; b=i/YuSpj9oxvYQKtHLJjvOnh8nfA5s9Az+cNrvISOa05COnUDP/OmnrZYRYI3FJJfqcRLdh3r7y1mclWr1IR6rlOCAgwN/50yBudcxT1mabI+LPNbCqfZM2+qLABPsHRjn8i1ezEW5z4fVTNUeORIMVC2yQybv8dFFYti94vhYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890935; c=relaxed/simple;
	bh=D167C/RHsLTI16g7rjfKOrOHe0Kjz3OBFXSWDP5Nuaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OB+lL0y3E0eeb7gky5jOZnzHgsJXjxbGgQJgNBp6/Kwm6SRDESrLUM7eaaqwKbwGUhzV23olGl1rmc5Bt3UXTkunzthQ8V2lNt6MQbmeQ0rufUDNdp16qOvV6TB00+B7QWAe7RbDUlDhr62012mkzD9Jun6YNz1vJzqb4+9T1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqL9g8cY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqL9g8cY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd21ffaca79so2165233666b.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890932; x=1780495732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwUYFbPIqqwZIiDmntvA5rfNiQ5P4q2eyAxyioD3Zw0=;
        b=SqL9g8cYSvcGj2jCTtPaw/kuT2DU6xOyJGRNLBvWo2mlFU/6KFTeTw1C2QIH3BwShg
         ivvpLXNv64PtaReRO6qep6KEx4Ww3NovRMQcx/DdidRkmqYOhGLz9T5vggmTDx1+dInU
         H+uzwqV5Jn9xuPvL0Mic2nyg+2PJzVd29qlA2grLAEl5Yw/gPpVTQTRs75UQLJiffgwb
         bxOKKwe/hhk1jXETrYaH+sPmOBsVgXI6tV/NTPpWyUd5f97WfMzdvVkPn6voxPcQpczU
         TRGmqzCklKFpgWLGursN24Sb5fvnu+oP62beQ6zlcUMdvly9pqeoJOYNJMAE1PcqJsd7
         ltHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890932; x=1780495732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZwUYFbPIqqwZIiDmntvA5rfNiQ5P4q2eyAxyioD3Zw0=;
        b=jJsIqEmyc1rtiqpNzXImqP8Z6ce+JxjKiTboKchhQtGNAjsyLobJOV55UeO/l1NQc4
         IwJWaDAncLMT1f86mR0DCb0aTDfy9rl+DMgUdCe53o4qZQQ0RD1qk8UgxJxqhJij8ufp
         q/Cl4BXHzPwGRix0DZhTVdU+gnIBVm+DuybjCSd0hPsuAo/iBYCgSS5nzTLagRbUptB2
         eeXAUSh1r5YJhsm02gsMzpTSAHOF44gk4mYUe2aR7qD7H2ZbbnSEKtqz3tmIhxdZopG2
         UnyCmD1M9aPL9RkFGl76STSQzT5GGmU2uYa4fbattn2Xpk/ucwHMJF6pB5aH8UlpYanQ
         Bm/w==
X-Gm-Message-State: AOJu0YyOBK6wGdRnGcGHmXxGdinhBxeiUbXR9KiJUv+sIw0ccw09Q0qf
	ltAAsWX/eAyy3t9wK1n6yFE+Olj4izEBLMwI5SexwsPTJoH8KVpEzGmq7pcGNQ==
X-Gm-Gg: Acq92OHA1tbiYFnsOYa+j4/3pC15tgx/Aobj1ODdAR4vdGnzn9ANli/a5jK5YCvDRTs
	wAC5tm7HbPbg0c+6zkKYxn/j9P21Woyct3FI+ZBNjoO44YZHKqCic09IDoBuz0sS13PedHbtIyu
	QQrNYAz2voD9Cc6U4v5J55aW+Vk/KTUX/0MFcP+95spPbtgzmRgjZvQDwzRCIVUadj7ekxhL9/l
	5MefhInc3hSWyD+JvILFAZaiAMJHg1frGERDmtjGToQdIjYitQOOopSm00jKiSLHQgNqFgB8gnZ
	0DXLTXsHfPQ4pL8/g7UvPZJDsUfX30cotcxRrWby2tp1NrM0XxvTekuKAzFMGXuAZaLDhpNdFGt
	ToPdEJkT4Nh7al/NNA5IxMapFVY7bxFwdtwayCQArL3DlYdVQcoJiZWcBJ6UgAqMExm6iu3hIrr
	GyjCrJRny9lq+AU0jw157Tus6NC/jSToXnQEn1cYVwo2etc0ggi/8VxK+DGocqSE9l1Dc1rQUSF
	jftEpPi2/XvmzA5DWhsVGFBxKk7x7qPhD/cOK30DHP5apBFyjhWt5tQChMx
X-Received: by 2002:a17:906:459a:b0:bd2:be3:572a with SMTP id a640c23a62f3a-bdd482f0eb4mr847444366b.6.1779890931489;
        Wed, 27 May 2026 07:08:51 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:50 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 8/8] doc: promisor: improve acceptFromServer entry
Date: Wed, 27 May 2026 16:08:20 +0200
Message-ID: <20260527140820.1438165-9-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260527140820.1438165-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
 <20260527140820.1438165-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The entry for the `promisor.acceptFromServer` in
"Documentation/config/promisor.adoc" has a number of issues:

- it's not clear if new remotes and URLs can be created,
- it looks like a big block of text,
- it's not easy to see all the options,
- it's not easy to see which option is the default one,
- for "knownName", it says "advertised by the client" instead of
  "advertised by the server",
- it doesn't refer to the new related `acceptFromServerUrl`
  option.

Let's address all these issues by rewording large parts of it
and using bullet points for the different options.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/promisor.adoc | 53 ++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index 455ce40be8..f07a2e883b 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -32,24 +32,41 @@ variable is set to "true", and the "name" and "url" fields are always
 advertised regardless of this setting.
 
 promisor.acceptFromServer::
-	If set to "all", a client will accept all the promisor remotes
-	a server might advertise using the "promisor-remote"
-	capability. If set to "knownName" the client will accept
-	promisor remotes which are already configured on the client
-	and have the same name as those advertised by the client. This
-	is not very secure, but could be used in a corporate setup
-	where servers and clients are trusted to not switch name and
-	URLs. If set to "knownUrl", the client will accept promisor
-	remotes which have both the same name and the same URL
-	configured on the client as the name and URL advertised by the
-	server. This is more secure than "all" or "knownName", so it
-	should be used if possible instead of those options. Default
-	is "none", which means no promisor remote advertised by a
-	server will be accepted. By accepting a promisor remote, the
-	client agrees that the server might omit objects that are
-	lazily fetchable from this promisor remote from its responses
-	to "fetch" and "clone" requests from the client. Name and URL
-	comparisons are case sensitive. See linkgit:gitprotocol-v2[5].
+	Controls which promisor remotes advertised by a server (using the
+	"promisor-remote" protocol capability) a client will accept. By
+	accepting a promisor remote, the client agrees that the server
+	might omit objects that are lazily fetchable from this promisor
+	remote from its responses to "fetch" and "clone" requests.
++
+Note that this option does not cause new remotes to be automatically
+created in the client's configuration. It only allows remotes which
+are somehow already configured to be trusted for the current
+operation, or their fields to be updated (if `promisor.storeFields` is
+set and the remote already exists locally). To allow Git to
+automatically create and persist new remotes from server
+advertisements, use `promisor.acceptFromServerUrl`.
++
+The available options are:
++
+* `none` (default): No promisor remote advertised by a server will be
+  accepted.
++
+* `knownUrl`: The client will accept promisor remotes that are already
+  configured on the client and have both the same name and the same URL
+  as advertised by the server. This is more secure than `all` or
+  `knownName`, and should be used if possible instead of those options.
++
+* `knownName`: The client will accept promisor remotes that are already
+  configured on the client and have the same name as those advertised
+  by the server. This is not very secure, but could be used in a corporate
+  setup where servers and clients are trusted to not switch names and URLs.
++
+* `all`: The client will accept all the promisor remotes a server might
+  advertise. This is the least secure option and should only be used in
+  fully trusted environments.
++
+Name and URL comparisons are case-sensitive. See linkgit:gitprotocol-v2[5]
+for protocol details.
 
 promisor.acceptFromServerUrl::
 	A glob pattern to specify which server-advertised URLs a
-- 
2.54.0.275.g96c817d129.dirty

