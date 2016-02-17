From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/26] wrapper.c: allow to create an empty file with write_file()
Date: Wed, 17 Feb 2016 14:29:57 -0800
Message-ID: <xmqqpovvgeca.fsf@gitster.mtv.corp.google.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
	<1455629367-26193-1-git-send-email-pclouds@gmail.com>
	<1455629367-26193-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 23:30:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWAbp-00038u-85
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 23:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424031AbcBQWaC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2016 17:30:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423468AbcBQWaA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2016 17:30:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99CA643B94;
	Wed, 17 Feb 2016 17:29:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gIT4y7DerCU2
	Mxtf3R0mmDzBEH0=; b=evjZ4ApmoCcsXHgWe+tTnXmpJfp0fNZVGO3ao6dhcrOy
	EceDGJdtjczQu5QKjdyiR7D629R8sTuNvYAWpPnlrtOjB69+z2SB+Sm4A4F/5Mgg
	I3WQeTiniv0ZdYAf48lrbO95oExqCYtCpep48GOmaRdnckHtFGBAtOyNlytd4CE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jXc9Sd
	92rMt5hYWOSSXiQmuSUESOQkMLvkXGbqbh/gXh6leXfxV/0UdvuaMgxpy4+QnXpp
	qCC+Ie9ESlv86E/YHZeVkHrCl1FbuseizsMC11ltIGiQVUOlrtUWrq+r5w+8aXhh
	HtQQdY8JLPnPwSCm7jiaohCgXRz2qfgnmbCFs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91ECF43B93;
	Wed, 17 Feb 2016 17:29:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1138A43B90;
	Wed, 17 Feb 2016 17:29:58 -0500 (EST)
In-Reply-To: <1455629367-26193-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 16
 Feb 2016 20:29:11 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FA64D5AC-D5C5-11E5-ACD9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286563>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is used later on to create empty .git/worktrees/xxx/locked when
> "git worktree lock" is called with no reason given.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  wrapper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wrapper.c b/wrapper.c
> index 29a45d2..1dc1eff 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -666,7 +666,7 @@ static int write_file_v(const char *path, int fat=
al,
>  	}
>  	strbuf_vaddf(&sb, fmt, params);
>  	strbuf_complete_line(&sb);
> -	if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
> +	if (sb.len && write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {

I do not quite see how this change relates to what the log message
claims this commit does.  write_in_full() returns 0 when called with
count=3D=3D0 just fine, no?

>  		int err =3D errno;
>  		close(fd);
>  		strbuf_release(&sb);
