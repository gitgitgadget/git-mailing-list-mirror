From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: gitpacker progress report and a question
Date: Mon, 26 Nov 2012 17:01:08 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121126220108.GB1713@thyrsus.com>
References: <20121115212818.GA21558@thyrsus.com>
 <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td6k3-00020L-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 23:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab2KZWBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 17:01:11 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:51851
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563Ab2KZWBK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 17:01:10 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 5D0254065F; Mon, 26 Nov 2012 17:01:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s30px2FgieC9VcGji7T+yWFo7gMSwQhtuztHrqto8B7Aw@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210504>

Felipe Contreras <felipe.contreras@gmail.com>:
> 1) I tried it, and it doesn't seem to import (pack?) are repository
> with sub-directories in it

I'll make sure my regression test checks this case.  The options to git 
ls-files are a bit confusing and it's possible my invocation of it
needs to change.
 
> 2) Using 'git fast-import' is probably simpler, and more efficient

That might well be.  I'm not worried about "efficiency" in this context 
but reducing the code size is significant and I'm willing to re-code
to do that.
 
> Here is a proof of concept I wrote in ruby that is half the size, and
> seems to implement the same functionality.

Not anywhere near the same.  It only handles commits, not tags. It
doesn't issue delete ops.  And it doesn't rebuild branch heads.
If I were willing to omit those features, I'm sure I could halve
the size of my implementation, too.  Of course, it would then be
almost completely useless...

>                           The format is exactly the
> same, but I think it should be modified to be more efficient.

I'm not wedded to the log format as it is, so I'll cheerfully
take suggestions about it.

Be aware, however, that I consider easy editability by human beings
much more important than squeezing the last microsecond out of the
processing time.  So, for example, I won't use data byte counts rather
than end delimiters, the way import streams do.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
