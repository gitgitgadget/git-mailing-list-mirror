Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3F3EAC87
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300745; cv=none; b=pgsX6kg+ja+t+ly34polb7oaJPIlAhIsplb660Jf2mySej0VO00CxLHTrJ42Id66JX+Y4w5u7ghQrYI2NuC5e56E5X6sHZQ9MffI4Iseh9AeTgc8qg1F+yfP5kR18UDdBYVN/oYQFTzLjljMKDEmnfeMY/c8VIVO8GVcuz/Ed6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300745; c=relaxed/simple;
	bh=GbkvRiq/8qyCcJ/ZHcU+l8QA4kHGzwxGXCDfJ9prDIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lylh8U773Uxh+klboUNDcBXl7HkY9GcPTrCmhD/TM11coMcAn2xf+Jxy158+PmU+45W7NDLmR0x691XMXRpnq1onBGOgSQgsrZso/IqSNjG6DcY8ckIKngv24QtEvpa65rUirD1KHIyTDsFGUEt/qM48KQRj07LKU9LzWwjxUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/O3J8b4; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/O3J8b4"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f633e6058so617567f8f.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300737; x=1784905537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FpzHWjscMlbdM2ZVZLQ9Cg5t1K3bpS9jZA3eSOHImxI=;
        b=Y/O3J8b4BApr3ZQI/Kr0aRZ7q0nS12APCrAVaCvgX+NWr+qydw9l7/MNv2RUChvSsi
         6xgyjrcCej6D4mXq/qFEUk1Pkda2cSMuu3uirNV1QMQYueDuL0qj5BGZTALh8f824VAm
         a0dnsITdhRoOqoeJRDVyNaiTj1ufEt7kdNQaEf+e8f3rb1zSo6DHta/rD7ah330JAN/z
         lvyPVohby/rqw/Dd7Z+l1SVrXzp6kNt9/z7nHEZmVM/1OspxBjedD+zsAkC69gx+IjLi
         a/PFpqEgcUDQx6Cl7rKGSUQEPepz47O+0rrtThuve4byhTPYmOmTTYCEh7lbhfBj5qnq
         4Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300737; x=1784905537;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpzHWjscMlbdM2ZVZLQ9Cg5t1K3bpS9jZA3eSOHImxI=;
        b=WdN2u5IFhMeraNv1Wz9FSVAU2mOTm6ERS37jKVeeDO2tiit8W+PnlmzCahyw+gdqhR
         tDUXOPiXfJIWZvuYTCBRtrtcMhPP9Xjp6n8Hm6/kCeWtsRUbiQZsS1LCi/4qbvFNoHWo
         P9/MdbAuovdJ6tU+lnFvU4VNdnsxEIZWJdQOV5xEhlRJFKRaTXQeoEbcnhJFOm6tnHW3
         z3B//O1kxvqVKbASjR6sYJTLEnB3ocYRphvk3WzQEzkUye5nTw96iiO+c9ZxRJ0Y8hTm
         x7JgwppLcXUCCfNjFqPIYDzdngkxbE1Ngq9J6cWoNS6wWfCn9FEA+IT7SB1C5d1GnLsw
         ub9A==
X-Gm-Message-State: AOJu0YzmlyJQZ5XsNIytj4MChPsaIip9sHKPPOOWs8AWS2ZT4qUX7X4B
	AGYtj6b57JhuZMRbT1kRPjLZ8C3DPAQmr8ox+C0R85CYgwq3xZCPtL86ujn0Mmqs
X-Gm-Gg: AfdE7clYFmBLFcxQIbS8DtPdhZzsKruXuZWUfBnYr/qgBWAEwOQSe27v/v16mqFKyap
	SwPBo3/JIbSf4l+D1mOWNO1CMDc6oNRqM1abKW8WB85H1/yZI1KFV3zdg2RNxE34kdElCqGmzyi
	gvReCXVAeJPrc8wjo3Uk/TQW6qyU+MVHNa5EOeuSgJNSeDZBu73chBSz3yuA0lz4YrAgFM7jrRa
	BrmJtmcPYlZniFM+LKec6T+qpTtu/uqn1A7Q0xB8CgIgUhgTbyyX13rFrSi3a47JNbuOg2FshXA
	o4Q/8ylGTCxp9OWLnbidApt/LxjqddeA6BOD8EUmrnhEuYcpT6U20PLNCYaBdlj0lX5Hz5si06o
	PD/5UW8ci2qJqi4A2qAdQn3rvXsKRRGu9wgahS1Ta9xH4RJW1x4eRLYqqTafUeOyCoRnYQvaFCe
	nRPq09A8lLWTl/lJsoSC/ZxY61W6fI1+BKP6Y537ES6crFMk2fQKLLn/gN49IVDUzc5S+irzpfa
	MifTyHxlcqqzID8gVdqfqKD/p+lgD1FsWmjcdup7vsBNgBKd+RTFmk12R3P8bs7HCTsaG3qtJQk
	9gDSqwN4CxSM/iyujFfj4P6J8aow/Eq6
X-Received: by 2002:a05:600c:4ed1:b0:495:4cb8:42b9 with SMTP id 5b1f17b1804b1-4954cb842f7mr18620805e9.4.1784300736237;
        Fri, 17 Jul 2026 08:05:36 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:35 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v19 06/13] connect: use unsigned int for hash_algo_by_name() calls
Date: Fri, 17 Jul 2026 17:05:16 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-6-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hash_algo_by_name() returns "unsigned int", but multiple variables that
store its return are assigned as "int".

Change hash_algo_by_name() variables type to match its return type, also
make it const because they are never modified.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 connect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 31e5ab958b..9d236e7bba 100644
--- a/connect.c
+++ b/connect.c
@@ -248,7 +248,7 @@ static void process_capabilities(struct packet_reader *reader, size_t *linelen)
 	feat_val = server_feature_value("object-format", &feat_len);
 	if (feat_val) {
 		char *hash_name = xstrndup(feat_val, feat_len);
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo != GIT_HASH_UNKNOWN)
 			reader->hash_algo = &hash_algos[hash_algo];
 		free(hash_name);
@@ -496,7 +496,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown object format '%s' specified by server"), hash_name);
 		reader->hash_algo = &hash_algos[hash_algo];
@@ -722,7 +722,7 @@ void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
