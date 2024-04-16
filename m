Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9013AA48
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713308530; cv=none; b=L1cV+IKzLrrpfVTiaPHmZHipYLbGUZsr3lMZfJLZLFkzfT6DEHQ7mHOmMpbMOIlut4V9qH8zYxU5dRO4T0IpskjhZ0d9Cj28fMN6dSN3LgY1UGyAkTetyotpfdw750+jdhfSV/IgdnI+8a5rU85gwDNozIuKrg6YsaozNw6zv0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713308530; c=relaxed/simple;
	bh=ulyTEcuPvp/VeO96joEDa6mN2f4b1GWZaQpSPIbleLk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WjgRTcYVz+TSIVO1RTEctdLhHBzX9OAfhCLTb2ULIlUV1s/f2IYPOxJAkWIJgHp+9bWoNiIoEfqk/EJ+e1pZHVPKZHuYT9GOi9YiPjFyV9SvEY9wndQfOlT8MfXStmeKTqJF7lBBskAY03nqbry4ffa6BR6gvZkiZ0Sx3JuSgOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+GrIZeM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+GrIZeM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41892a751faso7577185e9.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713308527; x=1713913327; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5LUQ2DI1gy+pHvfC8/qm4H4x816z+sGRCRZfUZnVqw=;
        b=Z+GrIZeM0VrqaL7HIYWQ9HoWgnsAwrhpLyjtaNEeOdzvoGMECYBlm/dqSZAmdfpDFZ
         /DchblkmHJgtPI0lbchxNDO9j7zrRhRwCyTxs5mEB2zw5FvgySg1tInXwNpTzJvgtvUT
         404PW2W4GEzGp+w6Y6OhAnvaOZdjDpXu/hLuj6/RGVjM1hP08/VQvakgDMt5L9UXi/fN
         OqUUFeZRIbmvpiJbHel2EsmLHPPn3NRV/jrcFXylBb5H3Z1/ctaTtddtlC+gkbQmKDDJ
         eaUfoNb/hrcfCGYfrqrygHpRPC6A2yTB9pDzpK/KM7J+QluAdZSBxU33EUzp0FhR5orP
         tcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713308527; x=1713913327;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5LUQ2DI1gy+pHvfC8/qm4H4x816z+sGRCRZfUZnVqw=;
        b=b169Yw2S5+P9O+aVHE+U+AWyIMPW9pKBuqleF4COKM6rqV0jsyDYzBe7R8e54Ttlqx
         ZsogMVB83aRTkQKBhOHzmMBwprztQ4kdOQGd1xxCZVY+qeNVsDUd5wPGR4ShA6JohlAP
         yEmUcVCEZ3sXRAxrUboymfA91IX3Fqkdr3VbY4GKC5NbOOQ2tlkU/csLFnj10EEhULE/
         dZeOhxB2jSAbFR2VHc8maC+6oIM8w13t+viHKPI8ZDG8gg6J3o+/o/mpI2itsq62mOEt
         3ugaDwZZJp+++o4gBP7OQ0LRhxlmQkxbHnjeMsNRKCmi9AmbKdpwlYcmzZpOE2qTIwM4
         +ECw==
X-Gm-Message-State: AOJu0YzEIj+3za3tgFS4TVZDfWN/xITCOkpUwUrBRhLbfyD+84eXYEZe
	POboyBN4feBzQ6kH60AmK1Wyug/7MP56RhWESJ8x6+DQYhJqzfrzHp3MPA==
X-Google-Smtp-Source: AGHT+IGfXfkbJEhNQdNRJP9uUIi2ycOxp8NL3Ps4256ariLf8GfH2o3pITspxu4AlH7J42O0/W19qA==
X-Received: by 2002:a05:600c:35d5:b0:415:6121:5171 with SMTP id r21-20020a05600c35d500b0041561215171mr8939991wmq.32.1713308526933;
        Tue, 16 Apr 2024 16:02:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cg14-20020a5d5cce000000b00346d91ddbe3sm14917018wrb.9.2024.04.16.16.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:02:06 -0700 (PDT)
Message-Id: <fd8ad38cab0ccc51ae7d26dc233d27e615a2969c.1713308518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
References: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
	<pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Apr 2024 23:01:55 +0000
Subject: [PATCH v5 6/8] SubmittingPatches: dedupe discussion of security
 patches
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a110f94db4f..060c8069c10 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -399,12 +399,11 @@ letter.
 
 ==== Choosing your reviewers
 
-:security-ml-ref: footnoteref:[security-ml]
+:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
+NOTE: Patches that may be
+security relevant should be submitted privately to the Git Security
+mailing list{security-ml}, instead of the public mailing list.
 
 :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
 not part of the core `git` binary and must be called directly. Clone the Git +
@@ -432,12 +431,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
-:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
-
-Before sending any patches, please note that patches that may be
-security relevant should be submitted privately to the Git Security
-mailing list{security-ml}, instead of the public mailing list.
-
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

