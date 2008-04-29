From: "Russ Dill" <russ.dill@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 09:24:54 -0700
Message-ID: <f9d2a5e10804290924y127d6a9frd7e883b8ab0f781f@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>
	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
	 <4816CC80.9080705@op5.se>
	 <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com>
	 <48171442.4050707@op5.se> <48171D24.9000104@gnu.org>
	 <481732C0.5020208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Paolo Bonzini" <bonzini@gnu.org>, sverre@rabbelier.nl,
	"Henrik Austad" <henrikau@orakel.ntnu.no>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:26:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqseN-0003V8-Ht
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbYD2QZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbYD2QZB
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:25:01 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:53134 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYD2QZA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:25:00 -0400
Received: by gv-out-0910.google.com with SMTP id s4so27066gve.37
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qixOJQi1+kSTzghMn37hCUIRqI/TUKNDok0sLYcEjc4=;
        b=X1fP/ZNn4pWhFRMIFSMg8/8AHQjm9FK5SqNBATGoTmIWg+0VRdauVXCIhTezJi/OOkN8RrN5ML5bBVrYqSjkCDd5S2tp0Bqa7QlqEoUvXt8/ith03zStKk5rO+v9IfXkwJj0YHy0mKuCSg1ZDSQglHDCtEhf8coU9C8IzVqxLx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3b1ufFJjYAgla1M+4Gfcjgo9Lojq0dHqsnfmzUaMAMT5wIdppW4JdXRd3Ms7dopv5cvg2tyFF7cxqzB2UFWIQaIgllHM3mf33k5y8Qow/yUzUvUW2WBYTyCVqrqeyatZzd/TSDe3GS67jghy10jIc8Lm/xDbkmIylu9B/vSpwI=
Received: by 10.150.50.2 with SMTP id x2mr5289024ybx.34.1209486294474;
        Tue, 29 Apr 2008 09:24:54 -0700 (PDT)
Received: by 10.150.228.20 with HTTP; Tue, 29 Apr 2008 09:24:54 -0700 (PDT)
In-Reply-To: <481732C0.5020208@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80700>

On Tue, Apr 29, 2008 at 7:37 AM, Andreas Ericsson <ae@op5.se> wrote:
>
> Paolo Bonzini wrote:
>
> >
> >
> > > I can think of one way to make git a lot more resilient to hash
> > > collisions, regardless of which hash is used, namely: Add the length
> > > of the hashed object to the hash.
> > >
> >
> > Not really, because most attacks are about collisions, not second
> preimages.  They produce two 64-byte blocks (hence, same length) with the
> same hash value.
> >
> > As such, they allow to change a blob that *the attacker* injected in the
> repository.  The way the more "spectacular" attacks are devised requires a
> "language" with conditional expressions -- for documents, for example,
> Postscript is used.  If you prepare a postscript file whose code is
> >
> >   if (AAAA == BBBB)
> >     typeset document 1
> >   else
> >     typeset document 2
> >
> > where AAAA and BBBB are collisions, and you change it to "if (BBBB ==
> BBBB) the hash will be the same, but the outcome will be document 1 instead
> of document 2.
> >
> > The fact that this requires having the two "behaviors" in the blob is not
> a big deal for source code, going in the wrong branch of an "if" can be an
> attack.  On the other hand, it makes adding the length useless for collision
> attacks.  True, it wouldn't be useless for second preimage attacks, but
> SHA-1 is still secure with respect to those.
> >
> >
>
>  So what you're saying is that if someone owns a repository and adds a
>  file to it, he can then replace his entire repository with an identical
>  one where the good file is replaced with a bad one, and this will affect
>  people who clone *after* the file gets replaced.
>

No, if someone 0wnz a repository, not owns (Or really, malicious
mirror owners could be in on it). Either that or some form of
redirection attack. When you download a tarball, you can check the
signed checksum that is downloadable along with it. When you clone a
repo, you depend on signed tags.
