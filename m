Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3CF1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 23:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeBFXBB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 18:01:01 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44422 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753803AbeBFXAr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 18:00:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id r1so1709444pgn.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 15:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpZCrxUEmycMR6RNln2X+rRsAp3cZvtuueANo5t90u8=;
        b=BcZbl32MREDetVJh+ruuUfWLcRhL2nC0A1+okarX7A+ZcYUB2Kdq8lXck5KzTXKIRY
         nZqJ+e63wreF53lGbAPF+HM5uRvn1Ajxnln6vtrogFGnRbs80FLV3q1B5d1Dy90K6CPb
         3AsWnX/2mD9VNDhWBtf+/TyA7mVMk+5U7a0ylcNjom+vUs4a6NjoDSrMhML/i0yYlrUq
         y8A/gnCOaQmg00QEg6ftieIqbvhNQAsqk1IfM1m8RDh+2YoHe8d0PUx0N/vBtJah4fPn
         FpbSQPJtbvBI2py/+/xgGhyDRHV+JskV97RMgoGqJ7kOf5JCK0+nLsCCZdM74PTlogQu
         7yaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpZCrxUEmycMR6RNln2X+rRsAp3cZvtuueANo5t90u8=;
        b=Sk7+Es465v8kE3bxCvNxEB3714hT9nVLDC0bzsZTxlnBIhwNp8cZT3KUEbDWW9uuOp
         CxSaTzWVTDpnHmxtlQuKb4lhzWSlByiluW0tt45etEeeZXk0lFUvOsNGtiWO/nLFRFfo
         qdpaWEbOk5ZbyArPQPYByffJDmD/mea9wnAApZV8ckC9qOOY4h65Ekk1LN7t8Ehj8xsc
         TS3BfhNi9z6ekpmTEBb1pvJSssWSgTbNQoXRgMeawrq7Bej2GjfHnMPIvwJsWXlehwy2
         2NZjIzyWHNA0OlwkWiEJskcMXQ+v3tt2nDqvNEs5pie6KM2uZzghTN0fTDWM2aIeDLMA
         J5PA==
X-Gm-Message-State: APf1xPB1UR34k3TsHadm3leTVOkJSofnQP5Qo+ax9w7lcqhHYFSuhztg
        1rQYGzLPymvRHuWN+leV8W2T2iCnx+w=
X-Google-Smtp-Source: AH8x226b9mCT7QtVvFFQj+PGEwNjERrhX8ihsYb0Eo9WmDc1AHMGAZJ6ME+dcApfQ7dNI1rbDuo7PA==
X-Received: by 10.98.196.13 with SMTP id y13mr3908939pff.73.1517958046171;
        Tue, 06 Feb 2018 15:00:46 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id v11sm48999pgf.83.2018.02.06.15.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Feb 2018 15:00:45 -0800 (PST)
Date:   Tue, 6 Feb 2018 15:00:44 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Prathamesh Chavan <pc44800@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, gitster@pobox.com, sbeller@google.com
Subject: Re: [PATCH v1 1/5] submodule foreach: correct '$path' in nested
 submodules from a subdirectory
Message-Id: <20180206150044.1bffbb573c088d38c8e44bf5@google.com>
In-Reply-To: <20180206145406.b759164cead02cd3bb3fdce0@google.com>
References: <20180202045745.5076-1-pc44800@gmail.com>
        <20180202045745.5076-2-pc44800@gmail.com>
        <20180206145406.b759164cead02cd3bb3fdce0@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 6 Feb 2018 14:54:06 -0800
Jonathan Tan <jonathantanmy@google.com> wrote:

> > There are two different possible solutions that have more value:
> > (a) The path value is documented as the path from the toplevel of the
> >     superproject to the mount point of the submodule.
> >     In this case we would want to have path='sub/nested'.
> > 
> > (b) As Ramsay noticed the documented value is wrong. For the non-nested
> >     case the path is equal to the relative path from $pwd to the
> >     submodules working directory. When following this model,
> >     the expected value would be path='../sub/nested'.
>
> A third solution is to use "nested" - that is, the name of the submodule
> directory relative to its superproject. (It's currently documented as
> "the name of the submodule directory relative to the superproject".)
> Having said that, (b) is probably better.

[snip]

> > +cat >expect <<EOF
> > +Entering '../nested1'
> > +$pwd/clone2-nested1-nested1-$nested1sha1
> > +Entering '../nested1/nested2'
> > +$pwd/clone2/nested1-nested2-nested2-$nested2sha1
> > +Entering '../nested1/nested2/nested3'
> > +$pwd/clone2/nested1/nested2-nested3-nested3-$nested3sha1
> > +Entering '../nested1/nested2/nested3/submodule'
> > +$pwd/clone2/nested1/nested2/nested3-submodule-submodule-$submodulesha1
> > +Entering '../sub1'
> > +$pwd/clone2-foo1-sub1-$sub1sha1
> > +Entering '../sub2'
> > +$pwd/clone2-foo2-sub2-$sub2sha1
> > +Entering '../sub3'
> > +$pwd/clone2-foo3-sub3-$sub3sha1
> > +EOF
> > +
> > +test_expect_success 'test "submodule foreach --recursive" from subdirectory' '
> > +	(
> > +		cd clone2/untracked &&
> > +		git submodule foreach --recursive "echo \$toplevel-\$name-\$sm_path-\$sha1" >../../actual
> > +	) &&
> > +	test_i18ncmp expect actual
> > +'

Wait a minute...this seems like you're using my "third solution". If we
were using either (a) or (b), $sm_path would contain slashes in the case
of nested submodules, right?
