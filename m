From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then
 sorting on add
Date: Tue, 17 Apr 2007 23:03:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704172300170.16435@beast.quantumfyre.co.uk>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
 <Pine.LNX.4.64.0704170901170.5473@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704172114040.8164@beast.quantumfyre.co.uk>
 <Pine.LNX.4.64.0704171350000.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:03:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdvlh-0003bO-Ox
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 00:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031277AbXDQWDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031272AbXDQWDR
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 18:03:17 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:50425 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031277AbXDQWDQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 18:03:16 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 57087C629F
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 23:03:15 +0100 (BST)
Received: (qmail 10220 invoked by uid 103); 17 Apr 2007 23:02:33 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3104. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.039628 secs); 17 Apr 2007 22:02:33 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 23:02:33 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0704171350000.5473@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44837>

On Tue, 17 Apr 2007, Linus Torvalds wrote:

>
>
> On Tue, 17 Apr 2007, Julian Phillips wrote:
>>
>> It's the tag auto-following code, I'm calling read_ref to see if I already
>> have that tag - and it appears that doing that a few thousand times takes a
>> while.
>
> Heh. I think we should probably call read_refs() just once to read them
> all (when most of them are packed, that's cheap), and then after that,
> have some way to just check for a match on the refs we have cached.

I had a look at the exclude_existing function in show-ref.  That uses 
for_each_ref to build a path_list, and path_list_has_path to do the 
filtering...

Using that I get (worst of 5, warm cache):
real    0m0.526s
user    0m0.302s
sys     0m0.176s

-- 
Julian

  ---
The descent to Hades is the same from every place.
 		-- Anaxagoras
