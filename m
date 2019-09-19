Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4104B1F463
	for <e@80x24.org>; Thu, 19 Sep 2019 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392032AbfISSdD (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 14:33:03 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59147 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbfISSdD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 14:33:03 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A8C93E0003;
        Thu, 19 Sep 2019 18:33:00 +0000 (UTC)
Date:   Fri, 20 Sep 2019 00:02:58 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git-gui: missing some patches from git?
Message-ID: <20190919183258.g7ae4u5nzuzwgu7b@yadavpratyush.com>
References: <CAGr--=KXqFbivuXHPNecb3dBR_hx8QqWoR4pBGXy7uOiT+ESbg@mail.gmail.com>
 <20190918092721.GA76617@archbookpro.localdomain>
 <20190918151404.rqjohdderwxfqtdm@yadavpratyush.com>
 <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqblvh5wbr.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 18/09/19 10:49AM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> You should be able to merge this (and all other git-gui topics
> already in my tree Denton pointed out) to your 'master'.  If you
> then make a trial merge of the result back into my tree with "git
> merge -Xsubtree=git-gui", it should result in "already up to date",
> i.e. a noop merge.

I pulled all the changes into git-gui. I had to manually backport two 
commits:

  * 7560f547e6 (treewide: correct several "up-to-date" to "up to date", * 2017-08-23)
  * 00ddc9d13c (Fix build with core.autocrlf=true, 2017-05-09)

because they touched other parts of git, that were not in git-gui.

I then did a trial merge into your 'master', and running a diff, 
git.git's version of git-gui is identical to mine. So everything seems 
to be correct.

Instead of doing this on my master, I did it on a separate branch just 
to be sure I don't mess something up. You can find it on 
https://github.com/prati0100/git-gui.git on the branch 'trial_merge'.

These are the new commits introduced:

  7435f916d3 git-gui: fix build with core.autocrlf=true
  834e3ec31e git-gui: correct "up-to-date" to "up to date"
  fecfccf9ff Merge branches 'js/msgfmt-on-windows', 'tz/fsf-address-update', 'jn/reproducible-build', 'ls/no-double-utf8-author-name', 'js/misc-git-gui-stuff', 'bb/ssh-key-files', 'bp/bind-kp-enter', 'cb/ttk-style' and 'py/call-do-quit-before-exit' of ../git into trial_merge
  f7a8834ba4 Merge branch 'bp/amend-toggle-bind'
  ec7424e1a6 git-gui: add hotkey to toggle "Amend Last Commit"
  6c8ec8c30a Merge branch 'bw/commit-scrollbuffer'
  acfa495519 Merge branch 'bw/amend-checkbutton'
  da08d559b7 git-gui: add horizontal scrollbar to commit buffer
  ba41b5b335 git-gui: convert new/amend commit radiobutton to checkbutton
  c77abf0460 Merge branch 'py/revert-hunks-lines'
  5a2bb62180 Merge branch 'bp/widget-focus-hotkeys'
  e07446ed5f git-gui: add hotkeys to set widget focus
  a4fa2f0a4c git-gui: allow undoing last revert
  2ccdfb1c78 git-gui: return early when patch fails to apply
  62bd99934b git-gui: allow reverting selected hunk
  5f0a516de9 git-gui: allow reverting selected lines

The top 3 commits are of note. The top 2 are the manual backports. The 
third is the octopus merge of all the topics not in git-gui yet. The 
rest are just other topics that were introduced in my fork recently.

If it looks all good, I'll put all this on my 'master' and re-send the 
pull request.

-- 
Regards,
Pratyush Yadav
