Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125D4519A6
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837868; cv=none; b=d319xwzyybFFYuC8Bxnxu8jbKaYh2eLUAg94h3AuAhMvrvn0vrCBGkmiAlIyFZMZlrMi6SDNXOUPJt3TdlYi62+EZ+wfYMKqxdNBMAvMEcKMB5QILdt2klYZqKDH+sYTQS1xfNPKKrlX4H5OePlOMSdpwYbYrVg5HVlMM5gu93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837868; c=relaxed/simple;
	bh=yvouIdFrzfWrFcid/+JM2pl28pYjt8WUDDZCqXgq/zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuZfx3EoKuFKAnZyYd1U0TKYX92wlKleOVXf/PvVAgKVOPtudlQK2oXATlB3j8kgQOQjRQiRsBAakqTZh5k52RuKEtxp1ivNDhj1Nt0a1ucjVYFrON2CXtwriKhcPLPmnYCb4B6mdMasdniN8JYCCH//Pc3h50tofbxqVpGsX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYEWe1Mt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYEWe1Mt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49558ce01afso23680055e9.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837865; x=1786442665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCQiplAntFibH2OMo99vhE3BwbvlfePs5TqvhawpBxs=;
        b=OYEWe1Mtn9Xs805+V7mhwRNCYbjaI05G8sbT5GV7QZCcyqp4AAXlJahXDcBR3ue0hy
         cDUuRF0kjnUr9f4P+L/cNVnFgoKXuADqHhOB7BbllDIHQ2Nwy3xoNgRqIkmQPMIL18F+
         xtuJn03fJVnUC33bSpkJjIhY41qpx+UggwtS+OF4PLfApwoTh8fQ3XfIKac22JzEaUdJ
         +3PG5L5HE+s5Nur5G/RDAMAPj4K/LEHJ9XyWR/75+6le8xQwoSh0vM3/zBYP+SdKP/8l
         YTeabgGi+TYQE/x6YN45/DQAgiaR85/2rf+LkjLjVtDFk5YIONWo2IxAjcYqenv4CQ4U
         fX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837865; x=1786442665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCQiplAntFibH2OMo99vhE3BwbvlfePs5TqvhawpBxs=;
        b=mecDPyUBvTMG01nCgMagBVN6oK60rvmmkCvPb7qMBWBk7Bq0NNC2PYEZK+HSk+ZdHi
         8ihCf4Fg7KGelfRAp+jlKlBdmwFvqb9BqNdA/1ftQY0kG2MwlIxS7BmW8sTA+m0CG9oj
         CWVGnfXD1AkDV2wSq0F9UL5fr9UJMh7I4V3vZCte6w9HGbfkJHjH43dGTRkpGSabz2ki
         lUd5lL8tZBMajEU4Dw/byA3ZyyzPB0kffqNlk/95DFOySErALZV4z/Q99xm/jxJZU7q9
         8qXLO8n2Epg97kt6ZecJwyap3O3s8gtRXt5UM0P1R7LCAumv+Yt+RIv4CCn5TMM9croH
         WkNg==
X-Gm-Message-State: AOJu0YzR1bVlNg1MX7yefKfVCDlJuqJplyIKzNK4g8pzevS+nQ4+vjte
	CM0MSQlYmrViMWntJrebm/QjrRB2CQ+CgBIpLRPtlAxrn/WnR078n9tBWiaL2A==
X-Gm-Gg: AR+sD10i4HwaB371FcDMIkeA9H5YWs30xm/JsXc8V7FifyiFHjFrDhJ/Ahh2pgGFdCz
	5qkW85OF3gSZyGZIawCFtOhnzyPTasikKwUj3hFV17zv6yypidiRa+qQdfl+p/syRAj0AeN9gt4
	/0ojqCEUcQEKj9xImHa3HhE1bZVq+AqzO/526L9wmj7IOPazDzVFvm4TmaBDNajlSvkAf0KH6pc
	GDTefXKdm73fKTYjNzCMAmQ2/oYcGb6vjey3J2RGUt8RcAclxGrOa2K9VcQnFpjGJmYEzLDliPn
	BMBHX/jpprB4gzUk4tCs4tWXTMbB9hTk8bSFr9OlO7QRH47Gtnlhf3VpH6tyf9bsU+j/R2JHNCo
	WGHufx8QEVfa/i/8RrVNWXQAMrCoLAcdqDjuD6PUHvDbpcX+Bii/cg8NUoCRho0/Yr4gGJfe7LX
	FrVs78GppxbmqvBSBE/cUTm2ampTivBgFo4H3e+nV6FEhZglALMacCAhnaQJ8IFX5DrUyxzfHwF
	pHpqSEhADHpOiAv+PQ3h3C7INqXHVaOIpgQ1VkReYNzDkMLuLDYU/dcdOBBQ7AsGOE4GaP2eIv+
X-Received: by 2002:a05:600c:3045:b0:495:7a5a:d96c with SMTP id 5b1f17b1804b1-4980c696b4amr199239845e9.18.1785837864878;
        Tue, 04 Aug 2026 03:04:24 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:24 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 05/12] fast-import: use int for some bool flags
Date: Tue,  4 Aug 2026 12:03:48 +0200
Message-ID: <20260804100355.1299498-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `show_stats` and `quiet` flags are meant to be parsed and used as
boolean flags.

To easily parse them using OPT_BOOL in a following commit, let's change
their type from 'unsigned int' to just 'int'.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9fc9ebe65a..9c8edd7c89 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -182,8 +182,8 @@ static unsigned long branch_count;
 static unsigned long branch_load_count;
 static int failure;
 static FILE *pack_edges;
-static unsigned int show_stats = 1;
-static unsigned int quiet;
+static int show_stats = 1;
+static int quiet;
 static int global_argc;
 static const char **global_argv;
 static const char *global_prefix;
-- 
2.55.0.492.g44bba30fd7.dirty

