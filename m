X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Corrupt pack file using older versions of git on a newer repo..
Date: Wed, 20 Dec 2006 08:27:40 -0500
Message-ID: <BAYC1-PASMTP11ADF6C984028A9DED853FAECF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 13:27:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061220082740.7501e6c5.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 20 Dec 2006 13:38:07.0953 (UTC) FILETIME=[156E3410:01C7243C]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx1U3-00083d-3d for gcvg-git@gmane.org; Wed, 20 Dec
 2006 14:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965017AbWLTN1n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 08:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWLTN1n
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 08:27:43 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:41878 "EHLO
 BAYC1-PASMTP11.BAYC1.HOTMAIL.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S965017AbWLTN1n (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20
 Dec 2006 08:27:43 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Wed, 20 Dec 2006 05:38:07 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gx0Xq-0003nc-BJ for git@vger.kernel.org; Wed, 20 Dec
 2006 07:27:38 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


This is probably expected behavior, but when bisecting another Git
issue[1], i found that after a fresh clone of the git repository using
1.4.4.2 I got the following corrupt pack file when accessing that repo
with an old version of git:

$ git --version
git version 1.4.2

$ git log
fatal: corrupted pack file .git/objects/pack/pack-d75f6a8307f8d8ce9727fe27107486839c54aef6.pack

When reverting to 1.4.3 instead, a git reset triggered the corrupt pack
error.  Anyway, just a heads up in case it actually matters.

Sean

[1]  The "Git" issue turned out not to be Git at all but rather the
Beagle search daemon which seems to touch file stat information as
it scans files in a git repo causing strange git status and diff
