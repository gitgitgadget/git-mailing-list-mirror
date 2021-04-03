Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8BFC433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F9461206
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhDCFvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhDCFvc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 01:51:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A61BC0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 22:51:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hq27so9803731ejc.9
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 22:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OLaV5RLtx/TzL1hwxqnzt6rG3IrQ1dfUEb2EQ7EvOFE=;
        b=nEd1vIsPD8YtKbZ4T6Mlp/3bhHS/W8SGy4TXm3k1QK4W3Gffzi3u0XuPKu7mPNp6yf
         CY92gbRduBuq8EiAfLNEtTt9K4a9Qf071NYHn7935IC73vpk+5WkpN2vjOfW4RdRLzYY
         0/O7TmT6bm137bvnp4pbAj42QelP6Zlp0x9jhWHczGw10UU+0J8qjUcZLkJv1sZFG7Nu
         QSea/X12UnteW5H8fJC5YbApV2dasAiVzh5gKzmTqBTwkCUz6AR885fH/wz+E9FlLgyO
         AeuoybkMXhqFJrqoTfHfZZZEO2Ag5+D34pw+rNJzl+/2KoF1p+ei2PJof9XLeD1gPdov
         Gy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OLaV5RLtx/TzL1hwxqnzt6rG3IrQ1dfUEb2EQ7EvOFE=;
        b=I2tnACh/xBXyu61NniS04vx0fgPiXWdXpugv3aSJdFlrhYFLCm2akq2ybh1yqwxrgX
         QrcDvudJwhdjCh6Rgjy8ZZvK9p5XnjgP/vwPqQF8J9NPTj1jVBQ+IhYH2+/FfSOaipyC
         hGux4DzVhk3789+vqlduAQhbVVUitmHNIMsivWHvsZmVpvGe/YdSxgUaUV80VPbDmGhM
         7jxqehYRKXUs6hzfiHrcYBCxDGY0lqd4rQuhVWYjFIYW/+RPUrVcCN62Lc0Qu2bskiuD
         FpwzqP8w43TPaN+SN6boRLr2OFqgclktmmsg7l3lXJuzWaHXkW9ccTg+ocdixTqlrpC0
         7LPw==
X-Gm-Message-State: AOAM532l+WKUCSLvQ1J2DCUvlug5d9B4wJQhy/ElyITIUMgx4GEtTss2
        GV35p1ZnUTOfRTyiy+9Oxn++AKAIuZ78V3KUPkQNpuRnsYWxPg==
X-Google-Smtp-Source: ABdhPJxqEPQpg72pEx+t2XNdp9/hp7TXq6Nk0TRfHhi273cqRA18OvTruzpzi75rDSu1cicsR8HdU5LTwZf4FyKM3JE=
X-Received: by 2002:a17:907:68a:: with SMTP id wn10mr17835240ejb.551.1617429088791;
 Fri, 02 Apr 2021 22:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
In-Reply-To: <xmqqim544dl4.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 3 Apr 2021 07:51:17 +0200
Message-ID: <CAP8UFD0AZWey045qK=9h8nVCVwK09s=t-=Z7OVBpvr4LAvSLUw@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 2, 2021 at 10:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> > +trailer.<token>.cmd::
> > +     The command specified by this configuration variable is run
> > +     with a single parameter, which is the <value> part of an

I prefer "argument" over "parameter". In the next paragraph you use
"argument" (in "as if a special '<token>=<value>' argument"), so it
would be more consistent and easier to read if "argument" was used
here too.

> > +     existing trailer with the same <token>.

It would be better to say something like "which is the <value> part of
a `--trailer <token>=<value>` on the command line". (Yeah, the
existing doc might be bad about this.)

Also it might be better to explicitly say that the command is run once
for each `--trailer <token>=<value>` on the command line with the same
<token>.

> > The output from the
> > +     command is then used as the value for the <token> in the
> > +     resulting trailer.
> > ++
> > +When this option is specified, If there is no trailer with same <token>,

As above, it's better to be more explicit and say something like "if
there is no `--trailer <token>=<value>` with the same <token> on the
command line". That's because there could already be such trailers in
the input file, but those don't trigger the command.

Anyway see below as you might need to change the whole paragraph anyway.

> s/If/if/ (downcase).
>
> > +the behavior is as if a special '<token>=<value>' argument were added at
> > +the beginning of the command, <value> will be passed to the user's
> > +command as an empty value.

The problem with this is that people could understand that the command
will run with an empty argument only if there is no trailer with the
same <token>. The current situation though is that the command will
run once with an empty argument whether there are `--trailer
<token>=<value>` options with the same <token> passed on the command
line or not.

> Do the two occurrences of the word "command" in the sentence refer
> to different things?  I do not think this is an existing problem
> inherited from the original, but as we are trying to improve the
> description, I wonder if we can clarify them a bit.
>
>         ... as if a '<token>=<value>' argument were added at the
>         beginning of the "git interpret-trailers" command, the
>         command specified by this configuration variable will be
>         called with an empty string as the argument.
>
> is my attempt,

It looks better to me.

> but I am not still sure what that "as if" part is
> trying to say.  Does it mean with
>
>         [trailer "Foo"] cmd = foo-cmd
>
> and the 'input-file' does not have "Foo: <some existing value>"
> trailer in it, the command "git interpret-trailers input-file"
> would behave as if this command was run
>
>         $ Foo= git interpret-trailers input-file

I would say it would behave as if:

$ git interpret-trailers --trailer Foo= input-file

> (as there is no <value>, I am not sure what <value> is used when
> <token>=<value> is prefixed to the command)?

Nothing is done when such things are prefixed to the command.

> Puzzled and confused utterly am I...  Help, Christian?

I hope the above helps.

> >  If some '<token>=<value>' arguments are also passed on the command
> >  line, when a 'trailer.<token>.command' is configured, the command will
> >  also be executed for each of these arguments. And the <value> part of
>
> This talks about 'trailer.<token>.command'.  Should this be changed
> to '.cmd'?

I think so.

> Or does everything after "When this option is specified, if there is
> no trailer with ..." apply to both the old .command and new .cmd?
> If so, that was not clear at all---we'd need to clarify this part.

Yeah, in the doc about ".command" I think we should say that it
behaves in a similar way as ".cmd" except for the $ARG vs $1 issue.

> > -these arguments, if any, will be used to replace the `$ARG` string in
> > -the command.
> > +these arguments, if any, will be passed to the command as first parameter.

s/as first parameter/as its first argument/
