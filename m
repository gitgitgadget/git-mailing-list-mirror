From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/5] Migrate git-checkout.sh to use git-rev-parse --parseopt --keep-dashdash
Date: Sun, 04 Nov 2007 00:44:03 -0700
Message-ID: <7v7ikytpz0.fsf@gitster.siamese.dyndns.org>
References: <1194043193-29601-5-git-send-email-madcoder@debian.org>
	<1194112219-19968-1-git-send-email-madcoder@debian.org>
	<1194112219-19968-2-git-send-email-madcoder@debian.org>
	<1194112219-19968-3-git-send-email-madcoder@debian.org>
	<1194112219-19968-4-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioa9u-0006EB-8U
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 08:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbXKDHoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 02:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbXKDHoY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 02:44:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57784 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbXKDHoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 02:44:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C64AE2EF;
	Sun,  4 Nov 2007 02:44:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1623A90E26;
	Sun,  4 Nov 2007 02:44:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63359>

Pierre Habouzit <madcoder@debian.org> writes:

> Also fix some space versus tabs issues.
> ---
>  git-checkout.sh |   99 +++++++++++++++++++++++++++----------------------------
>  1 files changed, 49 insertions(+), 50 deletions(-)
>
> diff --git a/git-checkout.sh b/git-checkout.sh
> index 8993920..5424745 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -1,6 +1,16 @@
>  #!/bin/sh
>  
> -USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
> +PARSEOPT_OPTS=--keep-dashdash
> +OPTIONS_SPEC="\
> +git-branch [options] [<branch>] [<paths>...]
> +--
> +b=          create a new branch started at <branch>
> +l           create the new branchs reflog
> +track       tells if the new branch should track the remote branch
> +f           proceed even if the index or working tree is not HEAD
> +m           performa  three-way merge on local modifications if needed
> +q,quiet     be quiet
> +"

Ok, so this is how PARSEOPT_OPTS gets used.  It is a way for the
command that sources git-sh-setup to tell the parseopt code what
to do.  I can agree with this, but then all the other commands
that do not set PARSEOPT_OPTS before sourcing git-sh-setup
should set it to empty string.  Otherwise the users can screw
you with their environment variables.
