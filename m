Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2211ADFFB
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 20:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803285; cv=none; b=Hqc04hEnxuX1qO0HRIaXfjyaNzZKAeGFA5NtU3oKIR0rXhLpOzbqq9bEWF7KqQew+UROuzOUioWZFBHOhv+WA4SamjhXTc0v80dqaaEGo4yRsRVCGiV0qELh9Lhc5iw7ydBI9bCbgt8MgrYnwp4ph+pr1ezZgLejMPbtV6XTQ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803285; c=relaxed/simple;
	bh=yjyz+Vz840lW2No3gACSbRZE3MV5qia5BFfczHhmR5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+DIVTBZbco29yKyNVPdScQqOYXVBl8WvysVWNnIvkr26/Z8yU6gLcrOkA2tnQcwgdP5H/aQOAXwJ62DtDQ7VKqs+3hNJ++FWCmXZJ4vjYEQubKvz54fGGS9btvci5tSm2B5OnwomQumR9wdv2rWRMWUZac+KO5ihKxut2GN53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk8HsvLr; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk8HsvLr"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbceb48613so8664536d6.2
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729803282; x=1730408082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=Nk8HsvLrCKzadTpvDh1HiTzqymYCLgsiGdxcGS+eaYUEIAM0+G//tJJQd3MG6YURDb
         qKOJxhpwRdjvr+T/WCvdyDdB898635O5H5Bc4X2DY/WiVX75ArDnj4JhFScBdJzcxx5h
         J2m3bpvQA78/gYGjrc3ot+9IFPwCR8ZkkNR/j1yqe0wGlkD3oci8jMAEtKfFJ8yNzIs9
         I19MAJRSAdDhJoH/IRxIGImDwppIiybpxcL19gOgGoslLF1tEaVBNcGwLA+gojObNXHb
         BNjzDyz/l2ghZLkuY2phjnU52fIrWUiq0+n4RB1NzaO3umDa+2I0mM/54im5LUXwsAet
         axwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803282; x=1730408082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cpGIf3Q2e9lMZFbZTS9wWeKcb2Sr6a33QDERJUPy1w=;
        b=cOLNeg13aH0UjNlr7XWmsWqZ/WxorFIhSDve+Wye5T08CIAOU5tU6pH8NJ3Zcj7FgH
         moBXgOl04XBxa3VXyqEyLaImJ9PMwYiCk8LPgFwzWPtn5sokmX/f0Vi9DL9duVUFyHFB
         66zHv5zvCj6Aj5CPlllYowE2im3d45FAUamYBf7sEMUWtxniTBnTJyPMJHHkWedf/NLU
         ug98bx9VrhLj9+Gk52TpBCEGKlPLZawIe1PABfqtXDOOYQAZQqbXHVfhFreIXOyEICe1
         L+TWqykZfmgS8sjJj3HP2VmbMBHCWrf82+Pa2O7iJrp80vjscgGlR96G5yP0fYoPrFLf
         cxfA==
X-Gm-Message-State: AOJu0Yy3/zSwH5P6myFdAwvxXBBDKmwuxSLtau+h4eSLahsdXDonifYG
	U8XBFqFwcQCPC+LoVoUF92eyd4IWQUj3/qUucnUISOv5F9vs5WoxH7Sf7ESW
X-Google-Smtp-Source: AGHT+IHdh5wzn3WATvD9hZ/5dnleJvqNpTSMQTPdubD9rM1Q6AEo+tUbaXKnPBsk95CmuxYqtvqGEg==
X-Received: by 2002:a05:6214:318d:b0:6cb:20b6:f398 with SMTP id 6a1803df08f44-6ce341a479emr72932356d6.21.1729803282085;
        Thu, 24 Oct 2024 13:54:42 -0700 (PDT)
Received: from PeijianitLabMBP.home ([184.147.230.152])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008b951esm53421556d6.22.2024.10.24.13.54.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Oct 2024 13:54:41 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v4 3/6] serve: advertise object-info feature
Date: Thu, 24 Oct 2024 16:53:56 -0400
Message-ID: <20241024205359.16376-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024205359.16376-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241024205359.16376-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index d674764a25..c3d8098642 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.47.0

