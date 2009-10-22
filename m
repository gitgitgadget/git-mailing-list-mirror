From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 0/2] Speedup fetch with large numbers of refs
Date: Thu, 22 Oct 2009 22:06:12 +0100
Message-ID: <20091022210444.18084.61685.julian@quantumfyre.co.uk>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 23:14:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N14zE-0002kZ-GZ
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 23:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840AbZJVVOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756837AbZJVVOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 17:14:09 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:46011 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756756AbZJVVOJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2009 17:14:09 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id F2B8E116330
	for <git@vger.kernel.org>; Thu, 22 Oct 2009 22:14:12 +0100 (BST)
Received: (qmail 10018 invoked by uid 103); 22 Oct 2009 22:08:09 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9924. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025224 secs); 22 Oct 2009 21:08:09 -0000
Received: from reaper.quantumfyre.co.uk (HELO rayne.quantumfyre.co.uk) (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 22 Oct 2009 22:08:09 +0100
X-Mailer: git-mail-commits v0.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131063>

These two commits make fetch quite a bit faster when dealing with
large numbers of refs.  Unfortunately I've lost the exact figures, but
my silly test respository (50000 tags, 1 branch) went from something
like 30s for a "fetch --tags" that did nothing, to about 5.

Julian Phillips (2):
  remote: Make ref_remove_duplicates faster for large numbers of refs
  fetch: Speed up fetch of large numbers of refs

 builtin-fetch.c |   17 ++++++++++++++---
 remote.c        |   39 +++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 21 deletions(-)
