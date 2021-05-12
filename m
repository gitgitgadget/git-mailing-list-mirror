Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF720C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975B4615FF
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhELCI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhELCI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:08:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB8C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:07:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso19236795otb.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMAPUWUuVl1bNfvUyPtS2Cl+u2SpZI672ADIFHIyFuY=;
        b=dUXT1BwyPHQSsGD99WxBabiaaHwsx9HskWJsSb60BLf1H7lp2QAky9z8cUdmB1Pym/
         HhKkJuyMsWnJ3cIkjnfXnQi4UhuvLbmgqqWGL72h4vwNt8SNjkUXDet2eruEYdx2lypt
         Mdc6e0QSijEa8D+Vmz38jcmVXqbB/a0fWRrUUG+GoOq7uGhfaNl2Eb3DTKOQuVxylHJx
         XbNfcnhIFWjBA3fiyD5NMpjLmqmWwjeg1aQEBHa2LJqOtI6+Rk+DU0cURoC1zP+TLxjb
         W4hoMNF5uweh/QTohO85L4G1uY/KroH0nEhGU1cR/vbRefiNKoC09zH8kZZt3yA1z8Oy
         zdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMAPUWUuVl1bNfvUyPtS2Cl+u2SpZI672ADIFHIyFuY=;
        b=CHWx9PeIa2MOVV4pYx9fWCVvddftCfgmD0kCl+piucI2+XvbVBQBl22ZsZj2pT0sT6
         QjQa2GIlOUA6yxehBXH2VWn911BD7ERUKAA2snDlt039SwVuV+8bD3Pk+4Ef17b4Qdb2
         ND2huUJ0YEZQTSaIxMJpByGO6TNeBKfALS2CtYCFRtsURY4UNmSynufY0JxYhR4I6aYG
         ZzzPOME41qb1wskpJpebCnHCO56DeyZzM5HrErBV/OTaxPgTLJyzR8V1MsnB+oSej59t
         QZ5D3FMki8A0M4uunxrXFO27EV0W9et7teUSJ2uigAK+ntkTApggKSZapoBvAct7nbGI
         sgug==
X-Gm-Message-State: AOAM53002ybkfVuCMLR08dFl5eghXg9Y32tzpxLO/OwoHqKUob/1b1C7
        V5+utqHZM+/sCwjBGbk0AUqG9KEuHY1me5acGQA=
X-Google-Smtp-Source: ABdhPJwfrvdktkGHKGxTyxIPZtu5aiYwm9yAwQ51fQ9FEIEtM4eo+B5+vL9ZFnMxnwGxD9HD0taar0JHkzyHDW4nSFc=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr21449372otj.345.1620785271469;
 Tue, 11 May 2021 19:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
 <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com> <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
 <xmqq7dk7rwcc.fsf@gitster.g> <CABPp-BFV6R9GNeZVbiKx_Tazq+6LuBNCzLcsEq63MfG5YD0hFQ@mail.gmail.com>
 <xmqqsg2sj3id.fsf@gitster.g>
In-Reply-To: <xmqqsg2sj3id.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 May 2021 19:07:40 -0700
Message-ID: <CABPp-BEJQ5RQdvm58xrNcWm9VdPrUF8_-bym-M424bs7xR=8Gg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] t7300: add testcase showing unnecessary traversal
 into ignored directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 3:43 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > But to answer your question, the paths we visit are '.', '..', '.git',
> > and 'untracked', the first three of which we mark as path_none and
> > don't recurse into because of special rules for those paths, and the
> > last of which we shouldn't recurse into since it is ignored.
>
> Not a hard requirement, but I wish if we entirely ignored "." and
> ".." in our code (not just not counting, but making whoever calls
> readdir() skip and call it again when it gets "." or "..").
>
>   https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.html
>
> seems to imply that readdir() may not give "." or ".." (if dot or
> dot-dot exists, you are to return them only once, which implies that
> it is perfectly OK for dot or dot-dot to be missing).


Something like this?

diff --git a/dir.c b/dir.c
index 993a12145f..7f470bc701 100644
--- a/dir.c
+++ b/dir.c
@@ -2341,7 +2341,11 @@ static int read_cached_dir(struct cached_dir *cdir)
        struct dirent *de;

        if (cdir->fdir) {
-               de = readdir(cdir->fdir);
+               while ((de = readdir(cdir->fdir))) {
+                       /* Ignore '.' and '..' by re-looping; handle the rest */
+                       if (!de || !is_dot_or_dotdot(de->d_name))
+                               break;
+               }
                if (!de) {
                        cdir->d_name = NULL;
                        cdir->d_type = DT_UNKNOWN;

It appears that the other two callers of readdir() in dir.c, namely in
is_empty_dir() and remove_dir_recurse() already have such special
repeat-if-is_dot_or_dotdot() logic built into them, so this was
partially lifted from those.

If you'd like, I can add another patch in the series with this change
so that all readdir() calls in dir.c have such ignore '.' and '..'
logic.  Or, we could perhaps introduce a new readdir() wrapper that
does nothing other than ignore '.' and '..' and have all three of
these callsites use that new wrapper.

> So dropping the test for number of visited paths would be nicer from
> portability's point of view ;-)

Yep, makes sense.  I already did that in v4, which means it'll
continue to pass with or without the above proposed change to
read_cached_dir().
