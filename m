Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36EBA20248
	for <e@80x24.org>; Thu, 28 Mar 2019 13:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfC1NcT (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 09:32:19 -0400
Received: from smtpout21.ngs.ru ([195.19.71.4]:49067 "EHLO smtpout.ngs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1NcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 09:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ngs.ru; s=mail1;
        t=1553779928; bh=bmmy+DX/tGwTwSxALFW8KfsUc4Bo5YrudEwLPqaqlxo=;
        l=1103;
        h=From:Subject:To:Cc:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding;
        b=juuh12bsV9kOAUz/qWv84EfxtajdOVyBAGtsNHuV5I/4fvIIpNaV6u+56x6aTHyiU
         5mB48SVD2UFp1GDwzdCosQTkyneOjFyDQnv8h/x74OhVJnsfBDp3bY4p0hVaBN6bP6
         55AgHCaAXIhoIHTJp4cOvd53p+OYV9q1+lPdqRPg=
Received: from [192.162.88.2] (account __vic@ngs.ru)
        by mx30.intranet.ru with HTTP id 54137705; Thu, 28 Mar 2019 20:32:07 +0700      
From:   "Victor" <__vic@ngs.ru>
Subject: Re: Strange behaviour of git log --follow
To:     avarab@gmail.com
Cc:     git@vger.kernel.org
Date:   Thu, 28 Mar 2019 16:32:07 +0300
Message-ID: <web-54137705@mx30.intranet.ru>
In-Reply-To: <87zhpf9m10.fsf@evledraar.gmail.com>
References: <web-54136765@mx30.intranet.ru>
 <87zhpf9m10.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 137610 [Mar 28 2019]
X-KLMS-AntiSpam-Version: 5.8.6.0
X-KLMS-AntiSpam-Envelope-From: __vic@ngs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Info: LuaCore: 258 258 ec4a3b526df04ef6f8b1265b4a4d4c00a63af4f6, {Tracking_smtp_from_same_from}, {Tracking_text_let_digits}, mx14.intranet.ru:7.1.1;github.com:7.1.1;ngs.ru:7.1.1;192.162.88.2:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx30.intranet.ru:7.1.1, Auth:dkim=none
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: not scanned, disabled by settings
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.705, not scanned, license restriction
X-Spamd-Result: default: False [0.00 / 13.00]
 R_SPF_ALLOW(0.00)
X-Spamd-Server: localhost
X-Spamd-Scan-Time: 0.20
X-Spamd-Queue-ID: 2DB55202AE6
X-Virus-Scanned: clamav-milter 0.98.6 at mc-filter2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Any plans to fix this?

On Thu, 28 Mar 2019 14:16:43 +0100
  Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Thu, Mar 28 2019, Victor wrote:
> 
>> Hello.
>>
>> $ git log include/__vic/mutex.h
>> commit 9429293f8f8fb0819c77cf1f723567f6edc8fb6a
>> Merge: 96dd9a2 f484f4e
>> Author: __vic <__vic@ngs.ru>
>> Date: 2017-12-13 10:41:32 +0300
>>
>>     Merge branch 'generic' into posix
>>
>> commit f484f4e8aae32041ba56bdce12d1efd8491e94d5
>> Merge: 86b848a b9bbbe6
>> Author: __vic <__vic@ngs.ru>
>> Date: 2017-12-12 17:35:10 +0300
>>
>>     waitable_event, thread, mutex
>> $ git log --follow include/__vic/mutex.h
>> $
>>
>> Why --follow makes git produce truncated history for 
>>file that wasn't
>> renamed?
>>
>> My repository is available here
>> https://github.com/2underscores-vic/__vic
> 
> I just briefly looked at this. It's because all changes 
>to the relevant
> file are in merge commits. If you run the "log" with 
>"--stat" you'll see
> no output.
> 
> Something in the --follow machinery takes the same 
>shortcut on merges
> and doesn't consider them.

