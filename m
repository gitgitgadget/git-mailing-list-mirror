Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE563B19CD
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881023; cv=none; b=Gx3efJjSl13pDrc/j4MEGow6eCeOyqs0YvV1GU7zfTTfWDaNnTmdGQpZnsADHU9pp/luVz05dlDsM46q0JJymqywM5EaaZ1BIGDRk8icYBfEtzpRt5ddoE3WsKo4Pg8IpXRYZdybT5eFtOXfDjb4SouCCpdgmDgyAWI5aI2c7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881023; c=relaxed/simple;
	bh=f62EsdEPNQVwUF5wYtG52yVBWaV+IstMQ7Ww8cGc7OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0JrMYLZ4LXB7h5FnajRIbTITBDoEfZUrCf57w4b6QL3PAhi65DtT2L6IKwjCmvoEeut0eCGB/wFX7V3INSCOuqmoIf3TyVK+gEujX3kOvGlNtRZeW5LhMaur1DsKdcsRgnATI3G0+U/XXdqMMIbPbd3STrHtxLrqPWpAEy+VXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W61FyH58; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W61FyH58"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso14913185e9.3
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781881021; x=1782485821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3v/SfigXrEZaFnqWWaSZ2dI2i2jGUaGemExufyYqqU=;
        b=W61FyH58qk+1j816j1IQdDpZW+ga9ejn2uhZzOmImo43qOUNUp/BeHWWlbaNpNkprA
         I8a7ItihLhyEkxice4U4UlPWA8t++VBTnxEH3L4ohsyRC7dKd/a2XJr3zealYUZtfic8
         IwZn+bPgbDPNPuQGGTD6wUgSZKPbipvP5HPan5UAB3/hJ3FmG8rE3NjVRDXxj0ogDBjr
         Nj70vVRWRMgAPx43/RIDNVpi9HgLjpCM4lVYSOMr1nJUgUvgP+BnPuHCgvUh4CxrfBGA
         WmCNSlRTE+y7PkguZcUDamuHUyQPhwd9oI27Cbq0iBufWZQce9nXMuAt1rli6C+HKDl2
         8ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781881021; x=1782485821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3v/SfigXrEZaFnqWWaSZ2dI2i2jGUaGemExufyYqqU=;
        b=NxxTidUGLf35c7iRM4uMu1Fj+krmA6ueBc0W2CBqR4oeZihzmM4wV4J5H1ag4FV8ih
         X+pfDDJ+pjF87GobOpNc7x1s3lOLqKIF+0N8V+L4a7iPSHbuPHUxojvJ8qRBhnQHMEn8
         ryBejpficCfXDt3Bl2rrHgDQncZYw18qz2smhYuxPcCUYt3l3kDlVmrrH+rqwUgm27OG
         q+0IjVZTCJMlaBAjnec4GWSYpsjQJGPGIohuZEumhsNSGnuaSyW0p9r2btgNnlTiHyGj
         oeAwSLJROZmuJ6iOqUWePp5cw9TtZqahTw99rd+q1R09NvLjMEZlbB3UO5EhfvyraWyj
         LysQ==
X-Forwarded-Encrypted: i=1; AFNElJ+berYKmT0dF675xkv/MKpI8VKyO8taVdxROzAiekB92oWfmv2kEkpQQIg6pVuKjarAIkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzce1UqQAosEYBy5fzsCKD7iyrEmmxx1N/i4Gt1mfGqnFqnGqW/
	z3nxF9ZWHMflPJCQ++fnqns6EPHHZYuIfLLLGqJzilm/n1rof2B8rcsJ
X-Gm-Gg: AfdE7cmJwSmTDAh1h1H354BDen7C4V4mFtciNwYLHtaHcNer7b68xXgYyMkfP7Crzcl
	0h1bv06V2Eu6m/hJ2e+Cs3rWXHeajnNBIZhUFO+obPwEJLLL+9BfoXQ680kUKvp/b/+jJBevPhv
	H2NZiD8LM9f4HZtUantxJ17+bZN+1Nlxgp7oGfbJgYx2xetxcz65lSCA3e6OPlWPokvwxmAVYLM
	p8+TyYw3pg+7JgyjhLfMziyoy4TBJjxxVRk/ygZHhllfyDR/3McU4rdf5XFd/VC7XhxowBEyBuy
	/BzSjuzsWE8eEWlF4OTCphZ51M3XYZ2llL0+RGJ5Mhgk0nvCLsFJ2QCX6jHUfVOFE5JN8GZ7ubD
	VxuU3ImSKypStTN9LKdTgCFKXRzrDHAPFdjMFD1ujAtjP/LO4or6kh06aLq+XI0wQ0QSKsAX4SY
	acDXV73ZaX/X3wpFc9rzYiA77q2fJYQNFwqlS0ucW8hcEbz8OAjZabcT1P9ia5645Dh6Jv4udRH
	oALZx1kTySKE1+bOrvdOue1IwC2hdopePhC1dpGWgtx7Jth1tFdb9ykWhO+Jzy9z47yQeey7EgN
	5SELXGDSCaPA+3veAW8OPENo7NevdQ+ruCCagtv/56vjxSC7l82SRJzFRNMTOpDiN8BxD51jZ/M
	9rkNIKrIEdL8wHw==
X-Received: by 2002:a05:600c:e556:10b0:490:e1a6:25d with SMTP id 5b1f17b1804b1-49240e9cb82mr44018905e9.26.1781881020786;
        Fri, 19 Jun 2026 07:57:00 -0700 (PDT)
Received: from localhost.localdomain (static-204-100-6-89.ipcom.comunitel.net. [89.6.100.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc63fsm39430795e9.1.2026.06.19.07.56.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jun 2026 07:57:00 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: gitster@pobox.com
Cc: peff@peff.net,
	eric.peijian@gmail.com,
	chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	chandrapratap3519@gmail.com,
	Calvin Wan <calvinwan@google.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC RFC v13 08/12] serve: advertise object-info feature
Date: Fri, 19 Jun 2026 16:56:37 +0200
Message-ID: <20260619-ps-eric-work-rebase-v13-8-3d4c7315d2f8@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
 <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 serve.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 49a6e39b1d..2b07d922b3 100644
--- a/serve.c
+++ b/serve.c
@@ -89,7 +89,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -97,6 +97,9 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	/* Currently only size is supported */
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 

-- 
2.54.0
