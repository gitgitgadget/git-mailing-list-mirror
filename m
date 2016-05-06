From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 22:17:09 +0100
Message-ID: <572D09D5.4060600@ramsayjones.plus.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
 <17E04501C9474282B87758C7998A1F5B@PhilipOakley>
 <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
 <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
 <572CDCFF.9050607@ramsayjones.plus.com>
 <xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
 <572CFCBC.3020103@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 23:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayn7g-0006oB-B3
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 23:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbcEFVRO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 17:17:14 -0400
Received: from avasout08.plus.net ([212.159.14.20]:56696 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbcEFVRN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 17:17:13 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id r9H91s0022D2Veb019HA3i; Fri, 06 May 2016 22:17:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=musMPx6A3WLis0h5T4cA:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <572CFCBC.3020103@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293862>



On 06/05/16 21:21, Ramsay Jones wrote:
> On 06/05/16 19:54, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
[snip]

> I still can't get gcc to complain, e.g. (on top of above):
>=20
>   $ git diff
>   diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>   index deae1f3..845fcdc 100644
>   --- a/builtin/rev-list.c
>   +++ b/builtin/rev-list.c
>   @@ -377,7 +377,7 @@ int cmd_rev_list(int argc, const char **argv, c=
onst char *prefix)
>                   mark_edges_uninteresting(&revs, show_edge);
>   =20
>           if (bisect_list) {
>   -               int reaches =3D 0, all =3D 0;
>   +               int reaches, all;
>   =20
>                   revs.commits =3D find_bisection(revs.commits, &reac=
hes, &all,
>                                                 bisect_find_all);
>   $ rm builtin/rev-list.o
>   $ make V=3D1 CFLAGS=3D'-g -O3 -Wall -Wextra -Wuninitialized -Wno-un=
used-parameter' builtin/rev-list.o
>   cc -o builtin/rev-list.o -c -MF builtin/.depend/rev-list.o.d -MQ bu=
iltin/rev-list.o -MMD -MP  -g -O3 -Wall -Wextra -Wuninitialized -Wno-un=
used-parameter -I. -DHAVE_ALLOCA_H -DUSE_CURL_FOR_IMAP_SEND  -DHAVE_PAT=
HS_H -DHAVE_DEV_TTY -DXDL_FAST_HASH -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_M=
ONOTONIC -DHAVE_GETDELIM -DSHA1_HEADER=3D'<openssl/sha.h>'  -DNO_STRLCP=
Y -DNO_MKSTEMPS -DSHELL_PATH=3D'"/bin/sh"'  builtin/rev-list.c
>   In file included from ./cache.h:4:0,
>                    from builtin/rev-list.c:1:
>   ./git-compat-util.h: In function =91xsize_t=92:
>   ./git-compat-util.h:838:10: warning: comparison between signed and =
unsigned integer expressions [-Wsign-compare]
>     if (len > (size_t) len)
>             ^
>   $=20

BTW, another patch that I have hanging around ... this time the
patch below was built on master from a couple of years ago (so,
I haven't bothered to rebase it, but you should get the idea):

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] git-compat-util.h: xsize_t(): avoid signed comparison =
warnings

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 git-compat-util.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c07e0c1..3a9cf6c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -838,9 +838,10 @@ static inline char *xstrdup_or_null(const char *st=
r)
=20
 static inline size_t xsize_t(off_t len)
 {
-	if (len > (size_t) len)
+	size_t r =3D (size_t)len;
+	if (len !=3D (off_t)r)
 		die("Cannot handle files this big");
-	return (size_t)len;
+	return r;
 }
=20
 __attribute__((format (printf, 3, 4)))
--=20
2.8.0
