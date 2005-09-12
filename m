From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree
 into another rather than two trees into merge base
Date: Mon, 12 Sep 2005 08:59:31 -0400
Organization: Network Appliance, Inc.
Message-ID: <43257BB3.5020506@citi.umich.edu>
References: <200509102027.28812.blaisorblade@yahoo.it> <1126427087.8457.33.camel@localhost.localdomain>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010609070605070604030303"
Cc: Blaisorblade <blaisorblade@yahoo.it>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 15:02:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEnuT-0000F6-Jh
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 14:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVILM7j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 08:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVILM7j
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 08:59:39 -0400
Received: from citi.umich.edu ([141.211.133.111]:35951 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1750798AbVILM7j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 08:59:39 -0400
Received: from [10.58.52.177] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id A39D91BB6C;
	Mon, 12 Sep 2005 08:59:32 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <1126427087.8457.33.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8380>

This is a multi-part message in MIME format.
--------------010609070605070604030303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Catalin Marinas wrote:
> On Sat, 2005-09-10 at 20:27 +0200, Blaisorblade wrote:
> 
>>I experienced a (performance) problem with StGit, but I don't know if it's the 
>>culprit or if git-merge-cache is.
> 
> 
> ('s/cache/index/g' below since I still use the old names)
> 
> Maybe both. I did some profiling in StGIT but only for trivial patches
> which did not involved calling gitmergeonefile.py. It was taking around
> 2.5s to push a patch with a changed base (involving merge) on an
> NFS-mounted directory but most of the time, 1.8s, was spent in
> git-read-tree to do the actual merge.
> 
> Someone else (Bcc'ed, not sure he wants his address to be public) did

that's me!  thanks catalin.

> some profiling on GIT and his conclusion was that most of the time was
> spend in memmove() called from add_cache_entry() in read-cache.c called
> from read-tree.c.
> 
> 
>>Today I was pushing my patch stack (which was against Linux 2.6.13) on top of 
>>the latest snapshot I have (i.e. upstream will likely have some mega of 
>>patches). And it was *really* slow (say it pushed 8 patches in 5 minutes).
> 
> 
> That's indeed very slow. How may files are modified in each patch? Do
> you run it over NFS? Also for profiling, it is useful to run a 'stg
> status' just to warm up the cache a little bit.

i've probably seen similar behavior with git-update-index, but i never 
bothered to measure it.  blaisorblade, how are you profiling git?

junio asked me to port my cache abstraction helpers over daniel's 
read-tree changes, which i have done.  i want to post those changes here 
today for comments.

--------------010609070605070604030303
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
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://www.monkey.org/~cel/
version:2.1
end:vcard


--------------010609070605070604030303--
