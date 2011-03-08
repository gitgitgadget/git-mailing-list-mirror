From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH] cherry-pick -x: add newline before pick note
Date: Tue, 8 Mar 2011 12:54:33 +0000 (UTC)
Message-ID: <loom.20110308T134920-72@post.gmane.org>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 14:20:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwwph-0001B0-Ab
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 14:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247Ab1CHNUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 08:20:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:35056 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab1CHNUG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 08:20:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PwwpY-00019F-RY
	for git@vger.kernel.org; Tue, 08 Mar 2011 14:20:04 +0100
Received: from berlin-gw.trolltech.de ([77.245.47.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 14:20:04 +0100
Received: from ossi by berlin-gw.trolltech.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 14:20:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.245.47.26 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.16) Gecko/20110107 Iceweasel/3.5.16 (like Firefox/3.5.16))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168663>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:
> Currently, cherry-pick -x sticks the pick note immediately after the
> existing commit message. This
> 
> * is bad for commits with 1 line subject (it makes a 2 line subject)
> * is different from git-svn, e.g., which leaves an empty line before.
> 
> Make cherry-pick always insert an empty line before the pick note.
> 
> Reported-by: Martin Svensson <martin.k.svensson <at> netinsight.se>
> Signed-off-by: Michael J Gruber <git <at> drmicha.warpmail.net>
> ---
>  builtin/revert.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 57b51e4..9251257 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -485,7 +485,7 @@ static int do_pick_commit(void)
>  		set_author_ident_env(msg.message);
>  		add_message_to_msg(&msgbuf, msg.message);
>  		if (no_replay) {
> -			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
> +			strbuf_addstr(&msgbuf, "\n(cherry picked from commit ");
>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}

so while everybody is apparently thinking about totally over-engineering
things as much as possible, could we please have this patch applied so we
have a solution for the time being? i really hate to tell my coworkers that
they have to amend the cherry-picks just to make them comply with git's
own guidelines for well-formed commit messages (and thus have them pass
our pre-receive hook).

regards
