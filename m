From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: [PATCH] git-svn: use SVN::Ra::get_dir2 when possible
Date: Sun, 2 Nov 2014 12:31:56 +0000
Message-ID: <1414931516.94573.YahooMailBasic@web172301.mail.ir2.yahoo.com>
References: <20141031101530.GA29248@dcvr.yhbt.net>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 13:32:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkuKB-00048a-N3
	for gcvg-git-2@plane.gmane.org; Sun, 02 Nov 2014 13:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbaKBMb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2014 07:31:59 -0500
Received: from nm23-vm4.bullet.mail.ir2.yahoo.com ([212.82.97.19]:40946 "EHLO
	nm23-vm4.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103AbaKBMb6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Nov 2014 07:31:58 -0500
Received: from [212.82.98.53] by nm23.bullet.mail.ir2.yahoo.com with NNFMP; 02 Nov 2014 12:31:57 -0000
Received: from [212.82.98.80] by tm6.bullet.mail.ir2.yahoo.com with NNFMP; 02 Nov 2014 12:31:57 -0000
Received: from [127.0.0.1] by omp1017.mail.ir2.yahoo.com with NNFMP; 02 Nov 2014 12:31:57 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 219108.10935.bm@omp1017.mail.ir2.yahoo.com
Received: (qmail 94948 invoked by uid 60001); 2 Nov 2014 12:31:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414931517; bh=XvBMKbMnpriIh37FI0NtYF5A01fYjsi9/yPVXx3f2X0=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=eobldTzSFmkIZTQLnWJpS7JbfApg5KH3F1qkMEUqRjXXzG10w01hQrgkX71cRJhT2jq6yw3YpDvPH++fLTzErPpNwK1tLuBziA39w0isS0SZ7jXl/5tq36olJAsxpf1hX/Mo895J4i5IPtO45CWGxOqNNNIzsUbSBorgimWghAE=
X-YMail-OSG: TqMHW.0VM1lRFvOI2yT.A50IyShilSEqPRC4AE1JvzlBxEl
 QwsSQ_NOBlB.Wguq890m3CiRFxzMCEhgn2Dq5jX3.CkSFIvmmIZ9nIkfGb95
 9aWSXFst.j7Pzrm.3VsIOuAY7BfxUbd1v.3AmrbUI5mA7phhQw5FT4h2PBWm
 ohMev77HNln4zV4.NPKBz5ATySZoeuJlWJGXI0m.p40rji067fBqC7VSR76d
 anXrpDGv7mEWNy03jwFySAI0x17hPP61ein2ODEgMdwa6YmScBjyfuZgXlEs
 _bRwqmMvyD8wf5BhWyoVkqvXlI_zl5uHLR_HKrtAWJ1b30PvWPVu7FH5rPfa
 31WW7xvI5SNyfkWetfQXst_mF6lV1j8aLyoUGn8EOWJUZuUz4MSVH2Xapvvv
 msy1pg0kjmWqEaNN5xx_g8YUG9KsrQ6V2xT.wPUKcSKLPEWxer17XAmgBINX
 NyrMJAw4kyYmSBNJjwQjrepcvs5LDkPHQ6MLk2JfvqZ_BtoGsm3Y8p2s3VDb
 Kq_MUniW6zSoeJLQPBcAKTXk_yHnvY6TzBR6ScS7PnfL6Cm6Shv_vm.i029C
 QIjCEHAsCV_cINsfRFrnphjsp67YxUtzsXKffx3QJLIcLaOtJ.RKs1ICbq0z
 5UsHs6tjlniJCMqKngPqB12FupcDDqpsKjKM4BR297xsm5auqUNIvzwp4i0w
 7SLPh0zFXV10-
Received: from [86.30.137.134] by web172301.mail.ir2.yahoo.com via HTTP; Sun, 02 Nov 2014 12:31:56 GMT
X-Rocket-MIMEInfo: 002.001,SG1tLCBJIHNlZSB5b3UgYXJlIGZpbGluZyB0aGUgcHJvYmxlbSBhZ2FpbnN0IHN1YnZlcnNpb24uIEZXSVcsDQpJIGFtIGN1cnJlbnRseSB1c2luZyBzdWJ2ZXJzaW9uLXBlcmwtMS44LjEwLTEuZmMyMC54ODZfNjQgcGFja2FnZSBvbiBmZWRvcmEgMjAuDQpJJ2xsIHBvc3NpYmx5IHRoaW5rIGFib3V0IGZpbGluZyBvbmUgdW5kZXIgcmVkaGF0J3MgYnVnemlsbGEgYW5kDQpsZXQgdGhlbSB0YWtlIGl0IHVwd2FyZCB0b28uDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <20141031101530.GA29248@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hmm, I see you are filing the problem against subversion. FWIW,
I am currently using subversion-perl-1.8.10-1.fc20.x86_64 package on fe=
dora 20.
I'll possibly think about filing one under redhat's bugzilla and
let them take it upward too.

--------------------------------------------
On Fri, 31/10/14, Eric Wong <normalperson@yhbt.net> wrote:

 This avoids the following failure
 with normal "get_dir" on newer
 versions of SVN (tested with SVN 1.8.8-1ubuntu3.1):
=20
 =A0 Incorrect parameters given: Could not convert '%ld'
 into a number
=20
 get_dir2 also has the potential to be more efficient by
 requesting
 less data.
=20
 ref: <1414636504.45506.YahooMailBasic@web172304.mail.ir2.yahoo.com>
 ref: <1414722617.89476.YahooMailBasic@web172305.mail.ir2.yahoo.com>
=20
 Signed-off-by: Eric Wong <normalperson@yhbt.net>
 Cc: Hin-Tak Leung <htl10@users.sourceforge.net>
 ---
 =A0 This should fix the vbox clone problem.=A0 SVN
 Perl binding
 =A0 breakage (again :<).=A0 I shall revert the
 int() changes.
=20
 =A0 > I added those two lines to my git and there is
 no improvement. It
 =A0 > still won't svn fetch the next revision. I think
 it may be
 =A0 > important/interesting to find out when or how it
 becomes non-int, so
 =A0 > I have tar'gz'ed my wont-fetch virtual box .git
 and in the middle of
 =A0 > uploading here:=20
 =A0 >
 =A0 > http://sourceforge.net/projects/outmodedbonsai/files/R/
=20
 =A0 > I am also uploading my old R clone also - maybe
 you'd like to see
 =A0 > why its .git/svn/.caches is so big compared to a
 recent one,
=20
 =A0 Jakob's changes causes different access patterns, so
 it's expected the
 =A0 sizes vary.=A0 I also changed the cherry pick
 cache and removed the
 =A0 _rev_list caching entirely, so it should be much
 smaller now.
=20
 =A0 > as well as how and why there were an extra merge
 and two missing
 =A0 > merges compared to a recent clone?
=20
 =A0 The different merges are fine, I think, as stated in
 =A0 =A0 http://mid.gmane.org/20141030230831.GA14160@dcvr.yhbt.net
=20
  perl/Git/SVN/Ra.pm | 12 +++++++++++-
  1 file changed, 11 insertions(+), 1 deletion(-)
=20
 diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
 index 82d6108..1e52709 100644
 --- a/perl/Git/SVN/Ra.pm
 +++ b/perl/Git/SVN/Ra.pm
 @@ -177,7 +177,17 @@ sub get_dir {
  =A0=A0=A0 =A0=A0=A0 }
  =A0=A0=A0 }
  =A0=A0=A0 my $pool =3D SVN::Pool->new;
 -=A0=A0=A0 my ($d, undef, $props) =3D
 $self->SUPER::get_dir($dir, $r, $pool);
 +=A0=A0=A0 my ($d, undef, $props);
 +
 +=A0=A0=A0 if (defined &SVN::Ra::get_dir2) { #
 appeared in SVN 1.4
 +=A0=A0=A0 =A0=A0=A0 # n.b. in addition to
 being potentially more efficient,
 +=A0=A0=A0 =A0=A0=A0 # this works around
 what appears to be a bug in some
 +=A0=A0=A0 =A0=A0=A0 # SVN 1.8 versions
 +=A0=A0=A0 =A0=A0=A0 my $kind =3D 1; #
 SVN_DIRENT_KIND
 +=A0=A0=A0 =A0=A0=A0 ($d, undef, $props) =3D
 $self->get_dir2($dir, $r, $kind, $pool);
 +=A0=A0=A0 } else {
 +=A0=A0=A0 =A0=A0=A0 ($d, undef, $props) =3D
 $self->get_dir($dir, $r, $pool);
 +=A0=A0=A0 }
  =A0=A0=A0 my %dirents =3D map { $_ =3D> { kind
 =3D> $d->{$_}->kind } } keys %$d;
  =A0=A0=A0 $pool->clear;
  =A0=A0=A0 if ($r !=3D $cache->{r}) {
 --=20
 EW
=20
