From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-submodule.txt: Further clarify the
 description
Date: Thu, 17 Jul 2008 13:24:22 -0700
Message-ID: <7v4p6ofedl.fsf@gitster.siamese.dyndns.org>
References: <20080717121813.GC10151@machine.or.cz>
 <20080717122911.32334.73465.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Heikki Orsila <shdl@zakalwe.fi>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 17 22:25:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJa2c-0001oh-Fk
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 22:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745AbYGQUYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 16:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759373AbYGQUYb
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 16:24:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758316AbYGQUYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 16:24:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F96D2E16E;
	Thu, 17 Jul 2008 16:24:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 433482E163; Thu, 17 Jul 2008 16:24:24 -0400 (EDT)
In-Reply-To: <20080717122911.32334.73465.stgit@localhost> (Petr Baudis's
 message of "Thu, 17 Jul 2008 14:29:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B8F7DC6-543E-11DD-BB7F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88909>

Petr Baudis <pasky@suse.cz> writes:

> This patch rewrites the general description yet again, first clarifying
> the high-level concept, mentioning the difference to remotes and using
> the subtree merge strategy, then getting to the details about tree
> entries and .gitmodules file.
>
> The patch also makes few smallar grammar fixups of the rest of the
> description and clarifies how does 'init' relate to 'update --init'.
>
> Cc: Heikki Orsila <shdl@zakalwe.fi>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>
>  Documentation/git-submodule.txt |   39 +++++++++++++++++++++++++++------------
>  1 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index bb4e6fb..01d0d91 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -18,24 +18,35 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +Submodules allow foreign repositories to be embedded within a dedicated
> +subdirectory of the source tree, always pointed at a particular commit.
> +They are not to be confused with remotes, which are meant mainly for branches
> +of the same project; submodules are meant for different projects you would like

Your lines are getting overlong to be easily quoted and commented...

> +....  In case you want to merge the project
> +histories, possibly make local modifications within the tree, but also do not
> +mind that your repository will bulk up with all the contents of the other
> +project, consider adding a remote for the other project and using the 'subtree'
> +merge strategy instead of setting up a submodule.

I'd suggest rephrasing "do not mind" to something a lot less nagative.
The user decides to merge because both histories *are* relevant and at
that point there is no _minding_ anymore.  If you want to have them, you
not only "do not mind to have" them but you positively "want" them.

On the other hand, a situation where you would want to use submodules is
when not necessarily all users of the superproject would want to have all
submodules cloned nor checked out.  This needs to be stressed with equal
weight as the above sentence in this "contrasting merged histories and
submodules" paragraph.  With that explained clearly upfront, it would
become easier for the readers to understand why you can choose not to even
update nor fetch submodules you are not interested in.

> +Submodules are composed from a special kind of tree entry (so-called `gitlink`)
> +in the main repository that refers to a particular commit object within

Do we have to say "special"?  Is a gitlink any more special than blob and
tree entries are?  It tends to be rarer, it came later, but I do not think
there is anything special from the end user's point of view.

>  checked out and at appropriate revision in your working tree. You can inspect
>  the current status of your submodules using the 'submodule' subcommand and get
> +an overview of the changes 'update' would perform using the 'summary'
> +subcommand.

Sorry, cannot parse the last three lines...
