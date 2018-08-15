Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638141F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeHPAOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:14:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34214 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeHPAOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:14:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so1029745pfi.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iu0x8VhNGhfYYfbRgN0e5dyp/T8id3fGCJ63RMSZwbA=;
        b=Oc4BsbiGIYCoamERMTwVIKA2yQXNzFsYCBsqSZ2n8v/TXR/URkp8CswVhvz+hJBFMe
         AGAemjYGQ4BFRwGtJGJjx919uRfIc04QjWBjgSU7aZ2rJeoIGGvTJgRXsMpftWNFvCDq
         jLQd/5cMxkwcLfudbWNevcBcWS1TiJ3Jn7JEYfO7TTKsSR8ifUseUN4tn+Fo1OM49uLO
         aoLGygWu49e0iRHIdGyQ00hW/Fhdyw/GeF4rTx5Tw48Jbpzls88a+7xEtBc4wy3y+lNK
         KYGWwMXSODAMmzEDH0uHfNFGljtKOT/fXHiPJWLcbD8EVYgXCrqUAPO8Aw6y5A6iQRvr
         ebpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iu0x8VhNGhfYYfbRgN0e5dyp/T8id3fGCJ63RMSZwbA=;
        b=qhP9JPRTNUOxjLoAxjJYml7GoI0wC43DIHtoxrKuwwwxlksTSVJiXzn//xcPAcIkLa
         VU8GkVEUhEDmOUzstm0nUvvEBA59oq9wW6rVMQ0bWiRka8Jclj/uZuqC/cKWePMW6dyv
         OgbRa99JTBsbZRl6sbNWURcUlQXaO3LDm4gyPgwfRvSmzCCHJgFolSQPGfTdEzRcNjMc
         fdQPvFFLGbgRYvhkiIoSZ7se3qFrdRze7JLBZ7kc8ox2vlc/Gqyi370kqdEgaFxrPULv
         ArKNIkfGRaS1VmIAozZzVOGUEiEF0n588oQ0REWHScetu7rcPh3VR9jzqdGbKr+5pR4e
         6jnQ==
X-Gm-Message-State: AOUpUlGgzJBFYqz1rIZg37jU6VKfWU2spBCQiZ490eOQ10qOSCgGWfsB
        siL9BGAtFVf06FJswcFRWOc=
X-Google-Smtp-Source: AA+uWPyqNqMSFiWOj2A3Yp9aSev7eZ5Mcr2EGvU++k8sksOgo4yd4aTCSYxK3vcpKhO8loViU0jmrQ==
X-Received: by 2002:a63:fb57:: with SMTP id w23-v6mr26486957pgj.441.1534368011928;
        Wed, 15 Aug 2018 14:20:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g85-v6sm55025409pfk.39.2018.08.15.14.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:20:11 -0700 (PDT)
Date:   Wed, 15 Aug 2018 14:20:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     git@vger.kernel.org
Subject: Re: Potential vulnerability: 'mixed up' output when commit has
 multiple signatures
Message-ID: <20180815212009.GE181377@aiede.svl.corp.google.com>
References: <1533898313.1249.36.camel@gentoo.org>
 <20180815053522.GI32543@aiede.svl.corp.google.com>
 <1534315421.1603.0.camel@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534315421.1603.0.camel@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michał Górny wrote:
> On Tue, 2018-08-14 at 22:35 -0700, Jonathan Nieder wrote:
> > Michał Górny wrote:

>>> I've been testing the git signature verification a bit and I've
>>> discovered a troubling behavior when the commit object contains
>>> multiple signatures.
>>
>> Thanks for discovering this.  Do you mind if I take this conversation
>> to the public mailing list?  (I'd bounce the existing thread there if
>> that's okay with you.)
>
> I've already asked somewhere else in the thread if you consider this
> suitable for disclosure, and haven't received a reply yet.  In any case,
> I don't mind it.

Thanks, doing so.

Thanks again for the analysis and fix as well.
