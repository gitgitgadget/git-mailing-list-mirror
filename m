From: Allan Caffee <allan.caffee@gmail.com>
Subject: [RFC/PATCH] autoconf: Do not build "http-push" without expat
	headers
Date: Wed, 22 Apr 2009 07:58:01 -0400
Message-ID: <20090422115801.GA23065@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 13:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwb74-00068j-97
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 13:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbZDVL6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 07:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbZDVL6I
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 07:58:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:17552 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZDVL6H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 07:58:07 -0400
Received: by wf-out-1314.google.com with SMTP id 26so225756wfd.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=4Yf8v6OI9wAYQWgIDI1h2DxcJhbrEJ103r86odCM0MQ=;
        b=gS/L2Lpeci1JqLlqnG6BM3O+agRyTLxjrixz0iCv/tJ0dF6LN1XgZjjRcwMXG1om3h
         1gjQes0TESeEDxMCETB/BbDkOdR+MBsRewEpZHCJmsfQvmdTxZkDqDpiwBE98Lz75MjX
         zt3xjz2RWwtym5paIT87Bc0O4nO1dD/0acWhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=BhSpVq24SJgpIo04lPCucGhOGk0S8J5upTkoqtFt2Q3qLVtNik1x1+OWsCz9SiePWG
         twUzCNHJRg1utcXLJuFwZNgq4BxA2dPbDOdcOQXAxAtmZoh1+0Yi7jn8Yx1Bh0qg+YJF
         CyCeX9E3PM8zu+pSppHdtK8CDiAD0nYHGgl/0=
Received: by 10.143.13.17 with SMTP id q17mr5139704wfi.222.1240401486841;
        Wed, 22 Apr 2009 04:58:06 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 22sm5659003wfg.3.2009.04.22.04.58.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Apr 2009 04:58:06 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117195>

Simply linking against expat does not guarantee successful compilation.
Check for development headers before attempting to compile the dependant
binaries.

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4e728bc..3de0ae7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -375,6 +375,9 @@ GIT_STASH_FLAGS($EXPATDIR)
 AC_CHECK_LIB([expat], [XML_ParserCreate],
 [NO_EXPAT=],
 [NO_EXPAT=YesPlease])
+AC_CHECK_HEADER([expat.h],
+[NO_EXPAT=],
+[NO_EXPAT=YesPlease])
 
 GIT_UNSTASH_FLAGS($EXPATDIR)
 
-- 
1.5.6.3
