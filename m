Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24EEC83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAE72082E
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 01:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4JIOeRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD3BxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgD3BxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 21:53:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE59C035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:53:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so3016291pjz.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GriQreCc23gTK/5XQuFdri8T+S9jUDwIUsnqjxjFFTA=;
        b=Z4JIOeRLRFeqlFt/qXu3NQFNX6YuJMV+pYQ+f7eZlVhs+0OeG9qK/WxCGGQEDu4nHb
         M71SuShoesOIAHNCWbks/O+jksjz7MllAkBTDrQQWQ8m0+pj3g/r2Ejzh6rW7OC7gP2l
         KrK7hv/jcns4EAK9TUIOqLREb66JwMYeE3V13TwsodeGTndEZzv+Tw+CEuGgvdfYiBB3
         Swwg0Xy1H65Y/WBpvj9BXLXtOT6ozJYu9bH7dEeM22a46eUSO6jDUIig50PFfsdBprjW
         hqyEshqdzw0HBhphttSvO48RW9paWOZpQdcy/MMwRz44wAWtHdfGSZBJvKYAJED9E06A
         /Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GriQreCc23gTK/5XQuFdri8T+S9jUDwIUsnqjxjFFTA=;
        b=FyS3wLRYbg+uwfrU4Bre+SalYH3xjQ8bPaeFjeKVP96eMlKXJn4wHWWN/Uc9mB57vg
         NsZOQzlC/WyjLFDu81GQ2mWt4QjOC/HL25VDvUYx6u/WrmX1TB1ztcQ50lY8rN5dgVty
         N0ooI8lwDjb4Goc0kAfo/9Dj4puplPBpRmwRWdjGQ2eqsRv14Pituz10DXtXqjXmfiyO
         D8FmVM93SAG1beEFNh55qGcS9wiginRxHdbIrTTnyNz52DxVR5MfALnR9IOGECNxW3ll
         2HA79yBNgHrBcRo1wyDZ8LBt9XG8xgdaltsYo3p6r0vxjT1xGnEyNE3h6WeznhqgDj0J
         JY5w==
X-Gm-Message-State: AGi0PubeEUx+yyDs7T9me1lPQEw4LqgeQdb7j7/OVWrk9l9n4XKyEZA3
        YfUekn7dNdawFy7z5rx0sm0bSztf
X-Google-Smtp-Source: APiQypKPQvj/zZGIA0PH8pQAe/fObdBVKTYesosryZDgsjH+vu9QRSNvqszBNNrKVxoblsmp36c0EQ==
X-Received: by 2002:a17:90a:362f:: with SMTP id s44mr243729pjb.156.1588211602773;
        Wed, 29 Apr 2020 18:53:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id y13sm2074374pfc.78.2020.04.29.18.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:53:22 -0700 (PDT)
Date:   Wed, 29 Apr 2020 18:53:20 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] bugreport: collect list of populated hooks
Message-ID: <20200430015320.GB115238@google.com>
References: <20200427233820.179891-1-emilyshaffer@google.com>
 <20200430012425.209122-1-emilyshaffer@google.com>
 <20200430015049.GA115238@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430015049.GA115238@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Emily Shaffer wrote:

>> +++ b/t/t0091-bugreport.sh
>> @@ -57,5 +57,15 @@ test_expect_success 'can create leading directories outside of a git dir' '
>>  	nongit git bugreport -o foo/bar/baz
>>  '
>>  
>> +test_expect_success 'indicates populated hooks' '
>> +	test_when_finished rm git-bugreport-hooks.txt &&
>> +	test_when_finished rm -fr .git/hooks &&
>> +	mkdir .git/hooks &&
>
> This is subtle.  Since c09a69a83e3 (Disable hooks during tests,
> 2005-10-16), the repository in which the test runs has its "hooks"
> directory renamed to "hooks-disabled", with rationale
>
>     Individual tests for hooks would want to have their own tests when
>     written.  Also we should not pick up from random templates the user
>     happens to have.
>
> That rationale is a bit strange because we explicitly passed
> --template to "git init" even then, so we could be confident that the
> built-in templates that do not enable any hooks would be in use.
>
> Mailing list diving finds [1].  We didn't have f98f8cbac01 (Ship
> sample hooks with .sample suffix, 2008-06-24) yet, which means that on
> filesystems that do not record an executable bit, the sample hooks
> were all enabled by default.  Nowadays that has been fixed and we
> should be able to get rid of the "mv .git/hooks .git/hooks-disabled"
> in the test setup.

And of course I forget to include the footnote.  Sorry for the noise.

Jonathan

[1] https://lore.kernel.org/git/81b0412b0510140546ya10bc8fg3dd5eaab429eba6f@mail.gmail.com/
