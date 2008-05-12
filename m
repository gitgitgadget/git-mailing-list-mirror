From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 15:10:30 -0500
Message-ID: <5d46db230805121310q5a0c6037p769ea091c26284d0@mail.gmail.com>
References: <20080512122900.GA13050@mithlond.arda.local>
	 <20080512155243.GA3592@mithlond.arda.local>
	 <alpine.DEB.1.00.0805121810501.30431@racer>
	 <20080512184334.GB5160@mithlond.arda.local>
	 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
	 <20080512190946.GC5160@mithlond.arda.local>
	 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon May 12 22:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JveNL-0005Lj-Ik
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 22:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYELUKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 16:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbYELUKq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 16:10:46 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:26601 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYELUKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 16:10:45 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1394113ywe.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 13:10:30 -0700 (PDT)
Received: by 10.150.68.2 with SMTP id q2mr8753099yba.89.1210623030910;
        Mon, 12 May 2008 13:10:30 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Mon, 12 May 2008 13:10:30 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81917>

On Mon, May 12, 2008 at 2:36 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 12 May 2008, Teemu Likonen wrote:
>
>  > Nicolas Pitre wrote (2008-05-12 14:56 -0400):
>  >
>  > > On Mon, 12 May 2008, Teemu Likonen wrote:
>  > >
>  > > > Well, I don't really have any problems with the current behaviour;
>  > > > it just feels a bit strange that, for example, Linus's kernel
>  > > > repository grew about 90MB after just one update pull and gc.
>  > >
>  > > That looks really odd.  Sure the repo might grow a bit, but 90MB seems
>  > > really excessive.  How many time did pass between the initial clone
>  > > and that subsequent pull?
>  >
>  > As I used the kernel repo just for testing this behaviour in question
>  > I did both things today. Timestamps tell that there were six hours
>  > between the initial .keep pack and the new pack created by manual "git
>  > gc".
>
>  This is way too big a difference.  Something is going on.
>
>  What git version is this? And can you send me the content of your
>  .git/logs directory?
>
>
>  > > > Also, dangling objects are kept forever in .keep packs (which are
>  > > > created with "git clone", for example).
>  > >
>  > > A pack obtained via 'git clone' will never contain any dangling
>  > > objects.
>  >
>  > I think it can contain at some later point. For example, if a user first
>  > fetches all the branches but later decides to track only one branch.
>  > After deleting unneeded tracking branches and expiring the reflog
>  > there'll be dangling objects in the original .keep pack created with
>  > "git clone".
>
>  Sure.  But to decide to track only one branch and exclude the others
>  require some higher level of git knowledge already.  At that point if
>  you really care about top packing performances you certainly can deal
>  with the .keep file as well.
>
>

I have had some similar problems with .keep files.  I cloned a repo I
created that had a branch that I wasn't interested in.  I deleted the
branch and then I could never get rid of the (large) number of objects
in that pack until I deleted the .keep and repacked.  I think there
should be some way of forcing git to fix this sort of thing.

It gets even worse, I had pushed up the branch I wanted to get rid of
to my hosted server and there was no way to get git to release that
disk space.  I had to have the hosting admin send me a tarball
of the repo, extract it, delete the .keep file and repack it then send
it back to him.  I was fortunate enough to have a service that would
let me do that.

Thanks,
Govind.
