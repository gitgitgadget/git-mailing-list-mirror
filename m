X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: latest update to git-svn blows up for me
Date: Mon, 4 Dec 2006 10:12:41 -0800
Message-ID: <20061204181241.GA27342@soma>
References: <863b7wnwcw.fsf@blue.stonehenge.com> <20061204070021.GG1369@localdomain> <86hcwbnb0o.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 19:41:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <86hcwbnb0o.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: ClamAV 0.88.6/2277/Mon Dec  4 17:10:23 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33229>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJgs-0000Wl-7d for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937324AbWLDTlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937327AbWLDTlQ
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:41:16 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:33401 "EHLO
 zeus1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S937324AbWLDTlO (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 14:41:14 -0500
Received: from hand.yhbt.net (normalperson@hand.yhbt.net [66.150.188.102]
 (may be forged)) by zeus1.kernel.org (8.13.8/8.13.1) with ESMTP id
 kB4IhTkl026347 for <git@vger.kernel.org>; Mon, 4 Dec 2006 18:44:41 GMT
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 600C82DC034; Mon,  4 Dec 2006 10:12:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Mon,  4 Dec 2006
 10:12:41 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >>>>> "Eric" == Eric Wong <normalperson@yhbt.net> writes:
> 
> Eric> "Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> >> 
> >> Does this ring a bell?
> 
> Eric> Nope.
> 
> Eric> This is on r15941 of  https://svn.perl.org/parrot/trunk ?  I can't seem
> Eric> to reproduce this with git svn fetch -r15940:15941
> 
> No, and that worked for me as well.  Apparently, I might have corrupted my
> metadata because I updated git-svn while I was using it.  Is there any way to
> reset the metadata without having to re-fetch 15000 revisions?

rm .git/refs/remotes/$GIT_SVN_ID .git/svn/$GIT_SVN_ID/.rev_db
git svn -i $GIT_SVN_ID rebuild

I don't think that updating git-svn while using it is a problem, because
Perl won't (to my knowledge) reread it after it's loaded, and git-svn
does not re-exec itself (it'll fork, however).  Weird... the change
(15941) was a property-only change; however.

-- 
