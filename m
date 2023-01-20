Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3DFC25B4E
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjATPXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjATPXj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:23:39 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698D4CE8B8
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:23:38 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BEA61CA1272;
        Fri, 20 Jan 2023 10:23:36 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 84DB9CC8321;
        Fri, 20 Jan 2023 10:23:36 -0500 (EST)
Message-ID: <d5e2cd60-49f7-91bf-0678-70e3671b1cad@jeffhostetler.com>
Date:   Fri, 20 Jan 2023 10:23:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [CI]: Is t7527 known to be flakey?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        edecosta@mathworks.com
Cc:     git@vger.kernel.org
References: <xmqqtu0lzzn2.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqtu0lzzn2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/19/23 9:52 PM, Junio C Hamano wrote:
> The said test failed its linux-musl job in its first attempt, but
> re-running the failed job passed.
> 
>      https://github.com/git/git/actions/runs/3963948890/jobs/6792356234
>      (seen@e096683 attempt #1 linux-musl)
> 
>      https://github.com/git/git/actions/runs/3963948890/jobs/6792850313
>      (seen@e096683 attempt #2 linux-musl)
> 

This is on Linux, so it would be using the linux inotify backend.
Let me add Eric to the "To:" line for visibility.  And see if he
has experienced this during his development of it.

I've not looked at the inotify code so I can't say if there are
races there or not.  Tests that move directories feel like good
candidates for race conditions -- since the daemon doesn't get a
recursive view of the tree with inotify() and must simulate that
and manage the individual directories, but again I don't want to
assume that.

Jeff

