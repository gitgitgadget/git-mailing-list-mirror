From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 18:11:37 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>  <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEux1-0005wb-P7
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbYAOXLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbYAOXLn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:11:43 -0500
Received: from iabervon.org ([66.92.72.58]:39298 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648AbYAOXLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 18:11:42 -0500
Received: (qmail 817 invoked by uid 1000); 15 Jan 2008 23:11:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jan 2008 23:11:37 -0000
In-Reply-To: <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70576>

On Tue, 15 Jan 2008, Chris Ortman wrote:

> The format that TortoiseSVN expects is the same as the format of svn diff.
> The most apparent differences are
> 
> diff --git a/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj
> b/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj
> 
> becomes
> 
> Index: Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj

When --no-prefix is used, we should probably do:

Index: <filename>

instead of

diff --git <filename> <filename>

If nothing else, --no-prefix generates patches that git-apply can't apply 
but thinks that it should be able to because of the "diff --git" line.

> and
> 
> index a0a0d38..9676e16 100644
> 
> becomes
> 
> ===================================================================

Can't tell if this matters, or if this is meant to underline the Index 
line, and if we can leave some extra info after it. The source link you 
sent requires a login; is this line actually important to recognition, or 
is it just different in the generated patches?

> and
> 
> --- a/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj
> +++ b/Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj
> 
> becomes
> 
> --- Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj	(revision 4715)
> +++ Facilities/EventWiring/Castle.Facilities.EventWiring.Tests/Castle.Facilities.EventWiring.Tests-vs2005.csproj	(working copy)

This (putting a description of the revision at the end) would be nice in 
general for those of us who can't remember what arguments we gave to git 
diff and can't get back to them without quitting less and no longer having 
the diff.

Of course, it would take a lot of magic to get git to describe things with 
the svn revision info in a non-svn-specific command, but that may not be 
necessary if tortoise is willing to apply patches where the base revision 
is unknown. Or git-svn could just make a lot of tags like "revision 4715".

	-Daniel
*This .sig left intentionally blank*
