From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 0/2] gitk --color-words
Date: Wed, 31 Mar 2010 02:52:47 +0200
Message-ID: <cover.1269996525.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Paul Mackerras <paulus@samba.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 31 02:53:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwmBC-0006cF-FN
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 02:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab0CaAwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 20:52:54 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:28438 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673Ab0CaAwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 20:52:53 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 31 Mar
 2010 02:52:52 +0200
Received: from localhost.localdomain (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 31 Mar
 2010 02:52:50 +0200
X-Mailer: git-send-email 1.7.0.3.522.ga3f6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143627>

This little pair of patches teaches gitk a color-words diff view.

To get there, I finally got rid of the assumption that --color-words
only ever needs to output ANSI(?) color sequences.  Hopefully this
will help other people to use --color-words in nice frontends.

It uses an ad-hoc output format where newlines in the output are
insignificant (so as to be able to speak about added/removed words)
and newlines from the input are output as a line with only a '~'.

RFC among other things because

* I chose ~ more or less randomly.  Do any diff implementations out
  there use it for some other purpose?

* The --color-words code was the only user of color_fwrite_lines() so
  I tweaked it according to my needs.  But that makes it highly
  diff-specific again, so it's not in color.c any more.  Did anyone
  else intend to use it?

* The Tk part of the patch is 95% voodoo of the
  cut&paste-from-elsewhere vintage and I have no clue whether it works
  only by accident

* I still need to do some things: add docs for --porcelain, add tests
  to the first patch, move the gitk patch to affect only the subtree

* I'm not even burning midnight oil any more

Thomas Rast (2):
  Add diff --porcelain option for --color-words
  gitk: add the equivalent of diff --color-words

 color.c       |   28 ---------------
 color.h       |    1 -
 diff.c        |  105 +++++++++++++++++++++++++++++++++++++++++++++++---------
 diff.h        |    1 +
 gitk-git/gitk |   29 +++++++++++++++-
 5 files changed, 116 insertions(+), 48 deletions(-)
