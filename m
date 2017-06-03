Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9736B2027C
	for <e@80x24.org>; Sat,  3 Jun 2017 00:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751180AbdFCAPP (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 20:15:15 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34467 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFCAPO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 20:15:14 -0400
Received: by mail-pf0-f169.google.com with SMTP id 9so58357156pfj.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 17:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lDziTfPdn9+SuXUSopDFKiHUnsU6KwGOGNScQ4IFiEs=;
        b=tka2xBzYIvFdChPO6RzNyxeW7BF3a/D+ZrfLtHffEhvNJykIKSndFksdaKvXTWsla1
         qwWRrrPaJDvRVfTC2HUaNVv1/EYAwffww3SwhKF4edC/Xgyt/tU2TRGsjbIS1wKH+TLH
         USdhGH+iBbFkjfB1mGaNYgSMBRb2Wb9b17C+Cr6grjWEpUQeszCZGX1Dlu97asZf/0ya
         VDdq+zccLZreUzo6GzRrYDJXOEg3MkwqHFrF45Ecld18ykJQ+/yY6hFhRHxol5dtH/8O
         pP1mToZEWGo7KfZe3mBYzGFdT5Ol4WTpFE6etqaQ5s1vYS3D4pW+Ggn8HLXF3O/fQggd
         bVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lDziTfPdn9+SuXUSopDFKiHUnsU6KwGOGNScQ4IFiEs=;
        b=s9yjMukEMDP00xnz/YkfvQc0cP5vzNrZr6WH7bBmMG2yy8vAd2ejGrvl/t4TOv9l0f
         mIfCXMOb4rxQkDx1QBJaEC0riHs1C9WZlOcBaYgBBxPQVs82JsDYLQ/MzweGzMgmLxDm
         fglfjZz3vUrvvX01ZI2/n5sfEI7zCHvzDiT+iOy1/wTWbP3yKzrtUJx7q+5DjY9zTdt6
         2cGVY33awd8lO2TnILJfQsDlGI3WNS04BjcP7LggZ0uukCWQzKrYSwrf34yd0mMRGY8w
         ZD/ywUyd32YKhOa6NFM2KIdJW2A0/XJjUfLT35l55gTPIJ/vG9P8axf2JsDikHarxYCw
         P2pA==
X-Gm-Message-State: AODbwcCi28si2Quuz7jy7I9Lx67R60Mh87fGrTQzTDpbUpxB04HdW4Fr
        0WgKzktYGNnUMQ==
X-Received: by 10.99.109.9 with SMTP id i9mr9643585pgc.56.1496448913711;
        Fri, 02 Jun 2017 17:15:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id c123sm11674763pfa.100.2017.06.02.17.15.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 17:15:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Martin \?gren" <martin.agren@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
        <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com>
        <mvmmv9st3yv.fsf@suse.de>
        <CAN0heSrzpwhS3Zf83vTzHAAmi8YVD4CoCh_px5SBXBZhSKPqPQ@mail.gmail.com>
        <CACBZZX6H9EZTLVnunoH2641fw6QmQL=hO9isinK07-dHnuxyFQ@mail.gmail.com>
        <CAN0heSrZcW3b6Osa8XNs0ghg2RE0ZS6FdPq8oPpwLcJjXAtLHg@mail.gmail.com>
        <CAN0heSp9DpW4_0QL57_oAHGu+os8k6yd=Z5+0MJnaL6iXTa-qQ@mail.gmail.com>
        <xmqq37bj454a.fsf@gitster.mtv.corp.google.com>
        <CACBZZX7EvUqH28uni+r=RUBXb9=WTp732B4=rq+ViD_kecxZaw@mail.gmail.com>
        <20170602144622.xottin6efikpkdel@oracle.com>
        <CACBZZX5iSxKz9p1V5h=t0+QtrY75g6haqRqMu7GEfrJHpWkefA@mail.gmail.com>
Date:   Sat, 03 Jun 2017 09:15:12 +0900
In-Reply-To: <CACBZZX5iSxKz9p1V5h=t0+QtrY75g6haqRqMu7GEfrJHpWkefA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 2 Jun
 2017 18:53:11
        +0200")
Message-ID: <xmqqzidqvsdr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, Jun 2, 2017 at 4:46 PM, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
>> 2.13.0 is very much broken for me on SPARC.
>> {maint//git} $ make -j120
>> [...]
>> {maint//git} $ ./git log
>> [1]    1004506 bus error (core dumped)  ./git log
>>
>> This is with b06d36431 (maint).
>>
>> The same thing happens on v2.13.0-384-g826c06412 (master).
>>
>> v2.13.0-539-g4b9c06c7d (next) works for me, as did following the
>> instructions on upgrading the sha1dc code myself.
>
> Thanks a lot. So that works as I suspect on SPARC, hopefully it'll be
> in master (and 2.13.1) soon.

Thanks.  Hopefully your ab/sha1dc-maint a0103914 ("sha1dc: update
from upstream", 2017-05-20) should be sufficient for helping the
users in the real-world, then.


