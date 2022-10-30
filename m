Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA5ECAAA1
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 23:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJ3Xmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 19:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ3Xmt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 19:42:49 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11F99FED
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 16:42:48 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o2so5532027ilo.8
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gUqpbIAg9S3VSSQ8WCBx+UaSF96swpb+KIWApz7mlRI=;
        b=R04oXqGMVRk5XDBaB6/a+yvrL7aFH2vcRQfV4WeBsYIGSdpOnNt1W7Fg/yaLL1NNTv
         rD11qlHEE11UWam+joK+QBpB6nHWX4otytK6/ZT5WrlfbaX6kgOQvGQ+Un0hKEHW/0ep
         8Wbv32sd9DCyo5zI+MevyVdPcahLSA+DcQZE39sUgaBG8tWQ1MLs+ptTX8D4CvDquVxr
         768YgoQ/a5oNIlH6FmMusNwIGAnufQnx0UIHq395QykXsi9UR4KUamw+nsOP1x8b4jsD
         r7X3IQtdyc1qPjojWxfcDHFh/aZ/AuDA0goBeYTkBJOjInSotjH1aO67pGMWlLj9M9L3
         OIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gUqpbIAg9S3VSSQ8WCBx+UaSF96swpb+KIWApz7mlRI=;
        b=GAh1FtNg242zceowE3F84Dz/H3xn3T+i58G/v95QZP/pquZsCjH0m0GB4M6qTCX6rr
         PdgbLEDk6BGoUDygvBnQVzlvgDiYi15rk6+44mDfhIBfMKLxpzBkbHln4YKfrrsomTsF
         9xByLLCPRyIxpHCpJmkR47bnd8tWVPbVRvT0JUdz9tEQ0SpM2SB0Za+xUfKt+QZSybXO
         wkOoJGK6fdXIgR+oNdbEP42kLLYesk2+7KDQWv5LpIW8MlVLvpSJW3ecOOSbNxXqYRqX
         eqyu5+NrgPPv2kJ9g073GbQXg4lWRoHr4LRV26NwFHUtElORziyUEAjCbCEb4mXHZRRe
         G4Rg==
X-Gm-Message-State: ACrzQf3MgCVAPtpRD7ZyX9m/fDObIRuOoTe6o/sYASzeNJUmqAhqatLz
        KqILc0IuQ1Uzs7PBU8NU4imLWg==
X-Google-Smtp-Source: AMsMyM7iwGrmuXIsWm30sxdXDDXciBAHOjjO2gjY3hci4LSkEvdlgtlkpIIbyRfTjjFJ78HxKcEotw==
X-Received: by 2002:a05:6e02:152e:b0:2f9:e082:7fc7 with SMTP id i14-20020a056e02152e00b002f9e0827fc7mr5270812ilu.167.1667173367968;
        Sun, 30 Oct 2022 16:42:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z26-20020a05663822ba00b0034a6d12aa25sm2159315jas.4.2022.10.30.16.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 16:42:47 -0700 (PDT)
Date:   Sun, 30 Oct 2022 19:42:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Taylor Blau <me@ttaylorr.com>, GitList <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: Re: [PATCH 1/1] pretty-formats: add hard truncation, without
 ellipsis, options
Message-ID: <Y18L9k0vAw1CArjw@nand.local>
References: <20221030185614.3842-1-philipoakley@iee.email>
 <20221030185614.3842-2-philipoakley@iee.email>
 <Y17PS/2LgRIJKGoo@nand.local>
 <85f56b56-74c5-ffe5-703f-ef0c1e6d3b45@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85f56b56-74c5-ffe5-703f-ef0c1e6d3b45@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2022 at 10:01:47PM +0000, Philip Oakley wrote:
> > If I remember correctly, strbuf_utf8_replace() supports taking NULL as
> > its last argument, though upon searching I couldn't find any callers
> > that behave that way. Can we use that instead of supplying the empty
> > string? If not, should we drop support for the NULL-as-last-argument?
>
> I wasalso  concerned about zero length strings but my brief look at the
> code indicated it could cope with a zero length string.
> The last param is `const char *subst`.
>
> I've just relooked at the code and it does have a
>
>      if (subst)
>         subst_len = strlen(subst);
>
> so it does look safe to pass NULL, though it would probably cause a
> pause for thought for readers, and isn't likely to be that much faster
> in these format scenarios.

I'm not worried at all about speed, I was just wondering if there was a
more designated helper for "truncate these many UTF-8 characters from
the end of a string".

It appears that passing NULL to that argument behaves the same as
passing "", so I was wondering if it would be clearer to use that. But
I'm fine either way. If there are no callers that pass NULL, then we
should consider something like the following:

--- 8< ---
diff --git a/utf8.c b/utf8.c
index de4ce5c0e6..e8813f64fe 100644
--- a/utf8.c
+++ b/utf8.c
@@ -361,10 +361,9 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
 	char *src = sb_src->buf;
 	char *end = src + sb_src->len;
 	char *dst;
-	int w = 0, subst_len = 0;
+	int w = 0, subst_len;

-	if (subst)
-		subst_len = strlen(subst);
+	subst_len = strlen(subst);
 	strbuf_grow(&sb_dst, sb_src->len + subst_len);
 	dst = sb_dst.buf;
--- >8 ---

Below the context there is another "if (subst)", but that one needs to
stay since we only perform the replacement once.

Thanks,
Taylor
