Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0098CC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 12:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiHWMt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 08:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbiHWMtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 08:49:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7052D6EF10
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:56:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w19so26365698ejc.7
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=uUNgNj5WMYgXtV78i+GbGDkjwI/afpolE7klvidXxow=;
        b=U4K5hJ+CLxvlOF7YG19rTHGHNcbhiMBLX3ja4juyedezeecdyFSPtuxR7lowuDAmlQ
         +2wUF8RiOM5pdU92kY4T6peF6CJiTH3126FlPiBAj1YcA/E8BsVUnJGmlOF+IybU7nxA
         N9H1xI5Gh8KK51A+l8Idaxq9yL9YdXPJx2kdWC2MPGwdp3H3BmNSVUT8vWvBFPlPnBje
         IZUgGMcx97+dx9dk0Ip6cV3jexuE3TFRaVSMH9y4w38vSMFOexKJmqW0VP3bTtHlTaeM
         y6B6GrWRX4sSHFECHtAfcdKN83mkLSEGztdvz/g3t+pKMJmiiJCnoDVxcPfoc4X7d60/
         52IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=uUNgNj5WMYgXtV78i+GbGDkjwI/afpolE7klvidXxow=;
        b=3r5aK+hBa1UfgwdE2clVuv69ZprwiRf7x+IFpGMhfCxLmQOxsfT9QgwT9QpgMlDLee
         3iunPteHrYPp9/E18Zh5C1Al2wVzKxWLcbwPb4fmHc8NwfKj38Bz+FX6g2CiALPkZUpH
         yCNJt0JMsR3ubyRflfeb2er4sEq5uc7urssQ3Yb1LhOXQwYU10Y1kRWje7pslryhG2B1
         NKGcR8ZgolFW9KC8wP8n/Y23nBwT5W08uFHhOBXkWrOGmy/oHhuxNvhgpgctemRMnDbJ
         wbAQXVrPQ569ynC7iMv0IaNdMvcx24kvdjIWzh9WWRdJNqOjQ3CfKK1H7rrx7UuSxYMw
         Zzdg==
X-Gm-Message-State: ACgBeo2vJGi1Exo7WBLt4qXImAcmNBPFH1wX8g8Ybhppzv4h3XbRncIv
        KEa6fm79s1jXmIihLIcD2Mo=
X-Google-Smtp-Source: AA6agR7eSj2QuI9JY2uGmyCkd+QgfuXKkF+B9mBA4FyD6g11QWt8Ucpz1D419mCgs494AvL0Zfk/xw==
X-Received: by 2002:a17:906:58d0:b0:73d:9bc9:947f with SMTP id e16-20020a17090658d000b0073d9bc9947fmr1913526ejs.367.1661248564042;
        Tue, 23 Aug 2022 02:56:04 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7cdce000000b0043cf0d56a61sm1150377edw.8.2022.08.23.02.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:56:03 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:56:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix xcalloc() argument order
Message-ID: <20220823095602.GC1735@szeder.dev>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <xmqqh7249b8d.fsf@gitster.g>
 <xmqq5yijahpm.fsf@gitster.g>
 <20220823070417.GA1735@szeder.dev>
 <20220823092156.GB1735@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823092156.GB1735@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2022 at 11:21:56AM +0200, SZEDER Gábor wrote:
> On Tue, Aug 23, 2022 at 09:04:17AM +0200, SZEDER Gábor wrote:
> > On Mon, Aug 22, 2022 at 06:09:41PM -0700, Junio C Hamano wrote:
> > > Junio C Hamano <gitster@pobox.com> writes:
> > > 
> > > > ...  FWIW, "make coccicheck" with what I happen to have
> > > > notices it.
> > > 
> > > Oops, that was a serious typo.  "notices" -> "fails to notice".
> > 
> > Hm, that's strange.  1.1.1 did notice this transformation for me,


> # Let's invoke spatch directly.
> $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c                               
> warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> HANDLING: promisor-remote.c
> # Nope.
> $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c lockfile.c
> warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> HANDLING: promisor-remote.c lockfile.c
> $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c git.c     
> warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> HANDLING: promisor-remote.c git.c
> $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c usage.c
> warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> HANDLING: promisor-remote.c usage.c
> # Nope, nope, nope.
> $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c builtin/*.c
> [...]
> # Nope!
> 
> # But watch this!
> $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c config.c
> warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
> warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
> HANDLING: promisor-remote.c config.c
> diff = 
> diff -u -p a/promisor-remote.c b/promisor-remote.c
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -146,7 +146,7 @@ static void promisor_remote_init(struct
>  	if (r->promisor_remote_config)
>  		return;
>  	config = r->promisor_remote_config =
> -		xcalloc(sizeof(*r->promisor_remote_config), 1);
> +		xcalloc(1, sizeof(*r->promisor_remote_config));
>  	config->promisors_tail = &config->promisors;
>  
>  	repo_config(r, promisor_remote_config, config);
> 
> # Huh?! (;
> 
> FWIW, I see this with Coccinelle 1.1.1, 1.0.8 and 1.0.6 as well.

Ok, I think I got this.

The transformation involves 'r->promisor_remote_config', where 'r' is
a 'struct repository*'.  However, 'promisor-remote.c' doesn't include
'repository.h' directly:

  $ grep '^#include' promisor-remote.c 
  #include "cache.h"
  #include "object-store.h"
  #include "promisor-remote.h"
  #include "config.h"
  #include "transport.h"
  #include "strvec.h"

If I add an '#include "repository.h" to 'promisor-remote.c', then
Coccinelle finds the transformation even when it processes this source
file on is own:

  $ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c
  init_defs_builtins: /usr/local/lib/coccinelle/standard.h
  HANDLING: promisor-remote.c
  diff = 
  diff -u -p a/promisor-remote.c b/promisor-remote.c
  --- a/promisor-remote.c
  +++ b/promisor-remote.c
  @@ -149,7 +149,7 @@ static void promisor_remote_init(struct
   	if (r->promisor_remote_config)
   		return;
   	config = r->promisor_remote_config =
  -		xcalloc(sizeof(*r->promisor_remote_config), 1);
  +		xcalloc(1, sizeof(*r->promisor_remote_config));
   	config->promisors_tail = &config->promisors;
   
   	repo_config(r, promisor_remote_config, config);

