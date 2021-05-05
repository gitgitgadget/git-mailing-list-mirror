Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6365C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50016102A
	for <git@archiver.kernel.org>; Wed,  5 May 2021 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhEEPyq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhEEPyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 11:54:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC14C061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 08:53:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id h7so1336535plt.1
        for <git@vger.kernel.org>; Wed, 05 May 2021 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0fHjsiBCFQwX29acPr4zhuw8VBJsJTLQmHw6aW/Ub5Y=;
        b=Eu8WTd2TdjE+aI0xlWUxNbc7EN76jMjnam83ISQqC1EldNE2a5DoeEJ4r+n41FY3/b
         sxSXY3LYL/T+saUpZdRrnx+EwTGwmVIwdIMS0AT2OHndiuCu8bGLQcv2ttlTVZVrBBY+
         nChHn3GZ8laqtIiMNbPCuudeFtNxYWzKxUZR8/fTKmss9MRF4ttgfimg4REy+g7mgDYI
         ZPJvAyJ8aWLIZiUOlhbp0NC+uMq1xao78F9n/y3XQB4mTVVVk8NDRGfFEyYhQXQn/P6P
         rNleoCiWZmiH4FFc6u6gAGYJ20+s+Djabl19hsvX05XpoKFNWXYoH84bA5UewC+727sz
         yZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0fHjsiBCFQwX29acPr4zhuw8VBJsJTLQmHw6aW/Ub5Y=;
        b=csugbEJEe/78Czxhhs3svGrkGLC9UZF07P6KRWoOJ6BGVYaFmBIQwExjoZqRsNjxtX
         uylI826wcI9sW1+f9Db6C/+mkq3FQNBBViQH+Et4oOXBuUVTGE2x98rl2KU8KZ7XijCI
         DMzftCKkyFNx2thJlDG5EPr0Si1+LrgQOc7y6ELcGIDyv+ov1QOltXmrO5XjBNJ7njfX
         haRcR1RChR8sSVpo+zP98SGZHcDFF9vDcjPoROeJ1GqNpnG0/qJoxRXQoFBFZr+S+YM8
         D8tJPKDctK2E+jla8ubvVPekMH9MeXmhYyT1qHZiodgNdP4dE/L4HauLKLLqG0WtJ0g/
         v1OA==
X-Gm-Message-State: AOAM5337dUWaGzDTJPT5it0q1RaUp3K4iW3jt2p2DEuM338wXrjSjOgD
        L2STx2Y/MB35Bs+utRXBT0fwyqxqTViZxw==
X-Google-Smtp-Source: ABdhPJxDJ2TtnfyXj9b4kQiIGlE8Pv+eHtHxVfdKvLJb7fLuCc1smYxESpa/uxulUKx69Y+1vq4vLA==
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr11464314pjs.112.1620230027991;
        Wed, 05 May 2021 08:53:47 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id y23sm15065810pfb.83.2021.05.05.08.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 08:53:47 -0700 (PDT)
Date:   Wed, 5 May 2021 22:53:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 3/5] mailinfo: skip quoted CR on user's wish
Message-ID: <YJK/ieA7fzB+h01t@danh.dev>
References: <20210421013404.17383-1-congdanhqx@gmail.com>
 <cover.1620148732.git.congdanhqx@gmail.com>
 <3215ea95cf869c8495d95cfd774973c330c14d1d.1620148732.git.congdanhqx@gmail.com>
 <xmqqeeel4y5f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeel4y5f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-05 13:12:12+0900, Junio C Hamano <gitster@pobox.com> wrote:
> > diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
> > index d343f040f5..c776b27515 100644
> > --- a/Documentation/git-mailinfo.txt
> > +++ b/Documentation/git-mailinfo.txt
> > @@ -9,7 +9,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
> > +'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] [--quoted-cr=<action>] <msg> <patch>
> 
> This line is getting really crowded.  Perhaps it is time to do
> 
> 	'git mailinfo' [<options>] <msg> <patch>
> 
> like other Git subcommands with too many options?  Certainly it can
> be done after the dust settles from this entire series as a follow up
> clean-up patch.

Yes, I think it's time to do that clean-up.

> >  static const char mailinfo_usage[] =
> > -	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
> > +	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] [--quoted-cr=<action>] <msg> <patch> < mail >info";
> 
> It is surprising that we haven't switched this to parse_options().
> It of course is outside the scope of this series, but from a cursory
> look of its option parsing loop, it looks like a trivial improvement
> to make.

And given that we also need 1/5 (otherwise, we need a new declaration
for "const char *str"), I think it would be better to turn 1/5 to the
conversion to parse_option.

> > @@ -43,7 +43,11 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
> >  			mi.use_scissors = 0;
> >  		else if (!strcmp(argv[1], "--no-inbody-headers"))
> >  			mi.use_inbody_headers = 0;
> > -		else
> > +		else if (skip_prefix(argv[1], "--quoted-cr=", &str)) {
> > +			mi.quoted_cr = mailinfo_parse_quoted_cr_action(str);
> > +			if (mi.quoted_cr == quoted_cr_invalid_action)
> > +				usage(mailinfo_usage);
> 
> This is not all that helpful, given that mailinfo_usage[] only says
> <action> without saying what the supported values are, and the
> message does not make it clear it was issued while looking at the
> --quoted-cr option.
> 
> At least, something like
> 
> 			if (mi.quoted_cr == quoted_cr_invalid_action)
>                         	die("--quoted-cr=%s: invalid action", str);
> 
> would be more palatable, but I wonder if mailinfo_parse_quoted_cr_action()
> should have an option to die with the list of actions it knows about
> in a message.

I tempted to remove the _invalid_action with the re-roll and always
die when it doesn't understand the actions instead.
Let's see how far I can get with that approach.

-- 
Danh
