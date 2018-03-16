Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865801F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeCPVeq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:34:46 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41191 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeCPVep (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:34:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id f14so12911297wre.8
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rxdi+G4W18dwAJklSUKZA4P+69eFmpowHAZ+E100HNY=;
        b=mumOw5WdQPPpuWrqdTBhGBi2rSG/KWjsyf4guRnH0lgdPwBCPV8h9rGw0BR0NILqa1
         TueF/CLlsLlD20zjWSi26yxE+TkPzYXs/kn9FFxJVrd5/3lnzutp4UdpWSzwfGalPe5L
         UKKV1MlFcKBJnHFbQhPJF9N3cOPMc1h1iMvSJ0qXDlIitOsHZ/wphpct2JwSKlEvKG8+
         GgcYXpjkF1gBo6PRTeidE6fnw/ghfKZ8FOA3OY9K9DHw/SLEfw5WbSdaEIyE7NxsI0gZ
         mJlJ8ig5ljflwKhAP9AJqp2q2xgcds6HekOI0rtLiHOg2+cj62rGOj/+dfgllZekt5So
         9/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rxdi+G4W18dwAJklSUKZA4P+69eFmpowHAZ+E100HNY=;
        b=PzMq07Ytx3DQRTRiQ9NVl2HoTJo/pPsDYWtpW94LBuxD04CLrz+9uuPqYt9dmXzOtg
         lDkn7jBWHU2FffYY0yjrs3Ke/NJs+AXqQJvnHTrS/EnKznSTiHU3ueBuZVCbSs7Odhlq
         vz4x7OD0E9kKtZ8yAIMHDttlICDdqC/6QJhPuJjr4fV3LTv9+ZZUNSBJQ/22LVrMxaJ7
         M7C5hSSTb0AkFjLQgCCPYpFkC/k3Rh4ozkq1Rm5mHZdVBgOVsdRUd74N2dPVbXOrJJcM
         tAk39qLmUe3Bf+EWC9pjIdQ3o8hnslP3kuYr73TAdB8HaTsGBeHseHND3n0zmBKm+nOi
         aoMw==
X-Gm-Message-State: AElRT7Gh3lUEa8HZ9I3m1Ysj0nmrQeFlFEJndY2LzbDzDgbz2kxqbtZv
        iKql2voxRk2wemqFWFl7wgs=
X-Google-Smtp-Source: AG47ELsE034n1OPmk9tl4vcX2ZXrrJeIPIJIOFbje9t5sTjK3YpgXGDovFf04e7VOzGUS528DH84vQ==
X-Received: by 10.223.176.237 with SMTP id j42mr2947580wra.25.1521236083503;
        Fri, 16 Mar 2018 14:34:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w29sm8225187wra.84.2018.03.16.14.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:34:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 09/11] pack-objects: shrink size field in struct object_entry
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-10-pclouds@gmail.com>
        <xmqqmuz7242v.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 16 Mar 2018 14:34:42 -0700
In-Reply-To: <xmqqmuz7242v.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Mar 2018 12:49:44 -0700")
Message-ID: <xmqqpo43zoul.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Also, don't we want to use uintmax_t throughout the callchain?  How
> would the code in this series work when your ulong is 32-bit?

My own answer to this question is "no conversion to uintmax_t, at
least not in this series."  As long as the original code uses
"unsigned long", this series also should, I think.

