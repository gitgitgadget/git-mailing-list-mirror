From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String
 Library.
Date: Fri, 7 Sep 2007 02:27:46 +0100 (BST)
Message-ID: <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org>
References: <46DDC500.5000606@etek.chalmers.se>  <1189004090.20311.12.camel@hinata.boston.redhat.com>
  <vpq642pkoln.fsf@bauges.imag.fr>  <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
  <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> 
 <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> 
 <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
 <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 03:28:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITSdb-0005Sa-TO
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 03:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbXIGB1y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 21:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbXIGB1y
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 21:27:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53297 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932397AbXIGB1x (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 21:27:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l871RlDa031522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 18:27:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l871Rkrv018960;
	Thu, 6 Sep 2007 18:27:47 -0700
In-Reply-To: <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com>
X-Spam-Status: No, hits=-3.242 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.31__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57961>



On Thu, 6 Sep 2007, Dmitry Kakurin wrote:
> 
> As it is right now, it's too hard to see the high-level logic thru
> this endless-busy-work of micro-managing strings and memory.

Total BS. The string/memory management is not at all relevant. Look at the 
code (I bet you didn't). This isn't the important, or complex part.

> IMHO Git has a brilliant high-level design (object database, using
> hashes, simple and accessible storage for data and metadata). Kudos to
> you!
> The implementation: a mixture of C and shell scripts, command line
> interface that has evolved bottom-up is so-so.

The only really important part is the *design*. The fact that some of it 
is in a "prototyping language" is exactly because it wasn't the core 
parts, and it's slowly getting replaced. C++ would in *no* way have been 
able to replace the shell scripts or perl parts.

And C++ would in no way have made the truly core parts better. 

> > and comparing C to assembler just shows that you don't have a friggin idea
> > about what you're talking about.
> 
> I don't see myself comparing assembler to C anywhere.

You made a very clear "assembler -> C -> C++/C#" progression nin your 
life, comparing my staying with C as a "dinosaur", as if it was some 
inescapable evolution towards a better/more modern language.

With zero basis for it, since in many ways C is much superior to C++ (and 
even more so C#) in both its portability and in its availability of 
interfaces and low-level support.

> I was pointing out that I've been programming in different languages
> (many more actually) and observed bad developers writing bad code in
> all of them. So this quality "bad developer" is actually
> language-agnostic :-).

You can write bad code in any language. However, some languages, and 
especially some *mental* baggages that go with them are bad.

The very fact that you come in as a newbie, point to some absolutely 
*trivial* patches, and use that as an argument for a language that the 
original author doesn't like, is a sign of you being a person who should 
be disabused on any idiotic notions as soon as possible.

The things that actually *matter* for core git code is things like writing 
your own object allocator to make the footprint be as small as possible in 
order to be able to keep track of object flags for a million objects 
efficiently. It's writing a parser for the tree objects that is basically 
fairly optimal, because there *is* no abstraction. Absolutely all of it is 
at the raw memory byte level.

Can those kinds of things be written in other languages than C? Sure. But 
they can *not* be written by people who think the "high-level" 
capabilities of C++ string handling somehow matter.

The fact is, that is *exactly* the kinds of things that C excels at. Not 
just as a language, but as a required *mentality*. One of the great 
strengths of C is that it doesn't make you think of your program as 
anything high-level. It's what makes you apparently prefer other 
languages, but the thing is, from a git standpoint, "high level" is 
exactly the wrong thing. 

		Linus
