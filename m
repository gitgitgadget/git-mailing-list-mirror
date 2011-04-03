From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH v2] contrib/emacs/git.el: Add user functions for push, pull, fetch
Date: Sun, 03 Apr 2011 19:27:24 +0200
Message-ID: <87mxk7454z.fsf@wine.dyndns.org>
References: <1300800651-12502-1-git-send-email-jari.aalto@cante.net>
	<d40ef57d7e6d75c41a4d1f8e51bdd892351f3aee.1300804459.git.jari.aalto@cante.net>
	<87tyef9uu5.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 19:48:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6RPF-0001xK-HR
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 19:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab1DCRsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 13:48:03 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:43998 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab1DCRsC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 13:48:02 -0400
Received: from xdsl-188-155-135-49.adslplus.ch ([188.155.135.49] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <julliard@winehq.org>)
	id 1Q6R5D-0005aa-BH; Sun, 03 Apr 2011 12:27:28 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 079391E729E; Sun,  3 Apr 2011 19:27:25 +0200 (CEST)
In-Reply-To: <87tyef9uu5.fsf@picasso.cante.net> (Jari Aalto's message of "Sun,
	03 Apr 2011 19:13:22 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Spam-Score: -4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170764>

Jari Aalto <jari.aalto@cante.net> writes:

> @@ -1555,6 +1561,13 @@ amended version of it."
>      (define-key map "x"   'git-remove-handled)
>      (define-key map "\C-?" 'git-unmark-file-up)
>      (define-key map "\M-\C-?" 'git-unmark-all)
> +    ; remotes
> +    (define-key remote-map "\C-a" 'git-push)
> +    (define-key remote-map "R" 'git-pull)  ; retrieve "RR"
> +    (define-key remote-map "r" 'git-pull)  ; retrieve "Rr" (synonym)
> +    (define-key remote-map "p" 'git-push)
> +    (define-key remote-map "f" 'git-fetch)
> +    (define-key remote-map "\C-a" 'git-fetch)

The \C-a things look strange.

> +(defun git-push (&optional remote)
> +  "Pull to REMOTE. Use \\[current-prefix-arg] to interactively set REMOTE."
> +  (interactive
> +   (list (or (and current-prefix-arg
> +		  (git-ask-remote "Push to remote: "))
> +	     "origin")))
> +  ;; FIXME: could colled some status data for display
> +  (git-call-process-display-error "push" remote)
> +  (git-update-status-files)
> +  (message "Pushed to remote: %s" remote))

You shouldn't display a success message if the call failed. Also there's
no need to refresh the status files on push or fetch.

-- 
Alexandre Julliard
julliard@winehq.org
