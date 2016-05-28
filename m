From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to
 the end?
Date: Sat, 28 May 2016 16:46:49 +0200
Message-ID: <5749AF59.2070704@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 16:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fb9-0002s7-34
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 16:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbcE1OwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2016 10:52:09 -0400
Received: from mout.web.de ([212.227.17.12]:53947 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbcE1OwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 10:52:08 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MHY1o-1b5YW72WJ2-003KU9; Sat, 28 May 2016 16:46:51
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5740AC28.6010202@web.de>
X-Provags-ID: V03:K0:sTrwQRVMtbtQrD4/9d2hoamOCusz40yrvxirdhaU3lLOQA1l1q4
 /yxy2ypYedewUjGtFSqGjik/7A67YPlY0a4o1C7qKFdPvFHMHbJtNLDGHIjcCA3aA1Psoqu
 OBtwTyZUlvSVyMwGt1YNJDQp9tDPMUFAatmmJVxTmJDNB+YJUuKvwz6ylUe4/IANzszOuHq
 41Dn237KfXLgoUqVpsYEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H20fIvuA9DY=:5p6YI4s/39CcycjFolUgPA
 gC8gFzhZnhTzx5+R/6di0hKCxkbJvsuIICs3bW1jFOUaSQJS+63y5GKzmL0AlKm3z2oKJ3F+9
 bwrenh6xXiVRDUnkEcgmy4ksFoxq/hKpqMs2rYbzXJ6lU+5uFYo5mIXvE4DKaDAYUy9456xZW
 LxpfcD2WussOGoQEqnUV7QJdye8n2x++3lJy5nwi0ziWNg3NkoVw2W90xoA2csx7oJZyDpSkT
 HnMDBTctRtE3T0L3Gd/E2OXFunaw0zO2IkzdE0B6Ad1mIVvYJAX6LlwAobTLsK5lQQlIdzlV3
 wMtaPSEDNT8KmeuaaKKGN3iK09DdjtZYMU3/0XFwAdpLhDa4mjj5Hel6HyGfzwChmtd5nC+OE
 EwPM3iuq1fhnbCZB69856PNvDnXMxPdGcA7WjKtPPV+WQdPK/lwNi1TetoYGL4NDBp7BPfZP4
 42wIcKeyfiBoy9F5RiqNCXnC7KcdLDN3rTUhpvBqt+qrZ9qfsaWJJh9XKNBAtmWKS6sNN/1dc
 T2CNiWG9PpAae+F60PaAni1tqHBIHiojcuaYbqdsAXLY1fgVNe15SEmcHMHPuuZzY5gvb/E9g
 SAPBLK6K0li0jdVJdlNZxFxRSQbQGz9feU7AAXaPp5QPDV1xNXDtQVvj3YLfz44rY3Zzm67/R
 JWUA3GXmWHriaUETkIEeHzjgSiAeD8u1pBhWmRztMtEBCR1Ll3L1xfpP0bYI9m5B9O2++jiZ4
 ru0NJITA8wLL9Yix7bcLOCriOnIcpV/ax6gsdn9xa0UFNjkzLYRaV4cUhvIH1FOvn9DnuQds 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295816>

Am 21.05.2016 um 20:42 schrieb Ren=E9 Scharfe:
> Am 11.05.2016 um 00:51 schrieb Junio C Hamano:
>> The helper function get_func_line() however gets confused when a
>> hunk adds a new function at the very end, and returns -1 to signal
>> that it did not find a suitable "function header line", i.e. the
>> beginning of previous function.  The caller then takes this signal
>> and shows from the very beginning of the file.  We end up showing
>> the entire file, starting from the very beginning to the end of the
>> newly added lines.
>=20
> In this case we need to look at the added lines in the post-image to
> see if the original context suffices.  We currently only look at the
> pre-image.  And if we have to extend the context simply search from t=
he
> bottom of the pre-image.  That's what the second patch does; the firs=
t
> one is just a small preparation.
>=20
> The last three patches introduce special handling of empty lines.
> Before them the code for -W only distinguished between function lines
> and non-function lines.  Not allowing empty lines between functions t=
o
> extend the context with -W is most useful in the case of appended ful=
l
> functions -- otherwise we'd get the preceding function shown as well =
as
> it "belongs" to the empty line separating them.
>=20
> And if we do that then it's easy and more consistent to stop showing
> empty lines trailing functions with -W (unless they're already includ=
ed
> in the one requested with -u/-U, of course).  Doing the same for grep
> then is only fair.
>=20
> Considering empty lines as uninteresting collides with languages like
> Whitespace.  I'm not sure -W was useful for it to begin with, though.
> Any other possible downsides?
>=20
> NB: Comments are still not handled specially.  That means they are
> considered to be part of the preceding function.  Fixing that is not =
in
> scope for this series.  (And I'm not sure it would be worth the hassl=
e.)
>=20
>    diff: factor out match_func_rec()
>    diff: handle appended chunks better with -W
>    diff: ignore empty lines before added functions with -W
>    diff: don't include common trailing empty lines with -W
>    grep: don't extend context to trailing empty lines with -W
>=20
>   grep.c        | 28 ++++++++++++++++++++++++--
>   xdiff/xemit.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++-------
>   2 files changed, 82 insertions(+), 9 deletions(-)

And here's the second round, this time with tests, a fix for a
signedness issue found by Ramsay, a small cleanup of the new function
is_empty_rec() and a new fix for the case of using git diff -W -U0.
An interdiff for the files touched by the original series is at the
bottom.


  t4051: rewrite, add more tests
  xdiff: factor out match_func_rec()
  xdiff: handle appended chunks better with -W
  xdiff: ignore empty lines before added functions with -W
  xdiff: -W: don't include common trailing empty lines in context
  xdiff: don't trim common tail with -W
  t7810: add test for grep -W and trailing empty context lines
  grep: -W: don't extend context to trailing empty lines

 grep.c                           |  28 ++++-
 t/t4051-diff-function-context.sh | 216 +++++++++++++++++++++++++------=
--------
 t/t4051/appended1.c              |  15 +++
 t/t4051/appended2.c              |  35 +++++++
 t/t4051/dummy.c                  |   7 ++
 t/t4051/hello.c                  |  21 ++++
 t/t4051/includes.c               |  20 ++++
 t/t7810-grep.sh                  |  19 +++-
 xdiff-interface.c                |  10 +-
 xdiff/xemit.c                    |  62 +++++++++--
 10 files changed, 341 insertions(+), 92 deletions(-)
 create mode 100644 t/t4051/appended1.c
 create mode 100644 t/t4051/appended2.c
 create mode 100644 t/t4051/dummy.c
 create mode 100644 t/t4051/hello.c
 create mode 100644 t/t4051/includes.c


diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d0c0738..bfa53d3 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -155,12 +155,12 @@ static long get_func_line(xdfenv_t *xe, xdemitcon=
f_t const *xecfg,
 	return -1;
 }
=20
-static int is_empty_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long=
 ri)
+static int is_empty_rec(xdfile_t *xdf, long ri)
 {
 	const char *rec;
 	long len =3D xdl_get_rec(xdf, ri, &rec);
=20
-	while (len > 0 && isspace(*rec)) {
+	while (len > 0 && XDL_ISSPACE(*rec)) {
 		rec++;
 		len--;
 	}
@@ -196,7 +196,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, x=
demitcb_t *ecb,
 				 * starting with empty lines.
 				 */
 				while (i2 < xe->xdf2.nrec &&
-				       is_empty_rec(&xe->xdf2, xecfg, i2))
+				       is_empty_rec(&xe->xdf2, i2))
 					i2++;
 				if (i2 < xe->xdf2.nrec &&
 				    match_func_rec(&xe->xdf2, xecfg, i2,
@@ -231,8 +231,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, x=
demitcb_t *ecb,
 			long fe1 =3D get_func_line(xe, xecfg, NULL,
 						 xche->i1 + xche->chg1,
 						 xe->xdf1.nrec);
-			while (fe1 > 0 &&
-			       is_empty_rec(&xe->xdf1, xecfg, fe1 - 1))
+			while (fe1 > 0 && is_empty_rec(&xe->xdf1, fe1 - 1))
 				fe1--;
 			if (fe1 < 0)
 				fe1 =3D xe->xdf1.nrec;
