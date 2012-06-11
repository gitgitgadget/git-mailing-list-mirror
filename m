From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] api-credential.txt: document that helpers field is
 filled-in automatically
Date: Mon, 11 Jun 2012 09:12:05 -0700
Message-ID: <7vzk897rqi.fsf@alter.siamese.dyndns.org>
References: <1339411574-22998-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 11 18:12:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se7E0-0000kb-0b
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 18:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503Ab2FKQMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 12:12:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab2FKQMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 12:12:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 028399D5F;
	Mon, 11 Jun 2012 12:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gtJT/HDkE9UIpU5eFkkTde+/BBk=; b=c6kH0m
	4Nkv1SQHRmlq5Rr7q1gjcBfyCr3GxHckhsI6/IMtzg9e/flXnjXqZFyMwj+KHCOX
	eRs2egfmU7i971hhuNXJCiCUSLokEUrNtBNc14/iVekdZnyKBkjVM/p1DfzOfjz3
	v17y0KjRpfoTZpECBOhpqcb/XtuKwz5lg4pWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XMG45NuX3OIdBqhCQRi1nZcuOPvgtAsD
	R2V5bJvbzq0LYG6WwVKezrK/YuE831rIlWLYgsqJnjudJtOLPAdBSrlWciCVoSxF
	O8QRpXGwD2lKveOVUeOKWqPC+OJHkTbPhyAY0f3gBtPHLgcB/PpgOoG0OufuqzSq
	INpTPXmwM7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED3429D5E;
	Mon, 11 Jun 2012 12:12:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 833A59D5D; Mon, 11 Jun 2012
 12:12:07 -0400 (EDT)
In-Reply-To: <1339411574-22998-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 11 Jun 2012 12:46:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31174988-B3E0-11E1-96FA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199669>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> It was unclear whether the field was to be specified by the user of the
> API.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>
> A quick grep in Git's source code seems to show that no user of the
> API explicitely modify this "helpers" field (except test-credential.c).

It is correct that the C API asks helpers that the user configured,
but I think it is common across three API functions, not limited to
credential_fill().  credential_apply_config() is called from approve
and reject, too.

>  Documentation/technical/api-credentials.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> index 21ca6a2..fc6d2b9 100644
> --- a/Documentation/technical/api-credentials.txt
> +++ b/Documentation/technical/api-credentials.txt
> @@ -46,7 +46,9 @@ Functions
>  	consulting helpers, then asking the user. After this function
>  	returns, the username and password fields of the credential are
>  	guaranteed to be non-NULL. If an error occurs, the function will
> -	die().
> +	die(). The `helpers` member of the structure is filled-in
> +	according to the corresponding configuration variables before
> +	consulting helpers.
>  
>  `credential_reject`::
