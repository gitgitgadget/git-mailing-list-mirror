From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 18:28:09 -0400
Organization: Network Appliance, Inc.
Message-ID: <4328A3F9.1010506@citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu> <20050912145629.28120.70337.stgit@dexter.citi.umich.edu> <Pine.LNX.4.63.0509121633480.23242@iabervon.org> <43284368.8010004@citi.umich.edu> <Pine.LNX.4.63.0509141214490.23242@iabervon.org> <43287ECB.8090308@citi.umich.edu> <Pine.LNX.4.63.0509141622340.23242@iabervon.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090802060700090700040608"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 00:31:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFfle-0004XT-UX
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 00:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVINW2R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 18:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbVINW2R
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 18:28:17 -0400
Received: from citi.umich.edu ([141.211.133.111]:26207 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1030236AbVINW2K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 18:28:10 -0400
Received: from [141.211.133.33] (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id D89AD1BAF1;
	Wed, 14 Sep 2005 18:28:09 -0400 (EDT)
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509141622340.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8572>

This is a multi-part message in MIME format.
--------------090802060700090700040608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Daniel Barkalow wrote:
> On Wed, 14 Sep 2005, Chuck Lever wrote:
>>[ i'm not sure why you think insert would be O(n). ]
> 
> 
> You need to find the correct location to insert in the sorted list, and 
> the hash table won't help you, because it doesn't have the new name. 
> Remember that the cursors need to go through the index in order, so the 
> list has to stay sorted.

oh, i see.  the hash table won't help cache_find_name find an insertion 
point quickly if the name isn't already in the cache.

in fact, this will impact the other places that need an insertion point, 
such as ls-files and merge-index, as well as your new merge algorithm 
(which inserts all merged entries into the active cache one at a time 
via add_cache_entry).

considering that add_cache_entry can do a cache lookup several times, i 
think we need the "not found, returning insertion point" case to be fast 
too.

back to the drawring board.

--------------090802060700090700040608
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Linux NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763 4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668 1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------090802060700090700040608--
