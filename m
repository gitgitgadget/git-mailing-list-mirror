From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Non-http dumb protocols
Date: Sun, 1 Jul 2007 06:48:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707010646461.22915@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0706301613410.14638@iabervon.org>
 <7vbqewakz8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 01 07:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4sIg-00026G-VN
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 07:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbXGAFsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 01:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbXGAFsk
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 01:48:40 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47918 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751387AbXGAFsj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jul 2007 01:48:39 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 0E3DFC15D4
	for <git@vger.kernel.org>; Sun,  1 Jul 2007 06:48:37 +0100 (BST)
Received: (qmail 30425 invoked by uid 103); 1 Jul 2007 06:48:37 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.3/3564. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.034049 secs); 01 Jul 2007 05:48:37 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 1 Jul 2007 06:48:37 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <7vbqewakz8.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51277>

On Sat, 30 Jun 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> Do we actually support local-fetch and ssh-fetch/ssh-push any more? They
>> seem to me to have been entirely supplanted with respect to functionality
>> for a long time now, but the programs are still there. This complicates
>> http-fetch, because only one -fetch can be linked into a binary as
>> currently designed, and we may want to make http-fetch builtin at some
>> point. Can we remove the other dumb protocols and merge fetch.c into
>> http-fetch.c?


> To be linked with the rest of git, I think the global symbols
> fetch.c has are named a little too generically, and they would
> need to be fixed first.  It may make sense to do the "backend
> descriptor" code restructure first _before_ linking anything
> with the rest of git.  We can rename main() in *-fetch.c to
> cmd_*_fetch() only for the ones that we choose to make built-in
> when the conversion is ready.
>
> Having said that, I have a feeling that many people do not build
> any of the commit walkers, and especially the http walker,
> because they have no need for dumb protocols, and libcurl-dev is
> just another piece of dependency they do not have to have.  If
> we were to do a built-in http-fetch, we also need to make sure
> it is done in such a way that people can choose to configure it
> out.

As part of making fetch a builtin, I also made http-fetch a builtin so
that I reuse some of the code.  When I did this it kept the same optional
build status as the original separate program.  Since Daniel based his
work on mine, he should have this change too ... however I didn't do any 
renaming of symbols in builtin-http-fetch.c other than the minimum 
necessary to make it a builtin.

-- 
Julian

  ---
Taxes are going up so fast, the government is likely to price itself
out of the market.
