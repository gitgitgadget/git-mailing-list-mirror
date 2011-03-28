From: Maarten Billemont <lhunath@gmail.com>
Subject: git-am cannot apply git format-patch -M
Date: Mon, 28 Mar 2011 09:44:34 +0200
Message-ID: <09D72CB4-1B48-4799-B0D5-DB54942D840F@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4781-0006fj-Gp
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab1C1Hol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:44:41 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63741 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab1C1Hok convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 03:44:40 -0400
Received: by wwa36 with SMTP id 36so3470976wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:content-type:content-transfer-encoding
         :subject:date:message-id:to:mime-version:x-mailer;
        bh=kIoZBW+VCtWlNKFxomgDrr+dzZ16NrDb5u/6ULxR9pw=;
        b=iyzN+hhRT4fdPBWE3PrsQrrSE+LlxhcuaqAk/WwnDKovYclC/f9FZqY+t8d9tzO/5x
         Q6m/p0G3ByPcbkEiDofWFpEzriUlwemmrGLuSX2+Pqy/rBDQmmDmiMseKDpgXbxLr2sQ
         8FDrZZ+ZeAMHPxzwMJLyAhtMVK3UbIj1k7dIM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=BayV+hvTq3uf7s/YAJjvs/cLja8NJ5W5lKq+hsZZgw8ysPhVV86i0crFU+tsNXgC5j
         SQ8J/hdDHzH1zvUOTku+B0/SotlBL1gqpe+S8QvX+7QcygIxZh8K2tddNVI0wimsKlzE
         EH2osCCUTHQrrli2TG5s2Z1wAoxLl0VfnF4/c=
Received: by 10.227.54.6 with SMTP id o6mr3463671wbg.61.1301298279290;
        Mon, 28 Mar 2011 00:44:39 -0700 (PDT)
Received: from mbillemo.lin-k.net ([80.169.61.18])
        by mx.google.com with ESMTPS id g7sm1848653wby.31.2011.03.28.00.44.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 00:44:38 -0700 (PDT)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170107>

I've created a series of patches for my local commits using:

git format-patch -M -C ...

The resulting patch files contain hunks like:

diff --git a/file1 b/file2
similarity index 93% 
rename from file1
rename to file2
index 7cf3a09..88c9c13 100644
--- a/file1
+++ b/file2
[...]

git-am fails at applying these hunks, failing with:

Applying: [commit description]
fatal: git apply: bad git-diff - inconsistent old filename on line 109
Patch failed at [HEAD commit]
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Additionally, I'd like to report that the line number reported by git-am in this error message does not reflect the actual line number of the problem in the patch file.  The reported line number is offset by -[amount of lines before the [---] line in the patch file], which makes understanding the error message hard, confusing and potentially misleading.