Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D1F1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbcLGU45 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 15:56:57 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34657 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932339AbcLGU44 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 15:56:56 -0500
Received: by mail-qk0-f175.google.com with SMTP id q130so241206463qke.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B+5QSGde2b/83K+BfVmGFafUjjrel90RzYWTviY2Qkg=;
        b=pJp/14pWPtJcdZ5N+Y07qaDuFFR9QrSJDQCC5YJTPl1v+3n4v3e8BN6moRULgCaEHc
         pF70urqkftvC/KJNLjHtZoUiPXWc27+KGd4VR+xTkk60I/LvJIztZe7zsrQ8qZ5Mwvty
         UiAI1rDbqBBFKsfubDbuvHGznAxQCFc/zY2lGErA4Zq0WUtpuErQlKvflUPtg12LARA9
         vYuzMjbysMdICoau1TujK4uAWohCJAet7iwEP226USzXmk9NbpF0jw+aEKFFVYhC3lbV
         w2AQf2QiV1OstCQlpoTKM6xp7cPgd1yht0ppjzLecqcwAn9TmeJmlfHHntrT1JCDittI
         FgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B+5QSGde2b/83K+BfVmGFafUjjrel90RzYWTviY2Qkg=;
        b=Vo/v7KIb//tppiWD5QXVbGnl3GnusZsgW61P7Y/cZNkYvcWoXh95KWOyr+cOlFqNzT
         9+EPBa+Wz8w4kBCH1REVdPOvlnC11NrtN0I3lcxM4yBkzpOWJ4SY3y+A7uyHlBX1FecE
         mdJklHoDbX+VnresgCHnxEwSndG/6NRWVAEr9+OLiXzapliPYYFrh0p2wC95tb1bWjUP
         eaoktedeSJxUrtUv7YKxLF3egf53pVcCWpLgFoKXLE5MbspB6Ei6K6Hdy7sOlekRmf92
         40/vzUIUyLtYUFiOVfxkpq9K/50HKJc4A3eEnI2O/m2jLMj58T1oBNSlFcQHbRhvxLwf
         lTCg==
X-Gm-Message-State: AKaTC03km4V+dA7HXL0PcACXz30JDVmfRLPyqukw2RdicH2F2SwXYlsPL5D9wyoE2j+gdUlJMyRPh78MnYqpkZ0t
X-Received: by 10.55.105.129 with SMTP id e123mr66205239qkc.173.1481144215447;
 Wed, 07 Dec 2016 12:56:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 12:56:55 -0800 (PST)
In-Reply-To: <CAPc5daX2CZ0=UBMuz70KwFPBDTUgAdi8WoVUJ7gNTq+QEXKxbg@mail.gmail.com>
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com> <20161207194105.25780-1-gitster@pobox.com>
 <20161207194105.25780-2-gitster@pobox.com> <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
 <CAPc5daX2CZ0=UBMuz70KwFPBDTUgAdi8WoVUJ7gNTq+QEXKxbg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 12:56:55 -0800
Message-ID: <CAGZ79kbZBzF20=cfF85_fSuFdpYZuNyhDNCSKCb9HBpLOSV0hA@mail.gmail.com>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Dec 7, 2016 at 12:48 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> So I would expect that we'd rather fix the update_index_if_able instead by
>> checking for the lockfile to be in the correct state?
>
> I actually don't expect that, after looking at other call sites of
> that function.

Yes I checked the other callers as well right now and you seem to be correct.
My initial response was based on the name of the function,
specifically the _if_able
part as that hinted to me that I can call the function with no
precondition and the
_if_able will figure out when to do the actual update_index.

The first part of the condition of the function
    (istate->cache_changed || has_racy_timestamp(istate)
reads rather as a _if_needed instead of an _if_able to me.
