Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32683DCD9F
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773250318; cv=none; b=L0BvUubjcUwhMtawMcghSKjkeMovF41paV4VcMhvnsDc8nUD4beeeekDwiG9BlYdaPesdYoSVlAHnmaFCkREdKsEILRktdEBv2c18ZscT6jTWnfUsoglqdKsx1kgG1WjHgQLoPxqFK9lLnurRQrRMwhHSJzrfPCmJ5EOZKIV+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773250318; c=relaxed/simple;
	bh=SimSezPDUX3sWC+meBWBAnslS8/egIYa67DAQbmHWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx7KYDSzXq5t4QKwAK43kATLvpady57Pge8zHxyrKQNM5B6nrAUj0exB/1/Sbb6bCWQqKUcXbLKs7D8uhaVmXp3dKEhIZHOgaYHdp9s6CkkO/m+HaLiSXOiEOve6nyDk245SbnbY46GJcnThA68aWtduI5r5PCKesVEOnbP03mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsK+hiS6; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsK+hiS6"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40ea36b56b7so111087fac.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773250314; x=1773855114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=dsK+hiS6jwLLR740L4g2zZfmAzjcJ/pMdaZEphr0llfny3akNkmoBz4Nkotw8TA/nV
         ah8lPkQCBat5J9TIi7YfpzwBQ3Q0yJdqJdFPJqZVVlGvXQBuDYmPPFW7x+hNDuEguAR2
         cN2zAGQi6R+fDRId1LOcvj6goy7OnpamYtXrvwkg/25uT6VMv0v1i3KaPU/G5rTTGxGe
         zn8B5IPZWzKc8Sq9sbTGyP3jRXcpa2Gv4vZOhFYWeKgSQ2CdLHR8MqjF8+n2rHYp5OfF
         sUDOtJkqqeZYEO5jDJQADu6T8Be9KMFUrw1KSWB5vhWN3YOzXpZP8U2ytCqPyLPGqCBy
         bEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773250314; x=1773855114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imne22hxy8MEPoK1faX4yqNl5eOW77+XOAOfx/LPR1c=;
        b=qa/MUzf7zEUH4ROCl1r2kmoDuCyID+R8HctFapplxEnPQnH+j4Gu3HbLbI3ok9FVrw
         QlCMqp4ZCvA3ZHSHqQw7FoqlPgkkRt3HBFtx+Js8TBsQenZmdMIG3Yp6mPGZfM3haPFc
         pswKRow1Gv4LxM8yF8JuX4FQ3IkyiuQ7fcQQEePDJ/AL1BnMY3v3seJzZRscpX9YZ1m2
         RQsGXI/gcsBUAcUuQrfXeSc6Hf8orI2wkba809QMBrGU841OkjVpBASxVYBRhf/84xwp
         z4hVLigfTffViI/SstPZe/leodbmb4se6Gt1t2MEytst7fjzVvKP107YyiAfl98sm5nK
         dcPg==
X-Gm-Message-State: AOJu0Yz4aXzeGW2+bS8NLHlRLnzj/iDZnsI9vbEPsmwWrnbr2Vivgsd9
	h3L7pZnXRp11OA0PBZJe/qV/mt7ZLRg7QPeRFjwJbIGXVIUTo52ZCjOEZMAAUw==
X-Gm-Gg: ATEYQzwWcnbX0xaCVSmgt1MasjizeFK7vHYhs9ltd0Nb6yRv5+KkVNQfiYkRzsLguIr
	awlg4FqeHhvDgW1MCbrcJW5kEAcBLNItOHmNb4XDRbSoN9RELxg5cT6OhDR4eNuioQQWHIBLeGc
	/JS/hHSSrg+a7Ri/5l/rMuGTARSnAqu8zWbarEV/86KoCfMFfox4f/J5dGbBZ9ccvdFe8iiQf8u
	M0mzUboIcp+p7CY4QL+Xn1Q2JLRKH4HDQbdmrh3DKqfnSVJ+CVAwQLhO4L+iVfuy2Vu43HRg1Lh
	rUsstewajRANW0WDVWgEX5f3FmyWVBz+N5q2KJcOoKsj6JYPOMX8QvTmrvt1iXcXpNg9opo1Z7c
	6f1JsGryFnVZr/BrnqayHa+ky5ExOdrRzTn7EWXyF0lyQeyKpzV921iFk3BeGNLbfWwAmaAKvgt
	eqbKG5HxenBBVZE88c4BOOGjHIfJ05kXM=
X-Received: by 2002:a05:6870:3c8b:b0:409:a4d3:a30e with SMTP id 586e51a60fabf-4177c8013b9mr2109408fac.2.1773250314266;
        Wed, 11 Mar 2026 10:31:54 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e26e2c6sm2826761fac.7.2026.03.11.10.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 10:31:53 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 1/3] commit: remove unused forward declaration
Date: Wed, 11 Mar 2026 12:31:45 -0500
Message-ID: <20260311173147.2336432-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260311173147.2336432-1-jltobler@gmail.com>
References: <20260310201116.1130160-1-jltobler@gmail.com>
 <20260311173147.2336432-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 6206089cbd (commit: write commits for both hashes, 2023-10-01),
`sign_with_header()` was removed, but its forward declaration in
"commit.h" was left. Remove the unused declaration.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 commit.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.h b/commit.h
index 1635de418b..f0c38cb444 100644
--- a/commit.h
+++ b/commit.h
@@ -390,8 +390,6 @@ LAST_ARG_MUST_BE_NULL
 int run_commit_hook(int editor_is_used, const char *index_file,
 		    int *invoked_hook, const char *name, ...);
 
-/* Sign a commit or tag buffer, storing the result in a header. */
-int sign_with_header(struct strbuf *buf, const char *keyid);
 /* Parse the signature out of a header. */
 int parse_buffer_signed_by_header(const char *buffer,
 				  unsigned long size,
-- 
2.53.0.381.g628a66ccf6

