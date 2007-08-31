From: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>
Subject: CVS-$Id:$ replacement in git?
Date: Fri, 31 Aug 2007 17:03:31 +0200
Message-ID: <46D82DC3.2030203@bioinf.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 18:20:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9Dr-00012s-V2
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbXHaQTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbXHaQTG
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:19:06 -0400
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:25300 "EHLO
	triton.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965023AbXHaQTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:19:05 -0400
X-Greylist: delayed 4531 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Aug 2007 12:19:05 EDT
Received: from mail.cs.uni-sb.de (mail.cs.uni-sb.de [134.96.254.200])
	by triton.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id l7VF3WNw031053
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 17:03:32 +0200
Received: from bioinf.uni-sb.de (fred.bioinf.uni-sb.de [134.96.237.36])
	by mail.cs.uni-sb.de (8.14.1/2007083000) with ESMTP id l7VF3W2e007725
	for <git@vger.kernel.org>; Fri, 31 Aug 2007 17:03:32 +0200 (CEST)
Received: from [134.96.237.57] ([134.96.237.57] verified)
  by bioinf.uni-sb.de (CommuniGate Pro SMTP 4.2b5)
  with ESMTP-TLS id 2992241 for git@vger.kernel.org; Fri, 31 Aug 2007 17:03:32 +0200
User-Agent: Thunderbird 2.0.0.5 (X11/20070725)
X-Enigmail-Version: 0.95.0
X-DCC-CTc-dcc1-Metrics: itelist
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (triton.rz.uni-saarland.de [134.96.7.25]); Fri, 31 Aug 2007 17:03:32 +0200 (CEST)
X-AntiVirus: checked by AntiVir MailGate (version: 2.1.2-14; AVE: 7.4.1.66; VDF: 6.39.1.72; host: AntiVir3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57182>

Dear all,

we would very much like to migrate our currently CVS-managed project,
the Biochemical ALgorithms Library BALL (http://www.ball-project.org) to
git. Apart from the problem that our repository turned out to be
horribly broken after 12 years of development -- which made conversion
to git a somewhat unpleasant experience -- we would now be nearly ready
to migrate. But unfortunately, we internally rely heavily on the $Id:$ -
expansion of CVS, that is the ability to have a line like

$Id:$

in the source file expanded to something like

$Id: HINFile.C,v 1.64 2005/02/09 13:02:41 oliver Exp $

The information we want to store in the file would be something like the
SHA1 of the last commit that touched that file, the date when it
happened and the person who commited it.

I have been thinking about trying to achieve something like this in git.
From my very limited understanding of the internals of git, I thought it
should be possible to have a sed-script at the appropriate hooks that
inserts the updated information into a file whenever it is affected by a
commit.

Do you think that this could work? And if so, would it suffice to add a
pre-commit hook?

I can currently see two main problems of this idea: the first is that I
would expect this to do strange things when people work with a cloned or
copied repository but forget to install the scripts at the correct
location. This, I would be willing to ignore. The other problem I expect
are lots of meaningless conflicts upon merging, since for a file that
has been touched in two branches, the $Id:$ - lines will necessarily be
different. Is there a way around this problem? And, more importantly,
did I overlook any potentially more serious problems with such an approach?

Thanks a lot,

  Andreas Hildebrandt
