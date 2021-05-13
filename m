Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6065BC43460
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2973461355
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhEMIQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 04:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhEMIQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 04:16:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F31C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:15:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id j75so24636387oih.10
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+qTsbf4oPLdfw3muZOSGa4Ao+UaeufsSfAeTFgRjhw4=;
        b=sNrNR9sL9FI+37uKFu/bn7DphqF0BM2I5UVieE979rhL1WJ+lY/xu0dRg/UXEMJW6b
         jxkCs4d8GKrXIzvCmqj+9/lgiyzJm3pGIcMpaPU7FmRlXJPbETfFJkBi9e1bz9GaAMtF
         T/CpvbSvpi1+OdEF0DA1gWLraNkv4O9WryARLZwWm08MFsDv+Tf8M8UKHJPd2ObA33jY
         A16LY0jPN6b48jdKBmmTflCVPmnWCjEri6CVYRkKg9IPtgEsgOC6qP79/jnbRIak482q
         HAn1jOj7UkDnBa97Zd4iCGqWigHWZ6eXG5F01i/F7EbhUBx+ZbyLPfosnb0VUQcNALWm
         Ukdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+qTsbf4oPLdfw3muZOSGa4Ao+UaeufsSfAeTFgRjhw4=;
        b=CPbfbDXO4WQ6dPVJINBXmTjhLkD3LVSOINPsQkmQRqPzyeo6TSOjbURm02B874/WdI
         kc1OxZ/clwomnLMFOBtM2364aKkVtrPxXZfAlJBw0nS4PmyHfhVNSu7RVFyPOmMopFwa
         EYzpnK/xFd4KxJTkAM1Hz6LLBWUdbyB0WZ6eb04EbMmwPeCte7LGX3AgEkRWZH9Z5qiN
         9Ie9jYlhk6LxZrAiotiXlHl7ZtKM4CVq+KHIpDbQ688j3f6yJ0fB2LoVzpU9WRzl7l4x
         8vOG2KGeiZG6s3JBDBgdTlIrNv+lenGdm0S5lt6k95aDIxp8TeULOtDTIDFfbTz8ZNaG
         epcw==
X-Gm-Message-State: AOAM532O5uUcnWraLaNowJJvFbmjxfiXAsRetBYY7Xf+aYJG9SAkzCYN
        8SZYzxHNSxHkQzUf6RGJNy0=
X-Google-Smtp-Source: ABdhPJxmESJWvljXaXAIuqtnzPJ4e8+hj4X6VyIjPxWFe/6Xq8SafXbOoj/9VKcrG3iImFDXXWEGJw==
X-Received: by 2002:aca:cf82:: with SMTP id f124mr29515205oig.4.1620893726204;
        Thu, 13 May 2021 01:15:26 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y11sm532338ooq.2.2021.05.13.01.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 01:15:25 -0700 (PDT)
Date:   Thu, 13 May 2021 03:15:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Message-ID: <609ce01c4d5df_5a82087a@natae.notmuch>
In-Reply-To: <YJzUvZjzSYuKcsTr@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-9.9-0d87c9a5a3-20210512T132955Z-avarab@gmail.com>
 <YJxgC/PJ/JIcIOfq@coredump.intra.peff.net>
 <609ccf688a4e7_329320879@natae.notmuch>
 <YJzUvZjzSYuKcsTr@coredump.intra.peff.net>
Subject: Re: [PATCH 9/9] send-email: move trivial config handling to Perl
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, May 13, 2021 at 02:04:08AM -0500, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> > > It is a bit unfortunate to have to go through these contortions, but
> > > this is definitely the best we can do for now. I think in the long run
> > > it would be nice to have a "--stdin" mode for git-config, where we could
> > > do something like:
> > > 
> > >   git config --stdin <<\EOF
> > >   key=foo.bar
> > >   type=bool
> > >   default=false
> > > 
> > >   key=another.key
> > >   type=color
> > >   default=red
> > >   EOF
> > 
> > Why do we even have to specify the type? Shouldn't there be a registry
> > of configurations (a schema), so that all users don't have to do this?
> 
> One of the purposes of git-config is to serve third-party scripts that
> store their own config keys that Git does not know about. So we can't
> know the set of all possible types that will be asked about.

Yes, I know, I maintain several tools that have such configurations. For
those you would need to specify the type (or find some way to install
the schema so that git parses it).

But I'm talking about git.git configurations. If you don't specify the
type in --stdin it should fetch it from some database. That would be
much more user-friendly.

-- 
Felipe Contreras
