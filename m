From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for
	backward compatibility.
Date: Thu, 4 Sep 2008 14:30:47 +0200
Message-ID: <20080904123046.GX10544@machine.or.cz>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com> <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 04 14:32:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbE0R-00032l-R7
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 14:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYIDMbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 08:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752873AbYIDMbA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 08:31:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45894 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbYIDMa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 08:30:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 94394393A367; Thu,  4 Sep 2008 14:30:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94928>

On Thu, Sep 04, 2008 at 02:00:52PM +0200, Matthieu Moy wrote:
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/git-annotate.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-annotate.txt b/Documentation/git-annotate.txt
> index 8b6b56a..6e05825 100644
> --- a/Documentation/git-annotate.txt
> +++ b/Documentation/git-annotate.txt
> @@ -14,6 +14,9 @@ DESCRIPTION
>  Annotates each line in the given file with information from the commit
>  which introduced the line. Optionally annotate from a given revision.
>  
> +This command exists for backward compatibility. For regular use, you
> +should use linkgit:git-blame[1] instead.
> +
>  OPTIONS
>  -------
>  include::blame-options.txt[]

Can you please also mark it deprecated in the bash completion and
command-list.txt?

Will we still keep it around indefinitely or do we have any phase-out
plan? If the latter, we should also start printing warning when
executing it.

I'm also curious about

                if (suspect->commit->object.flags & UNINTERESTING) {
                        if (blank_boundary)
                                memset(hex, ' ', length);
                        else if (!cmd_is_annotate) {
                                length--;
                                putchar('^');
                        }
                }

in builtin-blame.c. Junio, you introduced this in e68989a739d - why
do you use a separate flag instead of OUTPUT_ANNOTATE_COMPAT? The fact
that git annotate == git blame -c does not hold true because of this
(admittedly obscure case).

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
