Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74909C35242
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 07:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110C20718
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 07:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVlaZud6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgBQHUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:20:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44437 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQHUx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 02:20:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id g19so19457803eds.11
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 23:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh1RzwWJSlLTS1ehnbQ4uASdpayF6PYbkKr35SpRmJA=;
        b=UVlaZud6YdTciOd9n/cGmPyiFQ5GPuJ39Y0ICtm384nMzWDothF2zvzTPI4MyguDox
         JmMzLg9b1tli+6YbgKem8Do6YRhOf8ErH0oGxCtkx2T8n9v99nxdAXYhjAVzGE825saW
         XnG1Ia8RYwckSbKqIS5c4ao8i0diIS7+7+RWjCufU3Car6EeUh8PLTy7LiSMoCS0Vgki
         Q3849Ts+K6LJvyQs2s37YiyJWPJQ1qxxQZSe91ho0RrL19pWxPsWHRNay0PbQXIQVHki
         XlJReyH7Ok7q/+Tr4wYVIdwaQtxdHstiBauxKoctp8tLyi0UVkmQRuyhUpIKkRQYWo9h
         Hisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh1RzwWJSlLTS1ehnbQ4uASdpayF6PYbkKr35SpRmJA=;
        b=HXdn78DLZBxIR8V1Bc9CVhYxaARUgSW9jk24aUu/BbftNBTU8nTFed5KRHOzI0pIx/
         f6K6cKSZhHiZzCfDX+7F7cLPCFwVLUQ9nsB16kn4x2Sezad4NPEqzMDWvAS+U2c8Km8y
         6zrz/TrAO649Bdh/y8eIwRGbi7HeEh2E+KyAiZ1DP59B7UEr6NDXxdOAc2RxheUgLQ2D
         99gd6/Me2d2RL2CAOWUD9lAutkm53pILbjE2i69lye1ARZPlaRq44VaZtFOk7Tw/1TeH
         LVX2alPnTAMUDHK5wJBRMGqET16K/HmwPgD1PZqhFoZKQdBlZDOXc/WzXLDxJh/udPT8
         zTZg==
X-Gm-Message-State: APjAAAVozIoAH4HIfmcbq99JQvXwYaYfIMYtd8by0mw4zVKkcfW3q4oV
        HUgzgVTP6RDF64uwf+B8jwyk7PiZklBWSXL7mvU=
X-Google-Smtp-Source: APXvYqy2+A4yaBg3MVljKdLWWLyLgr/se22Qb8qDrYhplgTxc6clNcVrn8j/PW+4zoVOi6Gz4fxPnVlDoGyhKktbWJA=
X-Received: by 2002:a05:6402:b47:: with SMTP id bx7mr12950516edb.362.1581924050379;
 Sun, 16 Feb 2020 23:20:50 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <20200120143800.900-13-mirucam@gmail.com>
 <nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301619340.46@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Feb 2020 08:20:39 +0100
Message-ID: <CAP8UFD1UBPwYLUEdUJj3k1Yj0Y9dD6RyGh1dFL=wsSNihErqZQ@mail.gmail.com>
Subject: Re: [PATCH 12/29] bisect--helper: reimplement `bisect_next` and
 `bisect_auto_next` shell functions in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Thanks for your review! I agree with everything you said except a few
things below.

On Thu, Jan 30, 2020 at 11:47 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:

> > +static void prepare_rev_argv(struct bisect_terms *terms, struct argv_array *rev_argv)> > +{
> > +     struct string_list good_revs = STRING_LIST_INIT_DUP;
> > +     char *term_good = xstrfmt("%s-*", terms->term_good);
> > +
> > +     for_each_glob_ref_in(register_good_ref, term_good,
> > +                          "refs/bisect/", &good_revs);
> > +
> > +     argv_array_pushl(rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
> > +     for (int i = 0; i < good_revs.nr; i++)
> > +             argv_array_push(rev_argv, good_revs.items[i].string);
> > +
> > +     string_list_clear(&good_revs, 0);
> > +     free(term_good);
> > +}
>
> Maybe we should fold that into `prepare_revs()`? We could then render the
> arguments directly into `revs` (via `add_pending_object()`, after setting
> obj->flags |= UNINTERESTING`) rather than formatting them into a string
> list, then deep-copy them into an `argv_array` only to parse them back
> into OIDs that we already had in the first place.

The current code is a straightforward port from shell. If we do what
you suggest, yeah, it will be less wasteful, but on the other hand it
will be less easy to see that we are doing a good job of properly
porting code from shell. I suggest we try to focus on the later rather
than the former right now, especially as performance is not very
important here. Further improvements on top could be left for another
patch series or perhaps as microprojects for GSoC or Outreachy
applicants.

Using small functions also makes it easy to see that we are properly
releasing memory. A previous version of this code had everything into
a big function that used goto statements and it was less clear that we
released everything.

> > +static int bisect_skipped_commits(struct bisect_terms *terms)
> > +{
> > +     int res = 0;
> > +     FILE *fp = NULL;
> > +     struct rev_info revs;
> > +
> > +     fp = fopen(git_path_bisect_log(), "a");
> > +     if (!fp)
> > +             return error_errno(_("could not open '%s' for appending"),
> > +                               git_path_bisect_log());
> > +
> > +     res = prepare_revs(terms, &revs);
> > +
> > +     if (!res)
> > +             res = process_skipped_commits(fp, terms, &revs);
> > +
> > +     fclose(fp);
> > +     return res;
> > +}
>
> This is again a very short wrapper around another function, so it will
> probably make sense to merge the two, otherwise the boilerplate might very
> well outweigh the actual code doing actual work.

Yeah, there is perhaps a significant amount of boiler plate, but the
code is much easier to check for leaks than when everything was in the
same big function and there were goto statements, so I think it's a
reasonable trade-off

> > +             fclose(fp);
> > +     } else {
> > +             res = error_errno(_("could not open '%s' for "
> > +                                 "appending"),
> > +                               git_path_bisect_log());
> > +     }
>
> This pattern of opening a file, writing something into it, and then return
> success, otherwise failure, seems like a repeated pattern. In other words,
> it would be a good candidate for factoring out into its own function.

Yeah, but it seems that in this patch series we use the pattern only
once. So I think it's fair to leave that for another patch series with
cleanups and performance improvements or perhaps for microprojects.

Thanks,
Christian.
