From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 20:13:52 +0000
Message-ID: <54C15A00.9000706@ramsay1.demon.co.uk>
References: <1421893929-7447-1-git-send-email-sbeller@google.com>	<1421893929-7447-6-git-send-email-sbeller@google.com>	<54C0F41F.2080705@ramsay1.demon.co.uk> <CAGZ79kZnECcGOWKr4JLpF5zh68+L8XX7yYntyZDJTbZ5cLD50w@mail.gmail.com> <54C154C0.9020708@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:14:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEO8l-0003TI-Gw
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbbAVUOB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jan 2015 15:14:01 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:49411 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751930AbbAVUN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 15:13:57 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 049586F9E00;
	Thu, 22 Jan 2015 20:13:51 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id B54046F9D6F;
	Thu, 22 Jan 2015 20:13:50 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 22 Jan 2015 20:13:50 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54C154C0.9020708@ramsay1.demon.co.uk>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262865>

On 22/01/15 19:51, Ramsay Jones wrote:
> On 22/01/15 19:16, Stefan Beller wrote:
>> How do you run sparse on git?
>=20
>   $ make sparse >sp-out 2>&1
>=20

BTW, you can get gcc to warn about this also:

 $ rm refs.o
 $ make CFLAGS=3D'-Wall -Wextra' refs.o
    * new build flags
    CC refs.o
In file included from cache.h:4:0,
                 from refs.c:1:
git-compat-util.h: In function =E2=80=98git_has_dos_drive_prefix=E2=80=99=
:
git-compat-util.h:277:56: warning: unused parameter =E2=80=98path=E2=80=
=99 [-Wunused-parameter]
 static inline int git_has_dos_drive_prefix(const char *path)
                                                        ^
In file included from cache.h:4:0,
                 from refs.c:1:
git-compat-util.h: In function =E2=80=98xsize_t=E2=80=99:
git-compat-util.h:689:10: warning: comparison between signed and unsign=
ed integer expressions [-Wsign-compare]
  if (len > (size_t) len)
          ^
refs.c: In function =E2=80=98check_refname_component=E2=80=99:
refs.c:54:61: warning: unused parameter =E2=80=98flags=E2=80=99 [-Wunus=
ed-parameter]
 static int check_refname_component(const char *refname, int flags)
                                                             ^
refs.c: In function =E2=80=98warn_if_dangling_symref=E2=80=99:
refs.c:1814:78: warning: unused parameter =E2=80=98sha1=E2=80=99 [-Wunu=
sed-parameter]
 static int warn_if_dangling_symref(const char *refname, const unsigned=
 char *sha1,
                                                                       =
       ^
refs.c: In function =E2=80=98log_ref_write_fd=E2=80=99:
refs.c:3042:14: warning: comparison between signed and unsigned integer=
 expressions [-Wsign-compare]
  if (written !=3D len)
              ^
refs.c: In function =E2=80=98write_sha1_to_lock_file=E2=80=99:
refs.c:3105:42: warning: ordered comparison of pointer with integer zer=
o [-Wextra]
       || fdopen_lock_file(lock->lk, "w") < 0
                                          ^
refs.c:3110:39: warning: ordered comparison of pointer with integer zer=
o [-Wextra]
   if (fdopen_lock_file(lock->lk, "w") < 0
                                       ^
refs.c: In function =E2=80=98create_symref=E2=80=99:
refs.c:3220:18: warning: comparison between signed and unsigned integer=
 expressions [-Wsign-compare]
  if (sizeof(ref) <=3D len) {
                  ^
refs.c: In function =E2=80=98read_ref_at_ent=E2=80=99:
refs.c:3277:15: warning: unused parameter =E2=80=98email=E2=80=99 [-Wun=
used-parameter]
   const char *email, unsigned long timestamp, int tz,
               ^
refs.c: In function =E2=80=98read_ref_at_ent_oldest=E2=80=99:
refs.c:3324:19: warning: unused parameter =E2=80=98email=E2=80=99 [-Wun=
used-parameter]
       const char *email, unsigned long timestamp,
                   ^
refs.c: In function =E2=80=98for_each_reflog_ent_reverse=E2=80=99:
refs.c:3451:22: warning: comparison between signed and unsigned integer=
 expressions [-Wsign-compare]
   cnt =3D (sizeof(buf) < pos) ? sizeof(buf) : pos;
                      ^
refs.c:3451:43: warning: signed and unsigned type in conditional expres=
sion [-Wsign-compare]
   cnt =3D (sizeof(buf) < pos) ? sizeof(buf) : pos;
                                           ^
refs.c: In function =E2=80=98ref_transaction_free=E2=80=99:
refs.c:3659:16: warning: comparison between signed and unsigned integer=
 expressions [-Wsign-compare]
  for (i =3D 0; i < transaction->nr; i++) {
                ^
 $=20

Notice the [-Wextra] warnings above. ;-)

ATB,
Ramsay Jones
