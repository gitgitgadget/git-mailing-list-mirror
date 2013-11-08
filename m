From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Fri, 08 Nov 2013 17:39:01 -0500
Message-ID: <527D6805.3050303@xiplink.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>	<vpqtxfo8ow4.fsf@anie.imag.fr> <xmqqli0yojp8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Nov 08 23:38:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeuhT-0004H7-IY
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 23:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392Ab3KHWin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 17:38:43 -0500
Received: from smtp66.ord1c.emailsrvr.com ([108.166.43.66]:60865 "EHLO
	smtp66.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757800Ab3KHWim (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Nov 2013 17:38:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 090D5148371;
	Fri,  8 Nov 2013 17:38:42 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp1.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9C0141483DF;
	Fri,  8 Nov 2013 17:38:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqli0yojp8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237470>

On 13-11-08 01:02 PM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> 	When push.default is set to 'matching', git will push local branches
>>> 	to remote branches that already exist with the same (matching) name.
>>
>> Yes, that's better than the original patch (and remains two lines).
>> ...
>>
>>> 	In Git 2.0, git will default to a more conservative 'simple' behavior
>>> 	that only pushes the current branch.
>>
>> That's an option too, but I think mentionning "git pull" was a good
>> idea.
> 
> OK, I'll tentatively update the draft to read like this, redo the
> endgame patch on top and requeue.
> 
>  builtin/push.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/push.c b/builtin/push.c
> index 5393e28..27c5754 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -174,14 +174,12 @@ N_("push.default is unset; its implicit value is changing in\n"
>     "\n"
>     "  git config --global push.default simple\n"
>     "\n"
> -   "When push.default is set to 'matching', git will push all local branches\n"
> -   "to the remote branches with the same (matching) name.  This will no\n"
> -   "longer be the default in Git 2.0 because a branch could be\n"
> -   "unintentionally pushed to a remote.\n"
> +   "When push.default is set to 'matching', git will push local branches\n"
> +   "to the remote branches that already exist with the same name.\n"
>     "\n"
> -   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
> -   "branch to the same remote branch used by git pull.   A push will\n"
> -   "only succeed if the remote and local branches have the same name.\n"
> +   "In Git 2.0, Git will default to the more conservative 'simple'\n"
> +   "behavior that only pushes the current branch to the corresponding\n"
> +   "remote branch used by 'git pull' to update the current branch from.\n"

That reads a bit awkwardly.  How about:

	In Git 2.0, Git will default to the more conservative 'simple'
	behavior, which only pushes the current branch to the corresponding
	remote branch that 'git pull' uses to update the current branch.

		M.
