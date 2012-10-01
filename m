From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Add workaround for system where Shift-F5 mapped to
 Shift-XF86_Switch_VT_5
Date: Mon, 01 Oct 2012 10:27:56 -0700
Message-ID: <7vwqzacdb7.fsf@alter.siamese.dyndns.org>
References: <20120930101932.GA15672@goldbirke>
 <1349105191-31681-1-git-send-email-andrew.kw.w@gmail.com>
 <1349105191-31681-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, szeder@ira.uka.de, paulus@samba.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:33:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjmr-000079-UU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab2JAR2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:28:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221Ab2JAR17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BF49173;
	Mon,  1 Oct 2012 13:27:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQkMVAEbDy4VBiWnOXdyPrDF6Gg=; b=E82dVb
	9jZN3eRRh/whkbqY+o2Kdd4ukmSzVY+XgTeOM5zgOT/TPaLboMAqjPcqGtp9jZrM
	y1C+0VTMk0e+Wr/ztwUnYKta5llKcMc5qSW4wufltKIR8vljrrf8A7MFe8UNVBqv
	azzmsyNWgwvTxT10lEqpRwOyQWVHJmjwZmPPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uRQXdSo2tjpsF/j0bFcMzRDHckAEuRLy
	lbiWiQb5hkJVtWyJJB8RXVaMSD8usSwAWD7yleEaUAFu1ZWDWOXcWcwqUFHQbsOf
	FVanE+zSLkUmvWdaIErUdA2LwDjWuwYi5l50r+ELAcArEbsBro4vC1uX/ItRljYE
	3Ul91nCMdng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D20D39171;
	Mon,  1 Oct 2012 13:27:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ED1D916E; Mon,  1 Oct 2012
 13:27:58 -0400 (EDT)
In-Reply-To: <1349105191-31681-2-git-send-email-andrew.kw.w@gmail.com>
 (Andrew Wong's message of "Mon, 1 Oct 2012 11:26:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57C1D2D2-0BED-11E2-B76A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206747>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> The same workaround was used for Shift-F4 in:
>   cea07cf8dc9b3677e0c50433c0d72bce83adbdc7
>
> Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
> ---
>  gitk-git/gitk | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..698b84a 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2496,6 +2496,7 @@ proc makewindow {} {
>      bindkey f nextfile
>      bind . <F5> updatecommits
>      bind . <Shift-F5> reloadcommits
> +    catch { bind . <Shift-Key-XF86_Switch_VT_5> reloadcommits }
>      bind . <F2> showrefs
>      bind . <Shift-F4> {newview 0}
>      catch { bind . <Shift-Key-XF86_Switch_VT_4> {newview 0} }

Wouldn't it make more sense to have a small helper function to wrap
binding both <Shift-Fn> and <Shift-Key-XF86_Switch_VT_n> to the same
thing and have F4 and F5 binding use that to avoid repetition?
