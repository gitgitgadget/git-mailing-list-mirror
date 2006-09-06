From: Jakub Narebski <jnareb@gmail.com>
Subject: git-rev-list --full-history --parents doesn't respect path limit and shows all merges
Date: Wed, 06 Sep 2006 13:11:12 +0200
Organization: At home
Message-ID: <edmabt$3tc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Sep 06 13:11:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKvJi-0005ky-4i
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 13:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWIFLL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 07:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWIFLL0
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 07:11:26 -0400
Received: from main.gmane.org ([80.91.229.2]:43730 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750727AbWIFLLY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 07:11:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GKvJG-0005fI-Qa
	for git@vger.kernel.org; Wed, 06 Sep 2006 13:11:11 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 13:11:10 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 13:11:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26514>

When trying to speed-up gitweb by using only one git-rev-list invocation to
get _parsed_ list of revisions, and not first call git-rev-list to get list
of revisions, and then for each revision call git-rev-list --max-count=1
--parennts --header to parse a commit, I have encountered the following
error in (most probably) --full-history implementation.

Namely the following work as expected, returning only one commit:

  git rev-list HEAD -- gitweb/git-logo.png
  git rev-list HEAD --full-history -- gitweb/git-logo.png
  git rev-list HEAD --parents -- gitweb/git-logo.png
 
but the following command

  git rev-list HEAD --full-history --parents -- gitweb/git-logo.png

returns additionally _all_ the merges.


I don't know if it is a feature or a bug (I think that is the latter),
but it seriously screw mentioned plan to make gitweb faster a bit.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
