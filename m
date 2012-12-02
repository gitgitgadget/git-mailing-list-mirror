From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v6 0/4] submodule update: add --remote for submodule's upstream
 changes
Date: Sat, 01 Dec 2012 22:17:00 -0500
Message-ID: <cover.1354417618.git.wking@tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 04:19:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf055-0006UA-LS
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 04:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035Ab2LBDSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 22:18:23 -0500
Received: from vms173013pub.verizon.net ([206.46.173.13]:43301 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab2LBDSV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 22:18:21 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.250])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED00634VTZJU50@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 21:18:00 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id 109036E4035; Sat,
 01 Dec 2012 22:17:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.4.gf74b0fc.dirty
In-reply-to: <20121130032719.GE29257@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210999>

From: "W. Trevor King" <wking@tremily.us>

On Thu, Nov 29, 2012 at 10:27:19PM -0500, W. Trevor King wrote:
> On Thu, Nov 29, 2012 at 08:11:20PM -0500, Phil Hord wrote:
> > I've always felt that the "origin" defaults are broken and are simply
> > being ignored because most users do not trip over them.  But ISTR that
> > submodule commands use the remote indicated by the superproject's
> > current remote-tracking configuration, with a fallback to 'origin' if
> > there is none.  Sort of a "best effort" algorithm, I think.  Am I
> > remembering that wrong?
>
> The current code uses a bare "git-fetch".  I'm not sure what that
> defaults to if you're on a detached head.  If it bothers you, I'm fine
> adding the submodule.<name>.remote option in v6.

Here it is.  Now the remote defaults to $(get_default_remote) with an
optional override via submodule.<name>.remote.

Changes since v5:

* New patch 1 for easy config variable setup.
* Minor tweaks and rewordings in patches 2 and 3 (v5 patches 1 and 2).
* New patch 4 adding submodule.<name>.remote.

I'm fine with squashing patches 1, 2, and 4 together, if people prefer
a more compact series.

W. Trevor King (4):
  submodule: add get_submodule_config helper funtion
  submodule update: add --remote for submodule's upstream changes
  submodule add: If --branch is given, record it in .gitmodules
  submodule update: add submodule.<name>.remote config option

 Documentation/config.txt        |  8 ++++-
 Documentation/git-submodule.txt | 27 ++++++++++++++-
 Documentation/gitmodules.txt    |  5 +++
 git-submodule.sh                | 74 ++++++++++++++++++++++++++++++++++++++---
 t/t7400-submodule-basic.sh      |  1 +
 t/t7406-submodule-update.sh     | 49 +++++++++++++++++++++++++++
 6 files changed, 158 insertions(+), 6 deletions(-)

-- 
1.8.0.4.gf74b0fc.dirty
