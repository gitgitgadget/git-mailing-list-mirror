From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Debugging corrupt object generation
Date: Fri, 2 Nov 2007 00:26:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711020018400.18429@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0711012256080.17812@beast.quantumfyre.co.uk>
 <alpine.LFD.0.9999.0711011947220.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 01:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InkNB-0001jN-U5
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 01:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbXKBA0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 20:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbXKBA0k
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 20:26:40 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:35141 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754375AbXKBA0j (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 20:26:39 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 662B9C61D4
	for <git@vger.kernel.org>; Fri,  2 Nov 2007 00:26:38 +0000 (GMT)
Received: (qmail 20114 invoked by uid 103); 2 Nov 2007 00:26:37 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91.2/4654. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.030306 secs); 02 Nov 2007 00:26:37 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 2 Nov 2007 00:26:37 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.0.9999.0711011947220.21255@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63041>

On Thu, 1 Nov 2007, Nicolas Pitre wrote:

> On Thu, 1 Nov 2007, Julian Phillips wrote:
>
>> After a certain commit, and attempt to use that commit generates a "fatal:
>> unable to apply delta".  This appears to be coming from unpack_delta_entry
>> in sha1_file.c.
>
> I suppose you mean "fatal: failed to apply delta", because "unable to
> apply delta" doesn't appear anywhere in the current source tree.

I did indeed.  Read 'n' type never seems to be as reliable as copy 'n' 
paste ...

>> Can anyone give me any hints as to how I find out what is causing the
>> problem?  I'm not even sure what it is that isn't working ... and all
>> attempts to replicate the problem with my test repository have failed.
>
> Well, something is screwed for sure.  Some object you're requesting is
> made of a delta, and that delta is bad, therefore patch_delta() returns
> NULL (you could instrument it to determine exactly why).

Ah, ok - that sounds like it might be useful.  I guess that looking at the 
opposite side where fast-import is creating the data might also prove 
fruitful.

> Maybe fast-import hasn't flushed the needed data to the pack yet?

Well, fast-import completes quite happily and outputs the normal summary 
status.  I can look at logs and trees etc provided that I don't try and 
look at one particular part of the tree on one particular commit.  I 
think the problem is that I've managed to do something inside fast-import 
that corrupts one particular tree object (though I've no idea what that 
might be).

I shall have to start instrumenting and try again.

Thanks.

-- 
Julian

  ---
Many changes of mind and mood; do not hesitate too long.
