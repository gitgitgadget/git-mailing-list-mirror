From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 03/32] rollback_lock_file(): do not clear filename redundantly
Date: Thu, 11 Sep 2014 12:13:58 -0700
Message-ID: <CAL=YDW=pNyzdNCcRV89qU7vBy94jVymGmgAUufTXWiMjdnt2hw@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:14:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS9ol-0006Vq-KQ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbaIKTOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:14:00 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:61472 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbaIKTN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:13:59 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq11so2498095vcb.25
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GXBmwiu1S9uENDCbdOuVoOzUvlNBnW/1DEea2p1rjAw=;
        b=Dbv6iMiA4D9aoak11RZNe3FhOihPogmNtQYkVri+V6jNUxnKiL+OpgMqDXxUJyXQ1q
         w/zPuY6mk7Ww8JhnQEFYsiHGrmEfWh5JVpkjq2LSNzLazCP+EiRw/N87c9bWvkA98MJl
         Alz7tRWIzp/cJgiOOxrfnI2sdyNJXzS7Q0uhD12ukrRmq6xeaa3NVdQdkcWSg29kSpuA
         6VdqOVwqgpGnUt1zXD1Jtl7BLojZyptfb72lx4NENLNYz3ctEpbIJJwMpdAPrZW0W97y
         uxBkzc4036GNRRcCRNf3wV8VnLVGUyDAXJJQi6I1kvDZGwx6JZfJBGBWVSVG5FsPAxBM
         dvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GXBmwiu1S9uENDCbdOuVoOzUvlNBnW/1DEea2p1rjAw=;
        b=ITKiGLkl3+N5TC4OsY62llrUkuFtkLRyghW5RLvp62IJp2zqowH7jh+vxMv24Zo1R3
         P8MMijR6wZnfBp08aktJxojTEg5KiAncyxohR7xq8KsQNd4e1Jn0kme443HaWh5v/nvC
         OG13BPHhKZ2R1aGLerSUn5EnHZEGGv/YRkc+HjCq9jVpVksONYx0MZ//8akPUxpv06WW
         AABUVGtOeGwZK1iDbyFuh36pU8KM4dCYhrcutBU/H8lVe2xJJE2xLf/Npv3wgtPVN8Cw
         tjJaaOOThQazzIoRir8k8UhleRLmECcCXEj4XMDYByFQ9SiYRO9D2AqHmjpP8MxUcIGu
         VOcQ==
X-Gm-Message-State: ALoCoQk8Zv8hLmU9GMjfxD358I9SF2wGoT964JA9BBdL3gbO5Yutx24kx4hBiI6aO5F8yjLsTaYd
X-Received: by 10.52.34.104 with SMTP id y8mr2059459vdi.37.1410462838622; Thu,
 11 Sep 2014 12:13:58 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Thu, 11 Sep 2014 12:13:58 -0700 (PDT)
In-Reply-To: <1409989846-22401-4-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256864>

Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>

On Sat, Sep 6, 2014 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It is only necessary to clear the lock_file's filename field if it was
> not already clear.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index f1ce154..a548e08 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -276,6 +276,6 @@ void rollback_lock_file(struct lock_file *lk)
>                 if (lk->fd >= 0)
>                         close(lk->fd);
>                 unlink_or_warn(lk->filename);
> +               lk->filename[0] = 0;
>         }
> -       lk->filename[0] = 0;
>  }
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
