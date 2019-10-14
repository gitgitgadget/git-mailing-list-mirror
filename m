Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6801F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfJNR6D (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 13:58:03 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:44881 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbfJNR6D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 13:58:03 -0400
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 55CB9200002;
        Mon, 14 Oct 2019 17:58:00 +0000 (UTC)
Date:   Mon, 14 Oct 2019 23:27:48 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Gui: Branch->create currently fails...
Message-ID: <20191014175747.llstv7oxba2c23qy@yadavpratyush.com>
References: <bfe78474-0eb9-fc5e-1371-3b055308169a@iee.email>
 <20191008000003.qlulu5ie36eij4uq@yadavpratyush.com>
 <e0b45696-7945-4b7d-62e7-bff46eb8129a@iee.email>
 <20191013185007.hogizh23jomaswzx@yadavpratyush.com>
 <fccde9f3-7c5c-f8fb-1af2-bd56f48f7877@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fccde9f3-7c5c-f8fb-1af2-bd56f48f7877@iee.email>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/10/19 01:45PM, Philip Oakley wrote:
> Hi Pratyush,
> On 13/10/2019 19:50, Pratyush Yadav wrote:
> > Just to be sure it is a git-gui/Tcl issue and not an upstream 
> > git.git
> > issue, can you run:
> > 
> >    fmt='list %(refname) [list %(objecttype) %(objectname) [concat %(taggername) %(authorname)] [reformat_date [concat %(taggerdate) %(authordate)]] %(subject)] [list %(*objecttype) %(*objectname) %(*authorname) [reformat_date %(*authordate)] %(*subject)]'
> >    git for-each-ref --tcl --format="$fmt" --sort=-taggerdate refs/heads refs/remotes refs/tags
> > 
> > and see if the output contains that truncated line? If it does, then
> > that means the bug is in git-for-each-ref. Note that this is bash
> > syntax, and I did a test run on Linux. Do adjust it for Windows and your
> > shell if needed.
> 
> ran that bit of code (as distinct commands), and got (last two lines):
> 
> [list "" "" "" [reformat_date ""] ""]
> list "refs/heads/branch-patterns-v2" [list "commit"
> "d5a799d8833b0ae195915eefd5365f3fc4c7c0a4" [concat "" "Philip Oakley"]
> [reformat_date [concat "" "Sat Jun 8 22:50:06 2019 +0100"]]
> "t3203-branch-output: test -a & -r pattern options"] [list "" "" ""
> [reformat_date ""] ""]
> list "refs/heads/branch-patterns" [list "commit"
> "b2453cea29b58f2ec57f9627b2456b41568ba5da" [concat "" "Philip Oakley"]
> [reformat_date [concat "" "Tue May 28 20:22:09 2019 +0100"]] "squash! doc
> branch: provide examples for listing remote tracking branches"] [list "" ""
> "" [reformat_date ""] ""]
> list "refs/heads/MSVC-README" [list "commit"
> "056fb95c8e983ec07e9f5f8baa0b119bf3d13fed" [concat "" "Philip Oakley"]
> [reformat_date [concat "" "Sun May 19 22:33:37 2019 +0100"]]
> "compat/vcSegmentation fault
> 
> 
> Not exactly the same, but almost. Ends the same place, with as similar short
> line.
> This is run inside the bash that is started directly by the git-for-windows
> sdk start icon. (Target: C:\git-sdk-64\git-bash.exe   Stat in:
> C:/git-sdk-64/)
> 
> so looks to be MSYS2/bash related.

Ah, so it is an upstream issue. I guess we can just report it and wait 
for them to fix it.

-- 
Regards,
Pratyush Yadav
