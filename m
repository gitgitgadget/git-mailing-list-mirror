From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] merge-tree: fix typo in "both changed identically"
Date: Sat, 27 Apr 2013 14:38:12 +0100
Message-ID: <20130427133812.GE472@serenity.lan>
References: <51cbc79a9b250544a8365980d078601dfcd2b782.1367067799.git.john@keeping.me.uk>
 <517BD146.1040401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Apr 27 15:38:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW5Ki-000642-Sv
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 15:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab3D0NiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Apr 2013 09:38:20 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:40181 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab3D0NiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 09:38:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 34555606515;
	Sat, 27 Apr 2013 14:38:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HsonBkqW2cTF; Sat, 27 Apr 2013 14:38:18 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 99AB9606518;
	Sat, 27 Apr 2013 14:38:14 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <517BD146.1040401@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222647>

On Sat, Apr 27, 2013 at 03:23:18PM +0200, Ren=E9 Scharfe wrote:
> How about squashing in this test?
>=20
> Ren=E9
>=20
> ---
>  t/t4300-merge-tree.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index bd43b3d..2defb42 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -205,6 +205,19 @@ EXPECTED
>  	test_cmp expected actual
>  '
> =20
> +test_expect_success 'file remove A, B (same)' '
> +	cat >expected <<\EXPECTED &&
> +EXPECTED
> +
> +	git reset --hard initial &&
> +	test_commit "rm-a-b-base" "ONE" "AAA" &&
> +	git rm ONE &&
> +	git commit -m "rm-a-b" &&
> +	git tag "rm-a-b" &&
> +	git merge-tree rm-a-b-base rm-a-b rm-a-b >actual &&

I'm not sure about using the same "our" and "their" refs here.  The
existing tests go out of their way to create separate commits - althoug=
h
since they contain identical trees I don't think that actually buys us
anything.

Since this test does fail without my patch, it clearly does trigger the
affected code, so I think it's fine as is.

> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'file change A, remove B' '
>  	cat >expected <<\EXPECTED &&
>  removed in remote
> --=20
> 1.8.2.1
