From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Sun, 08 Nov 2015 06:03:28 +0100
Message-ID: <563ED7A0.7040007@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>	<3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu>	<1446670884.4131.42.camel@twopensource.com>	<563AD452.2030301@alum.mit.edu>	<1446740535.4131.50.camel@twopensource.com>	<563CAC58.3070907@alum.mit.edu>	<xmqq611f3umt.fsf@gitster.mtv.corp.google.com> <xmqqd1vm3e59.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 06:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvIFe-0002Gp-Eg
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 06:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbbKHFKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 00:10:46 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59269 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050AbbKHFKp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Nov 2015 00:10:45 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Nov 2015 00:10:45 EST
X-AuditID: 12074414-f794f6d000007852-4d-563ed7a339b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id EE.E2.30802.3A7DE365; Sun,  8 Nov 2015 00:03:32 -0500 (EST)
Received: from [192.168.69.130] (p4FC97053.dip0.t-ipconnect.de [79.201.112.83])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA853TLV003137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 8 Nov 2015 00:03:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqd1vm3e59.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqLvkul2Ywaq9TBbzN51gtOi60s1k
	0dB7hdniR0sPswOLx7PePYweFy8peyx4fp/d4/MmuQCWKG6bpMSSsuDM9Dx9uwTujG13pjIX
	bBOueH/nJXsD40z+LkZODgkBE4lrtz8zQthiEhfurWfrYuTiEBK4zCjR//MpO4Rzjkni4esV
	zCBVvALaEn+vNoLZLAKqEq/bnrGC2GwCuhKLepqZQGxRgSCJFctfMELUC0qcnPmEBcQWEVCT
	mNh2CMxmFkiRODDjABuILSzgKPHryWNmiGV/mCTmv1oCNohTwFri/PdbzBANehI7rv9ihbDl
	JZq3zmaewCgwC8mOWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWl
	dBMjJKRFdjAeOSl3iFGAg1GJhzci1y5MiDWxrLgy9xCjJAeTkijvox1AIb6k/JTKjMTijPii
	0pzU4kOMEhzMSiK8Fy8D5XhTEiurUovyYVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiU
	JHhjrgE1ChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIOiNb4YGK8gKR6gvQYg7bzF
	BYm5QFGI1lOMilLivDIgCQGQREZpHtxYWKJ6xSgO9KUw7z6QKh5gkoPrfgU0mAlosEOUDcjg
	kkSElFQDo3iOsUnnqq9XunTFHqfLuq+UKlG3eZkezLOlK+rUuRcWltN4Jsx7nhN8PuLvH/HI
	WVdtqzL+sB3kmea94vhB4ZPTddeKC/KKy01/pLyeb513ML98p6gP17aEL0qVlb65 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281030>

On 11/07/2015 12:24 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> [...] And then, if you are also OK with the
>>> new subdirectory introduced in this patch series, David and I seem to be
>>> in agreement that it is ready to go. It would be great if this patch
>>> series could be merged in a timely manner, as it will conflict with
>>> nearly any other changes that people might want to undertake in the refs
>>> code.
>>
>> Thanks for working well together.  Let me see what I can do today...
> 
> What I'll push out later today merges this to the tip of 'pu'.
> The resolution is the same for 'jch' or 'next' (I checked).
> 
> I have to say that the merge of this topioc is not pretty.  [...]

I hate to cause the maintainer extra work. I guess I was making two
naive assumptions:

* If we make the code-movement series simple and "obviously correct"
  enough, then it could be merged pretty much straight through to
  master.

* If one or two topics conflict with the code movement, they could
  be one-time rebased on top of the new master (I would be willing
  to do this work).

Maybe neither of these assumptions is valid. And maybe the correctness
of our series in its current form isn't quite obvious enough.

David and I will be the ones who benefit most from having this resolved
quickly, because there is lots more work that has to be done after the
code movement and it is kindof hard to continue that work while this
topic is up in the air.

I can see a few ways that we could make our series even more
straightforward:

1. Leave refs.c in its original location (as suggested by Junio).
   Optionally, it could be moved at a later date when this area is
   quiescent.

2. Move content selectively from refs.c to refs/files-backend.c rather
   than moving the whole file there and then moving content selectively
   back to refs/refs.c.

3. Separate *all* of the non-obvious changes into a preparatory
   patch series, to be followed by a separate patch series that *only*
   moves code.

The first idea would be a couple of hours of work (including adjusting
comments and commit messages). The second and third ideas would probably
best be done in combination, and might take a day or two of work because
they involve reordering patches.

Let us know what you think.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
