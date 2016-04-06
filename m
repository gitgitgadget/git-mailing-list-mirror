From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 6/6] tag: use gpg_verify_function in tag -v call
Date: Wed, 6 Apr 2016 03:09:13 -0400
Message-ID: <CAPig+cS8hc7G7gyivVFNDkpWpGu_sr1YyJUoMYUTWvigxH+U2g@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-7-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 09:09:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anhb8-0006K9-Py
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 09:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759831AbcDFHJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 03:09:21 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34755 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbcDFHJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 03:09:19 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so5971587igc.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=pjlj9U8an/yKsmcwQuDfASGhSpBChvQ7YTh6Vod6z5I=;
        b=r0Q34GnXwy3s4dW9pmxY5YxP3/Iu/uJR021Pnmy5A8MePW3Wo9hG5Wic+FwiNsZULK
         DBZEfgi4XzsgTsAZARbwhTCgnA2V8O2Q4N4u5LUWpVW5poeMR2T9/+kgz0iz2/AXx0dJ
         8X48hYkm0IbyVey+Mme1MrcxqevTUVQXk7fSBSr7IXKAoOi4oxHzmnE33bLKeZ71JtvC
         pYI2yBCNIG9WqAwzIKFyQj2n7EBqhPUBI5y/EbpzukRfdOTCftyw88rByiOJp+mhQdk5
         8RoPz8KpURIuCVrsH7itRsj8ZyOiiIx20evx1jLZ8zbjvX/Kkph2qM9AkpigK4UojyhA
         CMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pjlj9U8an/yKsmcwQuDfASGhSpBChvQ7YTh6Vod6z5I=;
        b=SJToq1FCy8W6rv2YcTCcq8wgXEYVc202y9NpVQ4vLqipfsB+shjDdj+rLenIL4GlxH
         vWpLl10kVC0naI0mAaqlL5rll2Bch69n+kdLB3VhFMxDohNqWzxOGKo8p4o2bd8puCkF
         4D3pXq8TS+/aYqiMo9/JZVfhyXX7idbYezlxacpwYVIo+7T/F2ak9mF1h+Qe3T1ppKkv
         U0hYME21QqplgLW1UqZk6EbHwUZz1DmigbjzVJFXvjM7q5pA6Jmo/TqAdCESFW7wQLqJ
         ecettTFaGJFWP5tcMDfN8y/ZArR56sFXBlMHrnFiaYos+mXrI71HZJFiEGqOHR0tEI5s
         0a7Q==
X-Gm-Message-State: AD7BkJKxcE0rHLGe7rZCi3GAlSXYXBIscVWItFPLNVzqnkcWQhP41hDRANLXzXPWmnE2vbMxDB3IhjnrV8JPRw==
X-Received: by 10.50.143.102 with SMTP id sd6mr15153747igb.73.1459926553449;
 Wed, 06 Apr 2016 00:09:13 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Wed, 6 Apr 2016 00:09:13 -0700 (PDT)
In-Reply-To: <1459872449-7537-7-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: 7HIwNWmnxQ5xboRNiT4uEJhQYdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290831>

On Tue, Apr 5, 2016 at 12:07 PM,  <santiago@nyu.edu> wrote:
> tag: use gpg_verify_function in tag -v call

This is a low-level description of what the patch is doing, but you
normally want the subject to present a high-level overview. Perhaps
something like:

    tag -v: verify directly rather than exec'ing git-verify-tag

> Instead of running the verify-tag plumbing command, we use the
> gpg_verify_tag() function within the verify_tag function to avoid doing
> an additional fork call.

I'm a bit confused about "gpg_verify_tag() function within the
verify_tag function". I *think* you can drop the "within the
verify_tag function" bit.

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  builtin/tag.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 1705c94..398c892 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -104,13 +104,7 @@ static int delete_tag(const char *name, const char *ref,
>  static int verify_tag(const char *name, const char *ref,
>                                 const unsigned char *sha1)
>  {
> -       const char *argv_verify_tag[] = {"verify-tag",
> -                                       "-v", "SHA1_HEX", NULL};
> -       argv_verify_tag[2] = sha1_to_hex(sha1);
> -
> -       if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
> -               return error(_("could not verify the tag '%s'"), name);
> -       return 0;
> +       return gpg_verify_tag(sha1, GPG_VERIFY_VERBOSE);
>  }
>
>  static int do_sign(struct strbuf *buffer)
> --
> 2.8.0
