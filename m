From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] push.c: add an --atomic-push argument
Date: Mon, 15 Dec 2014 13:50:16 -0800
Message-ID: <xmqqa92od1lz.fsf@gitster.dls.corp.google.com>
References: <1418673368-20785-1-git-send-email-sbeller@google.com>
	<1418673368-20785-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 22:50:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0dX9-0005VC-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 22:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbaLOVuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 16:50:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750738AbaLOVuX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 16:50:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BD7827DF6;
	Mon, 15 Dec 2014 16:50:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGPD3AuO9k1Qoxrk41nbpoVwMPY=; b=cxnDPj
	zDSnh/Quq2xoTwDQsNC1CZN536xnM6sZYxSGj8OZ2yJ9uql7ei379EN98zj3jH7H
	1dVhhy9Nb1ceQTs8blZqI+ixim/4YVg6R58JzxiVk9pLymVwtUdmYIApKA3i4eQ8
	0dMv2obLZ3T41fZJ0XSGaz/c57d/ZLYPVxD3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CDXx298IVH9eLa3u68FoiDLjSVsoakfL
	awAAsamaIJjxHNAJQgnKcaEFgjLWgah1cxn5pMqxRhBm1V0WKdWkdlBGpEE075So
	AQ7hCEtFpjfedcQEnYlAMB/pxhpLu4s0RBT5RLtJgu8UxA35lDhb/U1nhA9pPk+a
	d2toBwSiL8w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BBC527DF5;
	Mon, 15 Dec 2014 16:50:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77B9827DF3;
	Mon, 15 Dec 2014 16:50:18 -0500 (EST)
In-Reply-To: <1418673368-20785-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 15 Dec 2014 11:56:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C48EFC0-84A4-11E4-9709-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261428>

Stefan Beller <sbeller@google.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
>
> Add a command line argument to the git push command to request atomic
> pushes.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Makes sense, modulo a nit.

> +--atomic-push::
> +	Using atomic push. If atomic push is negotiated with the server
> +	then any push covering multiple refs will be atomic. Either all
> +	refs are updated, or on error, no refs are updated. If the server
> +	does not support atomic pushes the push will fail.

"git push --atomic-push"?  Why should one need to repeat the word?

>  		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
> +		OPT_BIT(0, "atomic-push", &flags, N_("use atomic push, if available"),
> +			TRANSPORT_ATOMIC_PUSH),

Contrast between the two.  It isn't "git push --signed-push", either ;-)
