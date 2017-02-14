Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFA31FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbdBNSpc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:45:32 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:65104 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752761AbdBNSpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:45:31 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3vNBF45hY4z5tlm;
        Tue, 14 Feb 2017 19:45:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2F8AE2AAA;
        Tue, 14 Feb 2017 19:45:28 +0100 (CET)
Subject: Re: [PATCH] mingw: make stderr unbuffered again
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
 <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1702141545380.3496@virtualbox>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
Date:   Tue, 14 Feb 2017 19:45:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702141545380.3496@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.02.2017 um 15:47 schrieb Johannes Schindelin:
> On Mon, 13 Feb 2017, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>> When removing the hack for isatty(), we actually removed more than just
>>> an isatty() hack: we removed the hack where internal data structures of
>>> the MSVC runtime are modified in order to redirect stdout/stderr.
>>>
>>> Instead of using that hack (that does not work with newer versions of
>>> the runtime, anyway), we replaced it by reopening the respective file
>>> descriptors.
>>>
>>> What we forgot was to mark stderr as unbuffered again.

I do not see how the earlier patch turned stderr from unbuffered to 
buffered, as it did not add or remove any setvbuf() call. Can you explain?

>> OK.  Should this go directly to 'master', as the isatty thing is
>> already in?
>
>>From my point of view, it is not crucial. The next Git for Windows version
> will have it, of course, and Hannes is always running with his set of
> patches, he can easily cherry-pick this one, too.

The patch fixes the problem for me here.

I am a bit hesitant to call it "not crucial": The symptom I observed is 
certainly not a show stopper; but who knows where else it is important 
that stderr goes to the terminal earlier than other output. As it is a 
new regression, it should be included in the next release.

Thanks,
-- Hannes

