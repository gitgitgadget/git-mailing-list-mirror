Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B881F462
	for <e@80x24.org>; Tue, 30 Jul 2019 22:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfG3W45 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 30 Jul 2019 18:56:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33191 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfG3W44 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 18:56:56 -0400
Received: by mail-vs1-f65.google.com with SMTP id m8so44903300vsj.0
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 15:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PIQpdFifglKCo+pFenTAiBcz/jthmHJajQCvSAHspFk=;
        b=NHT50mBigH8PN1dlY2auHJ1JzW34G/481XS0yHYMwZniBSxo/aULGoADi6/CbI5hg9
         sNJK/B+I2a5W+KredDs/s6rN+vjdjJQ7bMJ2RBQwpkEKIGmaFytiEBb2eBX+tRvry0bp
         1Vz+SpJOOyOkPOCyH8H4Qkln0sL2skHeMbc1md3ilWtOjiEgPBqv/HLsP+PNooxbMfu2
         8PFRMFZzDeU3zaMqRZrfRE/OnB/861lm2LvWRi2hhehbO8VMqfKbCwOh0C0LLb9J7nj8
         1DG5eAGf7mRYb+SrCJDYcQx++5fqDzOrHUoda32k3bSEVRDP/HzT45Ie12ywQl2oGA9N
         /p0w==
X-Gm-Message-State: APjAAAXmOaB/IPPAbtqOifi72Q4zohd+6LNyD9ErLS4xUF9CzAcuMGoJ
        0lDBbQWN0AiK+yrP9RDdjq1O4J/6iFUZF9Bf9Uc=
X-Google-Smtp-Source: APXvYqzNtUWhMLShKa0d/VcrLdy0E3LmlFpeNYtkTWg5ZuEXADjqM2OBvNlnkS3OuwAD3qKfA45qNTUZJjnzeLMYv/4=
X-Received: by 2002:a67:2e0e:: with SMTP id u14mr77612141vsu.182.1564527414561;
 Tue, 30 Jul 2019 15:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190730203327.30958-1-dima@arista.com> <xmqq5znjrx0h.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5znjrx0h.fsf@gitster-ct.c.googlers.com>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Tue, 30 Jul 2019 15:56:43 -0700
Message-ID: <CANaxB-yygbxt=-sP+cyhR9WhcyEck+Wy=453huwfVNC9+So0BA@mail.gmail.com>
Subject: Re: [PATCHv3] send-email: Ask if a patch should be sent twice
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dmitry Safonov <dima@arista.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 3:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Dmitry Safonov <dima@arista.com> writes:
>
> > I was almost certain that git won't let me send the same patch twice,
>
> Why?  And more importantly, does it matter to readers of this
> message what you thought?

Sounds rude. What matter to readers except author's thoughts? I guess you want
to say that the comment should be in more neutral technical form without
personal pronouns.

>
> > but today I've managed to double-send a directory by a mistake:
> >       git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
> >           --cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`
> >
> > [I haven't noticed that I put the directory twice ^^]
> >
> > Prevent this shipwreck from happening again by asking if a patch
> > is sent multiple times on purpose.
> >
> > link: https://lkml.kernel.org/r/4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com
>
> What does "link:" mean?
>
> > Cc: Andrei Vagin <avagin@openvz.org>
>
> What's the significance for this project to record that this patch
> was CCed to Andrei?
>
> > Suggested-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>
> I think "Helped-by:" is a lot more appropriate, viewing the exchange
> on v2 from the sideline.
>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > ---
>
> > diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> > index d93e5d0f58f0..0441bb1b5d3b 100644
> > --- a/Documentation/git-send-email.txt
> > +++ b/Documentation/git-send-email.txt
> > @@ -421,6 +421,8 @@ have been specified, in which case default to 'compose'.
> >                       ('auto', 'base64', or 'quoted-printable') is used;
> >                       this is due to SMTP limits as described by
> >                       http://www.ietf.org/rfc/rfc5322.txt.
> > +             *       Ask confirmation before sending patches multiple times
> > +                     if the supplied patches set overlaps.
> >  --
> >  +
> >  Default is the value of `sendemail.validate`; if this is not set,
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 5f92c89c1c1b..c1638d06f81d 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -688,6 +688,9 @@ sub is_format_patch_arg {
> >  @files = handle_backup_files(@files);
> >
> >  if ($validate) {
> > +     my %seen;
> > +     my @dupes = grep { $seen{$_}++ } @files;
> > +
> >       foreach my $f (@files) {
> >               unless (-p $f) {
> >                       my $error = validate_patch($f, $target_xfer_encoding);
> > @@ -695,6 +698,17 @@ sub is_format_patch_arg {
> >                                                 $f, $error);
> >               }
>
> This is not a fault of your patch at all, but the two hunks are
> curious.  If "git format-patch" chose to coalesce these two hunks
> into one, the second hunk header can be replaced by
>
>                 $error and die sprintf(__("fatal: ..."),
>
> The end result would be that we will spend the same number of lines
> and we will see more useful information.
>
> >       }
> > +     if (@dupes) {
> > +             printf(__("Patches specified several times: \n"));
> > +             printf(__("%s \n" x @dupes), @dupes);
> > +             $_ = ask(__("Do you want to send those patches several times? Y/n "),
> > +                     default => "y",
> > +                     valid_re => qr/^(?:yes|y|no|n)/i);
> > +             if (/^n/i) {
> > +                     cleanup_compose_files();
> > +                     exit(0);
> > +             }
> > +     }
>
> Perhaps this should be inserted _before_ the "let's examine each
> patchfile and complain" loop.  Otherwise, you'd see this warning
> only after seeing the same "the file has too long a line" error
> on the same patch.
>
> While you are counting with %seen how many times the contents of
> @files appear, perhaps you can also create a list of unique files,
> so that you do not have to call validate_patch() more than once
> for each of them.  It would also allow you to offer another choice
> in the above question "do you want to send them more than once?",
> which may be much more useful than yes/no: "drop duplicates".  If
> you did so, you do not need to swap the order of the checks.  You
> would first count the occurences of each element in @files, then
> call validate_patch() on each of them just once, and after you are
> done, check if the user wants to send duplicates, abort, or dedup.
>
> Perhaps like this:
>
>  if ($validate) {
> +       my (@dupes, %seen, @uniq);
> +
>         foreach my $f (@files) {
> +               if ($seen{$f}) {
> +                       if ($seen{$f} == 1) { push @dupes, $f; }
> +                       next;
> +               }
> +               $seen{$f}++;
> +               push @uniq, $f;
> +       }
> +       foreach my $f (@uniq) {
>                 unless (-p $f) {
>                         my $error = validate_patch(...);
>                 ... the existing loop ...
>         }
> +
> +       if (@dupes) {
> +               ... the new code in your patch ...
>
