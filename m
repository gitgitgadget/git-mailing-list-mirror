From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 1/5] fetch doc: update introductory part for clarity
Date: Fri, 30 May 2014 10:35:24 -0400
Message-ID: <5388972C.5020307@xiplink.com>
References: <1401403350-7122-1-git-send-email-gitster@pobox.com> <1401403350-7122-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 16:35:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqNtf-0001ai-2C
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 16:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbaE3Oe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 10:34:58 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:42728 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933107AbaE3Oe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 10:34:58 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 1523E1C10E3;
	Fri, 30 May 2014 10:34:57 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 3CAAE1C1076;
	Fri, 30 May 2014 10:34:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401403350-7122-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250439>

On 14-05-29 06:42 PM, Junio C Hamano wrote:
>  - "Branches" is a more common way to say "heads" in these days.
> 
>  - Remote-tracking branches are used a lot more these days and it is
>    worth mentioning that it is one of the primary side effects of
>    the command to update them.
> 
>  - Avoid "X. That means Y."  If Y is easier to understand to
>    readers, just say that upfront.
> 
>  - Use of explicit refspec to fetch tags does not have much to do
>    with turning "auto following" on or off.  It is a way to fetch
>    tags that otherwise would not be fetched by auto-following.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-fetch.txt | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
> index 5809aa4..d5f5b54 100644
> --- a/Documentation/git-fetch.txt
> +++ b/Documentation/git-fetch.txt
> @@ -17,20 +17,23 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Fetches named heads or tags from one or more other repositories,
> -along with the objects necessary to complete them.
> -
> -The ref names and their object names of fetched refs are stored
> -in `.git/FETCH_HEAD`.  This information is left for a later merge
> -operation done by 'git merge'.
> -
> -By default, tags are auto-followed.  This means that when fetching
> -from a remote, any tags on the remote that point to objects that exist
> -in the local repository are fetched.  The effect is to fetch tags that
> +Fetch branches and/or tags (collectively, "refs") from one or more
> +other repositories, along with the objects necessary to complete the
> +histories of them.

Phrasing: s/the histories of them/their histories/

> +
> +The names of refs that are fetched, together with the object names
> +they point at, are written to `.git/FETCH_HEAD`.  This information
> +is used by a later merge operation done by 'git merge'.  In addition,

Isn't this merge stuff about pull, not fetch?

> +the remote-tracking branches may be updated (see description on
> +<refspec> below for details).

I realize that "may be updated" is strictly correct, in that if the remote's
branches have not changed since the last fetch then the local tracking
branches won't change.

But it took me a second or two to think of that.  The "may" kindof tripped me
up.  The fact is that the local tracking branches are always updated to match
the remote's branches, it's just that sometimes the remote's branches don't
change.  So I think it would be clearer to say

	the remote-tracking branches are updated

because this makes it clear that the command always makes your local tracking
branches match the remote's.

		M.

> +
> +By default, any tag that points into the histories being fetched is
> +also fetched; the effect is to fetch tags that
>  point at branches that you are interested in.  This default behavior
> -can be changed by using the --tags or --no-tags options, by
> -configuring remote.<name>.tagopt, or by using a refspec that fetches
> -tags explicitly.
> +can be changed by using the --tags or --no-tags options or by
> +configuring remote.<name>.tagopt.  By using a refspec that fetches tags
> +explicitly, you can fetch tags that do not point into branches you
> +are interested in as well.
>  
>  'git fetch' can fetch from either a single named repository,
>  or from several repositories at once if <group> is given and
> 
