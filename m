Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E800211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeLDLUW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 06:20:22 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:33830 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLDLUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 06:20:22 -0500
Received: by mail-wm1-f50.google.com with SMTP id y185so9159996wmd.1
        for <git@vger.kernel.org>; Tue, 04 Dec 2018 03:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pfjJzHIj/xNBihQgDGCzZ0UAB+kMTEc0wI0VJOI3x/g=;
        b=nOSa/CQs0bIFVrMM7Le52Hb8oiXaH5Qf2NjlbnqrSI3gKrFmn72bg0Y+0p83GQ6bqv
         yYtOIlVlgtWUbOERKZXx2J8JJrvdPDIWVCofz7rIufZYrOlj+8ZZz8z2tHINHPrgWfgQ
         ZgytHw5/QILoRgTWlrltgEAoR9C1zVsqPZeP5DnXB2qmcSrPUsNFWZnphFdglkUmkyvJ
         JFS+yFzFXZmv2nxM8cATCc68ZCBSx9Trk6uEMNP5LSkEgewsvuQZdGFvHYvvHtbGJT54
         /iUOMwwCOLwayZqSedrR9Wobf+3zcQHtZEmCxu4wOr8fTx4vP0ByQfO+Aqoav2Hew6OH
         nhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pfjJzHIj/xNBihQgDGCzZ0UAB+kMTEc0wI0VJOI3x/g=;
        b=oNe4a3QYHbSpXgdhL8vSoFnuhJMFQKz+i88Jl6Llev4hL6082GxvsOMzmDdVTYqv8h
         5/9oDDwjGEt5DSb/JlicDRVjOnGH05+EMqNMyE4RkB8kNsTld3IDkKMLQigrUZQ29xWZ
         L6Vk6TJzcvqodUkkPtjkLzovgrctRrxtoaLwtQMIulbQIBufsm4UqP6Lys8JOnbyH4oz
         6mHFRX4B+LHGkWwtfnwc6LhE3vV6cUIwfCPMvtCoWGqeczvHoCOluEWMLpmOfX0n+kZW
         hNPw6Q0SxU2rsiel9LP1VwdaXieb8KlYJkdXBlEcnNM1n+tvdGFwvqfEDkqq0k6HsQ9m
         w7Fw==
X-Gm-Message-State: AA+aEWYkqtPkf6N9D+drjzjUUjOgQIztwPiJ0eXSmJtHFfftA+FDQV/r
        IwzVi1H4b9K6Eia9iFk2Ojg=
X-Google-Smtp-Source: AFSGD/U20WVeq2uJgT0cu6Hc2nKZNSbobVZgh9pq8hocH3rdcUQrdoOki1z8mSoMRIM0S1ZwfI1YpQ==
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr1241195wme.108.1543922420352;
        Tue, 04 Dec 2018 03:20:20 -0800 (PST)
Received: from kinodont-arch (ip-89-103-14-213.net.upcbroadband.cz. [89.103.14.213])
        by smtp.gmail.com with ESMTPSA id 6-v6sm9338893wmd.45.2018.12.04.03.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:20:19 -0800 (PST)
Message-ID: <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
From:   =?UTF-8?Q?Luk=C3=A1=C5=A1_Krej=C4=8D=C3=AD?= <lskrejci@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Date:   Tue, 04 Dec 2018 12:20:18 +0100
In-Reply-To: <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
         <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2018-12-04 at 12:04 +0100, Christian Couder wrote:
> 
> Could you try to check that? And first could you give us the output of:
> 
> git merge-base 5b394b2ddf0347bef56e50c69a58773c94343ff3
> 94710cac0ef4ee177a63b5227664b38c95bbf703

$ git merge-base 5b394b2ddf0347bef56e50c69a58773c94343ff3 94710cac0ef4ee177a63b5227664b38c95bbf703
94710cac0ef4ee177a63b5227664b38c95bbf703
$ git log -1 --format=oneline 94710cac0ef4ee177a63b5227664b38c95bbf703
94710cac0ef4ee177a63b5227664b38c95bbf703 (tag: v4.18) Linux 4.18

