From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git stash pop not reapplying deletions
Date: Sun, 14 Feb 2010 23:08:01 +0100
Message-ID: <201002142308.01704.trast@student.ethz.ch>
References: <loom.20100214T200110-615@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Steve Folly <steve@spfweb.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 14 23:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgmdS-0006rL-4e
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 23:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab0BNWIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 17:08:07 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:18900 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab0BNWIG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 17:08:06 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 23:08:02 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 23:08:01 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <loom.20100214T200110-615@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139947>

On Sunday 14 February 2010 20:45:03 Steve Folly wrote:
> 
> I'm not sure if I've found a bug in 'git stash' or if I'm using 
> it the wrong way? (This is with git 1.6.6):
> 
[eliding a lot everywhere to make it clearer]
> $ git status   # correctly shows renames
> #	renamed:    dira/a -> dirb/a
> #	renamed:    dira/b -> dirb/b
> #	renamed:    dira/c -> dirb/c
> $ git stash
> $ git stash pop
> # Changes to be committed:
> #	new file:   dirb/a
> #	new file:   dirb/b
> #	new file:   dirb/c
> # Changed but not updated:
> #	deleted:    dira/a
> #	deleted:    dira/b
> #	deleted:    dira/c

The problem is that you aren't using --index, but still expecting it
to restore your index.  If you change it to 'git stash pop --index',
everything will work as expected.

Yes, it does stage new files, but that is only to help you: otherwise
you could forget them before committing.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
