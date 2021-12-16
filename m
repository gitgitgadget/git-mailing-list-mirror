Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52D3C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbhLPVdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:33:32 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:56468 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236820AbhLPVdb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:33:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1639690411; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mkxjUyF6NJ3/+/J4hoRogJOvpXDnaFb9ZSTH0REcBLs=;
 b=sQ0WaULMvlgJWQVUyLgbI4N79ZZwYre7kGlmyZZUoteDAn4se6CnSgTibPfsLTKYW4n6xXU7
 MbGrmC5vDQUKCvt/iNfibacjH9T2Y8dUCXMKm7YJ1S5gmwm96mJQDStUzYaDvU84UulnS6z1
 obAq4vZnSbeE2fxbNOmq+PvRHLE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61bbb0a9c7b58d2909ebf4a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Dec 2021 21:33:29
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41D24C43616; Thu, 16 Dec 2021 21:33:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5FF1C4338F;
        Thu, 16 Dec 2021 21:33:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 16 Dec 2021 14:33:28 -0700
From:   Martin Fick <mfick@codeaurora.org>
To:     =?UTF-8?Q?Jo=C3=A3o_Victor_Bonfim?= 
        <JoaoVictorBonfim@protonmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fw: Curiosity
In-Reply-To: <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
 <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
 <xmqq8rwl91yf.fsf@gitster.g> <YbqiQ1B9ezF/RPOn@camp.crustytoothpaste.net>
 <xndBIO9EtrXaA932eF-0YkvHCAOL1GOKQQlIigssmcwhtZWqGxhc6I_A-lXt7vMK-j1oDrQMHUIuExlpqFS4v88nWci32qx3W5Xi1_hPpUM=@protonmail.com>
Message-ID: <54fe7ba20109f974b61a7e6c24ba8264@codeaurora.org>
X-Sender: mfick@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-12-16 14:20, João Victor Bonfim wrote:
>> To expand on this, if what you're storing is already compressed, like
>> Ogg Vorbis files or PNGs, like are found in that repository, then
>> generally they will not delta well. This is also true of things like
>> Microsoft Office or OpenOffice documents, because they're essentially
>> Zip files.
>> 
>> The delta algorithm looks for similarities between files to compress
>> them. If a file is already compressed using something like Deflate,
>> used in PNGs and Zip files, then even very similar files will 
>> generally
>> look very different, so deltification will generally be ineffective.
...
> Maybe I am thinking too outside the box, but wouldn't it be quite more
> effective for git to identify compressed files, specially on edge cases
> where the compression doesn't have a good chemistry with delta 
> compression,
> decompress them for repo storage while also storing the compression
> algorithm as some metadata tag (like a text string or an ID code 
> decided
> beforehand), and, when creating the work mirrors, return the 
> compression
> to its default state before checkout?

I suspect that for most algorithms and their implementations, this would
not result in repeatable "recompressed" results. Thus the checked-out
files might be different every time you checked them out. :(

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code
Aurora Forum, hosted by The Linux Foundation
