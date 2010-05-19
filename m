From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCHv2] Accept the timezone specifiers [+-]hh:mm and [+-]hh in addition to [+-]hhmm
Date: Wed, 19 May 2010 22:49:36 +0200
Message-ID: <1274302177-3573-1-git-send-email-marcus@mc.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 22:50:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEqDE-0008Cv-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 22:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0ESUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 16:49:51 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:45367 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0ESUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 16:49:50 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 5368CE183
	for <git@vger.kernel.org>; Wed, 19 May 2010 22:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1274302189; bh=LP2mtUk7rYi3bHpNt0eg4dyRBh7430f0swKit+satIU=;
	h=From:To:Subject:Date:Message-Id; b=qp+dSjp9YmJNipEin2KxTlskPNdn/+
	JyeGeazWu2ipkOUnkMbg0gGtFGur6FUzSPaMKQODqv4LCoROZdeRbwEGv8kl1duFV0Z
	8BFAqtgeMvKUZ607IAUkiUwYegKP6eZYS4yDLFqkEEbHP3FBHYFWwaYPxI2iPYYcGGd
	NXlimm8=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@chiyo>)
	id 1OEqD6-0000wl-9z
	for git@vger.kernel.org; Wed, 19 May 2010 22:49:48 +0200
X-Mailer: git-send-email 1.7.1.95.g7c1a64.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147346>

Ok, here's a new attempt for the +hh(:mm) timezones, which should be
semantically equivalent to the previous one.  In particular, I tested
the following corner cases:

  check_parse '+31/05/06 1980 01:02:03' '1980-05-06 01:02:03 +0000'
  check_parse '+1979/05/06/03 01:02:03' '2003-05-06 01:02:03 +0000'
  check_parse '+11:5:6 1999/04/01' '1999-03-31 18:06:00 +0000'
  check_parse '+11:73 Jun 15 10:00:00' bad

I'm not arguing that these results are "correct" or anything, I just
observe that it was like that before, and so by conservatively not
changing them, I shouldn't break anything...

(Ok, the last one _is_ a change from how it was in the before time,
 in the long long ago, but it's the same as it was with the last
 version of the patch.)


  // Marcus
