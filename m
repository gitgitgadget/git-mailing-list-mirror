Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA581F428
	for <e@80x24.org>; Fri,  5 Jan 2018 21:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeAEVW7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 16:22:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:54645 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbeAEVW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 16:22:58 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MUI8w-1eO7XL18Lq-00R0u5; Fri, 05 Jan 2018 22:22:53 +0100
Date:   Fri, 5 Jan 2018 22:22:52 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] merge-recursive: fix logic ordering issue
In-Reply-To: <20180105202001.24218-3-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801052221210.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <20180105202001.24218-1-newren@gmail.com> <20180105202001.24218-3-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NZ+FLWj7aL3PpcIuHayvoZvAL99C2JBKLZUXQkQ2y/2ciAxJGQo
 Q5qUk1oec0bs+7rAj0om4SsH7w+osRIP4t4v1Mp0RxO5RVE3+Q+kvHV7tEFvmlnmPizWAbt
 PHlGtyjhPBLdmFJuPjkmFWu3cBCb/t1u1CpeiyCwobgXcB4Y0EJxTwMGM3FVDzX5YWDCRjI
 IQ+HgRAZa53SSCblv92Dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9r0ObCGCv08=:Pzc2W8xSD9U95DLAxOPhXS
 8pwpntgttWWEH3BzzoYIZ637GHVFrCyW/6jy3A07CFCGwSGkZx9nK1bupHjdNcVEORD8NwUMO
 6GOavaDQB1PiBjYhcTFDk8GMkfLb72xyJOXhPEuOie8dEnIKlGNEi+xp+Q7qYO/JTYYBC3ARD
 117rOWYhIbAr5SKMmkn9cokv21bMVD/e9gVUGZpkY+dPgv4TeDL3UktTUjpV07dHAd5nh4yGp
 XD1e2B13LSMp+8xxjLMdGRE7Rxu9CKgymnU0hg6EvgvQs1ehNJQb0U/QYdCUkc0VJ0Dxd3v0X
 hkDCYuCKFtPnR4LCuyzIN63K4E85RyRjJERG7i1XJbegZfJEG0HCfEBSWN1l9jVyPGwoACTC4
 72S0boP1r1KcvzD4wfgsIW5GkvrfIDOY9xq0kkIOZ9zTeo88QgV6yisVhBZAx2X4uFnJ6Hl/8
 g/4oew9o1rnJ1cG4El1HOTw2WwgjfLhzs+49XeEx/0EkwLgUaAHJARXt7Qk/MKDA7iijeYm5+
 W1x9tjZyibjPtNHHSGvf5nxeSAizEoAksJ9foDtKdUGWpu1wp6ql8PptDN4l5LKZMvMu89gdk
 Y52DN9SwgbMBfhqDImUrC0zqchtNnLRVjU+WgTZ03qyWu7c6qxN6KwYxn2pPYSusio9+wFWOr
 dlykthCF0nbbjQvXfXYOASKX1tfeLFFwQjUKLfxJR2MUioGPCiQgcZputPpDohqSRxITKnCiY
 Wrz5L13sikCyDWubqiimp/xkPkNiJlUr030TADX11zXfbF7Yjr4MQtzdJ/AmwB3MroEEFlyVF
 FK3jNI57XgUm+4BgUanPmrEFW7tea2mR7BMd5JXaPDEeWDA4w0Pz7CTSledb9hdyQiIRmr4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 5 Jan 2018, Elijah Newren wrote:

> merge_trees() did a variety of work, including:
>   * Calling get_unmerged() to get unmerged entries
>   * Calling record_df_conflict_files() with all unmerged entries to
>     do some work to ensure we could handle D/F conflicts correctly
>   * Calling get_renames() to check for renames.
> 
> An easily overlooked issue is that get_renames() can create more
> unmerged entries and add them to the list, which have the possibility of
> being involved in D/F conflicts.  So the call to
> record_df_conflict_files() should really be moved after all the rename
> detection.

I cannot actually see how the *current* rename detection would result in
D/F conflicts, as it is really only about detecting the renames, the
conflicts should have happened earlier.

But I could imagine that your "detect directory renames" patch series
changes this behavior.

In any case, the reordering does not hurt.

Ciao,
Dscho
