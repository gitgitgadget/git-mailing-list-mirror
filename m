Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF187C433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 04:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD80206DB
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 04:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaJeEIOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgJTEQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 00:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbgJTEQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 00:16:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0672C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 21:16:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h6so290780pgk.4
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z2Esf2RLGMrSWYxFeVfw0Q3fU4I5aS81qQzgRC/xlr8=;
        b=LaJeEIOyuETvrmMNr7W8upA+RqF0wUuXzXeDyCN3tjxBvAU0XRgiOkvGt6ojLH+YbM
         p8H/5wWqnFes16jNba9R9vmjV/8n2EFTB+3dXyFdGaQl60+HJIzY5TdB8ZFBLMwEpcEO
         NxYy/7AUFCPd9Ces6qpHdkBWrb5Dms9P0M8Ayd41RqRMLOfsdnMyzFHPFgKIM+Kjbmrv
         g/eTLreJvxMaOJPrEBzNzOr9xiF5V1j4qAcO7d2ij/G0KF+ovgjx2nxSmc1CQcL0aMRm
         xl4bqx3QtPCjY2Uc/66GMQ4IEVNdQzhkgNVXcykRpbAgC0ZcpSIxwag9HgXO5YQbPLYM
         +T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z2Esf2RLGMrSWYxFeVfw0Q3fU4I5aS81qQzgRC/xlr8=;
        b=rjYvpHoocVXJExJS4nn3fVquvT2zdtpTupeTlQu4bIsqklWkl2ANy/BAzcDeKJxIPR
         Hgp3SIq1POBMBcwA9CsvM92AYyTy/haK0EV72Ar1mkUzoe8c0NcBEwBPc0MyDryMkNaE
         fwmsrmj7xlyZns5cY+pLRn1e5eppIFN6x7eClvAsBQO+dUc6ubV/piP0rjEJanP+6ww2
         D19fIYYo7p2WS2AIKUH+xiXabaH91IY613k/K+5W3+xhKbzjavEXwoN6bbvqYYtRoQzw
         sfk6bw7fZJfTalH4u993P5p6TxtZIQE7W2glZ7xsXk/wyWEBw+9iWJ75YbnwPo5FtUut
         a5qw==
X-Gm-Message-State: AOAM531e/oJkm0Lf+dkV0LcZvaSGQEuLxm9QLJc1CsEavFEkcBzNnYIl
        mrDQEP2cCFJHa/mT+amPlbI=
X-Google-Smtp-Source: ABdhPJxakwEcXd0iDo93lwnsOPTvZxBCMpunonANatG2W1ySEEGb1oRhKQslViUmri/VWnB7CFuqzw==
X-Received: by 2002:a65:6a0a:: with SMTP id m10mr1082342pgu.162.1603167388239;
        Mon, 19 Oct 2020 21:16:28 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id r6sm474453pfg.85.2020.10.19.21.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 21:16:27 -0700 (PDT)
Date:   Mon, 19 Oct 2020 21:16:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <jeffhost@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 16/19] parallel-checkout: add tests for basic
 operations
Message-ID: <20201020041625.GB15198@google.com>
References: <cover.1600814153.git.matheus.bernardino@usp.br>
 <64b41d537e68a45f2bb0a0c3078f2cd314b5a57d.1600814153.git.matheus.bernardino@usp.br>
 <20201020013558.GA15198@google.com>
 <CAHd-oW7=Bd+StX_t+6iuaas0SWzEdbQCj5aWgasoOYT2kfVw7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW7=Bd+StX_t+6iuaas0SWzEdbQCj5aWgasoOYT2kfVw7g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino wrote:
> On Mon, Oct 19, 2020 at 10:36 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Can we use an artificial repo instead of git.git?  Using git.git as
>> test data seems like a recipe for hard-to-reproduce test failures.
>
> I think we could maybe drop these tests. There are already some
> similar tests below these, which use an artificial repository. The
> goal of using git.git in this section was to test parallel-checkout
> with a real-world repo, and hopefully catch errors that we might not
> see with small artificial ones.  But you have a very valid concern, as
> well. Hmm, I'm not sure what is the best solution to this case. What
> do you think?

I see.  I suppose my preference would be to have a real-world example
in t/perf/ (see t/perf/README for how it allows an arbitrary repo to
be passed in) instead of in the regression tests.  In the regression
testsuite I'd focus more on particular behaviors I want to test (e.g.,
a file being replaced by a directory, that kind of thing).

Behaviors exercised by git.git are in some sense the *least* important
thing to test here, since developers in the Git project know to
advocate for those and exercise them day-to-day.  Where the testsuite
shines is in being able to advocate for use cases that are exercised
by other populations --- a testsuite failure can be a reminder to not
forget about the features other people need that are not part of our
own daily lives.

Thanks,
Jonathan
