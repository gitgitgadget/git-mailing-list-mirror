Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48BFC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 19:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiKOTzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 14:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiKOTyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 14:54:49 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2648D27CFF
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:54:48 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d3so7998508ils.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 11:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6Y/8p+BYw85JbViCIz80MB3COhEnQj9D7x3z24eo+AY=;
        b=EZNUVZOY5EWkxppasPv97oME6xYoKKWyNW/WGFpYF3AO2nPY13IlAkSe2PiQdw+oYI
         90NDoW6S0d+m8q7oqZ/Si+2qn5YTK4VfFSJ2JUpih3G/4XBbn/dF3O0C882UIkJ/iR5s
         5BoEghCw0b3ZwpltdZ/0lRheGW5YbaSDgIwHEDZ7vLUjww73xlPl4RfpWRjBntt5YoC3
         Sk5iGWt9K5bArZUa27Sw45XPB4MvAzaFgE00KWu7+hIabRdMRqgdlBlE6WgJf3wUt/of
         fTNZ/Gmqrdflhb0/zbcV0qEhvbRo2EP43yNCtbXu6by5Y5+jnVJhueucXWroG//kZzn5
         n91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y/8p+BYw85JbViCIz80MB3COhEnQj9D7x3z24eo+AY=;
        b=xOaiAp08iQ+xeVTPE1QGNa4zrxbB0jAfRH7Us0P6n2X9IPpsTPx2JG+8ZFgNRYlPMW
         fchGZBb3zt/FGLVdfKS6uk3RumzRv5Jf8+bv+ChvTAPTVa8AbjbDboLvTz7ePm9WRFDp
         +cGopGLop0lGN4hdZmk3XM3zRhm3VRrf0sSAf7xK+qJdKybpE5fR04DfVgIltWH0PAzb
         EuqhuByd7IWZx8IbG9MT30z2usa8C2mT8xAhqrA+GWmHfkzJMWSckDC8p68B30sttQnY
         s0bYX53XWhi9B63r4cBnnDaDN8RDtrCWebYDBLKIF11XFP8WoLOFzDMQS5BPINVcM8Ge
         z/pA==
X-Gm-Message-State: ANoB5pn8srT/HXP1GXxGXekPOlR3hM0KVd9gubh/Pu3JQnwa8sRSPEuW
        H7gI+qujEd7oKaZaZkwmHfeAoQ==
X-Google-Smtp-Source: AA0mqf74zTC4oU/cvWQwds1tw14cEfWAuGDW2NVa5RriCYzIqJ9+5djvbLBL8hTofppaz9/nz+YTWA==
X-Received: by 2002:a05:6e02:109:b0:2fa:b6c0:80fc with SMTP id t9-20020a056e02010900b002fab6c080fcmr9515009ilm.92.1668542087553;
        Tue, 15 Nov 2022 11:54:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a59-20020a029441000000b003712c881d67sm5042341jai.164.2022.11.15.11.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 11:54:47 -0800 (PST)
Date:   Tue, 15 Nov 2022 14:54:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
Message-ID: <Y3Puhtj8Q8kf2wt0@nand.local>
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
 <221115.86r0y4j8tr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221115.86r0y4j8tr.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2022 at 08:41:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > I am disappointed in myself for finding this only after I pushed out a
> > hotfix to 'next' and rebuild the downstream branches.
> >
> > This should be a minimal fix on top of Ævar's patch to get 'next'
> > building again.
>
> I'm also disappointed in myself, sorry. I *did* test it locally with
> valgrind, but obviously fat-fingered it somehow and tested the wrong
> version. Sorry!

It's OK. Let's not beat ourselves up too much, and instead focusing on
making sure the quality for the next pushout is higher (which is more on
me than it is on you).

> >  builtin/gc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index d87cf84041..38882a1e35 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
> >  	int found = 0;
> >  	struct string_list_item *item;
> >  	const struct string_list *list;
> > +	struct config_set cs = { { 0 } };
>
> Just "{ 0 }" here instead? I see it may have been copied from some older
> pre-image though, and they'll do the same in either case, so it's not
> important...

Copying from other zero-initializations of `struct config_set`:

    $ git grep -oh 'struct config_set.*= {.*' | sort | uniq -c
          3 struct config_set cs = { { 0 } };

Thanks,
Taylor
