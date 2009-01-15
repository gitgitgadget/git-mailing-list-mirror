From: "George Spelvin" <linux@horizon.com>
Subject: fatal: git grep: cannot generate relative filenames containing
 '..'
Date: Thu, 15 Jan 2009 17:29:05 -0500
Message-ID: <20090115222905.8157.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 23:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNapw-0008RP-Nl
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936235AbZAOWfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935916AbZAOWfu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:35:50 -0500
Received: from science.horizon.com ([192.35.100.1]:12158 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S936230AbZAOWfr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 17:35:47 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jan 2009 17:35:47 EST
Received: (qmail 8158 invoked by uid 1000); 15 Jan 2009 17:29:05 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105889>

Could someone fix this some day?  "git grep <pattern> ../include"
is something I find myself wanting quite frequently, and it's a fresh
annoyance every time I type it to discover that it still doesn't work.

While you're at it, an option to search the entire git tree rather than
the current subdirectory would also be useful.  I was thinking about
a flag like -r (for "root"), but a second idea dawned on me: interpret
absolute pathnames as relative to the root of the repository.  So I could
"git grep <pattern> /" or "git grep <pattern> /include" from any subdirectory.

As it is currently, absolute pathnames don't work very well either...
[1]$ git grep xyzzy $PWD
fatal: '/home/linux/project/src' is outside repository
[2]$ cd /usr/src/linux
[3]$ git grep xyzzy $PWD
CREDITS:E: rjd@xyzzy.clara.co.uk
drivers/hwmon/hwmon-vid.c: * With assistance from Trent Piepho <xyzzy@speakeasy.
drivers/infiniband/hw/ipath/ipath_debug.h: * if(infinipath_debug & _IPATH_xyzzy)
drivers/media/dvb/frontends/or51132.c: *    Copyright (C) 2007 Trent Piepho <xyz
drivers/media/video/cx88/cx88-alsa.c: *    (c) 2007 Trent Piepho <xyzzy@speakeas
drivers/video/intelfb/intelfbhw.c:      /* do some funky magic - xyzzy */
include/linux/byteorder/swab.h: * Trent Piepho <xyzzy@speakeasy.org> 2007114
include/linux/hwmon-vid.h:    With assistance from Trent Piepho <xyzzy@speakeasy
[4]$ cd include
[5]$ git grep xyzzy $PWD
fatal: git grep: cannot generate relative filenames containing '..'

I don't quite understand that last error message.

Thank you.
