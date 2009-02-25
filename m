From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 13:38:23 -0500
Message-ID: <013B8F55-FBCC-4D3B-9EA4-13C05FFE986B@silverinsanity.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com> <7E43550E-68B7-4B22-A83C-F840A7037CA9@silverinsanity.com> <450196A1AAAE4B42A00A8B27A59278E709E0486D@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 19:40:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcOfs-00059w-LO
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 19:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403AbZBYSig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbZBYSig
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 13:38:36 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:45123 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbZBYSif (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 13:38:35 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 5E7ED1FFC3A0; Wed, 25 Feb 2009 18:38:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id DCCFA1FFC3A0;
	Wed, 25 Feb 2009 18:38:21 +0000 (UTC)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E0486D@EXCHANGE.trad.tradestation.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111476>


On Feb 25, 2009, at 1:02 PM, John Dlugosz wrote:

>> Generally when I keep changes like this, I make a commit called  
>> "Local
>> Changes" or similar and have branch.master.rebase set to true so that
>> my changes get rebased on top of origin when I pull.
>
> That sounds ideal.  However, I don't understand the specific steps you
> mention.  Looking in the help for git-config,

As Junio and Linus have pointed out, most pulls will ignore local  
changes,
so this is likely overkill unless your changes are in commonly changed  
files.

> So, assuming you are working on the "master" branch, this will rebase
> the pulled content on top of the existing "master" rather than  
> merging.
> If my local changes are committed to "master" first, then this will  
> take
> all the commits from other developers that I don't already have in my
> local copy and apply them on top of my existing (including Local
> Changes).  But since those will now be different commits, what happens
> next time?  Ah, "...which introduce the same textual changes..." so
> that's covered in how rebase works.

You can set branch.master.rebase with

   git config branch.master.rebase true

It actually works the other way.  Your changes will be rebased on top of
the work from other developers.

A--B--E--F  origin/master
     \
      C--D master

will become

A--B--E--F  origin/master
           \
            C'--D' master

I share most of my changes using format-patch and e-mail instead of
pushes, so I just don't generate patches for my unimportant changes.
For pushing, I'd suggest either working on new features in a different
branch ("topic" and "local" for example), or using "rebase -i" to move
your local changes to the top and using "push HEAD^".

~~ Brian
