X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Bhavesh Davda" <bhavesh@vmware.com>
Subject: RE: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Date: Wed, 15 Nov 2006 10:42:27 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701A11D6D@PA-EXCH03.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 18:44:04 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [GIT PATCH] Makefile missing git-runstatus in PROGRAMS list
Thread-Index: AccI4/8MstcF80A5Raaz4tkVDWiYCQAAMiLQ
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31464>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPje-0000c0-Hw for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030848AbWKOSn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030846AbWKOSn0
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:43:26 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:61579 "EHLO
 mailout1.vmware.com") by vger.kernel.org with ESMTP id S1030849AbWKOSnX
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006
 13:43:23 -0500
Received: from mailhost2.vmware.com (mailhost2.vmware.com [10.16.64.160]) by
 mailout1.vmware.com (Postfix) with ESMTP id 3D5BC60A4; Wed, 15 Nov 2006
 10:43:40 -0800 (PST)
Received: from PA-EXCH03.vmware.com (pa-exch-node04.vmware.com
 [10.16.64.143]) by mailhost2.vmware.com (Postfix) with ESMTP id 800719041E;
 Wed, 15 Nov 2006 10:49:13 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

> 
> > Attached is my attempt at the same command "make 
> prefix=/var/tmp/ggg clean
> > all install"
> >
> > make install failes for the templates directory, leading to 
> the entire make
> > install failing:
> >
> > make -C templates DESTDIR='' install
> > make[1]: Entering directory `/VMware/kernel/git/git/templates'
> > : no custom templates yet
> > install -d -m755 '/var/tmp/ggg/share/git-core/templates/'
> > (cd blt && tar cf - .) | \
> > (cd '/var/tmp/ggg/share/git-core/templates/' && tar xf -)
> > tar: This does not look like a tar archive
> > tar: Skipping to next header
> > tar: Archive contains obsolescent base-64 headers
> > tar: Error exit delayed from previous errors
> 
> I have a feeling that you have CDPATH exported to the
> environment, which is a braindamage.  It is a fine usability
> helper for interactive shells so I do not have problem with
> people setting that in shell as shell variables, though.
> 
> In other words, never do "export CDPATH=..." nor "export CDPATH".
> 
> 

Indeed! I had "export CDPATH=.:$HOME" in my $HOME/.bash_profile.

"export -n CDPATH", and now "make install" works, setting up those hard links
too.

If this is a common gotcha in building and installing git, maybe you should
add it near the top of the INSTALL instructions.

I haven't run into this issue with other projects. Is there something that
can be changed in git's Makefile so it works even if CDPATH is set and
exported in people's environments? What about simply not naming the subdir
blt for both source and install directories under templates?

Thanks!

