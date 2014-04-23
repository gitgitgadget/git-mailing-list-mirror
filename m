From: Tim Chase <git@tim.thechases.com>
Subject: Archiving off old branches
Date: Wed, 23 Apr 2014 12:08:50 -0500
Message-ID: <20140423120850.3f6fb535@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 19:09:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd0fw-0002Ub-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbaDWRJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:09:31 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:54172 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753802AbaDWRI5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2014 13:08:57 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:33797 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <git@tim.thechases.com>)
	id 1Wd0fI-000Dir-IU
	for git@vger.kernel.org; Wed, 23 Apr 2014 12:08:56 -0500
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246852>

I've got a branch for each bug/issue and it was getting a bit
unwieldy.  A little searching suggested this

  # archive off the BUG-123 branch
  git update-ref refs/closed/BUG-123 BUG-123
  git branch -D BUG-123

which seems to do exactly what I want -- branches are archived off so
they still have refs, but they don't appear in the output of "git
branch".

Reading up on "git help update-ref", it states that it updates the
name "safely".  As best I can tell, the above process does something
like

  cd .git/refs
  mkdir -p closed
  mv heads/BUG-123 closed

Is there something unsafe about this?  The advantage to the latter
would be that I could do a bunch of them easily:

  mv heads/BUG-{123,234,345,456,567} closed

but I want to make sure I'm not screwing something up unsafely.  Is
there some key element to "update-ref"'s safety that I'm missing?

-tkc
