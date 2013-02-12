From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] completion: support 'git config --local'
Date: Tue, 12 Feb 2013 13:20:42 +0100
Message-ID: <1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
Cc: Dasa Paddock <dpaddock@esri.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 12 13:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Erb-0005dT-OE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 13:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076Ab3BLMVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 07:21:07 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53920 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933056Ab3BLMVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 07:21:06 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1CCKnK3008141
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2013 13:20:50 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U5Eqx-0008NP-1U; Tue, 12 Feb 2013 13:20:51 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1U5Eqw-0002gQ-UJ; Tue, 12 Feb 2013 13:20:50 +0100
X-Mailer: git-send-email 1.8.1.2.548.g956380a.dirty
In-Reply-To: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Feb 2013 13:20:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1CCKnK3008141
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1361276452.93667@BVtZZ3DIegmOwcRxguyg6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216150>

This needs to be done in two places: __git_config_get_set_variables to
allow clever completion of "git config --local --get foo<tab>", and
_git_config to allow "git config --loc<tab>" to complete to --local.

While we're there, change the order of options in the code to match
git-config.txt.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> I think this line should include --local:
> 
> https://github.com/git/git/blob/next/contrib/completion/git-completion.bash#L1782
>     "--global|--system|--file=*)"
> 
> This would help for:
>     git config -l --local

Yes, but not only ;-)

 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5770b6f..2e1ad67 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1570,7 +1570,7 @@ __git_config_get_set_variables ()
 	while [ $c -gt 1 ]; do
 		word="${words[c]}"
 		case "$word" in
-		--global|--system|--file=*)
+		--system|--global|--local|--file=*)
 			config_file="$word"
 			break
 			;;
@@ -1676,7 +1676,7 @@ _git_config ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--global --system --file=
+			--system --global --local --file=
 			--list --replace-all
 			--get --get-all --get-regexp
 			--add --unset --unset-all
-- 
1.8.1.2.548.g956380a.dirty
