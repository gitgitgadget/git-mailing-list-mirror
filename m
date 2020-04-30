Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13762C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57AB20731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588276335;
	bh=VmPhg2F8RssFG6yPIJTeivlBXXgz/ArKscvJOZlW5RY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y2dINn3mBMKS9lJRDRCgsW/OIoIodR8RREr4N4O8T3SXgnrA+SZgUtEg8vFV3uwiO
	 hx1RcJZlLgcecY8a+2Wcc3JowDRVc/GsrYOJCcBOVWDmmktmv4EIhx0sOh2JFuJkPg
	 +1beOzHa7hmjhHMbYi7za8NK/XCX6zMNebT7ATaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3TwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD3TwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 15:52:14 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E3C035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:52:14 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v18so3677272qvx.9
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=iRkWGjbwAidDRcNDJpSQkm47eNmXyIyEvN7G8POA8Us=;
        b=EkYA1Bf38vJCQpvzXhUbqW2D/WdsymhYWRiXSSdPuHVrCO0IuUkMzyqc3HWrUefHjj
         zBVBedes6bFnPaRSqsNVzty6CGhcIwUAsZkJE/qn0ay9ihTZUCX5NLQ2GLC/bUpOP0ET
         LjdA2Se4LaHt2MbRnOt9YJ48M7LxQpxADcqX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=iRkWGjbwAidDRcNDJpSQkm47eNmXyIyEvN7G8POA8Us=;
        b=IEXq4/DXEeQ38isx8XP7zNHicsLpZyaTwfGOBs5v8sF4ilExdVBVpTZWNeRUjXaDhd
         JCheicn+RPJBcqsHz2ZaHMaju5xHYh4SUu+IdY3Aa1EzNQZwDRqhYrMpoAuVoKQkDx63
         lTfqAp9HqBoBWIqJJ2MDdGSeJxB+je6S9k3iHAtu6YiJFpJNja0IiR9zN66c3itSm2mF
         aF7HCKo6AoGLzIZPNjMQvcRfIQYtJPT2azkJpYxsR+GBpc0evGHyzifmmMpb5PEMWj6v
         f6TL66GrdGdrJPvx4Sk/WvQ9opYaKrID7icwockRBxNPJf/Q9vaXXUmgeCa4P1GIXifV
         B3cw==
X-Gm-Message-State: AGi0Pub8z+TYBrWLok8NTJoyRLUKtBficzdeejB4GXfRV9nA2Mq8y4BZ
        ifPNo1Cp6KUyvq4apuMTE/ZJFrjhJN8=
X-Google-Smtp-Source: APiQypIWTVGkDaD2o8jnZ17wg0RGimu2t25gFOdPYFWPsA7YYYESDtD2c8MlFrHvyD9yKQm11kN4tA==
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr641613qvj.26.1588276333781;
        Thu, 30 Apr 2020 12:52:13 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id q17sm605128qtk.84.2020.04.30.12.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:52:13 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Thu, 30 Apr 2020 15:52:11 -0400
Date:   Thu, 30 Apr 2020 15:52:11 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Eric Wong <e@yhbt.net>
Cc:     git@vger.kernel.org
Subject: Re: Guess the base-commit of a series
Message-ID: <20200430195211.36zhvfcdrpfirewr@chatter.i7.local>
Mail-Followup-To: Eric Wong <e@yhbt.net>, git@vger.kernel.org
References: <20200430172147.3fblnrvi73asnkp5@chatter.i7.local>
 <20200430173302.GA18877@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430173302.GA18877@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 05:33:02PM +0000, Eric Wong wrote:
> > Given a/ b/ filenames and blob index information, is there a 
> > relatively easy way to find the latest branch commit where a patch 
> > series would apply cleanly (i.e. guess the base-commit)?
> 
> Not as far as I know...

Hmm... I'd assumed as much, given the whole "one-way" bit in "one-way 
hashing." :) However, I'm not very familiar with deep git internals, so 
wasn't sure if perhaps git kept a mapping index of sorts that could be 
queries.

There's a reasonable way to do it with the patches sent against the 
kernel, since they are likely against one of the tags created in the 
past few weeks. So, we just create a filename/blob index mapping and do:

git show tagname:filename | git hash-object --stdin

If we find a tagname where all the indexes match, then it's *probably* 
the base-commit (not guaranteed to be correct, obviously, because the 
patch may depend on changes made to other files in the tree, but 
hopefully we'll get most folks to start providing base-commit info soon 
and this guesswork will become increasingly obsolete).

-K
