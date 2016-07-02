Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB91B2018A
	for <e@80x24.org>; Sat,  2 Jul 2016 12:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbcGBMny (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 08:43:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35081 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbcGBMnx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 08:43:53 -0400
Received: by mail-it0-f68.google.com with SMTP id g4so8200ith.2
        for <git@vger.kernel.org>; Sat, 02 Jul 2016 05:43:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0UXY4AUHDd3WAH469P7VoEiGoEs7ns5133co//ALhK0=;
        b=eep6+xVYvmrVJAtGNpf8ZBR6tWkVFNaJSKHAIprBdtmT27h6SdNngwgUGCiAXSqO9U
         ev6HIXeG27nahkGNGnEjnNCGQMDE7mtbVBnhsiFYzhgdeLz+i98QKu42tmyIt9qoGiXA
         SF1bV/4z0cfH61/neFIzxdFM4xMMeymxoj+f9aZE4qJ1Tu2f7942bfhMP2h/xzULHDSR
         K5FJC7ouRwxAuXL77JV2ZCAvYxfxA8bufskMWC9FCeEw35D9oovmf01X7EApmolAhuLg
         meYUAutqRWhdLagFcmeGFgEhPzwGY2uqmNNvU9e/k59wfr3rHb6tR+GNo8xca5fKnQzh
         shXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0UXY4AUHDd3WAH469P7VoEiGoEs7ns5133co//ALhK0=;
        b=Pnng1srHbcY6866rXoAo/mEbW5vZNFXqJywcPkrPd2vb5O1pt3l0n6Cbt/vmMrYEYM
         qgeWRS28K7C/s32+E7UAE212o/ikxpkVk01/v/sJgEQwvjpk83z2zJa18I6yQ+iaEn/+
         0IfGOhMtrIpfgLMk3+Cw12OeLun2iqfAtLnKnUa0RhJ+gvugb2uV+X3gzUmsSTowXh0W
         8H1ujraS98JN3ysxP+IM1AYRMy+nSfi7uwKp2VedLAdTGn8GUciixROiRyYxDvtbDHru
         6S1iORXKZxxLRz6hg2PkGaIaH5FSsJdz6UJKtbw6t55DJnd6zY8kHtaVXU2n4yNaKfH+
         pLWA==
X-Gm-Message-State: ALyK8tJDY3P/QSCQzOzy3cXwAqVc6wooyu8sKK7u4vDJG6FizRWT7mjrwJrxO37hmw68gFJKI6hB0KfHM2PhUg==
X-Received: by 10.36.123.199 with SMTP id q190mr2590614itc.42.1467463432868;
 Sat, 02 Jul 2016 05:43:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 2 Jul 2016 05:43:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607021312210.12947@virtualbox>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-4-git-send-email-novalis@novalis.org> <alpine.DEB.2.20.1606301457340.12947@virtualbox>
 <CACsJy8DuTsDAYzRVk=mW7WX5CZb0Z5bAPnzV_2KXK-BcX=tcVg@mail.gmail.com> <alpine.DEB.2.20.1607021312210.12947@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 2 Jul 2016 14:43:23 +0200
Message-ID: <CACsJy8Bke0EQ9rOEBmz6BcvcfPe-X_rktaOku9F-wUOrnVMJDw@mail.gmail.com>
Subject: Re: [PATCH v13 04/20] index-helper: new daemon for caching index and
 related stuff
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	David Turner <novalis@novalis.org>,
	Git Mailing List <git@vger.kernel.org>,
	Keith McGuigan <kamggg@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 2, 2016 at 1:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> > -test -n "$NO_MMAP" && {
>> > -       skip_all='skipping index-helper tests: no mmap'
>> > +git index-helper -h 2>/dev/null
>> > +test $? = 129 ||
>>
>> So when NO_MMAP is set, "git index-helper -h" will set $? to 1.
>
> Not quite.
>
> When NO_MMAP is set, index-helper will not be compiled. Or at least it
> should not be:
>
>> +ifndef NO_MMAP
>> +ifndef NO_UNIX_SOCKETS
>> +       PROGRAM_OBJS += index-helper.o
>> +endif
>> +endif
>
> If it is *unset*, *and* if NO_UNIX_SOCKETS is *also* unset, index-helper
> gets compiled, and -h triggers code in parse-options.c or usage.c that
> exits with status 129.
>
> So I do not think that this is subtle.

The question is "whether index-helper is supported?" but you need to
go through parse-options.c and that strange (to me) exit status 129 to
conclude that index-helper is in fact built. It's not just as straight
forwarding from reading the test.

> But it just occurred to me that the #ifndef NO_MMAP in index-helper.c is
> unnecessary and that its #else clause (containing a loop() that fails)
> contains dead code: we never compile this code with NO_MMAP, and neither
> should we.

Yeah that's probably old code from POSIX shm time. Back then there
were calls to shm_open and stuff, not just mmap.

> Dave, would you mind taking that #ifndef NO_MMAP out of "index-helper: new
> daemon for caching index and related stuff" when you re-roll?
-- 
Duy
