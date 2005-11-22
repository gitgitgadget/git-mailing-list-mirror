From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: auto-packing on kernel.org? please?
Date: Tue, 22 Nov 2005 00:26:41 -0500
Organization: Network Appliance, Inc.
Message-ID: <4382AC11.5090209@citi.umich.edu>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> <20051121190151.GA2568@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050800000301050105010708"
Cc: Carl Baldwin <cnb@fc.hp.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 06:28:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeQgA-0002m7-6T
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 06:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVKVF0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 00:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVKVF0v
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 00:26:51 -0500
Received: from citi.umich.edu ([141.211.133.111]:59067 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932307AbVKVF0u (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 00:26:50 -0500
Received: from [10.58.52.182] (nat-198-95-226-230.netapp.com [198.95.226.230])
	by citi.umich.edu (Postfix) with ESMTP id 140AD1BAD0;
	Tue, 22 Nov 2005 00:26:43 -0500 (EST)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12526>

This is a multi-part message in MIME format.
--------------050800000301050105010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Mon, 21 Nov 2005, Carl Baldwin wrote:
> 
>>I have a question about automatic repacking.
>>
>>I am thinking of turning something like Linus' repacking heuristic loose
>>on my repositories.  I just want to make sure it is as safe as possible.
>>
>>At the core of the incremental and full repack strategies are these
>>statements.
>>
>>Incremental...
>>
>>>		git repack &&
>>>			git prune-packed
>>
>>Full...
>>
>>>		git repack -a -d &&
>>>			git prune-packed
> 
> 
> NOTE! Since that email, "git repack" has gotten a "local" option (-l), 
> which is very useful if the repositories have pointers to alternates.
> 
> So do
> 
> 	git repack -l
> 
> instead, to get much better packs (and "-a -d" for the full case, of 
> course).
> 
> Other that than, the old email suggestion should still be fine.

i've been playing with "git repack" on StGIT-managed repositories.

on NFS, using packs instead of individual objects is quite a bit faster, 
because a single NFS GETATTR will tell you if your NFS client's cached 
pack file is still valid, whereas a whole bunch of GETATTRs are required 
for validating individual object files.

there are some things repacking does that breaks StGIT, though.

git repack -d

seems to remove old commits that StGIT was still depending on.

git repack -a -n

seems to work fine with StGIT, as does

git prune-packed

i'm really interested in trying out the new command to remove redundant 
objects and packs, but haven't gotten around to it yet.

--------------050800000301050105010708
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


--------------050800000301050105010708--
