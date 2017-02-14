Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439FA1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbdBNSoD (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:44:03 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36025 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbdBNSoB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:44:01 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so44975525itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wvcpUZL+Aa3W8TQijAMT5VeZaDYb9KG+WgDWzgKfjrk=;
        b=QWYtfZ2jY0NpMStOxHuS2prueg5tUepszbGSUA8XASn502jRKZb0JhF4hlCyWwtuIv
         +3BpesNYVwSj7nX6vvPaiWL42/usSY/nPXR7CogHHzh6Bpy66+ZiX/reYbI0Ij4GeVGr
         oUZ2vPu062j0zmlsQIIc40Xy8nOuxECY1t2zCC96CE7F0P56mTcQGVNeBqd6H5ij35SO
         QWRw9mdfeFHm1HS42Ea9MRkDzMhfsNsl9bh4bFcsnGHDNP1E/0gqwjE4hjqV7ETDI4AD
         cpoEEb2nVqcTXXcmGBotCs6vok0xix5K3CjWtH/pdwxieP7W5fpaqzJhc1qVX4qlwgLV
         9tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wvcpUZL+Aa3W8TQijAMT5VeZaDYb9KG+WgDWzgKfjrk=;
        b=OCdIzOxrnS4NPFdbX6iT/ODgw1tEmJAbFuVI3jdF7/dhVoNOKT31MYvxRyJYizKEGr
         f3EE2vRYJ8vycc29tjdSO0t8/L1TFMFBdZpmyMMKNDX4BjheRfAFd9U3PabB4eotej/u
         P34ERpVeV22dV8RnM6hJmkSQAS0R3PyBeZ2ojQprPI1JYZ9Nx4+gsd4ISfBnIqCxqYUU
         QHXs0qVgYTk/sL3z3T0eMIabrKhD1kn+RKdnyKJWGLdeezjEd2kREGm/UlCADmrUjXZ2
         4Cwl+V86pY1SSBMwr1oV5fPrzuqPEci1PS0htFdsEm6ZUSWFuo27gkgyWoJMYQNPedIu
         wZIg==
X-Gm-Message-State: AMke39l6CR5FhGppfeSBevQzvTI61E1TNh+oTnWJMBsK3aA5un8nRH6VLK7jO8Fz+5Lavyj+hMacvqJf2+490uKa
X-Received: by 10.107.16.14 with SMTP id y14mr26555520ioi.164.1487097840303;
 Tue, 14 Feb 2017 10:44:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 14 Feb 2017 10:43:59 -0800 (PST)
In-Reply-To: <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-12-pclouds@gmail.com>
 <CAGZ79kZC6TntQrW7MF6-h5z5En-u6rwNX=zuaHRNDpbO80ALHA@mail.gmail.com> <CACsJy8ChQqUd4poeeKQruQSwdys=ydzxGDC8fU6ZgfrFEEm7NQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Feb 2017 10:43:59 -0800
Message-ID: <CAGZ79kb9jA9AfpPPPyOeiJPowvZempSq9V_3HAKYXUJQumU-zA@mail.gmail.com>
Subject: Re: [PATCH 11/11] refs: split and make get_*_ref_store() public API
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 2:04 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Feb 14, 2017 at 6:55 AM, Stefan Beller <sbeller@google.com> wrote:
>>>
>>> +/*
>>> + * Return the ref_store instance for the specified submodule. For the
>>> + * main repository, use submodule==NULL; such a call cannot fail.
>>
>> So now we have both a get_main as well as a get_submodule function,
>> but the submodule function can return the main as well?
>>
>> I'd rather see this as a BUG; or asking another way:
>> What is the difference between get_submodule_ref_store(NULL)
>> and get_main_ref_store() ?
>
> Technical debts :) In order to do that, we need to make sure
> _submodule() never takes NULL as main repo. But current code does. On
> example is revision.c where submodule==NULL is the main repo. In the
> end, I agree that get_submodule_ref_store(NULL) should be a bug.
>
>> As you went through all call sites (by renaming the function), we'd
>> be able to tell that there is no caller with NULL, or is it?
>
> Direct call sites are just middle men though, e.g.
> for_each_ref_submodule(). I'll attempt to clean this up at some point
> in future (probably at the same time I attempt to kill *_submodule ref
> api). But I think for now I'll just put a TODO or FIXME comment here.

ok, fine with me.

My line of thinking when originally responding was to put the FIXME
comment at the caller site, and there we'd differentiate between the
two cases and call the appropriate function.

> --
> Duy
