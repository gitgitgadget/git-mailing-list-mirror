From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Wrong time in git-log when using right/ timezone
Date: Wed, 18 Jul 2007 18:55:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707181849060.1544@reaper.quantumfyre.co.uk>
References: <20070718153614.GA28815@hartlich.com>
 <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Peter Hartlich <wwsgj@hartlich.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 19:56:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBDks-0005Tm-GS
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 19:56:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbXGRR4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 13:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762361AbXGRR4A
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 13:56:00 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:37183 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762287AbXGRRz7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 13:55:59 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id D76C3B994D
	for <git@vger.kernel.org>; Wed, 18 Jul 2007 18:55:57 +0100 (BST)
Received: (qmail 19312 invoked by uid 103); 18 Jul 2007 18:55:57 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3689. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.031684 secs); 18 Jul 2007 17:55:57 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 18 Jul 2007 18:55:57 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.0.999.0707180948080.27353@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52885>

On Wed, 18 Jul 2007, Linus Torvalds wrote:

> ie apparently Berlin is in a timezone of its own that is roughly one
> minute and 23 seconds away from CET.
>
> What the *heck*?
>
> I really don't think this is git that is confused: I get the exact same
> thing with "date" too:
>
> 	[torvalds@woody git]$ TZ=right/Europe/Berlin date ; TZ=CET date
> 	Wed Jul 18 18:52:25 CEST 2007
> 	Wed Jul 18 18:52:48 CEST 2007
>
> so it really *is* the tzdata that says that Berlin is not +0200, and it's
> not even +0159, it's something really strange with fractional minutes away
> from UTC.

Well ... not if you compare right/Europe/Berlin vs right/CET

jp3@neutron: ~>TZ=right/CET date '+%H:%M:%S %z'; TZ=right/Europe/Berlin 
date '+%H:%M:%S %z'
19:49:45 +0200
19:49:45 +0200

but, I suspect that the following is the underlying cause of the problem?

jp3@neutron: ~>TZ=right/UTC date '+%H:%M:%S %z'; TZ=UTC date '+%H:%M:%S 
%z'
17:51:32 +0000
17:51:55 +0000

Is git working internally in TZ=UTC?

-- 
Julian

  ---

Homer:	We always have one good kid and one lousy kid.  Why can't both
 	our kids be good?

Marge:	We have three kids, Homer.

 		   Separate Vacations
