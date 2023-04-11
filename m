Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC06C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjDKRNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDKRNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:13:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0631E5592
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:13:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p8so8567132plk.9
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681233231; x=1683825231;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrgryQZ7gvBNcnfaECqwf2yDyjqf+o1wSV76wj6iy3E=;
        b=qE8vOmeTlAOTgoE+wUEM08CKCV6Ar/NVT5UQqAreRgNc8sDO6jMoRLebIWKHTiKzhP
         xeiNR0BlLDESvUUxeAvowkCwVnmp4wjMwqWhvVSyX9jvnV2+SpKgwtK58EgWgdnto/Iu
         kc1k0vFDewnpYoqtULuaLe/H7gPTmzr17Jx57+lzFmTuEc4JxxozJSs15ycvWj3rT3bA
         A10vErnRRCw58KtrApTh9DtgffnDC49wvnoqjyari6ehq/PgPQGw+k2tOrRNiUE4VOZA
         Fmcu8NT86vMnMblP2xlVPuIG7cLSu6HR2/gC2+eh9dPDu6Z1naRlqe8rS+wBoLb3Zyfn
         Zizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233231; x=1683825231;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZrgryQZ7gvBNcnfaECqwf2yDyjqf+o1wSV76wj6iy3E=;
        b=lbT5ES4vO4r1POL0WF752zm+ivVq1eS61sHFqPBimLvSzMOHvfOXpmMyzJ64/J253K
         tmUdqs8lb+Q3QaDiblrPXiZ/71DkkdTa1AGglp1C5Sc4hMB6dSMTT/KXOmuxJ1McsEVc
         wrTH8y9mBJYQs5eQQcy7mtsgbLiSoRA0lW2eQW1MVRaBdDpv3BArUObIL6V4IzwjJQzL
         NS/ey3ClnpdImTwRWVSYSYzyShro7Dw70Ge2iRr6+ctO2kVYA3tofuVXY9drwhrdiMLh
         hgEQgzH+pzJp0QkZoE+iUS86onhpa1tSmxuaPjsbkVDUL50JIRi+pjmn7VQyHylURXdw
         qT4Q==
X-Gm-Message-State: AAQBX9drtWYYYt2XHlecHJ+1yKQIoRfcHD4yyD70PRZn/93zwNHq1Ogg
        LJr2lqJfdNz+ayZokpMOIjs=
X-Google-Smtp-Source: AKy350Zpkq8hMJpZKiG05BkwLxD1zhYk8tdBSkAN0ESmn3rEnBFIqo6zZ/sn3bVG3bA8QCKWxQ6KBw==
X-Received: by 2002:a17:90a:520c:b0:244:99f4:2ef3 with SMTP id v12-20020a17090a520c00b0024499f42ef3mr19753829pjh.0.1681233231383;
        Tue, 11 Apr 2023 10:13:51 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902868d00b00198f36a8941sm6962228plo.221.2023.04.11.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:13:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3] clone: error specifically with --local and symlinked
 objects
References: <pull.1488.v2.git.git.1681165130765.gitgitgadget@gmail.com>
        <pull.1488.v3.git.git.1681232918484.gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 10:13:48 -0700
In-Reply-To: <pull.1488.v3.git.git.1681232918484.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Tue, 11 Apr 2023 17:08:38 +0000")
Message-ID: <xmqqmt3e9wab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     A quick reroll to fix the style issue Taylor spotted in v2 (good
>     catch!). I didn't spot this patch in 'next' or 'seen', so hopefully I'm
>     still in time :)

What I locally have, which is an amended version of v2, and this one
differ like so:

diff --git a/builtin/clone.c b/builtin/clone.c
index ae2db8535a..b42231758c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -335,7 +335,6 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 		if (errno == ENOTDIR) {
 			int saved_errno = errno;
 			struct stat st;
-
 			if (!lstat(src->buf, &st) && S_ISLNK(st.st_mode))
 				die(_("'%s' is a symlink, refusing to clone with --local"),
 				    src->buf);

So I'll keep my copy.

Thanks anyway.
