From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Strangely broken git repo
Date: Mon, 10 Oct 2005 17:26:05 +1300
Message-ID: <4349ED5D.6020703@catalyst.net.nz>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>	 <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Oct 10 06:27:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOpEl-0002TA-3s
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 06:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVJJE0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 00:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVJJE0D
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 00:26:03 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:43420 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932339AbVJJE0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 00:26:02 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1EOpEd-00043N-WA
	for git@vger.kernel.org; Mon, 10 Oct 2005 17:26:00 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9874>

Hi!

We are having strange problems pushing (and pulling) with a particular
head in a git repo. The repo is publicly available via http, and when
I clone it it gives me a lot of errors

$ cg-clone http://locke.catalyst.net.nz/git/moodle.git#moodle--topnz
...
Getting index for pack 3e3492f365bb0d4a1ae11dfa7cee9ebbf345e647
Getting pack 3113eb34ef85482c87c3575721ce978c7232071f
which contains 007a0323cf0941476dc262f6e3aff6bb9600dcd8
error: The requested file was not found
... (many more like these)
FINISHED --15:56:38--
Downloaded: 4,723 bytes in 1 files
New branch: 6759e2800c0cef00017c63b7dbbed80e481dbe2c
Cloned to moodle.git#moodle--topnz/ (origin
http://locke.catalyst.net.nz/git/moodle.git#moodle--topnz available as
branch "origin")
aporo:~/tmp/moodle.git#moodle--topnz martin$ git-fsck-objects
bad sha1 file: .git/objects/00/7a0323cf0941476dc262f6e3aff6bb9600dcd8.temp
... (many more like these)

When using git+ssh, we are seeing very strange stalls during the
fetch, and when trying to push a couple of small new commits, it has
given us (from a Debian etch-ppc, git 0.99.8.b) gives us "fatal unpack
should have generated <sha1> but I can't find it".

This has been discussed earlier here
http://www.gelato.unsw.edu.au/archives/git/0508/7152.html -- but our
scenario doesn't involve rewinding or any strange trickery, it's just
clone - edit - commit - push.

 From a different machine (Debian sarge, i386, git 0.99.8b) the same
operation succeeds.

On the repo itself, I've run git-fsck-objects --full --strict and it
only complained about dangling tags. There are some heads on that repo
that I have deleted a while ago without purging unreachable objects,
so I kind of expected those.

There are some automated jobs that touch this repo and may have messed
things up:
  - cronjobs running git-cvsimport and git-archimport and pushing to 
this repo
  - weekly git-repack run over the repo

Uff. I have the feeling that this isn't a very complete picture, but
I'm not sure what else to do to debug this one. Pointers welcome.

cheers,


martin
