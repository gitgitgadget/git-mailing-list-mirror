Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E82C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7930223EB3
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395493AbgLKG2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395491AbgLKG1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 01:27:43 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D540C0613CF
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 22:27:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t16so7831597wra.3
        for <git@vger.kernel.org>; Thu, 10 Dec 2020 22:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j0Bzx9DV5+JYti0ZWSmFtl9GgpewWEjM4LhH5Gu0SQY=;
        b=YpR4zMBSpBGoAnIlmFzqtq7IgFJ0qh9CGBZTIvhTR1t0eSEAcYqy8IwoPxPdPn7Kpa
         AqYLCBcrnNgroWzawrVcRFC/qvKYgNRvyJGlZnW7drlM+/AUbj4TaJKcamTC0tsmprNY
         wRJUBCJqiUFi0YsgmWb67KvNEOS9kjTOJ6tPGnlC7SI6md4ofmqNAr+DhaeVWsEaJHnW
         M6f08CjnSOvQfJE2hHP+5lbpM5Z4G/p1qCm6jgFbgsbVuVhpXw+Eq8D8aZXkXedvQ3kJ
         mGK4jvpRVSiMrfgojA71SqDVispp0V8P2yStf++M0+z1D1HcHriafHcHxthS2gKJAG5c
         35oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0Bzx9DV5+JYti0ZWSmFtl9GgpewWEjM4LhH5Gu0SQY=;
        b=fwtn8fpMeJB39pTgoOcNotOXYaKCdBRddvR9bDPg+FbI24/IFJ8xipuexXDdVRrcPB
         On/Pbhbf8mPI4yAxBNy+Zei3JQfkfLQZKkQ4II8a+JNu2TOOBxBBx3DOVG353sMBbG1q
         ejTpo6ko5CvevXeo0qprJwTMoAAiNZVBWh7i20Cv3EeQeM30GH9x7hURpDwtl8iiwmaC
         Tbj33dN9iFU56DEG5uD68JJMVOEX6UbAZJWIGbVEf3chJwJjd/WP/u2I3Cpmh699CyOi
         83NreE3noNAba4NyFsU899m40hAa0hMr/MrkmibgsY/rz+PIfaCxzmZ8hAHEB/7cWWFp
         OpWQ==
X-Gm-Message-State: AOAM532i5b4FADruTdP7UERglOEpdBTAlRHVRh+YpGifAsgTAH542BVc
        4j0rhICshpEuiAMAFvGLPshrY3xdXN/mGVBAVRE=
X-Google-Smtp-Source: ABdhPJyxlp+zxAqZVCYvWy0Zf7DdXiVYTYyfJzQcdwFMbgAuwSKrnTgt8K3z3z8mrdmAq2yJlWzRPy26OrNGXVbQCZ8=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr12020726wrw.139.1607668022285;
 Thu, 10 Dec 2020 22:27:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.921.v3.git.git.1606230450.gitgitgadget@gmail.com>
 <pull.921.v4.git.git.1607637517.gitgitgadget@gmail.com> <483e490349165223a80a0bdf7716c5189560c977.1607637517.git.gitgitgadget@gmail.com>
 <CAMP44s3mtCd9RnZdW7-HLcKVG13UW8u_1VNC0_7jByQRv61+vw@mail.gmail.com> <xmqqblf0opwn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblf0opwn.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 11 Dec 2020 00:26:51 -0600
Message-ID: <CAMP44s1qW=_x6FeU7-dho+bxmY+0n4EehW8-Xy3PX_+sbhjmcg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] init: document `init.defaultBranch` better
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 10, 2020 at 11:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> >> -`refs/tags`, and template files.  An initial `HEAD` file that
> >> -references the HEAD of the master branch is also created.
> >> +`refs/tags`, and template files.  An initial branch without any
> >> +commits will be created (see the `--initial-branch` option below
> >> +for its name).
> >
> > The current sentence: "An initial `HEAD` file that references the HEAD
> > of the master branch is also created." is still true. There's no need
> > to change that (yet).
>
> The change updates the description for readability, lowering the
> technical level of description, and correcting inaccuracies.

OK.

>  - The readers in the context of understanding what "git init"
>    performs does not have to know nor care that HEAD is implemented
>    as a file.  In fact, there is an effort to introduce HEAD and
>    other refs that are implemented as individual files under
>    $GIT_DIR/.  Dropping the word "file" is to correct these.

Right.

>  - Also we no longer say "the HEAD of" a branch, even if we used to
>    use that expression.  When we really need to refer to the commit
>    directly pointed at by a branch ref, we say "the tip of" instead
>    there days.

Sure.

>  - It used to be left unsaid that the initial branch begins its life
>    without any commit.  Now it does.

OK.

> None of these is about "'master' or any other name?" issue.

Indeed, but the commit message clearly states:

  Our documentation does not mention any future plan to change 'master'
  to other value. It is a good idea to document this, though.

It doesn't say anything about improving the documentation of "git
init", nor any of your three points. The main intention is clear.

On top of your three points it sneaks another change; avoiding the
"master" branch name. If this really had nothing to do with the
"master" branch name, it could very well be sent as a separate
independent patch.

The following text has your three valid points, but doesn't sneak in
the extra change:

  An initial "master" branch without any commits will be created (see
  the `--initial-branch` option below to choose another name).

> > Perhaps: (see the `--initial-branch` option below to choose another name).
>
> That changes the meaning of the explanation.  It is compensating for
> not saying what the name of the initial branch is, and is not trying
> to teach that the name can be changed.  The text in the patch is good
> as-is.

In English parentheses are used to clarify information, and typically
it's *supplementary* information. That is; the sentence must stand on
its own without them.

This sentence is missing crucial information and it doesn't stand on its own:

  An initial branch without any commits will be created.

This one does stand on its own:

  An initial "master" branch without any commits will be created.

(and doesn't omit any current information.)

Cheers.

-- 
Felipe Contreras
