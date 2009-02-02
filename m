From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/4] add -p: Term::ReadKey and more
Date: Mon,  2 Feb 2009 22:46:27 +0100
Message-ID: <1233611191-18590-1-git-send-email-trast@student.ethz.ch>
References: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <junio@pobox.com>, Jeff King <peff@peff.net>,
	Suraj Kurapati <sunaku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 22:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU6eK-0001If-U8
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758953AbZBBVqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbZBBVqr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:46:47 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:9370 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758855AbZBBVqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:46:46 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:43 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Feb 2009 22:46:44 +0100
X-Mailer: git-send-email 1.6.1.2.513.g04677
In-Reply-To: <7vljspjk8n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 02 Feb 2009 21:46:44.0034 (UTC) FILETIME=[BD516A20:01C9857F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108126>

I added some more patches. 3/4 is the previous version, with code
added to make / work (it just prompts for a regex) and a configuration
variable added for Junio:

Junio C Hamano wrote:
> I'd appreciate if you can allow this "single stroke" mode to be optionally
> turned off by the end user.

I decided to disable it by default since it is an inconsistency
between add -i and add -p for users of both, so if you want this
feature, make sure to enable interactive.readkey.  (I don't mind the
inconsistency as I never use 'add -i'.)

I also removed the stray %control_chars from back when my draft
versions used raw instead of cbreak mode, and consequently had to test
for Ctrl-C themselves.


Finally, the first two patches fix small problems I saw while looking
over the code, and 4/4 changes the color of error messages caused by
keyboard input to color.interactive.help, lest they drown in the hunk
that is automatically redisplayed.


Thomas Rast (4):
  add -p: change prompt separator for 'g'
  add -p: trap Ctrl-D in 'goto' mode
  add -p: prompt for single characters
  add -p: print errors in help colors

 Documentation/config.txt  |    6 ++++
 git-add--interactive.perl |   70 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 63 insertions(+), 13 deletions(-)
