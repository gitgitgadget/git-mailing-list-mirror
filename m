From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: Emacs git-mode feature request: support fill-paragraph correctly
Date: Tue, 27 Jan 2009 12:03:05 +0100
Message-ID: <873af59fkm.fsf@wine.dyndns.org>
References: <87tz7mth3g.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Tue Jan 27 12:07:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRlki-0002SK-Qo
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 12:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZA0LDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 06:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbZA0LDP
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 06:03:15 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:44761 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbZA0LDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 06:03:15 -0500
Received: from adsl-62-167-29-78.adslplus.ch ([62.167.29.78] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LRlil-0007CY-SD; Tue, 27 Jan 2009 05:03:13 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 1D1AF1E71F0; Tue, 27 Jan 2009 12:03:05 +0100 (CET)
In-Reply-To: <87tz7mth3g.fsf@write-only.cryp.to> (Peter Simons's message of
	"Mon, 26 Jan 2009 12:57:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107332>

Peter Simons <simons@cryp.to> writes:

> Other modes, such as message-mode, do support that kind of thing
> correctly, so apparently it is possible to configure what the editor
> considers as a paragraph. Is there some Emacs wizard out there who'd
> be kind enough to improve git-mode accordingly?

You could try something like this:

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 3c37d0d..e314c44 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1331,6 +1331,7 @@ Return the list of files that haven't been handled."
 					 (log-edit-diff-function . git-log-edit-diff)) buffer)
 	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
       (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+      (setq paragraph-separate (concat (regexp-quote git-log-msg-separator) "$\\|Author: \\|Date: \\|Merge: \\|Signed-off-by: \\|\f\\|[ 	]*$"))
       (setq buffer-file-coding-system coding-system)
       (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
 

-- 
Alexandre Julliard
julliard@winehq.org
