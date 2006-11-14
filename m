X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: git-rev-list: --objects list inconsistency
Date: Tue, 14 Nov 2006 16:54:17 +0100
Organization: eudaptics software gmbh
Message-ID: <4559E6A9.9A30A236@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 16:00:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31350>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk0hn-0007bb-Ak for gcvg-git@gmane.org; Tue, 14 Nov
 2006 17:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965921AbWKNQAF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 11:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966042AbWKNQAF
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 11:00:05 -0500
Received: from main.gmane.org ([80.91.229.2]:42159 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S965921AbWKNQAD (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 11:00:03 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gk0he-0007Yz-JV for git@vger.kernel.org; Tue, 14 Nov 2006 17:00:02 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 17:00:02 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 14 Nov 2006
 17:00:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I observed a puzzling behavior of git-rev-list:

$ git-rev-list master^^..master 
f3364ca9405e17772fecea1d06c40b9965b8e6e4
bb3bfda219a85d2d49e62c261b9c8f6795ebdc22
$ git-rev-list --max-count=2 master 
f3364ca9405e17772fecea1d06c40b9965b8e6e4
bb3bfda219a85d2d49e62c261b9c8f6795ebdc22
$ git-rev-list --objects master^^..master |wc -l
     10
$ git-rev-list --objects --max-count=2 master |wc -l
   2376

As you can see, without --objects, master^^..master and --max-count=2
list the same two commits.

But with --objects I get different object lists. I don't even know which
one is the one to expect, but I certainly would not have expected the
lists to be different. What's wrong here?

BTW, the objects listed with --objects --max-count=2 are basically the
entire tree at master plus the few objects that changed since master^^.

$ git --version
git version 1.4.4.rc2.gc8641

-- Hannes
