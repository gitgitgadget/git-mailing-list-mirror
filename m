Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF0C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 11:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiHWLUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349905AbiHWLS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 07:18:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530F89919
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:22:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a22so17208653edj.5
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 02:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=iDgfMYYPfoEm6RH4Bh05iOqFOpoXAPm+EvVmfWsyZHg=;
        b=UtnXKgCpxsfm7kQn0vENK5pivPLmoK3p0oizJ5tfDVvsqGl3qZ1SjquR96lMzefCmZ
         aOhM4zt4A0tisbf2yCYX3e+pOUMNyJPV/44Y23tnHGhgs5g2LVHQxybG8S/ju0lEkaIg
         vh6vXXjZkgtP2wPyui6sebeXqCBWR8AXkbfgy4uGsZdC0ReNI8PEBbmC4vvpP1S0kddO
         knjTWo/+civB5QHoC/zRphfWwpYAW7z6+38vSCc75vG5Ydp7RI6XhhbZ3nyK5oYLzch5
         i1cA6WiPzJmNNmUIOm74MEKWdCNKZcy5ccLdnS3DXR/U8y94lOZFqdq4G8omwx2RzKxF
         HisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=iDgfMYYPfoEm6RH4Bh05iOqFOpoXAPm+EvVmfWsyZHg=;
        b=SulZGtiUqc3dWS5MeZF9ot/UVr3u6ErsoxYL8jDfhMWwWQ4cIekaDr98V+n0m7aEvA
         649L77p1YUUXDT/y7DE0rtDdOrF4vIft0+Hl65u3kJ+REZue66c1X9qvc6KyTdz1UQoU
         A6c9wvoQA0LSLIbnbBXjWt1uxEBsAssAdkMOUI4akXb1erX5byfr6NlCW8zOzFM3k1Jr
         kUd4YOy/NK4cGZ6k/nNP14bfeozc8jZIo1tPu6Bt0BGros+26gJMT2Z9E2egt3ji9Trd
         Nho5V1xiVZVz6WWodq4vXYlqFADuSv13XAosF11AGwCMVydY0Ru/G+emyHstcgigx04w
         KBfw==
X-Gm-Message-State: ACgBeo3YdTFo1jkCDKzZYHcJJrjQ9Jb9xCpvk0n3Zv8OH/vTH7+66it7
        8t4WfwIswf4urWqsgD5li0c=
X-Google-Smtp-Source: AA6agR5eyiVhnRenQIxz/YYCY1yKKqXRBXvRClgqXsG8BNVqyjbbh+oIcAchF3uA51su9QJwaZYgrQ==
X-Received: by 2002:a05:6402:530d:b0:446:e22:cca2 with SMTP id eo13-20020a056402530d00b004460e22cca2mr2752342edb.237.1661246519142;
        Tue, 23 Aug 2022 02:21:59 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id kv23-20020a17090778d700b0073d645e6dd8sm4463456ejc.223.2022.08.23.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:21:58 -0700 (PDT)
Date:   Tue, 23 Aug 2022 11:21:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] promisor-remote: fix xcalloc() argument order
Message-ID: <20220823092156.GB1735@szeder.dev>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <xmqqh7249b8d.fsf@gitster.g>
 <xmqq5yijahpm.fsf@gitster.g>
 <20220823070417.GA1735@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823070417.GA1735@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2022 at 09:04:17AM +0200, SZEDER Gábor wrote:
> On Mon, Aug 22, 2022 at 06:09:41PM -0700, Junio C Hamano wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > ...  FWIW, "make coccicheck" with what I happen to have
> > > notices it.
> > 
> > Oops, that was a serious typo.  "notices" -> "fails to notice".
> 
> Hm, that's strange.  1.1.1 did notice this transformation for me,

Hang on, it's not quite that simple.
Watch this, it will get weird:

# Batched spatch for faster processing, see 960154b9c1 (coccicheck:
# optionally batch spatch invocations, 2019-05-06)
$ grep SPATCH_BATCH_SIZE config.mak
SPATCH_BATCH_SIZE = 32
$ time make contrib/coccinelle/xcalloc.cocci.patch    
    SPATCH contrib/coccinelle/xcalloc.cocci
     SPATCH result: contrib/coccinelle/xcalloc.cocci.patch

real	0m35.902s
user	0m34.840s
sys	0m1.030s
# Found it, good.
$ make -s cocciclean
# Turn off batched processing (this is the default)
$ sed -i -e '/SPATCH_BATCH_SIZE/ s/= .*/= 1/' config.mak
$ time make contrib/coccinelle/xcalloc.cocci.patch    
    SPATCH contrib/coccinelle/xcalloc.cocci

real	0m24.553s
user	0m21.468s
sys	0m3.099s
# Not only missed the transformation, but it's faster than batched
# processing?!

# Let's invoke spatch directly.
$ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c                               
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c
# Nope.
$ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c lockfile.c
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c lockfile.c
$ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c git.c     
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c git.c
$ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c usage.c
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c usage.c
# Nope, nope, nope.
$ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c builtin/*.c
[...]
# Nope!

# But watch this!
$ spatch --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c config.c
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c config.c
diff = 
diff -u -p a/promisor-remote.c b/promisor-remote.c
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -146,7 +146,7 @@ static void promisor_remote_init(struct
 	if (r->promisor_remote_config)
 		return;
 	config = r->promisor_remote_config =
-		xcalloc(sizeof(*r->promisor_remote_config), 1);
+		xcalloc(1, sizeof(*r->promisor_remote_config));
 	config->promisors_tail = &config->promisors;
 
 	repo_config(r, promisor_remote_config, config);

# Huh?! (;

FWIW, I see this with Coccinelle 1.1.1, 1.0.8 and 1.0.6 as well.

