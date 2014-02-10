From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] t5538: fix default http port
Date: Mon, 10 Feb 2014 14:16:38 -0500
Message-ID: <20140210191637.GA3820@sigill.intra.peff.net>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
 <1391699439-22781-3-git-send-email-pclouds@gmail.com>
 <20140206193533.GB14552@sigill.intra.peff.net>
 <20140207234727.GA17520@sigill.intra.peff.net>
 <CACsJy8CLR4qerWPWs+0TWxnTWidm_VLtYExjKqAOLOSNK0chaA@mail.gmail.com>
 <20140210143948.GA21242@sigill.intra.peff.net>
 <xmqqwqh2su6e.fsf@gitster.dls.corp.google.com>
 <20140210191521.GA3112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 20:16:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCwLV-000337-QR
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 20:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbaBJTQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 14:16:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:48134 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752201AbaBJTQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 14:16:41 -0500
Received: (qmail 12699 invoked by uid 102); 10 Feb 2014 19:16:41 -0000
Received: from mobile-032-162-138-072.mycingular.net (HELO sigill.intra.peff.net) (32.162.138.72)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Feb 2014 13:16:41 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Feb 2014 14:16:38 -0500
Content-Disposition: inline
In-Reply-To: <20140210191521.GA3112@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241926>

On Mon, Feb 10, 2014 at 02:15:24PM -0500, Jeff King wrote:

> Thanks. It might be worth squashing in the patch below (or sticking it
> on top), to cover git-daemon as well.

Patch would probably be easier to read if I actually included it...

-- >8 --
Subject: [PATCH] tests: auto-set git-daemon port

A recent commit taught lib-httpd to always start apache on
the same port as the numbered tests. Let's do the same for
the git-daemon tests.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-git-daemon.sh   | 2 +-
 t/t5570-git-daemon.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 394b06b..1f22de2 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -22,7 +22,7 @@ then
 	test_done
 fi
 
-LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-'8121'}
+LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-${this_test#t}}
 
 GIT_DAEMON_PID=
 GIT_DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index e061468..6b16379 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -3,7 +3,6 @@
 test_description='test fetching over git protocol'
 . ./test-lib.sh
 
-LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-5570}
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
 start_git_daemon
 
-- 
1.8.5.2.500.g8060133
