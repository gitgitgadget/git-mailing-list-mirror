From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix vc git
Date: Thu, 21 Dec 2006 16:52:50 -0800
Message-ID: <7vhcvo92fx.fsf@assigned-by-dhcp.cox.net>
References: <8e745ecf0612210325m72a569d7k370dd5953ccf6f27@mail.gmail.com>
	<emdr6v$9ma$1@sea.gmane.org>
	<8e745ecf0612210359j3f895521r1fff497a512253d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 01:52:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxYec-0003Ql-QD
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 01:52:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423167AbWLVAww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 19:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423168AbWLVAww
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 19:52:52 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:35053 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423167AbWLVAwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 19:52:51 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222005251.STGG19398.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Dec 2006 19:52:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1ct31W00a1kojtg0000000; Thu, 21 Dec 2006 19:53:04 -0500
To: "Duncan Mak" <duncan@a-chinaman.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35104>

"Duncan Mak" <duncan@a-chinaman.com> writes:

> --- a/contrib/emacs/vc-git.el
> +++ b/contrib/emacs/vc-git.el
> @@ -58,7 +58,7 @@
>   (with-temp-buffer
>     (let* ((dir (file-name-directory file))
>            (name (file-relative-name file dir)))
> -      (when dir (cd dir))
> +      (when (file-exists-p dir) (cd dir))
>       (and (ignore-errors (eq 0 (call-process "git" nil '(t nil) nil
> "ls-files" "-c" "-z" "--" name)))
>            (let ((str (buffer-string)))
>              (and (> (length str) (length name))

I wonder what would happen when (file-name-directory file)
returns nil with this change...
