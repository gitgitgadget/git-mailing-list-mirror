From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH] Add SVN->Git conversion example to documentation
Date: Tue, 17 Jun 2008 16:21:36 -0700
Message-ID: <7viqw74phb.fsf@gitster.siamese.dyndns.org>
References: <20080614215812.GA28574@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jun 18 01:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8kVk-0000mD-Ph
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 01:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759757AbYFQXVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 19:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759052AbYFQXVx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 19:21:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759722AbYFQXVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 19:21:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BBF6211C18;
	Tue, 17 Jun 2008 19:21:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C89311C10; Tue, 17 Jun 2008 19:21:42 -0400 (EDT)
In-Reply-To: <20080614215812.GA28574@zakalwe.fi> (Heikki Orsila's message of
 "Sun, 15 Jun 2008 00:58:12 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27A7D0B2-3CC4-11DD-8F17-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85342>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
> ---
> This is the third round. Added some commands to clean up the repository, 
> and set fetch heads. Thanks to Miklos Vajna for feedback.
>
>  Documentation/git-svn.txt |   41 ++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index f4cbd2f..26e00c5 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -11,9 +11,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -git-svn is a simple conduit for changesets between Subversion and git.
> -It is not to be confused with linkgit:git-svnimport[1], which is
> -read-only.
> +git-svn is a simple bidirectional conduit for changesets between
> +Subversion and git. It is used to develop projects with Git tools,
> +but commit changes to a Subversion repository. It can also be used to

That is correct but doesn't the above give a false impression that commits
are only made on subversion side and never on git side?

> +convert a Subversion repository to a Git repository. It should not
> +be confused with linkgit:git-svnimport[1], which does Subversion to
> +Git conversion, but not the other direction.

We do not ship nor document svnimport anymore and linkgit: there is
actively wrong.  People seem to be confused with ancient documents still
floating on the Web that talk about svnimport, and I think it is a good
idea to try to clear the confusion here, but perhaps...

	... with the deprecated `git-svnimport`, which was used for
	one-way conversion from Subversion to git.

> @@ -520,6 +523,38 @@ have each person clone that repository with 'git clone':
>  	git-svn rebase
>  ------------------------------------------------------------------------
>  
> +CONVERTING A SUBVERSION REPOSITORY TO A GIT REPOSITORY
> +------------------------------------------------------
> +
> +When converting a Subversion repository to a Git repository
> +--no-metadata removes "git-svn-id:" comments from the log.
> +-A option is used to convert SVN pseudonyms to real names

Anything that user usually would type on the command line it is preferred
to typeset with `quoted like this`, so "`--no-metadata`" and "`-A` option".

It is not `--no-metadata` "removes".  git-svn adds cruft because it wants
to use it for bidi operation, but --no-metadata prevents it from doing
so.
