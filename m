Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC991F6C1
	for <e@80x24.org>; Sat, 20 Aug 2016 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbcHTIyr (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 04:54:47 -0400
Received: from nskntqsrv02p.mx.bigpond.com ([61.9.168.234]:44383 "EHLO
        nskntqsrv02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751350AbcHTIyq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Aug 2016 04:54:46 -0400
Received: from nskntcmgw05p ([61.9.169.165]) by nskntmtas06p.mx.bigpond.com
          with ESMTP
          id <20160820072417.QUJT2096.nskntmtas06p.mx.bigpond.com@nskntcmgw05p>
          for <git@vger.kernel.org>; Sat, 20 Aug 2016 07:24:17 +0000
Received: from x220a02 ([58.168.229.151])
        by nskntcmgw05p with BigPond Outbound
        id ZKQH1t00Q3GeBn601KQH6T; Sat, 20 Aug 2016 07:24:17 +0000
X-Authority-Analysis: v=2.1 cv=H9gmuLsi c=1 sm=1 tr=0
 a=gm2JgIm3B1ma6n2s4AHsSw==:117 a=gm2JgIm3B1ma6n2s4AHsSw==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=7z1cN_iqozsA:10 a=uPZiAMpXAAAA:8 a=wL1hjHsNqf4YO_XoXZ0A:9 a=CjuIK1q_8ugA:10
 a=svzibyHiZmA4t4YY0eFS:22
Received: by x220a02 (Postfix, from userid 1000)
        id 9030A260040; Sat, 20 Aug 2016 17:22:14 +1000 (AEST)
Date:   Sat, 20 Aug 2016 17:22:14 +1000
From:   Zenaan Harkness <zen@freedbms.net>
To:     git <git@vger.kernel.org>
Subject: git rm --cached should be git rm --cache or git rm --stage
Message-ID: <20160820072214.GB24992@x220-a02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  Please CC me :)


From man git-rm:

--cached
  Use this option to unstage and remove paths only from the index.
  Working tree files, whether modified or not, will be left alone.


This wording is unclear and dangerous, and ought be cleaned up somehow.

Probably also the option name should change.

See here for examples of community self-help compensating for git-rm man
page's particularly bad wording:
http://stackoverflow.com/questions/6919121/why-are-there-2-ways-to-unstage-a-file-in-git

I suggest:
 - change "--cached" to "--cache" at the least (allow both)

 - probably deprecate --cached and add "--stage" to replace it

 - perhaps change the wording in the man page above to something similar
   as on the stackoverflow page above,
   e.g.:
   "Removes a file from the index. In the case where the file is already
   in the repo, git rm --cached will remove the file from the index,
   leaving it in the working directory and a commit will now remove it
   from the repo as well. Basically, after the commit, you would have
   unversioned the file and kept a local copy."

   or perhaps something like:
   "does not unstage a file, it actually stages the removal of the
   file(s) from the repo (assuming it was already committed before) but
   leaves the file in your working tree (leaving you with an untracked
   file)"


The git "stage" is a primary concept, and a primary noun (one reason
many of us have come to appreciate git), and git's cmd line options and
help docs ought reflect this.

Thanks,
Zenaan
