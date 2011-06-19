From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/6] Allow "git notes merge" to use refs/remote-notes/ as a
 source.
Date: Sun, 19 Jun 2011 23:45:14 +0200
Message-ID: <201106192345.14879.johan@herland.net>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
 <1308431208-13353-5-git-send-email-ydirson@free.fr>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 20 00:07:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYQ9j-0008NH-GD
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 00:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805Ab1FSWHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 18:07:41 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59476 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab1FSWHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 18:07:39 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200I2I5GP0810@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:37 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5190C179906A_DFE7329B	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:37 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 304331796450_DFE7329F	for <git@vger.kernel.org>; Sun,
 19 Jun 2011 22:07:37 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LN200CIB5GO4R00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 20 Jun 2011 00:07:37 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <1308431208-13353-5-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176032>

On Saturday 18 June 2011, Yann Dirson wrote:
> Signed-off-by: Yann Dirson <ydirson@free.fr>
> ---
>  Documentation/git-notes.txt |    5 +++++
>  builtin/notes.c             |    4 ++--
>  notes.c                     |    5 +++--
>  notes.h                     |    2 +-
>  revision.c                  |    2 +-
>  5 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 6a187f2..7ce8a24 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -104,6 +104,11 @@ and instructs the user to manually resolve the
> conflicts there. When done, the user can either finalize the merge with
>  'git notes merge --commit', or abort the merge with
>  'git notes merge --abort'.
> ++
> +In addition to `refs/notes/`, the remote notes ref is accepted
> +from the `refs/remote-notes/` namespace.  This is intended to
> +provide notes with support for a workflow similar to the one used
> +for heads references.

I would rephrase this as:

  In addition to `refs/notes/*`, the remote notes ref can also be
  from within `refs/remote-notes/*`. This allows the user to set up
  fetch refspecs that transfers notes refs from a remote repo into
  `refs/remote-notes/*`, and then merge those remote notes refs into
  the corresponding local notes refs.

Also, AFAICS you're adding the possibility to read notes from refs/remote-
notes/*, but not WRITE to those notes using "git notes" (obviously, "git 
fetch" and other tools can be used to manipulate them). Please add some 
selftests verifying that "git notes" is still unable to manipulate notes in 
refs/remote-notes/*.

Otherwise the patch looks good to me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
