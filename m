From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] bisect--helper: `bisect_log` shell function in C
Date: Mon, 16 May 2016 03:36:42 -0400
Message-ID: <CAPig+cTfZ1hWXZcx5OLNRRqJ7FkTigizpMB9E1xzv1Tv+8YY2w@mail.gmail.com>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 09:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2D56-0000df-2e
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 09:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbcEPHgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 03:36:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35933 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbcEPHgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 03:36:43 -0400
Received: by mail-io0-f196.google.com with SMTP id k129so24129351iof.3
        for <git@vger.kernel.org>; Mon, 16 May 2016 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=02gs176CMaOZAk9XzMNm+keWNjuoF4cp+QG7g1H1WQs=;
        b=M492xuvO2I4ddAESjR81WwwXZVH+yT6QeRK1TvghUyJY6p2KxwQUOwW1YZC1EZfYzz
         22cqbFmlLdLJ2ntqdJCbeBnN6sYjyFK2IlImocnw7yH4WWOyBd9qOXX7N1v9gSy/mWSe
         MljmDx9JXBgjOtJ4gMk0qL51+lrs4O3HO69sU92FatO6qK7I+mMmBsfAsu2x7gwKFp8K
         Rg7w/VfIM6fgFu4KgPMBJ7O+Xfbj06adxiRZ/nbo+f+XJOcDTKTnvCVHaxLZbS1AMr11
         ehDSgt5xSCw1gBQsjFMcZowhD8raq9GcAi99SwYQaZSx2kEMFIIPja+vLouTVjqbD9dp
         bXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=02gs176CMaOZAk9XzMNm+keWNjuoF4cp+QG7g1H1WQs=;
        b=cnDS+Tc6S0I4p1P/h95RDZiYrNWeFnwCTsF8ZsDwvsDnQL42klFpBTlIhqWI/DIAdc
         95RB4ordChYHJ8nsYF63IwVnVeC73D9DhvxqgjAKsoOQiSF7nW+2Ca5DphhVwC+TyKZz
         wW5ZZMy8er1sb+bfjvqAJNTyxAM92oeH12LrhCuIiKOLlnLlQFURA3JrNG7n1j9UL9Cj
         +lRCLobeRXyt54TsGY8pWYq5PtzuXarXR6QEJRfjaLMMdUf5b7rOYVzSOC46WYzf3luW
         Nh6o8n2Tdc+vy9GE+/SiDtxurobRHQw/sVY9vo051OGgDkVcL1zoZT83Y1A0YHvE4N58
         ZUPA==
X-Gm-Message-State: AOPr4FUZX+z5oy708Lg1DtLOU/z0/ddUY+iMT5Q7hwqyhhbOqJspm/IOpeXwEB8rCFFSY8iCutSzB9JTDhNyGw==
X-Received: by 10.36.69.156 with SMTP id c28mr7775317itd.84.1463384202197;
 Mon, 16 May 2016 00:36:42 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 16 May 2016 00:36:42 -0700 (PDT)
In-Reply-To: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
X-Google-Sender-Auth: mEPU51upoRLeham7lLYRByreNfc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294729>

On Fri, May 13, 2016 at 4:02 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> bisect--helper: `bisect_log` shell function in C

Do you need to insert "rewrite" or "reimplement" in the subject?

> Reimplement the `bisect_log` shell function in C and add a
> `--bisect-log` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
>
> Using `--bisect-log` subcommand is a temporary measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other method.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> @@ -79,11 +80,26 @@ int write_terms(const char *bad, const char *good)
> +int bisect_log(void)

s/^/static/

> +{
> +       struct strbuf buf = STRBUF_INIT;
> +
> +       if (strbuf_read_file(&buf, ".git/BISECT_LOG", 256) < 0)

As mentioned in my review of the "write-terms" rewrite, hardcoding
".git/" here is wrong for a variety of reasons. See get_git_dir(),
get_git_common_dir(), etc. in cache.h instead.

> +               return error(_("We are not bisecting."));
> +
> +       printf("%s", buf.buf);
> +       strbuf_release(&buf);
> +
> +       return 0;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
> @@ -109,6 +127,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                 if (argc != 2)
>                         die(_("--write-terms requires two arguments"));
>                 return write_terms(argv[0], argv[1]);
> +       case BISECT_LOG:

Shouldn't you be die()ing here with an appropriate error message if
argc is not 0?

> +               return bisect_log();
>         default:
>                 die("BUG: unknown subcommand '%d'", cmdmode);
>         }
