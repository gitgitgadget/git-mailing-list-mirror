From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/3] t1004 (read-tree): the unremovable symlink test
 requires POSIXPERM
Date: Wed, 21 Apr 2010 08:44:57 -0500
Message-ID: <20100421134457.GB5595@progeny.tock>
References: <20100421131255.GA2750@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 15:45:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4aEk-0006f2-Ho
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 15:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625Ab0DUNo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 09:44:59 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38835 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610Ab0DUNo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 09:44:58 -0400
Received: by wwb24 with SMTP id 24so4053389wwb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=d5KbRYeEgG/Q3D8LBuGOEjk8JQFvvHK/iewo1GX82fw=;
        b=CU4hzT9APLlmZ92/As7RT2FmXA6MK3o5kCWIZ4mVLZ9Z594Tr2CN0yT6sg70f6oYNs
         gGzqy9e4m+RiczL6XzO17345RpVd+WCHbjjJnaK+Fymilh6gOPOEa+AjPXdczpnbU4OX
         1+5l3jTR0sjrhmnD072lkN1ZrSYi1mwuVgugY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CklHEPRsoVU1zUNxtR2rM7A5fPF+g2OZSg1CpMlaogXnEVih3zsd3USFsYJRGpGlsJ
         Xja9mlpoUNleotgmWyVq8b/X+L2WYm8LgBZp+cLPizMS9C6OkiFuExPiVrXtv6R1s2RC
         ZbYHS49yKOFeZIzecWhYiD53NJgsDw6vCmy5M=
Received: by 10.216.178.148 with SMTP id f20mr3843209wem.43.1271857496945;
        Wed, 21 Apr 2010 06:44:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e82sm1847489wej.4.2010.04.21.06.44.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 06:44:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100421131255.GA2750@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145429>

Now that it is possible to express this, declare the test from
8a785dc (Add tests to catch problems with un-unlinkable symlinks,
2008-03-18) to require both POSIXPERM and SYMLINKS.

This test would fail on Windows on filesystems that do support
symbolic links and in other situations where symlinks are usable but
Unix-style permissions are not.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
It seems that an almost identical patch was submitted while the
prerequisite mechanism was in its infancy.

http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=118385

 t/t1004-read-tree-m-u-wf.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index f19b4a2..62854a7 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '
 
 '
 
-test_expect_success SYMLINKS 'funny symlink in work tree, un-unlink-able' '
+test_expect_success 'POSIXPERM SYMLINKS' 'funny symlink in work tree, un-unlink-able' '
 
 	rm -fr a b &&
 	git reset --hard &&
-- 
1.7.1.rc1
