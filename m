Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F75BC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 23:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B19620673
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 23:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPRt5KVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBJX5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:57:00 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35239 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbgBJX5A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 18:57:00 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so2555152edv.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 15:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYpjgxdwdQwQGaDTs191uWLDHE03JiWQpIOYx9zmEl0=;
        b=MPRt5KVq0bSsSE3a4/z6emEOxfTk2jdj2eo5jEjERVhIOCvnmK7ca2GL9Vy/PAwD2i
         fjweM8mgMoKRLlLj5P8RMxKi9iGskvdzJOGJu4kWw4qw8UJbhrkUIPH93N30XHNZgoOM
         PIxZN7Ry/NneTMldun73AqV4mv9/3brWKhUMC5/5+TVnyu9DGHcqlNKALit7upFxQFlJ
         wnZkNSIefSJDWdZsBglw99XxaQU/Ko+79d1fbvbpQczmcyzxbmslhEKMZ74sneb4uQBA
         wM4uIQFa8axz5EusQroPuWeQcJ6OYF8MWQnHcgwSBbcf28fmdQ4dWVim31aZ8w66dVpy
         Fw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYpjgxdwdQwQGaDTs191uWLDHE03JiWQpIOYx9zmEl0=;
        b=F28uOxXD8FarvNnn+y5S41O1umAA/iOgp/HCspC7ogEC7P6dLVtb1RMX7w+vP9NiBy
         ihabC/D+cjbCNQrV7n91FKUrFh4qpYJ7YYfTMzOcmyfDIhJ1PxPofK5jJ2hmP0HJQXwN
         /XblUWXKi7LGdVLCQxsJ5qunCgajZmEYAzA+dfDQWiNcPFf1Hj9svHFZsLhdoyIB8K10
         lkvMGUEwvBBM07fn5/69ifwptTycoOveFuAJd6U/qlCLdrVlmb4BRJuIe80UMr1qOfC1
         MBbQ6U3uYeMOHo8y4cAadmE877c9kD2bfv89R10Zk0glnaEZC1DZs9BYuDucQlyFeE1n
         4qWw==
X-Gm-Message-State: APjAAAWr0zaZuHplYpxk5ReoPiGhb4OHYjU/U49Q3I0mbkinYjACtLCS
        98dAhPCGM+7OmVb+ZvLwr1AJcChbbmf7fSE60YQY9nH5rNA=
X-Google-Smtp-Source: APXvYqzV43syv3Et/hXuIWccvjo8KBez63CVpY5UKiWcemgFr0gv2XGlFryA5hPhSNiRT7qI/6AWNBL7mlYGj/jy2L4=
X-Received: by 2002:a50:ce56:: with SMTP id k22mr3438662edj.34.1581379017987;
 Mon, 10 Feb 2020 15:56:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com> <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
In-Reply-To: <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Tue, 11 Feb 2020 12:56:46 +1300
Message-ID: <CACg5j27SyHsc0soh_MUJHtAowjGxQ5e5ZBoXsDKfXCV2OMUpTQ@mail.gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 3:38 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/10/2020 12:04 AM, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Add a new advise_ng function that can check the visibility of advice
> > messages before printing.
> >
> > Currently it's very easy for the callers to miss checking the
> > visibility step. Also, it makes more sense for this step to be handled
> > by the advice library.
>
> This makes the advice API much easier and its uses much cleaner. Thanks!
>
> > Also change the advise call in tag library from advise() to advise_ng()
> > to construct an example of the usage of the new API.
>
> This is a good example case.
>
> > +static const char turn_off_instructions[] =
> > +N_("\n"
> > +"Turn this message off by running\n"
> > +"\"git config %s false\"");
>
> I have mixed feelings on the use of these instructions. Perhaps at
> minimum the addition of these instructions could be left to a
> separate patch than the creation of advise_ng().
>
> My biggest concern is that this adds unexpected noise to users who
> want the advice to stay. I'm calling attention to it, because this
> part isn't a simple refactor like the rest of the patch.
>
> If it _does_ stay, then I recommend condensing the message to
> a single line. For example:
>
>         Disable this message with "git config %d false"
>

I agree with you, I had mixed feelings about it too when suggested on
a previous patch [2].
But then I realized that it's hard for the user to find the right
config variable to turn off from the doc only.
So I like the compromise of condensing it to a single line.

> > +     if(value)
> > +     {
>
> Style: spacing, and opening braces are on the same line as the if:
>
>         if (value) {
>
> But also, this method would be simpler if the opposite case was
> an early return:
>
>         if (!value)
>                 return;
> Then the rest could have one less indentation.

Agree

> This loop looks like it was copied from advise(). Perhaps we could
> re-use that code better by creating a new vadvise() method that
> takes a va_list, and have advise() and advise_ng() call it instead?
> I include a patch at the end of this method that does this conversion.
> (Feel free to incorporate it into your next version, if you want, but
> be sure to add your sign-off.) Then, your advise_ng() can call these:
>
>         vadvise(advice, params);
>         advise(turn_off_instructions, key);
>
> removing the need to re-implement the for loop.

My intention was to replace advise() by advise_ng(), so I didn't mind
a temp code repetition during the transition phase.
But as it seems like some folks would rather keep both, then yes of
course a vadvise() function is the way to go, thanks.

> > diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
> > new file mode 100644
> > index 0000000000..b6ec90fd18
> > --- /dev/null
> > +++ b/t/helper/test-advise.c
> > @@ -0,0 +1,15 @@
> > +#include "test-tool.h"
> > +#include "cache.h"
> > +#include "advice.h"
> > +
> > +int cmd__advise_ng(int argc, const char **argv)
> > +{
> > +     if (!argv[1] || !argv[2])
> > +     die("usage: %s <key> <advice>", argv[0]);
> > +
> > +     setup_git_directory();
> > +
> > +     advise_ng(argv[1], argv[2]);
> > +
> > +     return 0;
> > +}
>
> I definitely tend to recommend more tests than most, but perhaps this
> unit test is overkill? You demonstrate a good test below using a real
> Git command, which should be sufficient. If the "turn this message off"
> part gets removed, then you will still have coverage of your method.
> It just won't require a test change because it would not modify behavior.
>

I see your point but I wanted to make sure advise_ng honors the config
variable using tests 2 & 3 in `t0018-advice.sh`
and `t7004-tag.sh` didn't seem like a good place to add these tests.

> > diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> > index 6db92bd3ba..b7c8d41899 100755
> > --- a/t/t7004-tag.sh
> > +++ b/t/t7004-tag.sh
> > @@ -1726,6 +1726,8 @@ test_expect_success 'recursive tagging should give advice' '
> >       hint: already a tag. If you meant to tag the object that it points to, use:
> >       hint: |
> >       hint:   git tag -f nested annotated-v4.0^{}
> > +     hint: Turn this message off by running
> > +     hint: "git config advice.nestedTag false"
> >       EOF
> >       git tag -m nested nested annotated-v4.0 2>actual &&
> >       test_i18ncmp expect actual
> >
> > base-commit: c7a62075917b3340f908093f63f1161c44ed1475
>
> Thanks,
> -Stolee
>
> -->8--
>
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Mon, 10 Feb 2020 09:33:20 -0500
> Subject: [PATCH] advice: extract vadvise() from advise()
>
> In preparation for a new advice method, extract a version of advise()
> that uses an explict 'va_list' parameter. Call it from advise() for a
> functionally equivalent version.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  advice.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/advice.c b/advice.c
> index 249c60dcf3..fd836332da 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -96,15 +96,12 @@ static struct {
>         { "pushNonFastForward", &advice_push_update_rejected }
>  };
>
> -void advise(const char *advice, ...)
> +static void vadvise(const char *advice, va_list params)
>  {
>         struct strbuf buf = STRBUF_INIT;
> -       va_list params;
>         const char *cp, *np;
>
> -       va_start(params, advice);
>         strbuf_vaddf(&buf, advice, params);
> -       va_end(params);
>
>         for (cp = buf.buf; *cp; cp = np) {
>                 np = strchrnul(cp, '\n');
> @@ -118,6 +115,14 @@ void advise(const char *advice, ...)
>         strbuf_release(&buf);
>  }
>
> +void advise(const char *advice, ...)
> +{
> +       va_list params;
> +       va_start(params, advice);
> +       vadvise(advice, params);
> +       va_end(params);
> +}
> +
>  int git_default_advice_config(const char *var, const char *value)
>  {
>         const char *k, *slot_name;
> --
> 2.25.0.vfs.1.1.1.g9906319d24.dirty
>
>
>

[2] https://lore.kernel.org/git/CACg5j26DEXuxwqRYHi5UOBUpRwsu_2A9LwgyKq4qB9wxqasD7g@mail.gmail.com/
