Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92EAC07E9A
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930186108D
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 07:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGEHW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:22:57 -0400
Received: from mx2.uni-regensburg.de ([194.94.157.147]:40320 "EHLO
        mx2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhGEHW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 03:22:56 -0400
Received: from mx2.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E1F296000051
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:20:16 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx2.uni-regensburg.de (Postfix) with ESMTP id C45E9600004D
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 09:20:16 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 05 Jul 2021 09:20:16 +0200
Message-Id: <60E2B2AF020000A100042296@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.3.1 
Date:   Mon, 05 Jul 2021 09:20:15 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: [EXT] Re: bug in "git fsck"?
References: <60DF1C22020000A100042225@gwsmtp.uni-regensburg.de><60DF1C22020000A100042225@gwsmtp.uni-regensburg.de>
 (Ulrich Windl's message of "Fri, 02 Jul 2021 16:01:06 +0200")
 <xmqqczs0popg.fsf@gitster.g>
In-Reply-To: <xmqqczs0popg.fsf@gitster.g>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Ulrich Windl schrieb am 05.07.2021 um 09:10 in Nachricht <60E2B04B.461 :
161 :
60728>:
>>>> Junio C Hamano <gitster@pobox.com> schrieb am 02.07.2021 um 20:15 in
Nachricht
> <xmqqczs0popg.fsf@gitster.g>:
> > "Ulrich Windl" <Ulrich.Windl@rz.uni‑regensburg.de> writes:
> > 
> >> I was wondering whether git fsck should be able to cleanup
> >> orphaned branches ("HEAD points to an unborn branch") as described
> >> in https://stackoverflow.com/q/68226081/6607497 It seems I can fix
> >> it be editing files in the repository, but I feed that's not the
> >> way it should be.
> > 
> > HEAD pointing at an unborn branch is not even a corruption, isn't
> > it?
> > 
> >    $ rm ‑rf trash && git init trash
> > 
> > would point HEAD at an unborn one, ready to be used.
> 
> 
> OK, so maybe I was just confused by "fsck". At it seems after committing, 
> fsck no longer complains.

Sorry, I didn't think (still pre-coffeine time):
The problem is gone in the workspace so far, not in the repository, and I
think the problem never was present in the workspace.
Also "git branch" dispalys three branches in addition to "master", while the
"branches" directory of the repository is empty.
So when I try to delete a branch displayed by "git branch", I get:
fatal: Couldn't look up commit object for HEAD

It seems  the delete command reads those refs from HEAD:
ref: refs/heads/name_of_branch_to_be_deleted

but in refs/heads/ that name does not exist

Last command before error message is:
lstat("./objects/00/00000000000000000000000000000000000000", 0x7fff76d9a180) =
-1 ENOENT (No such file or directory)
write(2, "fatal: Couldn't look up commit o"..., 47fatal: Couldn't look up
commit object for HEAD
) = 47


> As "EXTRACTED DIAGNOSTICS" In man git-fsck (Git 2.26.2) does not mention 
> "unborn" (and as it's not a common IT phrase), one could probably explain 
> what it means.
> 
> Regards,
> Ulrich
> 
> 
> 
> 



