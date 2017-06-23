Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A3F2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 02:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbdFWCfN (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 22:35:13 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35679 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdFWCfM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 22:35:12 -0400
Received: by mail-io0-f194.google.com with SMTP id 16so3048909iok.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 19:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=awUS6QFbL1rmf9VvG8+DbCTm2KWxmFGnIjTYXoj1/SY=;
        b=sYITuKWWJdxeWuHkE83UwnyKj4BY5jYnUSNSQUoaoA7txSwFaHv+BMvTwKrwKxCt1G
         SsZ1wtAmVX9Ukja0TuvUI27igxMqXHd0ieROzFD4yGcoyKG61nH7r10NAClCm+NB8ahS
         raLtx2xNjHMGd69E8D/krvtAfl8SeqbcegbTQ7EXtnqbhVQLjhZi3SZyrhRGzs/Dz5Hl
         a6GHgrPx3SdhfGGcsqhzOr/rgsGj1H8aL9mNoNNxYn96IQYKxrkJTCnnD49z2802ZOr8
         DdIFyIR3z4dKIlXYEA6n5HujLuDqI5sL5cJeIPK7fNaJGELbTa/RTcrN/J5ulChlIkCH
         hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=awUS6QFbL1rmf9VvG8+DbCTm2KWxmFGnIjTYXoj1/SY=;
        b=cJ9EhC5qXSkUvbsFg8SkULw53jQS2ul6Q6cvrDNbBPCkF79z3bhDahqza07wlNJZxw
         8eUsfWkmQGYwX6LSbVXwAl7iHIcREqXGsmYgelQViLbZpm9IM4CukkYY/FrejmUy7fIa
         dyS1pw8qZDkLmik4aBz7Oyo85jBoWclSQSr2a6k3pE7GOBeOTn6Lkfgu0t+hRrhDQCuF
         DXToWXiqk6aJlsJfQhKyRg5iezl6pK8DL8DbFgImi6C3jFq6wfxXh4Ti6k7SKpttX/cI
         XXG2LN9ND3KeSdBRs7sAvELRhW74X3h434918XZ98xhgOprBCiKKJPgwU92rmfsh98HV
         y75Q==
X-Gm-Message-State: AKS2vOwsrDT4qT6TQrq8aEARjRLhjAbKTMBE/G7zCjofYzXqJMwTP5Ic
        hVhG+8i4IdOuwgvcpj2OE5D+jKGIbA==
X-Received: by 10.107.10.160 with SMTP id 32mr5383860iok.103.1498185311965;
 Thu, 22 Jun 2017 19:35:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.156.81 with HTTP; Thu, 22 Jun 2017 19:34:31 -0700 (PDT)
In-Reply-To: <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
References: <20170607033308.33550-1-emilyxxie@gmail.com> <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
From:   Emily Xie <emilyxxie@gmail.com>
Date:   Thu, 22 Jun 2017 22:34:31 -0400
Message-ID: <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran the tests and none of them failed. Technically, the state of the
index would indeed be different with these new changes, but this
shouldn't be an issue. In the current version, there's one only item
added to the index that ends up getting used in subsequent tests. That
is, foo1, which is tested in: 'git add --chmod=[+-]x stages
correctly'.

With the current code, foo1 gets added to the index with a mode of
100644. When the 'git add --chmod=[+-]x stages correctly' test
executes, it removes foo1 from the working directory, creates a new
foo1, and runs 'git add --chmod=+x'. It then checks if foo1 is in the
index with a file mode of 100755.

Given how things are set up, the tests pass either way. But I think
it'd actually be nicer with the new changes in this patch, as foo1
would not already be in the index by the time  'git add --chmod=[+-]x
stages correctly' executes.

On Sat, Jun 10, 2017 at 1:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Xie <emilyxxie@gmail.com> writes:
>
> > diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> > index f3a4b4a..40a0d2b 100755
> > --- a/t/t3700-add.sh
> > +++ b/t/t3700-add.sh
> > @@ -331,9 +331,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
> >       test_i18ncmp expect.err actual.err
> >  '
> >
> > -test_expect_success 'git add empty string should invoke warning' '
> > -     git add "" 2>output &&
> > -     test_i18ngrep "warning: empty strings" output
> > +test_expect_success 'git add empty string should fail' '
> > +     test_must_fail git add ""
> >  '
>
> Doesn't this affect the tests that follow this step?  We used to
> warn but went ahead and added all of them anyway, but now we fail
> without adding anything, which means that the state of the index
> before and after this patch would be different.
>
> >  test_expect_success 'git add --chmod=[+-]x stages correctly' '
