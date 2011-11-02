From: Nick Alcock <nix@esperi.org.uk>
Subject: [PATCH 0/2] Support sizes >=2G in various config options, v2
Date: Wed,  2 Nov 2011 15:46:21 +0000
Message-ID: <1320248783-29577-1-git-send-email-nix@esperi.org.uk>
Cc: Nick Alcock <nix@esperi.org.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 17:25:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLdck-0003kb-9Z
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 17:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab1KBQZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 12:25:05 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:42917 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431Ab1KBQZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 12:25:03 -0400
X-Greylist: delayed 2294 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Nov 2011 12:25:03 EDT
Received: from esperi.org.uk (compiler@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.5/8.14.5) with ESMTP id pA2FkjP0032571;
	Wed, 2 Nov 2011 15:46:45 GMT
Received: (from compiler@localhost)
	by esperi.org.uk (8.14.5/8.14.5/Submit) id pA2Fkjl8029621;
	Wed, 2 Nov 2011 15:46:45 GMT
X-Mailer: git-send-email 1.7.6.1.138.g03ab.dirty
X-DCC-URT-Metrics: spindle 1060; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184641>

New in this version:

 - overflow detection, as suggested by Johannes Sixt (on 32-bit
   platforms too).
 - no renaming of NO_STRTOUMAX nor NO_STRTOULL.

I think this covers all the bases, including detection of configuration
values that overflow signed but not unsigned type only after
factor-application (as '3g' would on a 32-bit Linux box).

No new git testsuite failures. (No tests either, because I can't think
of one that will reliably induce overflow on a 64-bit box without being
totally ludicrous.)

Nick Alcock (2):
  Add strtoimax() compatibility function.
  Support sizes >=2G in various config options accepting 'g' sizes.

 Makefile           |    6 +++---
 compat/strtoimax.c |   10 ++++++++++
 config.c           |   43 +++++++++++++++++++++++++++++++++----------
 3 files changed, 46 insertions(+), 13 deletions(-)
 create mode 100644 compat/strtoimax.c

-- 
1.7.6.1.138.g03ab.dirty
