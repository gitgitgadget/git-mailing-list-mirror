Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCAB1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 09:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbcF3Juz (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 05:50:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36856 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbcF3Jux (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 05:50:53 -0400
Received: by mail-wm0-f67.google.com with SMTP id c82so21352253wme.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 02:50:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dD+SgCjTnq+mROr/xNbCqe8DMU3K1t+ovKJHUAy+9Z0=;
        b=AvFWh3qim0VZeuC0WdIyvZ4+bgrNO+7EeWFNQFvAZGJUYw9HQX7cxG/3xed2T4XBkR
         sHQYhbZB1u43q/GhqtLtsn1Q1eQRp0otBKJ450ptepvuxT2h0EtsqKoSRCR2ixxx/6HZ
         VGDsjidmbSN+O8KO6/zaOKr2OwGWD09w8cbAD0908tYsPPunWGnwN/JlsGHAaof+zLJY
         6v8fD1O9xqLAeANfda42vavvEnsxEwtXlGIysUjQ7w+FPuJ0MUrDri7njQ0tVLJ/yuG/
         H2lYmkLm2aQAepfCTgmD6Lr3aUYfPMBdmUrldjL7U7uBwX9G+K03hfnf7OdPNubb1G/y
         HTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dD+SgCjTnq+mROr/xNbCqe8DMU3K1t+ovKJHUAy+9Z0=;
        b=HUFXWsTAoTMdb8MSxcZPIJB6ZNQ/WTZclSsKWJHUlp4wjASwJQjGlZgjdwAJj55vYK
         jbIDlP0CxfOIsVveyf9EcVmc9s4/Hj7cfyPbz70cYm36UwD2nUSR0xoSqlIHVI3SrO/p
         9vEaax0/ZSmIKkZ0KSBSARyBm3wL31J5giC1AS00Q9m9RgZFkzbdh2SrZ65aLvEl4Nlt
         RIQvAuzOguGUJajNIkgAamcTF88fvhtvJbUB0/8O0/WoLzEAjg0ln9R2k612BfwDoVCi
         IeWywdcDH7K5sEgf303JlsXAmGNYp5awU6aox19lFaweLlccKCdbD7ANiCCWkWqhkQbs
         hBhQ==
X-Gm-Message-State: ALyK8tKxCuRXIJUOOwrnxCFFQbgLwzx31hmcsDQJ8riiF/e2oorQsHTYvzNS1MkjO5hPqlOqCeFXwOICeNsldw==
X-Received: by 10.194.239.163 with SMTP id vt3mr12480722wjc.78.1467280244781;
 Thu, 30 Jun 2016 02:50:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.25.197 with HTTP; Thu, 30 Jun 2016 02:50:44 -0700 (PDT)
In-Reply-To: <xmqqoa6l6lia.fsf@gitster.mtv.corp.google.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <20160627182429.31550-34-chriscool@tuxfamily.org> <xmqqoa6l6lia.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 30 Jun 2016 11:50:44 +0200
Message-ID: <CAP8UFD2kXp2Ugojq9ktudOB=tpcsm3fxe2XYKtRQ9KdzqTug-g@mail.gmail.com>
Subject: Re: [PATCH v8 33/41] write_or_die: use warning() instead of
 fprintf(stderr, ...)
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 11:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> @@ -98,8 +97,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
>>  int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
>>  {
>>       if (write_in_full(fd, buf, count) < 0) {
>> -             fprintf(stderr, "%s: write error (%s)\n",
>> -                     msg, strerror(errno));
>> +             warning("%s: write error (%s)\n", msg, strerror(errno));
>>               return 0;
>>       }
>
> I do not think you call write_or_whine() at all.  As another topic
> in flight removes the last caller of this function, this hunk is
> very much unwelcome.  The only effect of it is to force me resolve
> unnecessary merge conflicts.

Ok, sorry about that. I will remove the hunk.
