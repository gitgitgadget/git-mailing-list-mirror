Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712A3DFC6F
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933651; cv=none; b=GdriQt1JYhl7QZrBsjh20F07pw8ZcKzBCoIm4lcdsazKdgYHIokOgiiHJN8f1wco7vTTP3mvRvtXgh382QGoELmxIMtXGidn80YFcnxSphzOXdw5xUbzxpgY6d+rtHUyNlDwwjATeQg2Ut26jPaYS07Jf4ERRwVdJhzOhjxGHbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933651; c=relaxed/simple;
	bh=gRXkcHuKcLwlfetmN2GLzrwhyBodZ+PDTggZu+d1hR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBKvNgQcgtLCt0AwtQUcFtRvJJUR0vNsHMf+v9szfcZn6b2J6dpI3hc68hwn5EvCD0lCjOIiHA6XwyvpWPK0+flPJmxBREiELjwm2yNWTePrhbpS7PRTeVF7G77hlDRLEp48YqT6iiHAbjg03sw6nkm+kD2cEPT8KptvGe1rW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJbzJMPY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJbzJMPY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso26615195e9.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776933649; x=1777538449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOHFa7AoaSrfeqn4/kyvAjUitu1JlBUIz7FK3I+X5bk=;
        b=iJbzJMPY3mUrtIgukxuYEEcWx007nE4LFJzz8ln+OFHs9ESy0HvY/90XRm7Q3xXR1S
         F9DWzYkBsVHT4Bg1/Al4TTlj+GKslWsYIGqt7DoYVBBbplpM0bmrBwyFCf7h8u8y/4gl
         Jbgsp0z48xykOCUzk666YtOjRQrKFZ3lyfv74mOtIpIcvKl58CB1wGCmkRGfkRez+378
         sR7iDoMOvoPHrmDNd1UfJeeaNgQOwpcPItVUme+xZc+iOAqKyRL7YUgEddsLMyTBQ7t+
         cYFQ/sg3eEdrl2f3BcfA3WfXU1Nt++WQGcJAeF0FDOwamcjF3M52PPGtiQuwfKQaYBhM
         vD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933649; x=1777538449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kOHFa7AoaSrfeqn4/kyvAjUitu1JlBUIz7FK3I+X5bk=;
        b=FQs+1l28XmKD7RVX+c9AvWGHzlLTsSMJrcMC+aUv3M/A7WzUpUGczUa8SHLm3sL/A2
         idcEZTmI9ErCwkY5tTpnmrtoRuqG8ip4mwWcmShuff6ruQMRCKj3I+FY5c7WITjgwH/o
         isWC+pgvPk5KhHhLbwlb3ULI0HduKvW1t1xfM99wtQKsSBoEHnNQpH1XxvLFwcHlkuHO
         QPDlE3AY9XO7so9hh8LMQrmm+bsbiC1MrVLV/pmb/GRkXvC36YbNVktn4275VboxtHPp
         M5zAjJm98VVUvjCgbpwxgJFYARUOtgRHIhiOx/roVwQddHMJ2whbiQFMsTUaix4JOtec
         e7vQ==
X-Gm-Message-State: AOJu0Yx2UBF+FY80OkPiKMuYvQFRfTj31CiC4pM18VjwlTjp6kuIkftu
	8Dcb8Pnvdztj0X9uRjrj/K/G8rxu6WbmzcSY7t/yVec6CLy25xa9ws3A2TUkLw==
X-Gm-Gg: AeBDievacfAUhX+kzYxmc5bZUlK/TYv0sn0wjg3rPyNVPDEXsbMtvEJaEKAvyjBaLX0
	QEkL0WrNUXmzbtiC5UdFtiPeLpgcyvdF7F0Dn9+RrgRyhSIMlEqO4GZ/2g6pXmuk8N5lWHHBjqQ
	dIhd/d69gQ4cYkIMH7MkfZ0v7S4E/4Lj4uhDOipGq/SiMqv5LZgT3vTb/6X769vVWnEQeoUpCpY
	TnSEiXzuB2NteLdDHR6nDvFFRQWqNcqJfvYWfQzjqT0/46VSLfFcDnYJMFZXGr2Rt2D7wiuP4ux
	B0rkGoacW4h2i0kn3HPnNJiz2F9pKa2+E7XUEThLPyajJQ+noCEKv3GPti6bbnryqDP5AQy8CQW
	cQUgOgq6XG2meT7kICCMdizJUxvYxTNjokYJtrb5mNNVtvv1lW7Y4PbyX1u0f1FsmAWjxOEL1CW
	sgn5NeJUJ6hUhSE4jutJ89XBA/qmzsxgdTYdD2QqnM
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5d with SMTP id 5b1f17b1804b1-48a55743e96mr157762275e9.7.1776933648504;
        Thu, 23 Apr 2026 01:40:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1cda:f096:cc8c:a0e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489fec8f7cbsm234286785e9.11.2026.04.23.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:40:47 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 23 Apr 2026 10:40:38 +0200
Subject: [PATCH v2 9/9] refs: use peeled tag values in reference backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-refs-move-to-generic-layer-v2-9-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2493; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=gRXkcHuKcLwlfetmN2GLzrwhyBodZ+PDTggZu+d1hR8=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGnp2wXEZYJOGNPod1BggDNpdBUuzpP2UgaNS
 /j2Ih4B2Xfa5okBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJp6dsFAAoJED7VnySO
 Rox/Zd0L/12r36ixlFlzIiwLEY79LcQUw7kyjmSTi3Fx4XWQydDQQmq7CDSh3oCy6RTYlAY/IzW
 zE0+VChwNj3860L/5KcoMyn441j8vRWgWjtYw9Iu0IdddI1OvHTRGG759neSXeDKJnKwAqdHn64
 fFxgNbEAPnke89NsGV9RLPyh6rW19GCesKXc8yP1HZbRVwDHP/epYk9UFOw6zD536xE7+y4ByZ1
 JlV2e8W1kYYaADrq8e99DpfV6cpbQ2zXA+shbZ85GZbP72EISVSE18xRcRoaV+HR7I9Yz9CRffy
 pqFLqU9EbA0MfTdGYnXvN4qUdG7NViN63Qj94RwhDwhtLXdLRXlTmFBPdS6K8MhzCaZju5Qo/R5
 kKstpvzrabXCJCRWXZkXJOhLS+x17KpoL3Vsr/0Feb8gEuPOyLhmbnEAZbH8pcnqkdHSRkXC6w8
 rly1weLn0p1fw8yiJw36IFqtvUeD+Tlw6P6c7aE8UjNWflZyoHRvUSh/FPIymNdNfvc302t7nJ3
 w4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference backends peel tag objects when storing references to them.
This is to provide optimized reads which avoids hitting the odb. The
previous commits ensures that the peeled value is now propagated via the
generic layer. So modify the packed and reftable backend to directly use
this value instead of calling `peel_object()` independently.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/packed-backend.c   | 6 ++----
 refs/reftable-backend.c | 9 ++-------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 35a0f32e1c..0acde48c45 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1531,13 +1531,11 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
 			 */
 			i++;
 		} else {
-			struct object_id peeled;
-			int peel_error = peel_object(refs->base.repo, &update->new_oid,
-						     &peeled, PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE);
+			bool peeled = update->flags & REF_HAVE_PEELED;
 
 			if (write_packed_entry(out, update->refname,
 					       &update->new_oid,
-					       peel_error ? NULL : &peeled))
+					       peeled ? &update->peeled : NULL))
 				goto write_error;
 
 			i++;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index b0c010387d..8b4ac2e618 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -12,7 +12,6 @@
 #include "../hex.h"
 #include "../ident.h"
 #include "../iterator.h"
-#include "../object.h"
 #include "../parse.h"
 #include "../path.h"
 #include "../refs.h"
@@ -1584,17 +1583,13 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
 				goto done;
 		} else if (u->flags & REF_HAVE_NEW) {
 			struct reftable_ref_record ref = {0};
-			struct object_id peeled;
-			int peel_error;
 
 			ref.refname = (char *)u->refname;
 			ref.update_index = ts;
 
-			peel_error = peel_object(arg->refs->base.repo, &u->new_oid, &peeled,
-						 PEEL_OBJECT_VERIFY_TAGGED_OBJECT_TYPE);
-			if (!peel_error) {
+			if (u->flags & REF_HAVE_PEELED) {
 				ref.value_type = REFTABLE_REF_VAL2;
-				memcpy(ref.value.val2.target_value, peeled.hash, GIT_MAX_RAWSZ);
+				memcpy(ref.value.val2.target_value, u->peeled.hash, GIT_MAX_RAWSZ);
 				memcpy(ref.value.val2.value, u->new_oid.hash, GIT_MAX_RAWSZ);
 			} else if (!is_null_oid(&u->new_oid)) {
 				ref.value_type = REFTABLE_REF_VAL1;

-- 
2.53.GIT

