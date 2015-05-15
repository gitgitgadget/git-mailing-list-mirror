From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log --raw abbreviates SHA1s, despite what manual says
Date: Fri, 15 May 2015 17:08:38 +0200
Message-ID: <vpqfv6xc1zd.fsf@anie.imag.fr>
References: <loom.20150515T164345-901@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Fri May 15 17:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtHEH-0002hQ-88
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 17:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbbEOPIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 11:08:44 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32990 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693AbbEOPIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 11:08:43 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4FF8aln013991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2015 17:08:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4FF8cJI009467;
	Fri, 15 May 2015 17:08:38 +0200
In-Reply-To: <loom.20150515T164345-901@post.gmane.org> (Ed Avis's message of
	"Fri, 15 May 2015 14:46:14 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 15 May 2015 17:08:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4FF8aln013991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1432307318.34614@PtB28hf3bKujWAl6D6fb0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269150>

Ed Avis <eda@waniasset.com> writes:

> The manual page for git-log says:
>
>            The raw format shows the entire commit exactly as stored in the
>            commit object. Notably, the SHA-1s are displayed in full,
>            regardless of whether --abbrev or --no-abbrev are used,

It says "the raw format", not "the --raw option". The paragraph you cite
is under the PRETTY FORMAT section, hence documents what you can give as
argument to --format.

> But this is not quite true.  Here is an example line from 'git log --raw':
>
>     :100644 100644 9a203c9... daa08a7... M  myfilename

But

git log --format=raw generates an output format with full sha1.

Actually, the documentation *is* misleading, but not the part you're
quoting:

  COMMON DIFF OPTIONS
             [...]
         --raw
             Generate the raw format.

It is not very clear that --raw means to generate _the diff_ in raw
format.

Probably this patch to the doc would be an improvement IMHO:

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index ccd4998..0b50717 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -41,8 +41,11 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --raw::
-	Generate the raw format.
+	Generate the raw diff format.
 	{git-diff-core? This is the default.}
+ifdef::git-log[]
+	See the "RAW OUTPUT FORMAT" section of linkgit:git-diff[1].
+endif::git-log[]
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
