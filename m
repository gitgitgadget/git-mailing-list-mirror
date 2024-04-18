Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C419DF6C
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477135; cv=none; b=HPaCddBzJGaHPC3naxmAz0HdtFinaFq8SOEIFEKLr24nTKC9xj965kKPszFQKjrjTmhGWLEvG/6gh1fH5O+ZnqGz1AissS++mUVT0aX9SnlZ3peamOOzSaFaxGS9a5BfxcNb58TMgB9vWTj20+1wYGOhjC8HCPQnHlfwGOQrk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477135; c=relaxed/simple;
	bh=iPjfJWV4L7ohD3S8vxND21ne9Q+4QfV5GYmt5HHebF4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aL3ZNlcoeIc1XD5C/quZEarxIXKBKhEq0nVzAr6QbFfyzgMnuTsmR2Iw9b0ef082O+LAbBh05Fxj7tv4hYDUwGcXHyOAESuVtxT669WF6n0g1wXO+brmmRp3Vt0CJzbZTYG1WhqNm7XH6yCFuhKJJxQyhBY3bCGtf1rvWRTOSGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmJRKgh6; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmJRKgh6"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343e46ec237so946247f8f.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713477132; x=1714081932; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+pQR/iTPI0boEf3Pw/FXGSj5dlLZUxa7vhy3Jw7Hxs=;
        b=SmJRKgh6M0YBdm6wVwqsnKUS/CW7y+4TjPRSkr8PHNVXeGSy1L1vC0grXtdJbc/D52
         PYcs1gVLwBfVWEb9VCIBjOEW8Nfw4EAzTTUjKc0NXZ70m69gt/qXDabA1qatl4D6Xfsj
         z9cm6AlpFg+chnsBC0WRdOL+QskWKpCys4W3gYEeNSxHvSiHPaHx57UIQIKnV34NwGpq
         CiplN7txHslyoj2u1nwyg0REItbv282HwOuGsqo3OYGHsx5B2TK+H4ughSjr5mo5G2Xb
         usruTV8KzveDm4GoCHNAr4VCHDAS7YrhOuW02nc8j+1PaRrcPQgNx1KvaNJbcoUZhsWh
         8KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477132; x=1714081932;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+pQR/iTPI0boEf3Pw/FXGSj5dlLZUxa7vhy3Jw7Hxs=;
        b=YBxlpdMItWLUOFDzfp8NPgGfX4fioQ+mduiEjhxMFoou/BABoUYjwdlhHxGPWStCR4
         3ATY0aNZ7WtD8vm07VpkFA5bO6zPjTJAqqQmCPmo/6iFbAt8sklqeAq/Gr9kYlPSo5/p
         EfL1XajgDcjA5SWNC3EgVKuJF1DZO/BynXVb6+rBoBzWGaZGTr9iOSXKPK6/ukpiU11T
         wEORN8O66Zgcqn38IhlomhyDX/X7W7XbxlhXZSHz44K3Nlc4JmodFBMm32YSckMrlIjU
         Y4PgdWyP313tUAGFMCcOvjtU/3oxdsFxqxIu2YWJ010fwJkugJ0ugRX/AFgOZzJ8Rw5p
         lgxQ==
X-Gm-Message-State: AOJu0YykChSsViubL9kIoJ7GqtH3B5QtS+wCM6NrNdEdR4rSpcy1hzVN
	jsavTzfNfVw9CJP9Qutfkk+KEmk4eXZgx3PNNoV/A03OLa6q+ZEYkob5mA==
X-Google-Smtp-Source: AGHT+IGVTAOAc3llIHgLD9dNuuipzq6DINDg+TqUaY58NohcUhMjGzNGP7aq1jMxe/atXZhfpmihhA==
X-Received: by 2002:a5d:6087:0:b0:343:3a67:85f4 with SMTP id w7-20020a5d6087000000b003433a6785f4mr126178wrt.41.1713477131658;
        Thu, 18 Apr 2024 14:52:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a5d6344000000b00347363b77dasm2768345wrw.33.2024.04.18.14.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:11 -0700 (PDT)
Message-Id: <aac5dea0bfaea460da3c871ad6e722b6447d83ef.1713477125.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
References: <pull.1704.v5.git.1713308518.gitgitgadget@gmail.com>
	<pull.1704.v6.git.1713477125.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Apr 2024 21:52:02 +0000
Subject: [PATCH v6 5/8] SubmittingPatches: discuss reviewers first
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
 Documentation/SubmittingPatches | 66 +++++++++++++++++----------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6b9e954a47d..5d5046fa954 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -397,6 +397,40 @@ letter.
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
+:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
+not part of the core `git` binary and must be called directly. Clone the Git +
+codebase and run `perl contrib/contacts/git-contacts`.]
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
@@ -490,38 +524,6 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
-:security-ml-ref: footnoteref:[security-ml]
-
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
-
-:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are +
-not part of the core `git` binary and must be called directly. Clone the Git +
-codebase and run `perl contrib/contacts/git-contacts`.]
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

