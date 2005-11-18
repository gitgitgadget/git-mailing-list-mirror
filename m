From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 19:49:43 -0800
Message-ID: <437D4F57.9070303@gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>	<b0943d9e0511160311k725526d8v@mail.gmail.com>	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com> <7vfypur5jb.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Benes <smartcat99s@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 04:51:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcxG3-0004db-0F
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 04:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVKRDtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 22:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVKRDtr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 22:49:47 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:55056 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932426AbVKRDtr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 22:49:47 -0500
Received: by xproxy.gmail.com with SMTP id s14so98639wxc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 19:49:46 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=b/UCrJkLO0wm3OH5YcyOhdrUXTZ5knea78eAqnM+eBg8Gu5m3K+jNt792vbJJWCkzdngVMFypOH+awhcPupostfqrv35XajQeEBPSPC4QLgLkllLkIFbryH1zOeAh09u0DLOYUkfSWMoni3JXJztTGj7BLkSXgGQZelNvwcyGOo=
Received: by 10.70.42.19 with SMTP id p19mr5947492wxp;
        Thu, 17 Nov 2005 19:49:46 -0800 (PST)
Received: from ?10.0.0.6? ( [70.32.120.109])
        by mx.gmail.com with ESMTP id i10sm449744wxd.2005.11.17.19.49.45;
        Thu, 17 Nov 2005 19:49:46 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfypur5jb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12190>

Junio C Hamano wrote:
> John Benes <smartcat99s@gmail.com> writes:
> 
>>Junio C Hamano wrote:
>>
>>I was able to compile master and pu on Cygwin without NO_MMAP=YesPlease
>>in the Cygwin section.  However, the make test failed on the
>>binary-apply on both master and pu, output follows.
>>
>>Commit ID's used for testing:
>>refs/heads/master	4e1da85d7d0480b6d9973317da4f7a5aa603fcb5
>>refs/heads/pu		3b4587eb3c549649af7e84659b4808003c34c2d3
> 
> Thanks.  But the test result look suspicious for pu.
> 
> 	$ git-ls-tree 3b4587eb t | grep t4103
> 
> outputs empty, so what you tested does not seem to be that
> commit.
> 
> Anyway, the master is more important at this point.
> 
>>make test barfing on master:
>>*** t4103-apply-binary.sh ***
>>* FAIL 7: check binary diff with replacement.
>>        git-checkout master
>>                 git-apply --check --allow-binary-replacement BF.diff
>>* FAIL 8: check binary diff with replacement (copy).
>>        git-checkout master
>>                 git-apply --check --allow-binary-replacement CF.diff
>>* FAIL 15: apply binary diff.
>>        do_reset
>>                 git-apply --allow-binary-replacement --index BF.diff &&
>>                 test -z "$(git-diff --name-status binary)"
>>* FAIL 16: apply binary diff (copy).
>>        do_reset
>>                 git-apply --allow-binary-replacement --index CF.diff &&
>>                 test -z "$(git-diff --name-status binary)"
>>* failed 4 among 16 test(s)
>>make[1]: *** [t4103-apply-binary.sh] Error 1
> 
> So it fails on these binary diffs with full index tests.  Could
> you try running it like this?
> 
> 	$ cd t
>         $ sh ./t4103-apply-binary.sh -i -v
> 
> If all things being equal, this will stop at the first failing
> test "* FAIL 7: ", and you will have trash/ directory under t/.
> 
> 	$ cd trash
> 	$ ls -l
> 
> I would first want to see if it was diff that failed or the
> apply.  What does BF.diff contain?
> 

OK, here's what I get:

 > sh ./t4103-apply-binary.sh -i -v
* expecting success: git-checkout master
          git-apply --stat --summary B.diff
  file1 |    4 ++--
  file2 |    5 -----
  file3 |    0
  file4 |    0
  4 files changed, 2 insertions(+), 7 deletions(-)
  delete mode 100644 file2
  create mode 100644 file3
*   ok 1: stat binary diff -- should not fail.
* expecting success: git-checkout master
          git-apply --stat --summary C.diff
  file1 |    4 ++--
  file2 |    5 -----
  file3 |    0
  file4 |    0
  4 files changed, 2 insertions(+), 7 deletions(-)
  delete mode 100644 file2
  copy file1 => file3 (70%)
*   ok 2: stat binary diff (copy) -- should not fail.
* expecting failure: git-checkout master
          git-apply --check B.diff
fatal: patch with only garbage at line 30
*   ok 3: check binary diff -- should fail.
* expecting failure: git-checkout master
          git-apply --check C.diff
fatal: patch with only garbage at line 32
*   ok 4: check binary diff (copy) -- should fail.
* expecting failure: git-checkout master
          git-apply --check --allow-binary-replacement B.diff
fatal: patch with only garbage at line 30
*   ok 5: check incomplete binary diff with replacement -- should fail.
* expecting failure: git-checkout master
          git-apply --check --allow-binary-replacement C.diff
fatal: patch with only garbage at line 32
*   ok 6: check incomplete binary diff with replacement (copy) -- should 
fail.
* expecting success: git-checkout master
          git-apply --check --allow-binary-replacement BF.diff
fatal: patch with only garbage at line 30
* FAIL 7: check binary diff with replacement.
         git-checkout master
                  git-apply --check --allow-binary-replacement BF.diff
 > cd trash
internet@Gojira:~/GIT/git/t/trash> ls -l
total 28
-rw-r--r--  1 internet internet  909 2005-11-17 19:47 B.diff
-rw-r--r--  1 internet internet 1173 2005-11-17 19:47 BF.diff
-rw-r--r--  1 internet internet  944 2005-11-17 19:47 C.diff
-rw-r--r--  1 internet internet 1208 2005-11-17 19:47 CF.diff
-rw-r--r--  1 internet internet  201 2005-11-17 19:47 file1
-rw-r--r--  1 internet internet  201 2005-11-17 19:47 file2
-rw-r--r--  1 internet internet  201 2005-11-17 19:47 file4
 > cat BF.diff
diff --git a/file1 b/file1
index 
edc575dec543a684da5007b43886ee32ecb381ae..af1eedd35be991f3ced320f7d927799c72cd8435 
100644
--- a/file1
+++ b/file1
@@ -1,5 +1,5 @@
-A quick brown fox jumps over the lazy dog.
+A quick brown fov jumps over the lazy dog.
  A tiny little penguin runs around in circles.
-There is a flag with Linux written on it.
+There is a flag with Linuv written on it.
  A slow black-and-white panda just sits there,
  munching on his bamboo.
diff --git a/file2 b/file2
deleted file mode 100644
index 
edc575dec543a684da5007b43886ee32ecb381ae..0000000000000000000000000000000000000000
--- a/file2
+++ /dev/null
@@ -1,5 +0,0 @@
-A quick brown fox jumps over the lazy dog.
-A tiny little penguin runs around in circles.
-There is a flag with Linux written on it.
-A slow black-and-white panda just sits there,
-munching on his bamboo.
diff --git a/file3 b/file3
new file mode 100644
index 
0000000000000000000000000000000000000000..adb07b7ad3fa2c63251b06d1d39cb90a85b860b4
Files /dev/null and b/file3 differ
diff --git a/file4 b/file4
index 
edc575dec543a684da5007b43886ee32ecb381ae..adb07b7ad3fa2c63251b06d1d39cb90a85b860b4 
100644
Files a/file4 and b/file4 differ
