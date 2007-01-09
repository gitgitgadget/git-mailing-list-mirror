From: Wolfgang Fischer <wf@wf227.com>
Subject: Re: Bug in git-status with non-ascii characters:
Date: Tue, 9 Jan 2007 15:14:01 +0100
Message-ID: <6EBAA8D1-9839-4B77-968A-2828B19A9BF7@wf227.com>
References: <7BACA5DE-9DBA-4299-A965-E248263E27E2@silverinsanity.com> <17827.10918.897000.825178@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Juergen Ruehle <j.ruehle@bmiag.de>
X-From: git-owner@vger.kernel.org Tue Jan 09 15:45:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4IDw-0006Dc-AJ
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 15:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbXAIOpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 9 Jan 2007 09:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXAIOpI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 09:45:08 -0500
Received: from mail.wf227.com ([217.9.110.226]:32782 "EHLO mail.wf227.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113AbXAIOpH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 09:45:07 -0500
X-Greylist: delayed 1908 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 09:45:07 EST
Received: from [192.168.140.94] (unknown [145.253.159.194])
	by mail.wf227.com (Postfix) with ESMTP id 78C84BB44F;
	Tue,  9 Jan 2007 14:13:18 +0000 (UTC)
In-Reply-To: <17827.10918.897000.825178@lapjr.intranet.kiel.bmiag.de>
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36365>


On 09.01.2007, at 06:39, Juergen Ruehle wrote:

> Brian Gernhardt writes:
>> `git status` always reports the following:
>>
>> ----- 8< -----
>> # On branch refs/heads/master
>> # Untracked files:
>> #   (use "git add <file>..." to incrementally add content to commit)
>> #
>> #       gitweb/test/M=E4rchen
>> no changes added to commit (use "git add" and/or "git commit [-a|-i|=
-
>> o]")
>> ----- 8< -----
>>
>> When I do `rm gitweb/test/M<tab>` to remove this apparently unneeded
>> file, `git status` reports:
>>
>> ----- 8< -----
>> # On branch refs/heads/master
>> # Changed but not added:
>> #   (use "git add <file>..." to incrementally add content to commit)
>> #
>> #       deleted:    gitweb/test/M=E4rchen
>> #
>> no changes added to commit (use "git add" and/or "git commit [-a|-i|=
-
>> o]")
>> ----- 8< -----
>>
>> This is on Mac OS X, file system is HFS+ (Journaled).  Is this
>> expected?  I can't figure out why it's happening.
>
> It's a known problem with HFS+: it uses different byte sequences to
> identify the same file. Therefore git finds gitweb/test/M=E4rchen
> unchanged but also a gitweb/test/M=E4rchen in the working directory
> using a different byte sequence for the name as reported in status. I=
f
> you delete the file git doesn't find the file any longer and reports
> that in status as well.

Since this problem is discussed every other week, how about changing =20
the name of the test file to scheu=DFlicher_Dateiname or so, since the =
=20
sz-ligature does not have the problem of different UTF-8 =20
normalization forms. It wont fix HFS+, but since HFS+ is designed to =20
accept either UTF-8 normalization form and returning just NFD, nobody =20
will change/fix HFS+ anyway.

	Wolfgang