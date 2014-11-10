From: =?UTF-8?Q?Vanja_Radovanovi=C4=87?= <elvanja@gmail.com>
Subject: [PATCH] Custom prompt colors
Date: Mon, 10 Nov 2014 10:42:23 +0100
Message-ID: <CAC2nwfcuPLKr-kpt-G1uUmMoZs8T+pg9uJWP5oxMea60xg09=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 10:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnlUU-000892-UP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 10:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbaKJJm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 04:42:26 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59531 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbaKJJm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 04:42:26 -0500
Received: by mail-lb0-f173.google.com with SMTP id n15so5490651lbi.4
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 01:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=AhcAcWfRKkTjpgRiQ5tsKjXfZ9iJLA3XPP0Jj7E3k9U=;
        b=Bo16fXjd3RXwg7gGaYd5XKMxdaTMUm+fjM+ix2yyBBf6CkgtDTgviLpoAzG1phPzL1
         t+DBv8jTis8TBjXeUhc97ibQcLVDTqTHij4LcOSP3VCwt1r2vKp7e3McNYIZSHppyt0H
         CA4ehw4U9ottOn9NI2uzkCAC9WPR7c0HhDUqrLWn8bYKkIjGqKWREw03OzIokZsVv8x2
         q/3q4h0jIcfXhvqEv7lPobLrVtivLSSqVF8k/m9ViJB/eRFX8/JW4RW5KSq5Uzf3d+n6
         t2RB5jq5pQVuMbq8glYj9ZmtZapSqAT8q2qg2pNjlti1m+1ss5AjjBLtS3gAB+wDCFRo
         4+3w==
X-Received: by 10.152.204.99 with SMTP id kx3mr28467067lac.53.1415612543997;
 Mon, 10 Nov 2014 01:42:23 -0800 (PST)
Received: by 10.112.184.76 with HTTP; Mon, 10 Nov 2014 01:42:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>From 41e9edae533306b4a50570e32dbbdd291a4a5fbf Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Vanja=20Radovanovi=C4=87?= <elvanja@gmail.com>
Date: Sun, 9 Nov 2014 20:05:48 +0100
Subject: [PATCH] contrib/completion: custom git prompt colors

Allow git prompt colors to be customized.
Accept globally set colors, use defaults otherwise.

Note: requires /usr/lib/git-core/git-sh-promp to be
removed or commented out, so custom git-prompt.sh
can be used.
---
 contrib/completion/git-prompt.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c5473dc..ff5b04b 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -84,6 +84,10 @@
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb" and are available only when
 # using __git_ps1 for PROMPT_COMMAND or precmd.
+# Colors can be overridden; just set GIT_PS1_BAD_COLOR,
+# GIT_PS1_OK_COLOR and/or GIT_PS1_FLAGS_COLOR to the color of your choice.
+# Make sure you use appropriately escaped color codes, see
+# __git_ps1_colorize_gitstring function for details/defaults.

 # check whether printf supports -v
 __git_printf_supports_v=
@@ -240,9 +244,21 @@ __git_ps1_colorize_gitstring ()
  local c_lblue='\[\e[1;34m\]'
  local c_clear='\[\e[0m\]'
  fi
+
  local bad_color=$c_red
+  if [ -n "${GIT_PS1_BAD_COLOR-}" ]; then
+    bad_color=$GIT_PS1_BAD_COLOR
+  fi
+
  local ok_color=$c_green
- local flags_color="$c_lblue"
+  if [ -n "${GIT_PS1_OK_COLOR-}" ]; then
+    ok_color=$GIT_PS1_OK_COLOR
+  fi
+
+  local flags_color="$c_lblue"
+  if [ -n "${GIT_PS1_FLAGS_COLOR-}" ]; then
+    flags_color=$GIT_PS1_FLAGS_COLOR
+  fi

  local branch_color=""
  if [ $detached = no ]; then
-- 
2.1.3
