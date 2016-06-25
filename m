Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848581FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbcFYQcH (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:32:07 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:35159 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbcFYQcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:32:06 -0400
Received: by mail-it0-f48.google.com with SMTP id g127so36839091ith.0
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 09:31:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OG87M7v1biyAJ+GsKQQjSb8iRNBn9ei36pOPaqVEQyQ=;
        b=t7B6FYPXjR3O+n5RjI46OE7/l1QN+sh9KLwUD7ri0tMoaoeiq3YcgbWHMlJ1nhUNSm
         iIILQ4m7tDv97JNUHilsCyXQgYR4JAaP8cxJ4DUz9mrbcvzqTCngcCvkjV8UMlHYXv3g
         Wm2nJqtBAZdfvUBDxFZSSQt4zwsoDf906zv36Rm5+lepJQurvVHMPKonkm92eJJJ4jgo
         QgCBN21VRW5X1MKjMHonYwUA8wHGiVLGCSGreDqT14mKMOFsINW9n3ZEvStZ4nO91PLz
         9Uo9SR3ftkNpArSw84nWsLabQaS+Iag9EkrIEvqrps1FDJJ/XW5+HcBsMkpmFMGjyifo
         7FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OG87M7v1biyAJ+GsKQQjSb8iRNBn9ei36pOPaqVEQyQ=;
        b=MPRtt1sJuAociGC3/Fjabf21QAtyOfVme/eAA4K4FK50sZDH1uqJpOEaucdWxn+kGl
         Ecsvh8L1lRzap5bOeC/LgQueRio2AtKzbwoyL6qbILfwCxD8WttWvyoLwx182gFfHC1R
         RwuWL92fMpvNwTqopIy4K15lOqWcSaFyfAVodnnudMht3f4TUqsNTtRkl6EjG2N+81k7
         K+loe4nJOaRD2/G6+JSpmxvE5jBmqSKdvoEJvtdIuozHttB04v/1xVUUsVC+jM24zjEQ
         mbk+8w8DjBY6MYWRbHOLSr3az+1Q2uQTzz2RtnqvnOt6B3IbZzOeXdlBIuzcY3Mqv4bC
         nHqQ==
X-Gm-Message-State: ALyK8tJ8ZwIT8Xe6Ews2+9rAGsleFnXv1dEgm37RkFVcU4510FQUq8/WdGLywxRtQqk9cTbTh8q2DqB9EehVVQ==
X-Received: by 10.36.84.79 with SMTP id t76mr2788719ita.63.1466872291297; Sat,
 25 Jun 2016 09:31:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 09:31:01 -0700 (PDT)
In-Reply-To: <1463694357-6503-13-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-13-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 18:31:01 +0200
Message-ID: <CACsJy8B3t+ChhgDJJyr+W3PiF2QmavnU19BvQV84w_=4x9QobA@mail.gmail.com>
Subject: Re: [PATCH v12 12/20] update-index: enable/disable watchman support
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> @@ -1149,6 +1152,19 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>                 die("Bug: bad untracked_cache value: %d", untracked_cache);
>         }
>
> +       if (use_watchman > 0) {
> +               the_index.last_update    = xstrdup("");
> +               the_index.cache_changed |= WATCHMAN_CHANGED;
> +#ifndef USE_WATCHMAN
> +               warning("git was built without watchman support -- I'm "
> +                       "adding the extension here, but it probably won't "
> +                       "do you any good.");

_() this string. And maybe rephrase a bit, avoiding "I'm adding", e.g.
"git was built without watchman support, this command probably will
not result in any speedups"

> +#endif
> +       } else if (!use_watchman) {
> +               the_index.last_update    = NULL;
> +               the_index.cache_changed |= WATCHMAN_CHANGED;
> +       }
> +
>         if (active_cache_changed) {
>                 if (newfd < 0) {
>                         if (refresh_args.flags & REFRESH_QUIET)
> --
> 2.4.2.767.g62658d5-twtrsrc
>
-- 
Duy
