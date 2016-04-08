From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] l10n: index-pack: use plural string instead of normal one
Date: Fri, 08 Apr 2016 13:26:54 -0700
Message-ID: <xmqqlh4nvoc1.fsf@gitster.mtv.corp.google.com>
References: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:27:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoczh-0007W7-BQ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 22:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758534AbcDHU06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 16:26:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62307 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752950AbcDHU05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 16:26:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 71BF152DC8;
	Fri,  8 Apr 2016 16:26:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ik7T77+EfpMM5kQdfU5j4iTLLa8=; b=KDgYQb
	sGEksDXGSFvNAZDQJmJ7/mDmz0FUxOg+1mgWyyo/9M2ewTFP5R1/AmJkb+iN5G2L
	TmacmKprvbm0HC1H1eDI2PYVY9MsXgdYsQ6nOcyttHBwhNMSLyCrZua5B3/Tc7nk
	zdxvNI+UxAhXIBgPdnKGkio9M7PExP06EQoVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lf4mIBJaXVj48Vjn1tmn5PnaJR3uEL2b
	zzFlz2ZrInXjkZDKPQj8sGJQoU0VbZIi6aUQrKHoJ3eEKDIev196DE4EvrF5qyt/
	xLL9mHnzqLHEG768AdP3yqo5rOLtmMLdWzoJcdrUFnJY3bUoi08HK/vibSaKaVQ/
	pZnVHyQnozk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 696AC52DC7;
	Fri,  8 Apr 2016 16:26:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E10C352DC6;
	Fri,  8 Apr 2016 16:26:55 -0400 (EDT)
In-Reply-To: <1460145765-7454-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Fri, 8 Apr 2016 20:02:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CC2ADAA-FDC8-11E5-A6F9-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291068>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Subject: Re: [PATCH 1/7] l10n: index-pack: use plural string instead of normal one

These are probably better prefixed with "i18n:" (i.e. enable
translation into many languages) not "l10n:" (i.e. actually
translate for languages).

> Git could output "completed with 1 local objects", but in this case
> using "object" instead of "objects" is the correct form.
> Use Q_() instead of _().
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  builtin/index-pack.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 2d1eb8b..e8c71fc 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1250,7 +1250,9 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
>  		       nr_unresolved * sizeof(*objects));
>  		f = sha1fd(output_fd, curr_pack);
>  		fix_unresolved_deltas(f);
> -		strbuf_addf(&msg, _("completed with %d local objects"),
> +		strbuf_addf(&msg, Q_("completed with %d local object",
> +				     "completed with %d local objects",
> +				     nr_objects - nr_objects_initial),
>  			    nr_objects - nr_objects_initial);

Looks sensible.  It seems that all existing instances of Q_() that
have "%d" for the plural one also use "%d" for the singular, so this
update is consistent with them.

I however wonder if we want to say "completed with 1 local object"
in the message, which would allow translation of it into "completed
with one local object" etc., but that is a separate topic.

Thanks.

>  		stop_progress_msg(&progress, msg.buf);
>  		strbuf_release(&msg);
