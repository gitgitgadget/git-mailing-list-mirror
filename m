From: wfp5p@viridian.itc.Virginia.EDU (Bill Pemberton)
Subject: Re: [PATCH 0/6] cleanups for git-send-email
Date: Wed, 29 Apr 2009 15:48:51 -0400 (EDT)
Message-ID: <20090429194852.0976257034@viridian.itc.Virginia.EDU>
References: <7vws939skl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com (Junio C Hamano)
X-From: git-owner@vger.kernel.org Wed Apr 29 21:51:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzFmz-0007Zq-MQ
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 21:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760862AbZD2Tsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 15:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756146AbZD2Tsz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 15:48:55 -0400
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:34102 "EHLO
	viridian.itc.Virginia.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954AbZD2Tsy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 15:48:54 -0400
Received: by viridian.itc.Virginia.EDU (Postfix, from userid 1249)
	id 0976257034; Wed, 29 Apr 2009 15:48:51 -0400 (EDT)
In-Reply-To: <7vws939skl.fsf@gitster.siamese.dyndns.org>
X-Mailer: ELM [version 2.5 PL8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117931>

> Perl styles are highly personal.
> 

So are C styles, but the kernel and git doesn't allow all sorts of
mixed styles.  My changes are also not just coding style, they have
actual meaning in perl.

My changes come directly from the book "Perl Best Practices".  Just as
you do things like "don't allow assignment in conditionals" in C, even
though it's legal.  There are good reasons to do these things in perl
to prevent bugs down the road.

> 
> *1* ...except for the "and/or vs &&/||" bits, even though I prefer the
> latter myself solely because I am old fashioned.
> 

Again, it prevents bugs.  People use "and" vs "&&" as the same thing,
when they are not.  The have different precedence in perl.

For example, 

next if not $finished || $x < 5;
next if !$finished || $x < 5;

do not mean the same thing.


> I think it is simply silly to say "precedence of ! and and/or does not
> mix".  "!" and "&&" have different precedence and rewriting (A and !B)
> into (A && !B) would not make things any better nor worse.  After all,
> nobody would have problems with "$a + $b * $c" even though + and * have
> different precedence.
> 

It's not that ! and && have different precedence.  It's that "not" and
! have different precedence.  Using your math example, it would be
like having an operator named plus that had a higher precedence than
"*".  Now if you wrote "$a plus $b * $c" it would have different
result than "$a + $b * $c".


> Oh, I also do not agree with "always explicitly return".  If the change
> and explanation were limited to the subs whose return values are _used_, I
> would agree with the change, though.
> 

Again, it prevents potential bugs down the road.  Currently those
functions return something.  While they are not used, the something
they return can be interpreted by developers as an intentional return
value and that property may get used.  If some other developer changes
the original function in some way that the implicit return becomes
something else, it'll create a bug.  If a subroutine isn't supposed to
return a meaningful value, it should do it explicitly.


-- 
Bill Pemberton                                 wfp5p@virginia.edu
ITC/Unix Systems                               flash@virginia.edu
University of Virginia                    
