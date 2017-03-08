Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36E7202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 18:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbdCHSk3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 13:40:29 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36574 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753776AbdCHSk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 13:40:27 -0500
Received: by mail-pg0-f41.google.com with SMTP id 187so16101710pgb.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 10:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oYiH1ZncEMFeoraZMu8FcGF7U0KbR8QaEF7hV87cmQc=;
        b=a/K8xourdythBAM3KCpxJde4vlk1PCWMrPdNE3HNDr+s8HQkpzZs5nPAXYQTEA5MU/
         xBCo3bVYwT3uzo/SDyT0ZAyzGJSLMi4Frp20FTb8GXCYgijwN/16as+iaa5bp0IY7V6I
         U0k7D3gCgBc9CZO1hAfctNpNttL61Tp4TD69DlrCFxZSUCPUaXGcniEah3J4BIdcLBD3
         3cZXrTXZVPhgyLmT938WS9MbAFm+Cek5d88lCyZgaquVODSkWxSN9EseQl3mI9GV+PJX
         FiimyErYFNzD0Ni6BpSz1Tg/O9axlVsPN7FSjH+hIKm/+jtcAk4CP1QdG2a/M81x4NW0
         UJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oYiH1ZncEMFeoraZMu8FcGF7U0KbR8QaEF7hV87cmQc=;
        b=mvQe7ph1vEFw4AjdilomjWsOFAT9IAE70l9n96EuWUTfjNSw4i1uugb0mciC4WIGca
         Tz9OCMOh8ZwYQY0sdQZ3DGkp4+dA3dL5rLnEX0pv7yAtwle0kbW8DzCFOfVlJ4QdAPAA
         o4NdG1dJYdehN78vf2ZfiAMcOrLi0nt3ZlhcI7uD+to571F3nCjeXHGljIyfGc59lj7v
         vO4J40sZIzmJixyiRLNjrbIoFwaN81vEEGERnUxC9lT/qXT3F/+pYoHHpLDkZ/Tnbb0s
         oLDi8yAmDmTH1xYpfKmFzlu/VjKuocNh5EN5GQWYVJFrW7tQG2vEH6foG7mMQ8L557nU
         MuOg==
X-Gm-Message-State: AMke39mHnLKyohMM8oynDuJb3hXx9ilS0pnvXdo2kMqVPJ8a5KmUMxQLbbTfOLBtOiMKaH+h
X-Received: by 10.98.192.25 with SMTP id x25mr8991280pff.158.1488998322543;
        Wed, 08 Mar 2017 10:38:42 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:cdd8:47c3:cffc:85d3])
        by smtp.gmail.com with ESMTPSA id q73sm7541166pfa.129.2017.03.08.10.38.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 10:38:41 -0800 (PST)
Date:   Wed, 8 Mar 2017 10:38:40 -0800
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Fix callsites of real_pathdup() that wanted it to
 die on error
Message-ID: <20170308183840.GA130604@google.com>
References: <cover.1488987786.git.johannes.schindelin@gmx.de>
 <0c0abc667d9b8dff299aa61aeb29a7e9e7316b66.1488987786.git.johannes.schindelin@gmx.de>
 <81f1e30b-e0e1-d587-4a4b-4848beffd38c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81f1e30b-e0e1-d587-4a4b-4848beffd38c@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, René Scharfe wrote:
> Am 08.03.2017 um 16:43 schrieb Johannes Schindelin:
> > In 4ac9006f832 (real_path: have callers use real_pathdup and
> > strbuf_realpath, 2016-12-12), we changed the xstrdup(real_path())
> > pattern to use real_pathdup() directly.
> > 
> > The only problem with this change is that real_path() calls
> > strbuf_realpath() with die_on_error = 1 while real_pathdup() calls it
> > with die_on_error = 0. Meaning that in cases where real_path() causes
> > Git to die() with an error message, real_pathdup() is silent and returns
> > NULL instead.
> > 
> > The callers, however, are ill-prepared for that change, as they expect
> > the return value to be non-NULL.
> > 
> > This patch fixes that by extending real_pathdup()'s signature to accept
> > the die_on_error flag and simply pass it through to strbuf_realpath(),
> > and then adjust all callers after a careful audit whether they would
> > handle NULLs well.
> > 
> > Note: this fix not only prevents NULL pointer accesses, but it also
> > reintroduces the error messages that were lost with the change to
> > real_pathdup().
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  abspath.c            |  4 ++--
> >  builtin/init-db.c    |  6 +++---
> >  cache.h              |  2 +-
> >  dir.c                |  4 ++--
> >  environment.c        |  2 +-
> >  setup.c              |  4 ++--
> >  submodule.c          | 10 +++++-----
> >  t/t1501-work-tree.sh |  2 +-
> >  worktree.c           |  2 +-
> >  9 files changed, 18 insertions(+), 18 deletions(-)
> > 
> > diff --git a/abspath.c b/abspath.c
> > index 2f0c26e0e2c..b02e068aa34 100644
> > --- a/abspath.c
> > +++ b/abspath.c
> > @@ -214,12 +214,12 @@ const char *real_path_if_valid(const char *path)
> >  	return strbuf_realpath(&realpath, path, 0);
> >  }
> >  
> > -char *real_pathdup(const char *path)
> > +char *real_pathdup(const char *path, int die_on_error)
> 
> Adding a gentle variant (with the current implementation) and making
> real_pathdup() die on error would be nicer, as it doesn't require
> callers to pass magic flag values.  Most cases use the dying variant,
> so such a patch would have to touch less places:

I agree with Junio and Rene that a gentle version would make the api
slightly nicer (and more consistant with some of the other api's we have
in git).

This is exactly what I should have done back when I originally made the
change.  Sorry for missing this!
> ---
>  abspath.c            | 7 +++++++
>  cache.h              | 1 +
>  setup.c              | 2 +-
>  t/t1501-work-tree.sh | 2 +-
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/abspath.c b/abspath.c
> index 2f0c26e0e2..f3fcff8b1b 100644
> --- a/abspath.c
> +++ b/abspath.c
> @@ -217,6 +217,13 @@ const char *real_path_if_valid(const char *path)
>  char *real_pathdup(const char *path)
>  {
>  	struct strbuf realpath = STRBUF_INIT;
> +	strbuf_realpath(&realpath, path, 1);
> +	return strbuf_detach(&realpath, NULL);
> +}
> +
> +char *real_pathdup_gently(const char *path)
> +{
> +	struct strbuf realpath = STRBUF_INIT;
>  	char *retval = NULL;
>  
>  	if (strbuf_realpath(&realpath, path, 0))
> diff --git a/cache.h b/cache.h
> index 80b6372cf7..9dfbce702e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1154,6 +1154,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
>  const char *real_path(const char *path);
>  const char *real_path_if_valid(const char *path);
>  char *real_pathdup(const char *path);
> +char *real_pathdup_gently(const char *path);
>  const char *absolute_path(const char *path);
>  char *absolute_pathdup(const char *path);
>  const char *remove_leading_path(const char *in, const char *prefix);
> diff --git a/setup.c b/setup.c
> index f14cbcd338..398ea8a913 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -806,7 +806,7 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
>  		/* Keep entry but do not canonicalize it */
>  		return 1;
>  	} else {
> -		char *real_path = real_pathdup(ceil);
> +		char *real_path = real_pathdup_gently(ceil);
>  		if (!real_path) {
>  			return 0;
>  		}
> diff --git a/t/t1501-work-tree.sh b/t/t1501-work-tree.sh
> index 046d9b7909..b06210ec5e 100755
> --- a/t/t1501-work-tree.sh
> +++ b/t/t1501-work-tree.sh
> @@ -423,7 +423,7 @@ test_expect_success '$GIT_WORK_TREE overrides $GIT_DIR/common' '
>  	)
>  '
>  
> -test_expect_failure 'error out gracefully on invalid $GIT_WORK_TREE' '
> +test_expect_success 'error out gracefully on invalid $GIT_WORK_TREE' '
>  	(
>  		GIT_WORK_TREE=/.invalid/work/tree &&
>  		export GIT_WORK_TREE &&
> -- 
> 2.12.0
> 

-- 
Brandon Williams
