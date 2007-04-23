From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Controversial blob munging series
Date: Mon, 23 Apr 2007 19:35:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231933560.8822@racer.site>
References: <11772221041630-git-send-email-junkio@cox.net>
 <Pine.LNX.4.64.0704231540580.8822@racer.site> <7vzm4zf1zx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 19:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg2SS-0003wS-1z
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 19:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbXDWRgI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 13:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbXDWRgI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 13:36:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:57120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754099AbXDWRgF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 13:36:05 -0400
Received: (qmail invoked by alias); 23 Apr 2007 17:36:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 23 Apr 2007 19:36:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nqfJhfv7nORwQsb7ScftCu7hd2SNjmlBlBfjQUE
	sbB4Cl1I6NZnWB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm4zf1zx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45343>

Hi,

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 21 Apr 2007, Junio C Hamano wrote:
> >
> >> This is on top of 'next' I'll push out after I am done with
> >> v1.5.1.2 I am preparing today.
> >> 
> >> [1/2] Add 'filter' attribute and external filter driver definition.
> >> [2/2] Add 'ident' conversion.
> >
> > I think this is great work! And it is useful, too. Let me describe a usage 
> > scenario I have in mind.
> >
> > Being stuck with Pine, which still does not do Maildir, and wanting 
> > to be able to read my mails as distributed as I am working on documents 
> > and software projects, I always dreamt of having all my mail in Git.
> >
> > With filters, it should be relatively easy to do that. Before checking in, 
> > the individual mailbox files are split, the contents are put into the 
> > object database, and the mailbox file is replaced by a text file 
> > consisting of the SHA1s of the mails.
> >
> > Ideally, I would eventually not only teach Pine to understand Maildir 
> > format, but read and store the mails in a Git backend. Alas, I am way too 
> > lazy for that.
> >
> > So, with filters I'd do the cheap and easy thing.
> >
> > You may not be able to appreciate the advantages of my scenario, but this 
> > kind of flexibility is what makes Git so useful.
> 
> An earlier message $gmane/44896 from Linus comes to my mind.  An excerpt:
> 
>    The thing is, it's easy enough (although potentially _very_ expensive) to 
>    run some per-file script at each commit and at each checkout. But there 
>    are some fundamental operations that are even more common:
> 
>     - checking for "file changed", aka the "git status" kind of thing
> 
>       Anything we do would have to follow the same "stat" rules, at a 
>       minimum. You can *not* afford to have to check the file manually.
> 
>       So especially if you combine several pieces into one, or split one file 
>       into several pieces, your index would have to contain the entry 
>       that matches the _filesystem_ (because that's what the index is all 
>       about), but then the *tree* would contain the pieces (or the single 
>       entry that matches several filesystem entries).
> 
> and I am inclined to think that this is quite fundamental.  I
> think you just fell into category who want "extended semantics"
> Linus talked about in $gmane/45214:
> 
>   I suspect that this gets some complaining off our back, but I *also* 
>   suspect that people will actually end up really screwing themselves with 
>   something like this and then blaming us and causing a huge pain down the 
>   line when we've supported this and people want "extended semantics" that 
>   are no longer clean.
> 
> which is kind of dissapointing.
> 
> Even if you somehow solved the issue of "stat" rule, I do not
> know what your plans are to manage the blobs that you drop in
> the object store.  The list of object names in the mail-index
> file you are generating do not count as connectivity for the
> purpose of fetch/push/fsck/prune.

I had the idea to update a ref, which holds "trees" of message-id -> blob 
pairs, and get updated at the same time.

If Git were libified already, I might have tried to go for direct storage 
in .git/objects/ instead.

Ciao,
Dscho
