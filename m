From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] Documentation/notes: simplify treatment of default
 notes ref
Date: Sat, 8 May 2010 22:23:58 -0500
Message-ID: <20100509032358.GD7958@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:23:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAx6a-0001n1-3D
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693Ab0EIDWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 23:22:55 -0400
Received: from mail-qy0-f195.google.com ([209.85.221.195]:44726 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab0EIDWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:22:54 -0400
Received: by qyk33 with SMTP id 33so4253673qyk.24
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=fzArIqY75wiHutig9vBsL3LZlzJIEC1UOJagD9pkGRU=;
        b=Z9bsyCOtZusTJpHYlXUr1h2IWY7Z45sk341SEQup2Lsz7a5LSe+5TFQp30jsqUW76m
         E6zeE9/U3aLpZs0Gj7+Y+Fy2WhoDRzsVmlDJxskvMekSzyio5glAG1w0B5BUHMTlWbbv
         xFEfamlxyAmwEayndagT0YUMoYhTdHS7kqyW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FzxT79KFS1nulALiOf/NLMwFH9+ky5XK2+QX+Mn2xo1boMdZ+XVeG2GU17ecSSEk/k
         ReZBnFf0Fl+kSBL7KOBAgS95CrhLpnVYb2D82UK0cEECVpNLnHeXwaOJatjhsPI9k/rS
         btFiHEr6aiSB2bf5eB9YM9K/HdpHoTH80EX4U=
Received: by 10.229.182.5 with SMTP id ca5mr1633244qcb.98.1273375373957;
        Sat, 08 May 2010 20:22:53 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x34sm2700136qce.15.2010.05.08.20.22.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:22:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509031357.GA7926@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146695>

Separate the documentation of the semantics, command-line option,
configuration item, and environment variable for the default notes
ref.  The documentation is easier to digest in bite-sized pieces.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f561457..28ac862 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -23,6 +23,11 @@ DESCRIPTION
 This command allows you to add/remove notes to/from objects, without
 changing the objects themselves.
 
+By default, notes are saved to and read from `refs/notes/commits`, but
+this default can be overridden.  See the OPTIONS, CONFIGURATION, and
+ENVIRONMENT sections below.  If this ref does not exist, it will be
+quietly created when it is first needed to store a note.
+
 A typical use of notes is to extend a commit message without having
 to change the commit itself. Such commit notes can be shown by `git log`
 along with the original commit message. To discern these notes from the
@@ -30,8 +35,6 @@ message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
 "Notes:" for `refs/notes/commits`).
 
-This command always manipulates the notes specified in "core.notesRef"
-(see linkgit:git-config[1]), which can be overridden by GIT_NOTES_REF.
 To change which notes are shown by 'git-log', see the
 "notes.displayRef" configuration.
 
@@ -122,8 +125,8 @@ OPTIONS
 	the user can further edit the note message.
 
 --ref <ref>::
-	Manipulate the notes tree in <ref>.  This overrides both
-	GIT_NOTES_REF and the "core.notesRef" configuration.  The ref
+	Manipulate the notes tree in <ref>.  This overrides
+	'GIT_NOTES_REF' and the "core.notesRef" configuration.  The ref
 	is taken to be in `refs/notes/` if it is not qualified.
 
 
@@ -187,13 +190,10 @@ CONFIGURATION
 -------------
 
 core.notesRef::
-	When showing commit messages, also show notes which are stored in
-	the given ref.  The ref must be fully qualified.  If the given
-	ref does not exist, it is not an error but means that no
-	notes should be printed.
-+
-This setting defaults to "refs/notes/commits", and it can be overridden by
-the 'GIT_NOTES_REF' environment variable.  See linkgit:git-notes[1].
+	Notes ref to read and manipulate instead of
+	`refs/notes/commits`.  Must be an unabbreviated ref name.
+	This setting can be overridden through the environment and
+	command line.
 
 notes.displayRef::
 	The (fully qualified) refname from which to show notes when
@@ -242,6 +242,15 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
 environment variable, which must be a colon separated list of refs or
 globs.
 
+
+ENVIRONMENT
+-----------
+
+'GIT_NOTES_REF'::
+	Which ref to manipulate notes from, instead of `refs/notes/commits`.
+	This overrides the `core.notesRef` setting.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
-- 
1.7.1
