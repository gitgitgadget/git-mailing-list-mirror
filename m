From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: Git ~unusable on slow lines :,'C
Date: Tue, 09 Oct 2012 03:49:36 +0200
Message-ID: <87lifgct3j.fsf@centaur.cmartin.tk>
References: <50731B2A.6040104@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marcel Partap <mpartap@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 03:49:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLOx2-00052E-DS
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 03:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072Ab2JIBta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 21:49:30 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:52590 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750883Ab2JIBt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 21:49:29 -0400
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 66F7280014;
	Tue,  9 Oct 2012 03:49:26 +0200 (CEST)
Received: (nullmailer pid 10929 invoked by uid 1000);
	Tue, 09 Oct 2012 01:49:36 -0000
In-Reply-To: <50731B2A.6040104@gmx.net> (Marcel Partap's message of "Mon, 08
	Oct 2012 20:27:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207282>

Marcel Partap <mpartap@gmx.net> writes:

> Dear Git Devs,
> I love GIT, but since a couple of months I'm on 3G and after my traffic
> limit is transcended, things slow down to a feeble 8KiB/s. Juuuust like
> back then - things moved somewhat slower. And I'm fine with that - as
> long as things just keep moving.
> Unfortunately, git does not scale down very well, so for ten more days I
> will be unable to get the newest commits onto my machine. Which is very,
> very sad :/
>> git fetch --verbose --all 
>> Fetching origin
>> POST git-upload-pack (1023 bytes)
>> POST git-upload-pack (gzip 1123 to 614 bytes)
>> POST git-upload-pack (gzip 1973 to 1030 bytes)
>> POST git-upload-pack (gzip 5173 to 2639 bytes)
>> POST git-upload-pack (gzip 7978 to 4042 bytes)
>> remote: Counting objects: 24504, done.
>> remote: Compressing objects: 100% (10705/10705), done.
>> error: RPC failed; result=56, HTTP code = 200iB | 10 KiB/s       
>> fatal: The remote end hung up unexpectedly
>> fatal: early EOF
>> fatal: index-pack failed
>> error: Could not fetch origin
> Bam, the server kicked me off after taking to long to sync my copy.

This is unrelated to git. The HTTP server's configuration is too
impatient.

> Multiple potential points of action:
> - git fetch should show the total amount of data it is about to
> transfer!

It can't, because it doesn't know.

> - when ab^H^Horting, the cursor should be moved down (tput cud1) to not
> overwrite previous output

The error message doesn't really know whether it is going to overwrite
it (the CR comes from the server), though I suppose an extra LF wouldn't
hurt there.

> - would be nice to be able to tell git fetch to get the next chunk of
> say 500 commits instead of trying to receive ALL commits, then b0rking
> after umpteen percent on server timeout. Not?

You asked for the current state of the repository, and that's what its
giving you. The timeout has nothing to do with git, if you can't
convince the admins to increase it, you can try using another transport
which doesn't suffer from HTTP, as it's most likely an anti-DoS measure.

If you want to download it bit by bit, you can tell fetch to download
particular tags. Doing this automatically for this would be working
around a configuration issue for a particular server, which is generally
better fixed in other ways.


   cmn
