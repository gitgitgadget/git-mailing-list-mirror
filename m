From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] refs.c: drop duplicate entries in sort_ref_list
Date: Thu, 19 Apr 2007 09:49:42 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704190934480.30526@reaper.quantumfyre.co.uk>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
 <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
 <7vslaymzk3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704172304380.16435@beast.quantumfyre.co.uk>
 <7vodllfpaj.fsf@assigned-by-dhcp.cox.net> <20070418212749.4842.62822.julian@quantumfyre.co.uk>
 <4627262A.463AA87D@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 10:49:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeSKt-0004bU-MI
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 10:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161328AbXDSItp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 04:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993185AbXDSItp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 04:49:45 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:45383 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161340AbXDSIto (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 04:49:44 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id DE0F7C6499
	for <git@vger.kernel.org>; Thu, 19 Apr 2007 09:49:42 +0100 (BST)
Received: (qmail 6094 invoked by uid 103); 19 Apr 2007 09:48:57 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3125. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.041981 secs); 19 Apr 2007 08:48:57 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 19 Apr 2007 09:48:57 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <4627262A.463AA87D@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44996>

On Thu, 19 Apr 2007, Johannes Sixt wrote:

> Julian Phillips wrote:
>>
>> It shouldn't happen that we read duplicate entries into the same list,
>> but just in case make sort_ref_list drop them.  If the SHA1s don't
>> match then die instead, as we have no way of knowing which one is the
>> correct one.
>
> Clone a random repository that has tags, then
>
> $ rm .git/refs/tags/*
> $ git fetch origin
>
> now lists each tag twice: for the tag object itself and the commit it
> points to. Is this related to the problem you are solving here? If so,
> dying is probably not the best in this situation since the tags are
> still unique.

The sort function is only looking at refs.  So if you rm .git/refs/tags/* 
then you don't have any tag refs (assuming no packed-refs).  What it is 
talking about is having two instances of (e.g.) refs/tags/foo.

In the situation you mention above you still shouldn't see duplicated 
refs.

-- 
Julian

  ---

Ah, so that's what's been wrong with the little fella.  He misses
casual sex.

 		-- Homer Simpson
 		   Two Dozen and One Greyhounds
