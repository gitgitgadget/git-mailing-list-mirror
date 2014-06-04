From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 5/9] fetch doc: on pulling multiple refspecs
Date: Wed, 04 Jun 2014 10:44:18 -0400
Message-ID: <538F30C2.2000601@xiplink.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com> <1401833792-2486-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 16:44:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsCQj-0006c9-53
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 16:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaFDOof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 10:44:35 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:55172 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbaFDOoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 10:44:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 5D7392008A2;
	Wed,  4 Jun 2014 10:44:13 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 0E1B7200645;
	Wed,  4 Jun 2014 10:44:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1401833792-2486-6-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250731>

On 14-06-03 06:16 PM, Junio C Hamano wrote:
> Replace desription of old-style "Pull:" lines in remotes/
> configuration with modern remote.*.fetch variables.
> 
> As this note applies only to "git pull", enable it only
> in git-pull manual page.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/pull-fetch-param.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
> index 40f8687..25af2ce 100644
> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -34,22 +34,26 @@ will be needed for such branches.  There is no way to
>  determine or declare that a branch will be made available
>  in a repository with this behavior; the pulling user simply
>  must know this is the expected usage pattern for a branch.
> +ifdef::git-pull[]
>  +
>  [NOTE]
>  There is a difference between listing multiple <refspec>
>  directly on 'git pull' command line and having multiple
> -`Pull:` <refspec> lines for a <repository> and running
> +`remote.<repository>.fetch` entries in your configuration
> +for a <repository> and running

s/running/running a/

>  'git pull' command without any explicit <refspec> parameters.
>  <refspec> listed explicitly on the command line are always

s/<refspec>/<refspec>s/

>  merged into the current branch after fetching.  In other words,
>  if you list more than one remote refs, you would be making

s/refs, you would be making/ref, 'git pull' will create/

> -an Octopus.  While 'git pull' run without any explicit <refspec>
> -parameter takes default <refspec>s from `Pull:` lines, it
> +an Octopus merge. On the other hand, 'git pull' that is run
> +without any explicit <refspec> parameter takes default
> +<refspec>s from `remote.<repository>.fetch` configuration, it
>  merges only the first <refspec> found into the current branch,
> -after fetching all the remote refs.  This is because making an
> +after fetching all the remote refs specified.  This is because making an

That "On the other hand" sentence is hard to parse.  How about

	On the other hand, if you do not list any remote refs, 'git pull'
	will fetch all the <refspec>s it finds in the
	`remote.<repository>.fetch` configuration and merge only the
	first <refspec> found into the current branch.

Actually, "first <refspec> found" is also wrong, isn't it?  I'm not sure I
can craft a succinct summary of pull's merge behaviour for this note!

>  Octopus from remote refs is rarely done, while keeping track
>  of multiple remote heads in one-go by fetching more than one
>  is often useful.
> +endif::git-pull[]
>  +
>  Some short-cut notations are also supported.
>  +

Hmmm, in my 2.0 man page output (asciidoc 8.6.9 on Ubuntu) there's no empty
line between the end of the note and the "Some short-cut notations" line,
which I think is inconsistent with the rest of the formatting.  The HTML
version looks fine though.  Is there some asciidoc-ese that would insert a
line there for the man format?

		M.
