From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] introduce "preciousObjects" repository extension
Date: Tue, 23 Jun 2015 18:14:22 +0700
Message-ID: <CACsJy8AR_vZLAAKf4P+aEtKu1u35N8kAYtYLNOg55ET8DWeZUA@mail.gmail.com>
References: <20150623105042.GA10888@peff.net> <20150623105411.GB12518@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 13:14:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7MAM-0005qo-2M
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 13:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbbFWLOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 07:14:54 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33610 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbFWLOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 07:14:53 -0400
Received: by igbqq3 with SMTP id qq3so85744324igb.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 04:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0FtLYaAhcBKkjmjMmMOVXO5wtyd6CEZisGAvaCOIBgU=;
        b=vdcQsob0mHCqpxMk8qDdStokCoWyQl/95f7GeuVKcWKYe4lzNECgbvBORSY1Q7IFIH
         ekof7pleoSYlpKqUe7iyUtPUcCM/llzdMCeoZBr0ruUtbx5QG53k4oXjnLVtFLctAOqM
         tC6q3qdwBGXAI6xbLt5cNMnsL+jzKYE0TeuhGrdxzhj4NusLTEQ6r7RVwoNXuX9DF+4L
         hOFDXpJ/AaO5fyBTnzHc6rWsaN6OnP18pSKgdj3rZWxdC/2YWeD3QdwYvubC2zOYh6YQ
         SzSOnS7AJgN9oMt6W72zu9+S4SVKjpg66Eh0TNTtFmChvgIj/yCwO5rmvYXeGqChiWHd
         BNLA==
X-Received: by 10.50.4.66 with SMTP id i2mr1457505igi.40.1435058092082; Tue,
 23 Jun 2015 04:14:52 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Tue, 23 Jun 2015 04:14:22 -0700 (PDT)
In-Reply-To: <20150623105411.GB12518@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272452>

On Tue, Jun 23, 2015 at 5:54 PM, Jeff King <peff@peff.net> wrote:
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 0c73246..fc0c8e8 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -218,6 +218,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>                 return 0;
>         }
>
> +       if (repository_format_precious_objects)
> +               die("cannot prune in a precious-objects repo");
> +
>         while (argc--) {
>                 unsigned char sha1[20];
>                 const char *name = *argv++;
> diff --git a/builtin/repack.c b/builtin/repack.c
> index af7340c..8ae7fe5 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -193,6 +193,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, builtin_repack_options,
>                                 git_repack_usage, 0);
>
> +       if (delete_redundant && repository_format_precious_objects)
> +               die("cannot repack in a precious-objects repo");
> +
>         if (pack_kept_objects < 0)
>                 pack_kept_objects = write_bitmaps;
>

I know both commands have translatable strings that are not marked
with _(). But if you reroll, maybe you could add _() for these new
strings. It's even better if you mark all others in these commands
too, if you have time.
-- 
Duy
