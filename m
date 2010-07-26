From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC PATCH 0/2] Allow detached forms (--option arg) for git log options.
Date: Mon, 26 Jul 2010 20:14:36 +0200
Message-ID: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 20:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSCY-0005tX-B3
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab0GZSOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:14:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36342 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712Ab0GZSOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:14:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6QID0ax008909
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Jul 2010 20:13:00 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdSCH-0002HU-3d; Mon, 26 Jul 2010 20:14:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OdSCH-00086y-2K; Mon, 26 Jul 2010 20:14:41 +0200
X-Mailer: git-send-email 1.7.2.23.g58c3b.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Jul 2010 20:13:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6QID0ax008909
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1280772785.25541@ETJXr94nXp0zhUoattCb6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151866>

Hi,

This has been bothering me for a while: many commands accept detached
form (like "git commit -m message" instead of "git commit -mmessage"),
but others don't, in particular, git log options like

git log -S<string>
git log --grep=<string>

do not accept spaces.

This small patch serie is a very early RFC: it implements the feature
for just two options. There are at least 4 ways towards a real
implementations:

1) nobody except me likes the feature, drop the RFC.

2) Implement the same for other options. That's very repetitive (for
   each option, there are two ifs: a prefixcmp and a strcmp), I don't
   like it much.

3) Write a function or macro that accepts both variants, and use it
   everywhere.

4) use parse-option for "git log" options and then get the feature for
   free.

Hence my question: is there any reason why "git log" hasn't been
migrated to parse-option? Or is it only that nobody did it yet?

What do you think?

Thanks,

Matthieu Moy (2):
  Allow "git log --grep foo" as synonym for "git log --grep=foo".
  Allow "git log -S string" as synonym for "git log -Sstring".

 diff.c     |    5 +++++
 revision.c |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

-- 
1.7.2.23.g58c3b.dirty
