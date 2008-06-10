From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Mon, 9 Jun 2008 23:38:04 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0806092335420.17180@swallowtail>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1863694228-1213079885=:17180"
Cc: Clark Williams <clark.williams@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5xUg-0003zb-DY
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 08:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYFJGhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 02:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYFJGhR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 02:37:17 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:43265 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751508AbYFJGhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 02:37:15 -0400
Received: from swallowtail (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id E89C2A0128;
	Tue, 10 Jun 2008 02:40:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by swallowtail (Postfix) with ESMTPS id 4F1CB3FCBF;
	Mon,  9 Jun 2008 23:38:05 -0700 (PDT)
X-X-Sender: paulproteus@swallowtail
In-Reply-To: <20080610063328.GB26965@diana.vm.bytemark.co.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84477>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1863694228-1213079885=:17180
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 10 Jun 2008, Karl Hasselström wrote:

> On 2008-06-09 13:38:55 -0500, Clark Williams wrote:
>
>> This patch allows StGit to directly import compressed (.gz and .bz2)
>> files with reasonable patch names.
>>
>> I do a lot of work on modified kernel trees and usually the first
>> two things imported are a stable update patch followed immediately
>> by an -rt patch, both of which are compressed. With this patch I can
>> just copy the files down directly from kernel.org and import them,
>> rather than having to keep uncompressed copies around.
>>
>> Hey, I'm lazy... :)
>
> Lazy is good. Thanks for the patch!
>
>> +        if filename.endswith(".gz"):
>> +            import gzip
>> +            f = gzip.open(filename)
>> +            pname = filename.replace(".gz", "")
>> +        elif filename.endswith(".bz2"):
>> +            import bz2
>> +            f = bz2.BZ2File(filename, 'r')
>> +            pname = filename.replace(".bz2", "")
>
> Some comments here:
>
>  * By my reading of the docs, the second argument to BZ2File defaults
>    to 'r' anyway, so you could omit it.

Peanut gallery question: Why not just always try these methods and catch 
some format exception if they fail, proceeding to the next possible 
decompressor (proceeding on to no decompressor)?

That way if a file is called .GZ, it will still be handled properly; in 
fact, all files would still be handled properly.  And these formats leave 
notes in the first few bytes of the file as to if they should be tried, so 
it's not as if it would come at some performance cost.

-- Asheesh.

-- 
Say "twenty-three-skiddoo" to logout.
--8323329-1863694228-1213079885=:17180--
