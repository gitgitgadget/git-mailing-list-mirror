Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A9C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLNTRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238571AbiLNTRt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:17:49 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757F2B18B
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:48 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d2-20020a170902cec200b001899479b1d8so3229780plg.22
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oh6eC7nczfqI9ZFU06PBM2rWUyGCq0Sqke20SrYN4Qk=;
        b=emjuUa2ygAM/JB16MLhmXT0O/nareVKnRGoZdtHJ78t/BeObRxN3P+8hjGDvNSw2uJ
         L+kWmPbziK7vkO3vMOhQ4UcPlDweAKhbq0gHivuQWb+DovqrIyxz3mManLDOfPpjmS9J
         QCcDRLi9GX7em58y6zmpqEsJAHmfSnZ550SDWpj5hHLMEvzTD0eflqj0PNn0CZvsJg51
         5Jt8oCFdREyH99yYKLvFAbFTX1Hh9UrFFYQSPLusfN8pC72N96sBV5vKtvAM5N5Xpo8O
         BwZgzEfdHVTwXWFKLwCHVaBFNEyG8VBWTODny0+uIs1a02r7tHEmKwasxEoAun8BODeX
         sJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oh6eC7nczfqI9ZFU06PBM2rWUyGCq0Sqke20SrYN4Qk=;
        b=trwqXqi/xM600aHE1jc4FEsbc5F8PlzyJ7HdQuxewp9wwATA+awkjEedxOqnWj99vT
         vFFGTzBZ3dMsyzF9CIRfXGmRaIvNz2NeaQfJvpwumMhXrY9E/7wSec8UK/jyigxiJA1v
         SjseRQZE1Nuv/yaYFXrOu/O5J9NWY85dttSkVj1iZG9TpP72rYj/Mp9B/lJONrvu0p4u
         JvqdSPQE/Je/YtwsjRC9xkF6rutwa4PwlQMESwFsuyr34VAeY0hoY1NZ/IXMdOlFzsJP
         clBqm6WDKlUskYemfXdwxcC3oQ9pdgwv3pLj1UZi69XJ+IgnYI+8sQNv8aEo6u2Zj2ln
         tcyA==
X-Gm-Message-State: ANoB5pkZj6keJASMTXaugv0YwfspLvipY9+QWJBY6F66ozf8EuRkqC5h
        EMLJtVi50lDX/wQ4pRIpjtq6d91bhgOmFqCiFxuDn7rKkzHy2Pr9MmjzrYtV3dpfeBJza4ACJ9K
        pzIkM2L0fAfelBvNfQKOlmYjfHVY8k7uD8WBtN9ddMmXjnS3WNErAyUaaHcFILoq78sSWA0qMUQ
        c3
X-Google-Smtp-Source: AA0mqf5DBg6Keg+R7lZZ3j4XEfZFQWMT7hH+FLPS4SRhHzEPxKzai1+3YkbSsCpa8y8fHnJPS4MeGN1jgaDWZ06DhzOD
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:e301:0:b0:577:d5ac:8561 with
 SMTP id g1-20020a62e301000000b00577d5ac8561mr2284626pfh.15.1671045467464;
 Wed, 14 Dec 2022 11:17:47 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:17:39 -0800
In-Reply-To: <cover.1669839849.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1669839849.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <cover.1671045259.git.jonathantanmy@google.com>
Subject: [PATCH v6 0/4] Don't lazy-fetch commits when parsing them
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks everyone once again and sorry for the churn. Hopefully I got it
right this time.

open_loose_object() is documented to return the path of the object
we found, so I think we already have that covered (if we detect that
an object is corrupt, it follows that we would already have found the
object in the first place).

Jonathan Tan (4):
  object-file: remove OBJECT_INFO_IGNORE_LOOSE
  object-file: refactor map_loose_object_1()
  object-file: emit corruption errors when detected
  commit: don't lazy-fetch commits

 commit.c       |  15 ++++++-
 object-file.c  | 108 ++++++++++++++++++++++++-------------------------
 object-store.h |   7 ++--
 3 files changed, 69 insertions(+), 61 deletions(-)

Range-diff against v5:
1:  be0b08cac2 = 1:  be0b08cac2 object-file: remove OBJECT_INFO_IGNORE_LOOSE
2:  4b2fb68743 = 2:  4b2fb68743 object-file: refactor map_loose_object_1()
3:  a229ea0b11 ! 3:  811620909a object-file: emit corruption errors when detected
    @@ object-file.c: static int loose_object_info(struct repository *r,
      	int status = 0;
     +	int fd;
      	unsigned long mapsize;
    -+	const char *path = NULL;
    ++	const char *path;
      	void *map;
      	git_zstream stream;
      	char hdr[MAX_HEADER_LEN];
    @@ object-file.c: static int loose_object_info(struct repository *r,
      		break;
      	}
      
    -+	if (status && path && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
    ++	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
     +		die(_("loose object %s (stored in %s) is corrupt"),
     +		    oid_to_hex(oid), path);
     +
4:  b54972118a = 4:  8acf1a29e7 commit: don't lazy-fetch commits
-- 
2.39.0.314.g84b9a713c41-goog

