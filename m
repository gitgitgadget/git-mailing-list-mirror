Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4817120958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755228AbdCUB5f (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:57:35 -0400
Received: from [195.159.176.226] ([195.159.176.226]:41311 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754594AbdCUB5f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:57:35 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cq937-0001dN-UU
        for git@vger.kernel.org; Tue, 21 Mar 2017 02:57:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Anatoly Borodin <anatoly.borodin@gmail.com>
Subject: Why "You cannot combine --squash with --no-ff" in git merge?
Date:   Tue, 21 Mar 2017 01:57:13 +0000 (UTC)
Message-ID: <oaq19p$kpo$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: tin/2.4.1-20161224 ("Daill") (UNIX) (FreeBSD/11.0-RELEASE-p8 (i386))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

the message "You cannot combine --squash with --no-ff" appeared in 2008,
in the commit 1c7b76be7d620bbaf2e6b8417f04012326bbb9df ("Build in
merge"). I don't understand the logic of this restriction.

Imagine, I have the following branches, where A is a master and B is a
feature branch:

	A---B1---B2---B3---B4---B

`git checkout A && git merge --squash --no-ff B` says:

	fatal: You cannot combine --squash with --no-ff.

`git merge --squash --ff` will happily move the A ref to the B commit.

But what I want, and expect, is:

	A---B'

where B' has the same tree as B.

This can of course be done with `git rebase --interactive` and marking
all commits for squash or fixup. But `git merge --squash` works with
not-fastforwarding feature branch, why should it refuse to work in a
fastforwarding case?

-- 
Mit freundlichen Grüßen,
Anatoly Borodin

