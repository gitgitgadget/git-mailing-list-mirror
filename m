Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC9C1F404
	for <e@80x24.org>; Fri, 17 Aug 2018 06:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeHQJ47 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 05:56:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37887 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeHQJ47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 05:56:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so3178681pgq.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 23:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xrxPbsT48jRpi/mr7LFvzHgRlvkUee4EIDBEAf0RzZE=;
        b=TC96Obmkj/t57+ZtpqEPSd5unjbBoRrSj2r3Wen6KgocnOiOpGMVk05Ya92YNuEtO7
         V3ehVD11mstvWqou63uuE4HuFpZlmqtNZzkb92C4wLVspKOQ/03xtRTC/C/WuViPhpC0
         9CTZSjJwZCS/FTVJq6r3C0sRaNKr+koirKsmz5CVC49EZlCtxu9oqLRmoAyS5sOl4RQk
         uFS3Y+hxSBiZ7Qq3zbnqBfvcT2VaCfL8//EJ5CkRccfPO1qj/9qCf43k4lFo1rEHhlQI
         W8Fs764DuMe+tOlkj65ATDXom6A2TaIuOiD2jWEO1//taqHAXHC3BFAFCwoRYpqeU49w
         v8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xrxPbsT48jRpi/mr7LFvzHgRlvkUee4EIDBEAf0RzZE=;
        b=SuXr7FmPneVCWntnBNqirKJja9KvQj1pl2yYbWQgD1MAU8XZgmTDypXwjaflynP1Fn
         MY1xnUPGTKdHv2IYWBjL+egsFJ7oddt9a2vAZabNoiOd3+aHW3Io/pxCD3R0lcPDorjb
         /+13vtcj5xe7Z7NWoOUZxAThS2uAaS2oYdIS2mfSQtU2ilAqYrTs2CwV43BA5CtszNUP
         hVdof/h83btpr4/uNLZwf/SyxTpOMIlTEJ7HZIbgLHSTcLJUQWLsJrG5aO6oe0IIbRGf
         eVd0OYKAngFxUyuzSfqvT56r/fsBT/mqaXqZaHbnBnqCB8yOkDgP7QAsD2qc/Oxr808Z
         L4mw==
X-Gm-Message-State: AOUpUlHGQh1CPy8cC2YTxkZwKyQvdJUku4dBe+xOKIZ5D2+tH93kPI2L
        ClpG84ZuDwIG2bjNcSxMlm2RKj9g
X-Google-Smtp-Source: AA+uWPwkKEtCjwNwtuiT+MtTdkjhh+ANEB7PUhojhfEWovCJxG4UO0C+zo2qhQQRI6xmirM6zSYZkg==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr31675632pgd.326.1534488886697;
        Thu, 16 Aug 2018 23:54:46 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l79-v6sm2229682pfb.111.2018.08.16.23.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 23:54:46 -0700 (PDT)
Date:   Thu, 16 Aug 2018 23:54:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] gpg-interface.c: detect and reject multiple signatures
 on commits
Message-ID: <20180817065444.GC131749@aiede.svl.corp.google.com>
References: <xmqqbmaa9t8k.fsf@gitster-ct.c.googlers.com>
 <20180814151142.13960-1-mgorny@gentoo.org>
 <20180815213108.GM181377@aiede.svl.corp.google.com>
 <1534488137.1262.2.camel@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534488137.1262.2.camel@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny wrote:
> On Wed, 2018-08-15 at 14:31 -0700, Jonathan Nieder wrote:

>> It's not clear to me that the name is_status or SIGNATURE_STATUS
>> captures what this field represents.  Aren't these all sigcheck
>> statuses?  Can you describe briefly what distinguishes the cases where
>> this should be 0 versus 1?
[...]
>                                  Maybe it should be EXCLUSIVE_STATUS
> or something like that, to distinguish from things that can occur
> simultaneously to them.

Thanks.  Makes sense.

[...]
>> Can we have a test to make sure this behavior doesn't regress?  See
>> t/README for an overview of the test framework and "git grep -e gpg t/"
>> for some examples.
>
> Will try.  Do I presume correctly that I should include the commit
> object with the double signature instead of hacking git to construct it?
> ;-)

Good question.  You can hack away with a new program in t/helper/, or
you can make your test do object manipulation with "git cat-file
commit <object>" and "git hash-object -t commit -w --stdin".  If you
run into trouble, just let the list know and I'm happy to try to help.
(Or if you would like real-time help, I'm usually in #git-devel on
freenode.)

Jonathan
