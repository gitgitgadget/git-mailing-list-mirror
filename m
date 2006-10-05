From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: blame: All rows have title; print 8 SP when no leading commit-8
Date: Wed, 4 Oct 2006 18:29:48 -0700 (PDT)
Message-ID: <20061005012948.6961.qmail@web31815.mail.mud.yahoo.com>
References: <7vwt7fimgs.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 03:29:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVI3d-0007Xf-CY
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 03:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWJEB3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 21:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWJEB3t
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 21:29:49 -0400
Received: from web31815.mail.mud.yahoo.com ([68.142.206.168]:65171 "HELO
	web31815.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751307AbWJEB3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 21:29:49 -0400
Received: (qmail 6963 invoked by uid 60001); 5 Oct 2006 01:29:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=r9AcQbGBuDK4n4JYkbTx+7hi5IAk1/YG1nNgOcKK1UFmIn+2NfA7ZZo4pJhx2UjN8RlFJp5tBITqVnPTzEibStpQJjCVtQMecFhJYUvKl0oWgVJJMCi2sCFUvzaCHRbiJ26RbKbsrBONe63oobnbLdonkP5/+zZld0H1la1RER4=  ;
Received: from [64.215.88.90] by web31815.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 18:29:48 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt7fimgs.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28341>

--- Junio C Hamano <junkio@cox.net> wrote:
> Its visuals might be Ok (I haven't had chance to try it), but I
> am a bit worried about the output size bloat.  What kind of
> bloat factor are we talking about with this patch?
> 
>  - compared to the ancient original, which used to have commit-8
>    on all lines, title * N lines for a file that is N lines
>    long.  A title ("$author, $date") is about say 30 bytes or so
>    so for a file that is on average 25 bytes per line (this is
>    from "wc *.c" in git.git repository ) we are now spewing out
>    roughly twice the bytes back to the browser (25+8 vs 25+8+30)
> 
>  - compared to "only first in the block" version, assuming an
>    average group size is 10 lines or so (this is a totally made
>    up number) we are adding 72 extra bytes per 10 lines for
>    commit-8 on top of the title bloat which would be 270 bytes
>    per 10 lines.  Again assuming 25-byte per line average, that
>    is 250+8+30 vs 250+80+300 per 10 lines.  Again, roughly
>    twice.
> 
> I am not sure what the numbers of the chunked one I just
> reverted from "next" compared to the original.  For the same
> group size assumption, it added 8 bytes for commit-8 and 30
> bytes for title per the N lines, but we are assuming 10-line
> blocks, so 38 byte overhead per 10 lines, which is 250+80 vs
> 250+38, so it might have been actually slimmer than the
> original.

Yes, I agree with you.  That patch adds bloat.  I agree with
you, we can print the "title=" only for the leading commit-8,
as we currently do, and dispense with 8 SP.  In effect this
patch 2/2 can be dropped.

Thanks,
   Luben
