From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bug: git-rebase goofs up \n in commit messages
Date: Fri, 25 May 2007 20:59:29 -0700
Message-ID: <7vwsywnske.fsf@assigned-by-dhcp.cox.net>
References: <465750FE.9000406@iii.hu>
	<20070526004028.GA8940@sigill.intra.peff.net>
	<20070526011036.GA4169@gondor.apana.org.au>
	<20070526034236.GA18169@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Szekeres Istvan <szekeres@iii.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 26 05:59:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrnRL-0007jH-He
	for gcvg-git@gmane.org; Sat, 26 May 2007 05:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbXEZD7b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 23:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXEZD7b
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 23:59:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49005 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbXEZD7b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 23:59:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526035929.TFD19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 23:59:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3fzV1X00c1kojtg0000000; Fri, 25 May 2007 23:59:30 -0400
In-Reply-To: <20070526034236.GA18169@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 25 May 2007 23:42:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48447>

Jeff King <peff@peff.net> writes:

> On Sat, May 26, 2007 at 11:10:36AM +1000, Herbert Xu wrote:
>
>> If you need to echo something that may have escapes in it, the portable
>> way to do it is
>> 
>> printf '%s\n' "$test"
>
> Ah, I see. I had thought the problem was coming from some dash
> interpolation magic, but yes, it's just echo doing the conversion. And
> POSIX is very clear that this is an implementation defined behavior.
> Thanks very much for the response, Herbert.
>
> Junio, patch is below. I have no idea how prevalent this issue is within
> our scripts, but this at least fixes the reported bug.

Gaah.  Ok, dash uses "echo -e" behaviour by default.

I guess we need to hunt allmost all "echo", as I suspect most of
them (except the ones we use to do "echo $SHA1") have user
strings somewhere.

What a mess, but that is not your fault nor Herbert's.

Thanks.
