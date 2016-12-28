Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1952D1FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 06:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750819AbcL1GsW (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 01:48:22 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33240 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbcL1GsV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 01:48:21 -0500
Received: by mail-yw0-f196.google.com with SMTP id s68so24002071ywg.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 22:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Wil0RAnTwwkD2QgkEtBsDiIS4mKVoLVE5jtaL/K1mw=;
        b=XiH4BoMrOW3DEVFs+Qoz36VCUnIAKRyry5rBpRDQBiB6tobsOCtW7nTBTWRqAOyxyW
         JEls4RhkbKX8sMLr5fku2ofW+6vPESBi7kYoLbWZyx0NMrFtv7QILWHdMBnSH+fzoZwl
         nAo2Xaa5ljh9BABijPUyDfbx4Ne3BzIwiLl+DvkH7z+zLfG+l+L3fgP/0jHHTytaeR3v
         rAZTwPjxjxCm2GoscY7MbkB56M1P2WcuSmC2sbLaMGs7mwmgCLyZJpG4BRgGZpLPwT18
         fQdzBBTVvEt5JSuLnMsKjDPws+4PecirEpRZXPh8a/nRoaKJJvDO+PpHCfm3kV1U9+gL
         d2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Wil0RAnTwwkD2QgkEtBsDiIS4mKVoLVE5jtaL/K1mw=;
        b=LLR3sCc3X2oX2euBvUORy8pHa3gMxPGRQD/5/Av/NIeo42mipF6ycIAENbg7TpBJN3
         AXBoS6yXhysn5p4henf7cBAbtLoaCUs84KTxDMOOZ+7go4dt37cDC6ELXmlo0fZO98nj
         Eb21qfy1yFaorybim4L3rDibJk0ULgD4KVLcrxxu+nofbLwwNEV7t5WvFqunO4O7P57v
         qH8uvMJGX/inBHHB8rjG9BYuniruHIiHR3TcGYjDQJ/U5NOGCLFJDAc2ZbCsxj1bFEv1
         6fSlph5M0DUGG044/IgwskyhyuvS0RxQecR+3yymJjjvXYEOUhrId5BgtSNIK20tij6s
         v7Mg==
X-Gm-Message-State: AIkVDXIsgUVMHqiyYnyicVoqUOuyoNAxvhw3Bhj1xsfea5VVrN3zL/VlKE/5YyHWK9j6BUKv9rSe5+gKSc69Tw==
X-Received: by 10.129.85.11 with SMTP id j11mr27211551ywb.123.1482907700234;
 Tue, 27 Dec 2016 22:48:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Tue, 27 Dec 2016 22:47:49 -0800 (PST)
In-Reply-To: <xmqqbmvx842i.fsf@gitster.mtv.corp.google.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com> <20161227162357.28212-2-Karthik.188@gmail.com>
 <xmqqbmvx842i.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 28 Dec 2016 12:17:49 +0530
Message-ID: <CAOLa=ZRbpMhFx_QGPeT9oBpKLq7FZ-fDXt=ueY0TDn6y_-4dfg@mail.gmail.com>
Subject: Re: [PATCH v9 01/20] ref-filter: implement %(if), %(then), and
 %(else) atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>
>> +Some atoms like %(align) and %(if) always require a matching %(end).
>> +We call them "opening atoms" and sometimes denote them as %($open).
>> +
>> +When a scripting language specific quoting is in effect, everything
>> +between a top-level opening atom and its matching %(end) is evaluated
>> +according to the semantics of the opening atom and its result is
>> +quoted.
>
> What is unsaid in the last paragraph is that you assume "is
> evaluated according to the semantics of the opening atom" does not
> involve quoting and only the result from the top-level is quoted.  I
> am not sure if that is clear to the first-time readers.
>

How about being a little more explicit about that?

When a scripting language specific quoting is in effect, everything
between a top-level opening atom and its matching %(end) is evaluated
according to the semantics of the opening atom and only its result
from the top-level is quoted.

>>
>>  EXAMPLES
>>  --------
>> @@ -273,6 +291,22 @@ eval=`git for-each-ref --shell --format="$fmt" \
>>  eval "$eval"
>>  ------------
>> ...
>> +------------
>> +git for-each-ref --format="%(refname)%(if)%(authorname)%(then) %(color:red)Authored by: %(authorname)%(end)"
>> +------------
>
> This makes readers wonder how "red"ness is reset, but that is not
> something this example is interested in demonstrating.  Let's drop
> the %(color:red) bit to avoid distracting readers.

Sure, will do :)

-- 
Regards,
Karthik Nayak
