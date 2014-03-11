From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status merge: guarentee space between msg and path
Date: Tue, 11 Mar 2014 12:59:37 -0700
Message-ID: <xmqqeh28pkuu.fsf@gitster.dls.corp.google.com>
References: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:59:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSq3-0007kM-Av
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbaCKT7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:59:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647AbaCKT7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:59:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E99F744F1;
	Tue, 11 Mar 2014 15:59:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UV+/JlhAMCsXmN5NzXqAUvanpWQ=; b=Ypn8jC
	N7+GP1B7pyZPIyeX8faB2PKr0MB4hjN+TJN/fFKZnEV6k7MNZuWOORcI0TGaR/mt
	1CMjyMnX0KdeOJraQkPY+70syJBrY24GIzEUVjRRxPnET6P69o6W8jyecUjU36f9
	BBiNI9de1X1v14Vg4ozLDNFWzhBmdeRdgezKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oDuWGEEPOWxiNWxkPaqseLtidMVX1a85
	U+kjVj9oFevv2JDA41H+V0sF+JMwP4lWofR2+VqeAii2l+yit/NrNCU1Y5L0gHbp
	GT59KwRrByq9Ix4ji1z7BmeQ188p/UGv4wIIclvDiyTXH+0mh6WCfYFagdiXAMxY
	xA6MhHmuwts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2802C744F0;
	Tue, 11 Mar 2014 15:59:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B996744EF;
	Tue, 11 Mar 2014 15:59:39 -0400 (EDT)
In-Reply-To: <1394555447-1805-1-git-send-email-sandy.carter@savoirfairelinux.com>
	(Sandy Carter's message of "Tue, 11 Mar 2014 12:30:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADD877EE-A957-11E3-B85B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243887>

Sandy Carter <sandy.carter@savoirfairelinux.com> writes:

> diff --git a/wt-status.c b/wt-status.c
> index a452407..69e0dfc 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -264,7 +264,7 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
>  	case 6: how = _("both added:"); break;
>  	case 7: how = _("both modified:"); break;
>  	}
> -	status_printf_more(s, c, "%-20s%s\n", how, one);
> +	status_printf_more(s, c, "%-19s %s\n", how, one);
>  	strbuf_release(&onebuf);
>  }

Thanks; I have to wonder if we would want to do something similar to
what 3651e45c (wt-status: take the alignment burden off translators,
2013-11-05) to the other parts of the output, though.
