Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E6C32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 08:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIUIL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIUIL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 04:11:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD8386FEE
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 01:11:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so5054263pjl.0
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SCt4ye3CVHSWoGm0Li0WZqpbcpItnzXLBdV04PgYQbI=;
        b=EU5io+GVxjyQDbh1jLDE7E2z0LhEBvTT+gI2u2S+4U+ab5sNN7ldk3tEI8sR8uVWti
         zayejWKp4YHqTEeQ/dmr5ACRS6rq9hEsyrfpvK+HbI37cTRdTPkiDIGzEZd8AJy1vlEV
         FCqkv0IPUvV2EFN2Xdkg8Q3oO8X+UgDe0BAZGorcGbh6FFrMhZMT8OSNf84jpB/aN85z
         U4EeZq0a550co0HXWTJ1vtXu03lYZnxDGeNkWv7OTwmDuMBGj5KraNK3JlMcKBC/XLAG
         HjjcM8ecIj8IcRTNu0RV2jzvWv59rvTZNqZ6vpl+wUe3fR2wLRT2eVucZ5Qm+w01scVB
         GURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SCt4ye3CVHSWoGm0Li0WZqpbcpItnzXLBdV04PgYQbI=;
        b=GNNkCA5JPsiYHxsTH/DbRsmeaWc9YXSIFKQQf3ENC2ovw6vL7N6QLFZi40F9b49raJ
         BCmIs9QLRFMvjAEl2aFyh2WvikroriIXNb8DyVh0jUQJJYg3sfh881nkziUSq1lL01cz
         4WK19c5mgcoWJNT7zaN0ZeHMcf6UFtYS1yJL6UHzqdgbzpfkc9P+QsCbWNcLP2i5R3IH
         3k5VgG4Sj4gZjvZI6dAK3pboro3Tq/aHNzqJlA2uoaNpgdvaOu3uGYg8Lkxxeo5ihR03
         CRjrgNMN0noYa+SuF1dW0hq9Ztyq7qR34xL0sQVncyUwPwEL6TFeTRBP1fpomi0SZoDS
         Si5g==
X-Gm-Message-State: ACrzQf092eZDgcmee59EArCWJ7g0a6EzUkhZV+j6qq9kc2pDJUdd2y69
        cvOz80rkQj+cocUR7AkP7H0=
X-Google-Smtp-Source: AMsMyM4hX/ZgGJTS/CHszIjZzH4b+bJlfAb0R2MDNyeOgq9gEyPaEPMzN7e8u9cQ8FzLVwrUPTTMjA==
X-Received: by 2002:a17:90b:1b07:b0:203:5860:b441 with SMTP id nu7-20020a17090b1b0700b002035860b441mr8155739pjb.103.1663747885957;
        Wed, 21 Sep 2022 01:11:25 -0700 (PDT)
Received: from localhost ([2001:ee0:5008:db00:84c8:158c:9494:ee57])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709027b9600b00177faf558b5sm1281106pll.250.2022.09.21.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:11:25 -0700 (PDT)
Date:   Wed, 21 Sep 2022 15:11:22 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Skrab Sah <skrab.sah@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: what if i use makeheader tool to generate c header file, it
 would be accepted.
Message-ID: <YyrHKmNIoV70sATE@danh.dev>
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
 <220919.86zgev635z.gmgdl@evledraar.gmail.com>
 <xmqqbkrbb6ua.fsf@gitster.g>
 <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
 <220920.86illi5p6w.gmgdl@evledraar.gmail.com>
 <CA+J78MUM=JiAF7R_8oV23OQ-LndJbRm4AUdPsgS4HT4SduFgiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+J78MUM=JiAF7R_8oV23OQ-LndJbRm4AUdPsgS4HT4SduFgiw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-21 13:23:11+0530, Skrab Sah <skrab.sah@gmail.com> wrote:
> 1. We would not commit the generated file.
> 2. There are different ways we can install the makeheaders tool.
> 3. Makefile will first generate the header file then other compilation.

Without seeing the patches, here is my guess, you will make us only
write source code in '*.c' and extract declaration from foo.c to foo.h
And that will save us some time to write (and update) declaration in foo.h

However, whenever foo.c is updated, foo.h will need to be
re-generated, thus all other users of foo.h will need to re-compiled.
Thus, increase compilation time. We can work-around by write the
output to foo.h+ and compare to foo.h, discard it if its content
hasn't been changed. It still takes time to analyse foo.c and write to
foo.h+

In addition, I'm not sure where would you put the struct, enum,
preprocessor declaration, and compat stuff.

If my understanding is correct, it's not worth the effort, IMHO.

-- 
Danh
