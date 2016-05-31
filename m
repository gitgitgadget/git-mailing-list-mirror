From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/6] worktree.c: add is_main_worktree()
Date: Tue, 31 May 2016 10:52:47 -0700
Message-ID: <xmqqd1o25d3k.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-4-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 19:52:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7nqZ-00030y-3B
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 19:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbcEaRwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 13:52:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751133AbcEaRwv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 13:52:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A17B1E513;
	Tue, 31 May 2016 13:52:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xlfLiIq8ZAd1
	OeDBwqpOyHhqLRM=; b=Rc6tlDVuC5dyGwyFndcBTwT266GBqoSMXDnDTprodkJQ
	kfVUTBh8gAH3fnUtfm+q5anRvkmxaLZL+oaemBcPG/szfcJTbVqPNrJqiTmfwid2
	+XPwOjkRnDFx4LGOQatcAqVjeTV48muMQRyGg1K8po65Fn787xrBjC6S4YGURPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bf/Tux
	ui6WZTgLN+wSj3bOm1OA9wVxN1tQFbE2m6TxONuKNdA3S/eR0AZRHBT2W3zVa66y
	rD6aqHGv6xAoCocoTuIMaXb1cAQhNAeWrTk2XN+naL7V773sifitXIQhmBZyRD5W
	9piAm3x/FvG2ML6+L9VZvF+YK99kiRAaSGvwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81C711E512;
	Tue, 31 May 2016 13:52:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 103611E50A;
	Tue, 31 May 2016 13:52:48 -0400 (EDT)
In-Reply-To: <20160530104939.28407-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D198A40-2758-11E6-8B8A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295999>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Main worktree _is_ different. You can lock a linked worktree but not =
the
> main one, for example. Provide an API for checking that.

You haven't defined what it means to "lock" a worktree, so that
example does not sound convincing at all, until the reader sees what
happens later in the series.  I'll just take your word for it and
keep reading for now ;-)

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  worktree.c | 5 +++++
>  worktree.h | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index 4dd7b77..6432eec 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -250,6 +250,11 @@ struct worktree *find_worktree(struct worktree *=
*list,
>  	return *list;
>  }
> =20
> +int is_main_worktree(const struct worktree *wt)
> +{
> +	return !wt->id;
> +}
> +
>  int is_worktree_being_rebased(const struct worktree *wt,
>  			      const char *target)
>  {
> diff --git a/worktree.h b/worktree.h
> index 7ad15da..e1c4715 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -37,6 +37,11 @@ extern struct worktree *find_worktree(struct workt=
ree **list,
>  				      const char *prefix,
>  				      const char *arg);
> =20
> +/*
> + * Return true if the given worktree is the main one.
> + */
> +extern int is_main_worktree(const struct worktree *wt);
> +
>  /*
>   * Free up the memory for worktree(s)
>   */
