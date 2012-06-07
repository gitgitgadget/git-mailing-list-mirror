From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: rebase [-i --exec | -ix] <CMD>...
Date: Thu, 07 Jun 2012 21:10:36 +0200
Message-ID: <4FD0FCAC.3070408@web.de>
References: <4FD0D375.9060902@web.de> <1339087582-10040-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD0EB76.90501@web.de> <20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 21:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sci6h-0005dG-RW
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 21:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761364Ab2FGTKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 15:10:52 -0400
Received: from mout.web.de ([212.227.17.12]:57069 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761349Ab2FGTKv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 15:10:51 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0LiCop-1S8YCq1NYZ-00n0iF; Thu, 07 Jun 2012 21:10:48 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <20120607200731.Horde.xzrpWHwdC4BP0O3jZ46SyWA@webmail.minatec.grenoble-inp.fr>
X-Provags-ID: V02:K0:TLY+r/rzlkgABgi7DN5A3NJ4PuxtKkMBVr/esDneikl
 Kr7OdLbX3z6EDpkL/0VeNT/Nl8cMHVmSqEn2n1X1vpz44+1YBU
 VwMoeYmRJsmnv8owOUShdAj5yzcpang1DziHMjCSoiiXgZ4foh
 D09v55l3fiVOxwvLIi9q0V5lkvtlscyBq7orfKUsyjCLdjZNcW
 mpq23+2L1qgwtz5ePwE2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199440>

On 07.06.12 20:07, konglu@minatec.inpg.fr wrote:
> On which branch are you applying the patch ? It should works on
> branch master (it works for me) but it won't on branch "pu", as
> it has already been queued.
>
> Lucien Kong
>
Thanks, now the patch applies on master.
But it seems that the problem is still there:
================
[snip]
ok 55 - prepare for rebase -i --exec

expecting success:
    git rebase -i --exec "git show HEAD" HEAD~2 >actual &&
    (
        FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
        export FAKE_LINES &&
        git rebase -i HEAD~2 >expected
    ) &&
    sed 1,9d expected >expect &&
    mv expect expected &&
    test_cmp expected actual

sed: 1: "/^pick .*/i\exec  git s ...": extra characters after \ at the end of i command
Successfully rebased and updated refs/heads/execute.
Successfully rebased and updated refs/heads/execute.
--- expected    2012-06-07 19:07:51.000000000 +0000
+++ actual    2012-06-07 19:07:50.000000000 +0000
@@ -1,18 +1,4 @@
-Rebasing (2/4)
Executing: git show HEAD
-commit 8f99a4f1fbbd214b25a070ad34ec5a8f833522cc
-Author: A U Thor <author@example.com>
-Date:   Thu Apr 7 15:17:13 2005 -0700
-
-    E
-
-diff --git a/file3 b/file3
-new file mode 100644
-index 0000000..1c50726
---- /dev/null
-+++ b/file3
-@@ -0,0 +1 @@
-+E
-Rebasing (3/4)
Rebasing (4/4)
Executing: git show HEAD
+Rebasing (1/1)
Executing: git show HEAD
 commit 925b01e149bd188d43f972ad86d1e4d6611c8fa0
 Author: A U Thor <author@example.com>
 Date:   Thu Apr 7 16:10:13 2005 -0700
not ok - 56 running "git rebase -i --exec git show HEAD"
[snip]
