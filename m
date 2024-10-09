Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC01537D7
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467942; cv=none; b=sFXu4dLbiINA5KqxED8R5+OJzqagKhO8eV3NmpnmbUX2+/RbM2ZURZw98ArjGn/a9ScgFUS1JACFepegeKUeHdQVsh+/X/nCg9lU2OgAvP78FcYqM/DJ18SRrbCq7hxp6qc4HE2FJfrD4touQy1CQjoEtaZ8SKBN45Qg/YPoqQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467942; c=relaxed/simple;
	bh=eiN/CuenYFIau6VrZPFzQ+Lr/wf7DVm9kZs7FfdT2VI=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=gqVTPaFotF3VZxbHoglq+c/sDcg5KxbjANwQdC5Q3I9Zbv9M6Zfca/fPlzbl/24sglgwWGAgXCXewXVKNKQfZ9e2cT05ZIelRVxvxkf6boqDJrz+rP0iIqC6rm61nOk7pqV3TsIul2p1zqDA87r0ex1QoFJ1FSecpCQK/ougJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBgnbmp6; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBgnbmp6"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fc00f455bso106992241.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 02:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728467940; x=1729072740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xE28QM6o9Z165H9oji7v8kJm0gL72KqS6xXZ1hvHgxo=;
        b=DBgnbmp65bZQMCruo8sWxyEW2PDh/pDEvWgFCNCKrMS+XBIETLDaN8Zur0QrK2drVK
         t3zc1rLj8KT+MH4/X3CUqA+4cc7s9jvsrERC/6M0mceXHpriaFgBJO8L2FBnbEWQ9NjH
         HYnCJm7kz5xt7bAYk26DV1BCq5HiQ3OLCMlxdRA5K0ZZzVqjQrmN0bPJMuxjBtD56QJc
         2/cKreQzrWuzC8xWg0U7DK97TtMwQM7oiFf0q4FLz1Q6wswPooyTAdBeoc58XXnpwpYx
         Pfnfu4YM5PRaINylDdPJSxZLukknFp77RgP0YjDwFrBFi15BYM+MLAD4TQszOv+aFR3T
         AncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728467940; x=1729072740;
        h=cc:to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xE28QM6o9Z165H9oji7v8kJm0gL72KqS6xXZ1hvHgxo=;
        b=vUXZ/FugtQBOyy9TMEOn0OUFntNwDi8nwbtqRwibxMEcmwV4fNyvAVIM1EywTalvxq
         hqaFHGCysgeoFne69lJFWtg+f3bZ3Ry/JzbYpY2KEw93agqDPGv5R/8+n3lxtqZVrVDm
         NreOSCKdoCaspqj+r1alH4UNaOYsX8wtMv31D/HGbRbw1wRFSm3dZDUBbP/A0VZkBbo0
         aN/m+6BFxHZ+gCKfnyKPzY240+kQFMDT8nzQTnu4zRl6UJ1OYeDuyLPnRadBHKNl2eiP
         hBIqXvVwvV4w3GLxDpJIgSGru1t6QgPECLKmqrLE+KuZ4thjHTL6Zlf+E/lxKx5cC7Bd
         9KUA==
X-Gm-Message-State: AOJu0YwCVn3uytIo+0CyoggOYXmwaSWIjH2PNrHBpV3IeT5VSP72vvkq
	ep8Fn6e2hzMTjuHa97+bBLG+6ftTtNB2OcYZThCouT0TRRhRawNFH/A4B6YiFvo4g9VTzt6GLzp
	JmEzMLteFkdbZdoTOysHLbMLeoLlTEDC4
X-Google-Smtp-Source: AGHT+IEXBHP2/LkFIvAhpLLbtA44cDu7+Hd0r+UGFzxTcddRVb8+0YLgwUfyIN0UMqmg2rHC9pLrfUzueG7vQYJkrUU=
X-Received: by 2002:a05:6102:34d9:b0:49b:cfbc:63ac with SMTP id
 ada2fe7eead31-4a448d15cbcmr880905137.6.1728467939976; Wed, 09 Oct 2024
 02:58:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Oct 2024 02:58:59 -0700
From: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Oct 2024 02:58:59 -0700
Message-ID: <CAOLa=ZRMaw-PAsZ9s0zJ2zp_suMppi=ZrT67B__LU1tWZSvuUQ@mail.gmail.com>
Subject: [PATCH] loose: don't rely on repository global state
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"

In `loose.c`, we rely on the global variable `the_hash_algo`. As such we
have guarded the file with the 'USE_THE_REPOSITORY_VARIABLE' definition.
Let's derive the hash algorithm from the available repository variable
and remove this guard. This brings us one step closer to removing the
global 'the_repository' variable.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 loose.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/loose.c b/loose.c
index 6d6a41b7e5..897ba389da 100644
--- a/loose.c
+++ b/loose.c
@@ -1,10 +1,9 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "hash.h"
 #include "path.h"
 #include "object-store.h"
 #include "hex.h"
+#include "repository.h"
 #include "wrapper.h"
 #include "gettext.h"
 #include "loose.h"
@@ -142,8 +141,8 @@ int repo_write_loose_object_map(struct repository *repo)

 	for (; iter != kh_end(map); iter++) {
 		if (kh_exist(map, iter)) {
-			if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
-			    oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
+			if (oideq(&kh_key(map, iter), repo->hash_algo->empty_tree) ||
+			    oideq(&kh_key(map, iter), repo->hash_algo->empty_blob))
 				continue;
 			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)),
oid_to_hex(kh_value(map, iter)));
 			if (write_in_full(fd, buf.buf, buf.len) < 0)
-- 
2.46.2
