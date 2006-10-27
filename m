X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] cogito: Honor either post-commit script name; fail if both are executable
Date: Fri, 27 Oct 2006 09:41:49 +0200
Message-ID: <87mz7ip5mq.fsf@rho.meyering.net>
References: <874ptzhsjs.fsf@rho.meyering.net>
	<20061027020549.GY20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 07:42:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061027020549.GY20017@pasky.or.cz> (Petr Baudis's message of
	"Fri, 27 Oct 2006 04:05:49 +0200")
Original-Lines: 34
X-Virus-Scanned: ClamAV 0.88.5/2114/Fri Oct 27 05:07:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30299>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMMS-0002FU-Gh for gcvg-git@gmane.org; Fri, 27 Oct
 2006 09:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946224AbWJ0Hmh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 03:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946227AbWJ0Hmh
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 03:42:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16283 "EHLO
 zeus1.kernel.org") by vger.kernel.org with ESMTP id S1946224AbWJ0Hmg (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 03:42:36 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64]) by
 zeus1.kernel.org (8.13.7/8.13.1) with ESMTP id k9R7gKE3016876 for
 <git@vger.kernel.org>; Fri, 27 Oct 2006 07:42:35 GMT
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000) id
 6271C17F9; Fri, 27 Oct 2006 09:41:49 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Oct 20, 2006 at 06:15:51PM CEST, I got a letter
> where Jim Meyering <jim@meyering.net> said that...
>> I promised this patch some time ago, made the changes,
>> and then never sent them.  This is slightly different
>> from the current implementation in that it fails when both
>> scripts are executable.  Also, it factors out the script names and
>> adds tests.
>>
>> Signed-off-by: Jim Meyering <jim@meyering.net>
>
>   I'm not sure I like this (of course, I always like additional tests,
> though). The problem is that this loses a smooth upgrade path, things
> suddenly break and you can't commit without having to think about fixing
> your environment.

How would such a tiny change affect the upgrade path?
Failing when both scripts are executable feels more like doing the
(confused) user a favor than complicating their upgrade experience :-)

In case it wasn't clear, the only change induced by that patch is to
make cg-commit fail if *both* commit-post and post-commit scripts
exist and are executable.  I'll bet that is unusual enough not to matter.

> deprecation warnings. So if we want to get rid of commit-post, we should
> rather start printing deprecation warnings if commit-post exists, and in
> few months cut commit-post off.

If you want to retire "commit-post", that's mostly independent.
IMHO, the things to do:
  -- announce and document the name change (leaving mention of the old
       name at least temporarily in the documentation)
  -- later, start warning if the old name is used
