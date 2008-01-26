From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Pyrite project.
Date: Sat, 26 Jan 2008 13:21:43 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801261311380.23907@racer.site>
References: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1706897666-1201353708=:23907"
Cc: Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 14:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIkzi-0006UH-Lv
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 14:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbYAZNWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 08:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbYAZNWF
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 08:22:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:58016 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751557AbYAZNWC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 08:22:02 -0500
Received: (qmail invoked by alias); 26 Jan 2008 13:22:00 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 26 Jan 2008 14:22:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18C3qoLNwYCojQVwQvZIPTOAASbV5JUW//qYPSsmf
	sb1BBmeCkoL0rA
X-X-Sender: gene099@racer.site
In-Reply-To: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71781>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1706897666-1201353708=:23907
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

IIRC it was you who started the c# port of git?  What happened to it?

On Sat, 26 Jan 2008, Govind Salinas wrote:

> I am starting a project that I hope some of you will be interested in.
> I have been looking at DSCM tools for a few months now and I have
> come away liking different aspects of different systems.  The project,
> called Pyrite, aims to combine the best features of git and Mercurial.
> 
> Please stop by http://pyrite.sophiasuchtig.com/ to see the
> announcement.  Links to the public repo in there.

I do not like this type of announcement.  A link is good on IRC, but on 
the mailing list you can include a (possibly abbreviated) version of it so 
that people are not inconvenienced.

So I will quote your linked page, and insert my comments

> Introducing Pyrite. Combining the best of git and Mercurial.
> 
> I have been following the Distributed Source Code Management for some 
> time and I think it is a wonderful tool. I have looked extensively at 
> both git and Mercurial and there are several things I like about both of 
> them.
> 
> From Git I like.
> 
> 
>   • Ability to re-write history
>   • Speed
>   • Lightweight versatile branches
>   • Rebasing
>   • Squashing
> 
> 
> From Mercurial I like.
> 
>   • Easy as pie to set up an ad-hoc web server
>   • Cross Platform (works well on Winders)
>   • Extensibility, get full access to repository internals from your own python
>     scripts
>   • Python, chalk it up to personal taste, but I would rather work in python or
>     another high-level language
> 
> I think it is possible to get the best of both worlds. So I am looking 
> at writing something that will be a git repo at its core, but have 
> Mercurial-like properties for ui and add-ons.
> 
> Rather than try and re-implement git internals, I think it is best to 
> re-use them. So the project will take place in stages.
> 
> 
>  1. Build a wrapper over git plumbing that allows me to have the user
>     interfaces that I want.

That should be easy enough.

>  2. Help the libification effort in git so that I can use git code straight
>     from python.

That should also be easy enough; there was a GSoC program, and you could 
just go there and help that effort, instead of reinventing the wheel.

For your convenience:

	http://repo.or.cz/w/git/libgit-gsoc.git

>  3. Start stripping away non-performance-critical C code and convert it to
>     python code to help interoperate with extensions and GUIs

I am absolutely no fan of "extensions".  You keep breaking other people's 
code if your core introduces changes; see for example the libgit.a issue 
with cgit.

> There are 2 main benefits that I am looking for with git libification. 
> One is, if we can reduce the amount of code that has to be compiled in C 
> to a small enough subset, we should be able to build without the need of 
> Cygwin or Msys.

This effort would be better helped by converting more scripts to builtins, 
_not_ by reintroducing the dependency on python.

> The other main benefit is that if everything lives in the same process, 
> then we should be able to reduce the overhead for doing some operations 
> that require forking and execing.

We have relatively few fork()s and exec()s by now.  Eliminating them would 
mean that you have to put in a huge effort to undo the one-shot paradigm 
in a lot of operations.

> As you chain operations you can reuse data in their native structures 
> and not have to re-parse them as they are passed on stdin or the command 
> line.

You might want to look at Han-Wen's git-dump tool (although I think that 
it is misnamed; something like git-query would be better IMHO).

> Since it will be a git repository in fancy dress, the goal is to keep it 
> fully compatible with git such that you can clone/pull/push to and from 
> a git repository seamlessly. Or even use standard git in your pyrite 
> repository and vice versa.

I expect that Mercurial people will not be happy...

Ciao,
Dscho

---1463811741-1706897666-1201353708=:23907--
