Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A79BA1F463
	for <e@80x24.org>; Sun, 22 Sep 2019 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbfIVTxS (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 15:53:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37995 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfIVTxS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 15:53:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so7002915wmi.3
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4yhC+EIEUELslhFpBzbDY6mDQgh1d6AD36V/omuuVPU=;
        b=JrsmKaEavkOjXlpHjs6iYCbdZDalbNtRjBNeGV0ZTm8Ty3pCTdbzbwWLH9gJYsZte6
         LTSL8meFUKhSklF87oPc8J+3gjak35IHWE4sKKN2o/YY5bmNMdkHVxEc41CH0OW/lWqL
         yEMHM7a5SVcHWmpKRk3o5T89jxgH/AW2JKarBzNIzVw9I91vLVFsRFycGyeivX1tOw63
         N0B/vt667QEoQsvFcw+CkT0PvSoGL7tVPSNauw2NYzqYkINgksn35nH7Ktv6G9Av3drt
         A6sTVMJXMPwmJnsqWOav3IVbPL44rraaWJ4kdp1sKw2+9mj2cFtCCQFxTqtvR04awC7Z
         w7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4yhC+EIEUELslhFpBzbDY6mDQgh1d6AD36V/omuuVPU=;
        b=YvdZH3hXz3J8pMNhCpEhLa/jHLviI80luBr6WIO4gTcdSrJJqoz82udPmnqmLq11jd
         wO/YQWCbaHrJ5ufzUUNYRUuemx03GWx3jTiVRayNFbMEvXlNrT887HOgjSoICsCQ/ZQ2
         EopmOGvhrKouqcN4vGMPvipMsWztNpXJrvyrWSannWTgvSFnBP+VOqpvwQr6c2xNYSfe
         5WPkX991nha9gWY3q43vji0aSCpcZtVQtQ/2Zx645SHv1aoHXB9+kqQRss1EMRSDsST7
         GtbcPNho6og8qdfTwsFNiL9Z8e6lymPVYqg8cCLetU/tK63LRy3HR7cW5Mc9XVLA7MgO
         9/Jw==
X-Gm-Message-State: APjAAAVLL5jkF0SPde8qCAkgsDZqaaJWqCkramges0jQQgC6AgdPYoWf
        9kMHUpocvLl1Zpj/eXpGfNw=
X-Google-Smtp-Source: APXvYqyLG9vLAzQOyHVUtRqY35wD+GPWwmsEkygEzxMrRQFVF2H2g+zJ3h/85VrTe2Kcz/FG4rPJVQ==
X-Received: by 2002:a1c:984b:: with SMTP id a72mr11184238wme.149.1569181995800;
        Sun, 22 Sep 2019 12:53:15 -0700 (PDT)
Received: from szeder.dev (x4dbd3787.dyn.telefonica.de. [77.189.55.135])
        by smtp.gmail.com with ESMTPSA id n8sm12465222wma.7.2019.09.22.12.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 12:53:14 -0700 (PDT)
Date:   Sun, 22 Sep 2019 21:53:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] name-rev: avoid cutoff timestamp underflow
Message-ID: <20190922195312.GC10866@szeder.dev>
References: <20190922180143.25026-1-szeder.dev@gmail.com>
 <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5692e751-ae5b-e1c8-e5f7-79f0b43e20c0@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 22, 2019 at 07:57:36PM +0100, Phillip Wood wrote:
> On 22/09/2019 19:01, SZEDER Gábor wrote:
> >When 'git name-rev' is invoked with commit-ish parameters, it tries to
> >save some work, and doesn't visit commits older than the committer
> >date of the oldest given commit minus a one day worth of slop.  Since
> >our 'timestamp_t' is an unsigned type, this leads to a timestamp
> >underflow when the committer date of the oldest given commit is within
> >a day of the UNIX epoch.  As a result the cutoff timestamp ends up
> >far-far in the future, and 'git name-rev' doesn't visit any commits,
> >and names each given commit as 'undefined'.
> >
> >Check whether substacting the slop from the oldest committer date
> >would lead to an underflow, and use a 0 as cutoff in that case.  This
> >way it will handle commits shortly after the epoch even if we were to
> >switch to a signed 'timestamp_t' (but then we'll have to worry about
> >signed underflow for very old commits).
> >
> >Note that the type of the cutoff timestamp variable used to be signed
> >before 5589e87fd8 (name-rev: change a "long" variable to timestamp_t,
> >2017-05-20).  The behavior was still the same even back then, but the
> >underflow didn't happen when substracting the slop from the oldest
> >committer date, but when comparing the signed cutoff timestamp with
> >unsigned committer dates in name_rev().  IOW, this underflow bug is as
> >old as 'git name-rev' itself.
> >
> >Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> >---
> >
> >This patch adds a test at the end of 't6120-describe.sh', so it will
> >conflict with my non-recursive name-rev patch series, which adds a
> >test there as well, but the conflict should be wasy to resolve.
> >
> >   https://public-inbox.org/git/20190919214712.7348-7-szeder.dev@gmail.com/
> >
> >  builtin/name-rev.c  | 15 ++++++++++++---
> >  t/t6120-describe.sh | 15 +++++++++++++++
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> >
> >diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> >index c785fe16ba..a4d8d312ab 100644
> >--- a/builtin/name-rev.c
> >+++ b/builtin/name-rev.c
> >@@ -9,7 +9,11 @@
> >  #include "sha1-lookup.h"
> >  #include "commit-slab.h"
> >-#define CUTOFF_DATE_SLOP 86400 /* one day */
> >+/*
> >+ * One day.  See the 'name a rev close to epoch' test in t6120 when
> >+ * changing this value
> >+ */
> >+#define CUTOFF_DATE_SLOP 86400
> >  typedef struct rev_name {
> >  	const char *tip_name;
> >@@ -481,8 +485,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
> >  		add_object_array(object, *argv, &revs);
> >  	}
> >-	if (cutoff)
> >-		cutoff = cutoff - CUTOFF_DATE_SLOP;
> >+	if (cutoff) {
> >+		/* check for undeflow */
> >+		if (cutoff - CUTOFF_DATE_SLOP < cutoff)
> 
> Nice catch but wouldn't this be clearer as
>   if (cutoff > CUTOFF_DATE_SLOP) ?

It would only be clearer now, with an unsigned 'timestamp_t'.  I
tried to future-proof for a signed 'timestamp_t' and a cutoff date
before the UNIX epoch.

> >+			cutoff = cutoff - CUTOFF_DATE_SLOP;
> >+		else
> >+			cutoff = 0;
> >+	}
