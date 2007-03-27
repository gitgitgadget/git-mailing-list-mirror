From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: Type mismatches in safe_read and friends?
Date: Tue, 27 Mar 2007 12:34:03 +0200
Message-ID: <4608F31B.8070204@dawes.za.net>
References: <4607D4F6.80703@dawes.za.net> <20070326164755.GH13247@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 12:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW90U-0003tJ-Aw
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 12:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbXC0KeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 06:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbXC0KeX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 06:34:23 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:59576 "EHLO
	spunkymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753779AbXC0KeW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 06:34:22 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a7.g.dreamhost.com (Postfix) with ESMTP id A84A25C238;
	Tue, 27 Mar 2007 03:34:20 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <20070326164755.GH13247@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43254>

Shawn O. Pearce wrote:
>  
>> Or is it just a case that we don't really care, since we control the 
>> ranges of the values, and the underlying types are int anyway? Patches 
>> to follow if I get an indication that anyone cares, otherwise I'd be 
>> posting my question to a C newbies group. ;-)
> 
> It is sort of a case we don't care.  These probably should be fixed.
> A patch would be nice.  You want to learn C...  ;-)
> 

Ok. So I did a little patch, but I'm not sure whether I solved anything. 
Now we have an implicit cast from size_t to ssize_t in packet_read_line.

I guess this echoes your comment about requesting a large size_t, and 
getting a ssize_t result back. I suppose in theory we should be refusing 
to handle a length greater than that which would fit into a ssize_t? Or 
simply making sure to always return data smaller than max(ssize_t)?

Patch to follow.

Rogan
