From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 0/2] git-stash: clear rerere state on conflict
Date: Fri,  6 Jul 2012 12:22:50 -0400
Message-ID: <1341591772-26251-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 18:32:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnBSk-0003GR-2t
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 18:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965Ab2GFQct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 12:32:49 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:56082 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757946Ab2GFQcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 12:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=559; q=dns/txt;
  s=iport; t=1341592359; x=1342801959;
  h=from:to:cc:subject:date:message-id;
  bh=q8Xji1IMsDEU8fCGeQVkPqynA3TERO+G0uMnmiCDfHk=;
  b=fOw/DeHReAaP+jj+Fxqf4rSrNR7+SBYn4huFweljVChwISYzn8lzPZnS
   vLOgcipPohVDbYKh37PGUBj6qEUqujvOemoNtU37GLXG9Y4iDKc9VCoUr
   V24l2QXB2qHbxvArfeNbxA6d+Iz6meRWAEDk/TUFSKoS1UinEj0QuNEtz
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwEAGYQ90+tJV2Y/2dsb2JhbABFtz6BB4IxAWaBc4dpC5pJoCiOQ4McA5U3gRKNC4Fmgns
X-IronPort-AV: E=Sophos;i="4.77,537,1336348800"; 
   d="scan'208";a="99225938"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-1.cisco.com with ESMTP; 06 Jul 2012 16:23:10 +0000
Received: from iptv-lnx-hordp.cisco.com (dhcp-64-100-104-40.cisco.com [64.100.104.40])
	by rcdn-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id q66GNASd020339;
	Fri, 6 Jul 2012 16:23:10 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201121>

This patch series adds a failing test and then a fix for the condition
discussed in these threads:

http://article.gmane.org/gmane.comp.version-control.git/177224
http://article.gmane.org/gmane.comp.version-control.git/201045
http://article.gmane.org/gmane.comp.version-control.git/200178/match=merge_rr

I previously floated this wrong-headed test after the same problem:
http://article.gmane.org/gmane.comp.version-control.git/177231

[PATCH 1/2] test: mergetool ignores rerere in git-stash
[PATCH 2/2] Clear rerere status during stash conflict
