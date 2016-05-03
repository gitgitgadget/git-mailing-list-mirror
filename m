From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/41] builtin/worktree.c: use error_errno()
Date: Tue, 03 May 2016 13:02:08 -0700
Message-ID: <xmqq60uunc5b.fsf@gitster.mtv.corp.google.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-1-git-send-email-pclouds@gmail.com>
	<1462277054-5943-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:02:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axgWN-0004TO-SS
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 22:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325AbcECUCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 16:02:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752195AbcECUCL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2016 16:02:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EA1F17B54;
	Tue,  3 May 2016 16:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GTIFNHrvpHXz
	Ry9fLIpeMi922uY=; b=mgBntxe3fIDm6XHQw2rl0Izkp/i0zBRcizvpnhisZORS
	lWTEs4IaHATFJMxC865aXbHDZNEyRGjSAJ5pFd2MhQGptXt/WTuJylsBT/WVueFh
	mRX0Qr6kHXFtKQCc1jPy6Uv+oRGLsVw1xiUElxQMO3qz0OsfveIPR6tkhufpYx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KG37cx
	7MTdfPuWOZoTKyKNCue0YbEWoQmred5K0DNK2e4JRDoWmHvCrYfm0PKrQzodXXyU
	+l9fiw7GLFsJe61kUQoBSJHW3JwiiKVmri4GnHz9Mb8edSc3a1cMKieMcWD8PqCb
	8NYXgq8oVtUmgdKupYumQSKikSmkH0N2ltOus=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6706217B53;
	Tue,  3 May 2016 16:02:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B146117B52;
	Tue,  3 May 2016 16:02:09 -0400 (EDT)
In-Reply-To: <1462277054-5943-15-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 3 May
 2016 19:03:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB3EED58-1169-11E6-9D80-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293448>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/worktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d8e3795..331ecf6 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -110,7 +110,7 @@ static void prune_worktrees(void)
>  		if (ret < 0 && errno =3D=3D ENOTDIR)
>  			ret =3D unlink(path.buf);
>  		if (ret)
> -			error(_("failed to remove: %s"), strerror(errno));
> +			error_errno(_("failed to remove '%s'"), path.buf);

This also deserves a mention in the log message.  We didn't say what
we failed to remove, now we do, which is an improvement.
