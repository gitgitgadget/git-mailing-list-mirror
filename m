From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 3/3] status: introduce status.displayCommentChar to disable display of #
Date: Wed, 28 Aug 2013 14:50:11 -0700
Message-ID: <xmqqioyp8oz0.fsf@gitster.dls.corp.google.com>
References: <vpqhaeaasuf.fsf@anie.imag.fr>
	<1377694024-24173-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:50:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnd9-0002MX-4p
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab3H1VuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 17:50:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228Ab3H1VuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 17:50:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6191F3D4AF;
	Wed, 28 Aug 2013 21:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/aeJk94Ah7SZ9Glg/+OYXa5r5mo=; b=SBvJFm
	CsSwP4qLQemrfvzIvNTuI+FG3GX6JAjeGX9hC8Bz8UzcOkrFXtLCAVToei0S79S/
	KO4IXPOWxrze90V0kMaqbhGGyTzE8RUluiLT2lf5LRkO/VXy1uKACALHeJlNGVYi
	h/SxNKX0l3Foy7rylqDSOh+3v6W9t8QeBKJKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bvb/ZKX7f7/7YleA932D6m49xIQaJ3gF
	y83dg0NVRkPZcGXu0ajWu5lQp3r3cyBHK5ltQ4k2CS4NywTV+2F/hG9SU1jGhcJX
	sTJd5Cz7w9I6FQri0S5Q/QIi/tTimY36+/XL0gblKqFmtEtr1++XelqSMnSF/fe4
	K9OgH9V39Yg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 564AD3D4AD;
	Wed, 28 Aug 2013 21:50:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A82503D4AB;
	Wed, 28 Aug 2013 21:50:13 +0000 (UTC)
In-Reply-To: <1377694024-24173-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 28 Aug 2013 14:47:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D1936100-102B-11E3-A428-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233221>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/wt-status.c b/wt-status.c
> index cb24f1f..97068d5 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -774,12 +778,21 @@ static void wt_status_print_tracking(struct wt_status *s)
>  	if (!format_tracking_info(branch, &sb))
>  		return;
>  
> +	char comment_line_string[3];
> +	int i = 0;

decl-after-statement; queued with a fix to be squashed in.
