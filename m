From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about scm security holes
Date: Fri, 5 Mar 2010 10:25:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003050953580.20986@pacific.mpi-cbg.de>
References: <hmp427$d6h$1@dough.gmane.org> <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: walt <w41ter@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 10:18:36 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnTg1-0005sg-Ur
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 10:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab0CEJS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 04:18:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:34893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751029Ab0CEJS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 04:18:26 -0500
Received: (qmail invoked by alias); 05 Mar 2010 09:18:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 05 Mar 2010 10:18:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bxcdSvydbNSGO2IKpA0bJ8sBkNzUkWYi4iE2Gnr
	n5RwbM6Qpiqoz8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <32541b131003041803q9abf6baq4cf9ffcca990b51c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141569>

Hi,

On Thu, 4 Mar 2010, Avery Pennarun wrote:

> An attack in which someone untraceably modified the repo to contain 
> modified code would be a little more interesting.

I disagree that stealing the code in this particular case is 
uninteresting. You know that there are billions in the business how to 
manipulate Google's search results. If you can see how Google rates 
websites, you can prepare your xxx sites for it, and nobody would be able 
to know, let alone prove, that you "reverse-engineered" the system.

> git makes this sort of thing pretty much impossible to do without it 
> being *noticeable* at least.

That is not true in all cases.

If you're talking about a workflow as git.git has it, you're right, there 
is a maintainer, and a refused push would ring all kinds of alarm bells 
there.

Except, of course, when the maintainer happens to work on different 
machines, and is likely to pull from her main repository quite often. 
Think "get something compiling on an obscure platform while developing 
something different on your main computer, then do a criss-cross merge at 
the end".

It gets even much, much worse in the common setup of companies: a central 
repository. (The two main reasons why a central repository is used are: 
tradition (we did it with Subversion, too), and bottleneck problems: a 
single maintainer reviewing all changes is often deemed too expensive 
and slow.)

So in the regular case, it is _very_ easy to sneak in a code-change 
unnoticedly.

The trick now is to craft the commit in such a manner that it will not be 
noticed retro-actively. This is a simple case of social engineering: you 
have to imitate the style of the committer/author you are impersonating. 
The commit message must look like the usual ones (typos, preferred words, 
grammar, length of paragraphs, comprehensibility, etc)

Likewise, the code has to be analyzed for style, and obviously for most 
likely targets of a backdoor (both in terms of "it is a perfect spot for 
a backdoor" and "it is not uncommon for the author to touch that 
part of the code").

Crafting the commit message and the backdoor needs some time, and it needs 
to be done _after_ succeeding with the break-in, as you can only then 
start analyzing style (and most likely workflow -- whether there is a 
single maintainer or whether everybody pushes to a single repository).

The most likely route, therefore is to have _two_ break-ins. One for 
reconaissance, the second for the actual change.

Conclusion: there are no technical reasons why Git should be better than 
Perforce when it comes to a break-in.

Short version: it's a social problem, so it needs a social solution.

Ciao,
Dscho

P.S.: Sorry for the overly long mail. I did not have time to make it 
short.
