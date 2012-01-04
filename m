From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 04 Jan 2012 09:31:02 +0100
Message-ID: <4F040E46.5030001@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com> <7vboqks8la.fsf@alter.siamese.dyndns.org> <4F038EC8.505@tu-clausthal.de> <7v39bws4xi.fsf@alter.siamese.dyndns.org> <4F0405D4.9090102@tu-
 clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 09:31:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiMFa-0002Ao-9J
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 09:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab2ADIbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 03:31:03 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:15267 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936Ab2ADIbB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 03:31:01 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 34E3A29AED0;
	Wed,  4 Jan 2012 09:31:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=GQYD5D33GB9g88C464Pca1sJJGQ=; b=wr6fW8cm/4PWVwQNSieqYVWUl+WD
	EppeAiWIHTsULIHbC9YNZXb3Zg1hmuO1A2nYXTWtsu5ipQujjZjzPTFxBlkj8jo1
	etzBtQvUISz/kcGlzek2Q4/wVCOgkhn82y7xu3tLnW14hjF2xlwt7pBFGm8cna2Z
	HMFLDJmYA2nQd6o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=5npXgXPeTsZ2+lnJKcJ3YYSdTfgdTYiLFZ47tf5Ab+zjHRHlGeYeh+f
	9UAZaHwDMcPDAc9ZshC/layBMuhlcerjuCqyYkqGxIBinyTtJISRljvwuMgGyFSG
	lZcpP6469pAvang/vpQgEKDVdzrCA/784AbcUYpFv3O/pD78edUY=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 11BDD29AE3C;
	Wed,  4 Jan 2012 09:31:00 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25668723; Wed, 04 Jan 2012 09:31:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <4F0405D4.9090102@tu-clausthal.de>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187913>

Am 04.01.2012 08:55 schrieb Sven Strickroth:
> The Git.pm part is easy, but I also tried to update prompt.c (untested).

I said "easy" and then I mailed the wrong/outdated patch :(
I'm sorry for the noise.

From: Sven Strickroth <email@cs-ware.de>
Date: Wed, 4 Jan 2012 08:44:48 +0100
Subject: [PATCH] Git.pm, prompt: try reading from interactive terminal
 before using SSH_ASKPASS

SVN tries to read reading from interactive terminal before using
SSH_ASKPASS helper. This change adjust git to behave the same way.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 perl/Git.pm |    9 ++++-----
 prompt.c    |   14 +++++++++++---
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 1c96a20..721aef7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -530,13 +530,9 @@ sub prompt {
 		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
 	}
 	if (!defined $ret) {
-		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
-	}
-	if (!defined $ret) {
 		print STDERR $prompt;
 		STDERR->flush;
 		if ($isPassword) {
-			$ret = '';
 			require Term::ReadKey;
 			Term::ReadKey::ReadMode('noecho');
 			while (defined(my $key = Term::ReadKey::ReadKey(0))) {
@@ -551,10 +547,13 @@ sub prompt {
 			if (defined $ret) {
 				chomp($ret);
 			} else {
-				$ret = '';
+				undef $ret;
 			}
 		}
 	}
+	if (!defined $ret) {
+		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
+	}
 	return $ret;
 }

diff --git a/prompt.c b/prompt.c
index 72ab9de..e791619 100644
--- a/prompt.c
+++ b/prompt.c
@@ -52,9 +52,17 @@ char *git_prompt(const char *prompt, int flags)
 	}

 	r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
-	if (!r)
-		die_errno("could not read '%s'", prompt);
-	return r;
+	if (r)
+		return r;
+
+	if (flags & PROMPT_ASKPASS) {
+		const char *askpass;
+		askpass = getenv("SSH_ASKPASS");
+		if (askpass && *askpass)
+			return do_askpass(askpass, prompt);
+	}
+
+	die_errno("could not read '%s'", prompt);
 }

 char *git_getpass(const char *prompt)
-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
