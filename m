Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5161990D6
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750561; cv=none; b=AierVtRT+r/9GHNZo7xNe6qVnETZLa4Ks9V2coRLSn7lhhRl1iYujuCDFDYXpg9TE+UwOR1Gj96PAIRm/SinE57QH9rMck0owVSaIJQoftTiZDhjW9sp1DeVBtX7cnui0GgaUNsCkPMjEbpUotzXPvELbNdwCpLWUweNshAhFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750561; c=relaxed/simple;
	bh=W9pg0sU7KWpARDNhpNxbQjueZfSjMagxglG9BIOokHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYZKTgC+T1ycHiYw1bhWuOHYhAdvlsPE5p3PdQKLPNc5yekOibEAY9yKZNdfXmx97/vCv4AJQO8W12HFrQsttx9GFoaoYCoRXN8nW++jGF8rLkrlhlEP+MW1XDopTFFjvjM4foj8/MjU0fLbYZVmLSFoDqHCxO0q1USMj/epOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf50rGOL; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf50rGOL"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2973b53ec02so212268fac.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732750559; x=1733355359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xMxNdiuzrCvyzA276JFbhHsFz96hQOkPZvUXzScSV4E=;
        b=Uf50rGOLGuA3hEg0rJ5M+0UegdYRF+owkxMJLXCZP6Pe1YTt3PGSLVD9spu76GWImX
         CBQFoXPKgeMoaYQhGeyif1pyXBSKQHqk0Ftqmh7pbdR9o+T5do2pbJ5nEQmBOVj+URls
         Tw2NhP4slE8S/kZxRFcIygWzZ0w0vwS8O8VFI9N18PNXVBgsopNjavUfakDOJ7kZwV5x
         9IvEEoRvSZSE8jARx9VbrsEN/7rWtd1QfktBnQdXP7DIwu2F+DJg1Swh393/xgie2X7C
         vKnjXrVFFTw6vHznaJoFNOTLvYuxb2oxEnVLzaUnGPSbzPvGWD6Wlvct9vjHi9vBaz2Z
         hHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750559; x=1733355359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMxNdiuzrCvyzA276JFbhHsFz96hQOkPZvUXzScSV4E=;
        b=GSqm8+f2pUliM2187p3JAd6anmrUTX9j3MoxtmcrvJwcHU2lQ1LDICQFm8i2YrAQop
         IWfjVJYZANQBhHSIBzF6+bRwr6EMiNdevxhgMXT4lseIf++W1HC0VYP6J2V0JBTucPJ+
         +VsjiDf1/zg90kcmtrexAU7qO2REV/ThVR6mIjZqQAsZU8Y23Nwt4ZRE/KcbX/vwYfBN
         a91Ig7swQAyFyGLeEhH5jo4U+GVZ3AqmFjfBT9Ilf8B+Zgs3IweMhvbyTUuKcOdNuBcW
         NyOpJqH6dD1Lm99SipAbijP9YgVVDrpnP/aIcmGvwmqRRA2555sQJV15lJmAG+jqHipk
         wa4A==
X-Gm-Message-State: AOJu0Yx9LjPHCvffNifotcJ3KR6lOk2Lu+z7r6fNw0Dkp23zsnY7TBSZ
	0Ir1Ni08/dhpfMzq9y8CcDX7lyBb5F7wbNF+doWCJBs3oJNMXAZ6LZ777Q==
X-Gm-Gg: ASbGncvWtX/oqHHvQoBP58irKqM8p9dO6T/y+SGEJJ+ljce4PBaplt3K9v5DIn0eXJ9
	6Id6EkRVaY93t8YdEf3DMD6v/iSaGOlTnEqSGdrBKzzAHh0vOozUUns8zRHVvKt114OwXRlIU3/
	J5SDbT73lLf6jP3vSz9LSz+XV6ryjY92XOBsk3peqIGJL9wuzvwbAEWEqWj14xVcF0pVqinx5gu
	bgKSnpNCRZPo/D0W6F1V8zvZQFIHS6Qtnq+IwS1qa3lRvUXylABLNitWw==
X-Google-Smtp-Source: AGHT+IGaqVDiDTgyYgpoHvavgOTZgrs6kADhCNwnXU4bkNvgPSpzFXE3Y5/f2UltLlRJyShrWVrLsg==
X-Received: by 2002:a05:6870:4f14:b0:27c:a414:b907 with SMTP id 586e51a60fabf-29dc4305152mr4622962fac.33.1732750558864;
        Wed, 27 Nov 2024 15:35:58 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f31cefsm109260fac.2.2024.11.27.15.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:35:58 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/4] transport: propagate fsck configuration during bundle fetch
Date: Wed, 27 Nov 2024 17:33:12 -0600
Message-ID: <20241127233312.27710-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127233312.27710-1-jltobler@gmail.com>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fetching directly from a bundle, fsck message severity
configuration is not propagated to the underlying git-index-pack(1). It
is only capable of enabling or disabling fsck checks entirely. This does
not align with the fsck behavior for fetches through git-fetch-pack(1).

Use the fsck config parsing from fetch-pack to populate fsck message
severity configuration and wire it through to `unbundle()` to enable the
same fsck verification as done through fetch-pack.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t5607-clone-bundle.sh |  7 +++++++
 transport.c             | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 7ceaa8194d..c69aa88eae 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -171,6 +171,13 @@ test_expect_success 'clone bundle with different fsckObjects configurations' '
 
 	test_must_fail git -c transfer.fsckObjects=true \
 		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
+	test_grep "missingEmail" err &&
+
+	git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=ignore \
+		clone bundle-fsck/bad.bundle bundle-fsck-ignore &&
+
+	test_must_fail git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=error \
+		clone bundle-fsck/bad.bundle bundle-fsck-error 2>err &&
 	test_grep "missingEmail" err
 '
 
diff --git a/transport.c b/transport.c
index 8536b14181..6966df51a8 100644
--- a/transport.c
+++ b/transport.c
@@ -19,6 +19,7 @@
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "oid-array.h"
 #include "sigchain.h"
@@ -172,6 +173,19 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	return result;
 }
 
+static int fetch_fsck_config_cb(const char *var, const char *value,
+				const struct config_context *ctx UNUSED, void *cb)
+{
+	struct strbuf *msg_types = cb;
+	int ret;
+
+	ret = fetch_pack_fsck_config(var, value, msg_types);
+	if (ret > 0)
+		return 0;
+
+	return ret;
+}
+
 static int fetch_refs_from_bundle(struct transport *transport,
 				  int nr_heads UNUSED,
 				  struct ref **to_fetch UNUSED)
@@ -181,6 +195,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	};
 	struct bundle_transport_data *data = transport->data;
 	struct strvec extra_index_pack_args = STRVEC_INIT;
+	struct strbuf msg_types = STRBUF_INIT;
 	int ret;
 
 	if (transport->progress)
@@ -188,11 +203,16 @@ static int fetch_refs_from_bundle(struct transport *transport,
 
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle_inner(transport);
+
+	git_config(fetch_fsck_config_cb, &msg_types);
+	opts.fsck_msg_types = msg_types.buf;
+
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args, &opts);
 	transport->hash_algo = data->header.hash_algo;
 
 	strvec_clear(&extra_index_pack_args);
+	strbuf_release(&msg_types);
 	return ret;
 }
 
-- 
2.47.0

