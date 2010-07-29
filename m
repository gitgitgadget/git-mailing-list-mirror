From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] checkout: add a test for creating a new branch with 
	regexp as a starting point
Date: Thu, 29 Jul 2010 23:07:20 +0000
Message-ID: <AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
References: <20100729220111.GA28176@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Fri Jul 30 01:07:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OecCF-00073z-0G
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 01:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756946Ab0G2XHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 19:07:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60168 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab0G2XHV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 19:07:21 -0400
Received: by iwn7 with SMTP id 7so698132iwn.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M43VNsc6Q9IASnYIWNhqpR741XHGu8V0njhv00Z4WPM=;
        b=qVMoBSH3CLNRhe/DV182y3O6LYysAcrO9LaV6fZgY2kfxwdgDuGRlsTaMRSdkytw1X
         hP49YwMfUFSXJdtsJ59ZmfB2ZLx+0IomuIGgscC7BFB7Sy8cyLGCWR9KnfrGu/wi/ou5
         sLvCTt1/iItJEOJEIc8NknxdMfnCgHxQVVnVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ngTdWSN/Tt/dkKRn3B/iHsRstqAgIU0UIBVVAbZKmJBMpIw9gDwWhJ2rZLLxcYqPrR
         AEfQct+0sjFbMVSO3eO/RkZa2L6wpiFQ6rk6pL5Sxm/iBOtq25s8AwLEO/SgvTn7PGEv
         tJ1behmFL9fXMd6pUVIKQU+RfOJQWrRTTpOgE=
Received: by 10.231.31.202 with SMTP id z10mr579212ibc.191.1280444840620; Thu, 
	29 Jul 2010 16:07:20 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 29 Jul 2010 16:07:20 -0700 (PDT)
In-Reply-To: <20100729220111.GA28176@wo.int.altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152209>

On Thu, Jul 29, 2010 at 22:01, Dmitry V. Levin <ldv@altlinux.org> wrote=
:
> Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> This is just a regression test for the bug.

Thanks, always good to have more tests.

> =C2=A0t/t2018-checkout-new-branch-by-regexp.sh | =C2=A0 22 ++++++++++=
++++++++++++
> =C2=A01 files changed, 22 insertions(+), 0 deletions(-)
> =C2=A0create mode 100755 t/t2018-checkout-new-branch-by-regexp.sh
>
> diff --git a/t/t2018-checkout-new-branch-by-regexp.sh b/t/t2018-check=
out-new-branch-by-regexp.sh
> new file mode 100755
> index 0000000..78e54c5
> --- /dev/null
> +++ b/t/t2018-checkout-new-branch-by-regexp.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description=3D'checkout -b new_branch :/regexp'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> + =C2=A0 =C2=A0 =C2=A0 echo a > a &&
> + =C2=A0 =C2=A0 =C2=A0 git add a &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m first &&
> + =C2=A0 =C2=A0 =C2=A0 echo b > b &&
> + =C2=A0 =C2=A0 =C2=A0 git add b &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 git commit -m second
> +'

This should use test_commit (see t/README), but...

> +test_expect_success checkout '
> + =C2=A0 =C2=A0 =C2=A0 git checkout -b new_branch :/first
> +'
> +
> +test_done

=2E..it looks like this can just be added to the end of
t2018-checkout-branch.sh instead of creating a new test. Creating a
new file just for a single test for such a simple feature is a bit of
an overkill.
