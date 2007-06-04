From: Andy Green <andy@warmcat.com>
Subject: StGIT munged path on refresh
Date: Mon, 04 Jun 2007 09:24:52 +0100
Message-ID: <4663CC54.7090203@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 04 10:30:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7xL-00076i-QU
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 10:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbXFDIaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 04:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbXFDIaK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 04:30:10 -0400
Received: from mog.warmcat.com ([62.193.232.24]:33945 "EHLO
	mailserver.mog.warmcat.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120AbXFDIaI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 04:30:08 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2007 04:30:08 EDT
Received: from armbox7.home.warmcat.com (cpc1-nthc5-0-0-cust289.nrth.cable.ntl.com [82.29.29.34])
	by mailserver.mog.warmcat.com (Postfix) with ESMTP id 5CACE8CAD8;
	Mon,  4 Jun 2007 10:24:53 +0200 (CEST)
Received: from meerkat.home.warmcat.com (flatcat [192.168.0.77])
	by armbox7.home.warmcat.com (Postfix) with ESMTP id B3787103C9;
	Mon,  4 Jun 2007 08:25:01 +0000 (UTC)
Received: from meerkat.home.warmcat.com (localhost [127.0.0.1])
	by meerkat.home.warmcat.com (Postfix) with ESMTP id 7AF5612F34DA;
	Mon,  4 Jun 2007 09:24:52 +0100 (BST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49083>

Hi folks -

I have been using quilt with some success and now I am trying to migrate
to stgit.  I can get started okay with stg init and stg new "mypatch",
stg refresh then picks up modifications without having to be told about
the changed files, very nice.

However after I have modified several files in the tree, stg refresh
breaks without my having changed anything in the meantime to do with
stgit.  The problem looks like this:

$ stg refresh
Checking for changes in the working directory... done
Refreshing patch "mISDN-remove-unused-test-from-bitops.patch"...error:
drivers/isdn/hardware/mISDN/drivers/isdn/hardware/mISDN/appl.c: does not
exist and --remove not passed
fatal: Unable to process file
drivers/isdn/hardware/mISDN/drivers/isdn/hardware/mISDN/appl.c
stg refresh: Failed git-update-index

$ pwd
/projects/octotux/packages/mISDN-1.2.0/drivers/isdn/hardware/mISDN
$ ls appl.c
appl.c

The tree starts at /projects/octotux/packages/mISDN-1.2.0, ie, there is
a .git/ in there.  Notice that in the diagnostic, the path after the
start of the tree is repeated twice :-( but I did not run any stg or git
commands between a successful stg refresh and the first broken one.

In case it is important, I am working on a branch called "portability".

This is with

# rpm -q git-core
git-core-1.5.0.6-1.fc7
# rpm -q stgit
stgit-0.12.1-2.fc7

-Andy
