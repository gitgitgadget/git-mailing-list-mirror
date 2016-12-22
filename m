Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A30A41FCC7
	for <e@80x24.org>; Thu, 22 Dec 2016 22:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758961AbcLVWNl (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 17:13:41 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34878 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757203AbcLVWNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 17:13:40 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so41243579pfk.2
        for <git@vger.kernel.org>; Thu, 22 Dec 2016 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MX/V5VSRvk7FJ0GTiIG2omwyLZOa76XRE1P2UtWjwrw=;
        b=nfRdCK8ma0JMldXENfKujBeuq3EV9b9AgI4/jDN8FaF+XQBJ9YMYtHDWtYyAcrbPRY
         nDIl1iwTdUqQuH25RnOgurQaTGvsIrFFU6CSPzPTbBUdW94ng70nvSqg1YKpEd4rQZri
         v37OI0Evi5f4M0VqGnv5OMwwMs+CAxJV5RNqhxuiWm6ZlmsTMalQdE5sPJU8mndKOkgu
         0n9BbHHdKkb+VCVJ1xN7C4QtTVMaKwtHtlxp6+wm0DP3slZtxLFHTaLp1UO98uiqIe9+
         ln27WS2AHNP6RLgvBwdS0y3+etlPsHmBrGyeMuvTMDPkxS+DoWQtBnzK8qROebxnYRWa
         iaYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MX/V5VSRvk7FJ0GTiIG2omwyLZOa76XRE1P2UtWjwrw=;
        b=DXpgHjqzPT+ZQJgI4rm9erGs6ALNzRL8Tth1zHNAY6TVJn4JUKkAZoeP0KncYUAxsL
         Jb8/HYulXjXM0URvDW4lRx1k4lyjANORuVn4H5xB3ai9/aiIlVHIS5+KBo6JjqFivMTy
         hWK1ojzDQHZP/g5WqGLsBHBKD5JasE1sNyhck0xYncORhcg3sNhObVUb7M5e7x9kKh+6
         8WLR2vIRmcTmoaC+rZFj21UWU6fLzoDYcbaP+/kSEAWBBEup0fw1nqof6NzsJ/xjxubu
         i18aOH/mBIogNMRid/Pa7kNqlydAHeweZ/G1XpyKrlF6c1SDdAN+LtHM4j+D2SFVfFPU
         U5xw==
X-Gm-Message-State: AIkVDXKnOBjz+LbPjvlcM3lxFjW8NV5n/WK/aUkp8XAN++AGYqdMCtdguiyt03SAoGSscp1q
X-Received: by 10.99.102.69 with SMTP id a66mr20639886pgc.49.1482444818807;
        Thu, 22 Dec 2016 14:13:38 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:257c:d256:967a:f8])
        by smtp.gmail.com with ESMTPSA id a22sm57010626pfg.7.2016.12.22.14.13.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Dec 2016 14:13:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Cc:     Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] add diffstat information to rebase
Date:   Thu, 22 Dec 2016 14:13:27 -0800
Message-Id: <20161222221327.7354-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.50.g8bda6b2.dirty
In-Reply-To: <alpine.DEB.2.20.1612222239390.155951@virtualbox>
References: <alpine.DEB.2.20.1612222239390.155951@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2016 at 1:41 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Stefan,
>
> On Thu, 22 Dec 2016, Stefan Beller wrote:
>
>> This is a small hack that adds the diffstat to the interactive rebase
>> helping me a bit during the rebase, such that:
>>
>>     $ git rebase -i HEAD^^
>>
>>     pick 2eaa3f532c Third batch for 2.12
>>     # Documentation/RelNotes/2.12.0.txt | 40 +++++++++++++++++++++++++++++++++++++++
>>     # 1 file changed, 40 insertions(+)
>>     pick 3170a3a57b add information to rebase
>>     # git-rebase--interactive.sh | 2 ++
>>     # 1 file changed, 2 insertions(+)
>
> If it helps you, fine. But please make it opt-in. I would hate to see it
> in all my rebases, I find that information more confusing than helpful.

That's what I realized now that I played around with it for a day, because it actually
creates more lines than I can fit into my terminal in one screen now.

*Ideally* I would rather have a different formatting, e.g. maybe:

    $ git checkout remotes/origin/js/sequencer-wo-die
    $ git rebase -i --new-magic v2.10.0-rc2^

which produces:

    pick d5cb9cbd64 Git 2.10-rc2                                    | Documentation/RelNo.., GIT-VERSION-GEN -..(+5, -1)
    ...
    pick dbfad033d4 sequencer: do not die() in do_pick_commit()     | sequencer.c - do_pick_commit              (+7, -6)
    pick 4ef3d8f033 sequencer: lib'ify write_message()              | sequencer.c - write_message, do_pick_com..(+11, -9)
    ...
    ...
    pick 88d5a271b0 sequencer: lib'ify save_opts()                  | sequencer.c - save_opts + sequencer_pick..(+20, -20)
    pick 0e408fc347 sequencer: lib'ify fast_forward_to()            | sequencer.c - fast_forward_to             (+1, -1)
    pick 55f5704da6 sequencer: lib'ify checkout_fast_forward()      | sequencer.c - checkout_fast_forward       (+6, -3)
    pick 49fb937e9a sequencer: ensure to release the lock when w... | sequencer.c - read_and_refresh_cache      (+6, -3)



When writing this example, I do notice that some sorts of commits put
nearly this exact information into the commit message. But that happens
when the commit is already well crafted and often it is refactoring.

A good example for the use case of this new format would be
origin/js/regexec-buf as there the commit message doesn't give
away what files and functions are touched.

Another very good example for the usefulness of the new format
appears to be origin/js/am-3-merge-recursive-direct, because:

* there are quite a few commits in the series.
  (This feature seems to only be useful for long reshuffling series'
  for interactive rebase in my mind.)
* It is not obvious by the commit title, which parts of the code
  are touched. (files, functions)
* With a longer series, you can produce different valid orders for the
  patches to be applied, e.g. compiling and testing works even if the patches
  were applied in different orders.

Well actually the best use case are unfinished series,
with lots of "fixup" commits. :)

>
>>  git-rebase--interactive.sh | 2 ++
>>  1 file changed, 2 insertions(+)
>
> Oh well. I guess I have to modify sequencer-i yet another time.

I think this feature can wait until the sequencer is in
and then we can build it on top, time permitting.

Thanks,
Stefan

