From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 21:13:55 +0200
Message-ID: <20120913211355575954.3979105b@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
 <20120913154309.GB726@sigill.intra.peff.net>
 <20120913175300953765.9ccf790f@gpio.dk> <50522720.50204@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Drew Northup <drew.northup@maine.edu>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Sep 13 21:14:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEra-0001dV-C0
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 21:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab2IMTN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 15:13:58 -0400
Received: from [92.246.25.51] ([92.246.25.51]:62251 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab2IMTN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 15:13:57 -0400
Received: (qmail 88413 invoked from network); 13 Sep 2012 19:13:55 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 13 Sep 2012 19:13:55 -0000
In-Reply-To: <50522720.50204@kdbg.org>
X-Mailer: GyazMail version 1.5.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205415>

Hi Johannes.

I've changed...
	tr '\\r' '\\n'
...to...
	tr '\\15' '\\12'

...As you are right in that it is more correct. (Then in theory, it would be portable).
[I once came across tftpd, tried compiling it on a Mac, but it failed to work, because \r and \n were swapped on the compiler, so I asked the author to use \15 and \12, which made it fully portable]

It now works even better. I can't and won't complain - thank you. =)


Love
Jens

On Thu, 13 Sep 2012 20:34:08 +0200, Johannes Sixt wrote:
> Am 13.09.2012 17:53, schrieb Jens Bauer:
>> Hi Jeff and Drew.
>> 
>> Thank you for your quick replies! :)
>> 
>> The diffs look nasty yes; that's my main issue.
>> It can be worked around in many ways; eg a simple (but time consuming) way:
>> $ git diff mypcb.osm >mypcb.diff && nano mypcb.diff
>> 
>> -It'd be better to just pipe it into a regex, which changes CR to LF 
>> on the fly.
>> 
>> OsmondPCB is able to read files that has mixed LF and CR. (By mixed, 
>> I do not talk about CRLF)
> 
> That is good news. Just write a 'clean' filter that amounts to
> 
>    tr '\015' '\012'
> 
> You don't need a 'smudge' filter that reverts this conversion.
> 
> -- Hannes
> 
