From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Moved files and merges
Date: Sat, 3 Sep 2005 20:59:13 +0200
Message-ID: <20050903185912.GA8379@mars.ravnborg.org>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net> <7vek867e29.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 20:57:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBdCP-00071E-RN
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 20:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVICS5E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVICS5D
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 14:57:03 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:25721 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S1751187AbVICS5D
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Sep 2005 14:57:03 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepb.post.tele.dk (Postfix) with ESMTP id D81D65EE013;
	Sat,  3 Sep 2005 20:56:52 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 2B1966AC01D; Sat,  3 Sep 2005 20:59:13 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek867e29.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8044>

On Sat, Sep 03, 2005 at 01:25:50AM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> >
> >> I currently have two klibc trees,
> >
> > I cloned them to take a look.  You_do_ seem to have a lot of
> > renames.
> 
> Well, I think I understand how your trees ancestry looks like,
> but still haven't come up with a good problem definition.  I am
> sorry that this message is not a solution for your problem but
> would end up to be just my rambling and thinking aloud.
> 
> The ancestry looks like this:
> 
>        ----#4-#5---#7   #0: 1.0.14 released, next version is 1.0.15
>       /      /              5691e96ebfccd21a1f75d3518dd55a96b311d1aa
>      /---#1-#3---#6     #1: Explain why execvpe/execlpe work the way they do.
>     //     /                1d774a8cbd8e8b90759491591987cb509122bd78
>   #0-----#2             #2: 1.1 released, next version is 1.1.1
>                             3a41b60f6730077db3f04cf2874c96a0e53da453
>                         #3: Merge of #2 into #1
>                             7ab38d71de2964129cf1d5bc4e071d103e807a0d
>                         #4: socketcalls aren't always *.S files; they can...
>                             f52be163e684fc3840e557ecf242270926136b67
>                         #5: Merge of #3 into #4
>                             2e2a79d62a96b6b0d4bc93697fe77cd3030cdfd9
>                         #6: Warnings cleanup
>                             f5260f8737517f19a03ee906cd64dfc9930221cd
>                         #7: Remove obsoleted files from merge
>                             59709a172ee58c9d529a8c4b6f5cf53460629cb3
> 
> and you are trying to merge #6 into #7 (or #7 into #6).  #6 does
> not have usr/kinit and nfsmount at the top; #7 has nfsmount
> under usr/kinit/.


Hi Junio.

Ican expalin some of the background for this particular merge.
At about one month ago I cloned the current klibc.git tree and started
doing the necessary modifications needed to introduce kbuild - the
build system used in the kernel.
Futhermore we decided to move files around so they fit the directory
structure planned to be used in the kernel - when we at one point in the
future merged with mainline.
While I were modifying the build system the development continued and a
few files saw some updates in the official klibc tree.

So what we want to do in this case is:
- Merge the kbuild changes into the official tree without loosing the
  changes made to renamed files.

On purpose I did not modify any of the renamed files so the klibc-kbuild
tree contains renames only for these.

If it would be possible to merge:
libs/klibc/klibc.git and libs/klibc/sam/klibc-kbuild.git
using the above rules it would be perfect.

Then a few of the patches from libs/klibc/klibc-kbuild.git would have to
be applied again, but thats doable.

Anyway my view on it. Since Peter is the one doing the merge he may have
better ideas.

	Sam
