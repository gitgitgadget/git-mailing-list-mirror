Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13A020248
	for <e@80x24.org>; Wed,  6 Mar 2019 22:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfCFWJQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 17:09:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51694 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFWJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 17:09:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so7398197wmi.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 14:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71GV9L4lQeqfXAAuTP41f25p9dQzsOeXetYypsjZB5g=;
        b=lqreOBAElu0rVSsq1E9EaQCfxgBnHl2bhMihwJ3CVwkf1dZ/mLkcOq/GT858VeSZy0
         AFV2DA0PmTLCmlxCdWHGBThNYL87CVMdaoDzyJfQGdxMjUaqI85NRm8FQsujSiFc3+XX
         x9of6ZpF/P+GTtZ5/G7IVpUiNgIKKGYKNaSGES2UECv2u/hll8bOAMCTgOBbb0xkhp4L
         ydSncKykFkWV7gd3MJWy6qK6vJMpclfZgAo1g7faBdUH144YY3gRSWeyPSObeR/yK9KF
         ZFSiB2u5KVgV8J0HG5Ne7a/NsRszMnVHrP4I/U+JsMqfbGorCR8Mg3C2OgbtPvp1LBtk
         kVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71GV9L4lQeqfXAAuTP41f25p9dQzsOeXetYypsjZB5g=;
        b=Gv893k3k+VhnoGd2vL6GdOANCp5J+d9G7SbSFzpuS2WiIn7Tdzdu5cEjjLk5qevLvh
         lAPTTX51PZTDX4FhZ20j2gkbTLk50i1LltD/ZR7OLMzMal8XNd7eHm21UvXMNWzFgTKa
         IYI1+9lsOpAxP98DQWtcdexb5hWDB3y2wJE6lD+GeS7BWfB9ocGLmwkthYq0MUFfcm+H
         dIjqAM/jrzYLC9WKSuV8a7EctTot8kVLiOXBTF5emovy44PW2mxdvV2J8F5TTV22JKsH
         C8+ceJ0l0UlO3dqk9v9KCQD0lEeDvGii1BWC5qH9WFSTUlq80rwOa8zuD7x1GJUs66ee
         S44g==
X-Gm-Message-State: APjAAAWYMStiGp2fGQJh0J2igwTiJz3wsXMSGM5PIy3k5uAIVHTZyCFc
        IGm9KckdADp7pPzKyITmqkE=
X-Google-Smtp-Source: APXvYqy6aJElcMBSrzMCNsJKcOo+nX393c4CVVU4GqM/NLCCGfTLnXkdXa8Z+M8vnerY2ALfPDJNbQ==
X-Received: by 2002:a1c:2947:: with SMTP id p68mr3719800wmp.104.1551910153665;
        Wed, 06 Mar 2019 14:09:13 -0800 (PST)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id w10sm4318186wru.5.2019.03.06.14.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 14:09:12 -0800 (PST)
Date:   Wed, 6 Mar 2019 22:09:11 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org,
        johannes.schindelin@gmx.de, gitster@pobox.com
Subject: Re: [BUG] GIT_AUTHOR_NAME was checked before prepare_fallback got
 called (ps/stash-in-c)
Message-ID: <20190306220911.GZ6085@hank.intra.tgummerer.com>
References: <20190306195236.GA22872@dev-l>
 <20190306200049.GA23315@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306200049.GA23315@sigill.intra.peff.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06, Jeff King wrote:
> On Wed, Mar 06, 2019 at 11:52:36AM -0800, Denton Liu wrote:
> 
> > Hello all,
> > 
> > I've been on "jch" for my daily use and I noticed today that git stash
> > isn't working. I managed to debug it down to "ps/stash-in-c".
> > 
> > To reproduce on git.git, it's simply the following:
> > 
> > 	echo // >>dir.c
> > 	git stash
> > 
> > This gives me the following error:
> > 
> > 	$ git stash
> > 	BUG: ident.c:511: GIT_AUTHOR_NAME was checked before prepare_fallback got called
> > 	Aborted (core dumped)
> > 
> > I haven't read through the branch's code so I'm not too familiar with
> > the changes but please let me know if you need any other information or
> > if there's anything I can help with.
> 
> Yeah, it seems like the code from fd5a58477c (ident: add the ability to
> provide a "fallback identity", 2019-02-25) is over-eager:
> 
>   static void set_env_if(const char *key, const char *value, int *given, int bit)
>   {
>         if (*given & bit)
>                 BUG("%s was checked before prepare_fallback got called", key);
> 	...
>   }
> 
>   void prepare_fallback_ident(const char *name, const char *email)
>   {
>         set_env_if("GIT_AUTHOR_NAME", name,
>                    &author_ident_explicitly_given, IDENT_NAME_GIVEN);
> 	...
>   }
> 
> If the ident comes from config, then those bits will be set already,
> even if nobody ever looked at $GIT_AUTHOR_NAME. I think that BUG()
> should actually just be a silent return.

Eugh, I'm gonna go grab a brown paper bag.  This was actually working
correctly before the last update I sent, where I applied Junios
suggestions from [*1*].

Thanks for the report Denton, and thanks for digging into it Peff!

I was a bit puzzled why the test suite didn't catch this, but we only
run it with the environment variables set, not with the user.name and
user.email configs.  Even more awkwardly I did not use builtin stash
since I sent the last iteration.  Sorry about the mess :(

Here's a patch that can either be squashed into 4/27 of the
ps/stash-in-c series, applied on top, or I can re-send the series with
the fix.  Junio, please let me know which way you'd prefer.  

*1*: <xmqq4laxmmti.fsf@gitster-ct.c.googlers.com>

--- >8 ---
Subject: [PATCH] ident: don't require calling prepare_fallback_ident first

In fd5a58477c ("ident: add the ability to provide a "fallback
identity"", 2019-02-25) I made it a requirement to call
prepare_fallback_ident as the first function in the ident API.
However in stash we didn't actually end up following that.

This leads to a BUG if user.email and user.name are set.  It was not
caught in the test suite because we only rely on environment variables
for setting the user name and email instead of the config.

Instead of making it a bug to call other functions in the ident API
first, just return silently if the identity of a user was already set
up.

Reported-by: Denton Liu <liu.denton@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 cache.h          | 1 -
 ident.c          | 4 +---
 t/t3903-stash.sh | 6 ++++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 611e554dea..67e74b7f75 100644
--- a/cache.h
+++ b/cache.h
@@ -1493,7 +1493,6 @@ extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
 /*
  * Prepare an ident to fall back on if the user didn't configure it.
- * Must be called before any other function from the ident API.
  */
 void prepare_fallback_ident(const char *name, const char *email);
 extern void reset_ident_date(void);
diff --git a/ident.c b/ident.c
index f30bd623f0..bce20e8652 100644
--- a/ident.c
+++ b/ident.c
@@ -507,9 +507,7 @@ int git_ident_config(const char *var, const char *value, void *data)
 
 static void set_env_if(const char *key, const char *value, int *given, int bit)
 {
-	if (*given & bit)
-		BUG("%s was checked before prepare_fallback got called", key);
-	if (getenv(key))
+	if ((*given & bit) || getenv(key))
 		return; /* nothing to do */
 	setenv(key, value, 0);
 	*given |= bit;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 7dfa3a8038..97cc71fbaf 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1164,6 +1164,12 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
+test_expect_success 'stash with user.name and user.email set works' '
+	test_config user.name "A U Thor" &&
+	test_config user.email "a.u@thor" &&
+	git stash
+'
+
 test_expect_success 'stash works when user.name and user.email are not set' '
 	git reset &&
 	>1 &&
-- 
2.20.1.32.g82735acce8.dirty

