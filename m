From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 13:11:28 +0100
Message-ID: <81b0412b0701110411s7ccb45c1t9ececa9301760bae@mail.gmail.com>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	 <20070107163112.GA9336@steel.home>
	 <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
	 <Pine.LNX.4.63.0701110913140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0701110103p5f67b955gee6ff6194e6ea68d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 13:11:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ymM-0005hV-B1
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 13:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbXAKMLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 07:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbXAKMLa
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 07:11:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:16976 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030281AbXAKML3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 07:11:29 -0500
Received: by ug-out-1314.google.com with SMTP id 44so444110uga
        for <git@vger.kernel.org>; Thu, 11 Jan 2007 04:11:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aiCYIvFAJjUHC4lN8xznkXp3bYv0nyouJmfChJX0XpEwBt26qbDOXhobkO2MmIHb2zfYuF/PIbFhNEOSR42CnRKSqZL8j20C6NJPsOaqyqE1pyFWgtTZ4f+6sZmAGTvApmHkZFHwTEEfV0V/QYLTDpkqqovvUTXbKRw4MHY/N1w=
Received: by 10.78.131.8 with SMTP id e8mr396643hud.1168517488298;
        Thu, 11 Jan 2007 04:11:28 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 11 Jan 2007 04:11:28 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <81b0412b0701110103p5f67b955gee6ff6194e6ea68d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36583>

On 1/11/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > > > Yep. Tried the monster merge on it: 1m15sec on that small laptop.
> > >
> > > Is that supposed to be good? That still sounds really slow to me. What
> > > kind of nasty project are you doing? Is this the 44k file project, and
> > > under cygwin? Or is it that bad even under Linux?
> >
> > This _is_ cygwin. And 1m15sec is actually very, very good, if you happen
>
> No, this is linux, in a very constrained conditions. On cygwin I
> haven't tried it yet.

Well, tried it now. Strangely enough - there is almost no speedup with
Junio's patch on top of mine. I must have done something stupid,
but cannot find what. And the times reported by time on cygwin jump
wildly: from 29 to 38 sec!
