From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] Documentation/notes: describe effect of environment
 and configuration
Date: Mon, 3 May 2010 18:41:40 -0500
Message-ID: <20100503234140.GA27483@progeny.tock>
References: <20100503233604.GA27451@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 01:41:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95GZ-0003eQ-II
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759760Ab0ECXlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 19:41:31 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48530 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab0ECXl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:41:29 -0400
Received: by ywh36 with SMTP id 36so1477280ywh.4
        for <git@vger.kernel.org>; Mon, 03 May 2010 16:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QMVK0xqwc8OCGUKnL3cHFbcqHMG8RsiUdWREyMz4tbI=;
        b=dnrxH1bJAqAwGg/CwdlMfN/P1IIW7W0q/T6Q7lN+kuRhg1ERSpW2cEuXQF8f4mzhNS
         qmrprBM74A49MRwZ2aIEtfcSANf0xncZaYGjbxUxT6v9SEjwEglshmha7Yvl7PW+K3ZS
         P877q8T1Pbafxrpgl8mrpclFmMs0e8+KuDOVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wc+huZtiACZ3q1xhpyH+7ka1gD8+h5HoZVE1c5V0+jC6N463kMEj01jBpA53PZneaz
         6EMuUtsglX3/qQbPq+h/Cz+kCktZxOpQRCH7xjZN+gae0Hl7po3Bk77aCUD5ZXzx7dRz
         OjwcmTH3zMe2i0JnivhSM+CO7Z5LzE8RxJZ6A=
Received: by 10.150.167.1 with SMTP id p1mr10047584ybe.25.1272930088446;
        Mon, 03 May 2010 16:41:28 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4707858iwn.9.2010.05.03.16.41.27
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 16:41:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100503233604.GA27451@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146270>

Based on the description from Documentation/config.txt.

For now, this does not share text with Documentation/config.txt
because that makes it easier to think about how to describe the
environment variables.

Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-notes.txt |   82 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 4e5113b..b26598e 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -135,6 +135,88 @@ usual rules (see linkgit:git-commit[1]).  These details may change in
 the future.
 
 
+CONFIGURATION
+-------------
+
+core.notesRef::
+	By default, 'git notes' and other commands read and manipulate
+	the notes referred to by `refs/notes/commits`.  This
+	configuration item allows one to specify an alternative
+	default ref (to be overridden by environment variables or
+	command-line options).
+
+notes.displayRef::
+	Which refs, in addition to the default set by `core.notesRef`
+	or 'GIT_NOTES_REF', for 'git log' to read notes from when
+	showing commit messages.  Can be a (fully qualified) ref name
+	or glob.  You may also specify this configuration variable
+	several times.
++
+This setting can be overridden with the 'GIT_NOTES_DISPLAY_REF'
+environment variable.
+
+notes.rewrite.<command>::
+	When rewriting commits with <command> (currently `amend` or
+	`rebase`), if this variable is `false`, git will not copy
+	notes from the original to the rewritten commit.  Defaults to
+	`true`.  See also "`notes.rewriteRef`" below.
++
+This setting can be overridden by the 'GIT_NOTES_REWRITE_REF'
+environment variable.
+
+notes.rewriteMode::
+	When copying notes during a rewrite, what to do if the target
+	commit already has a note.  Must be one of `overwrite`,
+	`concatenate`, or `ignore`.  Defaults to `concatenate`.
++
+This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
+environment variable.
+
+notes.rewriteRef::
+	When copying notes during a rewrite, specifies the (fully
+	qualified) ref whose notes should be copied.  May be a glob,
+	in which case notes in all matching refs will be copied.  You
+	may also specify this configuration several times.
++
+Does not have a default value.  Configure this variable to enable note
+rewriting.
++
+Can be overridden with the 'GIT_NOTES_REWRITE_REF' environment variable.
+
+See linkgit:git-config[1] for details.
+
+ENVIRONMENT
+-----------
+
+'GIT_NOTES_REF'::
+	Which ref to manipulate notes from, instead of `refs/notes/commits`.
+	This overrides the `core.notesRef` setting.
+
+'GIT_NOTES_DISPLAY_REF'::
+	Which refs, in addition to the default from `core.notesRef` or
+	'GIT_NOTES_REF', to read notes from when showing commit
+	messages.
+	Must be a colon-delimited list of refs or globs.
+	This overrides the `notes.displayRef` setting.
++
+A warning will be issued for refs that do not exist, but a glob that
+does not match any refs is silently ignored.
+
+'GIT_NOTES_REWRITE_MODE'::
+	When copying notes during a rewrite, what to do if the target
+	commit already has a note.
+	Must be one of `overwrite`, `concatenate`, or `ignore`.
+	This overrides the `core.rewriteMode` setting.
+
+'GIT_NOTES_REWRITE_REF'::
+	When rewriting commits, which notes to copy from the original
+	to the rewritten commit.  Must be a colon-delimited list of
+	refs or globs.
++
+If not set in the environment, the list of notes to copy will depend
+on the `notes.rewrite.<command>` and `notes.rewriteRef` settings.
+
+
 Author
 ------
 Written by Johannes Schindelin <johannes.schindelin@gmx.de> and
-- 
1.7.1
