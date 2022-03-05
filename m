Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D34BC433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 22:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiCEWSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 17:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiCEWSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 17:18:50 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3BFE0D7
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 14:17:59 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4K9zch6MQmz5tl9;
        Sat,  5 Mar 2022 23:17:56 +0100 (CET)
Message-ID: <bee0dba1-e01c-4a2b-6a46-79361bfb3459@kdbg.org>
Date:   Sat, 5 Mar 2022 23:17:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] userdiff: add builtin diff driver for Kotlin language.
Content-Language: en-US
To:     jaydeepjd.8914@gmail.com
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220305094004.250570-1-jaydeepjd.8914@gmail.com>
 <4118762b-e2f1-4f77-68f3-e61cbe65aff7@kdbg.org>
 <6481bd49-eac9-9ebe-3d19-866107378f81@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
In-Reply-To: <6481bd49-eac9-9ebe-3d19-866107378f81@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.03.22 um 20:18 schrieb jaydeepjd.8914@gmail.com:
> Maybe we could just use cpp's regex for floating numbers starting with
> decimal point:
> 
> "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"

Yes, but with '_' permitted after the first digit:

	"|\\.[0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlL]?"

> 
> Or maybe, we can make the current regex for floats and integers a bit
> more loose:
> 
> "|[0-9.][0-9_.]*([Ee][*-]?[0-9]+)?[FfLl]*"
> What do you think would be better?

No, that does not work, either, because it splits X.Find into X .F ind.
I fixed that very problem with the cpp driver recently. We do need a
separate alternative for the floatingpoint numbers that start with a
decimal point.

-- Hannes
