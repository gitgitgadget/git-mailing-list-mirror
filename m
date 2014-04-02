From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/22] lockfile: define a constant LOCK_SUFFIX_LEN
Date: Wed, 02 Apr 2014 10:27:43 -0700
Message-ID: <xmqqvburvdyo.fsf@gitster.dls.corp.google.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:45:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeT5-0000xS-3c
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 12:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbaDBR1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 13:27:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932501AbaDBR1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 13:27:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3809B7851B;
	Wed,  2 Apr 2014 13:27:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=ASiIqxlSOiIcp/WR7aVxWquMlAY=; b=LVCLGoJW4nu87U49lvco
	mJeWsHbtYX+TcRhzj+M4udhemrvYE+pceYMA4dCGUTvBosNHj7Xj267XkKIb5TVE
	gB6qzmdhfx6z7vgTErZyIwMG6hJIJk7frtGzfj7Tbzz11+IX134y2htQDpYQpAry
	YsUZX+bJ7Ic1c3k6+BP4opM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mJf4kbcUWQaoo/HxydDjtHZKl7XDgfVoD+P+dW3oTDMgWi
	ABAxnUMV8hO7LVsUjfDXaZwraOqdHgimsiUKOikAh7dJgbm1koU3EUBokVJX6zxR
	EoitwbLx6fqEpswR/FpTSDPeYCyVgbfC5DJy4SEPCH808xQSnSC7YNwfrR33M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27C0A78519;
	Wed,  2 Apr 2014 13:27:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B58178514;
	Wed,  2 Apr 2014 13:27:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C28940A-BA8C-11E3-8327-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245693>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 4a9ceda..4e3ada8 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -178,14 +178,17 @@ static char *resolve_symlink(char *p, size_t s)
>  	return p;
>  }
>  
> +/* We append ".lock" to the filename to derive the lockfile name: */
> +#define LOCK_SUFFIX_LEN 5
>  
>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
>  	/*
> -	 * subtract 5 from size to make sure there's room for adding
> -	 * ".lock" for the lock file name
> +	 * subtract LOCK_SUFFIX_LEN from size to make sure there's
> +	 * room for adding ".lock" for the lock file name:
>  	 */
> -	static const size_t max_path_len = sizeof(lk->filename) - 5;
> +	static const size_t max_path_len = sizeof(lk->filename) -
> +		                           LOCK_SUFFIX_LEN;

SP{8,} in the indent; I've cleaned it up while queueing.

Thanks.
