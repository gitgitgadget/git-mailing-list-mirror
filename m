From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 16:46:29 -0300
Message-ID: <200701211946.l0LJkTMV022057@laptop13.inf.utfsm.cl>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 21:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8j1T-0006Wq-1p
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 21:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXAUUKf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 15:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXAUUKf
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 15:10:35 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:56293 "EHLO
	pincoya.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbXAUUKe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 15:10:34 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by pincoya.inf.utfsm.cl (8.14.0.Beta5/8.14.0.Beta5) with ESMTP id l0LJkaCe020932;
	Sun, 21 Jan 2007 16:46:36 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l0LJkTMV022057;
	Sun, 21 Jan 2007 16:46:34 -0300
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
Comments: In-reply-to Junio C Hamano <junkio@cox.net>
   message dated "Sun, 21 Jan 2007 03:20:06 -0800."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Virus-Scanned: ClamAV 0.88.7/2476/Sun Jan 21 13:22:33 2007 on pincoya.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_05,
	UNPARSEABLE_RELAY autolearn=ham version=3.1.4
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	pincoya.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37341>

Junio C Hamano <junkio@cox.net> wrote:
> BTW, as the upcoming v1.5.0 release will introduce quite a bit of
> surface changes (although at the really core it still is the old
> git and old ways should continue to work), I am wondering if it
> would help people to try out and find wrinkles before the real
> thing for me to cut a tarball and a set of RPM packages.
> 
> Comments?
> 
> Also, in the same spirit of giving the release an early
> exposure, here is the current draft of 1.5.0 release notes.
> 
> -- >8 -- cut here -- >8 --
> 
> GIT v1.5.0 Release Notes (draft)
> ================================
> 
> Old news
> --------

[...]

>  - There is a configuration variable core.legacyheaders that
>    changes the format of loose objects so that they are more
>    efficient to pack and to send out of the repository over git
>    native protocol, since v1.4.2.  However, loose objects
>    written in the new format cannot be read by git older than
>    that version; people fetching from your repository using
>    older clients over dumb transports (e.g. http) using older
>    versions of git will also be affected.

Huh?

What are possible values of that variable? What happens if it is set/unset?
I'd suppose that if it is set, you get the old format, but that isn't clear.

>  - Since v1.4.3, configuration repack.usedeltabaseoffset allows
>    packfile to be created in more space efficient format, which
>    cannot be read by git older than that version.

Same as above.

> The above two are not enabled by default and you explicitly have
> to ask for them, because these two features make repositories
> unreadable by older versions of git, and in v1.5.0 we still do
> not enable them by default for the same reason.  We will change
> this default probably 1 year after 1.4.2's release, when it is
> reasonable to expect everybody to have new enough version of
> git.

I don't see an upgrade path here that doesn't involve keeping cruft "new
feature is on" variables around indefinitely... Why not just a repository
version?

[...]

> Updates in v1.5.0 since v1.4.4 series
> -------------------------------------
> 
> * Index manipulation

[...]

>  - git-add without any argument does not add everything
>    anymore.  Use 'git-add .' instead.  Also you can add
>    otherwise ignored files with an -f option.

I suppose "git add ." works for 'adding everything' only at the top?

>  - git-add tries to be more friendly to users by offering an
>    interactive mode.

Why not tell about "git add -i"?

[...]

> * Detached HEAD

[...]

>  - After detaching your HEAD, you can go back to an existing
>    branch with usual "git checkout $branch".  Also you can
>    start a new branch using "git checkout -b $newbranch".

Where is such a branch rooted?

>  - You can even pull from other repositories, make merges and
>    commits while your HEAD is detached.  Also you can use "git
>    reset" to jump to arbitrary commit.

Does this leave you on that branch, or still in limbo?

>    Going back to undetached state by "git checkout $branch" can

s/undetached/attached/

>    lose the current stat you arrived in these ways, and "git
>    checkout" refuses when the detached HEAD is not pointed by
>    any existing ref (an existing branch, a remote tracking
>    branch or a tag).  This safety can be overriden with "git
>    checkout -f $branch".

What happens if there are changes in the tracked files?

[...]

> * Shallow clones
> 
>  - There is a partial support for 'shallow' repositories that
>    keeps only recent history.  A 'shallow clone' is created by
>    specifying how deep that truncated history should be.

A bit of detail on how to specify shallowness would be nice here...


Very nice work, thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
