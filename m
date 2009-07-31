From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Have git-merge-base support multiple IDs
Date: Fri, 31 Jul 2009 18:22:17 +0200
Message-ID: <4A731A39.3090506@drmicha.warpmail.net>
References: <alpine.LSU.2.00.0907311745100.4901@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:22:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWusU-00008u-Hi
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZGaQWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZGaQWe
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:22:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60489 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751947AbZGaQWd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 12:22:33 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C22FF3BD9E5;
	Fri, 31 Jul 2009 12:22:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 31 Jul 2009 12:22:34 -0400
X-Sasl-enc: R2Zb/NNEBu4HaBHElPu5uNOFQl10v3nTuJTmv61aiV8T 1249057353
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E55AEC5;
	Fri, 31 Jul 2009 12:22:33 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.2pre) Gecko/20090728 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <alpine.LSU.2.00.0907311745100.4901@fbirervta.pbzchgretzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124577>

Jan Engelhardt venit, vidit, dixit 31.07.2009 17:51:
> Hi,
> 
> 
> I am using git merge-base as sort of a hack to determine where to start 
> rebasing.
> Suppose this is the commit log (git log --oneline), of course, all 
> unpublished, which is why rebase comes in:
> 
>   98683793  Fix For faae2553
>   3365a01b  Fix For ab80794f
>   62943a23  Feature Baz
>   ab80794f  Feature Bar
>   faae2553  Feature Foo
> 
> To determine the rebase point (i.e. first commit in a series),
> one can (ab)use git-merge-base:
> 
>   p=$(git merge-base ab80794f faae2553)
>   git re -i ${p}^
> 
> And then reorder ab80794f, faae2553 to squash the fixes into the 
> appropriate commits. This practice works well somewhat.
> The twist is that merge-base in git 1.6.3.3 happens to ignore any 
> further arguments following two IDs. In short:
> 
>   git merge-base A B C...
> 
> Only yields the merge-base of A and B, and ignores C...

Uhm, are you sure about this?
The first argument is special.
merge-base computes the merge base between two commits:
- the first argument
- a (hypothetical) merge between all other arguments.

It may look a if C was ignored, though.

Michael
