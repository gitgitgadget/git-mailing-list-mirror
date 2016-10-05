Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA90207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 10:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbcJEKTm (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 06:19:42 -0400
Received: from mx3-phx2.redhat.com ([209.132.183.24]:52445 "EHLO
        mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752436AbcJEKTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 06:19:41 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
        by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id u95AJdf5029737;
        Wed, 5 Oct 2016 06:19:39 -0400
Date:   Wed, 5 Oct 2016 06:19:39 -0400 (EDT)
From:   Josef Ridky <jridky@redhat.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Anatoly Borodin <anatoly.borodin@gmail.com>, git@vger.kernel.org
Message-ID: <389765533.1406436.1475662779510.JavaMail.zimbra@redhat.com>
In-Reply-To: <20161005094706.GA18574@gmail.com>
References: <88486231.114620.1475474318974.JavaMail.zimbra@redhat.com> <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com> <CACNzp2mANqmciMzvCahM_+=RnZYtU1SK9DRS2BmQru1fZY_wUQ@mail.gmail.com> <597741871.671633.1475558327029.JavaMail.zimbra@redhat.com> <20161005094706.GA18574@gmail.com>
Subject: Re: Feature Request: user defined suffix for temp files created by
 git-mergetool
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.34.4.141]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF48 (Linux)/8.0.6_GA_5922)
Thread-Topic: Feature Request: user defined suffix for temp files created by git-mergetool
Thread-Index: pwDwuyLG+iP/QFRbi0H8KFPZAe+O7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

thank you very much for your reply.
Today I realized, that my attachment has been cut off, so I sent it in the morning [1].

I believe, that most of answer can be find in my previous email from this morning.
Only change, that should be done by this request is add possibility to edit hard-coded suffix of temporary files. 
I don't think, that change hard-coded suffix to switch between two hard-coded suffix of temporary files is suitable solution, but as well it's not bad solution.

Please look at the patch [1] and tell me, what do you think about this change.

[1] http://marc.info/?l=git&m=147565363609649&w=2

Regards
Josef

| Sent: Wednesday, October 5, 2016 11:47:06 AM
| 
| On Tue, Oct 04, 2016 at 01:18:47AM -0400, Josef Ridky wrote:
| > Hi Anatoly,
| > 
| > 
| > | Sent: Monday, October 3, 2016 5:18:44 PM
| > | 
| > | Hi Josef,
| > | 
| > | 
| > | On Mon, Oct 3, 2016 at 8:36 AM, Josef Ridky <jridky@redhat.com> wrote:
| > | > In several projects, we are using git mergetool for comparing files
| > | > from
| > | > different folders.
| > | > Unfortunately, when we have opened three files  for comparing using
| > | > meld
| > | > tool (e.q. Old_version -- Result -- New_version),
| > | > we can see only name of temporary files created by mergetool in the
| > | > labels
| > | > (e.g. foo_REMOTE -- foo_BASE -- foo_LOCAL)
| > | > and users (and sometime even we) are confused, which of the files
| > | > should
| > | > they edit and save.
| > | 
| > | `git mergetool` just creates temporary files (with some temporary
| > | names) and calls `meld` (or `vimdiff`, etc) with the file names as
| > | parameters. So why wouldn't you call `meld` with the file names you
| > | want?
| > 
| > 
| > Because files, that we want, are temporary files created by
| > git mergetool and we are not able to change their name.
| 
| [I didn't see your original patch, but we actually prefer inline
|  patches in the email, as sent via `git send-email`.
|  Documentation/SubmittingPatches has more details.
| 
|  Please also make sure to add a test to t/t7610-mergetool.sh
|  exercising any new features.]
| 
| Are you proposing support for config variables to control how
| the temporary files are named?
| 
| e.g. something like "mergetool.strings.{local,remote,base}" for
| overriding the hard-coded {LOCAL,REMOTE,BASE} strings?
| 
| I don't want to over-engineer it, but do you want to support
| executing a command to get the name, or is having a replacement
| sufficient?
| 
| Now I'm curious... if replacing the strings is sufficient, what
| do you plan to call them?  I can imagine maybe something like
| OURS, and THEIRS might be helpful since it matches the
| nomenclature already used by Git, e.g. "git merge -s ours".
| 
| Since these are temporary files, changing these names might not
| be entirely out of the question.  This might be a case where
| using the same words as a related Git feature might help reduce
| the mental burden of using mergetool.  OURS and THEIRS are
| probably the only names that fit that category, IMO.
| BASE is already good enough (merge-base).
| 
| The downside of making it configurable is that it can confuse
| users who use mergetool at someone else's desk where they've
| named these strings to "catty", "wombat", and "jimbo".  This
| doesn't seem like the kind of place where we want to allow users
| to be creative, but we do care about having a good default.
| 
| OURS and THEIRS are intuitive names, so switching existing users
| to those would not have much downside IMO, and it's a little
| less "I just merged a REMOTE branch" centric, which is good.
| 
| Do you think these names should be changed?
| If so, did you have those names in mind, or something else
| entirely?
| 
| cheers,
| --
| David
| 
