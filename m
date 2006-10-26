X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: an option to make "git-diff Z A" prints Z's diff before A's
Date: Thu, 26 Oct 2006 08:16:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610260812120.3962@g5.osdl.org>
References: <871wowzx15.fsf@rho.meyering.net> <7vd58g9pfs.fsf@assigned-by-dhcp.cox.net>
 <20061026084221.GB13780@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-948129080-1161875809=:3962"
NNTP-Posting-Date: Thu, 26 Oct 2006 15:17:55 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jim Meyering <jim@meyering.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061026084221.GB13780@diana.vm.bytemark.co.uk>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30226>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd6z7-00041g-LH for gcvg-git@gmane.org; Thu, 26 Oct
 2006 17:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423554AbWJZPRa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 11:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423557AbWJZPRa
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 11:17:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30701 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1423554AbWJZPR3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 11:17:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9QFGoPo024964
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 26
 Oct 2006 08:16:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9QFGnSc018080; Thu, 26 Oct
 2006 08:16:49 -0700
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-948129080-1161875809=:3962
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Thu, 26 Oct 2006, Karl Hasselström wrote:
> 
> A related question: is there a way to limit the path to Z, but
> excluding Z/B? That is, I'm interested in the changes in Z, but not
> the changes in its subdirectory B.

We never did that, no. It's certainly a relevant thing to do, and it would 
be sensible to have a kind of common logic with revision parsing (where a 
caret (^) at the beginning would mean "not"), but at the same time, it's 
not been common enough (read: "I have personally never missed it") to 
actually become an issue.

So I _think_ it would fit fairly well into the current code (just teach 
the stuff that uses "char **pathspec" about that new rule), and it might 
not be too bad. On the other hand, that particular code is pretty dense 
and part of a very core and performance critical subsystem, so unless you 
_really_ want this, you might be better off averting your eyes and just 
ignoring this issue ;)

			Linus
