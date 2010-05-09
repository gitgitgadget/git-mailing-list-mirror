From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/8] Documentation/notes: clean up description of rewriting
 configuration
Date: Sat, 8 May 2010 22:33:28 -0500
Message-ID: <20100509033327.GG7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Leif Arne Storset <lstorset@opera.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:32:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxFo-0004CN-TP
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab0EIDcZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 23:32:25 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41505 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0EIDcY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:32:24 -0400
Received: by gyg13 with SMTP id 13so1365454gyg.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9hTmAvvxYYDUrBnqgQ7YuaunHJ9bG3aI103GOKuwt6E=;
        b=GI7fLH5hNkk7ePOPpgTIpJ6RB6F1gIk2N8Q1jx3WsFXCGuwRnbTYSYSlGn2F5Hkhpr
         AOUpxgD93GN8bqbjQqIc3axI2dAE93IAmgBJMTTQecY2nrf1FORqZgnpoAPkziIQU6tV
         zy7IqCHCCNFj/D9ke0GeuA3+PhjXW9CH9ZaGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A5bhcX59bJEWvgOXgkgdPmTK4JRrGfIUYJ/8lHJ7jkjwW+koH6jISzb/olTfjBJaBq
         LWy5Q5E6ZKoLVvA0ZiJjBSEbRs4k9MvSOtW+HIwkGLakFZStpw3BZQmJHjQzTlGg1ydr
         aHupvSQW1NBmbQnaQUk1ovhhQ3wRjTD6UrmPI=
Received: by 10.151.3.3 with SMTP id f3mr6949809ybi.117.1273375943905;
        Sat, 08 May 2010 20:32:23 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2564845yxe.10.2010.05.08.20.32.22
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:32:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146698>

Clarify that the GIT_NOTES_REWRITE_REFS environment variable
overrides both =E2=80=98[notes "rewrite"] <command>=E2=80=99 and =E2=80=
=98[notes] rewriteRef=E2=80=99.

Add explanations of GIT_NOTES_REWRITE_MODE and GIT_NOTES_REWRITE_REFS
to the ENVIRONMENT section.

Cc: Leif Arne Storset <lstorset@opera.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |   47 ++++++++++++++++++++++++++---------=
-------
 1 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 7856b28..d868535 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -38,9 +38,8 @@ message, after an unindented line saying "Notes (<ref=
name>):" (or
 To change which notes are shown by 'git log', see the
 "notes.displayRef" configuration in linkgit:git-log[1].
=20
-See the description of "notes.rewrite.<command>" in
-linkgit:git-config[1] for a way of carrying your notes across commands
-that rewrite commits.
+See the "notes.rewrite.<command>" configuration for a way to carry
+notes across commands that rewrite commits.
=20
=20
 SUBCOMMANDS
@@ -206,33 +205,31 @@ notes.displayRef::
=20
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	`rebase`), if this variable is `false`, git will not copy
+	notes from the original to the rewritten commit.  Defaults to
+	`true`.  See also "`notes.rewriteRef`" below.
++
+This setting can be overridden by the 'GIT_NOTES_REWRITE_REF'
+environment variable.
=20
 notes.rewriteMode::
-	When copying notes during a rewrite (see the
-	"notes.rewrite.<command>" option), determines what to do if
-	the target commit already has a note.  Must be one of
-	`overwrite`, `concatenate`, or `ignore`.  Defaults to
-	`concatenate`.
+	When copying notes during a rewrite, what to do if the target
+	commit already has a note.  Must be one of `overwrite`,
+	`concatenate`, and `ignore`.  Defaults to `concatenate`.
 +
 This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
 environment variable.
=20
 notes.rewriteRef::
 	When copying notes during a rewrite, specifies the (fully
-	qualified) ref whose notes should be copied.  The ref may be a
-	glob, in which case notes in all matching refs will be copied.
-	You may also specify this configuration several times.
+	qualified) ref whose notes should be copied.  May be a glob,
+	in which case notes in all matching refs will be copied.  You
+	may also specify this configuration several times.
 +
 Does not have a default value; you must configure this variable to
 enable note rewriting.
 +
-This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
+Can be overridden with the 'GIT_NOTES_REWRITE_REF' environment variabl=
e.
=20
=20
 ENVIRONMENT
@@ -252,6 +249,20 @@ ENVIRONMENT
 A warning will be issued for refs that do not exist, but a glob that
 does not match any refs is silently ignored.
=20
+'GIT_NOTES_REWRITE_MODE'::
+	When copying notes during a rewrite, what to do if the target
+	commit already has a note.
+	Must be one of `overwrite`, `concatenate`, and `ignore`.
+	This overrides the `core.rewriteMode` setting.
+
+'GIT_NOTES_REWRITE_REF'::
+	When rewriting commits, which notes to copy from the original
+	to the rewritten commit.  Must be a colon-delimited list of
+	refs or globs.
++
+If not set in the environment, the list of notes to copy depends
+on the `notes.rewrite.<command>` and `notes.rewriteRef` settings.
+
=20
 Author
 ------
--=20
1.7.1
