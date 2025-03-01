Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87731322E
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825244; cv=none; b=qdP9DzBbns5y3rIYDeMM1Z+13SdLchGIW0toAPTDtfgixxtim9r/+sOF42Bzuroa7/EcstRlvq0kdbHacfUB+pnUNI0wgXJTilhkpB8FczGiK5UESY+wWcX+Spre4timWcNgH3w4XnndOQDc4A99lBT92H+eLW6nHIx9kJI1AG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825244; c=relaxed/simple;
	bh=mVEBadS6zJIFxSSIVh9nTY+y1VgRopuhwwjaM7FnF1Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tDn9fa8wG9/SOL41KvUbpS0KkgGMOqCS4+ljAdGLUDA1FfcFFop0BlMmRnFfqGchPLZ3L+LnPcIsghAMw/HS7A003Y3GuohC1mAhlWmLACm53sbVK4zM07XaxzTm6czd2GLEiokUs4az726KbxG+SMU7qXADHK1otYUUj3i9/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpoxBUn8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpoxBUn8"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390f5f48eafso456845f8f.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740825240; x=1741430040; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70AbJL4EB8pNm7Y82pFPSGSpfjOpE9NnK0kjqOeTyJQ=;
        b=hpoxBUn8vCBTK7b2LuBrn3yv1Z4PxW4FZ2j6p+gTvppnNWnOK0h242Y2sm9C9oiwR8
         a5n8TNABJ9HOoLuZlEbvAnUk6pDvjdE+0udWQeFMYh94+HpB9ih9X0eNhQAXLITv//io
         2cvEKSXPhvlQmbJ2AQYEZGQ7VcreragYfzfI/ELhZRmvVDnfCS+r+9/aD0a3O1UBDuuH
         gmaUP8rZI1V1u0u8m8cnZfaOL90BaS9ZiezCnGdKf5anMlkLSRtK0ZkldhJEXLJdVQh/
         7p+hYIDPJsNkO2Qw5XMp/UBvjG+ohr+gTOwglIGJ2fLd59t1rLDBl9gh00cOtBOF69aV
         wZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740825240; x=1741430040;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70AbJL4EB8pNm7Y82pFPSGSpfjOpE9NnK0kjqOeTyJQ=;
        b=t1Z1p13Dl9Wkhdo6/X8I0Wev+OkGJtBxXPXIxGll3dCAvKfzrz4+F4TZXW566Dx3Ql
         d5CcEvvgUlwqei06lQ97AvAWIgXKx1oVSQowbQSgmJ9DJD/oAUgeFaPAIxoVgkwffi66
         vppQMToeq+qDdUZG6o2ULuDQuZsFC/U57iGIpLV3v7DFQ2O1f+4E28aT52jnINN4GTYX
         xzKe01CRSqboeSeyeqM4M0IWcuX3SP0VedGg2rjIkG0FsVK3xqZwOzMQxNGDwf8lZhpq
         YnDXB50xB/PMCEx4RaS8PabtNJvNoQkRRCF4KlKawI/xgXnjuN1/SDzoiJcfWm065PtN
         jlHA==
X-Gm-Message-State: AOJu0YyH1IqUjDYeaNMNeOcROmkW4YVOH+niNs7ElZ9lF/hzpPkHL0Xz
	4vasPhBoMwGwFkuB7TYqnQnR1x5na9lDyOadvuYutHnroqu5WO5eVe/HKA==
X-Gm-Gg: ASbGnct6PeX/QNGngAN3oAklKaBfwlsQ5NfoJSOCoCQTJv6R0hbmWKi2NmoXpRMFR0p
	8OgSRkqLsz7T1+7/iQ47dJv44r+fYH7HYqfi7Hzks+cEV3YAe8p5lhSEt2sQvfp6ijYileRWvuL
	PmpEJl/PUkTDIVF0N55D6hhafcih9N3/2EcdzUPjRHReJUO62caBVV9/8CvAo1qFi+Pc9mAS94H
	EAuY5+yDfLOHLXR5Wu8NMgUYJNs+ftKk0pLRGUWCUHSXBQ/oyyHRkt+x3XqsPRssV8kVmlmLYVF
	jrCmSW+DUr7lswNmBzcmsze/M3zgoiLmoC6HGvIEJtYAWg==
X-Google-Smtp-Source: AGHT+IHOMla6GO22leDQQB7VGOGh2cZWEhBaiNY0GxBstu02w4IWw6zjHeQgiGf11HmCtmL4eQ6yeQ==
X-Received: by 2002:a05:6000:2d07:b0:390:df83:1f47 with SMTP id ffacd0b85a97d-390ec7d2e74mr4874950f8f.23.1740825240064;
        Sat, 01 Mar 2025 02:34:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e48445c5sm7894161f8f.78.2025.03.01.02.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 02:33:59 -0800 (PST)
Message-Id: <b36bc876fe1facbb278de0a58262843e5c88738c.1740825238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
	<pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Mar 2025 10:33:56 +0000
Subject: [PATCH v2 1/3] bundle-uri: copy all bundle references ino the
 refs/bundle space
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

When downloading bundles via the bundle-uri functionality, we only copy the
references from refs/heads into the refs/bundle space. I'm not sure why this
refspec is hardcoded to be so limited, but it makes the ref negotiation on
the subsequent fetch suboptimal, since it won't use objects that are
referenced outside of the current heads of the bundled repository.

This change to copy everything in refs/ in the bundle to refs/bundles/
significantly helps the subsequent fetch, since nearly all the references
are now included in the negotiation.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 bundle-uri.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 744257c49c1..3371d56f4ce 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -403,7 +403,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		const char *branch_name;
 		int has_old;
 
-		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
+		if (!skip_prefix(refname->string, "refs/", &branch_name))
 			continue;
 
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
-- 
gitgitgadget

