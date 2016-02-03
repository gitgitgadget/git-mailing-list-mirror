From: Dan Aloni <alonid@gmail.com>
Subject: [PATCH v3] Add user.explicit boolean for when ident shouldn't be
 guessed
Date: Wed, 3 Feb 2016 21:22:27 +0200
Message-ID: <20160203192227.GA13878@gmail.com>
References: <1454442861-4879-1-git-send-email-alonid@gmail.com>
 <20160203035648.GA20732@sigill.intra.peff.net>
 <20160203082112.GA27454@gmail.com>
 <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:22:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR30e-0007Vm-UX
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 20:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965792AbcBCTWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 14:22:33 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37166 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965039AbcBCTWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 14:22:32 -0500
Received: by mail-wm0-f51.google.com with SMTP id l66so85665111wml.0
        for <git@vger.kernel.org>; Wed, 03 Feb 2016 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p94NFMmouJESabM2bwaIobCM62x87MIKSjYSF4q2Myc=;
        b=tZFtmYlxRglvtN+FgbaP7eukn7Sa4WtFfunmd/N7ixoLzoM7ax5Jc3yzaAHMr99AtL
         NDXIKSK2ouUgUCkRAiiq4VhDcTqvpxf4kxG/5LrISRsCOqMVKFHUW026rwAAKapkDrE/
         zIQ6YIoa+nO/RXhvOYBlgbiyN3r/aJNoPGQetM44EujD/ewB7o0SqbxpilAxJJ5MieAp
         b3NpaLqXxOfJmvjamd8vOU0nzkHvPEOAYuHKGWHKC0TdaNB9Tp3e76R/1dFIdpCrf5b5
         REK/3lPafLr8R3OgMkNcL/A5Tn+RRiU2ZszCfmL33GktJyWACkTSMfOHeAiC1A9PJqBE
         Vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=p94NFMmouJESabM2bwaIobCM62x87MIKSjYSF4q2Myc=;
        b=TtfbamcpUFMMni9rRwxMZv5GCsVwZOkHY/m3GIi+OeVxbox85HZ2ZbcpFEy84X1Aqs
         G6LxsQsSTY1MYOGlvIWcOHNK8v6S/9TzHP5+0euwC/yttfCGC8zJlCpjqmrMCJWWpeqh
         fhLT3IPh3xN7AFprkXMw6N9f6w2zokB4lnNdNGz2uc/ho50gYsoZJr4Bko1OSuOWM8vd
         ctt2YbjJM338jfY1pYgI+pd9f6ykISmURERuNX+9yGb7C1V+FFwn+mqBgR+t0iCkBnuz
         MmToI0yI++qOI/MXqXM0o5KhNLiHtpU1S16OjSPjdifzwt5ru8cNNGqfNadVbknkaC4P
         ULDg==
X-Gm-Message-State: AG10YOQQR2XI/pIrqVmVQlq0NiECtaJ/fq1wk365lJAnp8TAxuc6pNmHUyFpnACLrD7pFQ==
X-Received: by 10.28.24.85 with SMTP id 82mr27401275wmy.58.1454527350501;
        Wed, 03 Feb 2016 11:22:30 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id b1sm7919323wjy.0.2016.02.03.11.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2016 11:22:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPig+cSWN-wpcooqmYtFfZoDYpkhLoezSeu6bm9rSTvZ72jSEQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285374>

On Wed, Feb 03, 2016 at 12:47:56PM -0500, Eric Sunshine wrote:
>[..]
> * The final paragraph of the commit message appears to be outdated
> since it still seems to be describing the approach taken by v1.

Revised.

> * Elsewhere, in the project, the spelling "email" is preferred over
> "E-Mail"; that's true even in the files your patch is touching.

Done.

> * In the documentation:s/mutiply/multiple/.

Done.

> * The documentation doesn't seem to mention the default value of the
> new config variable.

Done.

> * The new config variable "user.explicit" has a more nebulous name
> than Peff's suggestion of "user.guessIdent", which may make its intent
> harder to determine without consulting documentation.

I wasn't sure about that, was waiting for input from Jeff. Kept it as
it is.

> * Don't initialize static variables to 0 (let the .bss section do that
> automatically).

Done.

> * One space before && operator; not two.

Done.

> * Drop unnecessary braces.

Done.

> * Perhaps use test_config(), test_unconfig(), test_config_global() in
> the test script rather than the manual git-config invocations in
> subshells.

Done, although test_unconfig_global was missing, so I revised.

> * test_expect_failure() is for indicating that a test will fail
> because some feature is known to be broken, not for when you expect a
> git command to fail in a controlled fashion. Instead, use
> test_expect_success, and then use test_must_fail() within the body of
> the test.
> 
>     test_expect_success '...' '
>         ... &&
>         test_must_fail git commit -m msg
>     '

Done. Also refactored both aspects of the test to a function.

> * Do these new tests really deserve a new test script, or would they
> fit into an existing script? (Genuine question.)

I am not sure. IMHO it makes sense to have a new test script for a new
feature.

> It's also reviewer-friendly to indicate the patch revision in the
> subject "[PATCH v3]", and to describe what changed since the previous
> version of the patch. Providing a gmane link to the previous version
> is also very helpful.

All changes from v2 to v3 listed above.

http://article.gmane.org/gmane.comp.version-control.git/285340

-- >8 --
Subject: Add user.explicit boolean for when ident shouldn't be guessed

Previously, before 5498c57cdd63, many people did the following:

   git config --global user.email "(none)"

This was helpful for people with more than one email address,
targeting different email addresses for different clones.
as it barred git from creating commit unless the user.email
config was set in the per-repo config to the correct email
address.

This commit provides the same functionality by adding a new
configuration variable.

Signed-off-by: Dan Aloni <alonid@gmail.com>
---
 Documentation/config.txt  |  9 +++++++++
 ident.c                   | 45 +++++++++++++++++++++++++++++++++++++++++++++
 t/t9904-per-repo-email.sh | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100755 t/t9904-per-repo-email.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 877cbc875ec3..d329ec9ac8d1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2791,6 +2791,15 @@ user.name::
 	Can be overridden by the 'GIT_AUTHOR_NAME' and 'GIT_COMMITTER_NAME'
 	environment variables.  See linkgit:git-commit-tree[1].
 
+user.explicit::
+	This instruct Git to avoid trying to guess defaults for 'user.email'
+	and 'user.name' other than strictly from environment or config.
+	If you have multiple email addresses that you would like to set
+	up per repository, you may want to set this to 'true' in the global
+	config, and then Git would prompt you to set user.email separately,
+	in each of the cloned repositories.
+	Defaults to `false`.
+
 user.signingKey::
 	If linkgit:git-tag[1] or linkgit:git-commit[1] is not selecting the
 	key you want it to automatically when creating a signed tag or
diff --git a/ident.c b/ident.c
index 9dd3ae345255..c950b5e3490f 100644
--- a/ident.c
+++ b/ident.c
@@ -18,6 +18,7 @@ static int default_name_is_bogus;
 #define IDENT_ALL_GIVEN (IDENT_NAME_GIVEN|IDENT_MAIL_GIVEN)
 static int committer_ident_explicitly_given;
 static int author_ident_explicitly_given;
+static int ident_explicit;
 
 #ifdef NO_GECOS_IN_PWENT
 #define get_gecos(ignored) "&"
@@ -373,6 +374,21 @@ const char *fmt_ident(const char *name, const char *email,
 		die("unable to auto-detect email address (got '%s')", email);
 	}
 
+	if (ident_explicit) {
+		if (name == git_default_name.buf &&
+		    !(committer_ident_explicitly_given & IDENT_NAME_GIVEN) &&
+		    !(author_ident_explicitly_given & IDENT_NAME_GIVEN))
+			die("requested explicitly given ident in config, "
+			    "but user.name is not set, or environment is "
+			    "not set");
+		if (email == git_default_email.buf &&
+		    !(committer_ident_explicitly_given & IDENT_MAIL_GIVEN) &&
+		    !(author_ident_explicitly_given & IDENT_MAIL_GIVEN))
+			die("requested explicitly given ident in config, "
+			    "but user.email is not set, or environment is "
+			    "not set");
+	}
+
 	strbuf_reset(&ident);
 	if (want_name) {
 		strbuf_addstr_without_crud(&ident, name);
@@ -405,6 +421,18 @@ const char *git_author_info(int flag)
 		author_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_AUTHOR_EMAIL"))
 		author_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+
+	if (ident_explicit) {
+		if (!(author_ident_explicitly_given & IDENT_NAME_GIVEN))
+			die("requested explicitly given ident in config, "
+			    "but user.name is not set, or GIT_AUTHOR_NAME "
+			    "is not set");
+		if (!(author_ident_explicitly_given & IDENT_MAIL_GIVEN))
+			die("requested explicitly given ident in config, "
+			    "but user.email is not set, or GIT_AUTHOR_EMAIL "
+			    "is not set");
+	}
+
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
 			 getenv("GIT_AUTHOR_EMAIL"),
 			 getenv("GIT_AUTHOR_DATE"),
@@ -417,6 +445,18 @@ const char *git_committer_info(int flag)
 		committer_ident_explicitly_given |= IDENT_NAME_GIVEN;
 	if (getenv("GIT_COMMITTER_EMAIL"))
 		committer_ident_explicitly_given |= IDENT_MAIL_GIVEN;
+
+	if (ident_explicit) {
+		if (!(committer_ident_explicitly_given & IDENT_NAME_GIVEN))
+			die("requested explicitly given ident in config, "
+			    "but user.name is not set, or GIT_COMMITTER_NAME "
+			    "is not set");
+		if (!(committer_ident_explicitly_given & IDENT_MAIL_GIVEN))
+			die("requested explicitly given ident in config, "
+			    "but user.email is not set, or GIT_COMMITTER_EMAIL "
+			    "is not set");
+	}
+
 	return fmt_ident(getenv("GIT_COMMITTER_NAME"),
 			 getenv("GIT_COMMITTER_EMAIL"),
 			 getenv("GIT_COMMITTER_DATE"),
@@ -444,6 +484,11 @@ int author_ident_sufficiently_given(void)
 
 int git_ident_config(const char *var, const char *value, void *data)
 {
+	if (!strcmp(var, "user.explicit")) {
+		ident_explicit = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/t/t9904-per-repo-email.sh b/t/t9904-per-repo-email.sh
new file mode 100755
index 000000000000..f6f42288a10c
--- /dev/null
+++ b/t/t9904-per-repo-email.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+#
+# Copyright (c) 2016 Dan Aloni
+#
+
+test_description='per-repo forced setting of email address'
+
+. ./test-lib.sh
+
+prepare () {
+	echo "Initial" >foo &&
+	git add foo &&
+	unset GIT_AUTHOR_NAME &&
+	unset GIT_AUTHOR_EMAIL &&
+	test_unconfig --global user.name &&
+	test_unconfig --global user.email &&
+	test_unconfig user.name &&
+	test_unconfig user.email &&
+	test_config_global user.explicit true
+}
+
+test_expect_success 'fails commiting if clone email is not set' '
+        prepare &&
+
+	EDITOR=: VISUAL=: test_must_fail git commit -m msg
+
+'
+
+test_expect_success 'succeeds commiting if clone email is set' '
+        prepare &&
+
+	test_config user.name "test" &&
+	test_config user.email "test@ok.com" &&
+	EDITOR=: VISUAL=: git commit -m msg
+'
+
+test_done
-- 
2.5.0



-- 
Dan Aloni
