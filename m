From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: rebase --onto might "loose" commits
Date: Tue, 19 Feb 2008 08:23:59 +0100
Message-ID: <20080219072359.GA752@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Feb 19 08:24:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRMqH-0002pO-Vr
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbYBSHYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753628AbYBSHYG
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:24:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:40555 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753295AbYBSHYF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:24:05 -0500
Received: (qmail invoked by alias); 19 Feb 2008 07:24:00 -0000
Received: from i577B8F4B.versanet.de (EHLO atjola.local) [87.123.143.75]
  by mail.gmx.net (mp026) with SMTP; 19 Feb 2008 08:24:00 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+vtnMwL0ev0ra3ixW164WDfbl0y5/2eacuS9OGZL
	Dv/nN94zc8RbmB
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74381>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

when there's nothing to rebase (ie. upstream..branch is empty), rebase
fails to find any commits to rebase and correctly says "Nothing to do",
but when --onto is given, we already did a "reset --hard" to newbase, so
it already _did_ something.

As rebase also shows a "fatal: Not a range", during the operation, I
assume that this is an actual bug and not just a plain user error.

A test script is attached.

Thank,
Björn

--FCuugMFkClbJLl1L
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0Amkdir t=0Acd t=0Agit init=0A=0Atouch common1 && git add common1=
 && git commit -m common1=0Atouch common2 && git add common2 && git commit =
-m common2=0A=0Agit checkout -b dest=0Atouch newbase && git add newbase && =
git commit -m newbase=0Atouch newbase2 && git add newbase2 && git commit -m=
 newbase2=0A=0Agit checkout master=0Atouch this_gets_lost && git add this_g=
ets_lost && git commit -m this_gets_lost=0Atouch this_too && git add this_t=
oo && git commit -m this_too=0A=0Agit checkout -b new=0Agit rebase --onto d=
est master new=0A=0Aecho "master's shortlog"=0Agit shortlog master=0Aecho "=
rebased new shortlog"=0Agit shortlog=0A
--FCuugMFkClbJLl1L--
