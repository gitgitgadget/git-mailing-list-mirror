From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/2] Libify rerere: clear and gc
Date: Sun,  8 May 2011 13:00:49 +0530
Message-ID: <1304839851-6477-1-git-send-email-artagnon@gmail.com>
References: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 09:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIySX-0003lW-OT
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 09:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab1EHHbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2011 03:31:02 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:17570 "EHLO
	smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab1EHHa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 03:30:58 -0400
X-IronPort-AV: E=Sophos;i="4.64,334,1301875200"; 
   d="scan'208";a="430224106"
Received: from smtp-in-0191.sea3.amazon.com ([10.224.12.28])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 May 2011 07:30:57 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-0191.sea3.amazon.com (8.13.8/8.13.8) with ESMTP id p487UtX0002343;
	Sun, 8 May 2011 07:30:55 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id A1765754828; Sun,  8 May 2011 13:00:51 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
In-Reply-To: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173077>

Hi,

This is an alternate version of the v3 patch: Instead of exposing
unlink_rr_item, I have chosen to libify "rerere gc" in order to libify
"rerere clear", and it may be argued that this is a pleasant
side-effect.  I've also included another patch to replace the
"die_errno" call with a new "error_errno" call, and I hope this will
be used in other places as well.  Note one more subtle change: I've
chosen to pass "flags" as an argument to both functions for the sake
of consistency; if and when rerere grows more command-line options,
"flags" can be replaced by a struct containing those parsed options.

Cons: This patch is much larger than v3.

Thanks to: Junio and Jonathan.

Ramkumar Ramachandra (2):
  usage: Introduce error_errno corresponding to die_errno
  rerere: Libify "rerere clear" and "rerere gc"

 builtin/rerere.c  |   81 ++-----------------------------------------
 git-compat-util.h |    1 +
 rerere.c          |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rerere.h          |    2 +
 usage.c           |   10 +++++
 5 files changed, 116 insertions(+), 77 deletions(-)

-- 
1.7.5.GIT
