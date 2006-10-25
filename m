X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Hanging fetches
Date: Wed, 25 Oct 2006 18:25:56 +0200
Message-ID: <20061025162556.GL20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 16:28:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30073>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GclZq-00085g-Et for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932242AbWJYQZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 12:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWJYQZ6
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:25:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20887 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S932242AbWJYQZ6 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 12:25:58 -0400
Received: (qmail 16764 invoked by uid 2001); 25 Oct 2006 18:25:56 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

  Hi,

  due to the problem with kernel.org, I have a somewhat ugly situation
on repo.or.cz now:

root     16370  0.0  0.0  2112  732 ?        S    16:47   0:00  \_ /USR/SBIN/CRON
repo     16371  0.0  0.0  2776 1236 ?        Ss   16:47   0:00      \_ /bin/bash /home/repo/repomgr/updatecheck.sh
repo     16377  0.0  0.0  2776  648 ?        S    16:47   0:00          \_ /bin/bash /home/repo/repomgr/updatecheck.sh
repo     17685  0.0  0.0  2780 1252 ?        S    16:47   0:00              \_ /bin/bash /home/repo/repomgr/update.sh linux-2.6
repo     17689  0.0  0.0  2872 1372 ?        S    16:47   0:00                  \_ /bin/sh /home/pasky/bin/git-fetch -f -u -k --mirror-all
pub/scm/linux/kernel/git/torvalds/linux-2.6.git
repo     17702  0.0  0.0  2872  720 ?        S    16:47   0:00                      \_ /bin/sh /home/pasky/bin/git-fetch -f -u -k --mirror-org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
repo     17703  0.0  0.0  2872  644 ?        S    16:47   0:00                          \_ /bin/sh /home/pasky/bin/git-fetch -f -u -k --mirnel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
repo     17704  0.0  0.0  2836 1328 ?        S    16:47   0:00                          |   \_ /bin/sh /home/pasky/bin/git-ls-remote git://m/linux/kernel/git/torvalds/linux-2.6.git
repo     17716  0.0  0.0  2836  616 ?        S    16:47   0:00                          |       \_ /bin/sh /home/pasky/bin/git-ls-remote gib/scm/linux/kernel/git/torvalds/linux-2.6.git
repo     17717  0.0  0.0  2956  940 ?        S    16:47   0:00                          |       |   \_ git-peek-remote git //git.kernel.org/git/torvalds/linux-2.6.git
repo     17718  0.0  0.0 27488  552 ?        S    16:47   0:00                          |       \_ sort -t ? -k 2
repo     17719  0.0  0.0  2836  592 ?        S    16:47   0:00                          |       \_ /bin/sh /home/pasky/bin/git-ls-remote gib/scm/linux/kernel/git/torvalds/linux-2.6.git
repo     17705  0.0  0.0  2872  628 ?        S    16:47   0:00                          \_ /bin/sh /home/pasky/bin/git-fetch -f -u -k --mirnel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

  It's 18:24 now and peek-remote is hanging in a read(). My question is,
will this *ever* time out, and when? :) Perhaps the timeouts should be
adjusted to a more reasonable value, or implemented if they are missing
altogether, but I'm not sure what would be the best way to go about it -
alarm()? What value would be reasonable?

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
