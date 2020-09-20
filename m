Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6206EC43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA642078D
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 18:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePil9XKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgITSCz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgITSCy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 14:02:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A1C061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 11:02:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o20so6883241pfp.11
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NsBHcLd1PCg/0bH1O+6DKhPpT8gdvqjy1SlBCcr2dJ4=;
        b=ePil9XKiiKEte7S0e8pbWcfR38TTh2dSBGlLx1EBR59qlV2PXwxtn8DVdEh35hbsjv
         VgCckFTOJ3F56Lt7JvYY7eIH/m9l4lbjO8Gvx2dRFfjUpHT2rPTUJiZLkzS2RF75rb7p
         lOVQ6yLX2I1DrhA0TI+eXRjYdEqAUbFn8rbG8dWYKmpmttsbCFVy9637FqyVLC4jVo7Y
         CceY1WCjdIlT3W+iFwAliZ1wblgpAyHdf4wndrR5igwDHxMFfMplN0L5RakL7xvjVx+L
         biEb9HtCF07iCh0n/V0E75bIXxZWFcm0eBozs2759CzwO1YpFhbRe5TD/6hYssMktTAG
         gzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NsBHcLd1PCg/0bH1O+6DKhPpT8gdvqjy1SlBCcr2dJ4=;
        b=WpvXfJsuEpkAl43bVf72YbrnRl8M+/zQPrtafwQiIVX3QiXftPQYWi3h2cBu4WAVJj
         tP4NetAbG/m8QheOomGYxUJc+Gz0EF/VWD0CBOxBC9WsZ9YA1EwuUc2jDH09jvOxPYxx
         QDV6kFw8IyLNhTVip6kbcpg2QGwk9SLDxwBz4XUcrOU881tnDwPYDFnTXQdUOv/8+Jl9
         Tca0fMZF5HkD6lGKbE+rDtWcacLbdowMf17KrYiTIUpvtiXu1Nzp9sTx1OwJ4lPY4A/S
         Hd25opV7FAUjJNT3TgGR61cJ/NynzHW36rUJ0VCfO5/ymnZZtVLF86b5OV3/xLg2xwoh
         dJPw==
X-Gm-Message-State: AOAM533YOXAdezP8fuow6iAg09rlNQ62LT+RKabRLuPU7oAveIr9pgv/
        e1nGSLX7vtpfBP34D4t9kwUowYEeH0AubQ==
X-Google-Smtp-Source: ABdhPJyDTksBlMMv9ZchgoFIW8j4EAalitiTjESwKIbfoURgpRM9+HlkGjVH5iLaOD/4zOKCOK+F8Q==
X-Received: by 2002:a63:eb09:: with SMTP id t9mr12604875pgh.182.1600624974155;
        Sun, 20 Sep 2020 11:02:54 -0700 (PDT)
Received: from [192.168.208.42] ([49.205.85.152])
        by smtp.gmail.com with ESMTPSA id z9sm9331025pfk.118.2020.09.20.11.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 11:02:53 -0700 (PDT)
Subject: Re: How to checkout a revision that contains a deleted submodule?
To:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
Cc:     Jens Lehmann <Jens.Lehmann@web.de>
References: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com>
 <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <4eb688f2-0c17-9b85-e60e-f07485895622@gmail.com>
Date:   Sun, 20 Sep 2020 23:32:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE5ih79puooMA1v8jOkqKaO9xPmYqtkT9kXHq2L6YODJJ8oGEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/20 3:14 pm, Luke Diamand wrote:
> On Sat, 19 Sep 2020 at 10:03, Luke Diamand <luke@diamand.org> wrote:
>>
>> Maybe this is a FAQ, but I couldn't figure it out!
>>
>> I have a repo which has a couple of submodules.
>>
>> At some point in the past I deleted one of those submodules:
>>
>>      git rm sub2
>>      git add -u
>>      git commit -m 'Deleting sub2'
>>      git push origin
>>      ...
>>      ... more commits and pushes...
>>
>> Now I go and clone the head revision. This gives me a clone which has
>> nothing present in .git/modules/sub2.
>>      login on some other machine
>>      git clone git@my.repo:thing
>>      cd thing
>>      ls .git/modules
>>      <sub2 not present>
>>
>> So when I go and checkout an old revision where sub2 is still around I get:
>>      git checkout oldrevision
>>      fatal: not a git repository: sub2/../.git/modules/sub2
>>
>> What am I doing wrong?
>> What set of commands do I need to use to ensure that this will always
>> do the right thing?
>>
>> Thanks
>> Luke
> 
> Replying to myself, adding Jens who added the section below.
> 
> This is a known bug:
> 
> https://git-scm.com/docs/git-rm
> 
>> BUGS
>> ----
>> Each time a superproject update removes a populated submodule
>> (e.g. when switching between commits before and after the removal) a
>> stale submodule checkout will remain in the old location. Removing the
>> old directory is only safe when it uses a gitfile, as otherwise the
>> history of the submodule will be deleted too. This step will be
>> obsolete when recursive submodule update has been implemented.
> 

I don't think that part of the documentation applies to your case. So,
I also don't think this is a known bug. As a matter of fact, I couldn't
reproduce this with the following:


 git init checkout-removed-submodule &&
 cd checkout-removed-submodule/ &&
 echo "Hello, world" >foo &&
 git add foo && git commit -m "Initial commit" &&
 git init ../submodule &&
 cd ../submodule/ &&
 echo "Foo bar" >foobar.txt &&
 git add foobar.txt && git commit -m "Foo bar baz" &&
 cd ../checkout-removed-submodule/ &&
 git submodule add ../submodule/ foobar &&
 git commit -m "Add foobar submodule" &&
 git rm foobar/ &&
 git commit -m "Remove foobar submodule" &&
 git checkout HEAD~ # Checking out the "Add foobar submodule" commit

I get:

 HEAD is now at 25270d8 Add foobar submodule


I also tried with a cloned version of that repository as follows:
 git clone /me/checkout-removed-submodule/ cloned-repo &&
 cd cloned-repo &&
 git co HEAD~

I get:

 HEAD is now at 25270d8 Add foobar submodule

So, I don't get any errors when I checkout a revision where the deleted
submodule is still around. There might other factors in play such as,

- the version of Git being used
- whether `--recurse-submodules` was passed to checkout
- the configuration of the submodule in .gitmodules

It would be great if you could share these and possibly other useful
information to help us identify why you get an error when checking out
the revision.

--
Sivaraam
