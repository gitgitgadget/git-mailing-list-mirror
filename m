From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-merge: at least one <remote> not two
Date: Thu, 01 Jan 2009 13:25:02 -0800
Message-ID: <7vk59ehg7l.fsf@gitster.siamese.dyndns.org>
References: <87d4f6vph7.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Thu Jan 01 22:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIV3s-0003Ve-Uf
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZAAVZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZAAVZK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:25:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZAAVZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:25:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 249D61B8BB;
	Thu,  1 Jan 2009 16:25:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD71A1B8B8; Thu, 
 1 Jan 2009 16:25:03 -0500 (EST)
In-Reply-To: <87d4f6vph7.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Fri, 02 Jan 2009 02:41:08 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A959710C-D84A-11DD-9B07-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104328>

jidanni@jidanni.org writes:

> Make SYNOPSIS match usage message
>
> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---
>  Documentation/git-merge.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index f7be584..a3ac828 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
> -	[-m <msg>] <remote> <remote>...
> +	[-m <msg>] <remote>...
>  'git merge' <msg> HEAD <remote>...

The original uses ellipses for the first-class UI syntax as "zero or
more", while it means "one or more" in the description for the original
syntax, which is inconsistent, and you are matching them by making both
use "one or more" interpretation.

Two issues:

 * Are there similar breakages like this in the documentation and the
   usage text?  It would be a good idea to make the ellipses to mean the
   same thing everywhere, and a janitorial patch series that would fix
   the "ellipses" breakage (and nothing else) may be a good thing to
   have.  But before going that route...

 * Is it a good idea to standardize on "one or more" semantics?  I suspect
   we would rather want to standardize on "zero or more", because it would
   be more natural to say:

    $ git diff [--] <paths>...

   to mean "You can give paths if you want to but you do not have to".  If
   ellipses meant "one or more", you have to say this instead:

    $ git diff [--] [<paths>...]

While I prefer "zero or more" because  I think it is more logical, if the
preparatory study for the first issue reveals that we use "one or more" a
lot more often, it might be easier to standardize on that interpretation.

Oh, you also need to give ellipses to the usage string for the original
syntax in builtin-merge.c to match SYNOPSIS and usage string.

Thanks.
