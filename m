Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3164D208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 10:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdH3KMD (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 06:12:03 -0400
Received: from [195.159.176.226] ([195.159.176.226]:53341 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdH3KMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 06:12:02 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1dmzyD-0008Mt-0Q
        for git@vger.kernel.org; Wed, 30 Aug 2017 12:11:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Commit dropped when swapping commits with rebase -i -p
Date:   Wed, 30 Aug 2017 12:11:14 +0200
Message-ID: <oo62vr$pvq$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I believe stumbled upon a nasty bug in Git: It looks like a commits gets dropped during interactive rebase when asking to preserve merges. Steps:

$ git clone -b git-bug --single-branch https://github.com/heremaps/scancode-toolkit.git
$ git rebase -i -p HEAD~2
# In the editor, swap the order of the two (non-merge) commits.
$ git diff origin/git-bug

The last command will show a non-empty diff which looks as if the "Do not shadow the os package with a variable name" commit has been dropped, and indeed "git log" confirms this. The commit should not get dropped, and it does not if just using "git rebase -i -p HEAD~2" (without "-p").

I'm observing this with Git 2.14.1 on Linux.

Regards,
Sebastian



