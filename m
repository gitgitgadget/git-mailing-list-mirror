Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE07C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E6C206F1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592314261;
	bh=np3wOQlZ+QLw5pm1rkiZK4gakPx6gS24Ha3M01tcnZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Df8dvuwKcSUP6twjdAArgcFe2dszSBfgcjY338TLIAA3G6plwjWyAUUNOLgZivjw6
	 6EySMQqvJyWBp44G8Zns93A6xncjKMt2FPRYXzpHWXp7eOnnpNGO5uvn9JE01iBjYU
	 ojpckTDwfxnxJ2d+MKWrll34DN0QCrIpg6mRV9qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgFPNbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFPNa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 09:30:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84575C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 06:30:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so19086896qke.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lH6AJ0ZOL38wJKB6Z6ENglj43Zdwn57ItRF6F32bEqg=;
        b=Gn1uRKDEO/MwbCkRDqe7rcsfXnAZOqK5LfhCLrAasD6omEgGGT3vKFvWS5TN9QvvO6
         Oc04KkE2VE04qXMAXo1wCQQgU/d49ZOqPFUxUmAceqGBDtIT8WUANhwfE85lUCa6yu22
         nbe9R2glnWvwf32oDouQrXREPNCbXWEQ7NS6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lH6AJ0ZOL38wJKB6Z6ENglj43Zdwn57ItRF6F32bEqg=;
        b=A2/gaRg/jvlltrBTi+mBxS6cAbwaRADwhpsT/ViAlQTGjCfSwLh1tGdxhLmiMt18aH
         MaxMt8ehr2B8QO4xFVvVmv5teHNNgZaMb7SgE/vKxOuYrjH+czlSt5ohCyr+oetTCrmu
         T0/DBvtSOziPmFL6vlfz2UaAyxLdEqJ028LXxqSd3wzhXKIVzAOU4GQ/DzMU1aQYiaUZ
         WxFNonZhWdzjrOXBfxFQav6JhjoAkbwsyNZ/rOhTv9s8w7gZDO4o9lieoBUWTe6UU6sh
         tuGmAajrzb/njhUvR82BiRUASaF5mWV/u1pTs3QnLdXNeIIEkQCHw3iq5GQWNe6JdRF/
         Dpig==
X-Gm-Message-State: AOAM5331vCqLI+6VZliiyzM9zimhHXBAImRKOaIJqaXIXx9HNBOaAovt
        rAHpFfS/eBe3SNe78RSZcQD5tQ==
X-Google-Smtp-Source: ABdhPJz10derOTxEMt+hPs8QJmk4GJj8pzD0v1WiFvwbCbN8RkHQHimRoWX5OBjv7m0SF42VFun8dQ==
X-Received: by 2002:a37:5d6:: with SMTP id 205mr19152147qkf.46.1592314257399;
        Tue, 16 Jun 2020 06:30:57 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id i205sm1125539qke.14.2020.06.16.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 06:30:56 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 09:30:54 -0400
Date:   Tue, 16 Jun 2020 09:30:54 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Whinis <Whinis@whinis.com>
Cc:     alexsmith@gmail.com, don@goodman-wilson.com, git@vger.kernel.org,
        gitster@pobox.com, sandals@crustytoothpaste.net,
        sergio.a.vianna@gmail.com, simon@bocoup.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
Mail-Followup-To: Whinis <Whinis@whinis.com>, alexsmith@gmail.com,
        don@goodman-wilson.com, git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, sergio.a.vianna@gmail.com,
        simon@bocoup.com
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 07:38:33AM -0400, Whinis wrote:
> > 
> > This sickens me.
> Not just that, any twitter use can complain and get entire communities to
> throw out all rules on changes to appear to be on the "right" side. If
> anyone submitted a patch to change any functioning name without good reason,
> especially one assumed to never change and would likely break a significant
> number of external processes it would be denied without second thought. Here
> the entire thread didn't ask should we change it but instead started on the
> premise, even though this is documented throughout the world and millions or
> even billions of scripts and programs assume it to be constant, it must
> change without discussion.

Let's leave emotionally charged rhetoric and discuss this like 
reasonable human beings.

Here are facts:

1. Git is distributed software. It's not a central service and it does 
   not manage any code hosting platforms. It has no control over what 
   Github, Gitlab, whatnot or other decide to do. If you don't like what 
   they are doing, take it up with them and keep it off this list.

2. Branch naming is entirely the choice of individual repository 
   maintainers. Some prefer not to have a "master" branch, and it's not 
   simply because of "political correctness" reasons as everyone 
   insists:
   
   - they may prefer to have "stable" and "development" branches
   - they may want to use localized names for all their naming 
     conventions (using Cyrillic, Hanzi, Kana, whatever)
   - they may be goofing off (there's a furry-related repository on 
     GitHub with the main branch called "yiffed")

3. In your example, "millions and billions" of scripts are already wrong 
   if they assume that there is always a "master" branch. However, it 
   doesn't matter, because unless someone actively renames a branch in 
   an existing repo that they work with, they will continue working just 
   fine. Nobody is talking about banning the use of the word "master" 
   for any existing branches. I am 100% certain that Linux mainline will 
   continue to happen in refs/heads/master, because the fallout of 
   renaming that would be terrible.

4. In Git, local branch names do not need to map to remote branch names.  
   Your local branch "upstream" can track remote branch "development".  
   If the remote branch gets renamed, you simply update your 
   configuration and continue without change.

5. The change proposal has two parts to it:

   1. Allow users of Git to designate another branch as their primary.  
      As Junio pointed out, Git treats one of the branches as special, 
      but currently that is hardcoded to "master". This change will make 
      this configurable so that projects with different naming 
      conventions can designate some other branch as their primary.
      I've seen no objection to this from anyone.

   2. Consider if the default branch created during "git init" should be 
      called "master" or if it should be called something else. Options 
      are to keep it "master" for legacy reasons or to make it something 
      more descriptive like "main". Since this would be merely the 
      default configuration option, packagers and sysops can set it to 
      be whatever they like via /etc/gitconfig, and individual 
      developers can set this in their ~/.gitconfig.

I invite anyone to show just how any of the above is unreasonable.

-K
