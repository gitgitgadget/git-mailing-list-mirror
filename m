From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 04:04:41 -0500
Message-ID: <CAPig+cSaZv9XHO+BezAJxjh-i_LiBfLxhkKr3u=p8V8zCFnjDw@mail.gmail.com>
References: <20160219111941.GA31906@sigill.intra.peff.net>
	<20160219112324.GF9319@sigill.intra.peff.net>
	<CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
	<20160220081010.GA16722@sigill.intra.peff.net>
	<CAPig+cTACku01im72Cd7LxYopwwFaXtKYXkxi53GMrTRyZpFGQ@mail.gmail.com>
	<20160220083426.GA17171@sigill.intra.peff.net>
	<CAPig+cQK15OoNdG0zyCC0eZJ1XeidD7sOU8BggnNN7k=Zi9zdw@mail.gmail.com>
	<20160220085740.GC17171@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 10:04:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX3TA-0003db-4m
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 10:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992867AbcBTJEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 04:04:46 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34193 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992561AbcBTJEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 04:04:43 -0500
Received: by mail-vk0-f52.google.com with SMTP id e185so94141200vkb.1
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 01:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qxrIWDbqE1TmyUuYXYFPsI3rG61KAV8CwkV5i/+8Juk=;
        b=LDXs7HqNh/Pjmui4mp7DG97Ep0kdOqQsXDJaWjd1CA9CNWo0BLsE0hTE5bXd3QQyWK
         Q8N16ebxhIdvfS79pqjk+Mo4QRaCgxL964UJ9sSgUhNJ64M6azYL5xLWWSXwtLoJxPO8
         sfUdprbLVIE2SucrtkFK44/xc7F59D5OtrXYZ8ow721Z5FpwLR8PJrPqpx0o0z90xNNX
         /CTR0z9Yr0zMUFshWEXsSAKPwDrTFT7ndu2++lQUZKGG4iDV9mhAs2iX1ZeR6XZfZ40o
         F5r1PQBHnWpjOoyuzWMBrzd4k30ymmHGRestya7Ur0LflDcpnwpC1L91DaTcYzmms+xB
         Kftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qxrIWDbqE1TmyUuYXYFPsI3rG61KAV8CwkV5i/+8Juk=;
        b=EX2nLTaLoK97trnTCDRx6DcN/JKrOENmMSYlBzpCdGvUZLZ+9O4TRZOFaPxTrnC+sX
         5cpA9/1KFC5aXhn7rcDL8+0bPJa02WIgfUU8EqYrAumJGJFX4lYOUoIzDs2Ml/Xoa1CK
         cA/7mkR/1dsDpihJLU8x4ZyIP84Aq96c5/gPyObQbsxzNGGeWmYMmTQxdyRtpZJHqtX0
         PQByLp0S03Xbu9K4YFbM5IIeXazvWbGSF0ex+ddD6CxTHkZO59RBifMhAeb70qtzXDkb
         moOxtmgHCnKxr7qHHae9MCfbYHDuLupX/QgxGntozEhv1xEG5AmF80Q0YG4VIHYeivu0
         Dv3Q==
X-Gm-Message-State: AG10YOT63E2GD4xZh7iKY8i7hFLNa/4pKMVHgjmpj8xsXwA5o0kaKOZpQzJCLDdI4wBUR/5YhZmRiDwu3DjQEA==
X-Received: by 10.31.164.78 with SMTP id n75mr15276828vke.14.1455959082270;
 Sat, 20 Feb 2016 01:04:42 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 20 Feb 2016 01:04:41 -0800 (PST)
In-Reply-To: <20160220085740.GC17171@sigill.intra.peff.net>
X-Google-Sender-Auth: 2TOqC1Zg9cSQrlmKNEVOBR1Tsbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286775>

On Sat, Feb 20, 2016 at 3:57 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 20, 2016 at 03:39:36AM -0500, Eric Sunshine wrote:
>> I also had made the strbuf_detach() analogy in my response but deleted
>> it before sending; I do think it's a reasonable API template to mirror
>> via new argv_array_detach().
>
> That would look like this, which I think is not too bad (on top of my
> series for now; I'd do the API function as a separate patch at the
> beginning and then use it immediately).

Looks reasonable.

> diff --git a/argv-array.c b/argv-array.c
> index eaed477..5d370fa 100644
> --- a/argv-array.c
> +++ b/argv-array.c
> @@ -74,3 +74,14 @@ void argv_array_clear(struct argv_array *array)
>         }
>         argv_array_init(array);
>  }
> +
> +const char **argv_array_detach(struct argv_array *array)
> +{
> +       if (array->argv == empty_argv)
> +               return xcalloc(1, sizeof(const char *));
> +       else {
> +               const char **ret = array->argv;
> +               argv_array_init(array);
> +               return ret;
> +       }
> +}
> diff --git a/argv-array.h b/argv-array.h
> index a2fa0aa..29056e4 100644
> --- a/argv-array.h
> +++ b/argv-array.h
> @@ -20,5 +20,6 @@ void argv_array_pushl(struct argv_array *, ...);
>  void argv_array_pushv(struct argv_array *, const char **);
>  void argv_array_pop(struct argv_array *);
>  void argv_array_clear(struct argv_array *);
> +const char **argv_array_detach(struct argv_array *);
>
>  #endif /* ARGV_ARRAY_H */
> diff --git a/line-log.c b/line-log.c
> index fa095b9..bbe31ed 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -748,15 +748,17 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
>
>         if (!rev->diffopt.detect_rename) {
>                 struct line_log_data *r;
> -               struct argv_array paths = ARGV_ARRAY_INIT;
> +               struct argv_array array = ARGV_ARRAY_INIT;
> +               const char **paths;
>
>                 for (r = range; r; r = r->next)
> -                       argv_array_push(&paths, r->path);
> +                       argv_array_push(&array, r->path);
> +               paths = argv_array_detach(&array);
> +
>                 parse_pathspec(&rev->diffopt.pathspec, 0,
> -                              PATHSPEC_PREFER_FULL, "", paths.argv);
> -               /* argv strings are now owned by pathspec */
> -               paths.argc = 0;
> -               argv_array_clear(&paths);
> +                              PATHSPEC_PREFER_FULL, "", paths);
> +               /* strings are now owned by pathspec */
> +               free(paths);
>         }
>  }
