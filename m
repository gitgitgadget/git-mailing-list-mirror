From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Why are ref_lists sorted?
Date: Mon, 19 Mar 2007 05:22:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0703190520150.24247@beast.quantumfyre.co.uk>
References: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 06:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTAKR-00033X-Bn
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 06:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbXCSFWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 01:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbXCSFWm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 01:22:42 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36633 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965073AbXCSFWl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2007 01:22:41 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id AA859C61A6
	for <git@vger.kernel.org>; Mon, 19 Mar 2007 05:22:40 +0000 (GMT)
Received: (qmail 6730 invoked by uid 103); 19 Mar 2007 05:22:40 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2869. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.138404 secs); 19 Mar 2007 05:22:40 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 19 Mar 2007 05:22:39 +0000
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42590>

On Mon, 19 Mar 2007, Julian Phillips wrote:

> A bit of investigation showed this to be due to the first attempt to read a 
> ref causing the packed refs to be loaded.  In my test repo the packed-refs 
> file has over 9000 entries, but I still thought that it would load faster 
> than that.  It turns out that the overhead is from sorting the refs when 
> building the ref_list.  If I remove the code for sorting the entries I lose 
> that initial 1s delay, without appearing to break anything in the fetch. 
> However I assume that it's there for a reason ...
>

Actually, it's worse than that ... I forgot about the other end.  If I 
point fetch at an upload-pack with the sorted removed the time goes down 
by another second.  So that sorting accounts for 2 of the 3s ...

-- 
Julian

  ---
Know thyself.  If you need help, call the C.I.A.
