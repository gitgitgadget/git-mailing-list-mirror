Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7767C201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbdGCQ4e (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 12:56:34 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33454 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbdGCQ4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 12:56:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so23686715pgb.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 09:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BMpchk7LZDmcgkQ18BPKMrX5utBaDamBka67i551aQ4=;
        b=r4jj1+PhtspX7yw8xwwHIX72Dmn28L7mG2UxoPTldgs2zxs+OU5tTugwZ+t9a6kQ7T
         16b44tC/+CHtfqiYLMLDtw7W+v4pYYcHnq4Y0vXhvP3fVCqwqPs199rXBHEPXWwSYT2n
         XVhfs0GoBaC47qYe+AAYeUX5+Tj6txx6/9WQTC/NR/d5J2U09AcpSZQcTsG9EVUoL2AE
         HTpisv0l7A5MDYt8P/X15R3t0BvaS/muZo2gfshOYw8BlQNOg1SP7W+KcFliLJJHkGxo
         4XxMD2fvxb9jstmrgxkfqgW6lMtOARcSVKyklKXkHEuNf1VlhTldy6mCF0Lcd1Mz0oOa
         NahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BMpchk7LZDmcgkQ18BPKMrX5utBaDamBka67i551aQ4=;
        b=dGSlX2cFENEIoaQpRAff5zJcyIYy/zTdHSzOT02TvCFcf1RvQvamjnUag3IuZ8hzGL
         dr8kPB7ZeKV5aQMAGBGv2EzwPbH+iTLjSEJgtEL+ga4HlntIrWhg1VyNJv03BENV0Cvb
         yVUIKuE20ZaelpwnwjEjuYfRY2Uvb5y40ouzeCvDMEdiTl5tr5y7qgamfY5SgcZMh0Jm
         4vd3VoHhVYMeERFYUBpIlR17g027UH/7lvKPqchBW0De5/Gvfc6Ym4msYdJDN2SJHIvn
         ACfJ5wJiQ+GHrSJvmaYPXujS67eyJk3O4UH5pq4Ldtw+AHGmFzGm2Vh+PbK/kBEPDDQO
         uUig==
X-Gm-Message-State: AIVw110pbK0lA63wRf+L0ofJjGhXu+MPCt11nHCUJvZmX/UOm+12aJQj
        W4anYW2HlDeF9g==
X-Received: by 10.84.176.3 with SMTP id u3mr11613834plb.134.1499100992307;
        Mon, 03 Jul 2017 09:56:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id s9sm42381915pfe.67.2017.07.03.09.56.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 09:56:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v4 00/49] Add initial experimental external ODB support
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
        <4be750af-b093-6644-7f0e-82983327766a@gmail.com>
        <CAP8UFD2hghBePr-WVLiA6P0rS5=JPLmsxqJ_6rEWrqG3VEd7Dg@mail.gmail.com>
        <xmqqtw2vnbho.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD3YPXRDc8ThSuTWjKDQ2i+zqNrhBi6JfEuTPXnNA6LUiw@mail.gmail.com>
Date:   Mon, 03 Jul 2017 09:56:30 -0700
In-Reply-To: <CAP8UFD3YPXRDc8ThSuTWjKDQ2i+zqNrhBi6JfEuTPXnNA6LUiw@mail.gmail.com>
        (Christian Couder's message of "Sun, 2 Jul 2017 06:25:32 +0200")
Message-ID: <xmqqlgo5mpc1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Jul 1, 2017 at 10:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>>> I think it would be good to ensure the
>>>> interface is robust and performant enough to actually replace the current
>>>> object store interface (even if we don't actually do that just yet).
>>>
>>> I agree that it should be robust and performant, but I don't think it
>>> needs to be as performant in all cases as the current object store
>>> right now.
>>
>> That sounds like starting from a defeatest position.  Is there a
>> reason why you think using an external interface could never perform
>> well enough to be usable in everyday work?
>
> Perhaps in the future we will be able to make it as performant as, or
> perhaps even more performant, than the current object store, but in
> the current implementation the following issues mean that it will be
> less performant

That might be an answer to a different question; I was hoping to
hear that it should be performant enough for everyday work, but
never thought it would perform as well as local disk.

I haven't used network filesystem quite a while, but a repository on
NFS may still usable, and we know our own access pattern bettern
than NFS which cannot anticipate what paths the next operations by
its client happen, so it is not inconceivable that a well designed
external object database interface would let us outperform "repo on
NFS" scenario.
