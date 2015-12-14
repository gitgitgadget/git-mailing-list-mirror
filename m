From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 0/4] Fix git-gui when recentrepo list has duplicates
Date: Mon, 14 Dec 2015 15:08:59 +0000
Message-ID: <1450105743-2432-1-git-send-email-philipoakley@iee.org>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
Cc: Alexey Astakhov <asstv7@gmail.com>, sender <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:09:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ukd-0003dW-1y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbLNPJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:09:04 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:40282 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751700AbbLNPJC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:09:02 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ADCwDp2m5WPCSzBlxeGQEBAgsBAgEBAQEBgjlRhCODfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgGIRb0yAQEII4ZWjj0FlnaqWIRnPoU6AQEB
X-IPAS-Result: A2ADCwDp2m5WPCSzBlxeGQEBAgsBAgEBAQEBgjlRhCODfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgGIRb0yAQEII4ZWjj0FlnaqWIRnPoU6AQEB
X-IronPort-AV: E=Sophos;i="5.20,427,1444690800"; 
   d="scan'208";a="621287614"
Received: from host-92-6-179-36.as43234.net (HELO localhost) ([92.6.179.36])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 14 Dec 2015 15:30:39 +0000
X-Mailer: git-send-email 1.9.5
In-Reply-To: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282360>

This is the patch series which follows from a user report of not being
able to start the git-gui when it contained duplicate entries.

The git gui design assumes that there will never be duplicate entries
in the recent repo list, and attempts to keep it that way.

For reasons unknown (other applications or tcl bugs?) there are cases
where the global .gitconfig does contain duplicate entries in the
gui.recentrepo config var. contrary to expectation.

The patch series fixes the root of the issue first, then patches the
logic for the two functional usages of _unset_recentrepo.

Finally, the displayable recentrepos list region is expanded to allow
extended recentrepo lists to at least be shown, before the git-gui
wrangles then back down to the allowed maxrecent size.

Philip Oakley (4):
  git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
  git gui: cope with duplicates in _get_recentrepo
  git gui: de-dup selected repo from recentrepo history
  git gui: allow for a long recentrepo list

 git-gui/lib/choose_repository.tcl | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.5.2.windows.2
