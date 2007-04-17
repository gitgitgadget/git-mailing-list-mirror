From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] refs.c: add a function to sort a ref list, rather then
 sorting on add
Date: Tue, 17 Apr 2007 22:01:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704172156590.9988@beast.quantumfyre.co.uk>
References: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 23:01:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdunh-0000wB-GB
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 23:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031233AbXDQVBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 17:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031228AbXDQVBS
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 17:01:18 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:34019 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031233AbXDQVBR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2007 17:01:17 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 6BD8AC6282
	for <git@vger.kernel.org>; Tue, 17 Apr 2007 22:01:16 +0100 (BST)
Received: (qmail 8451 invoked by uid 103); 17 Apr 2007 22:00:35 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3104. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.039818 secs); 17 Apr 2007 21:00:35 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 17 Apr 2007 22:00:34 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070417014307.12486.28930.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44825>

On Tue, 17 Apr 2007, Julian Phillips wrote:

> Rather than sorting the refs list while building it, sort in one go
> after it is built using a merge sort.  This has a large performance
> boost with large numbers of refs.
>
> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
> ---
>
> Having got builtin fetch to the point of generating a correct FETCH_HEAD (for a certain path through the code at least), I revisted the speed issue I brought up a while back with the sorting of refs.
>
> Running fetch (builtin version) on a repo with >9000 refs which is up-to-date, using the old sort-on-add I get (best of 5, warm cache):
>
> real    0m4.351s
> user    0m4.068s
> sys     0m0.219s
>
> With this patch the same fetch gives (worst of 5, warm cache):
>
> real    0m2.196s
> user    0m1.870s
> sys     0m0.212s
>
> Since this is orthogonal to making fetch a builtin, I don't see that it needs to wait ...

In case anyone is curious, doing the same fetch with master 
(v1.5.1.1-135-gf948792):

master (best of 5, warm cache):
real    0m33.962s
user    0m23.992s
sys     0m9.986s

master + patch (worst of 5, warm cache):
real    0m20.821s
user    0m10.390s
sys     0m9.799s

-- 
Julian

  ---
NANCY!!  Why is everything RED?!
