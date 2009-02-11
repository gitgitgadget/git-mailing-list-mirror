From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and rebased
 	remote branches
Date: Wed, 11 Feb 2009 16:35:23 -0500
Message-ID: <4993449B.2040401@xiplink.com>
References: <20090210202046.8EBEC3360AC@rincewind>	 <7v3aemm1po.fsf@gitster.siamese.dyndns.org>	 <4991FA18.1040200@xiplink.com> <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:37:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXMlR-0007kJ-T1
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 22:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbZBKVfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 16:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbZBKVfd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 16:35:33 -0500
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:53718 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbZBKVfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 16:35:33 -0500
Received: from relay2.r2.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay2.r2.iad.emailsrvr.com (SMTP Server) with ESMTP id 705DA44C078;
	Wed, 11 Feb 2009 16:35:26 -0500 (EST)
Received: by relay2.r2.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 41AA644C0C0;
	Wed, 11 Feb 2009 16:35:26 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <76718490902101513i504e515ocb4a2d789ba520f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109535>

Jay Soffian wrote:
> 
> The output of git remote show seems much too verbose for the
> information it provides. Something like this, I think, provides the
> same information in much less space:
> 
> * remote origin
>   URL: git://git.kernel.org/pub/scm/git/git.git
>   Remote branches:
>     html      Not tracked
>     maint     Tracked
>     man       Tracked
>     master    Tracked
>     next      Tracked
>     pu        Tracked
>     todo      Not tracked
>     old-next  Stale (would prune)
>   Local branches configured to pull from this remote:
>     master           upstream is master (merges)
>     wip/remote-HEAD  upstream is next   (rebases)

The current test case for 'remote show' (without my rebase patch) is:

* remote origin
  URL: $(pwd)/one
  Remote branch merged with 'git pull' while on branch master
    master
  New remote branch (next fetch will store in remotes/origin)
    master
  Tracked remote branches
    side
    master
  Local branches pushed with 'git push'
    master:upstream
    +refs/tags/lastbackup

Should that last bit about 'git push' change as well (I admit I don't really understand what that part is saying)?  Or should we just be consistent?  Maybe something like:

* remote origin
  URL: $(pwd)/one
  Remote branches:
    master  Tracked
    side    Not tracked
    flip    Tracked
  New remote branch (next fetch will store in remotes/origin)
    master
  Local branches tracking this remote:
    master   upstream is master (merges)
    rebaser  upstream is flip   (rebases)
  Local branches pushed with 'git push'
    master:upstream
    +refs/tags/lastbackup

		M.
