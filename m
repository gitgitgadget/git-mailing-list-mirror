Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0001158D94
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699825; cv=none; b=WX6BhuGxqTfOtLB9MapyJN+vFQ85V8JPEmvPig+eoEjLUiXrByc6nmIuRbSTex4suwF3YykrAxZNUlHBxeZM8dVV0Y3sPJ6deqPSY8ET2j9VbHtyLLPn4G3UBA3EC9GFAIPJLNM/vkZUVnNX2QnPXq7WFhTEf9xEFHhv6KYBi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699825; c=relaxed/simple;
	bh=5cy1OPvy9KfvsVVcu4gzZ7WibGtKIPvhFkmkLIXlwAM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PJ6itETStaKVL0KYzhelq/Voo9uHxNbp99uCfoPPJgK8t4Ue5YXfXScrCWNorXteaMemBER7O7FS+WvY/2qAOn2se5/mpxqVvMzfhIqxyTLQPPaYSLS/DVOlotIaW1BiA+QxCbmgrTXm7iXDjM0AW7ryNSLCsOkCcnVstnBgDd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkdUXvaV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkdUXvaV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34388753650so2539122f8f.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 14:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712699822; x=1713304622; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6j860TExSUSDavYKKOlVuU1oRtbZEpDvs0vvv9ixh4A=;
        b=fkdUXvaV8v7TQ9IFbD1NqeaZzsc8CSJ3jiQV8/UAhbFolN8CKjDIE7e8uOK0inJew/
         IHtEGVT/NzqUpIDBna5UviAOk8Sr9qbuGBJ7WVx9H6WTVMQKPbcYAzMOaJGNDUhKR3Ci
         vUM0avYqU7E5ojqBymPDDfmSP+ojkFj3O+qRpfTFfmclhaX0jqlCq8YaBkdC60BUB5gN
         udHvJoDIbaIp9gNFuqPOTa8uY9jpN3dS7E/G4EJ4XMy0a6M3xBNQjEDairMiTDRTjiai
         xJgAQ5GIyoUoIU1WNC4AJwv9WNE3UR6QWzMYUCI3M3PiLE/6FgnzXM8/rspGqDS7xMZF
         jYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699822; x=1713304622;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6j860TExSUSDavYKKOlVuU1oRtbZEpDvs0vvv9ixh4A=;
        b=INsJJq+8tu5/yM+gYBm7LC39gxlMJFsdm/CvGyYO/84+9UDateQ4qWJMiw/fT8WJwG
         iKSBcoRG+1qQiG/dJMWHQBcWzsHHNQpp+zrUWXDp1nqQJEXBzhCsZR/N6f9k1ZucnNCE
         VzUVyWMwDKIk7s2bMHejVXTylIlSw0TRRMQ8IkM+H5fgMLk5BA5CbP9e9xsevsfg4pWa
         c2HcGoyvK7oaVEcC106wlKLMiDS/vnT2CKzZqyPzhHD4SO5BVPzgbJcePTnvY8517EdB
         Eu38i31Rh2A9hG+WnsfkuBxSmHHDzYF8V4qEWFsdr+UJfrLqTX0phNncOqwUlTSPgR8m
         PosA==
X-Gm-Message-State: AOJu0YxydUkLkHHWiLcQefbtN7z4/utdWadkYBLTPlncF6DxjwvnAYXe
	ZnWu+YLoUlalDaAzH7H+ltGZ7q7i4QsQmHSqnH5Mr9V/OEl+wxdrartkEZ7o
X-Google-Smtp-Source: AGHT+IFfokPbCMI67w4kPcFOh8AdtvwSPC+Y3ewARvtN9dtnMM9KE1myQW7Auevhz1MdICKhBZ4EZQ==
X-Received: by 2002:a5d:61cd:0:b0:343:6704:93b7 with SMTP id q13-20020a5d61cd000000b00343670493b7mr639729wrv.59.1712699821932;
        Tue, 09 Apr 2024 14:57:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b003456c693fa4sm8128889wrx.93.2024.04.09.14.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:57:01 -0700 (PDT)
Message-Id: <6f71b1731f2aed9c2f4dc101bf4349344b575d73.1712699815.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
	<pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Apr 2024 21:56:52 +0000
Subject: [PATCH v3 5/8] SubmittingPatches: discuss reviewers first
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
 Documentation/SubmittingPatches | 58 +++++++++++++++++----------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8594a3dda36..392bbccc452 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -397,6 +397,36 @@ letter.
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
+Send your patch with "To:" set to the mailing list, with "cc:" listing
+people who are involved in the area you are touching (the `git contacts`
+command in `contrib/contacts/` can help to
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
@@ -490,34 +520,6 @@ patch, format it as "multipart/signed", not a text/plain message
 that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
 not a text/plain, it's something else.
 
-:security-ml-ref: footnoteref:[security-ml]
-
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
-
-Send your patch with "To:" set to the mailing list, with "cc:" listing
-people who are involved in the area you are touching (the `git contacts`
-command in `contrib/contacts/` can help to
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

