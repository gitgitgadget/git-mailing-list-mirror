Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789E401A36
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538100; cv=none; b=pj1eXZ4e7g6244RfhIoLW/XXqVTKotJJNENnJDsdArqqdj2nlJwgIai6z8qPPKxzKqGLdqxviKrk7euzR3zX82FgVWjwO7VL6qbdBGnJ6zZHFU/opOdfX9+YzcKpf2VsWqQ29xRpD0Xcu1vIyQ12EbCRF0oglmbKqDMWHsm4OkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538100; c=relaxed/simple;
	bh=F1rQY6lS1liAjY+9q77IEcOzLQyGsY3Qt/rpIVhG7as=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KBJt1flXfkzqFy+2Ie2PwvMIZSthkR8qh7maXNlwe3fHckWt2Hqj64qAuFB2u4QZbl79nZlfRnD7qAXrKy1k1EV/IKGW9P6j2zVIJIgf10wWwXfAmAHqBhuA2H3GDMyCYGSugrtkQHMeJDgd6z1wIWm333nAPWc/Yw9+ZpkePR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwH1XoAu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwH1XoAu"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfbfdabf3fso114390785a.3
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538097; x=1775142897; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+e0vbdqUVgzn4DIHrRVN1NYuT+wGbffhrIkYn6JMRM=;
        b=qwH1XoAu4MQWgBI0txGmf8rCkj+cNbYKI0C66cqkc0rCPzk1fpai50TDi03CbB8dPU
         p4HMa+NvbI9DyjKE3USG62UtuXzEUqpV+08IwcJXD3iCcf7uFgxFavTtADauA+UZDzMx
         rqOhos7jYs+eZri6Bt9cwgBL3lwIxv2Uwtf9y4z+mzL2LLJQVfJnhz1Vyh644R0DcGH5
         ViWDiVVDtR0NMc4EFcioWFXr1FznzuGlPgFl2Q8NSZhM1n0mqVk2GYgetW1RN9ujwWYF
         iaTqFYo+grGBVRB3Olcss0XU5/ZNajQVZIXa76QFDzcHDjJfvWSvAuRMZ/rBHD07B/c2
         FEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538097; x=1775142897;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V+e0vbdqUVgzn4DIHrRVN1NYuT+wGbffhrIkYn6JMRM=;
        b=nREjDCjgpp8pTt7NCeFAINB2b57gpbAM4svK2dGBJznOGADxnbsVQ+6EsGZWjAV+KZ
         BM2yeonbLigp7EjDad7EIdN5Y43T+r3pw9jUbc8ugKr1wxgeYNYpxRR8howzEgn8/1tP
         RLcm2+2npJNHRtHWWAoVJMKheeSWq99ytO2kZ6i824YzqdijVoOR/dko7wp7GdtGzdy6
         petMZX5wft+R0RidG176H9YEcG2EeAZ1HDbayp1bZhKwSTSWTwcNaynoqOGb83022pJJ
         H9nRcgoa8RzQwYWsAwn3+gsC+pNFw4IZEqrbdcoSGuwv18D45Po34yF/mI+Us3TWS4hD
         KE9Q==
X-Gm-Message-State: AOJu0YyLnpicaNvhEMz7Sb8v0FimFMIFaWjAblxiJag2DpGoGWtZaLi/
	Uu3fgIERGDsJVSvL9hslVOLlqPlRK0rztREkTNsE6z9VB/Hqg93CGGq5SGeFNw==
X-Gm-Gg: ATEYQzxhKG/8cfjL2qL6BXGG6Q1PeZUFiSv8zuualBBJWV2h7Rgh3boQ94+sRMU+810
	rdLQADMs/srM/QyuBOI3K+YESmthqu13GhilSnHCqxn7T1CDy5cA7Ve0l3pPgCvJWzJteijHBCP
	TjQ9Nxi2XCtnE9njXV31qrGJiDNL8LLLXhhCklyrEyIR80YulkwIjSKRlnvxLz6VcK7s5NBG0EU
	dJjHQCgTY5Jq7oSDPxIwoqNuUUyajV4jCVuCPYLaYYDeEXqH9Y8Y79O66Mp8tWI8YUWnNmxPJmL
	YFs0mo3bpmoVgGSbqIADy79+1bF+mhsV7Yq3NCP9wqcQb6rU26CFoGdM46GWRlDZcv2dvJ3OW9c
	T1Q3KsaoKT5VglI1Vwsv39q0k34j7JsRo293sM8/ev4AIQDE4bZL6JCjgWT8nGpHPrkjAVVDRW3
	X2GDp0ydrBHYYABGNj9yzXOSnM6t0sgNTR43mx
X-Received: by 2002:a05:620a:3f85:b0:8cf:d62a:c820 with SMTP id af79cd13be357-8d000f3b18cmr1145403585a.20.1774538097088;
        Thu, 26 Mar 2026 08:14:57 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e4cf106sm271789185a.22.2026.03.26.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:14:56 -0700 (PDT)
Message-Id: <fda0239103f6e2b9e76403144b9ed2e9205e1c2a.1774538094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:49 +0000
Subject: [PATCH v3 1/6] revision: include object-name.h
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
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The REV_INFO_INIT macro includes a use of the DEFAULT_ABBREV macro, which is
defined in object-name.h. Include it in revision.h so consumers of
REV_INFO_INIT do not need to include this hidden dependency.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 revision.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/revision.h b/revision.h
index b36acfc2d9..18c9bbd822 100644
--- a/revision.h
+++ b/revision.h
@@ -4,6 +4,7 @@
 #include "commit.h"
 #include "grep.h"
 #include "notes.h"
+#include "object-name.h"
 #include "oidset.h"
 #include "pretty.h"
 #include "diff.h"
-- 
gitgitgadget

