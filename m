Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7289A1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 16:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbdCBQBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 11:01:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:52225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753281AbdCBQAY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 11:00:24 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPE7E-1cf2lK2Jii-004RSP; Thu, 02
 Mar 2017 16:25:26 +0100
Date:   Thu, 2 Mar 2017 16:25:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stephen Hicks <stephenhicks@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Rebase sequencer changes prevent exec commands from modifying
 the todo file?
In-Reply-To: <CAKNkOnM366uiJKkz31hS8V3NTa8qksP2pXrH4+F-zodZaNdsqg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1703021617510.3767@virtualbox>
References: <CAKNkOnM366uiJKkz31hS8V3NTa8qksP2pXrH4+F-zodZaNdsqg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:V8+xzFX9IH7+nbg0/e8s32Vy2eFmRQ93KyMpPFY6Qx5LipzTXs+
 kAL7Wm3XtNHPOTpD8Re5cpbKCeNsOHlaEH964H8BihlS3vM5iCm31oUYLMOJU04WnfDXXGH
 v+AYZLNthLtlayLeDOv3T9wylYAnISI2Fc7lBrT33OikmrT3dpqh6SOglhJYE+9qvxt+WrG
 oOEAbn/N/iTKLL0L5bVMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g7hR04Fr3ps=:qd9eTiyoYMKvRRwZDm4lI9
 ubwA4C85LEa2Sxtg0B3XH5kbBRFHXwM0uBVyYdhxDC5WPxF/yIgBwYUTkrAPaTQmVg2iW9US9
 kIIsU68ICtabdi6Ez8N283oCBP53jEPenAQHId9hKwdSDaalxl8kqgnD7M2lnP+MJhrfnenK0
 TkhE3kiLo+JPx2PzJKCVJq3f417lFqAHiPJNnVqQx1bOTDbDJOEg7R0nPk7rFKwk9qzo45fid
 FcpyKLQXKgwGBxQB6NEP2/okZIacqxO8qQQkdKH2xWVTnsVaVrsEeYwBMW+5OCPXCBAQJjeIE
 ZgrNKW21NVREfv7vVDdR4YkpYtEgzd8+AEL7+G4MN0yZ0R2/8f5xFEg1rzNDi2josiJ/+yC+K
 2BhgSSxGsvX9UNtsfICulbz8js/ZHJcK5F+28FY15semABKq8wyYS72rr7bXKwsU3ucMZd+gN
 BzMO+TdBr4jb0Nc2pnVshsdmo+jFqToN5pVXUOF2AVBVP5zofuEU4pgJ2nphR4T0VRFbuC39k
 2qzYHmSOusPEoYb4NQN83h9NjB26SYnaNkmA4kaH2Zwd5GIdcCBzRL2n3KJgi0OCke2cEe7in
 AHXuP9mfOUYRxYf9jQSvAOA1TzbN1BD6ScqlAg27NKd75oD2aeibAXs30wROubjbVXFBUYm7r
 QakS8H6vS2ROfFO8TeW/Cjffvj/JnOhBCUwsMO8g6/9c9gXvnTaBx5ugJcLyY2Da1EM/pugRH
 9JMfvLAa9UY2T4X1T2Soo5KmohATQNPj4KD6NKHdkkiyG8OjMPz44MwfmzH+bgQ7Cr9Z6A0ea
 SjOyT2BmyKa6GmEIWTYtafGB1/tmA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephen,

On Wed, 1 Mar 2017, Stephen Hicks wrote:

> I have a preferred rebase workflow wherein I generate my own TODO file
> with 'exec' lines that further modify the TODO file.  I recently noticed
> that these changes weren't sticking: they seemed to persist until the
> end of the exec'd command, and then as soon as the next command ran
> (i.e.  GIT_EDITOR=cat git rebase --edit-todo) they were gone.
> 
> I don't understand the changes that have been going through, but I suspect
> this is a result of the sequencer refactoring.  Is there a way to prevent
> git rebase from overwriting these changes?
> 
> To reproduce:
> $ git rebase -i HEAD -x "echo x false >> \"$(git rev-parse
> --git-dir)/rebase-merge/git-rebase-todo\""
> 
> This should cause the rebase to fail (and indeed, it does on 2.11.0.390)
> since it inserts an "x false".  But somewhere between there and
> 2.12.0.rc1.440, this behavior is changed.

Do you also modify the author-script file to execute arbitrary shell
commands? ;-)

Seriously again, it should not be too much of a deal to handle your use
case by re-reading the git-rebase-todo file if it has changed after an
`exec` has modified it. We already force a re-read of the index.

I won't be able to take care of that immediately, though, as I have a
pressing other patch series I need to get done.

If you want to take a crack at it in the meantime, I think this is where I
would start:

https://github.com/git-for-windows/git/blob/ce4c6ca554/sequencer.c#L2020-L2027

I would probably try to make the code smart by looking at the
timestamp/size/inode fields of the stat data of git-rebase-todo, and only
force a re-read in case those fields are different, the `res` variable is
0, and then the code would need to `continue;` in order to skip the
increment of `todo_list->current`.

And before that, I'd turn your example into a test case in
t/t3405-rebase-malformed.sh...

Ciao,
Johannes
