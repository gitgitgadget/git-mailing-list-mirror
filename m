From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 0/5] ignore SIGINT while editor runs
Date: Sun, 11 Nov 2012 20:15:20 +0100
Message-ID: <20121111191520.GA9474@shrek.podlesie.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <87a9uq5tql.fsf@Niukka.kon.iki.fi>
 <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
 <871ug15k5c.fsf@Niukka.kon.iki.fi>
 <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
 <87wqxs4o6f.fsf@Niukka.kon.iki.fi>
 <20121111154846.GA13188@sigill.intra.peff.net>
 <20121111163100.GB13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kalle Olavi Niemitalo <kon@iki.fi>,
	Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXd0M-0003hN-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 20:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab2KKTPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 14:15:24 -0500
Received: from [93.179.225.50] ([93.179.225.50]:60711 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751656Ab2KKTPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 14:15:23 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id BAF31581; Sun, 11 Nov 2012 20:15:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121111163100.GB13188@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209439>

On Sun, Nov 11, 2012 at 11:31:00AM -0500, Jeff King wrote:
> 
> Here's a series that I think should resolve the situation for everybody.
> 
>   [1/5]: launch_editor: refactor to use start/finish_command
> 
> The cleanup I sent out a few minutes ago.
> 
>   [2/5]: launch_editor: ignore SIGINT while the editor has control
> 
> Paul's patch rebased on my 1/5.
> 
>   [3/5]: run-command: drop silent_exec_failure arg from wait_or_whine
>   [4/5]: run-command: do not warn about child death by SIGINT
>   [5/5]: launch_editor: propagate SIGINT from editor to git
> 
> Act more like current git when the editor dies from SIGINT.
> 

Looks ok, but what about SIGQUIT? Some editors like GNU ed (0.4 and 1.6)
ignore SIGQUIT, and after SIGQUIT git dies, but editor is still running.
After pressing any key ed receives -EIO and prints "stdin: Input/output
error". GNU ed 1.6 then exits, but ed 0.4 prints this error forever.
Maybe git should kill the editor in such case?

Krzysiek
