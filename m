From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first
 argument.
Date: Mon, 17 Dec 2007 11:50:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171149540.9446@racer.site>
References: <20071217095014.GF7453@artemis.madism.org>
 <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-2065060594-1197892215=:9446"
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:50:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4EUo-00023m-To
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935416AbXLQLub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935153AbXLQLub
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:50:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:58326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932863AbXLQLua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:50:30 -0500
Received: (qmail invoked by alias); 17 Dec 2007 11:50:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 17 Dec 2007 12:50:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180lU5rM780bb3eKXajv6ninkxwfQvKFLtGNuXeUB
	KOt9Du+eJ1XHCQ
X-X-Sender: gene099@racer.site
In-Reply-To: <20071217114703.GH7453@artemis.madism.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68546>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-2065060594-1197892215=:9446
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Dec 2007, Pierre Habouzit wrote:

> On Mon, Dec 17, 2007 at 11:10:00AM +0000, Wincent Colaiuta wrote:
> > El 17/12/2007, a las 10:50, Pierre Habouzit escribió:
> > 
> > >Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > >---
> > >>   // ...
> > >>   /* when in `git --opt1 --opt2 foo -a -b -c` mode: */
> > >>   int cmd_pos = git_find_builtin_command_name(argc, argv);
> > >>   int count = parse_options(cmd_pos, argv, git_generic_options,
> > >>	"git [special-options] cmd [options]", 0);
> > >>   if (count)
> > >>	die("unknown git command: `%s`", argv[0]);
> > >>   argv += cmd_pos;
> > >>   argc -= cmd_pos;
> > >>   /* here we simulate an argv of {"foo", "-a", "-b", "-c"} */
> > >
> > >   Or even simpler, with the following specifically tailored patch you
> > >   can directly write:
> > >
> > >   argc = parse_options(argc, argv, git_generic_options,
> > >	"git [generic-options] <command> [cmd-options]",
> > >	PARSE_OPT_STOP_AT_ARG);
> > >
> > >   and then {argc, argv} will exactly be the NULL-terminated array
> > >   starting with the builtin command. Kind of nice :)
> > 
> > Indeed, nice ideas. I think all this will lead to a nice UI improvement 
> > post-1.5.4.
> > 
> > About the only thing that I think would merit action *prior* to 1.5.4 is 
> > marking the "-p" switch to git (synonym for --paginate) as deprecated, 
> > see as it clashes with other commands' uses of that switch ("git log -p" 
> > for example). Are there any other conflicting specials that a currently 
> > parsed in git.c?
> 
>   You don't need to, and I'd see that as a regression. With my proposal,
> there isn't any kind of need that git commands do not clash with git
> ones. The parse-option mechanism will properly hide options that are
> masked this way, dscho wrote the patch for that.
> 
>   git -p log -p ...
> 
> just makes sense to me. CVS or SVN e.g. (don't hit me !) have the same
> kind of "issues", and I never found that weird.
> 
>   In fact I see this the other way around: git status -p that is in fact
> the same as git -p status, is the conveniency, git -p status is the
> canonical form.

I would even go further: "git status -p" looks utterly wrong to me.

Ciao,
Dscho

---1463811741-2065060594-1197892215=:9446--
