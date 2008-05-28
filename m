From: Christophe GRENIER <grenier@cgsecurity.org>
Subject: Bug in git-log --date=short --pretty=format:"%ad"
Date: Wed, 28 May 2008 15:49:35 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0805281535560.8172@adsl.cgsecurity.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 16:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1MaF-00067r-44
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 16:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbYE1OYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 10:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYE1OYB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:24:01 -0400
Received: from SMT02001.global-sp.net ([193.168.50.54]:56004 "EHLO
	SMT02001.global-sp.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYE1OYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:24:01 -0400
X-Greylist: delayed 2059 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 May 2008 10:24:00 EDT
Received: from [192.168.100.1] (mna75-8-82-234-66-240.fbx.proxad.net [82.234.66.240])
	(Authenticated sender: grenier-cgsecurity-org@smt02003.global-asp.net)
	by SMT02001.global-sp.net (Postfix) with ESMTP id 4DE7B552EB3
	for <git@vger.kernel.org>; Wed, 28 May 2008 15:49:37 +0200 (CEST)
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-MailScanner-ID: 4DE7B552EB3.F2E7C
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck: 
X-MailScanner-From: grenier@cgsecurity.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83093>

Hi,

According to the git-log man page, we can configure how date are 
displayed:

--date={relative,local,default,iso,rfc}
   Only takes effect for dates shown in human-readable format,
   such as when using "--pretty".

But it doesn't work when a user supplied format is used:

git-log --date=short --pretty=format:"%ad"
Wed May 28 13:28:35 2008 +0200
Wed May 28 13:26:14 2008 +0200
...

instead of
2008-05-28
2008-05-28
...

In pretty.c, when pretty_print_commit() calls format_commit_message(),
dmode isn't passed as argument so format_commit_item() will never have
the date format specified at the command line.
This problem is present in git-1.5.5.3

Regards,

 	Christophe

-- 
    ,-~~-.___.     ._.
   / |  '     \    | |"""""""""|   Christophe GRENIER
  (  )         0   | |         | grenier@cgsecurity.org
   \_/-, ,----'    | |         |
      ====         !_!--v---v--"
      /  \-'~;      |""""""""|   TestDisk & PhotoRec
     /  __/~| ._-""||        |   Data Recovery
   =(  _____|_|____||________|   http://www.cgsecurity.org
