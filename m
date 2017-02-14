Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253741FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 21:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754138AbdBNVNk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 Feb 2017 16:13:40 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:29632 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbdBNVNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 16:13:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 1EF331E3063;
        Tue, 14 Feb 2017 22:13:36 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ML8x9685hmAG; Tue, 14 Feb 2017 22:13:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id B797C1E3082;
        Tue, 14 Feb 2017 22:13:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id edz08bfW-BRo; Tue, 14 Feb 2017 22:13:35 +0100 (CET)
Received: from [192.168.178.28] (aftr-185-17-204-143.dynamic.mnet-online.de [185.17.204.143])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 629FC1E3063;
        Tue, 14 Feb 2017 22:13:35 +0100 (CET)
Subject: Re: [PATCH] completion: complete modified files for checkout with
 '--'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20170213233359.11149-1-cornelius.weig@tngtech.com>
 <CAM0VKj=d+hAiF6_8TLuJfccNiPtHyg9F6zESA8SuTEeaLsrw4Q@mail.gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, j6t@kdbg.org,
        Richard Wagner <bitte.keine.werbung.einwerfen@googlemail.com>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
Date:   Tue, 14 Feb 2017 22:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAM0VKj=d+hAiF6_8TLuJfccNiPtHyg9F6zESA8SuTEeaLsrw4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2017 01:50 AM, SZEDER Gábor wrote:
> On Tue, Feb 14, 2017 at 12:33 AM,  <cornelius.weig@tngtech.com> wrote:
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>
>> The command line completion for git-checkout bails out when seeing '--'
>> as an isolated argument. For git-checkout this signifies the start of a
>> list of files which are to be checked out. Checkout of files makes only
>> sense for modified files,
> 
> No, there is e.g. 'git checkout that-branch this-path', too.

Very true. Thanks for prodding me to this palpable oversight.

My error was to aim for a small improvement. I think the correct
approach is to improve the overall completion of git-checkout. IMHO it
is a completion bug that after giving a ref, completion will still offer
refs, e.g.
$ git checkout HEAD <TAB><TAB> --> list of refs

As far as I can see, giving two refs to checkout is always an error. The
correct behavior in the example above would be to offer paths instead.

I'll follow up with an improved version which considers these cases.

