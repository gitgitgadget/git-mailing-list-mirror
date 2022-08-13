Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0E2C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiHMJTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 05:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 05:19:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426B1EEC4
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 02:19:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l4so3469448wrm.13
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=woasTxfh4HsCtO6BZ91p85+YHOJNpUdYaxOG4teYaBk=;
        b=QcuvWNWZKt1GDtpBgAOkvrK3P7kByBtzCPiIbOJTqQGX4sniNoEVo1gbn/n1Rqm6WU
         OaUmJf4wv7x/UjEZj+cVfNtTG2Mqgl99RCSUejEiiU+NBkJVomp0l+vKi8Fmsk7Br2yb
         X562L3ViW4LrvDx4R1Qvu2Xj3OKOnrkUlAdb6vscD98+XSDn+NMKMvAfLK+ZM52AZQj5
         Zsi9eMbY/0XG8eemjXrHSFEpFpgTYNe9PYy9WDQagECnkmN/TfMFp/CuvnXrFFNMh/Nk
         ZxND/04c2uGKcDgSRaBfcCoxz/pcfuc5CYTVD1qtf5bITzu3wtbwUEAb+N4mu/Ml7Nlo
         Iybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=woasTxfh4HsCtO6BZ91p85+YHOJNpUdYaxOG4teYaBk=;
        b=7mH3InGiPDDIPf+QSVyvyWmZjPwazCa3C1tMLbRcwCRkH2rt8DxaXyHJipT1lkpBoB
         G5J8bb755JLoSb+9o2KZYDTywH0JtuU//voC0lqL4t135La3DKMWWPsPktnxLhYpkGML
         6/Vcxja9n8KH71DBmHNZDtSYSwnBDQvOLCexhOw+p4aoPiwtsUpw9E+lG8NjklYNbc3h
         pwwgWcnWMMDmNfaPx5tdUP4K8OruQdb7+IvprLtgvbZuv2pDiTrSPK4CECBwLDHJdIB2
         JdApADpxktPO57zzCNvebXcrn6eZn1swebRGi3PBwnQ6L0R3yUs4RTZMP8VbsqePVu9p
         ntKw==
X-Gm-Message-State: ACgBeo3m1L2LbmHoTF647+gcVM/wo69lT5Qk4EzgjmeSs8IpK7t6JhO2
        Z2H9G2rQpB4JgmBU25ApNjFk8Dyy/LG/JUw3
X-Google-Smtp-Source: AA6agR62C3akBtATcYk7Y68l3Ai6naa4wtjj+kh000YH6AE0PGbmmTmtIj/YNRsv8Luo9jCAfjJAaw==
X-Received: by 2002:a05:6000:1367:b0:21f:156d:1a8e with SMTP id q7-20020a056000136700b0021f156d1a8emr4052361wrz.89.1660382382244;
        Sat, 13 Aug 2022 02:19:42 -0700 (PDT)
Received: from [192.168.2.52] (68.83-213-117.dynamic.clientes.euskaltel.es. [83.213.117.68])
        by smtp.gmail.com with ESMTPSA id c5-20020adffb05000000b0021e4f595590sm1596718wrr.28.2022.08.13.02.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 02:19:41 -0700 (PDT)
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Rub=c3=a9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
 <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr> <xmqqk07iu3c3.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <be21e2ba-1c57-a5aa-a986-64413f3983c3@gmail.com>
Date:   Sat, 13 Aug 2022 11:19:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqk07iu3c3.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 6:06 PM Junio C Hamano <gitster@pobox.com 
<mailto:gitster@pobox.com>> wrote:
 >
 > Johannes Schindelin <Johannes.Schindelin@gmx.de 
<mailto:Johannes.Schindelin@gmx.de>> writes:
 >
 > > @@ -1420,6 +1420,12 @@ static int 
interpret_nth_prior_checkout(struct repository *r,
 > >       const char *brace;
 > >       char *num_end;
 > >
 > > +     if (namelen == 1 && *name == '-') {
 > > +             brace = name;
 > > +             nth = 1;
 > > +             goto find_nth_checkout;
 > > +     }
 > > +
 > >       if (namelen < 4)
 > >               return -1;
 > >       if (name[0] != '@' || name[1] != '{' || name[2] != '-')
 >
 > If a solution along this line works, it would be far cleaner design
 > than the various hacks we have done in the past, noticing "-" and
 > replacing with "@{-1}".  For one thing, we wouldn't be receiving a
 > "-" from the end user on the command line and in response say @{-1}
 > does not make sense in the context in an error message. That alone
 > makes the above approach to deal with it at the lowest level quite
 > attractive.
 >
 > In the list archive, however, you may be able to find a few past
 > discussions on why this is not a good idea (some of which I may no
 > longer agree with).  One thing that still worries me a bit is that
 > we often disambiguate the command line arguments by seeing "is this
 > (still) a rev, or is this a file, or can it be interpreted as both?"
 > and "-" is not judged to be a "rev", IIRC.
 >
 > Luckily, not many commands we have take "-" as if it were a file and
 > make it read from the standard input stream, but if there were (or
 > if we were to add a command to behave like so), treating "-" to mean
 > the same thing as "@{-1}" everywhere may require the "does this look
 > like a rev?"  heuristics (which is used by the "earlier ones must be
 > rev and not file, later ones must be file and cannot be interpreted
 > as rev, for you to omit '--' from the command line" logic) to be
 > taught that a lone "-" can be a rev.
 >
 > So it is quite a lot of thing that the new code needs to get right
 > before getting there.

Agree. To make a substitution in the command line and to consider "-"
in interpret_nth_prior_checkout, I see them as two very different games.

Previous to this, I thought about making also a "git diff -",
https://github.com/gitgitgadget/git/pull/1314 
<https://github.com/gitgitgadget/git/pull/1314>. Suddenly there was 5
commands with this substitution (checkout, merge, rebase, branch, diff)
so I follow a little the path now Johannes suggests, making the
substitution "- ~ @{-1}" deep in the system. For me, the implications,
error cases, test cases... to consider was not worth the change to
get what I was looking for: align the workflow "checkout/merge/branch
-d".

Also discarded the "git diff -" change, because of so many flags and
conditions "diff" has. So I only sent the "branch -" patch.
