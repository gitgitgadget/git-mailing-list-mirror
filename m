Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02241ECAAD3
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 01:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiIBBzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiIBBzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 21:55:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F6C659EF
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 18:55:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id jm11so448500plb.13
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=qZws2bQjnhU3hw0VjVzZTeRjeTldGN8fpen/uXHrKPA=;
        b=iDTlvve8wGe5o1XfKcjsxbuMXQllMV7YvGGw9kv5L40Er6xq2NZsXETOWCzQWzDV6s
         UMmcvX/PuCu0fWH0HyzQQnb1u/cIhibW5I3EgfyhQ910NdkGAIs+iy8ADuXN5Ti0brnv
         IEKMdciq6rh8chiaT5QTDO++cJtYTYBCkwGeB4KHqhdIRvy0HveQ10x89Wdzs1mdw5KM
         ZMCBGC0psfAPNVctUCYK1kj03hedndw4AICsOamESs02yQpfE/5vMWCJE/GbZYbLqRPQ
         s1ZjTPbnaEkubV0IBuh6iKqEwo4V6aV0FcPSDhJ4NffXra1sVN3njdD1KfKPLJnOXzca
         7i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qZws2bQjnhU3hw0VjVzZTeRjeTldGN8fpen/uXHrKPA=;
        b=jPdkkxwvJIdHw7p4IpGpACEUbpCcex06OoVGG0cXNNcGVSFg8LFpbwnXQGYs0K6jh/
         hd6n6dqULhDyw5ii73gABHKSpWhwkOp9zRg6nsDbRaddBfA0J0wmYPx8IzzL78oE3hae
         u9mRcHu1wi7/HOMJBn081dqymu4CWugVwmIGyijaQKltEePDNabf2s4DvbKisBfnupa+
         NI2xuGE0d4mK3Uy771Wk7lsztojevu7ajVDaSyR0Hn9dDbnm0bb57eTSc2me+K9xUzlU
         cfWl2gtEah2FIts/H7+/2nbgEJ1lswQ2eFlqwgMsVKLEta7JzQMnN65c65RnqCnlTGrw
         0Bgw==
X-Gm-Message-State: ACgBeo05cKxwTweXcnfm6iwDohwoLeOk82+YebQFuJ93Tn8QShjg06Rf
        wvM0WE34IYZkdcOAH/g9c5c=
X-Google-Smtp-Source: AA6agR6Off4uFNH/Y3AXFiPvFJDaFyK+BqK5+QwZYsqvR/9CCUM2yN8cmEnNa3edYOB2vQe8tm63xA==
X-Received: by 2002:a17:903:2282:b0:174:f9e1:b08c with SMTP id b2-20020a170903228200b00174f9e1b08cmr18295497plh.121.1662083746036;
        Thu, 01 Sep 2022 18:55:46 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id d29-20020aa797bd000000b005380832c1fesm314589pfq.10.2022.09.01.18.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 18:55:45 -0700 (PDT)
Date:   Fri, 2 Sep 2022 08:55:40 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] t1800: correct test to handle Cygwin
Message-ID: <YxFinAJ2NeKiHaS8@danh.dev>
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>
 <xmqqedwv9c9f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqedwv9c9f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-01 11:32:12-0700, Junio C Hamano <gitster@pobox.com> wrote:
> In any case, thanks for a fix.  Will queue.
> 
> >  t/t1800-hook.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> > index 64096adac7..fae8b2faf9 100755
> > --- a/t/t1800-hook.sh
> > +++ b/t/t1800-hook.sh
> > @@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a bad shebang' '
> >  	# TODO: We should emit the same (or at least a more similar)
> >  	# error on Windows and !Windows. See the OS-specific code in

Please also change the comment here too.
I'm not sure what should be put in the comment here, though.
Maybe on MINGW and other platforms?

> >  	# start_command()
> > -	if test_have_prereq !WINDOWS
> > +	if test_have_prereq !MINGW
> >  	then
> >  		cat >expect <<-\EOF
> >  		fatal: cannot run bad-hooks/test-hook: ...

-- 
Danh
