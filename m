From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] shell doc: emphasize purpose and security model
Date: Sun, 10 Feb 2013 21:57:52 -0800
Message-ID: <20130211055752.GF15329@elie.Belkin>
References: <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 06:58:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mPN-0000dY-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 06:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab3BKF6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 00:58:01 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:40848 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab3BKF6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 00:58:00 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so544722pbc.25
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 21:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dhp2PFRsV+r+g0LEKOE6zdfLsOejYzAuKfVEDJ57jA8=;
        b=T31+/c1mqhShiMglr2zGxYAdQFv/NdRwxhL6GAqfGFz69BSHGymN1XapHoYVnI4OLf
         tKUsC6gMbatQUtuKXCX9OKFqFUIjVevRgL6QMIOxCyNMpVJayaDi4uEljF3SjM23AM62
         y26EOg8XRMM3cmmCvRb1PkB+wz0dQ7a6oSA4veqDsMXcQY66sttO6voF8jJ8UBh+h/oA
         8Rk+U3MGK0u0/ximA9gb0lSEFag52I/s+AIfuwBWfqCiYvYC0TyVltqNVlMlXBYbr7GT
         eztTOCOHVO3/rtXIzJItSQBW4uVg+4RVqpdMY8LhhecSkYuxKCIm1YIzMJ6JEa4RYJFa
         7Zfw==
X-Received: by 10.68.11.200 with SMTP id s8mr16157752pbb.141.1360562280144;
        Sun, 10 Feb 2013 21:58:00 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id zq5sm6587313pbc.16.2013.02.10.21.57.57
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 21:57:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130211055604.GE15329@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215995>

The original git-shell(1) manpage emphasized that the shell
supports only git transport commands, and as the shell gained
features that emphasis and focus in the manual has been lost.
Bring it back by splitting the manpage into a few short sections
and fleshing out each:

 - SYNOPSIS, describing how the shell gets used in practice
 - DESCRIPTION, which gives an overview of the purpose and
   guarantees provided by this restricted shell
 - COMMANDS, listing supported commands and restrictions on the
   arguments they accept
 - INTERACTIVE USE, describing the interactive mode

Also add a "see also" section with some relevant related reading.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New text.  Split off from patch 2 --- this is just documenting
existing behavior.

 Documentation/git-shell.txt | 66 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 9b925060..4fe93203 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -9,25 +9,61 @@ git-shell - Restricted login shell for Git-only SSH access
 SYNOPSIS
 --------
 [verse]
-'git shell' [-c <command> <argument>]
+'chsh' -s $(which git-shell) git
+'git clone' `git@localhost:/path/to/repo.git`
+'ssh' `git@localhost`
 
 DESCRIPTION
 -----------
 
-A login shell for SSH accounts to provide restricted Git access. When
-'-c' is given, the program executes <command> non-interactively;
-<command> can be one of 'git receive-pack', 'git upload-pack', 'git
-upload-archive', 'cvs server', or a command in COMMAND_DIR. The shell
-is started in interactive mode when no arguments are given; in this
-case, COMMAND_DIR must exist, and any of the executables in it can be
-invoked.
-
-'cvs server' is a special command which executes git-cvsserver.
-
-COMMAND_DIR is the path "$HOME/git-shell-commands". The user must have
-read and execute permissions to the directory in order to execute the
-programs in it. The programs are executed with a cwd of $HOME, and
-<argument> is parsed as a command-line string.
+This is a login shell for SSH accounts to provide restricted Git access.
+It permits execution only of server-side Git commands implementing the
+pull/push functionality, plus custom commands present in a subdirectory
+named `git-shell-commands` in the user's home directory.
+
+COMMANDS
+--------
+
+'git shell' accepts the following commands after the '-c' option:
+
+'git receive-pack <argument>'::
+'git upload-pack <argument>'::
+'git upload-archive <argument>'::
+	Call the corresponding server-side command to support
+	the client's 'git push', 'git fetch', or 'git archive --remote'
+	request.
+'cvs server'::
+	Imitate a CVS server.  See linkgit:git-cvsserver[1].
+
+If a `~/git-shell-commands` directory is present, 'git shell' will
+also handle other, custom commands by running
+"`git-shell-commands/<command> <arguments>`" from the user's home
+directory.
+
+INTERACTIVE USE
+---------------
+
+By default, the commands above can be executed only with the '-c'
+option; the shell is not interactive.
+
+If a `~/git-shell-commands` directory is present, 'git shell'
+can also be run interactively (with no arguments).  If a `help`
+command is present in the `git-shell-commands` directory, it is
+run to provide the user with an overview of allowed actions.  Then a
+"`git> `" prompt is presented at which one can enter any of the
+commands from the `git-shell-commands` directory, or `exit` to close
+the connection.
+
+Generally this mode is used as an administrative interface to allow
+users to list repositories they have access to, create, delete, or
+rename repositories, or change repository descriptions and
+permissions.
+
+SEE ALSO
+--------
+ssh(1),
+linkgit:git-daemon[1],
+contrib/git-shell-commands/README
 
 GIT
 ---
-- 
1.8.1.3
