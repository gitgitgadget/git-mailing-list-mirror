Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7E2C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 04:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851EF20726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 04:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="UcjLdR/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLJEiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:38:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44634 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJEiX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 23:38:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19so18187070lji.11
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 20:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/hgzbmSxxTeBpSOjudC8S2rEdnf16D+xxAOjvs9++0=;
        b=UcjLdR/c4EN5B/rtbzJsJUAwFa0BbkXfCqFYMIU87MhHjv9PftzUMF9jdA1IUIs0lz
         OgotCc5pZtcjkJcgDn6LJFiQDG+G4ZfdYDGbeqh5e9e0IMxZKykiHNuxhsdr4x1+yfOC
         QUOGOuEOGmCunIk8hKWetz8tKWgF7IvhQmp6nb+5XnV1EEkwpwRWShyZg4AMmlWo9hzO
         f6PohIPa8qynGMF9zjIAu7tQ+LvaOf23N5jGVDnzPHXGKHZ75j1NC16qbLU1+WasOtCe
         l/Ebn6xXYNVnUzz+mh+6QrrV7Dvu3/YNaw1rCq1DKmPTp77ZCaFyl2i8jOAdcTiVTL56
         kUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/hgzbmSxxTeBpSOjudC8S2rEdnf16D+xxAOjvs9++0=;
        b=mOONA2S2jkxCxYkw8id/b19VNlkdsF7Xx3Ut0W3ead7kQnGRm6HI6qszCgdwaS2tEy
         91M6xfVe2Cz5e+cTMp29pkU0Z/qaEt885CbOyCt+lYd1v8i1fzz6/3aHO9ei0pbY9g1C
         EJCtIvUTA+1uH+FtIvcV+CB/VMss9mZli5rluvFYMVbCm3Q5wSoKu1vB6GRD6CYmmO4H
         tNS+B66gR9XYrXiZ7FGqYBYSUBPu7um8Q2g7JeK5tZecVuCdEug40yDqE9u6bkr4hSK9
         ga5YuJfvCyHIaSQTqz/lMROoU1pgsvrbfKNGhSMh2tUv3RqcH1t1nio1yPoUYKXMXqHX
         p/VA==
X-Gm-Message-State: APjAAAVZn/evZ3sk2I005/ulyRepBhBMz4YrTXaTUR/Miko4pCbeA1Vo
        C9k7w7iNgDBjVe/73QDB/VSCyhzoEuDrumZd9mAFBA==
X-Google-Smtp-Source: APXvYqyRYS9ZQQsCWbh1/njS1djQg2IOs+fVRXRni8tlV3TQeHGf1AYYvgtWrnfMbw5Sp40NoSutqPecmntaVzrSMsg=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr19352388ljd.227.1575952700893;
 Mon, 09 Dec 2019 20:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20191208180439.19018-1-otalpster@gmail.com> <CAHd-oW4MzH9Wrb2zNPF0JBN8+FRB4NtDX0166Qt2Kbqs0mDgcw@mail.gmail.com>
 <xmqqv9qptcyz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9qptcyz.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 10 Dec 2019 01:38:09 -0300
Message-ID: <CAHd-oW5tVNP=yNZqPANkk4JLWKJyPkb4g4AeUerrd1O=xdLKXQ@mail.gmail.com>
Subject: Re: [PATCH] entry.c: use dir-iterator to avoid explicit dir traversal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     otalpster@gmail.com, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 6:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
>
> >> The changes pass the test suite t/ and Travis CI.
> >> Please point out any mistakes.
> >> ...
> >> -               strbuf_addch(path, '/');
> >> -               strbuf_addstr(path, de->d_name);
> >> -               if (lstat(path->buf, &st))
> >> -                       die_errno("cannot lstat '%s'", path->buf);
> >> -               if (S_ISDIR(st.st_mode))
> >> -                       remove_subtree(path);
> >> -               else if (unlink(path->buf))
> >> -                       die_errno("cannot unlink '%s'", path->buf);
> >> -               strbuf_setlen(path, origlen);
> >> +               if (unlink(iter->path.buf)) {
> >
> > unlink()-ing a directory in Linux will return a EISDIR error. So I
> > think you still need to use S_ISDIR() to check if iter->path.buf is a
> > directory and call rmdir(), in this case.
> >
> > However, note that the dir-iterator API gives entries in pre-order.
> > I.e. a directory appears before its subentries. In the use case of
> > remove_subtree(), though, we need to traverse in post-order, since we
> > have to remove the subentries before removing the directory where they
> > reside. My suggestion is that you add a preliminary patch,
> > implementing a new DIR_ITERATOR_POST_ORDER flag to dir-iterator.h, and
> > then use it in this patch.
>
> Thanks for a review and a few hints to nudge a new contributor in
> the right direction.  Very much appreciated.
>
> I wonder why the bugs in this patch weren't caught by self test we
> already have, by the way.  We need a bit better test coverage,
> perhaps?

I think there is no current test that covers remove_subtree() being
called with nested directories. But we could use the test proposed by
Daniel[1], which does fail when this current patch is applied. So,
maybe, Plato could also include this test in v2, before performing the
dir-iterator convertion.

[1]: https://public-inbox.org/git/1493226219-33423-3-git-send-email-bnmvco@gmail.com/
