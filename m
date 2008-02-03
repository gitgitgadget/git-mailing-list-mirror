From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Comment private modifier to improve performace.
Date: Sun, 03 Feb 2008 17:46:56 -0200
Message-ID: <47A61A30.3000904@intelinet.com.br>
References: <1201919018-10782-1-git-send-email-rogersoares@intelinet.com.br> <200802030201.10971.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLknB-0007tx-V2
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 20:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbYBCTpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 14:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbYBCTpa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 14:45:30 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1748 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750890AbYBCTp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 14:45:29 -0500
Received: (qmail 82407 invoked by uid 0); 3 Feb 2008 17:47:47 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.262319 secs); 03 Feb 2008 19:47:47 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 3 Feb 2008 19:47:47 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <200802030201.10971.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72397>

Robin Rosenberg escreveu:
>
> I'm not fully convinced this is the right way after all. Good
> performance is obviously good, but so is good encapsulation. 
> I've sometimes tried changing things like this even in pieces
> of code that I really thought it should matter, but not been able
> to measure any real improvemen even with performance measurment tools.
>
> Obviously seeing that warning is annoying so maybe we should just set it to
> ignore or exclude it from the project settings (if that is possible). The
> only project where I think it might make a difference is the jgit part because
> that is where we optimize and that is where I experimented with visibility
> changes. In the Eclipse part we need to encapsulate more, partly because 
> Eclipse is less understood by the current authors than Java in general. 
> Encapsulation means encapsulating bad coding and bad design that comes
> from lack of understanding of the framework we are working within.
>
>   

Ok, so some more points for your consideration:

. I saw this /* private */ notation on eclipse code and found it 
interesting.

. I won't bother measuaring any single case to make sure it is not 
impacting performance under some circunstance, so resolving those 
warnings puts me in the safe area. On the other hand, I think it is a 
lot easier to tell if a patch is breaking encapsulation in a bad way 
just by reviewing it, which is something that is already done. 
Especially if it has the private modifier commented out. Someone can 
even do a script to uncomment them and verify that it still builds 
without errors.

. The ui part isn't supposed to be reused by other projects, so I think 
encapsulation there is less important than for jgit. But even so, the 
default modifier (or package-private) is good enough for encapsulation. 
Other projects shouldn't write code in the the same packages from jgit, 
if they do so they know that they are using internal things and they can 
run into problems in the future.

That said, I'm ok with your patch too. I think the important is to 
choose one so we stop mixing things, for consistency's sake.

[]s,
Roger.
