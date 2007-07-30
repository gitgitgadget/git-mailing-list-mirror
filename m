From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 1/4] get_series: Remove comments from end of series lines
Date: Mon, 30 Jul 2007 01:26:33 -0400
Message-ID: <20070730052633.GI22017@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <11856954183111-git-send-email-eclesh@ucla.edu> <20070730035422.GB22017@filer.fsl.cs.sunysb.edu> <87r6mqcvzp.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 07:26:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFNmG-0006IR-9f
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 07:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761589AbXG3F0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 01:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761066AbXG3F0k
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 01:26:40 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:48853 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138AbXG3F0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 01:26:40 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6U5QXQQ030951;
	Mon, 30 Jul 2007 01:26:33 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6U5QXD4030949;
	Mon, 30 Jul 2007 01:26:33 -0400
Content-Disposition: inline
In-Reply-To: <87r6mqcvzp.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54187>

On Sun, Jul 29, 2007 at 10:15:54PM -0700, Eric Lesh wrote:
> 
> [ Do you mind if these messages go to both your email addresses, or
> should I remove one or the other? ]
 
I really don't care if I get duplicates. It'll happen anyway when the git
mailing list is cc'd. As for which address I prefer, it really doesn't
matter to me which one stays in Cc. I'm slowly trying to move everything
over to @cs.

> Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:
> 
> > On Sun, Jul 29, 2007 at 12:50:15AM -0700, Eric Lesh wrote:
> > ... 
> >> diff --git a/guilt b/guilt
> >> index f67bfb5..774909e 100755
> >> --- a/guilt
> >> +++ b/guilt
> >> @@ -178,7 +178,8 @@ get_series()
> >>  	#	- whitespace only
> >>  	#	- optional whitespace followed by '#' followed by more
> >>  	#	  optional whitespace
> >> -	grep -ve '^[[:space:]]*\(#.*\)*$' "$series"
> >> +	# also remove comments from end of lines
> >> +	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series" | sed -e 's/[[:space:]]*#.*$//'
> >
> > I'd be tempted to replace the whole thing with one sed script...something
> > like (not tested):
> >
> > "
> > /^[[:space:]]*#/ ! {
> > 	s/[[:space:]]*#.*$//
> >
> > 	p
> > }
> > "
> >
> 
> sed -e "/^[[:space:]]*\(#.*\)*$/d
> 	/^[[:space:]]*\(#.*\)*$/!{
> 	s/[[:space:]]*#.*$//
> 	}
> 	" $series
> 
> is the best I can do.

I think the script I wrote is a bit cleaner as it more easily translates to:

if (!ignore_line) {
	strip comment
	print
}

to make it work, you'd need to run sed with -n to not implicitly print the
line.

Jeff.

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
