Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038A6C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 02:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiC2Cvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 22:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiC2Cvg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 22:51:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F057157
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 19:49:55 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i11so5106748plg.12
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 19:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FiBVrEGKdtTz1ES5Dj2YbMITqSHW5Avc+CsJEYExS0=;
        b=Zr5nAWQLMEFRUnKP5t1yCenH12CZImDY9duenyTrIPIcSm/5H9z29jm+V4b9VmwChC
         i+rWKfoAImPVNQ2asGpFIBFcTzGv0Y26APxINirB+KnzJQXgIkjHvN6xac74W4KjvqoD
         mCQIW2MXC4E+6MbSFtP9RKmyiZQGX/zqf+U6Pspnf+aTk9ejjKpt/d6VXjg1udAfcD8s
         mGfZHwCMZ3xm7e9fwe9HQd1/kvqWJsOD6UnXDpVBSjPqxCvMk5OijsMGXB4nZVv3eksj
         idNDX5CmyFdUl5rx1Ji8/ILLsJSJkXN2XFr3m56TXxhKPTU3u1+22ESFOugzC4pf6nt9
         3jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FiBVrEGKdtTz1ES5Dj2YbMITqSHW5Avc+CsJEYExS0=;
        b=MJ7Kiv6NEoGVKlgE/oK/KrcLfhBkr8DVU2bEP4KZn4YDsZxAqxIdb0K7uE0LdpK+jm
         e+P0NRHD1I9It4jLjZdtdU9cJUw1K+VHz0i3vDaKDBxw9d6pNUTYmIAKLxf+A0SifwJz
         i4/POIIEFV/pRWIa2EAFQ6eMH9gaD0NAUDJJ4XMkdV4+R5jrKlLCnIXh7ySNKDTzI49Q
         4lgbYFSm0s90RVNwX3IQ94juRPr8BF+oi1GiBwby7OJhvaFVvMXuyOOY0C/7tFhKpOMe
         tz6TKR89eHZ9jcL4T93AhYel+UcGRiCuHZEWOmt+MCm0G7P0aYGiKZ/wiMzH5j4c9CX5
         SsZw==
X-Gm-Message-State: AOAM533YNwz9sOnRfkD9CNbsvkX22NgPC2tJ4wR+fbCrZmmeY5cGtkoH
        aOAZxNKHVkBiU4ChNAGijDs=
X-Google-Smtp-Source: ABdhPJxWCLsRj752hlXyAd0tFy7/Uj1/f4ZdxKGMo38xc7KpoI84PPwkaYunt/DOaPHqLbVl54jL7Q==
X-Received: by 2002:a17:90b:3807:b0:1c7:6cd5:cb3f with SMTP id mq7-20020a17090b380700b001c76cd5cb3fmr2175163pjb.201.1648522194435;
        Mon, 28 Mar 2022 19:49:54 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id d5-20020a633605000000b0039815688655sm8525212pga.0.2022.03.28.19.49.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Mar 2022 19:49:53 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 2/3] pack-bitmap.c: add "break" statement in "open_pack_bitmap()"
Date:   Tue, 29 Mar 2022 10:49:49 +0800
Message-Id: <20220329024949.62091-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.577.g74cc1aa55f.dirty
In-Reply-To: <YjzAbSJfuu06smnD@nand.local>
References: <YjzAbSJfuu06smnD@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 24 Mar 2022 15:03:09 -0400, Taylor Blau wrote:

> The lack of a break here is intentional, I think, since having more than
> one bitmap of the same kind in a repository is an error.

Yeah. I quite sure that it's intentional now.

Thanks for your explanations.

> (This is behavior we inherited from the pre-MIDX bitmap days, when
> having more than one pack bitmap caused Git to signal an error, since it
> could only use the results from a single bitmap).
> 
> You can see in pack-bitmap.c::open_pack_bitmap_1() that we have a
> condition saying:
> 
>     if (bitmap_git->pack || bitmap_git->midx) {
>         /* ignore extra bitmap file; we can only handle one */
>         warning("...")
>         close(fd;)
>         return -1;
>     }
> 
> We do want to call that open_pack_bitmap_1() function on every pack we
> know about to make sure that one and only one of them corresponds to a
> .bitmap.

Yeah, the condition and "warning" make it clear to me which is if already
exists a bitmap of the pack or MIDX is ready, we will give warnings and just
let it fail (return -1 means a return of NULL in "prepare_bitmap_git()", and
will then die() in usage cases I found).

In addition of above, I had a question that why we need "bitmap_git->midx"
in the condition? Because here in "open_pack_bitmap_1()" we intent to open the 
non-midx-bitmap and it's after we deal with "open_midx_bitmap()" in "open_bitmap()":

static int open_bitmap(struct repository *r,
              struct bitmap_index *bitmap_git)
{			      
	assert(!bitmap_git->map);

	if (!open_midx_bitmap(r, bitmap_git))
	   return 0;
	   return open_pack_bitmap(r, bitmap_git);
}

So if I understood correct, maybe we can made condition of "bitmap_git->midx" a little
earlier so that we can avoid to open every packfile,  maybe it's like:

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9c666cdb8b..38f53b8f1c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -483,11 +483,12 @@ static int open_pack_bitmap(struct repository *r,
 
        assert(!bitmap_git->map);
 
-       for (p = get_all_packs(r); p; p = p->next) {
-               if (open_pack_bitmap_1(bitmap_git, p) == 0)
-                       ret = 0;
+       if (!bitmap_git->midx) {
+               for (p = get_all_packs(r); p; p = p->next) {
+                       if (open_pack_bitmap_1(bitmap_git, p) == 0)
+                               ret = 0;
+               }
        }
-
        return ret;
 }


Thanks.
