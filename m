From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 15:11:48 -0500
Message-ID: <9e4733910802101211v11c0e285teb36f06d9a0e5f37@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
	 <200802091627.25913.kendy@suse.cz>
	 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
	 <alpine.LSU.1.00.0802101640570.11591@racer.site>
	 <alpine.LSU.1.00.0802101845320.11591@racer.site>
	 <alpine.LFD.1.00.0802101437040.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jan Holesovsky" <kendy@suse.cz>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIXr-0003h9-7H
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbYBJULw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752692AbYBJULv
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:11:51 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:37292 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162AbYBJULu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:11:50 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1731446wah.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5fgGNzMxBFiCJaQagWd33FjGn5g7HFedtaNqbdaXnqk=;
        b=gxve+8HboVTwZLzzL2XwOp4oVcGgjA+uD0vCT36y5uXzblLQxo4E4t/xOIPAUp128KGAahht/GNPfCxVwM4pDm99JDG7UAvSUUaDT0aZiqf0EZcUx3OkZeAfsRT/OEtNCN/cuAAbMePDmd5Tlw/EEjLirxsqokoiRidmv+V3N1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SD8GgKbYhxdlOw02HiJ4tXneBpAugea1hN31BnHWG8nDCNbhu1BMbI8SZUeVJ+/aCAM5ypCjGjiRJ/kPBBGX8oKaJNH/QnrfVn15VAojpQLgiWW2YfMDlPTMa/pzMf/Ahz2ztW+quL07NrM9pvN88mwMPxFuVyGd4HuqPFxWJSQ=
Received: by 10.114.79.1 with SMTP id c1mr8665151wab.148.1202674309043;
        Sun, 10 Feb 2008 12:11:49 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Sun, 10 Feb 2008 12:11:48 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0802101437040.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73396>

On 2/10/08, Nicolas Pitre <nico@cam.org> wrote:
> On Sun, 10 Feb 2008, Johannes Schindelin wrote:
>
> > Hi,
> >
> > On Sun, 10 Feb 2008, Johannes Schindelin wrote:
> >
> > > On Sat, 9 Feb 2008, Nicolas Pitre wrote:
> > >
> > > > On Sat, 9 Feb 2008, Jan Holesovsky wrote:
> > > >
> > > > > On Friday 08 February 2008 20:00, Jakub Narebski wrote:
> > > > >
> > > > > > Both Mozilla import, and GCC import were packed below 0.5 GB.
> > > > > > Warning: you would need machine with large amount of memory to
> > > > > > repack it tightly in sensible time!
> > > > >
> > > > > As I answered elsewhere, unfortunately it goes out of memory even on
> > > > > 8G machine (x86-64), so...  But still trying.
> > > >
> > > > Try setting the following config variables as follows:
> > > >
> > > >   git config pack.deltaCacheLimit 1
> > > >   git config pack.deltaCacheSize 1
> > > >   git config pack.windowMemory 1g
> > > >
> > > > That should help keeping memory usage somewhat bounded.
> > >
> > > I tried that:
> > >
> > > $ git config pack.deltaCacheLimit 1
> > > $ git config pack.deltaCacheSize 1
> > > $ git config pack.windowMemory 2g
> > > $ #/usr/bin/time git repack -a -d -f --window=250 --depth=250
> > > $ du -s objects/
> > > 2548137 objects/
> > > $ /usr/bin/time git repack -a -d -f --window=250 --depth=250
> > > Counting objects: 2477715, done.
> > > fatal: Out of memory, malloc failed411764)
> > > Command exited with non-zero status 1
> > > 9356.95user 53.33system 2:38:58elapsed 98%CPU (0avgtext+0avgdata
> > > 0maxresident)k
> > > 0inputs+0outputs (31929major+18088744minor)pagefaults 0swaps
> > >
> > > Note that this is on a 2.4GHz Quadcode CPU with 3.5GB RAM.
> > >
> > > I'm retrying with smaller values, but at over 2.5 hours per try, this is
> > > getting tedious.
> >
> > Now, _that_ is strange.  Using 150 instead of 250 brings it down even
> > quicker!
> >
> > $ /usr/bin/time git repack -a -d -f --window=150 --depth=150
> > Counting objects: 2477715, done.
> > Compressing objects:  19% (481551/2411764)
> > Compressing objects:  19% (482333/2411764)
> > fatal: Out of memory, malloc failed411764)
> > Command exited with non-zero status 1
> > 7118.37user 54.15system 2:01:44elapsed 98%CPU (0avgtext+0avgdata
> > 0maxresident)k
> > 0inputs+0outputs (29834major+17122977minor)pagefaults 0swaps
> >
> > (I hit the Return key twice during the time I suspected it would go out of
> > memory, so it might have been really at 20%.)
> >
> > Ideas?
>
> You're probably hitting the same memory allocator fragmentation issue I
> had with the gcc repo.  On my machine with 1GB of ram, I was able to
> repack the 1.5GB source pack just fine, but repacking the 300MB source
> pack was impossible due to memory exhaustion.
>
> My theory is that the smaller pack has many more deltas with deeper
> delta chains, and this is stumping much harder on the memory allocator
> which fails to prevent fragmentation at some point.  When Jon Smirl
> tested Git using the Google memory allocator there was around 1GB less
> allocated, which might indicate that the glibc allocator has issues with
> some of Git's workloads.

I'm forgetting everything again, but I seem to recall that the Google
allocator only made a significant difference with multithreading.  It
is much better at keeping the threads from fragmenting each other.
It's very easy to try it, all you have to do is add another lib the
the link command.


>
>
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
