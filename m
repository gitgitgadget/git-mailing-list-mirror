From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/6] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Mon, 24 Feb 2014 10:24:50 +0100
Message-ID: <CAP8UFD1Fz_cPSBPAZ2DwoiXKAXxEvoBAj6fiBRz3FH0nfi+OvA@mail.gmail.com>
References: <1393000327-11402-1-git-send-email-mhagger@alum.mit.edu>
	<1393000327-11402-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Feb 24 10:25:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHrmR-0008Ml-K8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 10:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbaBXJYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 04:24:52 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:38538 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbaBXJYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 04:24:50 -0500
Received: by mail-vc0-f170.google.com with SMTP id hu8so5534681vcb.15
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 01:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NBrZsYnUPmLp5JICk3rnLYTJLAMmLdLKlKxWvJEoDnI=;
        b=bLJUPotH3KDGpUFdydNSsFh6kRFf7EjDKl96QGjP/Wpmqh2ejKsFfmRtYdL5tVAZr1
         CJLr+b5k8n4JGWkTL6x/antPAVSrirNLeJDDTtNI+9mHND+lxEuhG3qixiYxVRj2/DzV
         Gfc3QQNE1VpMS6KX8LjEqxkj8CG05evObP/hv3SJTxDVZaVf3KLLEL8q4YM0PRNqbNWs
         Z2you6oN2WRY8smOxhLDWA2yOEdIgDqpxR2PY++DruzTjKAhNFb64SdvkZVuu8zPV9wf
         rikYMaDu1bZFC7qKkPcLkJGkfV5DrUAngrzZHU11r8wkuQD6bR/Pnf37aq9PEncF2Cpq
         9kFw==
X-Received: by 10.52.116.171 with SMTP id jx11mr3931299vdb.88.1393233890301;
 Mon, 24 Feb 2014 01:24:50 -0800 (PST)
Received: by 10.58.104.129 with HTTP; Mon, 24 Feb 2014 01:24:50 -0800 (PST)
In-Reply-To: <1393000327-11402-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242583>

On Fri, Feb 21, 2014 at 5:32 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  cache.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index dc040fb..0ecd1c8 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -788,13 +788,29 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
>  {
>         return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
>  }
> +
> +/*
> + * If a replacement for object sha1 has been set up, return the
> + * replacement object's name (replaced recursively, if necessary).
> + * The return value is either sha1 or a pointer to a
> + * permanently-allocated value.  This function always respects replace
> + * references, regardless of the value of check_replace_refs.

Here you talk about "check_replace_refs" ...

> + */
>  extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
> +
> +/*
> + * If object sha1 should be replaced, return the replacement object's
> + * name.  This function is similar to do_lookup_replace_object(),
> + * except that it when object replacement is suppressed, it always
> + * returns its argument unchanged.
> + */
>  static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
>  {
>         if (!read_replace_refs)

... but here "read_replace_refs" is used.

>                 return sha1;
>         return do_lookup_replace_object(sha1);
>  }

Thanks,
Christian.
