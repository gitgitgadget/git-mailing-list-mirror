From: David Goldfarb <deg@degel.com>
Subject: RE: trouble on windows network share
Date: Mon, 6 May 2013 10:46:41 +0000
Message-ID: <8B6563E531152E4190313499F193F94214AAB079@mbx500-u1-lo-3.exch500.msoutlookonline.net>
References: <871B6C10EBEFE342A772D1159D1320853F63D205@umechphj.easf.csd.disa.mil>
	<1367529968647-7584800.post@n2.nabble.com>
	<87ppx8o1lj.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214A9C966@mbx500-u1-lo-3.exch500.msoutlookonline.net>
	<87ip2wla12.fsf@linux-k42r.v.cablecom.net>
	<8B6563E531152E4190313499F193F94214AAAB42@mbx500-u1-lo-3.exch500.msoutlookonline.net>
 <878v3sh14d.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 12:46:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZIwS-0006g8-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 12:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab3EFKqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 06:46:45 -0400
Received: from HUB500-LO-4.exch500.serverdata.net ([205.217.20.176]:39329 "EHLO
	hub500-LO-4.EXCH500.SERVERDATA.NET" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753366Ab3EFKqo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 May 2013 06:46:44 -0400
Received: from MBX500-U1-LO-3.exch500.msoutlookonline.net ([10.32.4.55]) by
 HUB500-LO-4.exch500.msoutlookonline.net ([10.32.4.39]) with mapi id
 14.03.0123.003; Mon, 6 May 2013 03:46:35 -0700
Thread-Topic: trouble on windows network share
Thread-Index: AQHOSkGhDJxfER0S7U2/adU3l4duX5j376ZggAAJdNA=
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [87.69.114.75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223441>

Oops, I earlier missed the second half of your message, where you suggested that I patch move_temp_to_file().
Sorry, I don't have the tool-chain or knowledge to recompile git into this win/Cygwin environment.

What I can do, realistically, is:
- Follow exact instructions.
- (with some obvious hesitation) run executables that you send me.
- Continue whatever tests you want with my existing git.

Note, too, that:
- This is occurring on a standard, off-the-shelf, NAS box, the Western Digital "My Book Live"
- I would guess that the "craziness" has more to do with the box's network stack than with its FS, since it behaves fine when mounted on Linux, but not on Windows.

David



-----Original Message-----
From: David Goldfarb 
Sent: Monday, May 06, 2013 1:13 PM
To: 'Thomas Rast'
Cc: git@vger.kernel.org
Subject: RE: trouble on windows network share

Ok.  Continuing in the same shell:

    U:\foo>git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       new file:   trace1
    #
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       trace2

    U:\foo>git commit -m "test b"
    error: Trying to write ref refs/heads/master with nonexistent object 428dafc292b8396fc7b3c7f692dc9dfe1196a40a
    fatal: cannot update HEAD ref

    U:\foo>dir /s *a40a
     Volume in drive U is Users
     Volume Serial Number is FC97-3DA5

     Directory of U:\foo\.git\objects\42

    05/06/2013  12:26 PM               152 8dafc292b8396fc7b3c7f692dc9dfe1196a40a
                   1 File(s)            152 bytes

         Total Files Listed:
                   1 File(s)            152 bytes
                   0 Dir(s)  1,594,477,576,192 bytes free

    U:\foo>date
    The current date is: Mon 05/06/2013
    Enter the new date: (mm-dd-yy)
    U:\foo>time
    The current time is: 13:10:49.55
    Enter the new time:
    U:\foo>git cat-file -p 428dafc292b8396fc7b3c7f692dc9dfe1196a40a
    tree cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
    parent f6a0de35d12a3b58f12bf1af4ff629b8b004ad82
    author David Goldfarb <deg@degel.com> 1367834997 +0300
    committer David Goldfarb <deg@degel.com> 1367834997 +0300

    test b

    U:\foo>U:\foo>



David

-----Original Message-----
From: Thomas Rast [mailto:trast@inf.ethz.ch]
Sent: Monday, May 06, 2013 1:08 PM
To: David Goldfarb
Cc: git@vger.kernel.org
Subject: Re: trouble on windows network share

David Goldfarb <deg@degel.com> writes:

> Looks like it works.
>
> From the windows machine:
>     U:\foo>git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
>     100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
>     100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
>
>     U:\foo>
>
>
> Double-checking that nothing was fixed or changed when I earlier committed the file from Linux, here's a second test:
>
>
>     U:\foo>git cat-file -p 0b89efdeef245ed6a0a7eacc5c578629a141f856
>     100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
>     100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
>     
>     U:\foo>git status
>     # On branch master
>     # Untracked files:
>     #   (use "git add <file>..." to include in what will be committed)
>     #
>     #       trace1
>     #       trace2
>     nothing added to commit but untracked files present (use "git add" 
> to track)
>     
>     U:\foo>git add trace1
>     
>     U:\foo>git commit trace1 -m "testing"

Note that specifying 'trace1' here is redundant, since you already added it and had no other staged changes.  Perhaps you can re-run a test like this without the extra argument for comparison.  That would tell us if it matters that the write and read happen in the same process.

>     error: unable to find cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
>     fatal: cecae5b4c87ea21aef513fcfcd5c27fe87e0536f is not a valid 
> object
>     
>     U:\foo>git cat-file -p cecae5b4c87ea21aef513fcfcd5c27fe87e0536f
>     100644 blob b02e7c87fe376a353ea4f014bdb3f5200a946b37    foo1
>     100644 blob 2cbf64f759a62392ad9dfe1fb9c2cdb175876014    foo2
>     100644 blob 19102815663d23f8b75a47e7a01965dcdc96468c    test.txt
>     100644 blob c9009b02950964cf1d5281125e6e2f647dd9dc16    trace1

I'm inclined to just say that your FS is crazy.

What's unsatisfactory is that we already have a bunch of crazy FS workarounds in move_temp_to_file(), which is one obvious candidate for what is going on here.  So this wouldn't be something new; just another craziness to work around.

For example, you could test the theory that rename() has something to do with it by patching this into move_temp_to_file():

diff --git i/sha1_file.c w/sha1_file.c
index 67e815b..22af015 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -2635,6 +2635,10 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 		/* FIXME!!! Collision check here ? */
 	}
 
+	if (access(filename, R_OK) < 0)
+		return error("access(%s, R_OK) failed immediately after rename(): %s",
+			     filename, strerror(errno));
+
 out:
 	if (adjust_shared_perm(filename))
 		return error("unable to set permission to '%s'", filename);


--
Thomas Rast
trast@{inf,student}.ethz.ch
