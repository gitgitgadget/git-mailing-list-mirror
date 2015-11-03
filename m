From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] diff-highlight: add `less -r` to cmd in README
Date: Mon, 02 Nov 2015 18:41:53 -0800
Message-ID: <xmqq7flzerda.fsf@gitster.mtv.corp.google.com>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
	<1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 03:42:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtRXt-0000T9-FB
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 03:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbbKCCl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 21:41:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64185 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751965AbbKCCl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 21:41:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8FBDC297EA;
	Mon,  2 Nov 2015 21:41:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p/3Eu2dTe7FEZ8bfKVNEQJWcf2U=; b=luQLmK
	tYsGin3g09y4iwEM++36r43ENyffxsu1lN0nkr1UrkBXeJ+VKylDR+d0PeYq+vlp
	UGlxktacU9JXkp0IzCjb2/TTiXOIkMYdGZu0fWn+GyUAT9Zq/Rfum6wXjFtxnMHT
	nT+SK8XeUtv10ZbhdtdSbRFj4aqBuxgdJe/ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D0rzryTbjeExPIlJstmxr6rghXRQv9pD
	Q+xnRgLn4OI3SZF9FwLib0Q6kdnyhLUg7mhPW5JhlKl5NksMhvYAgwmF80T8MCUy
	DgEk3fjSEP90yjeZlLdd/DkHofL+03Y/+ytgyPwLQmr246CQBtNiQnXk4T+wwp9i
	eoexj4htQ/0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87A4B297E9;
	Mon,  2 Nov 2015 21:41:55 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A107297E8;
	Mon,  2 Nov 2015 21:41:54 -0500 (EST)
In-Reply-To: <1446516334-27652-2-git-send-email-jonathan.lebon@gmail.com>
	(Jonathan Lebon's message of "Mon, 2 Nov 2015 21:05:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7203B65A-81D4-11E5-816D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280746>

Jonathan Lebon <jonathan.lebon@gmail.com> writes:

> As it is, the suggested command for trying out diff-highlight will just
> dump the whole git log output to the terminal. Let's pipe it through
> `less` so users aren't surprised on the first try.

That justifies the "less" part but not your choice of "-r".

I am assuming that you are telling "less" not to show the ANSI
"color" escape sequences using the caret notation with "-r", which
is a very natural and sensible thing to do when using `highlight`.

But if that is the case, you don't want "-r" (raw control chars for
everything).  You would want to say "-R", I think.

Other than that, looks like a sensible thing to do to me.

Thanks.


> Signed-off-by: Jonathan Lebon <jonathan.lebon@gmail.com>
> ---
>  contrib/diff-highlight/README | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/diff-highlight/README b/contrib/diff-highlight/README
> index 836b97a..bbbfdda 100644
> --- a/contrib/diff-highlight/README
> +++ b/contrib/diff-highlight/README
> @@ -44,9 +44,9 @@ Use
>  
>  You can try out the diff-highlight program with:
>  
> ----------------------------------------------
> -git log -p --color | /path/to/diff-highlight
> ----------------------------------------------
> +------------------------------------------------------
> +git log -p --color | /path/to/diff-highlight | less -r
> +------------------------------------------------------
>  
>  If you want to use it all the time, drop it in your $PATH and put the
>  following in your git configuration:
