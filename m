From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] write_pack_file: use correct variable in diagnostic
Date: Mon, 03 Mar 2014 10:43:09 -0800
Message-ID: <xmqqfvmzqg1u.fsf@gitster.dls.corp.google.com>
References: <1393745411-30980-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:43:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXpe-00036S-T5
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbaCCSnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:43:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbaCCSnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:43:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B2E06F6B5;
	Mon,  3 Mar 2014 13:43:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvqZ8hnnTM+BDOJnqzwKnVSAkSo=; b=vU5foL
	1naN7r/dR27Z0YaGawQGVgrGWe/KF8VvR9s0vcRUhjZo1oSgYcvKeiwG9aORa9ru
	UqGNwTX9ha/ddKjT/f9rPgEamppD5ppdHh421sGC9Vx0aEYXXddog+S8xBYNx0R/
	uy8tmO7k/4chFLo2NMXk8yacH84dUsIT2L3wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x7f1vzilxgDlZoUO1XkQ4rRplpiqsshL
	/yFmc8MhYf8aoT6GVx+9rxhDvURIdkFRyXE+PMJOJBYxAq9XZqNCoo1L88p046TG
	+QQHxaxCMTE0562VtvHNABomA9J03pBEuc1ke6gQGoxYhjZSI7+vX1YVip0sijo2
	5v7+/q2fCjw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D57B6F6B4;
	Mon,  3 Mar 2014 13:43:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3379E6F6B0;
	Mon,  3 Mar 2014 13:43:11 -0500 (EST)
In-Reply-To: <1393745411-30980-1-git-send-email-sunheehnus@gmail.com> (Sun
	He's message of "Sun, 2 Mar 2014 15:30:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ABB48AFC-A303-11E3-81C1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243251>

Sun He <sunheehnus@gmail.com> writes:

> 'pack_tmp_name' is the subject of the utime() check, so report it in the
> warning, not the uninitialized 'tmpname'
>
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>
>  Changing the subject and adding valid information as tutored by 
>  Eric Sunshine.
>  Thanks to him.
>
>  builtin/pack-objects.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..4922ce5 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -823,7 +823,7 @@ static void write_pack_file(void)
>  				utb.modtime = --last_mtime;
>  				if (utime(pack_tmp_name, &utb) < 0)
>  					warning("failed utime() on %s: %s",
> -						tmpname, strerror(errno));
> +						pack_tmp_name, strerror(errno));
>  			}
>  
>  			/* Enough space for "-<sha-1>.pack"? */

Very nicely done.  Thanks.

And big Thanks to Eric guiding this patch through.
