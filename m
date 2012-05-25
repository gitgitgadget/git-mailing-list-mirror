From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Fri, 25 May 2012 11:03:14 -0700
Message-ID: <7v8vggt9y5.fsf@alter.siamese.dyndns.org>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <4FBC0019.6030702@in.waw.pl> <7v4nr72bim.fsf@alter.siamese.dyndns.org>
 <CAMP44s0aKi+8WHPXYLQ+iSMkj9iV88JGTabrpBRNBWb7upAMiQ@mail.gmail.com>
 <CAOnadRF8XyZKi+d=y1fFy2Xvs-3ETVyCbJBj83mK3Q8yuK7oQw@mail.gmail.com>
 <CAMP44s3uW75O_jt2F7POxTAhX+qPyRSjOX9-DuEkg7a7WtnLsA@mail.gmail.com>
 <4FBD5CC1.3060701@tedpavlic.com> <20120524203549.GA2052@goldbirke>
 <CAOnadRFbrhrFz7Ya3Vhgsju9G723Qu0OdJnM31xFmBqQNgj6gA@mail.gmail.com>
 <20120525073506.GD2052@goldbirke> <87ehq8its8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Ted Pavlic <ted@tedpavlic.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Dan McGee <dan@archlinux.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	<git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 25 20:03:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXyrD-0000Ri-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758123Ab2EYSDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:03:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38039 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030Ab2EYSDS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:03:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED8E38311;
	Fri, 25 May 2012 14:03:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ueGpW+dlJctEAfPxlNwl8mCm0aQ=; b=pPKgdU
	PL5bv2H4jPgU0pm9h9xRP/PRYey6ctrazpo8o0zgswiLiTA1vhqJJ2d770TotOhe
	w1WwF7Oj3kWEJKsqPA5nabI/iCMNn8nmMYqLa40x/ylDOFOSN6wYYP2G9JK32pcA
	MsK9kNS9fvVEB5Wy1LwpM2XjZANPMx6vOuNsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l4T6bIoYCUc9QDDdLc+h1prxzNQw+D6Y
	uisEdJw7CCa0Y6QA2ILBsDfT9NJk/NQuuVd/qD/GeQfKNOXePw6ViMHvQWE7XKL1
	0mE5DecDLzkbh7GAqdOZ7br8oAAEnvKp/gHwtneibg8/CNRwAPfTgwPEwyq81ScU
	hfde69chFRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E24D78310;
	Fri, 25 May 2012 14:03:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53108830E; Fri, 25 May 2012
 14:03:16 -0400 (EDT)
In-Reply-To: <87ehq8its8.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 25 May 2012 09:50:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E70017E8-A693-11E1-A95F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198498>

Thomas Rast <trast@inf.ethz.ch> writes:

> Why not make a git builtin command that figures out everything that
> __git_ps1 does?  Perhaps in a format that can be eval'd and processed to
> the user's taste.

I'd rather not to see something so specific for one interpreter like that
in the core.  How about doing it this way instead?

diff --git a/contrib/completion/Makefile b/contrib/completion/Makefile
new file mode 100644
index 0000000..71c600f
--- /dev/null
+++ b/contrib/completion/Makefile
@@ -0,0 +1,13 @@
+# The default target is ...
+all::
+
+SCRIPTS = git-completion.bash git-prompt.sh
+
+all:: $(SCRIPTS)
+clean::
+	rm -f $(SCRIPTS)
+
+$(SCRIPTS): % : %.shc
+	rm -f $@+ $@
+	sed -e '/## include common-bits/r common-bits' $< >$@+
+	mv $@+ $@
diff --git a/contrib/completion/common-bits b/contrib/completion/common-bits
new file mode 100644
index 0000000..06c2845
--- /dev/null
+++ b/contrib/completion/common-bits
@@ -0,0 +1,22 @@
+# __gitdir accepts 0 or 1 arguments (i.e., location)
+# returns location of .git repo
+__gitdir ()
+{
+	if [ -z "${1-}" ]; then
+		if [ -n "${__git_dir-}" ]; then
+			echo "$__git_dir"
+		elif [ -n "${GIT_DIR-}" ]; then
+			test -d "${GIT_DIR-}" || return 1
+			echo "$GIT_DIR"
+		elif [ -d .git ]; then
+			echo .git
+		else
+			git rev-parse --git-dir 2>/dev/null
+		fi
+	elif [ -d "$1/.git" ]; then
+		echo "$1/.git"
+	else
+		echo "$1"
+	fi
+}
+
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash.shc
similarity index 99%
rename from contrib/completion/git-completion.bash
rename to contrib/completion/git-completion.bash.shc
index abf8215..cf30f01 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash.shc
@@ -32,24 +32,8 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
-# __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
-__gitdir ()
-{
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
-		elif [ -d .git ]; then
-			echo .git
-		else
-			git rev-parse --git-dir 2>/dev/null
-		fi
-	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
-	else
-		echo "$1"
-	fi
-}
+## include common-bits here
+## common-bits ends here
 
 __gitcomp_1 ()
 {
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh.shc
similarity index 94%
rename from contrib/completion/git-prompt.sh
rename to contrib/completion/git-prompt.sh.shc
index 8e2e9f3..d442a1a 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh.shc
@@ -49,27 +49,8 @@
 # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
 # setting the bash.showUpstream config variable.
 
-# __gitdir accepts 0 or 1 arguments (i.e., location)
-# returns location of .git repo
-__gitdir ()
-{
-	if [ -z "${1-}" ]; then
-		if [ -n "${__git_dir-}" ]; then
-			echo "$__git_dir"
-		elif [ -n "${GIT_DIR-}" ]; then
-			test -d "${GIT_DIR-}" || return 1
-			echo "$GIT_DIR"
-		elif [ -d .git ]; then
-			echo .git
-		else
-			git rev-parse --git-dir 2>/dev/null
-		fi
-	elif [ -d "$1/.git" ]; then
-		echo "$1/.git"
-	else
-		echo "$1"
-	fi
-}
+## include common-bits here
+## common-bits ends here
 
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
