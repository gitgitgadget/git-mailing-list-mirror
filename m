Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB85C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDNMSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjDNMSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:49 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C699EF7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:48 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-187878a90e6so7695112fac.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474726; x=1684066726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoxuHttwGlHpw0iLHk9kbmg5mFYOxafVOewfrSGopK8=;
        b=kyN/2MYMJb4/vFIq4TRAGz90pLOJkCn/tccLck8VdBK2bKOUZF7UIDqPU3PmuXQ/7P
         Q3ymv2ucr65mOxcsUEteKUr3RKfSNOkOL9mnRvWW2z7+3CMZs6HXbLe6dpzJJPXT0GFo
         VOeSq2Xfi7/hCTwVEYSm+EJ6ussWyAqetDeRCbWl5I3vEZ1Y/fbx3SqkAkhRKhrQ54ES
         8NtOILQh+jEIudmiOZ75iV8k2KZ5gvVe+UOJKD5voikoWFsFq6lgc6s/m9vBpX8QnPEd
         JbMLEED0WwlqVKfnWurxUK1jsFWkGT843q4o5aXxhIPfSyt2aAL09D5fcE6LXloOcTWv
         /D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474726; x=1684066726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoxuHttwGlHpw0iLHk9kbmg5mFYOxafVOewfrSGopK8=;
        b=b7gps36mHewOMMVJbNLG8eLZj8957w2Saw9YHPfYnzxnyyoWSSCVEvG+2Js/EOsHds
         CeNq5zEQ5kBZnUtKJpDi/FfXjzKfYAxryXCyANZy6cTmataEKu8KtEK9pa1vQ8Qhrr9t
         5+VgQrRpXm80dHdvPnTa7eoa6Jt3QM02UjqkD2cT+siUJIqEHoUOX0oNlqb76eU7/3Jn
         j0vA+X1EP0Flnl+CBAmD8PUKFE3nCiIkRAl0olGVu0gZjJzapWbnsbhOpbMfe16XG21R
         dGuXN7OSUO0uHVn9vo578q/T/XgznvIc7MpWz/S91fjqPUbV+NflKAkLKI6plnFaXxL2
         bnrQ==
X-Gm-Message-State: AAQBX9ctvxqAaeLmQx7xdQzdFDAFv6A+we3738otWd0b3Qp1/YxO/h5l
        7pzC6Hk0KcxcMugFgsXTTnLh6et5QCk=
X-Google-Smtp-Source: AKy350YEdVKieqVYpk7oYKvYZ0dQlodWyWS8QLigsMUr2pXjixTahgP/PQu3PAeLYcnt2j34rT3alA==
X-Received: by 2002:a05:6870:309:b0:187:7579:76c0 with SMTP id m9-20020a056870030900b00187757976c0mr3317713oaf.37.1681474726189;
        Fri, 14 Apr 2023 05:18:46 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b3-20020a056870918300b00177c314a358sm1718025oaf.22.2023.04.14.05.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/18] version-gen: trivial cleanup
Date:   Fri, 14 Apr 2023 06:18:25 -0600
Message-Id: <20230414121841.373980-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't use `git-foo` since git 1.6.

HEAD is the default of `git describe`.

Also, deal with a bunch of shellcheck warnings.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 29d634a30b..6dd7683ee7 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -7,7 +7,7 @@ LF='
 '
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) || return 1
+	VN=$(git describe --match "v[0-9]*" 2>/dev/null) || return 1
 	case "$VN" in
 	*$LF*)
 		return 1
@@ -22,26 +22,24 @@ describe () {
 }
 
 # First see if there is a version file (included in release tarballs),
-# then try git-describe, then default.
+# then try `git describe`, then default.
 if test -f version
 then
 	VN=$(cat version) || VN="$DEF_VER"
-elif test -d ${GIT_DIR:-.git} -o -f .git && describe
+elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g');
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+VN=$(expr "$VN" : 'v*\(.*\)')
 
 if test -r $GVF
 then
 	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
 else
-	VC=unset
+	VC='unset'
 fi
-test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
-	echo "GIT_VERSION = $VN" >$GVF
-}
+test "$VN" = "$VC" && exit
+echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

