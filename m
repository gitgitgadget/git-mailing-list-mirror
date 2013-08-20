From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH v5 0/2] Fix IO of >=2GB on Mac OS X by limiting IO chunks
Date: Tue, 20 Aug 2013 08:43:53 +0200
Message-ID: <1376981035-23284-1-git-send-email-prohaska@zib.de>
References: <1376926879-30846-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 20 08:45:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBfhH-00042T-VA
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 08:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab3HTGpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 02:45:32 -0400
Received: from mailer.zib.de ([130.73.108.11]:64072 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab3HTGpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 02:45:30 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id r7K6i74s002538;
	Tue, 20 Aug 2013 08:44:13 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id r7K6i4jp029237;
	Tue, 20 Aug 2013 08:44:05 +0200 (MEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
In-Reply-To: <1376926879-30846-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232585>

This is the revised patch taking the considerations about IO chunk size into
account.  The series deletes more than it adds and fixes a bug.  Nice.

Steffen Prohaska (2):
  xread, xwrite: Limit size of IO, fixing IO of 2GB and more on Mac OS X
  Revert "compate/clipped-write.c: large write(2) fails on Mac OS X/XNU"

 Makefile               |  8 --------
 compat/clipped-write.c | 13 -------------
 config.mak.uname       |  1 -
 git-compat-util.h      |  5 -----
 t/t0021-conversion.sh  | 14 ++++++++++++++
 wrapper.c              | 12 ++++++++++++
 6 files changed, 26 insertions(+), 27 deletions(-)
 delete mode 100644 compat/clipped-write.c

-- 
1.8.4.rc3.5.g4f480ff
