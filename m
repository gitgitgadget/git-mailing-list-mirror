Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB9071F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751766AbdFJBkl (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:40:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33398 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbdFJBkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:40:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id w12so153192pfk.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=HStlfpgBe2eDQ8reytSmimOYhmO40vh/ipVGhUGuPiU=;
        b=GP9h2P/480PRbnQi6rERuA3pf0alBZcUYd8NGMhe5oR/qdnXIN9IWGCJayFCOYLsm1
         rt4+y3l/sdL1ZFy9V3xZ/ugQpEDbtt+wcfLm/eiHSHZT/IxMN12gcCGkBi4q3BCWPTXg
         Sc5A1AbgeUKT/wlCfFZQWmNJyiQrTscT8yxPb/doTPHvrRIk4ubUJwNeu8WjWRSRmDB8
         YmJ7lepo8ziBQE08EKSDWJyWhwa0yqvHqjd02dVPeKXNKyWP3EEqV/wdAUOBtHN8YG35
         BUPmTwq5t/ga++suwWrLeixixBVNrDZTpX/iWI1GvQ1T/avKaGqlsEnhvwDF1IcJrTHQ
         ofhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=HStlfpgBe2eDQ8reytSmimOYhmO40vh/ipVGhUGuPiU=;
        b=CaMlHL1l/CXzDKBsH3pSB8DenH9dlBV4da4goFJCDwVqk1pEoQvUdvbci1fKLgjCpl
         LiSXiXi+Z0LDrJvGH3rX2e1znLbSrywVsAB4IOx0sot2kAwDetcZUdifi96uExEwSIlJ
         Sg+ENpqahFsd89KXRKjGj+9sdzwfTUw9sr3KT2qRuCfdSOvYnDWBhk3ZRMCOG+HTZCx1
         ngnZVzKNtx4ya6fXb1fiAklA7WWL7n9n5MBA3dRrjz4TWZfoV6MJ9H7yp1K2GEp0hUw4
         mUZ5r7YHSTaBF+LimjwtUgJKMaTy3j1LcI1ZvNByN5lECqnJx2B+8t6a72Kl3RBRmKWD
         63iQ==
X-Gm-Message-State: AODbwcCYA+r2lL+l4qrhVauGAdw4KZMn1tQtH0jaruU8sdCi0gfRjw0k
        gU7IlgbHyDgGQw==
X-Received: by 10.99.95.87 with SMTP id t84mr45937466pgb.193.1497058839683;
        Fri, 09 Jun 2017 18:40:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id q135sm4625615pgq.41.2017.06.09.18.40.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:40:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around free(ptr); ptr = NULL
References: <20170609085346.19974-1-avarab@gmail.com>
        <20170609220420.4910-2-avarab@gmail.com>
        <20170609222738.GF21733@aiede.mtv.corp.google.com>
        <20170609233701.GA7195@whir>
Date:   Sat, 10 Jun 2017 10:40:38 +0900
In-Reply-To: <20170609233701.GA7195@whir> (Eric Wong's message of "Fri, 9 Jun
        2017 23:37:02 +0000")
Message-ID: <xmqq60g462nd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Hi,
>> 
>> Ævar Arnfjörð Bjarmason wrote:
>> 
>> > Add a FREEZ() wrapper marco for the common pattern of freeing a
>> > pointer and assigning NULL to it right afterwards.
>> 
>> I'm conflicted.  On one hand it makes code more concise and makes it
>> easier for people to remember to assign NULL after freeing a variable.
>> On the other hand it makes git more of a custom dialect of C, which
>> may make the code harder to read and hack on for new contributors.
>
> I think this problem could be avoided by using a more explicit
> name, perhaps: "free_and_null"
>
> Seeing the initial subject, I thought this series was short for
> "freeze" (like "creat").

Both match my thoughts exactly ;-)

> ...
> I don't see the point of a macro wrapper, forcing the user to
> type out the '&' should drive home the point that the pointer
> gets set to NULL.  I also find capitalization tiring-to-read
> because all characters are the same height.

Sounds sensible.

So make Jonathan's freez_impl a public API and rename it to
free_and_null(), perhaps?
