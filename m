From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Segfault in `git describe`
Date: Mon, 15 Jul 2013 15:03:51 +0200
Message-ID: <51E3F337.8070708@alum.mit.edu>
References: <krrkk0$kri$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 15:04:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyiRm-0001xX-9b
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 15:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab3GONDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 09:03:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:55610 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755996Ab3GONDy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jul 2013 09:03:54 -0400
X-AuditID: 1207440c-b7f016d000005997-2f-51e3f33945b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id AD.99.22935.933F3E15; Mon, 15 Jul 2013 09:03:53 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6FD3pSF011676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Jul 2013 09:03:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <krrkk0$kri$1@ger.gmane.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1LX8/DjQ4PVLfouuK91MFi/bDzA7
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7ozGXweYCiarVdw5+o6pgfGNfBcjJ4eEgInE
	5oXb2SBsMYkL99YD2VwcQgKXGSW67h1nh3CuMUms2b+QqYuRg4NXQFtix/ZgkAYWAVWJV2cP
	MIPYbAK6Eot6msFKRAXCJK78VgUJ8woISpyc+YQFxBYRsJH42dvLBlLCLCAu0f8PLCwsoC5x
	8v0sVhBbSEBD4l7zU7CJnAKaEh9fNzJBlKtLrJ8nBBJmFpCXaN46m3kCo8AsJAtmIVTNQlK1
	gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuoV5uZoleakrpJkZIgPLsYPy2TuYQowAHoxIP
	b6ba40Ah1sSy4srcQ4ySHExKorwn3wKF+JLyUyozEosz4otKc1KLDzFKcDArifAuvQiU401J
	rKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8L78CNQoWJSanlqRlplTgpBm
	4uAEGc4lJVKcmpeSWpRYWpIRD4rQ+GJgjIKkeID2bv0Asre4IDEXKArReopRl+PAjy3vGYVY
	8vLzUqXEeZ+A7BAAKcoozYNbAUtHrxjFgT4W5t0BUsUDTGVwk14BLWECWtI8G2xJSSJCSqqB
	sdbgWt2SjOUz5M8JT9t5a7J48YEkhoCWi1pmH1PMC7t0WKZ9nzs3Z3/7yhuBXxN2p7+w/5s3
	T6ma5Vb99U5TY49p1148dWedef2e3qp9Yfs8Xk/+Z/m/a/vMxXw57x7FpN2z+vxJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230461>

On 07/13/2013 03:27 PM, Mantas Mikul=C4=97nas wrote:
> I have a clone of linux.git with various stuff added to it (remotes f=
or
> 'stable' and 'next', a bunch of local tags, and historical repositori=
es
> imported using `git replace`).
>=20
> Yesterday, I noticed that `git describe`, built from git.git master
> (v1.8.3.2-804-g0da7a53, gcc 4.8) would simply crash when run in that
> repository, with the following backtrace:
>=20
>> Program terminated with signal 11, Segmentation fault.
>> #0  0x00000000004c39dc in hashcpy (sha_src=3D0x1c <Address 0x1c out =
of bounds>,=20
>>     sha_dst=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\337l\002B\2=
14P\037\210ShX\022")
>>     at cache.h:694
>> 694		memcpy(sha_dst, sha_src, 20);
>> (gdb) bt
>> #0  0x00000000004c39dc in hashcpy (sha_src=3D0x1c <Address 0x1c out =
of bounds>,=20
>>     sha_dst=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\337l\002B\2=
14P\037\210ShX\022")
>>     at cache.h:694
>> #1  peel_ref (refname=3Drefname@entry=3D0x1fe2d10 "refs/tags/next-20=
130607",=20
>>     sha1=3Dsha1@entry=3D0x7fffc0b4d610 "\242\271\301\366 \201&\346\3=
37l\002B\214P\037\210ShX\022") at refs.c:1586
>> #2  0x0000000000424194 in get_name (path=3D0x1fe2d10 "refs/tags/next=
-20130607",=20
>>     sha1=3D0x1fe2ce8 "\222V\356\276S5\tk\231Hi\264\r=3D\336\315\302\=
225\347\257\300N\376\327\064@\237ZDq[T\246\312\033T\260\314\362\025refs=
/tags/next-20130607", flag=3D<optimized out>,=20
>>     cb_data=3D<optimized out>) at builtin/describe.c:156
>> #3  0x00000000004c1c21 in do_one_ref (entry=3D0x1fe2ce0, cb_data=3D0=
x7fffc0b4d7c0)
>>     at refs.c:646
>> #4  0x00000000004c318d in do_for_each_entry_in_dir (dir=3D0x1fe1728,=
=20
>>     offset=3D<optimized out>, fn=3D0x4c1bc0 <do_one_ref>, cb_data=3D=
0x7fffc0b4d7c0)
>>     at refs.c:672
>> #5  0x00000000004c33d1 in do_for_each_entry_in_dirs (dir1=3D0x1fdf4d=
8, dir2=3D0x1fd6318,=20
>>     cb_data=3D0x7fffc0b4d7c0, fn=3D0x4c1bc0 <do_one_ref>) at refs.c:=
716
>> #6  0x00000000004c33d1 in do_for_each_entry_in_dirs (dir1=3D0x1fdf1f=
8, dir2=3D0x1fd62d8,=20
>>     cb_data=3D0x7fffc0b4d7c0, fn=3D0x4c1bc0 <do_one_ref>) at refs.c:=
716
>> #7  0x00000000004c3540 in do_for_each_entry (refs=3Drefs@entry=3D0x7=
a2800 <ref_cache>,=20
>>     base=3Dbase@entry=3D0x509cc6 "", cb_data=3Dcb_data@entry=3D0x7ff=
fc0b4d7c0,=20
>>     fn=3D0x4c1bc0 <do_one_ref>) at refs.c:1689
>> #8  0x00000000004c3ff8 in do_for_each_ref (cb_data=3Dcb_data@entry=3D=
0x0, flags=3D1, trim=3D0,=20
>>     fn=3Dfn@entry=3D0x424120 <get_name>, base=3D0x509cc6 "", refs=3D=
0x7a2800 <ref_cache>)
>>     at refs.c:1724
>> #9  for_each_rawref (fn=3Dfn@entry=3D0x424120 <get_name>, cb_data=3D=
cb_data@entry=3D0x0)
>>     at refs.c:1873
>> #10 0x0000000000424f5b in cmd_describe (argc=3D0, argv=3D0x7fffc0b4d=
dc0, prefix=3D0x0)
>>     at builtin/describe.c:466
>> #11 0x000000000040596d in run_builtin (argv=3D0x7fffc0b4ddc0, argc=3D=
1,=20
>>     p=3D0x760b40 <commands.21352+576>) at git.c:291
>> #12 handle_internal_command (argc=3D1, argv=3D0x7fffc0b4ddc0) at git=
=2Ec:453
>> #13 0x0000000000404d6e in run_argv (argv=3D0x7fffc0b4dc78, argcp=3D0=
x7fffc0b4dc5c)
>>     at git.c:499
>> #14 main (argc=3D1, av=3D<optimized out>) at git.c:575
>> (gdb)=20
>=20
> According to `git bisect`, the first bad commit is:
>=20
> commit 9a489f3c17d6c974b18c47cf406404ca2a721c87
> Author: Michael Haggerty <mhagger@alum.mit.edu>
> Date:   Mon Apr 22 21:52:22 2013 +0200
>=20
>     refs: extract a function peel_entry()
>=20
> The crash happens only in repositories that have at least one replace=
d
> object in the branch's history. Running `git --no-replace-objects
> describe` avoids the crash.
>=20
> The crash happens only if there are any tags under .git/refs/tags/ th=
at
> do not exist in .git/packed-refs, or if I remove all "peeled" lines f=
rom
> .git/packed-refs (including the '#' line; /^[#^]/d).
>=20
> A quick way to reproduce this with git.git master is:
>=20
> git tag -f test-tag HEAD~10
> git replace -f HEAD $(git --no-replace-objects cat-file commit HEAD \
>   | sed 's/@/@test/' | git hash-object --stdin -t commit -w)
> ./git describe

Thanks for the bug report.

I think the cause of this bug is that peel_entry() is causing a nested
call to do_for_each_entry() to look up the replace reference, which
resets current_ref to NULL between the test and the dereference of
current_ref in peel_ref().

Unfortunately, I cannot reproduce the failure by following your recipe
(though I didn't have a lot of time yet for this).  I suppose that my
repo starts out in a slightly different state than yours and therefore =
I
don't get the same results.  If you could find a recipe to reproduce th=
e
problem, starting either with an empty repo, or perhaps a fresh clone o=
f
git.git, and double-check that you don't have any unusual config option=
s
that might be affecting things, that would be very helpful.

I might have more time to look at this tonight.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
