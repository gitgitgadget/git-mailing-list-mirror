Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A149DC433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D16A239A4
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 14:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbhAUODw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 09:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbhAUODJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 09:03:09 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02AC061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 06:02:29 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id k9so511001oop.6
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIQ9ftI7Xu0eB6wuUfbjpZWpOkmF9eiFhoKKb9RaOcM=;
        b=Hq+OTSa8VwfImdigbNAQ3u6e8SNM43OKTouk+AkWjcsgnvG+8i6xggV/JpyiZ1SEOu
         UyM20yPXOQhX/HZHz8v6Z9TnH2pjKnv+GlE0zj83nIEBv48ckWrZoCxmVXEXAU0sd0Je
         6ecmV/wDS9/HJ8qW6jTM70CJsK97wB0OD3X1mKRFpC9m3YgN1ATQS34UcGhL3Cr6D5ek
         MYkYufMqO6gjtv8y31LOtHFnHjc09uOhk45QDnR8NJ4mKzdVaxnfTc3VrfGQJ/u0ZksA
         cyXmtTePSCZ1bg0wSvUf4f4M1Tug6ftLtp2HH2oR/7CMT+5p0ErTG/bxwDocJpVDpJcb
         uepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIQ9ftI7Xu0eB6wuUfbjpZWpOkmF9eiFhoKKb9RaOcM=;
        b=aCBgRacH8GnCNBkVAk/FPObRRg9uQAW9T98VwUn0oDUTLa8pBprBCydyr9a1OdGIe4
         +SRRkEbLh6nD5Jx3S+1ChhkjQmoGGfjlNNtXY4idAt+6FTQd75acwdUjSBqLFSnL16XH
         uqqObwPyhyLMaxgeX2W6QyMOn5Az1ekyYE+d/kR7t483UCgN/Vk1jj1xXunGpazXt2kT
         XKZbOcQeILSSNUTDYx9chgg4bC6PImvZI9BNfXNrvKIlFezYLV8K5bKNsWVC7ZISC73U
         BDnotDtx51X1ENQT7PMam8zwzxt3nNb4c/StYfN1jJTeISzkc5ZEb6GNfgEouqxpeAkd
         qdkw==
X-Gm-Message-State: AOAM531nbMqtjCszKsLaYGgroAxGl99FdiV65ffqu9EgM6zKOqTUH89r
        HOT3uGcmES8JdAUDQCLfTUOCvOjecONEHEwaJFU=
X-Google-Smtp-Source: ABdhPJy1ErtHVIbznOwioJ3Ivw3zCLWXibsVJJGTkkL/Khr5eOlrLJgBgRQouzcRu43wwLQ+CBXFKD+F7vafru8qAcc=
X-Received: by 2002:a4a:41cf:: with SMTP id x198mr9564872ooa.75.1611237748507;
 Thu, 21 Jan 2021 06:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-4-charvi077@gmail.com>
 <xmqqmtx3dq83.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmtx3dq83.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 21 Jan 2021 19:32:15 +0530
Message-ID: <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 21 Jan 2021 at 07:08, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > +static size_t subject_length(const char *body)
> > +{
> > +     size_t i, len = 0;
> > +     char c;
> > +     int blank_line = 1;
> > +     for (i = 0, c = body[i]; c; c = body[++i]) {
> > +             if (c == '\n') {
> > +                     if (blank_line)
> > +                             return len;
> > +                     len = i + 1;
> > +                     blank_line = 1;
> > +             } else if (!isspace(c)) {
> > +                     blank_line = 0;
> > +             }
> > +     }
> > +     return blank_line ? len : i;
> > +}
>
> I cannot quite tell what this loop is trying to compute at the first
> glance.
>

Oops, I think Phillip and Christian also pointed in the last revision
to look for alternatives to make it easy. I mistook that point and
forgot to look at it.

>  - If body[0] == '\n', then i==0, c==LF, blank_line==1 and len==0
>    so len==0 is returned immediately.
>
>  - If the first line has only SP, HT, CR, etc. whitespace,
>    blank_line stays 1 and at the end of the line when we see
>    c=='\n', body[i] is pointing at that '\n', blank_line is true, so
>    len is returned from the previous iteration (e.g. body="   \n"
>    returns 0)
>

yes, it returns the same result as given in this example (But I am
not sure what you are taking " SP, HT, CR, etc " ? otherwise if its
whitespace, then its works the same).

>  - If the first line has some non space, blank_line becomes false,
>    so at the end of that line when we see c=='\n', body[i] is
>    pointing at that '\n', len==i+1 becomes one past that LF and then
>    we reset blank_line to true??? and go on to the next line.
>
> So when we see LF, if we have seen any non whitespace byte on that
> line, blank_line is false.  Only when we saw LF followed by zero or
> more whitespace before seeing another LF, we return len that was set
> when we saw the previous LF (which is one past that LF).
>
> So... is this trying to find the first paragraph-break-looking line
> to find the end of the first paragraph.  OK.
>

I followed and agreed with the above.

> There must be an easier-to-read way to write all this, though, I
> would think (or don't we already have an existing code that is
> waiting to be factored out?).
>

I look into the code again and wonder if we can change this function like this :

static int subject_length(const char *body)
{
               const char *p = body;
               while (*p) {
                if (*p == '\n' && p[1] =='\n') {
                            break;
                } else {
                            p++;
               }
               }
               return p - body;
}

I think checking again '\n' will also serve the purpose as we separate
the commit message subject and its body with the newline. Also, this
is also
true that this function is only called when the message starts with
(squash! or amend! or fixup!)

> In any case, let's keep reading.
>
> >  static void append_squash_message(struct strbuf *buf, const char *body,
> >                                 struct replay_opts *opts)
> >  {
> > +     size_t commented_len = 0;
> > +
> >       unlink(rebase_path_fixup_msg());
> > +     if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
> > +             commented_len = subject_length(body);
> >       strbuf_addf(buf, "\n%c ", comment_line_char);
> >       strbuf_addf(buf, _("This is the commit message #%d:"),
> >                   ++opts->current_fixup_count + 1);
> >       strbuf_addstr(buf, "\n\n");
> > -     strbuf_addstr(buf, body);
> > +     strbuf_add_commented_lines(buf, body, commented_len);
>
> As add_commented_lines places the comment character at the beginning
> of each line, it is OK for body[0..commented_len) to contain more than
> one lines.  Good.
>
> > +     strbuf_addstr(buf, body + commented_len);
>
> And we add everything after the beginning of the paragraph-break
> looking line.  This code may add a line, immediately after the
> previous "commented out" block, bunch of whitespaces and then a LF.
> It will be cleaned up with stripspace most of the time, but
> depending on the end-user settings, it may be left behind.  I am
> guessing that is what we want, but thought it would not hurt to
> double check.
>

I agree this working does the same and comments out the subject of the
commit message starting with squash! or fixup! or amend!, upon
squashing the two or more commits.

> > diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> > index 7bab6000dc..551dc06bc3 100755
> > --- a/t/t3415-rebase-autosquash.sh
> > +++ b/t/t3415-rebase-autosquash.sh
> > @@ -81,8 +81,7 @@ test_auto_squash () {
> >       echo 1 >file1 &&
> >       git add -u &&
> >       test_tick &&
> > -     git commit -m "squash! first" &&
> > -
> > +     git commit -m "squash! first" -m "extra para for first" &&
>
> It is not "extra"; that's the beginning of the "body" ;-).
>

Okay, maybe we can use "message body" here.

> >       git tag $1 &&
> >       test_tick &&
> >       git rebase $2 -i HEAD^^^ &&
> > @@ -139,7 +138,7 @@ test_expect_success 'auto squash that matches 2 commits' '
> >       echo 1 >file1 &&
> >       git add -u &&
> >       test_tick &&
> > -     git commit -m "squash! first" &&
> > +     git commit -m "squash! first" -m "extra para for first" &&
> >       git tag final-multisquash &&
> >       test_tick &&
> >       git rebase --autosquash -i HEAD~4 &&
> > @@ -192,7 +191,7 @@ test_expect_success 'auto squash that matches a sha1' '
> >       git add -u &&
> >       test_tick &&
> >       oid=$(git rev-parse --short HEAD^) &&
> > -     git commit -m "squash! $oid" &&
> > +     git commit -m "squash! $oid" -m "extra para" &&
> >       git tag final-shasquash &&
> >       test_tick &&
> >       git rebase --autosquash -i HEAD^^^ &&
> > @@ -203,7 +202,8 @@ test_expect_success 'auto squash that matches a sha1' '
> >       git cat-file blob HEAD^:file1 >actual &&
> >       test_cmp expect actual &&
> >       git cat-file commit HEAD^ >commit &&
> > -     grep squash commit >actual &&
> > +     grep -v "squash" commit &&
>
> This says that the file must have at least one line that does not
> say "squash" or the test is a failure.  It does not say "there
> should be no line that has "squash" on it".  Intended?
>

Ohh yes ..

> > +     grep "extra para" commit >actual &&
>
> I can tell that you want the "extra para" to still remain, but how
> does the grep that is not anchored guarantee that?

.. but now I think to remove this `grep -v "squash" commit` as also
discussed with Phillip earlier that in this test script we are not
checking for the commented commit message.

> Perhaps look for
>
>         grep "^extra para" commit
>
> to ensure that you are not seeing a commented out but somehow failed
> to get stripspaced out?
>
I am not sure, what does failing to get stripspaced mean?

Thanks for the review !

Thanks and Regards,
Charvi
