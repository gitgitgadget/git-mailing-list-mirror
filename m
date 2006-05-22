From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Tue, 23 May 2006 01:08:41 +0200
Message-ID: <20060522230841.GM11941@pasky.or.cz>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE> <44722A8F.9020609@zytor.com> <20060522220206.GA10488@pasky.or.cz> <447239F0.9030705@zytor.com> <20060522225054.GL11941@pasky.or.cz> <4472432A.8010002@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 01:08:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiJVz-0001Kb-Fw
	for gcvg-git@gmane.org; Tue, 23 May 2006 01:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWEVXIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 19:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWEVXIk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 19:08:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:25281 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751146AbWEVXIk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 19:08:40 -0400
Received: (qmail 13166 invoked by uid 2001); 23 May 2006 01:08:41 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4472432A.8010002@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20545>

Dear diary, on Tue, May 23, 2006 at 01:03:06AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> Petr Baudis wrote:
> >
> >Even rsync and HTTP cg-clones? git:// and git+ssh:// fetching follows an
> >almost entirely different code patch and it's much more efficient since
> >I just accumulate the tag object ids I want to check and then pour them
> >to git-fetch-pack - I cannot do that with git-(local|http)-fetch. :-(
> >
> 
> No, but git-fetch-pack could operate over a local pipe just fine (after 
> all, all it does is ssh an "git-send-pack" command to the other side.)

Yes, but in that case it couldn't hardlink the objects so you would see
quite a big bump in disk usage if you have many local clones of the same
repo.

That said, hardlinking is probably not all that big an advantage if you
repack often, repack everywhere, and in the many-repositories cases it
might be more sensible to use alternates (which is what cg-clone -l
should really do instead of symlinking), so it might be well worth
the sacrifice.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
