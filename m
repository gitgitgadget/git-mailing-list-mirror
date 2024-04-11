Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9584C60C
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878350; cv=none; b=NbMW0kO3QNDKXQDTG0cefbBrbs5PWMXovcsqrx91MPjjNMlA7Y4OXS83f1h+jnat4eiGTJB5iQNhOtbxaMZgUlEUnSIsNSFmnJEBWA7fKUQN3XspaJYQE0XXij+r8kaBh/7i8EOmV0XW3x5LVruBlgIrYlni6/nuqedEUqCq4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878350; c=relaxed/simple;
	bh=a0DwZJqfHNEiyf1I43XsENVL1rFgZ2rPn7RjEU10J/c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QuOGhF2KnwxzyNPikZ0UygnT7IRHGa3PVA2Nk+fdhVyBI6QIXd366MbBEmwIsznex7VXpW0q+EH0M3fy5txAQiAGyQOXcaMPwC9/i5U2DrW4pNZwWhoBkOKlAnHOAVi+MYCSEaJfkr0NzlwgBh+iwkKg77ypoU4ku2qFl9Nz+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktlfdn2T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktlfdn2T"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-417d14b3b29so2593175e9.0
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878346; x=1713483146; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEbXp+6FzrWn85i4TPSECfd3gAlSF9NSyW8X8bUGl4Q=;
        b=Ktlfdn2ToG3LLjoumgDhHzJp35Lp7NfeHH1ZsGufltEuitWyxf7M1fbhWU1wXgMxKH
         ktt/20rQnqSAjudhU/NRKSlQqzMVvRxl8G2DzYGBRdAtCVAFeQmau2wezjp/3Be4B+Tj
         yz1Eueb212nyVP2zmoqB7j5OBJLozWcFYZlIgdK5OUSIJ7QIsKpXaA90yvcPrkyoQn0Q
         PNAQFHg9kIVbfWug154pArsOreXF7dLSDXiFVHgr+jHfvqB4NzFbViePm2mLTlQmfy7k
         4JGzKZBNhDBCu8LYK0iZK1Z3qwHiy1bg9iga/1tcwIGFqzVFf75R6BoBMae3N97z5esm
         mCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878346; x=1713483146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEbXp+6FzrWn85i4TPSECfd3gAlSF9NSyW8X8bUGl4Q=;
        b=TbRmXCRJnc4l9GVNtvylwJz2APHQ8VXGevgpUHbK8UM9/yiH3usT4PtugLbQwW8gWe
         KTLNHVKHog7D00y0YawjmcmA51O8V5c2d7RfXpnMAkDOpGxHaTwcFT5aBugBe4+uBeAt
         0tpDoZdyY+VeZxb5yaFWM7vFwK4e0AzQu10z//A5nCSRcjPi0zzL0SFp3tjmGeWRY2MI
         l2qB3yjFZ6LCTWOeALmlrBvuqmrBme6bKoUiGlfnWAf3N80wW6XQU6Tr1c3Joh4yyTcH
         C0g63iUliZUvVyOI42F/+pGF4ZTT+7fJO7bLIDxnWGOez8cMrYtPsAoaKfmnC5YGku7s
         VSOg==
X-Gm-Message-State: AOJu0YypeqZpIDRISKTCp1ZJO/KrjnUsOB9lblq4zcKQdACDbLxh9mK7
	tKB7e6rJRik4D6EnHVCZHOE6ExBUqTdwezr2FFqLN1fH26D6ZXpzsZBQ5w==
X-Google-Smtp-Source: AGHT+IEZoXyFgsPAVb0i+QSWNp2DlIXOmHbIvUKrbkAzqLLlqq9rbnAL15Asp85QRes+pfeaOZoPiA==
X-Received: by 2002:a05:600c:4f0d:b0:416:6dff:9850 with SMTP id l13-20020a05600c4f0d00b004166dff9850mr887033wmq.0.1712878346254;
        Thu, 11 Apr 2024 16:32:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c354700b00416aca5ff66sm6930647wmq.19.2024.04.11.16.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:25 -0700 (PDT)
Message-Id: <15f9356ff97a428a73226a5ed36bcafff9f00875.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:16 +0000
Subject: [PATCH v4 5/8] SubmittingPatches: discuss reviewers first
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

No matter how well someone configures their email tooling, understanding
who to send the patches to is something that must always be considered.
So discuss it first instead of at the end.

In the following commit we will clean up the (now redundant) discussion
about sending security patches to the Git Security mailing list.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 72 +++++++++++++++++----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f1c0d1483bd..8805579a36e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -397,6 +397,43 @@ letter.
 [[send-patches]]
 === Sending your patches.
 
+==== Choosing your reviewers
+
+:security-ml-ref: footnoteref:[security-ml]
+
+As mentioned at the beginning of the section, patches that may be
+security relevant should not be submitted to the public mailing list
+mentioned below, but should instead be sent privately to the Git
+Security mailing list{security-ml-ref}.
+
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
+part of the core `git` binary and must be called separately. Consult your +
+package manager to determine where it is located. For example&#44; on Ubuntu-based +
+systems it could be installed under +
+`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
+with `perl ...` if it does not have the executable bit set.]
+
+Send your patch with "To:" set to the mailing list, with "cc:" listing
+people who are involved in the area you are touching (the `git-contacts`
+script in `contrib/contacts/`{contrib-scripts} can help to
+identify them), to solicit comments and reviews.  Also, when you made
+trial merges of your topic to `next` and `seen`, you may have noticed
+work by others conflicting with your changes.  There is a good possibility
+that these people may know the area you are touching well.
+
+:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
+:git-ml: footnote:[The mailing list: git@vger.kernel.org]
+
+After the list reached a consensus that it is a good idea to apply the
+patch, re-send it with "To:" set to the maintainer{current-maintainer}
+and "cc:" the list{git-ml} for inclusion.  This is especially relevant
+when the maintainer did not heavily participate in the discussion and
+instead left the review to trusted others.
+
+Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
+`Tested-by:` lines as necessary to credit people who helped your
+patch, and "cc:" them when sending such a final version for inclusion.
+
 :security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
 Before sending any patches, please note that patches that may be
@@ -490,41 +527,6 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
-:security-ml-ref: footnoteref:[security-ml]
-
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
-
-:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
-part of the core `git` binary and must be called separately. Consult your +
-package manager to determine where it is located. For example&#44; on Ubuntu-based +
-systems it could be installed under +
-`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
-with `perl ...` if it does not have the executable bit set.]
-
-Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git-contacts`
-script in `contrib/contacts/`{contrib-scripts} can help to
-identify them), to solicit comments and reviews.  Also, when you made
-trial merges of your topic to `next` and `seen`, you may have noticed
-work by others conflicting with your changes.  There is a good possibility
-that these people may know the area you are touching well.
-
-:current-maintainer: footnote:[The current maintainer: gitster@pobox.com]
-:git-ml: footnote:[The mailing list: git@vger.kernel.org]
-
-After the list reached a consensus that it is a good idea to apply the
-patch, re-send it with "To:" set to the maintainer{current-maintainer}
-and "cc:" the list{git-ml} for inclusion.  This is especially relevant
-when the maintainer did not heavily participate in the discussion and
-instead left the review to trusted others.
-
-Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
-`Tested-by:` lines as necessary to credit people who helped your
-patch, and "cc:" them when sending such a final version for inclusion.
-
 == Subsystems with dedicated maintainers
 
 Some parts of the system have dedicated maintainers with their own
-- 
gitgitgadget

