Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFDCC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 15:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiHLPQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiHLPQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 11:16:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97785A9B
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:15:25 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id tl27so2564464ejc.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=btwyYQC9gSLYf4GEP68EICW/XGg7lSAxMvrkazY05T4=;
        b=Q8cuyCGJom4zTNkTgreS60ySDm8LYxuJR1k0hPnjO0+K7JLiSA4JE8fQmQNwrNdGht
         mwQyoXsJjY8jbTGlmt+6jJWOwv675TFXekgX+X63YIlbZTnPaqQ5QLqJL0qv4cOyipPc
         m4/VHqX13aIv6I1socvnkSWZdgEr3vO/S/mj8LmmHz5aIDVtGvOBqcXI9uNqHHSb+uQc
         9Xojhyn5DB1LWC/krUnb/phSV17F/Zh9mEL28k5O8uMsam2UsiWsnaau2fZy7/8mIEut
         /QmzMxhGyvE3G8BmhYS+0DGDNoOnsFYNoWG8jLF3QVGMyjbNNGYO22z2SxY81uanZK0Q
         KQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=btwyYQC9gSLYf4GEP68EICW/XGg7lSAxMvrkazY05T4=;
        b=o57baVw9PnFdLr0AgNRWYcIK9G7eEXVHn0JqDWaVh5ybdDXYcTN+ZEYdMYEOyIq0Y5
         OZ27P0ZirT2NBa3zwEPcFN9Vu8uOjWAkjCTOp5kCVrGhmMJSvxjhkFjQ3KL10mWaGdWL
         7s5FiXnKh19VNumpbSc+PF36LHnb8pVlhs5cq6NqR3RkUM4it8TrwDZERHf4fG4/W+4d
         cdlyGyrRm7Q5C2RWL4mX0k8ld6WmOtK2Rqz7H9rJIb6x9I2pI6lG42uxz3R0Gj8gTVQQ
         eY/fqPtp0MkkNWK82uQxltsexh74xeskIQtkuflR3cfnkLb+MDV7a09Diq/wNDuGlu7J
         Warg==
X-Gm-Message-State: ACgBeo153e/yk/cmPfsizG0zRRvBrsBu2SFCbG9w8RXcJGNK0zQc+rDR
        6g5pvQWGpl/iADoiV+tUYqs=
X-Google-Smtp-Source: AA6agR7TtXy3rsp+s50EMMRFN/vM+Idv/Q1iK5JA3CPS80XS51M39H9a2KobqOZmPJPrtvzMvZ5dYg==
X-Received: by 2002:a17:906:ee8e:b0:730:4a24:f311 with SMTP id wt14-20020a170906ee8e00b007304a24f311mr3067286ejb.420.1660317314740;
        Fri, 12 Aug 2022 08:15:14 -0700 (PDT)
Received: from localhost (94-21-58-102.pool.digikabel.hu. [94.21.58.102])
        by smtp.gmail.com with ESMTPSA id c15-20020aa7d60f000000b0043d6ece495asm1480778edr.55.2022.08.12.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:15:14 -0700 (PDT)
Date:   Fri, 12 Aug 2022 17:15:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/20] parse-options: add support for parsing subcommands
Message-ID: <20220812151513.GB3790@szeder.dev>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <20220725123857.2773963-10-szeder.dev@gmail.com>
 <220725.86a68xp7az.gmgdl@evledraar.gmail.com>
 <20220725192947.GB2543@szeder.dev>
 <220725.86wnc1nf6c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220725.86wnc1nf6c.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 25, 2022 at 09:41:52PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> > @@ -206,6 +217,11 @@ struct option {
> >> >  #define OPT_ALIAS(s, l, source_long_name) \
> >> >  	{ OPTION_ALIAS, (s), (l), (source_long_name) }
> >> >  
> >> > +#define OPT_SUBCOMMAND(l, v, fn)      { OPTION_SUBCOMMAND, 0, (l), (v), NULL, \
> >> > +					NULL, 0, NULL, 0, NULL, 0, (fn) }
> >> > +#define OPT_SUBCOMMAND_F(l, v, fn, f) { OPTION_SUBCOMMAND, 0, (l), (v), NULL, \
> >> > +					NULL, (f), NULL, 0, NULL, 0, (fn) }
> >> 
> >> Nit, I know you're carrying forward existing patterns, but since that
> >> all pre-dated designated init perhaps we could just (untested):
> >> 	
> >> 	#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
> >> 		.type = OPTION_SUBCOMMAND, \
> >> 		.long_name = (l), \
> >> 		.value = (v), \
> >> 		.ll_callback = (fn), \
> >> 	}
> >> 	#define OPT_SUBCOMMAND(l, v, fn) OPT_SUBCOMMAND_F((l), (v), (fn), 0)
> >> 
> >> Which IMO is much nicer. I have some patches somewhere to convert these
> >> to saner patterns (I think not designated init, but the X() can be
> >> defined in terms of X_F() like that, but since this is new we can use
> >> designated init all the way...
> >
> > Oh, I love this idea!  But are we there yet?  I remember the weather
> > balloon about designated initializers, but I'm not sure whether we've
> > already made the decision to allow them.
> 
> Yes, we've got a thoroughly hard dependency on that part of C99 for a
> while now, and it's OK to add new ones (especially in cases like these,
> where it makes thigs easier to read).

Good.  I updated this hunk to use designated initializers as you
suggested, because all those unused 0/NULL fields in there are just...
ugly.

> > If we do, then I'm inclined
> > to volunteer to clean up all those OPT_* macros in 'parse-options.h'
> > with designated initializers,

But I'll leave this for later, because it's awfully easy to make a
mistake and assign a macro parameter to the wrong field, and I find
the resulting diff very hard to review.

