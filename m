From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 10:02:03 +0100
Message-ID: <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	 <20070107163112.GA9336@steel.home>
	 <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 10:02:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4vp5-0006st-C2
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 10:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbXAKJCI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 04:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbXAKJCH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 04:02:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:54216 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030251AbXAKJCF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 04:02:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so394465uga
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 01:02:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K1b8jA0NA8qZX/7e93fK206BQcZgachWORuvPHLTfBXDgEw+2KOMsAMpzaRUjoocHIWi39k6X1z4DKtflF8mqP+LPE43eFlT7en3LyCiEAw0ewC+6XdqI8P4pp906GnkzItsZYpm+Z4FYd0RbNIdYBJoIDLzVOKVKMR01pOPvv4=
Received: by 10.78.178.5 with SMTP id a5mr354737huf.1168506123563;
        Thu, 11 Jan 2007 01:02:03 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 11 Jan 2007 01:02:03 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36560>

On 1/11/07, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Yep. Tried the monster merge on it: 1m15sec on that small laptop.
>
> Is that supposed to be good? That still sounds really slow to me. What
> kind of nasty project are you doing? Is this the 44k file project, and
> under cygwin? Or is it that bad even under Linux?

It is that "bad" on a 384Mb linux laptop and 1.2GHz Celeron.
Yes, it is that 44k files project. The previous code finishes
that merge on that laptop in about 20 minutes, so it's defnitely
an improvement. My cygwin machine has a lot more memory (2Gb),
so I can't really compare them here.
