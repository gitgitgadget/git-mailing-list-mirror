From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add long option completion for 'git send-email'
Date: Mon, 14 Jul 2008 11:21:02 +0300
Message-ID: <1216023662-9109-1-git-send-email-tlikonen@iki.fi>
Cc: spearce@spearce.org, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 10:22:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJJw-00035o-Ld
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbYGNIVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756123AbYGNIVI
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:21:08 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:46448 "EHLO
	kirsi1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756128AbYGNIVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:21:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.rokki.sonera.fi (8.5.014)
        id 483E837C01E72EAF; Mon, 14 Jul 2008 11:21:04 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1KIJIs-0002NH-R1; Mon, 14 Jul 2008 11:21:02 +0300
X-Mailer: git-send-email 1.5.6.3.316.g01fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88398>

Add the following long options to be completed with 'git send-email':

    --bcc --cc --cc-cmd --chain-reply-to --compose --dry-run
    --envelope-sender --from --identity --in-reply-to
    --no-chain-reply-to --no-signed-off-by-cc --no-suppress-from
    --no-thread --quiet --signed-off-by-cc --smtp-pass --smtp-server
    --smtp-server-port --smtp-ssl --smtp-user --subject --suppress-cc
    --suppress-from --thread --to

Short ones like --to and --cc are not usable for actual completion
because of the shortness itself and because there are longer ones which
start with same letters (--thread, --compose). It's still useful to have
these shorter options _listed_ when user presses TAB key after typing
two dashes. It gives user an idea what options are available (and --to
and --cc are probably the most commonly used).

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---
 contrib/completion/git-completion.bash |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d268e6f..b15f3a9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -905,6 +905,24 @@ _git_rebase ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_send_email ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--bcc --cc --cc-cmd --chain-reply-to --compose
+			--dry-run --envelope-sender --from --identity
+			--in-reply-to --no-chain-reply-to --no-signed-off-by-cc
+			--no-suppress-from --no-thread --quiet
+			--signed-off-by-cc --smtp-pass --smtp-server
+			--smtp-server-port --smtp-ssl --smtp-user --subject
+			--suppress-cc --suppress-from --thread --to"
+		return
+		;;
+	esac
+	__git_complete_file
+}
+
 _git_config ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1376,6 +1394,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
 	reset)       _git_reset ;;
+	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
@@ -1435,6 +1454,7 @@ complete -o default -o nospace -F _git_rebase git-rebase
 complete -o default -o nospace -F _git_config git-config
 complete -o default -o nospace -F _git_remote git-remote
 complete -o default -o nospace -F _git_reset git-reset
+complete -o default -o nospace -F _git_send_email git-send-email
 complete -o default -o nospace -F _git_shortlog git-shortlog
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_stash git-stash
-- 
1.5.6.3.316.g01fc
