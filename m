Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67853C7619A
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjC0LhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjC0LhL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 07:37:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745949E8
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679917025; i=johannes.schindelin@gmx.de;
        bh=0aZEsuuzmW0wGJCXUJXz0fk13iGZWuh4WKuIh6PDPFs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j6EKPtnVf7Do/FZYs7KWnm20LFKkjohQE7ChQI3q2NkaETwefJMrTj6araK7xOQkM
         ebSj16tAX6P5oe2U8LXwPTQX7uVEiePo/sCFFp8QQay3pz00dZw3I9ICUufDg7ioVw
         zkFdC/IFs0XCxJBRjdCJVfY79bAcGk8tsLuBlYYPrIir9MnCqlTf5S/P6VsmTj+dr9
         dDRd+0wjHeqxfVHVh7Tu5+pxm9dXwkg1RWBZZv66DAREUPxq5U33iODH/1lThI5bG4
         rKgzbdei5oe4Zt//WpYTnM6iq9s32Iluj41+4OW7y1JhGesKRw1MQLgWZHHVLnPRS6
         ZcPYelymvDJdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1pzvuB0lV8-00JKrx; Mon, 27
 Mar 2023 13:37:05 +0200
Date:   Mon, 27 Mar 2023 13:37:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] fsmonitor: handle differences between Windows named pipe
 functions
In-Reply-To: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
Message-ID: <e48e768a-19f3-386a-9bda-8fa8681d1a6c@gmx.de>
References: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N5DrJEgSjcBy+gXCRl1fzYI8BtmH6ayF/a/xk9kv2WBBxoBLN5O
 JqL4S2w/47ayxdZmm4vKwhKEukaB1E1I3gLerjhH/J5TG5Cdga/U4Z8L5jIvmZ/6Rtp79iE
 bOl+dSUE+OG9ySJCQUBq+tY8q1zxEUAGOhJQlJwFb6OsuOEszdJA5oKjReA/n6dOC3CacdR
 7Ydq1kSq6uyTukGnenfbQ==
UI-OutboundReport: notjunk:1;M01:P0:pUQaQm5d2CE=;6O3l3qm8OZjQVp/687eouRZ35bs
 FrB9BETNv9l5ctGl3B9BUV3HcMoIa59BP19My2xVqUNDw+9k/CCmG7WHT3nxWaeFhEQeZmyQD
 Jn7ZjQ9u/vl8xADL7GTAo4rKn07HloAIm9wmrZw+wl/tPrlw0j9lvjpyPG4tODeEt4mDcnvb6
 piJk9E0tfalhqi+G5//vIqudOCsNTWIzWNIXSaT5ldX7KXmo+ojrtxn9oY/ErNlnBdmqRMnoT
 e54YycILb0I7qfw/hVHKPs7yCoLmPHxbuC+d4+pw7wjFTTmFW0CNz6dZSreVHiV92DqEKq9SR
 ReXFY2D2bnGbHkmpC8MOKgo/o1CaIPOf/dmXsoO2yPjptGY1z9If2lLa21DXbnYrsqRUNHi9m
 fsh8fo4LiDa8vZQQoRPaePq4pf/paN7ZL4blSOHndazGfJgPRXot23auY5DwBCoz488R2fdfU
 9T93HM++S2FqldhAF84vrWIDUP6/apW0EKx6Bg3htOmwjJmP7iUZjGB1oq9gXmggIq9ZasRY0
 YRZsYFshXyj/4V/CsM56IpgBIYBt9HEzYWbK2LTPyqcaK5gvH8ESplzfg2Tw1z5+U/+6EEeSx
 ZXvkUhKcri7uFHwUSwLxRGOvvL59/J3roPajwwqJMF+g/hMTcohHzWgsAPCXBWqeGA/focioL
 QSDVlGp6wefQaQi7tW1/RPcAkZgumjQ0IENSN4RlUqqZ4gKvwIIc6YXcxfRXqquweG6GfGBwT
 uaHEBYtqPgR1dsrObU0MzyIZdQsJDrIWIGYrY7saVximMYDPdOJ7Ob155g8NxwbFpM+moqWOJ
 T81mmdkoZ+TQ3PfdkJUJ1Rur4aADYoQ1KbWOGEK2Hu45IIb56JSkemVuHuMHFgAdAY/cmwlyB
 I2fVYT2c5DdUKAR0xrlAnhuumaZ2gaWNNm3N8YDjQQtlsmgyPuul2F9MtYJwbS5rwDJMoWIDZ
 fDULre2hcDezSjlVGhKCqFvy6pY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 24 Mar 2023, Eric DeCosta via GitGitGadget wrote:

> From: Eric DeCosta <edecosta@mathworks.com>
>
> CreateNamedPipeW is perfectly happy accepting pipe names with seemingly
> embedded escape charcters (e.g. \b), WaitNamedPipeW is not and incorrect=
ly
> returns ERROR_FILE_NOT_FOUND when clearly a named pipe, succesfully crea=
ted
> with CreateNamedPipeW, exists.
>
> For example, this network path is problemmatic:
> \\batfs-sb29-cifs\vmgr\sbs29\my_git_repo
>
> In order to work around this issue, rather than using the path to the
> worktree directly as the name of the pipe, instead use the hash of the
> worktree path.

This is a rather large deviation from the other platforms, and it has an
unwanted side effect: Git for Windows' installer currently enumerates the
named pipes to figure out which FSMonitor instances need to be stopped
before upgrading. It has to do that because it would otherwise be unable
to overwrite the Git executable. And it needs to know the paths [*1*] so
that it can stop the FSMonitors gracefully (as opposed to terminating them
and risk interrupting them while they serve a reply to a Git client).

A much less intrusive change (that would not break Git for Windows'
installer) would be to replace backslashes by forward slashes in the path.

Please do that instead.

Ciao,
Johannes

Footnote *1*: If you think that the Git for Windows installer could simply
enumerate the process IDs of the FSMonitor instances and then look for
their working directories: That is not a viable option. Not only does the
Windows-based FSMonitor specifically switch to the parent directory (to
avoid blocking the removal of a Git directory merely by running the
process in said directory), even worse: there is no officially-sanctioned
way to query a running process' current working directory (the only way I
know of involves injecting a remote thread! Which will of course risk
being labeled as malware by current anti-malware solutions).
