From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 01:26:59 +0100
Message-ID: <200603210126.59870.Josef.Weidendorfer@gmx.de>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us> <200603201730.19373.Josef.Weidendorfer@gmx.de> <7voe00iupp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 01:27:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLUif-00052M-G8
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 01:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWCUA1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 19:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWCUA1F
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 19:27:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:48050 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932224AbWCUA1C (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Mar 2006 19:27:02 -0500
Received: (qmail invoked by alias); 21 Mar 2006 00:27:00 -0000
Received: from p5496B08D.dip0.t-ipconnect.de (EHLO linux) [84.150.176.141]
  by mail.gmx.net (mp031) with SMTP; 21 Mar 2006 01:27:00 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7voe00iupp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17773>

On Tuesday 21 March 2006 00:04, you wrote:
> > Linus wanted to still be able to say "origin" which automatically
> > would map to "remotes/origin/master", where the name of the remote
> 
> I do not remember that,

See
http://www.gelato.unsw.edu.au/archives/git/0603/17405.html

I found it strange at first. But I think it is the right thing.

> I think what is reasonable is something like this:
> 
>  - If you start from a repository cloned in the traditional
>    way, the upstream "master" is kept track of with your
>    "origin", so "diff origin master" would be "my changes on top
>    of the upstream".

Yes. And it would be nice if the same would work with the new layout,
assuming that there is no local "origin" branch, but a .git/remotes/origin
file and .git/refs/remotes/origin directory.

>  - Regardless of how you started your cloned repository, with an
>    $GIT_DIR/{remotes,refs/heads,refs/remotes} editor I hinted in
>    a separate message, you can rearrange things to organize the
>    refs/ hierarchy any way you want.

Yes.
Still it would be nice to have a fixed convention here.
Eg. gitk could decorate the namespace in a special way.
Even if it is most of the time "origin" only.

> [Footnote]
> 
> *1* ... which currently I do not plan to do myself unless I have
> absolutely nothing else to do and really bored.  A sound of huge
> hint dropping ;-).

It should be as simple as (probably with quite some errors)

~/> cat git-rename-remote.sh
mv .git/refs/remotes/$1 .git/refs/remotes/$2
sed -e "s|remotes/$1|remotes/$2" .git/remotes/$1 > .git/remotes/$2
rm .git/remotes/$1

If you allow more freedom regarding the use of refs/remotes, it gets more
complicated both for the script and for the user to understand.

Josef
