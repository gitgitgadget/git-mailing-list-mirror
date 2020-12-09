Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E69EC1B0E3
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 03:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A142389E
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 03:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgLIDHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 22:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgLIDHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 22:07:35 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAF1C06179C
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 19:06:54 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f16so5682otl.11
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 19:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2gFF0VMlHBMzUz50NgA4oP77T6fhBpDQUVOg+bTHSA=;
        b=s4DodOu6xLnVVOQP5C9Ntt96HYWL5Y2zQ8p23ycBxSPrHEOVKa7iTSL8X3KYItab4w
         aOt/Zju3ZmmT/swOsPo5OgBRK51+iOu6DZOwZkE+BEzxORw2xuS3dTTy/1ad5LhsdC0r
         rLIg8hzP/DM+kVtynW8KO1zZ4CvyZzjivxCp52N1JcVIbmXgFwcnzUjefn/zC8Rswxd+
         dWZYHi3RW9rkSsIcndyqqoWHNWsS+lCT5MLxWNzC2qhdqYsU6uig5dCUGOlxU+eMbeWD
         szUiWo1cGH1WEXSuqpGmqxjoo61Esv5m11XB+2z7bJ2igVgcgB11ak6hGESG2yWEaiXC
         3Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2gFF0VMlHBMzUz50NgA4oP77T6fhBpDQUVOg+bTHSA=;
        b=ujGRkSJ9Phe/EhBxEmbjj7QOx/4/k3mrrl9DQvxQa45KQzCkD0n6XmtmM4ExENCYm4
         eBIY9X1Ou+hN1qqf0gw0s21tZ43O0O16dG9rJnKNqAXMViSUJK9sfVWdC6eV935n2KhC
         WA/FMWsanif5zwV43izV61yyXR86nv+GqcLs5OfeIcGoTRapt6QWHqlCNqCDBcnJlGPB
         Q2WWdjwayMUCFN5BT2TZ6n8R5m9Eg1VPEHF+aiKrjXp3jf7nQaFSmOejHcR+zQEyBjQO
         dfEuDU9fI9tnsm6k3O99HZdroZbQyXDwDJqBfhRai+5nu7zsWV+UG3CyUzUHDNefSqCl
         gggw==
X-Gm-Message-State: AOAM530xx4atyUzbE0DzpFMdXMvc7Uhdogn7/D1PxFu/wfq+PmgeyzGr
        Bel/wTuUV9ff3Uib5nKw+exFJh0UTYhhqRteFl4=
X-Google-Smtp-Source: ABdhPJyMXoCiCF8ueNhUPXiCQ4YjYafaYaWZs89oXVTlyVpCDAq+vvYi6shkW7ALkK0v/5BCXfmIaDyEtmqJI/7TVUM=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr145538otp.162.1607483214377;
 Tue, 08 Dec 2020 19:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <87y2i8dptj.fsf@osv.gnss.ru>
 <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
 <87y2i8c4mr.fsf@osv.gnss.ru> <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
 <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Dec 2020 19:06:43 -0800
Message-ID: <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Dec 8, 2020 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > ... I guess I'm not sure why one would ever
> > want to see diffs for merges and not for normal commits.  Even in the
> > unusual case someone did, couldn't they just pass --merges (to strip
> > out the normal commits entirely)?
>
> Giving "--merges" would skip the single-strand-of-pearls commits
> entirely, not even showing their log messages, so it won't be an
> equivalent substitute.

Right, I said that too in my parenthetical comment; --merges would
strip out the normal commits entirely.  As I said, I'm not sure why
anyone would ever want to see diffs for merges and not for normal
commits, the closest useful thing I can imagine is commit messages +
diffs for just merges, stripping the normal commits.  Is there a
usecase here (other than the motivating example of trying to remove an
inconsistency between -m and --cc output)?

I'd personally dislike needing to specify --cc and -p together when
today I can specify just --cc.  You said as much too at [1].  Have you
since changed your mind?

[1] https://lore.kernel.org/git/1440110591-12941-1-git-send-email-gitster@pobox.com/

> > Honestly, I find it a little surprising that despite the fact that log
> > -p shows nothing for merge commits, that when I add --first-parent to
> > see a subset of commits I suddenly get weird, huge diffs shown for the
> > merges (yeah, yeah, I learned recently that it's documented behavior,
> > so it's not surprising anymore, just weird).
>
> I view "--first-parent" as telling "git log" to pretend all merges
> are single-parent commits (as if you did squash merges), and it is a
> natural consequence if "log --first-parent -p" showed each commit
> with its first parent, whether it is a merge or a single-parent
> commit.

Alright, fair enough.  I had always viewed it as commit limiting only
(and thus why it looked weird to me), but I really don't use
--first-parent or -m much.

But that leaves Sergey's question unanswered: should the inconsistency
between --cc and -m (namely that only the former implies -p) be
removed?  If so, since --first-parent implies -m, what's the right way
to avoid --first-parent becoming weird?  (Allow explicit -m to imply
-p, but not an implicit -m that came from --first-parent?)
