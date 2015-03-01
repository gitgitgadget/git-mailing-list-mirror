From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Sun, 01 Mar 2015 11:25:53 +0100
Message-ID: <54F2E931.7020200@web.de>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com> <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, johan@herland.net
To: =?UTF-8?B?TcOlcnRlbiBLb25nc3RhZA==?= <marten.kongstad@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 11:26:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS14X-0007UU-1m
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 11:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbbCAKZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2015 05:25:59 -0500
Received: from mout.web.de ([212.227.15.3]:61009 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbbCAKZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 05:25:58 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LkPW7-1XubCD2ZXH-00cOWd; Sun, 01 Mar 2015 11:25:54
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
X-Provags-ID: V03:K0:SgPBirB1JldTgt2p7M2HoIAW7Xb9sQEDEPlz+GHyUOnIRirL0d/
 opAjngMKtnxOhT0D0oXvv+q1Q6NAOyTs1NKYrK1deirb/0R7x3tmcMPg1mHbXFEBoPTSCjq
 Eoc1mmZCT5f0LuekRon894eYzQkgy1/J1tPBu6Fj6I6ouM3cfk/bswaMhl9yaXatgpyMrUc
 J6pN7Xn60V6pYkoMdwyLw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264555>

On 2015-03-01 08.39, M=C3=A5rten Kongstad wrote:
[]
 index ed7e093..128f7bf 100755
> --- a/t/t4047-diff-dirstat.sh
> +++ b/t/t4047-diff-dirstat.sh
> @@ -973,4 +973,15 @@ test_expect_success 'diff.dirstat=3Dfuture_param=
,0,lines should warn, but still wo
>  	test_i18ngrep -q "diff\\.dirstat" actual_error
>  '
> =20
> +test_expect_success '--shortstat --dirstat should output only one di=
rstat' '
> +	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_s=
hortstat_dirstat_changes &&
> +	test $(grep -c " dst/copy/changed/$" actual_diff_shortstat_dirstat_=
changes) =3D 1 &&
How portable is the "grep -c" usage ?
(I don't now it either, do we have other opinions ?), but the following=
 seems to be more "Git-style":

test_expect_success '--shortstat --dirstat should output only one dirst=
at' '
	git diff --shortstat --dirstat=3Dchanges HEAD^..HEAD >actual_diff_shor=
tstat_dirstat_changes &&
	grep " dst/copy/changed/$" actual_diff_shortstat_dirstat_changes >actu=
al &&
	test_line_count =3D 1 actual
