From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/10] t3301 (notes): use test_expect_code for clarity
Date: Sun, 31 Oct 2010 02:36:57 -0500
Message-ID: <20101031073657.GG11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:37:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSTZ-0005mt-OY
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120Ab0JaHhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:37:09 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57691 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab0JaHhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:37:08 -0400
Received: by gyg4 with SMTP id 4so2657709gyg.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EACmb/u4n3jI+3pvd8PYMbdPJZ5FhjFlurFEDswDJpo=;
        b=X8JpJcOUTACWu5YtoSnPUA95+1Zv7A6Wc9ZzAltFpVvdWnX7lrShO7dqN0RRgMVaa6
         xSTlIeAYGya4kUbMMIVTqUQnTyATmRh0wAi18/MR3OHa9qWWT70KkRZX+PdTBdMpR5f7
         w6gWATDKv4iDVfNCbznK3MBvrEVMVnxCeAGVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hBRCtn0AddliK4JGvMxQ8WWNthJiAMRSH7/33zja5I0ZqY/yZZGKlSyMr7CSqnzm0R
         in7ol2lkgApZK5gHbE5YEuljT+hMJD6ScTRbUitfBaDLpfpDUWL9BRUM+BT40LN7b2o3
         hPDbzT+Ccy+Gv0wqfQjeBRIt41GS6/zuXEhOY=
Received: by 10.151.9.5 with SMTP id m5mr15895370ybi.307.1288510627501;
        Sun, 31 Oct 2010 00:37:07 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e44sm3815238yha.47.2010.10.31.00.37.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:37:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160425>

Use the test_expect_code helper instead of open-coding it.

The main behavior change is to print the command and actual exit
status when the test fails.  More importantly, this would make it
easier to add commands before "git notes show" as part of the
same test assertion if needed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t3301-notes.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 6931171..7e84ab9 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -52,7 +52,7 @@ test_expect_success 'refusing to edit notes in refs/remotes/' '
 
 # 1 indicates caught gracefully by die, 128 means git-show barked
 test_expect_success 'handle empty notes gracefully' '
-	git notes show ; test 1 = $?
+	test_expect_code 1 git notes show
 '
 
 test_expect_success 'show non-existent notes entry with %N' '
-- 
1.7.2.3.557.gab647.dirty
