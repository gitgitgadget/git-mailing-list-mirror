Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF646C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 02:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiC3C51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 22:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiC3C5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 22:57:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876A5B6C
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:55:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z6so23350062iot.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 19:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x3pOPGEF7DaAynrWQUN6aitKjQpCFkzw0xiag5At9Xk=;
        b=yLBbcXXu64frvMvDqCN+LdEmGsH+jrY/KPenguxhTyo4wDvNIQvVUGxJGrkMosOpH/
         V4+BSZssn2mMQaG/BNcGxrlb7/OUbizCyztDjCzzIGoW8A49EVcWr8CLG9bU3g1Woa9f
         wvfLCJUQ8iJtmVowe1PYmKA1IK4HHM6m33ohBVv5EqTgNz0Kid+hmhfmpCqoKNHEVxao
         vNxQjaDqUQoJXVNwo1BRfCJ2SOThQ0H1yDdafDzHAc+1na6mIrADDCVQzPxMR0wIKfg5
         ZvuFeV2bazhtp8JAFSk4ZQNN7hbc46igqnBLUNfIeKwlL5Igb/VrPVpLQocQRkJWGsHQ
         r7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3pOPGEF7DaAynrWQUN6aitKjQpCFkzw0xiag5At9Xk=;
        b=LFvTi5ph7hndlbVkA/Mz9wFaqGzXECO8U2mqqJ5lIjmx/+YJaqzBLSyuKiOCZEHt+a
         XyTxB2/c1I8zhgx+J1CLiXpDcPUlHBMWoUZtVEfomYyMyFsYh+dn7JT8LJic8KeKoDwC
         Y/p+fHijgH6Cg3+FnN5id2RCDNZh1msVm9yEa+6gGrwhSQ/8AwdHY6PhMhwzgXfw6Bc3
         4f7bXNvcK641iH6wssoZPjKlogMLZaW7B3WgmkRGmP81ogdgD+O0q303id4U0uJx413M
         gvq9yKZdoktLVgTv2axD1/0+ZwL1ghBwm0w20a2BPYLdImCzw5zXuhwcW4Xo9jF6AEvL
         Z9SQ==
X-Gm-Message-State: AOAM533kvFu0LJ+uUOYgzB7tTHgSljFmKqUaLuhhN26Si0U7EMb2jHzq
        Fi4e2nigb6eSw2m3h2aizfEc5w==
X-Google-Smtp-Source: ABdhPJwL1QAHHxfF+hlV891+U0FtIeCQDENp6ZWq4P7XLYH69YNmrj2ygyhr+a5DQTIN6Fq5Rk05bA==
X-Received: by 2002:a05:6638:d16:b0:323:63cd:c144 with SMTP id q22-20020a0566380d1600b0032363cdc144mr8842730jaj.76.1648608940864;
        Tue, 29 Mar 2022 19:55:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f2-20020a056e020b4200b002c805b9b4c4sm10426322ilu.16.2022.03.29.19.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 19:55:40 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:55:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 2/3] pack-bitmap.c: add "break" statement in
 "open_pack_bitmap()"
Message-ID: <YkPGq0mDL4NG6D1o@nand.local>
References: <YjzAbSJfuu06smnD@nand.local>
 <20220329024949.62091-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220329024949.62091-1-dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 10:49:49AM +0800, Teng Long wrote:
> Yeah, the condition and "warning" make it clear to me which is if
> already exists a bitmap of the pack or MIDX is ready, we will give
> warnings and just let it fail (return -1 means a return of NULL in
> "prepare_bitmap_git()", and will then die() in usage cases I found).
>
> In addition of above, I had a question that why we need
> "bitmap_git->midx" in the condition? Because here in
> "open_pack_bitmap_1()" we intent to open the non-midx-bitmap and it's
> after we deal with "open_midx_bitmap()" in "open_bitmap()":

You're right; open_pack_bitmap_1() doesn't need to care about whether or
not bitmap_git->midx is or isn't non-NULL, since:

  - if we did open a MIDX bitmap (which we will always attempt first
    before trying to open single-pack bitmaps), then we won't even
    bother to call open_pack_bitmap() at all.

  - if we _do_ end up within open_pack_bitmap_1(), then we _know_ that
    no MIDX bitmap could be found/opened, so there is no need to check
    in that case, either.

So I think we realistically could do something like:

--- 8< ---

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 97909d48da..6e7c89826d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -387,3 +387,3 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git

-	if (bitmap_git->pack || bitmap_git->midx) {
+	if (bitmap_git->pack) {
 		/* ignore extra bitmap file; we can only handle one */

--- >8 ---

...but having the conditional there from the pre-image doesn't hurt,
either, and it makes the error clearer in case of an accidental
regression where we start looking for single-pack bitmaps after
successfully opening a multi-pack one.

> static int open_bitmap(struct repository *r,
>               struct bitmap_index *bitmap_git)
> {
> 	assert(!bitmap_git->map);
>
> 	if (!open_midx_bitmap(r, bitmap_git))
> 	   return 0;
> 	   return open_pack_bitmap(r, bitmap_git);
> }
>
> So if I understood correct, maybe we can made condition of "bitmap_git->midx" a little
> earlier so that we can avoid to open every packfile,  maybe it's like:
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 9c666cdb8b..38f53b8f1c 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -483,11 +483,12 @@ static int open_pack_bitmap(struct repository *r,
>
>         assert(!bitmap_git->map);
>
> -       for (p = get_all_packs(r); p; p = p->next) {
> -               if (open_pack_bitmap_1(bitmap_git, p) == 0)
> -                       ret = 0;
> +       if (!bitmap_git->midx) {
> +               for (p = get_all_packs(r); p; p = p->next) {
> +                       if (open_pack_bitmap_1(bitmap_git, p) == 0)
> +                               ret = 0;
> +               }
>         }
> -
>         return ret;
>  }

This shouldn't be necessary, since we don't bother calling
open_pack_bitmap() at all if open_midx_bitmap() returns success. In
other words, based on the way that open_bitmap() (which is the caller
for both of these functions) is written, we know that once we're in
open_pack_bitmap(), that `bitmap_git->midx` is definitely NULL, which
makes this change a noop.

Thanks,
Taylor
