Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8616AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 20:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiGUUTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiGUUTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 16:19:22 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C73A4BC
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:19:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u12so2190056qtk.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IO5Q/iQGin6aTAJ+K+qEY1LaMuy19MGNxXUCAWuGAL8=;
        b=VO8x7qVH5+OFh0UN85L/UU7vWLZbKHWY/2884I36oD8Jx/V7BTpehI6d9Ra/Cpay0b
         kejrUt47EZ/bFvnyWj4eurFcr+h1YUB9/bDbn4HGPhaXJ00uOCIpIE4Za877muaYMpC2
         1Yb4DKi3wQK7ooRz986Hk0JFwa45XviGSB7II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IO5Q/iQGin6aTAJ+K+qEY1LaMuy19MGNxXUCAWuGAL8=;
        b=OmgUmDYNTlAc68KQsS2fyCb9eShAauTQWWYncScmG9qpFeGEiqOmcYF6yMDgOtDGCd
         LQsJ/xUlm5wsQbBjvM3urdGBLhemhcmIrtOTeXYxei7a9vzFAToO4TNnnuzNBts3RgU7
         PonhccVV9QPDYD01Ce7OUlyDvy2/Q6uG4r+yUVK8y9bxtJoATu293IlQAqeJk2N4QrU3
         eHd+ff3LXnWWiGpkyp9TJ5AxzXIARhS4x4oWS3h0ccCmGn81BG/c71fU+4RxROhwHf9e
         qT2+0wewWY5iPzRx61heO/2lCV9Jv2LTwg3Vcpauur6Csl9xGwbMo7n6OODVqF1F3FBH
         9pQw==
X-Gm-Message-State: AJIora/K6KgXcs0oFAJOvnqDBiWopD+uEGaEguU6/26YzeZbFASdkvm0
        XiLCejFL1UYTU7QcwUiVRkmp2SuyeJ+xNA==
X-Google-Smtp-Source: AGRyM1uRdcKUeaVsi9i+nZ20rf0gWRx4RnjVuJP11o9F9vvdfha+GddINNi1obsfbEjYH9g+DwyjSw==
X-Received: by 2002:ac8:5b83:0:b0:31f:1ef0:7da9 with SMTP id a3-20020ac85b83000000b0031f1ef07da9mr304776qta.320.1658434760535;
        Thu, 21 Jul 2022 13:19:20 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id x29-20020a05620a0b5d00b006a6a4b43c01sm1979026qkg.38.2022.07.21.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 13:19:20 -0700 (PDT)
Date:   Thu, 21 Jul 2022 16:19:18 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: On-branch topic description support?
Message-ID: <20220721201918.xvunkyehxnjbwhjv@meerkat.local>
References: <xmqqilnr1hff.fsf@gitster.g>
 <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
 <xmqqwnc6idxr.fsf@gitster.g>
 <220721.86a692tkva.gmgdl@evledraar.gmail.com>
 <xmqqy1wmgx8t.fsf@gitster.g>
 <20220721182645.45xrwf2buohibcaw@meerkat.local>
 <20220721191349.kf3zx4tpwrjhzudt@nitro.local>
 <xmqqa692grqr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa692grqr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 01:01:16PM -0700, Junio C Hamano wrote:
> Now you are discussing this on the git mailing list, you do not
> necessarily have to take the existing behaviour of Git as given.  

Indeed, I was mostly observing about how it works right now -- please don't
take this as complaining. :)

> For example, I do not think it is unreasonable to teach "git rebase
> [-i]" to special case a certain merge commit in the rebased range
> without any extra option, as long as the criteria to pick such a
> special "merge" is specific and narrow enough (a two-parent merge M
> whose tree matches that of one parent's tree (say M^1^{tree}), the
> other parent (say M^2) is an immediate ancestor of the bottommost
> commit of the range being rebased, or something like that).  And the
> way you "special case" it does not have to be tied to the way the
> "-r" option handles it, either.  
> 
> A possible design could go like this:
> 
>  * we recognize such a special merge commit;
> 
>  * we rebase the rest of the range, pretending as if that merge
>    commit did not exist and instead its children are all direct
>    child of one of its parent (say M^1), using the options given (so
>    "-r" would affect how other merges in the rebased range is
>    handled).
> 
>  * after everything is done, we create a new empty merge commit at
>    the top, merging the bottom of the range and the tip of the range
>    as its parents, using the log message from original M.  This can
>    be done totally outside of the regular "rebase" machinery.
> 
> Such a change to existing behaviour is well within the scope of
> "On-branch topic description support", I would think.

I agree, this would be great. If this is in place, then it would certainly
bring us closer to managing "proposed change" series completely in-git.

One thought that comes to mind -- perhaps it would be easier not to track the
special commit, but designate the branch as a special "proposed changes"
branch that could even "hide" the cover-letter merge commit (CLM) from most
operations. It's still a simple two-parent merge commit, so it can be
pushed/pulled with any existing remotes without requiring any changes on the
server side, but operations like adding a regular new commit to the tip of
the "proposed changes" branch would automatically move the merge commit so
it's back at the tip. This way "not sure what you're trying to do" situations
like this would be avoided:

  A--B--C--CLM--D--E
 /          /
Y-----------

-K
