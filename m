Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D31C4332E
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC3423A7A
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbhAHSST (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 13:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbhAHSSS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 13:18:18 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349EBC0612A4
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 10:17:51 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 75so11123755ilv.13
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 10:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zCb37iXSFsX9rFmR1LLC+H3EPGfQdLbpmMxbI4AJd3g=;
        b=XG5KQvesgB6lknDOW9L474XlfM+oGqa6oFussocfCaIxymWKhlq7NqiVbb50eTU5eS
         OPXaqlve707VO+31k7LByaySQvh4hVsNA/sxweDTFh0bO9nFPdMJf9k/WAcG7W+wAcbT
         aL8TWYkRKJHqsuk26sFiIu5SwUhSRekTy2a0XLL+Z++hgWo7NQZoGWqY0qkcuFLnNcvi
         b12Bt9dIHauMaN9j/EWvmgtGPJ3PAKHy2LwqxMRwkst0jk1d55lEOuhIjHcTbbBc7HfP
         xymvxubov3/vUWg/yznhXrG7XoQ1R9H73UWzamAgOT7wHGmiTZFJuDKxm4rU4joyg+DI
         avtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zCb37iXSFsX9rFmR1LLC+H3EPGfQdLbpmMxbI4AJd3g=;
        b=iuC8oiSKB71lHhTsCBf0ish+7HtEmhiUNRsxJKXuGo6dANlV3pdjrioqE6q8Vz0OFh
         I1fFuUvEUQG7NImDRKoD1cPgTH+ZfQBJS9hve4vHm6tcS4NhqdIiAI3E3pQUgDM0L5r4
         6oUIypO/A458CJXOWTjSQkf5sqYGLeLaAat3awy9DhbC1b2Mqv1TX6owObKV87uRqw4l
         P8H3pc2J0wYAZM2mDTLWMJthOpZIwKsxH+aqNbohB+WCvNanC2q2V15cNvT3SpJ8sCNk
         O5rmG9NiDnd3FpVtVgmwFwrYt6lQSWNxBxiJ5pI3CSbwxr2DG71MZxRoOY0XBlB8bzZW
         9SJw==
X-Gm-Message-State: AOAM531Dgwze1YjqOef9b+TofpyH9Sumj9ugdfW5D+rhY/Y82HevkDyK
        CxBRPEcL7m27/ImRytKrn3NEmme0AJXw4Q==
X-Google-Smtp-Source: ABdhPJyg08/wA1UZGxggeO85q+cvEFyzJxCFSlOefqvqO1DdJz+JTIOhKKxUvIZIJsa601W7gkdQag==
X-Received: by 2002:a92:cec4:: with SMTP id z4mr4995627ilq.217.1610129870374;
        Fri, 08 Jan 2021 10:17:50 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id e9sm7266137ilc.73.2021.01.08.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:17:49 -0800 (PST)
Date:   Fri, 8 Jan 2021 13:17:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
Subject: [PATCH 16/20] builtin/gc.c: guess the size of the revindex
Message-ID: <7c17db7a7df8b524f13969efd1cb5e6e95de5a2d.1610129796.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'estimate_repack_memory()' takes into account the amount of memory
required to load the reverse index in memory by multiplying the assumed
number of objects by the size of the 'revindex_entry' struct.

Prepare for hiding the definition of 'struct revindex_entry' by removing
a 'sizeof()' of that type from outside of pack-revindex.c. Instead,
guess that one off_t and one uint32_t are required per object. Strictly
speaking, this is a worse guess than asking for 'sizeof(struct
revindex_entry)' directly, since the true size of this struct is 16
bytes with padding on the end of the struct in order to align the offset
field.

But, this is an approximation anyway, and it does remove a use of the
'struct revindex_entry' from outside of pack-revindex internals.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4c24f41852..c60811f212 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -301,7 +301,7 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
 	/* and then obj_hash[], underestimated in fact */
 	heap += sizeof(struct object *) * nr_objects;
 	/* revindex is used also */
-	heap += sizeof(struct revindex_entry) * nr_objects;
+	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
 	/*
 	 * read_sha1_file() (either at delta calculation phase, or
 	 * writing phase) also fills up the delta base cache
-- 
2.30.0.138.g6d7191ea01

