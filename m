From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
Date: Fri, 16 Jan 2015 10:32:09 -0800
Message-ID: <xmqqfvba37bq.fsf@gitster.dls.corp.google.com>
References: <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<20150116013256.GA25894@peff.net>
	<BEFF558C-774D-4891-96A0-BE962F8070E7@gmail.com>
	<20150116033445.GA29572@peff.net> <20150116091648.GA2450@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,  msysgit@googlegroups.com,  Torsten
 =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,  Git Mailing List
 <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCG77UMM3EJRBLFS4WSQKGQERUNCTLQ@googlegroups.com Fri Jan 16 19:32:14 2015
Return-path: <msysgit+bncBCG77UMM3EJRBLFS4WSQKGQERUNCTLQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f56.google.com ([209.85.220.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBLFS4WSQKGQERUNCTLQ@googlegroups.com>)
	id 1YCBgs-0007r0-72
	for gcvm-msysgit@m.gmane.org; Fri, 16 Jan 2015 19:32:14 +0100
Received: by mail-pa0-f56.google.com with SMTP id et14sf2996836pad.1
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Jan 2015 10:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=S8429JmVfiaqdEHEZi5Qu1+qsUuTVHRTMccJK8ezQzI=;
        b=O8hCubVXppQ5qOCdVwe3IpEM8p7S+Ai/Q1PfhoR+8Ns/rEzFOAC7jJrh5S6Zi4s7cp
         +zJgkj2ALYV7pelAyN8CTDx6GxJ3mgThS/+HOIU4+dlHV4Q70ZRC8ajaQAubHJ7nYIlb
         XC9sebyKRB/UYcNXNOrNSz5AmhgPs8B4PMvBabaZZgqore/kBw6ox76eWBpJKRo7HUBw
         7vrxA2dnxfiYGIrMXY9UzcHtZpW2AnrT8XZi7nD6TERWEexQ4zGpUJTrvbXc19eiAMgg
         ABCLkVEtOT0xeRI+WVW6wTAPHQSDZNp+Tp+9C4uhlICTCutqw+kcf7ITpLpViKparpLt
         LjZg==
X-Received: by 10.50.118.42 with SMTP id kj10mr77207igb.9.1421433133385;
        Fri, 16 Jan 2015 10:32:13 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.12.217 with SMTP id 86ls71721iom.4.gmail; Fri, 16 Jan 2015
 10:32:12 -0800 (PST)
X-Received: by 10.66.131.102 with SMTP id ol6mr13142682pab.37.1421433132492;
        Fri, 16 Jan 2015 10:32:12 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id e4si629458qcq.3.2015.01.16.10.32.12
        for <msysgit@googlegroups.com>;
        Fri, 16 Jan 2015 10:32:12 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C70D630720;
	Fri, 16 Jan 2015 13:32:11 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD47B3071F;
	Fri, 16 Jan 2015 13:32:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 148783071D;
	Fri, 16 Jan 2015 13:32:11 -0500 (EST)
In-Reply-To: <20150116091648.GA2450@peff.net> (Jeff King's message of "Fri, 16
	Jan 2015 04:16:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FC03BFB4-9DAD-11E4-AFB0-42529F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262554>

Jeff King <peff@peff.net> writes:

> So here's a re-roll with `id -u`, as that may be the simplest way to get
> people to test (with the patch applied, running t5550 as a normal user
> should work, and as root should skip the tests).
>
> -- >8 --
> Subject: [PATCH] t/lib-httpd: switch SANITY check for NOT_ROOT
>
> The SANITY prerequisite is really about whether the
> filesystem will respect the permissions we set, and being
> root is only one part of that....

I checked the use of POSIXPERM that is not tied to SANITY and found
a few questionable ones (this is orthogonal from the earlier list of
glitches I mentioned, which is SANITY without POSIXPERM).

I think we will later make SANITY to require NOT_ROOT and POSIXPERM,
at which point many existing tests that require POSIXPERM,SANITY can
be simplified to require only SANITY, but that will be a follow-up
change to this fix.

-- >8 --
Subject: tests: correct misuses of POSIXPERM

POSIXPERM requires that a later call to stat(2) (hence "ls -l")
faithfully reproduces what an earlier chmod(2) did.  Some
filesystems cannot satisify this.

SANITY requires that a file or a directory is indeed accessible (or
inaccessible) when its permission bits would say it ought to be
accessible (or inaccessible).  Running tests as root would lose this
prerequisite for obvious reasons.

Fix a few tests that misuse POSIXPERM.

t0061-run-command.sh has two uses of POSIXPERM.

 - One checks that an attempt to execute a file that is marked as
   unexecutable results in a failure with EACCES; I do not think
   having root-ness or any other capability that busts the
   filesystem permission mode bits will make you run an unexecutable
   file, so this should be left as-is.  The test does not have
   anything to do with SANITY.

 - The other one expects 'git nitfol' runs the alias when an
   alias.nitfol is defined and a directory on the PATH is marked as
   unreadable and unsearchable.  I _think_ the test tries to reject
   the alternative expectation that we want to refuse to run the
   alias because it would break "no alias may mask a command" rule
   if a file 'git-nitfol' exists in the unreadable directory but we
   cannot even determine if that is the case.  Under !SANITY that
   busts the permission bits, this test no longer checks that, so it
   must be protected with SANITY.

t1509-root-worktree.sh expects to be run on a / that is writable by
the user and sees if Git behaves "sensibly" when /.git is the
repository to govern a worktree that is the whole filesystem, and
also if Git behaves "sensibly" when / itself is a bare repository
with refs, objects, and friends (I find the definition of "behaves
sensibly" under these conditions hard to fathom, but it is a
different matter).

The implementation of the test is very much problematic.

 - It requires POSIXPERM, but it does not do chmod or checks modes
   in any way.

 - It runs "rm /*" and "rm -fr /refs /objects ..." in one of the
   tests, and also does "cd / && git init --bare".  If done on a
   live system that takes advantages of the "feature" being tested,
   these obviously will clobber the system.  But there is no guard
   against such a breakage.

 - It uses "test $UID = 0" to see rootness, which now should be
   spelled "! test_have_prereq NOT_ROOT"

 t/t0061-run-command.sh   |  2 +-
 t/t1509-root-worktree.sh | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t0061-run-command.sh b/t/t0061-run-command.sh
index 17e969d..9acf628 100755
--- a/t/t0061-run-command.sh
+++ b/t/t0061-run-command.sh
@@ -34,7 +34,7 @@ test_expect_success POSIXPERM 'run_command reports EACCES' '
 	grep "fatal: cannot exec.*hello.sh" err
 '
 
-test_expect_success POSIXPERM 'unreadable directory in PATH' '
+test_expect_success POSIXPERM,SANITY 'unreadable directory in PATH' '
 	mkdir local-command &&
 	test_when_finished "chmod u+rwx local-command && rm -fr local-command" &&
 	git config alias.nitfol "!echo frotz" &&
diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index 335420f..b6977d4 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -98,8 +98,16 @@ test_foobar_foobar() {
 	'
 }
 
-if ! test_have_prereq POSIXPERM || ! [ -w / ]; then
-	skip_all="Dangerous test skipped. Read this test if you want to execute it"
+if ! test -w /
+then
+	skip_all="Test requiring writable / skipped. Read this test if you want to run it"
+	test_done
+fi
+
+if  test -e /refs || test -e /objects || test -e /info || test -e /hooks ||
+    test -e /.git || test -e /foo || test -e /me
+then
+	skip_all="Skip test that clobbers existing files in /"
 	test_done
 fi
 
@@ -108,8 +116,9 @@ if [ "$IKNOWWHATIAMDOING" != "YES" ]; then
 	test_done
 fi
 
-if [ "$UID" = 0 ]; then
-	skip_all="No you can't run this with root"
+if ! test_have_prereq NOT_ROOT
+then
+	skip_all="No you can't run this as root"
 	test_done
 fi
 

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
