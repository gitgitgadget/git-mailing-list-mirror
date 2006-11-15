X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bhavesh Davda" <bhavesh@vmware.com>
Subject: RE: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Tue, 14 Nov 2006 20:09:49 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701A11D6A@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 04:10:07 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Thread-Index: AccIPfwv6kyWKY5BTqiRwvpzVwS6vgALOTPg
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31410>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkC5x-0006Ni-GS for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966569AbWKOEJu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966568AbWKOEJu
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:09:50 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4769 "EHLO
 mailout1.vmware.com") by vger.kernel.org with ESMTP id S966567AbWKOEJt
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006
 23:09:49 -0500
Received: from mailhost2.vmware.com (mailhost.vmware.com [10.16.64.160]) by
 mailout1.vmware.com (Postfix) with ESMTP id C26EA6033; Tue, 14 Nov 2006
 20:10:06 -0800 (PST)
Received: from PA-EXCH03.vmware.com (pa-exch-node04.vmware.com
 [10.16.64.143]) by mailhost2.vmware.com (Postfix) with ESMTP id E103D905A3;
 Tue, 14 Nov 2006 20:15:34 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> > diff --git a/Makefile b/Makefile
> > index 36ce8cd..24a0dc7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -202,7 +202,7 @@ PROGRAMS = \
> >  	git-upload-pack$X git-verify-pack$X \
> >  	git-pack-redundant$X git-var$X \
> >  	git-describe$X git-merge-tree$X git-imap-send$X \
> > -	git-merge-recursive$X \
> > +	git-merge-recursive$X git-runstatus$X \
> >  	$(EXTRA_PROGRAMS)
> >  
> >  # Empty...
> 
> This cannot be right.  There is builtin-runstatus.o defined as
> part of BUILTIN_OBJS so you already should have git-runstatus as
> a hardlink to other binaries such as git-add, git-apply
> etc. in the same directory as you have them.
> 
> I seem to have 55 hardlinks to that file under my ~/bin/.
> 

So I just blew away /usr/bin/git*, and removed my Makefile patch, and did
another:

make prefix=/usr all (as myself)

and then

sudo make prefix=/usr install

I now *don't* have /usr/bin/git-runstatus.

And none of the files under /usr/bin/git* are hard links. There are in all 79
files beginning with /usr/bin/git*:

git git-am git-applymbox git-applypatch git-archimport git-bisect
git-checkout git-cherry-pick git-clean git-clone git-commit
git-convert-objects git-cvsexportcommit git-cvsimport git-cvsserver
git-daemon git-describe git-fetch git-fetch-pack git-fsck-objects
git-hash-object git-http-fetch git-http-push git-imap-send git-index-pack
git-instaweb git-local-fetch git-lost-found git-ls-remote git-merge
git-merge-base git-merge-index git-merge-octopus git-merge-one-file
git-merge-ours git-merge-recur git-merge-recursive git-merge-recursive-old
git-merge-resolve git-merge-stupid git-merge-tree git-mktag git-mktree
git-pack-redundant git-parse-remote git-patch-id git-peek-remote git-pull
git-quiltimport git-rebase git-receive-pack git-relink git-repack
git-request-pull git-rerere git-reset git-resolve git-revert git-send-email
git-send-pack git-sh-setup git-shell git-shortlog git-show-index
git-ssh-fetch git-ssh-pull git-ssh-push git-ssh-upload git-status git-svn
git-svnimport git-tag git-unpack-file git-update-server-info git-upload-pack
git-var git-verify-pack git-verify-tag gitk

I haven't tried make -p yet, but can do that to see why git-runstatus isn't
installed under /usr/bin

Thanks

