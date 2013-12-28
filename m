From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: [PATCH v4 23/23] compat/mingw.h: Fix the MinGW and msvc builds
Date: Sat, 28 Dec 2013 11:06:41 +0100
Message-ID: <CAFFjANQpdh5Ti2JCKD1Q-gZQFUjzX5y=Nhn1t5uieTg=xSzGwQ@mail.gmail.com>
References: <20131221135651.GA20818@sigill.intra.peff.net> <20131221140052.GW21145@sigill.intra.peff.net>
 <CABPQNSa+mtVoMiN_mxVfYW_=JMxO-0Odv5uLnGhknNhDq1yWrw@mail.gmail.com> <20131228100050.GA24929@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 28 11:07:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwqnt-0008D0-92
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 11:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab3L1KHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 05:07:03 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:46869 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab3L1KHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 05:07:02 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so10446715ieb.22
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fVa3jYjOJPI2DFMqjnKf9XllFIGnJzH426U/VmgbICU=;
        b=g9lKHFXmq2eWL5jWk6hR/dTfNaOM4gAcaZG9e/U+9kF46BdkBqeL1tJkiYOeO/uPvb
         YlqTi60QvzYC1KgoqSIq3vi6K/dxAgc/dwT5khN5KdWh8b/V+sMyZRXUppf5VyQs+agB
         WFY7H+DsKQ+D2w5dIo2oy2rKDuO3K89JSLpu35dkNHTv6HtyxPa2ior3obYMtqSwml9z
         kDL0CcDTNy3VWY9rJUIArZL7WBMBi7SUAMNYJ585qFKg5aLGDI2isERaST1gJM51UPxt
         jyWDk9cm23SrkM6aJo76oWN7mfAgm4xVyhJd8Qe9KHKAJvBMerEYP9unw85aAls8jo0t
         H0cw==
X-Received: by 10.42.142.129 with SMTP id s1mr35669147icu.30.1388225221452;
 Sat, 28 Dec 2013 02:07:01 -0800 (PST)
Received: by 10.50.221.135 with HTTP; Sat, 28 Dec 2013 02:06:41 -0800 (PST)
In-Reply-To: <20131228100050.GA24929@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239769>

Sounds good. We don't really need the dump anyway.

On Sat, Dec 28, 2013 at 11:00 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 25, 2013 at 11:08:57PM +0100, Erik Faye-Lund wrote:
>
>> On Sat, Dec 21, 2013 at 3:00 PM, Jeff King <peff@peff.net> wrote:
>> > From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> >
>> > Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> >  compat/mingw.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/compat/mingw.h b/compat/mingw.h
>> > index 92cd728..8828ede 100644
>> > --- a/compat/mingw.h
>> > +++ b/compat/mingw.h
>> > @@ -345,6 +345,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
>> >  #define PATH_SEP ';'
>> >  #define PRIuMAX "I64u"
>> >  #define PRId64 "I64d"
>> > +#define PRIx64 "I64x"
>> >
>>
>> Please, move this before patch #8, and adjust the commit message.
>
> Yeah, that makes sense. Though I think we can do one better and simply
> remove the need for it entirely. The only use of PRIx64 is in a
> debugging function that does not get called.
>
> How about squashing the patch below into patch 8 ("ewah: compressed
> bitmap implementation"):
>
> diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
> index f104b87..9ced2da 100644
> --- a/ewah/ewah_bitmap.c
> +++ b/ewah/ewah_bitmap.c
> @@ -381,18 +381,6 @@ void ewah_iterator_init(struct ewah_iterator *it, struct ewah_bitmap *parent)
>                 read_new_rlw(it);
>  }
>
> -void ewah_dump(struct ewah_bitmap *self)
> -{
> -       size_t i;
> -       fprintf(stderr, "%"PRIuMAX" bits | %"PRIuMAX" words | ",
> -               (uintmax_t)self->bit_size, (uintmax_t)self->buffer_size);
> -
> -       for (i = 0; i < self->buffer_size; ++i)
> -               fprintf(stderr, "%016"PRIx64" ", (uint64_t)self->buffer[i]);
> -
> -       fprintf(stderr, "\n");
> -}
> -
>  void ewah_not(struct ewah_bitmap *self)
>  {
>         size_t pointer = 0;
> diff --git a/ewah/ewok.h b/ewah/ewok.h
> index 619afaa..43adeb5 100644
> --- a/ewah/ewok.h
> +++ b/ewah/ewok.h
> @@ -193,8 +193,6 @@ void ewah_and(
>         struct ewah_bitmap *ewah_j,
>         struct ewah_bitmap *out);
>
> -void ewah_dump(struct ewah_bitmap *self);
> -
>  /**
>   * Direct word access
>   */
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
