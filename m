Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9355BC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590E6206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="0BZJGha5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgA3Hig (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:38:36 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:45013 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgA3Hig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 02:38:36 -0500
Received: by mail-io1-f50.google.com with SMTP id e7so2849830iof.11
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6x6TPIgxjHy/qegavGfzKTeAEvJ+dzBrKDuddSJ3tA=;
        b=0BZJGha5AOkUnYm7+5nHuEZIc3ibVajbDQohsNIKDgHDhxXC45A1N4u9jsD5j2Nkqb
         5aR6OI4qgazlzzf1ga46wYW2VnMx9rmGHGLfntjG6UwRv7cKiSdsqMFk1ZtPr49za7z4
         wTxMyx3BoXJEygg2yMt+NPwu6u1V55GikycBGjBB5Yodm9YcWS+FgxcdLOTo4YvZ6Owx
         7yuTSv2ZPSLQXXyryt+8OfXmz2qEFOi0QGLLoZkEHijtipA8h3KsXSyZseTq7A8Xg1lA
         6eiN6IrBBaarJoTZzE4q2C+TAm01w2po1M5pQc7Cgon5VC5qgtPznWV2miSjvnEgeuMt
         OPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6x6TPIgxjHy/qegavGfzKTeAEvJ+dzBrKDuddSJ3tA=;
        b=YsjpK4m3LG4GGLCqIFmE8Jn3aBSVmHcwUpS6zecqo/l+ekmovaRQlTZ69dSfN3znAk
         eHw584qXKkC0JpwAOokJ9q8CLjcdf4LY9g7wuDy9M2BfHsOsmNwcvOtoYf98twdkpcop
         NPWwDRIMCgGKwH7AEE3/wEmUlKWKD5JtDtBzozrjYv2xEnvLBvWEV36tMzccUhXTRZOl
         bvnrcn4k7qeBpHc44CJhDhWP1FUaSKaEcy6JLM+dGpNugH/s8mc/PJfV9VSrutNoc7bh
         mrYI2giI1ivBjRop9PJo0JPECnW+AjegxkS1usHVoWGKsFgpbFIvKk4qwjXjrL2HXEZH
         S+Wg==
X-Gm-Message-State: APjAAAVVg/geozva7H49m3mNiF29aK5KsV8UoH5HyaavZ5QhXARUhWon
        xqLnEBo8UY4UT9ej2ybKX5R18ss0cZt7Z19wc5T57SBN
X-Google-Smtp-Source: APXvYqx+/+TRzqHZA+j11n7A8i5mgWtddzA9zn3yHSTDvOAFA/GaLqP39nFM3HR+5MBugVCbdcEVUte0GbOHxtCoYAg=
X-Received: by 2002:a6b:dc09:: with SMTP id s9mr2855804ioc.185.1580369915418;
 Wed, 29 Jan 2020 23:38:35 -0800 (PST)
MIME-Version: 1.0
References: <CAGyf7-E==gzsvP-ckK0kwHD+f9pMmLBVpL4y2rC9tqk7ZiuW1g@mail.gmail.com>
 <20200130071102.GA2189233@coredump.intra.peff.net>
In-Reply-To: <20200130071102.GA2189233@coredump.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 29 Jan 2020 23:38:23 -0800
Message-ID: <CAGyf7-HkUV43A79DKiDVvKnW5vuwsFz0KnZKj9bBQYc906VONg@mail.gmail.com>
Subject: Re: packObjectsHook and the git executable
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 29, 2020 at 11:11 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jan 29, 2020 at 05:00:18PM -0800, Bryan Turner wrote:
>
> > In upload-pack.c, when Git invokes the packObjectsHook, it's
> > hard-coded to pass "git". Unless it modifies the PATH environment
> > variable, though, if the script were to invoke the provided command
> > line as-is, it may end up running a different version of Git than the
> > version being used to run upload-pack (or http-backend).
>
> We do modify PATH to put git's exec-path at the start. This happens in
> setup_path(), which is called by the main "git" executable (so "git
> upload-pack" before it hits cmd_upload_pack()).

Thanks, that's a missing piece I'd overlooked (and explains why
everything is written the way it is, to use "git").

>
> Programs which are invoked directly as "git-upload-pack" need to call
> that function on their own (which happens when upload-pack is invoked
> over ssh). But upload-pack and http-backend do that.
>
> > Is there any way the packObjectsHook could be passed the "right" git
> > executable? Or am I missing some surrounding context that means
> > executing "git" is somehow guaranteed to invoke the "right" binary?
> > (Perhaps this same PATH-related caveat applies to other places where
> > Git invokes itself recursively?)
>
> I think all is working as designed, but if you have a reproducible case
> where we run the "wrong" git, I can take a look at it.

I suspect it's a case of a broken Git build. Not that Git is doing
anything wrong, or has any problems with its build, to be clear--I
mean instead that someone ran a local build and didn't set it up
"right". Correct me if I'm wrong but:
- If the GIT_EXEC_PATH environment variable isn't set, Git will use
the path that was compiled in when it was built
- If that Git is installed in a different path (i.e. compiled for
/usr/local but installed in /opt), the compiled-in exec path may not
exist or not contain "git"
- In that case, "git" gets run from wherever it's found in $PATH and
you get whatever version that happens to be

Does something like that seem like it could happen?

Thanks as always for your insights!
Bryan

>
> -Peff
