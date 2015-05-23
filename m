From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/5] verify_lock(): return 0/-1 rather than struct
 ref_lock *
Date: Fri, 22 May 2015 17:09:45 -0700
Message-ID: <CAGZ79kZnpruF+DfO9WO2cT1796j_0XUU8E3qFAg1qoufdBz4Pg@mail.gmail.com>
References: <1432337697-29161-1-git-send-email-mhagger@alum.mit.edu>
	<1432337697-29161-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat May 23 02:09:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvx0h-0007H0-5X
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 02:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450AbbEWAJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 20:09:47 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34776 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316AbbEWAJq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 20:09:46 -0400
Received: by qgez61 with SMTP id z61so18148232qge.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 17:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E7yxUCz1Mflficj+K2ZuvlKAXOdvjjocV1JHJmbWILE=;
        b=YaOISevvObDFQ9tbLayp9rfOsjPLjzPBHf71NGSoLd2NebXzclhWBLac8z5zt6JWwZ
         p2F5szjeBQd6mPiwpAxLImAPYn6KmBVuSwn0BCEeNZyfRjlsnwkjbAG2tD28L5Gh0NzJ
         jNtSOkFy2QTXR0/E7EBOMHUhq0RWtfu+Fa0n8Ow34TS/E3wi5/S/5nsCTKcZWzBlA2sG
         VCtRJIjm//ySu1fdjOn1YzccIt94txE1w8WqMXB6/G6Vc+Y4eAZC1cXPCBP/y88VMchz
         D3FUpErevU0GioDqGp9wra2I9upFJeK9S7UMi/sb6JaFJjjHKChN0KmG2TrfuWQ+Dxq+
         dj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=E7yxUCz1Mflficj+K2ZuvlKAXOdvjjocV1JHJmbWILE=;
        b=dxXFdTQvBZDFk3M67k7zyx1GS72tSGSbuBJqnlcNCL4nqsGy81Oyq3C+BdlgYhL5JV
         OhRZJIT6OQmwBOCGgg2hSsb02/4jtDHLKdj+6f8W/OACYAKX4fvai34CwpcOYE7+Dtxr
         YNv5Pzs+haP0LNlnkbovc/dlbfUQvocrE9k8rmz5QXyNjZzHK9dzQvInpT2rVhHmY9GF
         FqdCdmmZ3mxSxuauzqCJ8SOmGTyMBXa23rUD9qoiSlOurpOy5Ss+K+guJEvKl1DMzBRg
         kpvw/0pXHj3AKaN89aqG8+1L9swOTA08PVxKs9YS9wzGp/7omcFPgbV+lMxgjW3wgBBl
         ADzg==
X-Gm-Message-State: ALoCoQngQps6wQEu7W6nJXu9xQ43jSACC11e7cAbgZ+WQbHA5wnqMbRRkX2sQDhQZTdHW/kQwzx1
X-Received: by 10.140.23.35 with SMTP id 32mr14250341qgo.106.1432339785525;
 Fri, 22 May 2015 17:09:45 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 17:09:45 -0700 (PDT)
In-Reply-To: <1432337697-29161-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269781>

On Fri, May 22, 2015 at 4:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Its return value wasn't conveying any extra information, but it made
> the reader wonder whether the ref_lock that it returned might be
> different than the one that was passed to it. So change the function
> to the traditional "return 0 on success or a negative value on error".
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Bonus points for the documentation!
Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  refs.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 97043fd..4432bc9 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2195,9 +2195,14 @@ static void unlock_ref(struct ref_lock *lock)
>         free(lock);
>  }
>
> -/* This function should make sure errno is meaningful on error */
> -static struct ref_lock *verify_lock(struct ref_lock *lock,
> -       const unsigned char *old_sha1, int mustexist)
> +/*
> + * Verify that the reference locked by lock has the value old_sha1.
> + * Fail if the reference doesn't exist and mustexist is set. Return 0
> + * on success or a negative value on error. This function should make
> + * sure errno is meaningful on error.
> + */
> +static int verify_lock(struct ref_lock *lock,
> +                      const unsigned char *old_sha1, int mustexist)
>  {
>         if (read_ref_full(lock->ref_name,
>                           mustexist ? RESOLVE_REF_READING : 0,
> @@ -2206,16 +2211,16 @@ static struct ref_lock *verify_lock(struct ref_lock *lock,
>                 error("Can't verify ref %s", lock->ref_name);
>                 unlock_ref(lock);
>                 errno = save_errno;
> -               return NULL;
> +               return -1;
>         }
>         if (hashcmp(lock->old_sha1, old_sha1)) {
>                 error("Ref %s is at %s but expected %s", lock->ref_name,
>                         sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
>                 unlock_ref(lock);
>                 errno = EBUSY;
> -               return NULL;
> +               return -1;
>         }
> -       return lock;
> +       return 0;
>  }
>
>  static int remove_empty_directories(const char *file)
> @@ -2445,7 +2450,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                         goto error_return;
>                 }
>         }
> -       return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
> +       if (old_sha1 && verify_lock(lock, old_sha1, mustexist))
> +               return NULL;
> +       return lock;
>
>   error_return:
>         unlock_ref(lock);
> --
> 2.1.4
>
