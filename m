Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E95C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 10:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbjAIKM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbjAIKMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 05:12:17 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C491A049
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 02:10:48 -0800 (PST)
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Nr8pZ6pSZz1s94p;
        Mon,  9 Jan 2023 11:10:46 +0100 (CET)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.84])
        by mail.m-online.net (Postfix) with ESMTP id 4Nr8pZ6MBvz1qqlR;
        Mon,  9 Jan 2023 11:10:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan3.mail.m-online.net [192.168.6.84]) (amavisd-new, port 10024)
        with ESMTP id w1L84ulkeTPz; Mon,  9 Jan 2023 11:10:46 +0100 (CET)
X-Auth-Info: CxfxP41gWryf9nExk+dWoI3em+fpzgdCBl9l4k6hnnXlL6VoqSUaDHAVoNZbzW4L
Received: from igel.home (aftr-62-216-205-85.dynamic.mnet-online.de [62.216.205.85])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  9 Jan 2023 11:10:46 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id BD5122C1385; Mon,  9 Jan 2023 11:10:45 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        git@vger.kernel.org
Subject: Re: Github actions failing
References: <CA+PPyiG=+rs_bOQbaNB311_DVdSc2g44SkLzpaqOER7rfxykrQ@mail.gmail.com>
        <CAP8UFD2huFgTjB1hNGyGnMKPONOG6ZV-wvxWkTaz-iZNfxrhJA@mail.gmail.com>
        <CA+PPyiHOLUm87eHuxyhbqqML33Q6g-he_DKRxTEb2fu-2p3NSQ@mail.gmail.com>
        <CAP8UFD23ObbQaeQi2WsZ3oy0QTKiBxs3wExaHTU2QzJBPwKOmA@mail.gmail.com>
X-Yow:  Kids, the seven basic food groups are GUM, PUFF PASTRY, PIZZA,
 PESTICIDES, ANTIBIOTICS, NUTRA-SWEET and MILK DUDS!!
Date:   Mon, 09 Jan 2023 11:10:45 +0100
In-Reply-To: <CAP8UFD23ObbQaeQi2WsZ3oy0QTKiBxs3wExaHTU2QzJBPwKOmA@mail.gmail.com>
        (Christian Couder's message of "Mon, 9 Jan 2023 10:22:01 +0100")
Message-ID: <87pmbo2f2y.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 09 2023, Christian Couder wrote:

>> > 1870 + test 2 -ne 2
>> > 1871 + eval diff -u "$@"
>> > 1872 + diff -u actual expected
>> > 1873 --- actual 2023-01-08 19:40:42.169214115 +0000
>> > 1874 +++ expected 2023-01-08 19:40:42.121213837 +0000
>> > 1875 @@ -1,4 +1,5 @@
>> > 1876 gpg: Signature made Sun Jan 8 19:40:42 2023 UTC
>> > 1877 gpg: using DSA key 13B6F51ECDDE430D
>> > 1878 +gpg: checking the trustdb
>
> The + before "gpg" means that the above line is in what we expect, but
> not in what we actually get.
>
> I think the reason might be that gpg's output could have changed
> between different versions of gpg and it might just not be possible
> and wise to rely on the exact output it emits.

I think the "checking the trustdb" message is time-dependent, as the
trustdb is normally updated only after some interval has passed.
According to the gpg manpage, automatic trustdb checking can be
suppressed with --no-auto-check-trustdb.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
