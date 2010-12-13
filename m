From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/19] Convert struct diff_options to use struct pathspec
Date: Mon, 13 Dec 2010 11:00:37 -0800
Message-ID: <7vhbeh1oru.fsf@alter.siamese.dyndns.org>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 20:00:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSDdj-0002CB-2P
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 20:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318Ab0LMTAp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 14:00:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab0LMTAp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Dec 2010 14:00:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 101043604;
	Mon, 13 Dec 2010 14:01:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=cD/3JIAC/LwL2jUAoYjdYXqJi
	jk=; b=rRrzXjNpCVWunVNboSmCYFrUeoa5nRQnN6QR1xFgMeEcx3aZ/M0YYC8vQ
	aahP3f7sGCWMJhqc1NqE0AUxeXhq2APex5laozHvWfxyjpPfwksyOxYpwFoqW7g1
	RXj2atJD3Gb1lru23U9vdHJIC4AMmMWhsYKKDIczNxKYDiiAmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ID7E7JM/2roZfyawcRW
	uqtpZBRwElo6bdEF3lSpXxvoxwo8laj2h3hjbtLRrwbbdzt9TcS7ICwPgji7vHJD
	MsrXIaQRGbEZLUmZNdLRBCT8kgslf6wPR1NN+wKvMQ1GLFVCFUzL/QN2oGK0xadT
	EXvyvvUomt6oR9qYXewca2dc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC21A3603;
	Mon, 13 Dec 2010 14:01:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 004CB35FA; Mon, 13 Dec 2010
 14:01:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57A4EF40-06EB-11E0-B959-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163580>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 392ce2b..3b809f2 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -501,7 +501,7 @@ int do_diff_cache(const unsigned char *tree_sha1,=
 struct diff_options *opt)
>  	active_nr =3D dst - active_cache;
> =20
>  	init_revisions(&revs, NULL);
> -	revs.prune_data =3D opt->paths;
> +	revs.prune_data =3D opt->pathspec.raw;
>  	tree =3D parse_tree_indirect(tree_sha1);
>  	if (!tree)
>  		die("bad tree object %s", sha1_to_hex(tree_sha1));

Hopefully the prune_data will become opt->pathspec not "raw" and use yo=
ur
generalied/unified pathspec matching code in later patches in the serie=
s,
yes?

Other than that (no, "including that", really), looks nicely done.
