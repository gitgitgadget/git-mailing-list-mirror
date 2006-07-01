From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Sat, 1 Jul 2006 15:45:10 -0700 (PDT)
Message-ID: <20060701224510.38530.qmail@web31806.mail.mud.yahoo.com>
References: <Pine.LNX.4.64.0606302029310.12404@g5.osdl.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 00:45:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwoDE-0003N3-4z
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 00:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWGAWpN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 18:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGAWpN
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 18:45:13 -0400
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:12110 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751308AbWGAWpL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 18:45:11 -0400
Received: (qmail 38532 invoked by uid 60001); 1 Jul 2006 22:45:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6R07ZGKcmm0n7FpDVgAdi5aHwMUuwtgz6Q9L1/2R9N2blXVwB9MFZGZTqsaCMbG/BVPxZY37Hp02kQoYq/3u8enUcrKgi1Cssg6UqfqGmozlBXwNDpK4s2V0HlamSBvL8CVexhMNjo5HlbwfbREPzOeMiP85WaddUkEzi0vrZWA=  ;
Received: from [68.186.62.135] by web31806.mail.mud.yahoo.com via HTTP; Sat, 01 Jul 2006 15:45:10 PDT
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606302029310.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23069>

--- Linus Torvalds <torvalds@osdl.org> wrote:
> That count of 145 is the number of commits that actually _change_ Makefile 
> some way - and some of them really are merges, because they have a content 
> merge, and the merge result is thus different from any of the children. So 
> that's a real number. So is 136, in some sense - it just says that we 
> don't care about commits, even if those commits _do_ end up changing the 
> file.

Indeed, I got the same conclusion using different branches.
(Sorry, I thought your email was from Junio in my last email, it was
your analysis after all.)

> But the important part to realize is that the "971" number is always 
> wrong. It's never a really valid number. It contains a lot of extra 
> merges, but it does _not_ contain enough of them to connect all the dots, 
> and it's thus never correct. Either you should drop merges that don't 
> change things (in which case you cannot have full connectivity, and 
> "--parents" doesn't make sense), or you should keep them all (or at least 
> enough to get full connectivity).

Yes, that makes sense.

Ok, I get similar numbers as you do.  After the patch, compared to
the simple case of git-rev-list HEAD -- <path spec>, --parents gives
me only one more commit which is the very first hand made kernel
commit ;-) ; --parents --full-history gives me way too many unrelated
commits about 10x as many; --full-history gives me a _complete_ list.

The simple case fails to report a few commits which are
due to merges, which do indeed change files in the path spec.
(--full-history successfully reported those though).

So your patch plus "--full-history" is what I think we want.

    Luben
