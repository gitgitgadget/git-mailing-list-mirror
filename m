From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] t9139 uses ancient, backwards-compatible iconv names
Date: Fri, 29 May 2009 17:14:47 -0700
Message-ID: <20090530001447.GA32188@dcvr.yhbt.net>
References: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de> <20090528080706.GA9239@dcvr.yhbt.net> <20090528081804.GB9239@dcvr.yhbt.net> <7v3aaoe40j.fsf@alter.siamese.dyndns.org> <6I7Qq-BKaJmSe6FJkYgjMpNqo6RFAVB0STpL09QJO1skOCB2ezM6mA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 02:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MACFP-0003so-EM
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 02:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbZE3AOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 20:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbZE3AOq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 20:14:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35258 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbZE3AOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 20:14:45 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850211F79D;
	Sat, 30 May 2009 00:14:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <6I7Qq-BKaJmSe6FJkYgjMpNqo6RFAVB0STpL09QJO1skOCB2ezM6mA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120326>

This is needed to work with
5ae93dfdccfe9457bdb1f54b33c76359f6c3b861:
  t3900: use ancient iconv names for backward compatibility

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

  Brandon Casey <casey@nrlssc.navy.mil> wrote:
  > Junio C Hamano wrote:
  > > Eric Wong <normalperson@yhbt.net> writes:
  > > 
  > >>  t/t9139-git-svn-non-utf8-commitencoding.sh |   47 ++++++++++++++++++++++++++++
  > > 
  > > Hmm.
  > > 
  > >> +# Copyright (c) 2009 Eric Wong
  > >> +
  > >> +test_description='git svn refuses to dcommit non-UTF8 messages'
  > >> +
  > >> +. ./lib-git-svn.sh
  > > 
  > > This passes when merged to 'master', but together with bc/old-iconv branch
  > > cooking in 'next' it breaks.
  > 
  > Yeah, it's the second for loop which accesses the files in t/t3900/.
  > bc/old-iconv replaces each occurrence of ISO-8859-1 with ISO8859-1
  > and EUCJP with eucJP since old Solaris didn't know both names and
  > modern platforms handle either name.  The text files in t/t3900/
  > were renamed accordingly.
  > 
  > It would be nice to use these older names here too, even though I
  > won't be able to test it since svn is not installed on the older
  > platforms I have access to.

 t/t9139-git-svn-non-utf8-commitencoding.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9139-git-svn-non-utf8-commitencoding.sh b/t/t9139-git-svn-non-utf8-commitencoding.sh
index 2b1db97..f337959 100755
--- a/t/t9139-git-svn-non-utf8-commitencoding.sh
+++ b/t/t9139-git-svn-non-utf8-commitencoding.sh
@@ -8,7 +8,7 @@ test_description='git svn refuses to dcommit non-UTF8 messages'
 
 # ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
 
-for H in ISO-8859-1 EUCJP
+for H in ISO8859-1 eucJP
 do
 	test_expect_success "$H setup" '
 		mkdir $H &&
@@ -17,7 +17,7 @@ do
 	'
 done
 
-for H in ISO-8859-1 EUCJP
+for H in ISO8859-1 eucJP
 do
 	test_expect_success "$H commit on git side" '
 	(
@@ -33,7 +33,7 @@ do
 	'
 done
 
-for H in ISO-8859-1 EUCJP
+for H in ISO8859-1 eucJP
 do
 	test_expect_success "$H dcommit to svn" '
 	(
-- 
Eric Wong
