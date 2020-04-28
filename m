Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0189C83002
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 02:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60D1221F5
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 02:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmTAn0au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD1CMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1CMv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 22:12:51 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186EC03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 19:12:51 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id w68so2165552vke.5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 19:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ujbFjouIVlo4xufks1aaij3ni217irBe8U5zugiARQ=;
        b=AmTAn0auMzL9x28dBDRWplgmEiJwpYFptJFIIkZh84CjOZLx/3MFU0XcZebW+XkSoX
         LOqGqUBNLX70emY//02VSaralwbUqSJJuxs7SUvLSKZFMc8bdSoK3xGIEEMAk+ECAl79
         UOFTVO5QyI1NLfckoIEAV/URRBrg4pdjsMCHkVg1HiMMP76qG/yO2CnuxVv+Q/ALQgpK
         vYYV6zG0t4PcCwSItK3qvfNpan2wQEvuuLYObGwwm8XTEFCw4kiEApzj6ykPgi7a+Mc9
         Rt9WoVPcmL89E92XmVuE4X/FhQrQgU/xdjhVAW5cIUHrFQuGHLBVx+Zv2x2XKe4ARmim
         NAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ujbFjouIVlo4xufks1aaij3ni217irBe8U5zugiARQ=;
        b=n4GcoGQ3OBrJO8q4sDIm9fUEY0vWeFlDRhMhUvE0qL2HQu/vaZXnroLMPBQAx0mexN
         lAPoYkqecLq6hZ23OfMK3uhDzInkFgKPGtVcrfk8lGB+FgxVhUC+vUGEnOV/pck4YLDe
         CRQ3zgYr8Z6KMqtoHN27hSy6E/ENH0Qnh10gyAye3nLCJZzkUCgjIxsZCu12N1V1+uWr
         CLFmmYgjuD87iymzlAd69mAA2UE8A4+93fF+3sJWsaO5BNX6TfHo8yMFPBR4iQFMo0YK
         5r0eoso5a2oA9s85f/7PQHPuFj4XpONgbSBeLhZOkjF3qrdt/kImPHIJadRBnr5+HARE
         33DQ==
X-Gm-Message-State: AGi0PuZh54a+fcrHEbPspHfITzBLD69tEj/kBsISU2k/u0Xz+O1mRWcu
        dO4AZBn5YSUZehdDTwnBb/zQPqwkyRYNNlksPbA=
X-Google-Smtp-Source: APiQypI2MtIDrdjjf/nN4IsNRy3qDM542mmheqrX0fLDN4omDDMu6AYMdZY/dFkCLKD2+cBp58AlPk6hfevwKpMSnSE=
X-Received: by 2002:a1f:a150:: with SMTP id k77mr20191178vke.88.1588039970317;
 Mon, 27 Apr 2020 19:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
 <20200425022045.1089291-6-jacob.e.keller@intel.com> <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 27 Apr 2020 19:12:39 -0700
Message-ID: <CA+P7+xqEFk5_x5hG=zbPUCvz4W5Obr7fMjdPVfKYCZ8A9e2uqA@mail.gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for
 git switch --orphan
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > git switch with the --orphan option is used to create a new branch that
> > is not connected to any history and is instead based on the empty tree.
> >
> > It does not make sense for completion to return anything in this case,
> > because there is nothing to complete. Check for --orphan, and if it's
> > found, immediately return from _git_switch() without completing
> > anything.
> >
> > Add a test case which documents this expected behavior.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 11 ++++++++++-
> >  t/t9902-completion.sh                  |  7 +++++++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index c21786f2fd00..08d3406cf3e4 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2223,9 +2223,18 @@ _git_switch ()
> >               __gitcomp_builtin switch
> >               ;;
> >       *)
> > +             local track_opt="--track" only_local_ref=n
> > +
> > +             # --orphan is used to create a branch disconnected from the
> > +             # current history, based on the empty tree. Since the only
> > +             # option required is the branch name, it doesn't make sense to
> > +             # complete anything here.
> > +             if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
> > +                     return
> > +             fi
> > +
> >               # check if --track, --no-track, or --no-guess was specified
> >               # if so, disable DWIM mode
> > -             local track_opt="--track" only_local_ref=n
> >               if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
> >                  [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
> >                       track_opt=''
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index a134a8791076..9d02de167219 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -1351,6 +1351,13 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
> >       EOF
> >  '
> >
> > +# TODO: completion does not yet recognize --orphan
> > +test_expect_failure 'git switch - with --orphan, do not complete anything' '
> > +     test_completion "git switch --orphan " <<-\EOF
> > +
> > +     EOF
> > +'
> > +
>
> I am getting "TODO passed" at 7276ffe0 (completion: add test showing
> subpar completion for git switch --orphan, 2020-04-24), which hasn't
> hit 'next' yet.
>
> Perhaps we got some rebase gotcha here?
>


Hmm.. Yea, I think there is a problem. Originally I had one commit
which added the test case for --orphan and I fixed it later, but I
rebased things so it was one commit. I probably just forgot to update
the tests.

Thanks,
Jake

> >  test_expect_success 'teardown after ref completion' '
> >       git branch -d matching-branch &&
> >       git tag -d matching-tag &&
