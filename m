From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH] bash: Add long option completion for 'git send-email'
Date: Sun, 27 Apr 2008 08:09:51 +0300
Message-ID: <20080427050951.GA3946@mithlond.arda.local>
References: <7vskx8kvbu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 07:17:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpzG7-0000c0-RF
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 07:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbYD0FQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 01:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbYD0FQJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 01:16:09 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:59505 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752837AbYD0FQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 01:16:07 -0400
X-Greylist: delayed 359 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Apr 2008 01:16:07 EDT
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 480DD91B00121D96; Sun, 27 Apr 2008 08:09:54 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jpz95-00011s-6c; Sun, 27 Apr 2008 08:09:51 +0300
Content-Disposition: inline
In-Reply-To: <7vskx8kvbu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80409>

Add the following long options to be completed with 'git send-email':

  --bcc --cc --cc-cmd --chain-reply-to --compose --dry-run
  --envelope-sender --from --identity --in-reply-to --no-chain-reply-to
  --no-signed-off-by-cc --no-suppress-from --no-thread --quiet
  --signed-off-by-cc --smtp-pass --smtp-server --smtp-server-port
  --smtp-ssl --smtp-user --subject --suppress-cc --suppress-from
  --thread --to

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
index 665a895..a9a7015 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -875,6 +875,24 @@ _git_rebase ()
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
@@ -1331,6 +1349,7 @@ _git ()
 	rebase)      _git_rebase ;;
 	remote)      _git_remote ;;
 	reset)       _git_reset ;;
+	send-email)  _git_send_email ;;
 	shortlog)    _git_shortlog ;;
 	show)        _git_show ;;
 	show-branch) _git_log ;;
@@ -1383,6 +1402,7 @@ complete -o default -o nospace -F _git_rebase git-rebase
 complete -o default -o nospace -F _git_config git-config
 complete -o default -o nospace -F _git_remote git-remote
 complete -o default -o nospace -F _git_reset git-reset
+complete -o default -o nospace -F _git_send_email git-send-email
 complete -o default -o nospace -F _git_shortlog git-shortlog
 complete -o default -o nospace -F _git_show git-show
 complete -o default -o nospace -F _git_stash git-stash
-- 
1.5.5.1.94.g80fd
