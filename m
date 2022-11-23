Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD7CC4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 09:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237921AbiKWJfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 04:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiKWJfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 04:35:11 -0500
X-Greylist: delayed 353 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 01:33:04 PST
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405331FB2
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 01:33:03 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4NHG3t2y1Tz1s94l;
        Wed, 23 Nov 2022 10:27:06 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4NHG3t21xBz1qqlS;
        Wed, 23 Nov 2022 10:27:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id 9LuhdxmtPgAu; Wed, 23 Nov 2022 10:27:05 +0100 (CET)
X-Auth-Info: 2iO6diUn5LaS+KtLVAEpHB752IqClPWGt42/5IW5xYJpv1ZYXG5fDSZZn2424TQN
Received: from hawking (unknown [81.95.8.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 23 Nov 2022 10:27:05 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Andreas Hasenack <andreas@canonical.com>, git@vger.kernel.org
Subject: Re: chainlink.pl /proc/cpuinfo regexp fails on s390x
References: <CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com>
        <87v8n6o9du.fsf@igel.home>
        <CAPig+cRchF_6t-B-cZHLHAH_E6qNmapTezSfCj9AZ8cfWNzivw@mail.gmail.com>
X-Yow:  I'm an East Side TYPE..
Date:   Wed, 23 Nov 2022 10:27:05 +0100
In-Reply-To: <CAPig+cRchF_6t-B-cZHLHAH_E6qNmapTezSfCj9AZ8cfWNzivw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 22 Nov 2022 18:50:26 -0500")
Message-ID: <mvm1qpu9g2e.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 22 2022, Eric Sunshine wrote:

> On Tue, Nov 22, 2022 at 6:37 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>> On Nov 22 2022, Andreas Hasenack wrote:
>> > /^processor[\s\d]*:/
>> > or something else.
>>
>> Something else.
>>
>> $ getconf _NPROCESSORS_ONLN
>
> Yes, that works too and was (I'm pretty sure) considered during
> development. The reason /proc/cpu was chosen over `getconf` was that
> opening & reading /proc/cpu should be faster since it doesn't involve
> spawning a process. If we did use `getconf`, we'd have to be careful
> to degrade gracefully if `getconf` isn't available or if the
> configuration parameter (i.e. "_NPROCESSORS_ONLN") isn't known on the
> platform.

getconf is surely more portable than poking in /proc, especially
/proc/cpuinfo is the antipode of portability.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
