Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4369F20365
	for <e@80x24.org>; Tue,  3 Oct 2017 10:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751409AbdJCKW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 06:22:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55046 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdJCKW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 06:22:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id i124so15773534wmf.3
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=Y8UzvSi7VNKlyun9zTmSQrqVpVzeoWZue9E66BLjWKo=;
        b=uGF9Ci+hCQf7EIQc346tFleOU3VVeZhx69WTgWpncLXxPFOUkvmZkqZLygDJrak4ML
         rcBTPS2xOaMx7d75V4F19ZR72vqwbiX+vJeut9n9oVH+rTXhcgYwvYn2C1cWZpIFXipm
         fkrMEHPdGevukytSZEx89cYGQ0nDPvg/aN/laAroV9yw8XMN3TCycyxRlul3LCjNKxyK
         7nfZN2F2HUcGPMHquscxpHczrdC2JwcI1zDVv30z6fVs9Vhfbo2R81jZTOIv08jlK+fg
         4pvmHRfbtzeaR06H1r9ZE3ORbcYUOqcae8mLOatP94heh5j1bC5fJyQ/2zwfrMPfbekC
         FiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=Y8UzvSi7VNKlyun9zTmSQrqVpVzeoWZue9E66BLjWKo=;
        b=N0KD0jFfWZk2lzL0NjE1zJPl1NINi5DennTV+ZxgRE7IQCcZ5BIX/3eQoV6NRhWNrR
         a/b6Vp/GC/0ZLZbs6NGBv1mi/npEmNh6DPLgcMT+PDcA9Ugsj5xVw1L0gEqsYBSCdmyG
         9IzhGVw4+qI3MrjL5Jzp/M9rO3WyjUE4sQRs6qb8hiasFm6XFeM6BpQE+Y/Bm1E2Oq9M
         NSBn/bX1e5qSyxKoFPwRYAzuGymClYMH9VnP2ZapzXdQnzKitBuGOi63/XhG6RfvoDCZ
         Fj6k9NMCoYnlLwtU/84G2OzCr8p/Xowv2EBUqidc2chIqtYKn9Ani4IdqObD2Uf2WVgd
         DgvQ==
X-Gm-Message-State: AHPjjUhV95XTd2gJgHLjgZFeSFE9yrk8pzFpSwR+ePxGYEmKRe55D9mm
        w8KGRWQ9ZFDecomLK5sr0dyGDg==
X-Google-Smtp-Source: AOwi7QBp051zni/hp4+DZkRkdTcOyEAAhr6OyBGTn0/ZdyDKwasclvK10/7K+s6+tZ+35UrSIT5lqw==
X-Received: by 10.28.48.71 with SMTP id w68mr13512877wmw.3.1507026146825;
        Tue, 03 Oct 2017 03:22:26 -0700 (PDT)
Received: from localhost.localdomain (x4db1f0e1.dyn.telefonica.de. [77.177.240.225])
        by smtp.gmail.com with ESMTPSA id p77sm9504723wmd.28.2017.10.03.03.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 03:22:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] tag: avoid NULL pointer arithmetic
Date:   Tue,  3 Oct 2017 12:22:15 +0200
Message-Id: <20171003102215.9952-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.14.2.815.gce07940e3
In-Reply-To: <99e56671-bdf9-a59f-ae7b-758f1b7a8f14@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> lookup_blob() etc. can return NULL if the referenced object isn't of the
> expected type.  In theory it's wrong to reference the object member in
> that case.  In practice it's OK because it's located at offset 0 for all
> types, so the pointer arithmetic (NULL + 0) is optimized out by the
> compiler.  The issue is reported by Clang's AddressSanitizer, though.
> 
> Avoid the ASan error by casting the results of the lookup functions to
> struct object pointers.  That works fine with NULL pointers as well.  We
> already rely on the object member being first in all object types in
> other places in the code.

This sounds like the main goal of the patch is to avoid an ASan error,
but I think it's more important to avoid (and to be more explicit
about avoiding) the undefined behavior.  I.e. along the lines of
s/In theory it's wrong/It's undefined behavior/ and
s/ASan error/undefined behavior/

Furthermore, fsck.c:fsck_walk_tree() does the same "immediately
reference the object member in lookup_blob()'s and lookup_tree()'s
return value" thing.  I think those should receive the same treatment
as well.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  tag.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tag.c b/tag.c
> index 7e10acfb6e..fcbe012f7a 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -142,13 +142,13 @@ int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
>  	bufptr = nl + 1;
>  
>  	if (!strcmp(type, blob_type)) {
> -		item->tagged = &lookup_blob(&oid)->object;
> +		item->tagged = (struct object *)lookup_blob(&oid);
>  	} else if (!strcmp(type, tree_type)) {
> -		item->tagged = &lookup_tree(&oid)->object;
> +		item->tagged = (struct object *)lookup_tree(&oid);
>  	} else if (!strcmp(type, commit_type)) {
> -		item->tagged = &lookup_commit(&oid)->object;
> +		item->tagged = (struct object *)lookup_commit(&oid);
>  	} else if (!strcmp(type, tag_type)) {
> -		item->tagged = &lookup_tag(&oid)->object;
> +		item->tagged = (struct object *)lookup_tag(&oid);
>  	} else {
>  		error("Unknown type %s", type);
>  		item->tagged = NULL;
> -- 
> 2.14.2
> 
