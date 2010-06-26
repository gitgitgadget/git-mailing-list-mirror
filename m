From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git-rebase --abort eats files
Date: Sat, 26 Jun 2010 20:09:30 +0200
Message-ID: <201006262009.30380.j6t@kdbg.org>
References: <20100626125924.160F11F212@leonis4.robolove.meer.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Madhu <enometh@meer.net>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:12:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSZru-0003bB-0Y
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab0FZSJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 14:09:38 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:32471 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752365Ab0FZSJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 14:09:37 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 02F59CDF88;
	Sat, 26 Jun 2010 20:09:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 73E9419F773;
	Sat, 26 Jun 2010 20:09:30 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100626125924.160F11F212@leonis4.robolove.meer.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149767>

On Samstag, 26. Juni 2010, Madhu wrote:
> Don't know if this has been resolved-by-debate here before, But adding
> a file via git-add in the middle of an interactive rebase and aborting
> the rebase deletes the hitherto untracked file.  It should not.
>
> Maybe something like this to fix it?
>
> +++ b/git-rebase--interactive.sh
> @@ -749,6 +749,7 @@ first and then run 'git rebase --continue' again."
>                         git symbolic-ref HEAD $HEADNAME
>                         ;;
>                 esac &&
> +               git-reset &&
>                 output git reset --hard $HEAD &&
>                 rm -rf "$DOTEST"
>                 exit

No, it can't be that simple. If rebase stopped due to a conflict on a commit 
that added new files, then your version of rebase --abort will leave these 
new files behind as untracked.

-- Hannes
