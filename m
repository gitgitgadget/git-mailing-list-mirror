Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9371F462
	for <e@80x24.org>; Tue, 11 Jun 2019 21:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406954AbfFKVL4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 17:11:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42474 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391155AbfFKVL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 17:11:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so14533432wrl.9
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5eC/2RZ9KNfGLJrYMzdChmfE2GJvAVYHsdRW/8cBkEY=;
        b=jeh3MBcmmIa4GHDsFSa/wxJpxEWU3Cna7KkgDyw0xuz+YzC8SbSmoY6yBJEIo+se+m
         9tTw32agCVXGulW4HKO+w+VlA6isPTnOCC7El+5Fmri/dTwhtHLb53J9fyCGqiqI8dfl
         zNsO1QnWBTzhDx9yaek6334YSmrYrm1wEHYVtpo3WIJlBX34FKf6w9QMtmkVvxVm1N6w
         1r4/jVVrEgaICa894K/zTnpuSjx4B4NPEg50MspyiT65XsyEDbQ3ttdeijxF9bqMz4n1
         i4IzKhVJW/luO5p3Nq8ZdkXmLLCS9o9FiTrjTkP5qW6QuJMw+r5qqkv33TVxqqni821f
         Q+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5eC/2RZ9KNfGLJrYMzdChmfE2GJvAVYHsdRW/8cBkEY=;
        b=Yqfn/nqhJLrS/52T8dCQTa9ekXbq9adIbDItt5sT1yIJnKlOTRFW4BTt3+67zkxlyf
         0mFTK/PMYEWhfI7oeDWoGcniEC5FVKGVW0xM8QJNaxpIO5gakMI7IPJgQ3CltSAa6K1z
         AMFb5ol3M3Qz8PGmMw1Dv5m5BOETy5dpSGvgXGTUUaI3QOrLQi7n/mKulE3dcUYay/FL
         PFe80XiC82A1VbkfPX6VQN/fwcf7djo+yxaHH1GhsfjlU55RqwMRtMWH4KhTFjHpbI8v
         ++mCKlqYU0p93HCTLKqv88oti8r33pc7k+fw6be4cPuZlWotg4WWWf07xAoROCe+cc52
         GLdQ==
X-Gm-Message-State: APjAAAVCeA8DFROvIW+s2/gcm75suQ4HnvVf30/3omwnMujLNsmOLmZv
        o5TblS8dmF6/3Nvjan++Zr8=
X-Google-Smtp-Source: APXvYqyRdbXEmzmYq9XYExlfqBOhENQgjASYeqsREFL1HhVLAUEQFqk20+XJ+9FuZKkeR/KqokofLA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr51444559wrr.324.1560287514387;
        Tue, 11 Jun 2019 14:11:54 -0700 (PDT)
Received: from szeder.dev (x4db6e6c5.dyn.telefonica.de. [77.182.230.197])
        by smtp.gmail.com with ESMTPSA id o13sm25188440wra.92.2019.06.11.14.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 14:11:53 -0700 (PDT)
Date:   Tue, 11 Jun 2019 23:11:51 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
Message-ID: <20190611211151.GG4012@szeder.dev>
References: <20190430142556.20921-1-szeder.dev@gmail.com>
 <20190611130320.18499-1-szeder.dev@gmail.com>
 <20190611130320.18499-4-szeder.dev@gmail.com>
 <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 01:36:16PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessfully rebased and updated refs/heads/missing-commit.
> > +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ                                                                                QSuccessfully rebased and updated refs/heads/missing-commit.
> >  EOF
> 
> Yuck, 

Oh yeah...

>... but I do not see how else/better this test can be written
> myself, which makes it a double-yuck X-<

Perhaps hiding those spaces behind a helper variable e.g.
'dump_term_clear_line=Q<80-spaces>Q' and embedding that in the here
docs specifying the expected output in these three tests could make it
ever so slightly less yuck...

> Are we forcing out test to operate under dumb terminal mode and with
> a known number of columns?

'test-lib.sh' sets TERM=dumb relatively early on, and in these tests
we don't use 'test_terminal' to run 'git rebase', so...  yeah.  And
term_columns() defaults to 80.

However, if the terminal were smart, then we would have to deal with
ANSI escape suddenly popping up...
