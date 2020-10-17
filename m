Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827D3C433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA13207EA
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2KnHOYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437446AbgJQHTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411558AbgJQHTR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:19:17 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6FEC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:19:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p5so6718816ejj.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19agXmOmIkeCKfDdcFtbuactgxxVsWfJZDWs2YHjq+o=;
        b=c2KnHOYiP7VtdNeJATZVYEvh9csCjZhePeR2ulA3F7DGZNlKI5VtGc2OwY/YgFDRbg
         Qc+1KYnSiWB1NSRd7HTauNjTKL6UMqKN9oiivCb4jREqpQTstzTR/oTTVkvnKzQN7eJh
         pVWGVHN+ZbJZPE1iv6UyB0wh6NTnyWFhH0Qluy4y/rC8v5J9Xq/Im0J8Ji3l98C+bnQA
         26a0PoQNNbDk4bhMbvQWG8n76/YMy2vB1QHX1pOsxdxWO5XQAAT1sltUhkGiSpqIksJs
         MFUM2RpTncgpqwIjVkJkD3QsThPlkej48qA70J+LH5ndeanzP6bZEC1m1NwC0yIHjhC2
         dKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19agXmOmIkeCKfDdcFtbuactgxxVsWfJZDWs2YHjq+o=;
        b=TllR43ToSGlIC2uvcT0p/kKGsMEZS7MYjXR/G89DYx34uRFI+MAOnJsdhsEUTnf5ZB
         eiS0NDAcOfcxPkVgcb+CcH2zPjkbDYopOGzLQDOhCC+8QQy6NPKHCWJvw3Z18lUxhbx+
         iZ7mZ75b0hiuLzj+Yo2jv95uGC7T+XpEpU6xNKK6q5qB3tijmHqV0bonzgvLZXk/H50O
         DE9NAuRAnZNjj3KsOCcXG9//GGTKAQRNEZJnUwN18M5OaY/feoFP6FW4UgIgBBMvpeAr
         oRhL6JBrHnrp3ZCiWqrubpiPS6C2m9tvzoqQKEUCRSGqZuS+Jn0L7NUqjWKURmmW8VgR
         VGAA==
X-Gm-Message-State: AOAM5306HXog7TM3gX+ik8FleFa1jg1rZOj0qglT+4XW9vM9rDUvumLT
        MuIqXJzzx02+YsHgugOc/PYnPFxgOK5LVHUtPVE=
X-Google-Smtp-Source: ABdhPJwNfiq0pZtTxB68PKg8TlAK+gEbPV4gSjUDdvyduF/EmK3lCyZQK58/P1HQumLOWN512DYHL6AWGOCvla9+BI4=
X-Received: by 2002:a17:907:204c:: with SMTP id pg12mr7606462ejb.160.1602919156373;
 Sat, 17 Oct 2020 00:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201017024353.189792-1-caleb.tillman@gmail.com> <20201017024353.189792-2-caleb.tillman@gmail.com>
In-Reply-To: <20201017024353.189792-2-caleb.tillman@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 17 Oct 2020 09:19:05 +0200
Message-ID: <CAP8UFD2RS-sdaA8tJjqGW=L=_DM0QOZT-pg9D1oL8LEk7Cc84w@mail.gmail.com>
Subject: Re: [PATCH 1/1] Microproject - Use debug-friendly test_path_is_* functions.
To:     Caleb Tillman <caleb.tillman@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 17, 2020 at 8:05 AM Caleb Tillman <caleb.tillman@gmail.com> wrote:
>
> t0000-basic.sh - Replace an instance of test -f with test_path_is_file.

This line seems redundant with the subject.

We suggest that all the messages sent by Outreachy applicants or
interns have "[Outreachy]" at the beginning of their subject. This way
we can identify these emails more easily and prioritize them. Also
using "[...]" ensures that "Outreachy" doesn't appear in the commits
when the patches are applied.

For Outreachy patches related to a test script, we suggest a subject like:

[Outreachy][PATCH X/Y] tZZZZ: do something

where X, Y and ZZZZ are numbers and tZZZZ is the identifier of the test script.

So in this case the subject should be something like:

[Outreachy][PATCH 1/1] t0000: replace an instance of test -f with
test_path_is_file

Note that there is no "Microproject" in the subject and that there is
no uppercase letter used after "PATCH".

The body of the message should explain the reason or the goal of the
patch. Here the reason is that test_path_is_file provides an
(hopefully helpful) error message when it fails, so it should make the
reason for a test failure easier to diagnose.

> Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
> ---

Here, after the line with "---" and before the stats below, you can
add comments that will not appear in the commit message when the patch
will be applied. For example here you can say that the patch is your
microproject.

If you really want to make it more prominent, another option is to use
[Outreachy-Microproject] in the subject instead of [Outreachy] but it
makes the subject line longer for information that we are anyway not
likely to miss.

>  t/t0000-basic.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 923281af93..eb99892a87 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
>  test_expect_success 'git read-tree followed by write-tree should be idempotent' '
>         rm -f .git/index &&
>         git read-tree $tree &&
> -       test -f .git/index &&
> +       test_path_is_file .git/index &&
>         newtree=$(git write-tree) &&
>         test "$newtree" = "$tree"
>  '

This looks good to me.

Thanks!
