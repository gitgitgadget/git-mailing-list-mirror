From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Sun, 25 Nov 2012 17:44:44 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121125224443.GC6937@thyrsus.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <20121125095356.GA22279@thyrsus.com>
 <CAMP44s1oRpm4QkhcbfAuxK8UTZnuSVfNhAQnmUd1xiwhwLEqGw@mail.gmail.com>
 <20121125173229.GA32394@thyrsus.com>
 <CAMP44s2ft7vvaGqHUa2CytpAsX8vOF3YQo24PLPsD6y1Dk3GZQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 23:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TckxY-0004l4-S3
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 23:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab2KYWph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 17:45:37 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:44751
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab2KYWph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 17:45:37 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 1EC9C4065F; Sun, 25 Nov 2012 17:44:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s2ft7vvaGqHUa2CytpAsX8vOF3YQo24PLPsD6y1Dk3GZQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210388>

Felipe Contreras <felipe.contreras@gmail.com>:
> > I'd be happy to help you out by auditing them for version dependencies.
> 
> Be my guest:
> http://git.kernel.org/?p=git/git.git;a=tree;f=contrib/remote-helpers;h=adfdcc164e634c74024c8f69bb0cdb9f3b4a9f18;hb=7b4a70c62f3a83fbd8b44bf712141754a5f64205
> 
> Some patches might be missing, so:
> https://github.com/felipec/git/tree/fc/remote/hg

OK, here's what I look for:  use of argparse, use of unittest, use
of Collections.counters, use or ordered dictionaries, use of set literals,
use of multiple context managers in one "with", use of memoryview, use of
the comma format specifier.  I'm not worried about the changes in repr()
for floating point; I'd be astonished if they mattered in code like this.
Likewise for PyCapsule and importlib.

I don't see obvious problems in that code.  Looks pretty vanilla, actually;
the latest version-related blocker I can see is the import of json,
which would have been a problem before 2.5.

You wrote the code.  Do you *know* of 2.7-specific constructions in
there that I've missed?  If you do, and think of this as a way to
catch me in a mistake and dance triumphantly, you lose - our goal
should be to cooperate to improve the auditing process, not score
silly points.

> > One way is by having clear guidelines for good practice that *include*
> > Python, and tell people exactly what the requirements are.
> 
> The key word being guideline, which is different from a strict rule.

Agreed. It's a matter for the dev group to decide when we need rules
and when we need guidelines.  I think we need a rule about Python version
conformance that protects older systems, but other things can be guidelines.

> According to the results of the last survey, our users do care about
> performance, so I don't think there's anything excessive about it. Are
> there any hidden costs in maintenance problems? I don't think so.

Then you're either pretending or very naive. Three decades of
experience as a C programmer tells me that C code at any volume is a
*serious* maintainance problem relative to almost any language with
GC.  Prudent architects confine it is much as possible.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
