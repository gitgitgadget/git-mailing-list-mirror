Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D573DC54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10A12071C
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWgBiBtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDVWrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVWrO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 18:47:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BA7C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 15:47:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 18so675364pfv.8
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oJYo0mjwavCY33qN1Ize6fDHHT+TDw5dFsJzEewqkec=;
        b=RWgBiBtm6/CnyZ0IyAUQgM2m1dL2Kx7SPm05ZMAPAxbf86fTDuFx88QLekcng5npsH
         JVc6OqwjXgG5Y2hqJBZ60bFP48on1QR+mGHeWTMWsMyTJxSz/mRbPpG1/mA7FJJ9URv0
         xgGb37ubh/gnADX/5Ro94dCxntkKQvJ1AWAqz0E7ZwVBslvkTDuEfLfnETJSSVn2vKqo
         dMzagY+j22Id0ttopHdJTE/pS6wWyOckZiw5AJ4xPfNi18H5CNgDu6nzVO/IOLc57cfc
         s/X3QUNPsTFyQPDUu/YFB+oOf0LcbWOE8veMiQ5JRoPJ1pLkF3Fl4cD/P/Z9pWZ7srYr
         d1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oJYo0mjwavCY33qN1Ize6fDHHT+TDw5dFsJzEewqkec=;
        b=C8IdSAcdknfFJ3x739UVZ7v2HC2Pze2fEbBqDI4pPy05vF95GOfRksBITu69ZG/wVn
         7kODQjQCVgZ4c4f0GjOCdB9LFnSBppUpuF9WKKq9J7n6d8K64dx5VD103wrtRqtNNvmG
         +bCilJx7DXJSiKIklqI8d0/C9KQoAlCp6M37Is8O/z3siJIgS6OfUvipOFD96RGJ1jfN
         HU9o4IfTiL1yKlr6VvDiyvUKGfeJpf+QEKKhHnsGk68o7Dq1VvIitb9R76mqxaM/EbtV
         1tv1lTbfLv7ApL9YsCK/uZclA6peyvfvMmak9wMWjJ0Yr7F4uxMWCXaC3gulQn5+77K8
         KxYQ==
X-Gm-Message-State: AGi0PuZVVOhmCqSo06l84MfRB8ICI62xmQb+qDBN+7MCEugEmdH4FRtI
        PvN9Zjt+UxYZMlIJZqU8S8U=
X-Google-Smtp-Source: APiQypLvYOqyIdu2hLFeFcte7LA5kWniSnUD/URwJe4Nxuxh3omT5KxTGcKmvxEtsODa7a33DLgXyw==
X-Received: by 2002:a63:4f65:: with SMTP id p37mr1322765pgl.60.1587595633792;
        Wed, 22 Apr 2020 15:47:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id r26sm570543pfq.75.2020.04.22.15.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 15:47:12 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:47:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH 0/3] credential: handle partial URLs in config settings
 again
Message-ID: <20200422224711.GC140314@google.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
 <20200422221334.GA571740@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2004230019170.18039@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2004230019170.18039@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:
> On Wed, 22 Apr 2020, Jeff King wrote:
>> On Wed, Apr 22, 2020 at 08:51:02PM +0000, Johannes Schindelin via GitGitGadget wrote:

>>> Please note that Git v2.17.4 will not do what we would expect here: if any
>>> host name (without protocol) is specified, e.g. -c
>>> credential.golli.wog.username = boo, it will actually ignore the host name.
>>> That is, this will populate the username:
>>>
>>>   $ echo url=https://example.com |
>>>     git -c credential.totally.bog.us.username=foo credential fill
>>
>> That seems scary. What if it is not .username, but:
>>
>>   [credential "example.com"]
>>   username = foo
>>   helper = "!echo password=bar"
>>
>> ? (Or you can imagine a helper that is pulling from a read-only store,
>> like "pass"). That would send the credential to the wrong host.
>
> It would. But I am not aware of any implications regarding `.gitmodules`
> (for some reason I now expect every bug to open an attack vector via
> submodules, I wonder why that is), so that's at least good.

Submodules are only one of many ways that people end up cloning from
an attacker-controlled URL.  In submodules we're careful not to use
--recurse-submodules by default at clone time.  So I'll mentally
subsitute "attacker-controlled URLs" where you say "submodules". ;-)

I agree with Peff's concern about the unpatched state: since there are
people who use `[credential "host.example.com"] helper` and there are
credential helpers that ignore the host passed in, the combination can
hurt people.  (Fortunately, there aren't many credential helpers in
that category that are commonly used.)

[...]
> Yes. For the record, I tried to be very careful here. The _only_ code path
> that is affected by this change is the config reading.
[...]
> But again, I would love another pair of eyes on this, to confirm my
> analysis.

As mentioned above, the config reading is sensitive, too.  That said,
I suspect you got it to do basically the right thing.

Reading through the patches.  Thank you.

Jonathan
