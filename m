From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disown ssh+git and git+ssh
Date: Sat, 13 Feb 2016 13:10:34 -0800
Message-ID: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
References: <1455289777-186690-1-git-send-email-cmn@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Sat Feb 13 22:10:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUhSi-0005TC-Od
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 22:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbcBMVKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2016 16:10:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751306AbcBMVKg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2016 16:10:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B687442CCA;
	Sat, 13 Feb 2016 16:10:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZjDs+JYVfZxh
	HP8IQz7wFGcv16w=; b=UxHmeAX7J7fHeE4VMafvVXLQBReq1DSVGV0ikaO/maIz
	23X9/QCyVgEJvLk5EEeiGPF53OQYKwPapR37NjsrorRc8JIWCdqd3xgstjcamChE
	Qbx+kBGg+HE2+bdny6hF6B46lmCm9247IvYLIfn7Ous9QobjQRVvuUdey4vJbPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VYkki/
	CfNT9pJS96abOZwaH0ljgTApFoES/yCFezRkjmrZiBZkqmi3sc45o5jeFCiVPUX1
	ErE20epNHNDGMx431n+eF/XQWRixB7wZ/6/9yfCPixyOEdF1jDGFq4r1wSyNF5Lr
	6HoULgSkK9xPChNlf4lBp3OX4EqrXxftmL0PY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC83D42CC9;
	Sat, 13 Feb 2016 16:10:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2CFDE42CC7;
	Sat, 13 Feb 2016 16:10:35 -0500 (EST)
In-Reply-To: <1455289777-186690-1-git-send-email-cmn@dwim.me> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Fri, 12 Feb 2016 16:09:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 393E0966-D296-11E5-8A90-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286130>

Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:

> These were silly from the beginning, but we have to support them for
> compatibility. That doesn't mean we have to show them in the
> documentation. These were already left out of the main list, but a
> reference in the main manpage was left, so remove that.
>
> Also add a note to discourage their use if anybody goes looking for t=
hem
> in the source code.
> ---

Sign off?

>  Documentation/git.txt | 2 +-
>  connect.c             | 4 ++++
>  transport.c           | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d987ad2..2f90635 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1122,7 +1122,7 @@ of clones and fetches.
>  	    connection (or proxy, if configured)
> =20
>  	  - `ssh`: git over ssh (including `host:path` syntax,
> -	    `git+ssh://`, etc).
> +	    `ssh://`, etc).
> =20
>  	  - `rsync`: git over rsync
> =20
> diff --git a/connect.c b/connect.c
> index fd7ffe1..4f96424 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -267,6 +267,10 @@ static enum protocol get_protocol(const char *na=
me)
>  		return PROTO_SSH;
>  	if (!strcmp(name, "git"))
>  		return PROTO_GIT;
> +	/*
> +	 * These ssh schemes remain supported for compat but are
> +	 * undocumented and their use is discouraged
> +	 */

Micronit.

It is not like we continue to support two more different protocols;
we just allow users to spell the thing in different ways.

"These ssh schemes" might be clearer if spelled "These alternative
ways to spell the ssh scheme".

>  		|| starts_with(url, "file://")
>  		|| starts_with(url, "git://")
>  		|| starts_with(url, "ssh://")
> +		/*
> +		 * These ssh schemes remain supported for compat but are
> +		 * undocumented and their use is discouraged
> +		 */

Likewise.

>  		|| starts_with(url, "git+ssh://")
>  		|| starts_with(url, "ssh+git://")) {
>  		/*

Thanks.
