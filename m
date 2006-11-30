X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Getting CVS and Git to play nicely in the same box
Date: Thu, 30 Nov 2006 12:39:13 +0000
Organization: Insert Joke Here
Message-ID: <1164890354.21950.92.camel@okra.transitives.com>
Reply-To: kernel-hacker@bennee.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 12:42:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.6.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32732>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplEW-0007TW-5P for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936256AbWK3Mjd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936295AbWK3Mjb
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:39:31 -0500
Received: from mx.transitive.com ([217.207.128.220]:16089 "EHLO
 pennyblack.transitives.com") by vger.kernel.org with ESMTP id S936284AbWK3MjQ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:39:16 -0500
Received: from [192.168.1.82] (helo=okra.transitives.com) by
 pennyblack.transitives.com with esmtp (Exim 4.50) id 1Gpl2y-0002AD-FV for
 git@vger.kernel.org; Thu, 30 Nov 2006 12:29:48 +0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi,

I'm trying to get a setup where I can use git for my day to day coding
on problems but still mirror a CVS repo. The situation is muddied
slightly by the way we manage changes in our CVS repository and
baselines.

The CVS manner of working means we create a branch at a given point to
do work on it:

          BL1_CH2
         /
        /
       BL1_CH1
BL1---/

And then in the meantime a new baseline may be released:


BL2    BL1_CH2
|     /
|     BL1_CH1
BL1--/

So we employ the "cvs -q update -dP -j BL1 -j BL2" on our development branch
          
          BL2_CH2
         /
BL2     BL1_CH2
|      /
|    BL1_CH1
BL1--/

I want to mirror this sort of behaviour it git (basically making the 
cvs -j -j operation a git merge, separate from the normal development track). 
I however also need to maintain the CVS meta-data so when I get to given points
I can commit my work into the main development server.

I can set up a git repo that ignore all the CVS gubbins with exclude info but the
CVS metadata gets in the way. I think I have to maintain two git repos, one that tracks the
baseline and one which is a clone (which can then pull updates) but has the CVS meta data
for my development branch. However CVS does seem to get very confused when the world moves
under it when you switch branches in GIT.

Has anyone successfully set up such a working environment? Can anyone offer any tips on how to
make it all work nicely?

-- 
Alex, homepage: http://www.bennee.com/~alex/
To iterate is human, to recurse, divine.
