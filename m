Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B72C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbiEIR65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiEIR6w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:58:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02A32CCD1F
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:54:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id be20so17174460edb.12
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VKDxrijw84sYdbJWr5DaXujjMNAqhTlE6569q5KTrlg=;
        b=DkjdCYbbcHr/jb/Kk4NXgndVD5xwJr1SCqgBqR1QN1QVltXJ+En5fQYxXbYotJljCm
         e8r2pqeDkeau5TyxKSw/0bS9cdB2m3Bt6lLjjWKvGF7oQaQQz0QjLFJL+Gs/Uc9HlgiA
         V9OdVp+Rd15LQ58AnHFD8r7PN3DNzzMnYT8TWoVO9VC2I/66vyt//nsKxAtCeIzJXHn2
         pqD2VTKsuX2DgF7oug9CymxEC9dQYf78uRRmGX7Z8DWphnVitoVKgHiQAQMkByt2novS
         KppLuZsA7g3a9SvDcIdjfgHZljKDx/hdLz8D/wy5s1MJBSjUVOPunGGHx3EO7Y/3Gi4y
         0o1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VKDxrijw84sYdbJWr5DaXujjMNAqhTlE6569q5KTrlg=;
        b=qfQwkBgFOexbBusMndpno0gclSRA9qOZOphGwAVx0LigWcTNEiD7gWWDoFAaMIHUGF
         m9FsXzuSld80LIabfv0KhLmF59WGxnqNLr3tKsqPjYsMwQWDdUtyO5AGoO5wyPCt7wi6
         SxXhhh3qL5boG/uN7RVa3MvhpAsbTDmsm5mnJ+lfOmkTq3TQe2XkDp46xh6qulSrLOrt
         OOt5UQmxcPk4uRnmyKT0Mh77DXDI+vcg/sQod2izkNczgedaaa2JO4m/p41lPKCv/+Yu
         lwhmY4uAyb3FDiSy8kYTvJYWXRu+ipe63bn0jXZhYhgteKBd9NOoHH9TDI5xSazuBg1E
         qrAw==
X-Gm-Message-State: AOAM532Kr3eii6QurcOvImQfrfE1gB9uAxfVnB3yp1HU7OFs2fJTQYyY
        azr1yk6N+UObDvlk3GrgYfwkwfzrFvE=
X-Google-Smtp-Source: ABdhPJyRwBNEDKPpioNP6+I2aorNWeDRoiGQraPjzHn5rObhe+ID9wjNsXBNmWCTiWOq4CxjpdHnFA==
X-Received: by 2002:a05:6402:278a:b0:427:d0e1:599e with SMTP id b10-20020a056402278a00b00427d0e1599emr18628619ede.58.1652118896576;
        Mon, 09 May 2022 10:54:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:54:56 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 02/15] t0066: remove dependency between unrelated tests
Date:   Mon,  9 May 2022 20:51:46 +0300
Message-Id: <20220509175159.2948802-3-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Two unrelated tests were using the same path for testing. That's
incorrect because if the test that depends on the other test, which
creates the directory hierarcy, is ran using the --run flag then it
will fail, even though it should pass, because the path doesn't exist.
Unrelated tests should not have dependencies among them.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 807c43d447..801749eb7e 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -63,9 +63,11 @@ test_expect_success 'begin should fail upon inexistent paths' '
 '
 
 test_expect_success 'begin should fail upon non directory paths' '
+	>some-file &&
+
 	echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
 
-	test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
+	test_must_fail test-tool dir-iterator ./some-file >actual-non-dir-output &&
 
 	test_cmp expected-non-dir-output actual-non-dir-output
 '
-- 
2.36.1

