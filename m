Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C629C4332F
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C4461882
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 22:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241277AbhKQWdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbhKQWdF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 17:33:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75983C061200
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 14:30:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t30so7522890wra.10
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhZGMneokY/RAFaALqMiFM9Ll1kN2x2TQzf57PFnInE=;
        b=jsgTgpUJCjZGdueYNjEC4GBkJC7IJ7wRzWVh6qo/+Wxduw66ouwOJHrg04LC0EhP7o
         XHWxSyKIck2xlE72K3z2i8o51OS0Fbtne1kaQsiEiC+iICvKMeLMtU7azK3RCa9+a+6n
         8hVlW/BXJbswtI0yIJTDgg5+gZMfn68US/LWTF6NGqiKj/PnQoHD58z7JPYAteEC4+TJ
         ik0FXN/d7nxYMR5I5epkOW5q+vJUdR/skS4/UXZeIx3A/1SzhdtX/bGMKEMV5muEh92t
         kFwPzkAy0GkUCI80/dlWl3KQu1Rsjtz7ngYIzCd8rHv5xw3VkTof6GUk8W8bxMpdpR4q
         awaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhZGMneokY/RAFaALqMiFM9Ll1kN2x2TQzf57PFnInE=;
        b=HO93pPawwGbjvQ/r6tykGZwsPkkyQtpgQ8WgTVqw6ah6JK2odeVKrhrAWf3ZvmUprU
         MB4m7CvjN2GVmSj6YN4G63er5LMEynmb4plGMT+yz1C33mtlnyW6oTSuUSbNANc4VH3b
         LxA1S1FKD98ozqvT8lV22tWB0xqpQDwoit22bKmIE1Y0F4VZHsRVV9m8LoKHk9cI2XMJ
         xWw9SCcuA1Fe8DBiwXaNnJa9STwd9IcZrM1iUWvGKLL/OJynmbgmF8ppz98c2FkIibPi
         ofrbamv0Qgtti4x+EuKhbYwpHbdrWgdQGQx1SEAx5b4hTePFmFjHoqDXUJ91I4tAzNGc
         ZmHQ==
X-Gm-Message-State: AOAM532a5nqUK8OfsQA9w5o+VoEf7Fb+r5fRcw+N0Pf6Xxl72GT9vooU
        IKOVucAMHzO6poi5Tz5t+lY=
X-Google-Smtp-Source: ABdhPJzyuWV+S5/5PYvqtPhh13ZcQC+gAoPy6Q+gYfkBIgPFJKkCuA0iYKXxFpa2OBq7pTEUIcDnqg==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr24490073wrv.240.1637188205035;
        Wed, 17 Nov 2021 14:30:05 -0800 (PST)
Received: from szeder.dev (94-21-146-88.pool.digikabel.hu. [94.21.146.88])
        by smtp.gmail.com with ESMTPSA id 8sm6517907wmg.24.2021.11.17.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 14:30:04 -0800 (PST)
Date:   Wed, 17 Nov 2021 23:30:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
Message-ID: <20211117223002.GC5811@szeder.dev>
References: <20211113122833.174330-1-gotlouemail@gmail.com>
 <20211113130508.zziheannky6dcilj@gmail.com>
 <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
 <xmqq7ddbme7q.fsf@gitster.g>
 <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
 <xmqqilwulims.fsf@gitster.g>
 <xmqqpmr2j5lq.fsf_-_@gitster.g>
 <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 11:03:58AM +0000, Phillip Wood wrote:
> Hi Junio
> 
> On 15/11/2021 06:27, Junio C Hamano wrote:
> > There are certain C99 features that might be nice to use in our code
> > base, but we've hesitated to do so in order to avoid breaking
> > compatibility with older compilers. But we don't actually know if
> > people are even using pre-C99 compilers these days.
> > 
> > One way to figure that out is to introduce a very small use of a
> > feature, and see if anybody complains, and we've done so to probe
> > the portability for a few features like "trailing comma in enum
> > declaration", "designated initializer for struct", and "designated
> > initializer for array".  A few years ago, we tried to use a handy
> > 
> >      for (int i = 0; i < n; i++)
> > 	use(i);
> > 
> > to introduce a new variable valid only in the loop, but found that
> > some compilers we cared about didn't like it back then.  Two years
> > is a long-enough time, so let's try it agin.
> > 
> > If this patch can survive a few releases without complaint, then we
> > can feel more confident that variable declaration in for() loop is
> > supported by the compilers our user base use.  And if we do get
> > complaints, then we'll have gained some data and we can easily
> > revert this patch.
> 
> I like the idea of using a specific test balloon for the features that we
> want to use but wont this one break the build for anyone doing 'make
> DEVELOPER=1' because -Wdeclaration-after-statement will error out. I think
> we could wrap the loop in gcc's warning pragmas to avoid that.

The scope of the loop variable is limited to the loop, so I don't
think this is considered as declaration after statement, just like
other variable declarations in limited scopes that are abundant in
Git's codebase, e.g.:

  printf("...");
  if (var) {
      int a;
      ...
  }

FWIW, I've spent some time with Compiler Explorer compiling a for loop
initial declaration after a statement with '-std=c99 -Werror
-Wdeclaration-after-statement', and none of them complained (though
there were some that didn't understand the '-std=c99' or '-Wdecl...'
options or couldn't compile it for some other reason).

