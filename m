From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Sun, 19 Oct 2014 15:22:29 +0100
Message-ID: <1413728549.57276.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, stoklund@2pi.dk, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sun Oct 19 16:22:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfrNV-0000ev-GO
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 16:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbaJSOWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2014 10:22:33 -0400
Received: from nm37.bullet.mail.ir2.yahoo.com ([212.82.96.62]:36798 "EHLO
	nm37.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751916AbaJSOWc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 10:22:32 -0400
Received: from [212.82.98.52] by nm37.bullet.mail.ir2.yahoo.com with NNFMP; 19 Oct 2014 14:22:30 -0000
Received: from [212.82.98.85] by tm5.bullet.mail.ir2.yahoo.com with NNFMP; 19 Oct 2014 14:22:30 -0000
Received: from [127.0.0.1] by omp1022.mail.ir2.yahoo.com with NNFMP; 19 Oct 2014 14:22:30 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 164580.46930.bm@omp1022.mail.ir2.yahoo.com
Received: (qmail 65499 invoked by uid 60001); 19 Oct 2014 14:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1413728550; bh=0FDoRkl7TKYk1wLztIx+/DTt3j7CJPjqm9uHKgqUD5g=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=aCqdgIIELT9g/cg/DZ1yan7Un7oM1OE+oTtkn34ZRkcpY5JMcCAaxmQJ3gmmDumukWR2FtK1y+EYRj+MohYLv3Ibc8SIy7o6Ohq8H/ikPffORFPXuLIeHF2wQjbzaKL+a8gW/d8tSH15AhT9/bx2rCJeSsCWjOvsusSZ4H0bweE=
X-YMail-OSG: ZAboVMoVM1nBX9_bLFZ5Tvb6l8SEweguaGi75Je2Kpe1tk7
 UOThWcPyD874mSiBEWbDddCDLKJRr2HKacC3bS1jpAxVmNFb_dbovdVI6GQL
 S7bgFKk8MqadX8nKISSYAIC0fZdkk8BQA5hSRA7pK.RDimgzuk3AZJT4uEoV
 iRm6atEtQHFqsk28hwQD7BsgiC.AjIg.mnJ90zno5_8QoHaRimakeJdZql_f
 9_.Bs7zr8doAVzCj7hkkW6UYEUWN07czL8BGRMnPyJRxufChNEcwHJOgyPAx
 oQjQ6YWPmxBZLt2jxLWNMUMQZ1DIQka0KkknTrUjOyMx14feCyMyYglwvqKm
 bsBDZRmUs4EKniBkU9OhEVT8X9HhlaFsU8T5dx24rjF8eOklbvobskc26395
 fw40O9KzEB2jcCSwuXuTgwUhLEHUiGTspOA5Xbdty0bw0rnpWEIKFGPbIeb9
 oA7D88.8dfEBSilvijkML.z01HhyFUCypu5ZtH45PsqZBQers2Yqb.q2fLVt
 W4W48Noyv7JVvEbRIpnGeGyEnSZPjo8AXdi8GrZuI_FXhLsNmeUF0Tuwf418
 uhSzCnIqac..lr1IH_DRZXgoiN1YaBg0MAyGbMUKcbZs-
Received: from [86.30.137.134] by web172306.mail.ir2.yahoo.com via HTTP; Sun, 19 Oct 2014 15:22:29 BST
X-Rocket-MIMEInfo: 002.001,KHNvcnJ5IGFib3V0IHRoZSBsYXN0IGJsYW5rIHJlcGx5IC0gbW9iaWxlIHBob25lIGFuZCBmaW5nZXIgYWNjaWRlbnQuLi4pDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KT24gU3VuLCBPY3QgMTksIDIwMTQgMDU6MTIgQlNUIEVyaWMgV29uZyB3cm90ZToNCg0KPkhpbi1UYWsgTGV1bmcgPGh0bDEwQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4gd3JvdGU6DQo.IFRoZSBuZXcgY2xvbmUgaGFzOg0KPiANCj4gPC0tDQo.ICQgbHMgLWx0ciAuZ2l0L3N2bi8uY2FjaGVzLw0KPiB0b3RhbCAxNDQ3ODgBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.696
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(sorry about the last blank reply - mobile phone and finger accident...=
)

------------------------------
On Sun, Oct 19, 2014 05:12 BST Eric Wong wrote:

>Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> The new clone has:
>=20
> <--
> $ ls -ltr .git/svn/.caches/
> total 144788
> -rw-rw-r--. 1 Hin-Tak Hin-Tak=A0 1166138 Oct=A0 7 13:44 lookup_svn_me=
rge.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 72849741 Oct=A0 7 13:48 check_cherry_pi=
ck.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak=A0 1133855 Oct=A0 7 13:49 has_no_change=
s.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 73109005 Oct=A0 7 13:53 _rev_list.yaml
> -->
>=20
> The old clone has:
>
><snip>
> -rw-rw-r--. 1 Hin-Tak Hin-Tak=A0 40241189 Oct=A0 5 16:42 lookup_svn_m=
erge.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak 225323456 Oct=A0 5 16:49 check_cherry_p=
ick.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak=A0 =A0 242547 Oct=A0 5 16:49 has_no_cha=
nges.yaml
> -rw-rw-r--. 1 Hin-Tak Hin-Tak=A0 24120007 Oct=A0 5 16:50 _rev_list.ya=
ml
> -->
>=20
> I had to suspend somewhat around r59000 - but it is interesting to se=
e
> that the max memory consumption of the later part is almost double?
> and it also runs at 100% rather than 60% overall; I don't know what
> to make of that - probably just smaller changes versus
> larger ones, or different time of day and network loads (yes,
> I guess it is just bandwidth-limited?, since the bulk of CPU time is =
in system
> rather than user).
>
>git-svn memory usage is insane, and we need to reduce it.
>(on Linux, fork() performance is reduced as memory size of the parent
> grows, and I don't think we can easily call vfork() from Perl)
>

Yes, I think the memory consumption is a bit crazy. I ran svn fetch on
the old again and it was a bit slow, so I timed the new, and here it is=
=2E
=46or just fetching 45 changes, it took 36 minutes and the memory=20
consumption shoots up to over 1GB. (there was one or two mergeinfo
in the middle, not shown).

<---
cd ../R-2/
[Hin-Tak@localhost R-2]$ /usr/bin/time -v git svn fetch --all
	M	src/library/base/R/apply.R
	M	src/library/base/man/apply.Rd
	M	doc/NEWS.Rd
r66721 =3D e26e52bf4b2cdbe291d5899fd0a449f197aa2133 (refs/remotes/trunk=
)
=2E..
	M	src/library/tools/R/utils.R
r66765 =3D c64d1828ada98395892529ce59b5760de1bdc60b (refs/remotes/R-3-1=
-branch)
---
	Command being timed: "git svn fetch --all"
	User time (seconds): 2042.81
	System time (seconds): 115.98
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 36:13.74
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 1019092
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 1149
	Minor (reclaiming a frame) page faults: 1482219
	Voluntary context switches: 9470
	Involuntary context switches: 226683
	Swaps: 0
	File system inputs: 358864
	File system outputs: 510680
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
[Hin-Tak@localhost R-2]$ cd ../R
--->


> I am somwhat worry about the dramatic difference between the two .svn=
/.caches -
> check_cherry_pick.yaml is 225MB in one and 73MB in the other, and als=
o
> _rev_list.yaml is opposite - 24MB vs 73MB. How do I reconcile that?
>
>Calling patterns changed, and it looks like Jakob's changes avoided so=
me
>calls.=A0 The main thing to care about:
>=A0=A0=A0 Does the repository history look right?
>

I'll check soon and report. I looks superficiently okay. I suppose
I'd need to check every branch to be sure. I know the fetch history is
different - but reflog (or the equivalent of it in svn) expires and are=
 pruned
after two weeks?

>The check_cherry_pick cache can be made smaller, too:
>----------------------- 8< -----------------------------
>From: Eric Wong <normalperson@yhbt.net>
>Subject: [PATCH] git-svn: reduce check_cherry_pick cache overhead
>
>We do not need to store entire lists of commits, only the
>number of incomplete and the first commit for reference.
>This reduces the amount of data we need to store in memory
>and on disk stores.
>

Is there a way of retrospectively compress/trimming the cache, or bette=
r
still, examine it before compressing?

I intend to hold on to both the new and the old clone for a while until
I can reconcil the differences... though I am running the same git svn =
code
on both now.

>Signed-off-by: Eric Wong <normalperson@yhbt.net>
>---
> perl/Git/SVN.pm | 28 +++++++++++++++-------------
> 1 file changed, 15 insertions(+), 13 deletions(-)
>
>diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
>index 25dbcd5..b2d37cb 100644
>--- a/perl/Git/SVN.pm
>+++ b/perl/Git/SVN.pm
>@@ -1537,7 +1537,7 @@ sub _rev_list {
> =A0=A0=A0 @rv;
> }
>=20
>-sub check_cherry_pick {
>+sub check_cherry_pick2 {
> =A0=A0=A0 my $base =3D shift;
> =A0=A0=A0 my $tip =3D shift;
> =A0=A0=A0 my $parents =3D shift;
>@@ -1552,7 +1552,8 @@ sub check_cherry_pick {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 delete $commits{$commit};
> =A0=A0=A0 =A0=A0=A0 }
> =A0=A0=A0 }
>-=A0=A0=A0 return (keys %commits);
>+=A0=A0=A0 my @k =3D (keys %commits);
>+=A0=A0=A0 return (scalar @k, $k[0]);
> }
>=20
> sub has_no_changes {
>@@ -1597,7 +1598,7 @@ sub tie_for_persistent_memoization {
> =A0=A0=A0 =A0=A0=A0 mkpath([$cache_path]) unless -d $cache_path;
>=20
> =A0=A0=A0 =A0=A0=A0 my %lookup_svn_merge_cache;
>-=A0=A0=A0 =A0=A0=A0 my %check_cherry_pick_cache;
>+=A0=A0=A0 =A0=A0=A0 my %check_cherry_pick2_cache;
> =A0=A0=A0 =A0=A0=A0 my %has_no_changes_cache;
> =A0=A0=A0 =A0=A0=A0 my %_rev_list_cache;
>=20
>@@ -1608,11 +1609,11 @@ sub tie_for_persistent_memoization {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 LIST_CACHE =3D> ['HASH' =3D> \%lookup_s=
vn_merge_cache],
> =A0=A0=A0 =A0=A0=A0 ;
>=20
>-=A0=A0=A0 =A0=A0=A0 tie_for_persistent_memoization(\%check_cherry_pic=
k_cache,
>-=A0=A0=A0 =A0=A0=A0 =A0 =A0 "$cache_path/check_cherry_pick");
>-=A0=A0=A0 =A0=A0=A0 memoize 'check_cherry_pick',
>+=A0=A0=A0 =A0=A0=A0 tie_for_persistent_memoization(\%check_cherry_pic=
k2_cache,
>+=A0=A0=A0 =A0=A0=A0 =A0 =A0 "$cache_path/check_cherry_pick2");
>+=A0=A0=A0 =A0=A0=A0 memoize 'check_cherry_pick2',
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 SCALAR_CACHE =3D> 'FAULT',
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 LIST_CACHE =3D> ['HASH' =3D> \%check_ch=
erry_pick_cache],
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 LIST_CACHE =3D> ['HASH' =3D> \%check_ch=
erry_pick2_cache],
> =A0=A0=A0 =A0=A0=A0 ;
>=20
> =A0=A0=A0 =A0=A0=A0 tie_for_persistent_memoization(\%has_no_changes_c=
ache,
>@@ -1636,7 +1637,7 @@ sub tie_for_persistent_memoization {
> =A0=A0=A0 =A0=A0=A0 $memoized =3D 0;
>=20
> =A0=A0=A0 =A0=A0=A0 Memoize::unmemoize 'lookup_svn_merge';
>-=A0=A0=A0 =A0=A0=A0 Memoize::unmemoize 'check_cherry_pick';
>+=A0=A0=A0 =A0=A0=A0 Memoize::unmemoize 'check_cherry_pick2';
> =A0=A0=A0 =A0=A0=A0 Memoize::unmemoize 'has_no_changes';
> =A0=A0=A0 =A0=A0=A0 Memoize::unmemoize '_rev_list';
> =A0=A0=A0 }
>@@ -1648,7 +1649,8 @@ sub tie_for_persistent_memoization {
> =A0=A0=A0 =A0=A0=A0 return unless -d $cache_path;
>=20
> =A0=A0=A0 =A0=A0=A0 for my $cache_file (("$cache_path/lookup_svn_merg=
e",
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0=A0=A0"$cache_path/che=
ck_cherry_pick",
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0=A0=A0"$cache_path/che=
ck_cherry_pick", # old
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0=A0=A0"$cache_path/che=
ck_cherry_pick2",
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0=A0=A0"$cache_path/has=
_no_changes")) {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 for my $suffix (qw(yaml db)) {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 my $file =3D "$cache_file.$su=
ffix";
>@@ -1817,15 +1819,15 @@ sub find_extra_svn_parents {
> =A0=A0=A0 =A0=A0=A0 }
>=20
> =A0=A0=A0 =A0=A0=A0 # double check that there are no missing non-merg=
e commits
>-=A0=A0=A0 =A0=A0=A0 my (@incomplete) =3D check_cherry_pick(
>+=A0=A0=A0 =A0=A0=A0 my ($ninc, $ifirst) =3D check_cherry_pick2(
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 $merge_base, $merge_tip,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 $parents,
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 @all_ranges,
> =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0=A0=A0);
>=20
>-=A0=A0=A0 =A0=A0=A0 if ( @incomplete ) {
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 warn "W:svn cherry-pick ignored ($spec)=
 - missing "
>-=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 .@incomplete." commit(s) (eg =
$incomplete[0])\n";
>+=A0=A0=A0 =A0=A0=A0 if ($ninc) {
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 warn "W:svn cherry-pick ignored ($spec)=
 - missing " .
>+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "$ninc commit(s) (eg $ifirst)=
\n";
> =A0=A0=A0 =A0=A0=A0 } else {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 warn
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "Found merge parent ($spec): =
",
>--=20
>EW
