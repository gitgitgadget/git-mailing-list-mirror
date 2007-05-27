From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Fix git-svn to handle svn not reporting the md5sum of
 a file, and test.
Date: Sun, 27 May 2007 15:28:08 -0400
Message-ID: <4659DBC8.2000105@gmail.com>
References: <1179981426176-git-send-email-foom@fuhm.net> <4659703B.8070101@gmail.com> <20070527172351.GA27309@muzzle>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: James Y Knight <foom@fuhm.net>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 27 21:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsOPj-0002WN-N1
	for gcvg-git@gmane.org; Sun, 27 May 2007 21:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbXE0T2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 15:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753571AbXE0T2T
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 15:28:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:41887 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbXE0T2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 15:28:18 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1060358wxc
        for <git@vger.kernel.org>; Sun, 27 May 2007 12:28:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SqPZdF6K36xLvAVzQ8Ynb4zpimpE/eNSu66PWTAipVjq0xnXu1vNkPOSDbQR5HTxqBbDa4B1svpRSsd2auHKQuy9agH6Nd87TXnS12tg0aWsItAGqDEVeCytU40l7uppDFTQkCJwg5Z1L5PIddhAGnFKm4GjhtoNEzMoj/Ql8G4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HnaVoo98SHezYNRk34Yh4TZLaDkETB3G8jeO8AwUu+GgdVZuuS1JPQ/bV5Ma1jaGLUdSLGBtV/NpSl4pD0OorAgU5E/xSk56sJRUpFfKsxDUQUHQrWw+tZ3RZiHFFzvwgzaUPTxr53ojyNmAUJWqi9LpHOr0HKu5wRERSHqnyk8=
Received: by 10.70.117.1 with SMTP id p1mr7242798wxc.1180294098169;
        Sun, 27 May 2007 12:28:18 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id i17sm6383187wxd.2007.05.27.12.28.11;
        Sun, 27 May 2007 12:28:11 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20070527172351.GA27309@muzzle>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48572>

Eric Wong wrote:
 > A Large Angry SCM <gitzilla@gmail.com> wrote:
 >> James Y Knight wrote:
 >>> ---
 >>> git-svn.perl                    |    2 +-
 >>> t/t9112-git-svn-md5less-file.sh |   45
 >>> +++++++++++++++++++++++++++++++++++++++
 >>> 2 files changed, 46 insertions(+), 1 deletions(-)
 >>> create mode 100755 t/t9112-git-svn-md5less-file.sh
 >> [...]
 >>
 >> The new test fails here (Suse 9.3 fully patched) w/ the following:
 >>
 >> *** t9112-git-svn-md5less-file.sh ***
 >> *   ok 1: load svn dumpfile
 >> *   ok 2: initialize git-svn
 >> * FAIL 3: fetch revisions from svn
 >>         git-svn fetch
 >> * failed 1 among 3 test(s)
 >> make[1]: *** [t9112-git-svn-md5less-file.sh] Error 1
 >
 > I can't reproduce it here (on Debian Etch, SVN 1.4.2).  Can you run with
 > the test with the -v switch?  Thanks.
 >


~/GIT/git/t> sh ./t9112-git-svn-md5less-file.sh -v
* expecting success: svnadmin load /home/test/GIT/git/t/trash/svnrepo < 
dumpfile.svn
<<< Started new transaction, based on original revision 1
      * adding path : md5less-file ... done.

------- Committed revision 1 >>>

*   ok 1: load svn dumpfile

* expecting success: git-svn init file:///home/test/GIT/git/t/trash/svnrepo
*   ok 2: initialize git-svn

* expecting success: git-svn fetch
./test-lib.sh: line 141:  8163 Segmentation fault      git-svn fetch
* FAIL 3: fetch revisions from svn
         git-svn fetch

* failed 1 among 3 test(s)
~/GIT/git/t>


And here is the failing part of the test using sh -x:

+ test_expect_success 'fetch revisions from svn' 'git-svn fetch'
+ test 2 = 2
+ test_skip 'fetch revisions from svn' 'git-svn fetch'
++ expr ././t9112-git-svn-md5less-file.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t9112
++ expr 2 + 1
+ this_test=t9112.3
+ to_skip=
+ case "$to_skip" in
+ false
+ say 'expecting success: git-svn fetch'
+ echo '* expecting success: git-svn fetch'
* expecting success: git-svn fetch
+ test_run_ 'git-svn fetch'
+ eval 'git-svn fetch'
++ git-svn fetch
./test-lib.sh: line 141:  8276 Segmentation fault      git-svn fetch
+ eval_ret=139
+ return 0
+ '[' 0 = 0 -a 139 = 0 ']'
+ test_failure_ 'fetch revisions from svn' 'git-svn fetch'
++ expr 2 + 1
+ test_count=3
++ expr 0 + 1
+ test_failure=1
+ say 'FAIL 3: fetch revisions from svn'
+ echo '* FAIL 3: fetch revisions from svn'
* FAIL 3: fetch revisions from svn
+ shift
+ echo 'git-svn fetch'
+ sed -e 's/^/  /'
         git-svn fetch
+ test '' = ''
+ echo ''

This began after the 18bece4..99b5a79 update to master. Prior to that 
the svn tests were passing.
