From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Tue, 15 Mar 2016 07:09:30 +0000
Message-ID: <20160315070930.GA24036@dcvr.yhbt.net>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net>
 <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net>
 <56E79C54.8000606@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:09:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afj6l-0004FL-Un
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 08:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933033AbcCOHJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 03:09:32 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36899 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755193AbcCOHJb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 03:09:31 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61DF11F725;
	Tue, 15 Mar 2016 07:09:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56E79C54.8000606@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288837>

Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
> On 03/15/2016 02:59 AM, Eric Wong wrote:
> >[]
> >I just edited locally and pushed those out to Junio:
> >
> >http://mid.gmane.org/20160315015726.GA25295@dcvr.yhbt.net
> >
>=20
> The new TC 11/12 don't pass under cygwin.
>=20
> Do we need cp932 ?

Not sure, both CP932 and ISO8859-1 work fine for me on
GNU/Linux.   Anyways I'm fine skipping this patch for 2.8
while we hash it out, too.

Kazutoshi: can you answer?  Thanks.

> If not, we may use the paych from here:
> https://github.com/tboegi/git/commit/379c01bf52464f8a50065b11af516127=
e9144045
>=20
> Date:   Tue Mar 15 05:03:18 2016 +0100
>=20
>     t9115: Use funcky file names that work under unicode FS
>=20
>     Don't use funky file names, that can not be created under
>     HFS or NTFS.
>=20
> diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh
> b/t/t9115-git-svn-dcommit-funky-renames.sh
> index 0990f8d..d022f0d 100755
> --- a/t/t9115-git-svn-dcommit-funky-renames.sh
> +++ b/t/t9115-git-svn-dcommit-funky-renames.sh
> @@ -93,11 +93,11 @@ test_expect_success 'git svn rebase works inside
> a fresh-cloned repository' '
>  # > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
>  # > "Private use area") when creating or accessing files.
>  prepare_a_utf8_locale
> -test_expect_success UTF8 'svn.pathnameencoding=3Dcp932 new file on d=
commit' '
> +test_expect_success UTF8 'svn.pathnameencoding=3DISO8859-1 new file =
on dcommit' '
>         LC_ALL=3D$a_utf8_locale &&
>         export LC_ALL &&
> -       neq=3D$(printf "\201\202") &&
> -       git config svn.pathnameencoding cp932 &&
> +       neq=3D$(printf "\303\244") &&
> +       git config svn.pathnameencoding ISO8859-1 &&
>         echo neq >"$neq" &&
>         git add "$neq" &&
>         git commit -m "neq" &&
> @@ -105,11 +105,11 @@ test_expect_success UTF8
> 'svn.pathnameencoding=3Dcp932 new file on dcommit' '
>  '
>=20
>  # See the comment on the above test for setting of LC_ALL.
> -test_expect_success 'svn.pathnameencoding=3Dcp932 rename on dcommit'=
 '
> +test_expect_success 'svn.pathnameencoding=3DISO8859-1 rename on dcom=
mit' '
>         LC_ALL=3D$a_utf8_locale &&
>         export LC_ALL &&
> -       inf=3D$(printf "\201\207") &&
> -       git config svn.pathnameencoding cp932 &&
> +       inf=3D$(printf "\303\226") &&
> +       git config svn.pathnameencoding ISO8859-1 &&
>         echo inf >"$inf" &&
>         git add "$inf" &&
>         git commit -m "inf" &&
>=20
