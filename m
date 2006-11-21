X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: remotes/* for "foreign" archives (was Re: tracking many cvs/svn/git remote archives)
Date: 21 Nov 2006 06:57:45 -0800
Message-ID: <86r6vwkfti.fsf@blue.stonehenge.com>
References: <86y7q6m3zm.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 14:58:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.14.18; tzolkin = 5 Etznab; haab = 11 Ceh
In-Reply-To: <86y7q6m3zm.fsf@blue.stonehenge.com>
Original-Lines: 42
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31991>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmX4L-0006Tr-7r for gcvg-git@gmane.org; Tue, 21 Nov
 2006 15:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934371AbWKUO5r (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 09:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934375AbWKUO5r
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 09:57:47 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:44212 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S934371AbWKUO5q (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 09:57:46 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id CEF158FBA4 for <git@vger.kernel.org>; Tue, 21 Nov
 2006 06:57:45 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 31505-01-91 for <git@vger.kernel.org>; Tue, 21 Nov 2006 06:57:45 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 3059C8FB72;
 Tue, 21 Nov 2006 06:57:45 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:

Randal>             *-GIT*)
Randal>                 ## first, update "origin":
Randal>                 case $i in
Randal>                     *-GIT)
Randal>                         git-fetch
Randal>                         ;;
Randal>                     *-GITCVS)
Randal>                         git-cvsimport -k -i $(git-repo-config getcvs.gitcvsargs)
Randal>                         ;;
Randal>                     *-GITSVN)
Randal>                         ## be sure to have origin "ref: refs/remotes/git-svn"
Randal>                         git-svn multi-fetch
Randal>                         ;;
Randal>                 esac

It occurred to me after posting this, and while still thinking about the
presentation I'm writing, that it'd be interesting if "get-fetch" could hide
this from me.

If the file in remotes/origin looked something like:

        Pull: !git-svn multi-fetch trunk
        Push: !git-svn commit

then git-fetch and git-push could treat "origin" as a "foreign" branch
and indirect through these commands.

Then I could just use "git-pull" naively, and it would git-fetch origin,
invoking git-svn multi-fetch trunk to update it, and later I could
git-push and it would use git-svn commit.

This idea is half baked, but it could definitely hide the various foreign
adaptors from the invocation line, allowing layered tools to use them
transparently.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
