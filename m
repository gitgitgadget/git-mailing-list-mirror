Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C053451B3
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411416; cv=none; b=I9ste6OiC5Aq7s3iATUGiYWHnQMmihNixaW40UqSByGWlwxLSIXui/BxPhtCJXHLPjYpSN1DvsqCs68gz15t5mMIO3Q75HNxkIDuFddEO30vRTkSOwziyi6zPflVJH5gJg0u1R27kyiTQ0MMcy03LUs3iHct5rhEDKYACiVpxS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411416; c=relaxed/simple;
	bh=N/GZEqZQagnA3ziQU3wxUG1qUpD7eJ9n4QtzlmzZVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORGelxCVf/V4DTo/leZDeeXC+4AlYjt3aFfcDRGofhzK6rnAjwCbE6H2eWW9aj72ss95HRaB+6rPJzbq1l7bts8i5hdIvpMaA5s6AIECgZwl8bVMOkvYYA5H5TOIYoh9oSkljutdctZqtjj+LbG/QHOiq//z5JK6dm3Mv/odPQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fmzcv1Hp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmzcv1Hp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49548e01d02so8350315e9.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411414; x=1785016214; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nwfyweLB4c/VAp27bK4XZttL8/Wv2oEOK0DLBVaYDK8=;
        b=Fmzcv1HpqwyYIerg3VBWmwXoNqZVngQ5rj5HdxwThc0pjrucI/3EyGA3KSr4+9pBoq
         V/VwVLo8iLl12+8oiUAJeXExF72BBNqJD2Tf18Y6X+DSpdXw4mSg3XybPsfTR+85iLQk
         VLfvk6tIveb15H5nyPwCQ/g9xX+hK1RjKE3y1pJSyIYhfzSRY0AZ/SbRuDpUOboomEmh
         bt/EN0wfOO9Brc85+xXriN8aP8KurosEAjS0xUXv4c1e5tQu/5Vh9/Q0Y9x4R047r6bJ
         rtnlRinQCrOIsIgD5l71zP1PAKLIpajHQ51lJgjTZi1EtNtUB5LwBbMqE5RHjk5KUJwn
         Zfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411414; x=1785016214;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwfyweLB4c/VAp27bK4XZttL8/Wv2oEOK0DLBVaYDK8=;
        b=DAnmFA3bxzUBzxMz0eOs0dIZ01MNo1IRFytzs4dlWMZsiyC9iCRC3M2BzNUOkYfIxi
         CyXt1zgNCTg4uaLgdFwHw5FoBAvKuS51RnAJXcl9QR5Oab+ac7Y64NV1q4uCHtxUw7uL
         enpi86I2r7EtCYpSB37zBKMHFszl1c1Rdfg/8NTx5U+MEdfoVNWEFPteJPmXGZSTtuvw
         tGi9s7PMF2M8V/3wxQyOojL7kAUvwX71kr3Ej5ffD3yzSaxeaPTLeUOXHwunvDNgY9Xk
         UIZSkPSV5FiHeHYJjnevQsr7piuajc5JfXCtnpvlf+eY1n/5Opv3D5PKfK9qzCn27V2e
         IPAw==
X-Gm-Message-State: AOJu0YxPveMuRStWNs1w6g6tDHeCrunnzzh/c1CjNsa0SINUxBTC2hjN
	oHJXyDYeI73vVxsWN2EqNIGdCQhN7OFAwot5Oo24Ka/G1hPXAd+OWlin0iOm4DML
X-Gm-Gg: AfdE7cllRoiJ6MxgimAmBWKAE6P2b1B1liaXmu8eiPCGJ/k8bZhT4XkdNJPjqXA138q
	zT68uf10fuYVDw1D94vCHu4R/WVddEy9b8OvFN3iJltpCyFGKkRoBtNSMUQMDRf22mnJfotN4U2
	NjKjWYr9I3xUlEP5muKPK5o2+Yj7A2nATDtRw//NfDKc4c95/PlkQyjPTJYiM3PZqCrAOLDcQ7B
	ECDZ678WxN3ozsMqPu39AiL/aLXuUYabEJlo09fXyJChy9zcDDx7guDgf4ohfw7ulKf8yeOjgOi
	k1ydO0w//Q8TLH84iWyi11IJ6aDW3g4qmP/cPeenh/p5Kkb2GHDWKaN0O/++RfQKf4Cly3Ejzzh
	cMX0ja8xrVXs7mdFslofEbBrqoXqT7B7I40nSZl7mHDlOBMh13dXBoLBOsMztpOnO7wOkyxTgsW
	V4r5boJYW7QshYcVOQfNnh4lNkjQeu1SbL5cH+xHSBS+bJYl0FF8rFLYD7VWdr1N5TMCKImIRmw
	lLaWt9G1tglovE00qqHI3wZThJP8F7Ti3yjnQ8AFB8btJyoWgCu98ERCXouTszWc5dCxoXog2T/
	w8EyxQm6+bZ1ijhYQTRPn1o8zcBtaa/A
X-Received: by 2002:a05:600c:310e:b0:495:52dc:73a1 with SMTP id 5b1f17b1804b1-49552dc776bmr35889625e9.29.1784411413516;
        Sat, 18 Jul 2026 14:50:13 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:13 -0700 (PDT)
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
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 05/13] fetch-pack: use unsigned int for hash_algo variable
Date: Sat, 18 Jul 2026 23:49:54 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-5-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hash_algo_by_name() returns unsigned int, but it is stored in
hash_algo variable as int. This goes unnoticed because of:

	DISABLE_SIGN_COMPARE_WARNINGS

On 'fetch-pack.c'

On a subsequent commit this function will be moved to 'connect.c' that
would notice this.

Change hash_algo variable type to match its return type, also make it
const because they are never modified.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 65ebfec09f..f1e64160fc 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1397,7 +1397,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
