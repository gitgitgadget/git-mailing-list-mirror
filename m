From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5551: fix the 50,000 tag test
Date: Mon, 09 Jun 2014 12:16:13 -0700
Message-ID: <xmqqr42xevwi.fsf@gitster.dls.corp.google.com>
References: <5390E2D5.9070000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 21:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu53R-0001jk-HX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 21:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbaFITQW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 15:16:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59559 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbaFITQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jun 2014 15:16:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 477451CC18;
	Mon,  9 Jun 2014 15:16:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tAC0sfqY93fv
	2iJVrPUhaLWWkEs=; b=XxFcgla5D5uL0EGRTlgMOaLNH6RW4Ti5tnIN9ODQS1Oq
	Vr82HdQHh51e9FaHSLuKndiCYL26uhg1DJ1ip3dMS/CyZ8PagR12gT0vCY5u5N/p
	5ExSaNDFx7W+NAqyx+0tbSF1vtrSGa/uCGDSilAp992x9NoxS/bJFZ6ZQG6h/xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xIlOgy
	n6lVWetbmnQg4k1iGOrM3XLOkreSRBl8bjI0GqjXyRwDlHqJKqtctAfNzUFj8N1O
	CijJnrmqub95sCh18HfpL9ZqeGAhM0Eei6JXZs3ZglVLePcATnU0JDkI3yZKJqO3
	jgcqy1LD3Sud/1i8ZptRBtx7xgQY9O7K7DgQo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C77C1CC17;
	Mon,  9 Jun 2014 15:16:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 396771CC16;
	Mon,  9 Jun 2014 15:16:15 -0400 (EDT)
In-Reply-To: <5390E2D5.9070000@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 05 Jun 2014 23:36:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 86C2013A-F00A-11E3-B5E0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251103>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The first version of test 23 did simply check that no output was send
> to stderr.
>
> Commit 5e2c7cd2 verified that the expected tags were actually cloned.
>
> Since the day "git clone" printed "Cloning into 'too-many-refs'" to s=
tderr,

Thanks.  It is 68b939b2 (clone: send diagnostic messages to stderr,
2013-09-18); before it we showed the message to the standard output
stream instead.

Will queue.

> the test failed because stderr was not empty.
>
> Remove the check for stderr and make t5551-23 pass again
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t5551-http-fetch-smart.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.s=
h
> index e07eaf3..2c49133 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -240,8 +240,7 @@ test_expect_success EXPENSIVE 'create 50,000 tags=
 in the repo' '
>  '
> =20
>  test_expect_success EXPENSIVE 'clone the 50,000 tag repo to check OS=
 command line overflow' '
> -	git clone $HTTPD_URL/smart/repo.git too-many-refs 2>err &&
> -	test_line_count =3D 0 err &&
> +	git clone $HTTPD_URL/smart/repo.git too-many-refs &&
>  	(
>  		cd too-many-refs &&
>  		test $(git for-each-ref refs/tags | wc -l) =3D 50000
