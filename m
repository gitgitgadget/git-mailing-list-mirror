From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: [PATCH 1/2] Partition SubmittingPatches doc into two files
Date: Thu, 14 Apr 2016 22:12:29 +0000
Message-ID: <0102015416d52ae9-da060607-a742-4efc-8b40-98301c2bb261-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqpVD-0007x0-4a
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 00:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbcDNWMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 18:12:34 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:37752
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752063AbcDNWMc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2016 18:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460671949;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=hUExdqtCZ9nV1l2IArz1GXtGCGmH6817MbsYQfJXIVA=;
	b=OoM+E4lBTbNKDOXyQbdK4J2OZsAWYXBsFYPle16Ltvg5UqcDTQ56LJyAhKmq2IzF
	aiXdia23tfz/5LQ1awjjqVuWE9CQJgIHKc02DYbPe2BiYpuqokpA4OCLTtcyvUalmJ4
	y7mQVfbYx53xIZbHOTvuH1KA3Sxme3kE6ZUFGjZQ=
X-SES-Outgoing: 2016.04.14-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291569>

No editorial changes in this commit, the text that is transferred into the
second file is unchanged apart from minor chunk re-ordering.

The split is based on:

* Information needed for all users, whether using `git send-email` or
  submitGit (ie good commit practice, mailing list etiquette)
* Information needed just for `git send-email`/MUA users (generating the
  right kind of diff, avoid MIME & PGP, send-email & MUA specific hints)
---
 Documentation/SubmittingPatches      | 137 ---------------------------------
 Documentation/SubmittingPatchesByMUA | 142 +++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/SubmittingPatchesByMUA

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 98fc4cc..6dca41d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -119,11 +119,6 @@ archive, summarize the relevant points of the discussion.
 
 (3) Generate your patch using Git tools out of your commits.
 
-Git based diff tools generate unidiff which is the preferred format.
-
-You do not have to be afraid to use -M option to "git diff" or
-"git format-patch", if your patch involves file renames.  The
-receiving end can handle them just fine.
 
 Please make sure your patch does not add commented out debugging code,
 or include any extra files which do not relate to what your patch
@@ -136,11 +131,6 @@ that is fine, but please mark it as such.
 
 (4) Sending your patches.
 
-Learn to use format-patch and send-email if possible.  These commands
-are optimized for the workflow of sending patches, avoiding many ways
-your existing e-mail client that is optimized for "multipart/*" mime
-type e-mails to corrupt and render your patches unusable.
-
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
 a developer to be able to "quote" your changes, using standard
@@ -148,18 +138,8 @@ e-mail tools, so that they may comment on specific portions of
 your code.  For this reason, each patch should be submitted
 "inline" in a separate message.
 
-Multiple related patches should be grouped into their own e-mail
-thread to help readers find all parts of the series.  To that end,
-send them as replies to either an additional "cover letter" message
-(see below), the first patch, or the respective preceding patch.
 
-If your log message (including your name on the
-Signed-off-by line) is not writable in ASCII, make sure that
-you send off a message in the correct encoding.
 
-WARNING: Be wary of your MUAs word-wrap
-corrupting your patch.  Do not cut-n-paste your patch; you can
-lose tabs that way if you are not careful.
 
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
@@ -187,31 +167,6 @@ an explanation of changes between each iteration can be kept in
 Git-notes and inserted automatically following the three-dash
 line via `git format-patch --notes`.
 
-Do not attach the patch as a MIME attachment, compressed or not.
-Do not let your e-mail client send quoted-printable.  Do not let
-your e-mail client send format=flowed which would destroy
-whitespaces in your patches. Many
-popular e-mail applications will not always transmit a MIME
-attachment as plain text, making it impossible to comment on
-your code.  A MIME attachment also takes a bit more time to
-process.  This does not decrease the likelihood of your
-MIME-attached change being accepted, but it makes it more likely
-that it will be postponed.
-
-Exception:  If your mailer is mangling patches then someone may ask
-you to re-send them using MIME, that is OK.
-
-Do not PGP sign your patch, at least for now.  Most likely, your
-maintainer or other people on the list would not have your PGP
-key and would not bother obtaining it anyway.  Your patch is not
-judged by who you are; a good patch from an unknown origin has a
-far better chance of being accepted than a patch from a known,
-respected origin that is done poorly or does incorrect things.
-
-If you really really really really want to do a PGP signed
-patch, format it as "multipart/signed", not a text/plain message
-that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
-not a text/plain, it's something else.
 
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the output from
@@ -370,95 +325,3 @@ Know the status of your patch after submission
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
-------------------------------------------------
-MUA specific hints
-
-Some of patches I receive or pick up from the list share common
-patterns of breakage.  Please make sure your MUA is set up
-properly not to corrupt whitespaces.
-
-See the DISCUSSION section of git-format-patch(1) for hints on
-checking your patch by mailing it to yourself and applying with
-git-am(1).
-
-While you are at it, check the resulting commit log message from
-a trial run of applying the patch.  If what is in the resulting
-commit is not exactly what you would want to see, it is very
-likely that your maintainer would end up hand editing the log
-message when he applies your patch.  Things like "Hi, this is my
-first patch.\n", if you really want to put in the patch e-mail,
-should come after the three-dash line that signals the end of the
-commit message.
-
-
-Pine
-----
-
-(Johannes Schindelin)
-
-I don't know how many people still use pine, but for those poor
-souls it may be good to mention that the quell-flowed-text is
-needed for recent versions.
-
-... the "no-strip-whitespace-before-send" option, too. AFAIK it
-was introduced in 4.60.
-
-(Linus Torvalds)
-
-And 4.58 needs at least this.
-
----
-diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
-Author: Linus Torvalds <torvalds@g5.osdl.org>
-Date:   Mon Aug 15 17:23:51 2005 -0700
-
-    Fix pine whitespace-corruption bug
-
-    There's no excuse for unconditionally removing whitespace from
-    the pico buffers on close.
-
-diff --git a/pico/pico.c b/pico/pico.c
---- a/pico/pico.c
-+++ b/pico/pico.c
-@@ -219,7 +219,9 @@ PICO *pm;
-	    switch(pico_all_done){	/* prepare for/handle final events */
-	      case COMP_EXIT :		/* already confirmed */
-		packheader();
-+#if 0
-		stripwhitespace();
-+#endif
-		c |= COMP_EXIT;
-		break;
-
-
-(Daniel Barkalow)
-
-> A patch to SubmittingPatches, MUA specific help section for
-> users of Pine 4.63 would be very much appreciated.
-
-Ah, it looks like a recent version changed the default behavior to do the
-right thing, and inverted the sense of the configuration option. (Either
-that or Gentoo did it.) So you need to set the
-"no-strip-whitespace-before-send" option, unless the option you have is
-"strip-whitespace-before-send", in which case you should avoid checking
-it.
-
-
-Thunderbird, KMail, GMail
--------------------------
-
-See the MUA-SPECIFIC HINTS section of git-format-patch(1).
-
-Gnus
-----
-
-'|' in the *Summary* buffer can be used to pipe the current
-message to an external program, and this is a handy way to drive
-"git am".  However, if the message is MIME encoded, what is
-piped into the program is the representation you see in your
-*Article* buffer after unwrapping MIME.  This is often not what
-you would want for two reasons.  It tends to screw up non ASCII
-characters (most notably in people's names), and also
-whitespaces (fatal in patches).  Running 'C-u g' to display the
-message in raw form before using '|' to run the pipe can work
-this problem around.
diff --git a/Documentation/SubmittingPatchesByMUA b/Documentation/SubmittingPatchesByMUA
new file mode 100644
index 0000000..b3ffbc0
--- /dev/null
+++ b/Documentation/SubmittingPatchesByMUA
@@ -0,0 +1,142 @@
+Learn to use format-patch and send-email if possible.  These commands
+are optimized for the workflow of sending patches, avoiding many ways
+your existing e-mail client that is optimized for "multipart/*" mime
+type e-mails to corrupt and render your patches unusable.
+
+Git based diff tools generate unidiff which is the preferred format.
+
+You do not have to be afraid to use -M option to "git diff" or
+"git format-patch", if your patch involves file renames.  The
+receiving end can handle them just fine.
+
+Multiple related patches should be grouped into their own e-mail
+thread to help readers find all parts of the series.  To that end,
+send them as replies to either an additional "cover letter" message
+(see below), the first patch, or the respective preceding patch.
+
+If your log message (including your name on the
+Signed-off-by line) is not writable in ASCII, make sure that
+you send off a message in the correct encoding.
+
+WARNING: Be wary of your MUAs word-wrap
+corrupting your patch.  Do not cut-n-paste your patch; you can
+lose tabs that way if you are not careful.
+
+Do not attach the patch as a MIME attachment, compressed or not.
+Do not let your e-mail client send quoted-printable.  Do not let
+your e-mail client send format=flowed which would destroy
+whitespaces in your patches. Many
+popular e-mail applications will not always transmit a MIME
+attachment as plain text, making it impossible to comment on
+your code.  A MIME attachment also takes a bit more time to
+process.  This does not decrease the likelihood of your
+MIME-attached change being accepted, but it makes it more likely
+that it will be postponed.
+
+Exception:  If your mailer is mangling patches then someone may ask
+you to re-send them using MIME, that is OK.
+
+Do not PGP sign your patch, at least for now.  Most likely, your
+maintainer or other people on the list would not have your PGP
+key and would not bother obtaining it anyway.  Your patch is not
+judged by who you are; a good patch from an unknown origin has a
+far better chance of being accepted than a patch from a known,
+respected origin that is done poorly or does incorrect things.
+
+If you really really really really want to do a PGP signed
+patch, format it as "multipart/signed", not a text/plain message
+that starts with '-----BEGIN PGP SIGNED MESSAGE-----'.  That is
+not a text/plain, it's something else.
+
+------------------------------------------------
+MUA specific hints
+
+Some of patches I receive or pick up from the list share common
+patterns of breakage.  Please make sure your MUA is set up
+properly not to corrupt whitespaces.
+
+See the DISCUSSION section of git-format-patch(1) for hints on
+checking your patch by mailing it to yourself and applying with
+git-am(1).
+
+While you are at it, check the resulting commit log message from
+a trial run of applying the patch.  If what is in the resulting
+commit is not exactly what you would want to see, it is very
+likely that your maintainer would end up hand editing the log
+message when he applies your patch.  Things like "Hi, this is my
+first patch.\n", if you really want to put in the patch e-mail,
+should come after the three-dash line that signals the end of the
+commit message.
+
+
+Pine
+----
+
+(Johannes Schindelin)
+
+I don't know how many people still use pine, but for those poor
+souls it may be good to mention that the quell-flowed-text is
+needed for recent versions.
+
+... the "no-strip-whitespace-before-send" option, too. AFAIK it
+was introduced in 4.60.
+
+(Linus Torvalds)
+
+And 4.58 needs at least this.
+
+---
+diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
+Author: Linus Torvalds <torvalds@g5.osdl.org>
+Date:   Mon Aug 15 17:23:51 2005 -0700
+
+    Fix pine whitespace-corruption bug
+
+    There's no excuse for unconditionally removing whitespace from
+    the pico buffers on close.
+
+diff --git a/pico/pico.c b/pico/pico.c
+--- a/pico/pico.c
++++ b/pico/pico.c
+@@ -219,7 +219,9 @@ PICO *pm;
+	    switch(pico_all_done){	/* prepare for/handle final events */
+	      case COMP_EXIT :		/* already confirmed */
+		packheader();
++#if 0
+		stripwhitespace();
++#endif
+		c |= COMP_EXIT;
+		break;
+
+
+(Daniel Barkalow)
+
+> A patch to SubmittingPatches, MUA specific help section for
+> users of Pine 4.63 would be very much appreciated.
+
+Ah, it looks like a recent version changed the default behavior to do the
+right thing, and inverted the sense of the configuration option. (Either
+that or Gentoo did it.) So you need to set the
+"no-strip-whitespace-before-send" option, unless the option you have is
+"strip-whitespace-before-send", in which case you should avoid checking
+it.
+
+
+Thunderbird, KMail, GMail
+-------------------------
+
+See the MUA-SPECIFIC HINTS section of git-format-patch(1).
+
+Gnus
+----
+
+'|' in the *Summary* buffer can be used to pipe the current
+message to an external program, and this is a handy way to drive
+"git am".  However, if the message is MIME encoded, what is
+piped into the program is the representation you see in your
+*Article* buffer after unwrapping MIME.  This is often not what
+you would want for two reasons.  It tends to screw up non ASCII
+characters (most notably in people's names), and also
+whitespaces (fatal in patches).  Running 'C-u g' to display the
+message in raw form before using '|' to run the pipe can work
+this problem around.

--
https://github.com/git/git/pull/223
