From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change
 check_pbase_path() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 19:32:16 +0700
Message-ID: <CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru> <53105995.3010001@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:32:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMcV-0004uQ-Me
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbaB1Mcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:32:48 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:52412 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbaB1Mcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:32:47 -0500
Received: by mail-qa0-f42.google.com with SMTP id k15so568991qaq.29
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7MiJO83Rq/IMoUiCn5hmRH4Gve6tnLab2nyFDPhytDM=;
        b=SfTqOlkjYdsz9b4doqqhmiRo7B32zB3i0Pbv3eciAXKPkQLIYBAHQWICUbJOTft5sS
         bplqowcorFmuKI5OHeU6r9AtJZggSBRMn0YZEXEdKgPipDo/kJnBAGvfP/ltjEKKZzAO
         myaIHSvY0qMnrbBvxZbdfs57a1plYHZ61wnjLMzsf5eAfjIeEQ+AaJP+OVIok3XBTPV6
         mH7bLrTuNZ5K0HOGQBnGq+2NJKgkQZd+XXGTy0J9I+xqMrKdqznEQMUMHtv9PwrsFvmL
         WLRao/2qzjQ1sJgiWwx38NIsZq7kJYbKVFhWAtK0dK4q376ULYCFK0vH9NJWgNoC2K3p
         2xRg==
X-Received: by 10.140.40.5 with SMTP id w5mr2917596qgw.65.1393590766405; Fri,
 28 Feb 2014 04:32:46 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 04:32:16 -0800 (PST)
In-Reply-To: <53105995.3010001@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242948>

On Fri, Feb 28, 2014 at 4:40 PM, Dmitry S. Dolzhenko
<dmitrys.dolzhenko@yandex.ru> wrote:
> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
> ---
>  builtin/pack-objects.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c733379..56a6fc8 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1213,12 +1213,7 @@ static int check_pbase_path(unsigned hash)
>         if (0 <= pos)
>                 return 1;
>         pos = -pos - 1;
> -       if (done_pbase_paths_alloc <= done_pbase_paths_num) {
> -               done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
> -               done_pbase_paths = xrealloc(done_pbase_paths,
> -                                           done_pbase_paths_alloc *
> -                                           sizeof(unsigned));
> -       }
> +       ALLOC_GROW(done_pbase_paths, done_pbase_paths_num + 1, done_pbase_paths_alloc);

Not strictly a rule, but I usually try to keep it within 80 columns,
unless the surrounding code already breaks it.

>         done_pbase_paths_num++;

If you move this up one line, then you don't have to "+ 1" in ALLOC_GROW

>         if (pos < done_pbase_paths_num)
>                 memmove(done_pbase_paths + pos + 1,
> --
> 1.8.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
