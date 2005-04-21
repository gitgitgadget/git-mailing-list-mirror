From: Steven Cole <elenstev@mesatop.com>
Subject: Re: Possible problem with git-pasky-0.6.2 (patch: **** Only garbage was found in the patch input.)I
Date: Wed, 20 Apr 2005 18:20:27 -0600
Message-ID: <200504201820.27497.elenstev@mesatop.com>
References: <200504201706.09656.elenstev@mesatop.com> <20050420231212.GN19112@pasky.ji.cz> <200504201715.00058.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 02:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOPQc-0003Cn-4i
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 02:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVDUAYm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 20:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVDUAYm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 20:24:42 -0400
Received: from nacho.zianet.com ([216.234.192.105]:16652 "HELO
	nacho.zianet.com") by vger.kernel.org with SMTP id S261858AbVDUAYh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 20:24:37 -0400
Received: (qmail 42738 invoked from network); 21 Apr 2005 00:24:33 -0000
Received: from 216-31-65-218.zianet.com (216.31.65.218)
  by 0 with SMTP; 21 Apr 2005 00:24:33 -0000
To: Petr Baudis <pasky@ucw.cz>
User-Agent: KMail/1.6.1
In-Reply-To: <200504201715.00058.elenstev@mesatop.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 April 2005 05:15 pm, Steven Cole wrote:
> On Wednesday 20 April 2005 05:12 pm, Petr Baudis wrote:
> > Dear diary, on Thu, Apr 21, 2005 at 01:06:09AM CEST, I got a letter
> > where Steven Cole <elenstev@mesatop.com> told me that...
> > > After getting the latest tarball, and make, make install:
> > > 
> > > Tree change: 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea322221
> > > *100755->100755 blob    a78cf8ccab98861ef7aecb4cb5a79e47d3a84b67->74b4083d67eda87d88a6f92c6c66877bba8bda8a     gitcancel.sh
> > > Tracked branch, applying changes...
> > > Fast-forwarding 55f9d5042603fff4ddfaf4e5f004d2995286d6d3 -> a46844fcb6afef1f7a2d93f391c82f08ea322221
> > >         on top of 55f9d5042603fff4ddfaf4e5f004d2995286d6d3...
> > > patch: **** Only garbage was found in the patch input.
> > > 
> > > This may be a harmless message, but I thought I'd bring it to your attention.
> > 
> > This _is_ weird. What does
> > 
> > 	$ git diff -r 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea32222
> > 
> > tell you? 
> 
> [steven@spc git-pasky-0.6.2]$ git diff -r 55f9d5042603fff4ddfaf4e5f004d2995286d6d3:a46844fcb6afef1f7a2d93f391c82f08ea32222
> Index: gitcancel.sh
[ output snipped, see previous message for output]
> 
> > What if you feed it to patch -p1? 
> I haven't done that yet, awaiting response to above.
> 
> > What if you feed it to git  
> > apply?
> > 
> > Thanks,
> > 
> Your're welcome.  I'll do the "git patch -p1 <stuff_from_above" if that's what's needed,
> same with git apply.  Corrrections to syntax apprceciated.
> Steven

Actually, I meant "patch -p1 <stuff_from_above".

But before doing that, I did a fsck-cache as follows, with these results.
This seems damaged.

[steven@spc git-pasky-0.6.2]$ fsck-cache --unreachable $(cat .git/HEAD)
root 1bf00e46973f7f1c40bc898f1346a1273f0a347f
unreachable commit 0128396de7ca8a7dc74f6fbff59a68bb781bb9b2
unreachable blob 012c82312c99606f914bda5c501b616237a3b7e9
unreachable tree 02a1b5337f78b807d4404f473e55c44f4273d2f8

[ lots of snippage...]

unreachable blob fee26cc5b378819ff48ef8cb54c35744c0f1c17f
unreachable tree fff7294434014ea68153770da3965ed315806499

[steven@spc git-pasky-0.6.2]$ fsck-cache --unreachable $(cat .git/HEAD) | wc -l
467

I renamed the repo to git-pasky-0.6.2-damaged, and repeated untarring the 0.6.2 tarball,
make, (didn't do make install this time), and repeated "git pull pasky" with
similar results as before.

[steven@spc git-pasky-0.6.2-damaged]$ cat .git/HEAD
a46844fcb6afef1f7a2d93f391c82f08ea322221
[steven@spc git-pasky-0.6.2-damaged]$ cd ../git-pasky-0.6.2
[steven@spc git-pasky-0.6.2]$ cat .git/HEAD
7a4c67965de68ae7bc7aa1fde33f8eb9d8114697

Hope this helps,
Steven

