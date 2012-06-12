From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: report SHA-1 instead of gibberish when
 marks exist already
Date: Tue, 12 Jun 2012 07:26:54 -0700
Message-ID: <7vtxyg4ndd.fsf@alter.siamese.dyndns.org>
References: <1339508716-51880-1-git-send-email-max@quendi.de>
 <1339508716-51880-2-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 16:27:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeS3q-0001K4-Fn
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 16:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991Ab2FLO1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Jun 2012 10:27:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab2FLO05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2012 10:26:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFFB88D37;
	Tue, 12 Jun 2012 10:26:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8YoIykdc4YMe
	/iBNw5RTMcePMAU=; b=sF/KW08WBG64u9+qjVThI9EKOUFoK+lwEFEUr9DSL1qZ
	u74ITbBqaQEtQ2u7NnbvRC0lVvBkd4YBxo30wNphGsH8IpHuUhRSVv+Wr9j6CCNE
	dKce3+GWnB26RxJLD62ptzjB3qJA3j+l+BWNa2P5x5B56zQSQn4C0WYpK3FrNJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=p9/hIv
	37pxIsHPr0bkVM//4sMU3ig33qIES3VfSWUMup5lvXz7Vp5OS9xAGs8WdS2Ti29F
	Jp3PjeTXuU6yVadGV7kxt/BCKMfhjiNnW7Ph7uiSoQmRznkZcu60S1bIOp7Manqc
	A2VF7vR0E8PqoCPnbVopO5gfmQPWWxOuC73TM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BBB8D35;
	Tue, 12 Jun 2012 10:26:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 752E88D34; Tue, 12 Jun 2012
 10:26:56 -0400 (EDT)
In-Reply-To: <1339508716-51880-2-git-send-email-max@quendi.de> (Max Horn's
 message of "Tue, 12 Jun 2012 15:45:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9D20EE8-B49A-11E1-B46C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199790>

Max Horn <max@quendi.de> writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Cc: Pieter de Bie <pdebie@ai.rug.nl>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Max Horn <max@quendi.de>
> ---

Thanks, both.  Applied.

>  builtin/fast-export.c |    2 +-
>  1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt=
(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 19509ea..ef7c012 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -610,7 +610,7 @@ static void import_marks(char *input_file)
>  			die ("Could not read blob %s", sha1_to_hex(sha1));
> =20
>  		if (object->flags & SHOWN)
> -			error("Object %s already has a mark", sha1);
> +			error("Object %s already has a mark", sha1_to_hex(sha1));
> =20
>  		mark_object(object, mark);
>  		if (last_idnum < mark)
