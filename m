From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] git-rev-size: calculate sizes of repository
Date: Mon, 21 Aug 2006 01:36:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608210130010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060820105452.GA19630@nospam.com>
 <Pine.LNX.4.63.0608201519360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060820152404.GA5679@nospam.com> <Pine.LNX.4.63.0608201805070.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vlkpjytnj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Rutger Nijlunsing <git@wingding.demon.nl>
X-From: git-owner@vger.kernel.org Mon Aug 21 01:36:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEwqS-0000SP-J9
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 01:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWHTXgj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 19:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWHTXgj
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 19:36:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:54158 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932088AbWHTXgi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Aug 2006 19:36:38 -0400
Received: (qmail invoked by alias); 20 Aug 2006 23:36:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 21 Aug 2006 01:36:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkpjytnj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25773>

Hi,

On Sun, 20 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 20 Aug 2006, Rutger Nijlunsing wrote:
> >
> >> I _knew_ it... Please go bug someone else. The only thing I did was
> >> help someone, and for that I choose my own tools since I do it for
> >> fun.
> >
> > Fair enough.
> >
> > -- 8< --
> > [PATCH] Add git-rev-size
> >
> > This tool spits out the number of trees, the number of blobs, and the total
> > bytes of the blobs for a given rev range.
> 
> I do not speak ruby (well I suspect I could read it if I wanted
> to but I didn't try) so this may or may not be something
> Johannes inherited from the original,

No, it was no rewrite. But looking at the Ruby code again, it is not 
really similar: the builtin uses the hash to cache the sizes even for a 
blob. Further, it does not unpack the objects (except for the trees, and 
for the revision walk if you limit by pathname). However, it inherits 
this:

> but I think the code overcounts blobs and trees for a top-level tree 
> that happens to have the same blob (or tree) twice.  I am not sure if 
> that is intended.
> 
> Overcounting would give closer estimate for how big a tar
> archive would be, or how big an populated working tree would be,
> so it could be considered a feature.  It all depends on what
> this tools is useful for, I guess.

I dunno. No idea what the original requester wanted to do with it.

For me, it was a nice distraction from my work. And a nice occasion to 
finally copy^H^H^H^Himplement the independent hash map code I always 
wanted to refactor from object.c. And a nice demonstration how easy it 
actually is these days to implement a builtin.

Ciao,
Dscho
