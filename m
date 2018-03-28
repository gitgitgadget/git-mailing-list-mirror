Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC4A1F42D
	for <e@80x24.org>; Wed, 28 Mar 2018 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeC1QwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 12:52:11 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54438 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeC1QwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 12:52:10 -0400
Received: by mail-wm0-f44.google.com with SMTP id h76so6181264wme.4
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7pPoIzm/sQbRYRBUAVxVN7UdCTL9QpDAp3OIEEZYIt0=;
        b=RkNYe0cBjPvuCsbS2vxpvR3dn5lIhP2WAPnltqXzPhA4pyQKXJXZ2v6d8hFoB6Yns4
         pTp9u+4HoIhMuiaSc8eoYHzThg8gp6PMNiO6gEPr/CQKykrmFXGahdSeFJRy1kBOVkho
         qzHgVtNesCkIQBM6jekvnioTvU6XU4BTmn+IMybeAsxy2yzPAXuU0H7BLyJaTvU/MLKp
         yLY5JMSybSDhKkR7HZGtctegMtxaA6rP7msj9+HOSO75Qx22cJqwNEFW/LloTyYhRQdK
         h2jiYEqwOmwAy9d7qWoG+ZEPZvmkzrDr+z9O3C+bhVNMZ8/8xqJpaNdPzMagzLh/fCAr
         2uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7pPoIzm/sQbRYRBUAVxVN7UdCTL9QpDAp3OIEEZYIt0=;
        b=GRE8m44K2LDYr2Gd3HXH0v7SCgn/AQRD5Xa+1sw5td2a8D8/0C8vTMr3epmZJPQUJw
         IdPSfxOkYrGGroAp7NntR6b22z/c8iuwUDSK/WgXAbbExFlB7lIe62Owh+by+cwr3TAn
         QsYixeImRUdkw7D/LHKecBfbzlo/SrN52iepgXTpGG9tsACe+311VRu9pvh3tJ0abJpP
         dfLZtqpN30JLdB6lTAJyPZdhO7eVfoqJwacYBbRn6nsYqd349PwBOsjTVWNr1IXacpzv
         LLBQn3mWmJSlZW0F07zDkmbu4z3OTaCNueoA907P+bgxOaDiNoSe57mQ2XU2T9X3YjYg
         jdMA==
X-Gm-Message-State: AElRT7GKPyB2tXpmmlbUgyc7ZiiZlZbQrCSGvXyh37U8ndr0CeKTgLVO
        mSC+EiQf8vKGAWFMPsPRh9M=
X-Google-Smtp-Source: AIpwx49TML5vwcdQov7xuxqVwWX5Ed5vD1mnIUUdml8l0oZ14RvR9RwPJeVXp/JYAN2j0kzWxXlzzQ==
X-Received: by 10.28.6.14 with SMTP id 14mr3159485wmg.42.1522255928432;
        Wed, 28 Mar 2018 09:52:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d8sm5143898wrf.8.2018.03.28.09.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 09:52:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, jeremy@feusi.co,
        git <git@vger.kernel.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: Null pointer dereference in git-submodule
References: <20180325095046.GA687@feusi.co>
        <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
        <CAGZ79kYagdvpOcZykF4JPQc9vpVb8_xyFiQkE9yznBQTD1PWJw@mail.gmail.com>
Date:   Wed, 28 Mar 2018 09:52:07 -0700
In-Reply-To: <CAGZ79kYagdvpOcZykF4JPQc9vpVb8_xyFiQkE9yznBQTD1PWJw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 27 Mar 2018 23:50:44 +0000")
Message-ID: <xmqqlgec87ns.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Subject: [PATCH v2] submodule: check for NULL return of
> get_submodule_ref_store()
>
> Maybe more imperative, telling what we actually want
> to achieve instead of what we do?
>
>    submodule: report deleted submodules as not initialized
>
>> If we can't find a ref store for a submodule then assume it the latter
>> is not initialized (or was removed).  Print a status line accordingly
>> instead of causing a segmentation fault by passing NULL as the first
>> parameter of refs_head_ref().
>
> Thanks for the message here. Looks good!
> ...
> Which would be added in t/t7400-submodule-basic.sh
>
> Thanks for coming up with a sensible patch!

I take the above to mean that you as a contributor active in this
area like the general idea in the patch but not volunteering to take
this topic over and instead trust René to tie the loose ends with a
reroll, taking hints from your suggestions?

I just wanted to make sure that we won't be confused whose turn it
is next (e.g. me waiting for update to t7400 from you or René doing
the same).

Thanks.



