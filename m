Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9EDC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiLLWuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbiLLWt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:49:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC292BD8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:48:56 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-39afd53dcdbso147329347b3.8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOnUOH4d+rUWGx26Gwc7+ZPfAP4srmk8mPKvmuGACZQ=;
        b=MkaJXUbc4TAJiAxAbtj/tMW4wf8U0aFdSPAfqIGPm2/IAo2ruHEMV6zX95DriatDc0
         TJ6tkalITbFqiRduKxtoNdW4PDR1Snn1u5M+OinSNTH2d/rggJnKLFV1hTcgf0OaagTY
         pT+iwoiw7Qlqx2NaWwGpZKfOfts8Mb8vEzzCqWnLZOyXoh7dbpLFV6Bq6Udar+XWaEbL
         mFalX13X3j2UMT/CDAKhuZ2OG6cQtqb/qNMjmbOcZLjN9AeKRWvDqhdAHr8VuuCcNWZc
         3F9OIOqgKAFcAel8QCymv09FnuDiraAnZtVSlVpyCwPTJKyc9u1KyAWXmIfWEE9d1tiT
         Z43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOnUOH4d+rUWGx26Gwc7+ZPfAP4srmk8mPKvmuGACZQ=;
        b=mVS2x7gZiFDSGV9Mz4x637TY3caEcWcoqxC3gY3FUv6zPHbOFuNvXXOTXShVVbxuSP
         dbv05ZmxB7eX7yYtnvHZRpLntnagQCYW3DjrxN4kfqfWUL8BAh+GXWQNuORWcxmGpFBB
         29kVZOdwacfvuhUfj3mGx40zf29IMHSjxgK4hDZac5BO8Wd128RHM+B8dYpNU8gCQ9l6
         ZrUvTlEjaorwg4PF5ltGDdiyd2Yi78mpEgO3KOq50YXWhBNuCuxcmPgOimnkq5qENLTS
         puyylriR3CigOitHZvYrIUaJHJBZktBtchblqKaWjCDmoQFEZPJcxvaRPr1SU0aoc5LC
         tZVg==
X-Gm-Message-State: ANoB5pnpnN2+rZi4us7djLM2wq5cenOCawjGeWANxj/102NJrjNOPy9G
        MIiFxZCWxzxFda10WjHnrBgXarRJY8wmh/7guD9M+nzKzguQnNVf80UFH+h4bEpMZjha/HanU9k
        sp0AEgnQqwW4guDexj5s5XB0zBcn45Xmu6hxXbnbBtlGPnQttY1zApHDrmNBihxe7gonU9nc/hV
        vX
X-Google-Smtp-Source: AA0mqf7PIXsDsH702StMG1jIBUQTgfu/dFVrBRAy8nr3YWU/x+toq4X+E+x7qr4h2PfNUPUhxMU8AvvLYyid4Gxf3P20
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:6981:0:b0:70b:1577:e9e0 with
 SMTP id e123-20020a256981000000b0070b1577e9e0mr6409379ybc.230.1670885336123;
 Mon, 12 Dec 2022 14:48:56 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:48:47 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <cover.1670885252.git.jonathantanmy@google.com>
Subject: [PATCH v5 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone for taking a look. Here's a reroll with safer path
handling.

Jonathan Tan (4):
  object-file: remove OBJECT_INFO_IGNORE_LOOSE
  object-file: refactor map_loose_object_1()
  object-file: emit corruption errors when detected
  commit: don't lazy-fetch commits

 commit.c       |  15 ++++++-
 object-file.c  | 108 ++++++++++++++++++++++++-------------------------
 object-store.h |   7 ++--
 3 files changed, 69 insertions(+), 61 deletions(-)

Range-diff against v4:
1:  be0b08cac2 = 1:  be0b08cac2 object-file: remove OBJECT_INFO_IGNORE_LOOSE
2:  4b2fb68743 = 2:  4b2fb68743 object-file: refactor map_loose_object_1()
3:  07d28db92c ! 3:  a229ea0b11 object-file: emit corruption errors when detected
    @@ object-file.c: static int loose_object_info(struct repository *r,
      	int status = 0;
     +	int fd;
      	unsigned long mapsize;
    -+	const char *path;
    ++	const char *path = NULL;
      	void *map;
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
    @@ object-file.c: static int loose_object_info(struct repository *r,
     +	fd = open_loose_object(r, oid, &path);
     +	if (fd < 0) {
     +		if (errno != ENOENT)
    -+			error_errno(_("unable to open loose object %s"), path);
    ++			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
     +		return -1;
     +	}
     +	map = map_fd(fd, path, &mapsize);
    @@ object-file.c: static int loose_object_info(struct repository *r,
      		break;
      	}
      
    -+	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
    ++	if (status && path && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
     +		die(_("loose object %s (stored in %s) is corrupt"),
     +		    oid_to_hex(oid), path);
     +
4:  1a0cd5b244 = 4:  b54972118a commit: don't lazy-fetch commits
-- 
2.39.0.rc1.256.g54fd8350bd-goog

