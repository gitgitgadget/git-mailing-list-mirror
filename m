Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26BC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiGUS0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGUS0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:26:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6751804BC
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:26:47 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m10so1833426qvu.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vAltE1qUn8M4/ZYj31XHjnycQ56sC5o1bE6PMTc5dMg=;
        b=Ha56uTptEonl9qLe33hUEIBEYJo8dgSRU8gY3Ih0SOFDguMMMHAl2pAxL9IJVnS41o
         eQdG5QgjsOd14Ufk+xcPVefolNsOC1jICji9md0+CsmmTA1wk+KoZxrucnoIT4eoI+V+
         A6ikTPJPpd1E3nM3ikwzi6PhKACZ9FDxGLnHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vAltE1qUn8M4/ZYj31XHjnycQ56sC5o1bE6PMTc5dMg=;
        b=Q4X44qauhjlpPci8iOFmJ8pggjRwSxAgYvw8qSxlD/mXjWmdByqIlmCte2TGUOnLSn
         I8Eguys4EewGV11/+aO2S2Bq3jg0simBAnOzT0bzd3S7WJGPmP+MDceuV1GSqR8YOcpi
         NO/ZKqJVe7Y7TPgSBknE8HNmNm69dM3AkbLYfLELDMfxN0iin01AbvP3mdb0qjp2VNgX
         APkQtwyqaglTupAOO1fqkFzJRYUcOu27yBAWmIzI/Z3xrUfp2EiaiMkuebQQKoQS/r4t
         TeBCKGWq+V4cHDGJMF+rapv0lzUUuU3peiymrwhEFx9YRit8uGqmGFsUlfxJZfrDXPIz
         dblg==
X-Gm-Message-State: AJIora/awC6wa9+nqymx6Cfae9hS4Ivii/wp+m5d4Ng/YcMNn3HQLrjt
        Ms0KP/UI5y4UMsAIHHIRnXqHNfgnr+W8MA==
X-Google-Smtp-Source: AGRyM1t2+yd9m+j5R2nrCpWALS6sS3E//eOtgvZLMwkwn691opVi+i40IEeut1zWD8Qx3gQft3lrUg==
X-Received: by 2002:ad4:5bc1:0:b0:473:93b1:81ed with SMTP id t1-20020ad45bc1000000b0047393b181edmr33957544qvt.58.1658428006999;
        Thu, 21 Jul 2022 11:26:46 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id r3-20020ae9d603000000b006b5f371a19esm1743063qkk.111.2022.07.21.11.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:26:46 -0700 (PDT)
Date:   Thu, 21 Jul 2022 14:26:45 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
Message-ID: <20220721182645.45xrwf2buohibcaw@meerkat.local>
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
 <xmqqwnc6idxr.fsf@gitster.g>
 <220721.86a692tkva.gmgdl@evledraar.gmail.com>
 <xmqqy1wmgx8t.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy1wmgx8t.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 11:02:26AM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > But this is worse in that "git rebase" will get rid of it by default.
> 
> FWIW, I think I like this much better than Konstantin's "there is an
> empty commit at the bottom", for exactly the same reason why I like
> the original "empty commit at the tip", i.e. simply because we can
> strip away the "extra" commit that holds the topic description
> without having to change all the "real" commits.

I'm happy to consider alternatives if I can have a reliable way of tracking
"the series we're working on starts at this commit". I know that this is
antithetical to git's design, but I also can't think of anything else that
reliably survives rebases.

> In fact, I thought one of the newer "b4" subcommands that is used to
> accept a patch series with a cover letter creates exactly this sort
> of topology, when told to apply the topic to the tip of the
> integration branch? 

Yes, you're thinking "b4 shazam -M", which does a "merge --no-ff" with the
cover letter as the template merge commit. I guess it does create this exact
structure:

             C---B---A---M
             /          /
        X---Y-----------

I'll play with tip merge commits and see how well my "survives rebases" tests
go.

-K
