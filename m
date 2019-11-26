Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A0DC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 05:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62ED820678
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 05:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzJzHMFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfKZFg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:36:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34667 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfKZFg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 00:36:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id cx19so7451562edb.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 21:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJydSGlj1rQpKuArMSlUd9DFF06xvYUvR3CFmziDisY=;
        b=BzJzHMFBPVIL1d7IvZ45agXSOplCcH1K+VeYdYK0NuOLyhhSCnT9OKAY7MKh1sn/So
         a96L4pUg6nNqqDQ4k1A9kG7IS+UnCIYzcedDw6q9sksfdRjobS+cXYIApbA+vnRQiL4Q
         Xd9xkW5VoPaNSh9U45X/osCRQnNWN+rXjJuVpDFjjTbBICD/vmcJkLpm1D1D8WvAbilP
         37daBM/nsd1PUIGZy/rmz04Ugf+p3LFPNN5k7/tS5j/f9Llqo8+UTM3XQwE01uhNU7pv
         M6cU704Cyy8zFVhRbe3GmtGbuEoXUlAGxaYHZaqZJurFLJ0GTARxzOAETFoWu34nbDGw
         RrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJydSGlj1rQpKuArMSlUd9DFF06xvYUvR3CFmziDisY=;
        b=E/Fbdz+yrxxkTq4guJCdcOMAgBNkS/Jc3sDKxA4wbEHsvgicl2vKrd+trNT2L2Nj/v
         yst4MKGdICaLGBPE3uYWTHeYAcXfoCOxmz8hrLJa7c+BblEeFJaM68zW216bY3Bz0pOt
         XdDySPn+69siKu66GkY6jag5DQ4KLNh+zV7tOdYzx3l6US92C0QeafxE41Nlxv0XJxOU
         zvltnZU4JuUr9dqWaDpxqvgRNBD1etY5z03NXMVl6qc6hvm0NmJ3OpYK3Z7nbBHxzTwg
         x8lpT7aGVF5HG5U5zB7DcfRyQZ/OlDo0pgJ57JEkUEGFLUeZJl5Yd6Ae7CmTokbauH3K
         Lprg==
X-Gm-Message-State: APjAAAXtYhTT8XV5jk03vcrNcFMx2QkNSdqUZJ3GxdeT5fkzpI9ZhlFv
        4byzxrOh/gZahJ8F3MrEuRXcMRtUvjPNvvX3JE7AGPtSo9Y=
X-Google-Smtp-Source: APXvYqwH/4lcb0Surry4ThIQF4ivpFlOwSk9FOAKhz6PrdbEF1kalmgNl/exxaDfNxhtMvsMBRozTidWuWPUv7ns86Q=
X-Received: by 2002:aa7:d8cd:: with SMTP id k13mr23121428eds.179.1574746584486;
 Mon, 25 Nov 2019 21:36:24 -0800 (PST)
MIME-Version: 1.0
References: <87o8x06sbw.fsf@sydneypc> <20191125141635.GD494@sigill.intra.peff.net>
 <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com>
In-Reply-To: <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Tue, 26 Nov 2019 16:36:13 +1100
Message-ID: <CAAE-R+8dqbxWr9an63OGCL2g1sm1h-ds3yKrzz7Shwq3UyfWxQ@mail.gmail.com>
Subject: Re: A new idea to extend git-blame
To:     Jeff King <peff@peff.net>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The problem of recursive blaming with 3rd party script is it's slow.
The script have to restart git process multiple times. Besides, as I
already did in Emacs (see
https://github.com/redguardtoo/vc-msg/commit/1f7775f951fdd9e6571afbb3a767c42d20617f52),
it's still lots of code.

So if it's possible to use a simple cli option like `git blame
-S"text"`to do the same thing, it would be easier to migrate vc-msg's
functionality to other text editors.

On Tue, Nov 26, 2019 at 3:55 PM chen bin <chenbin.sh@gmail.com> wrote:
>
> I re-tested `git log -L20,20:README.md` in git's own repo with HEAD
> d01d26f2df. Looks git log is not what I expected. The output contains
> many unrelated commits. So it will be slow in real project.
>
> A recursive blame with the algorithm I suggest will get correct commit
> in short time. So my suggestion still hold.
>
> I could submit a patch to enhance blame.
>
> On Tue, Nov 26, 2019 at 1:16 AM Jeff King <peff@peff.net> wrote:
> >
> > On Mon, Nov 25, 2019 at 11:41:55PM +1100, Chen Bin wrote:
> >
> > > The key algorithm is simple,
> > >
> > > The algorithm only works for one line blame and the user must
> > > select text inside the line first.
> > >
> > > Step 1, `git blame -L6,1 --porcelain -- hello.js` output,
> > >
> > >     4f87408612e0dacfd89a1cd2515944e21cf68561 6 6 1
> > >     skip...
> > >     filename hello.js
> > >      doit({bad: 'destroy world', good: 'hello world', ...});
> > >
> > > I got the commit id (1st column), the line number (2nd column),
> > > file name (hello.js) and the code line (last line).
> > >
> > > Step 2, if the code line does not contain the selected text, the
> > >   recursive search stops
> > >
> > > Step 3, or else use commit id, line number and file name to build
> > >   new git blame cli, like,
> > >
> > > `git blame -L line-num,1 --porcelain 4f8740^ file-name`
> > >
> > > Step 4, execute new git blame command and start from Step 1
> >
> > This sounds a lot like how git-log's "-L" option works, which tries to
> > find the history of a line over many changes.
> >
> > It's also similar to the "re-blame from parent" feature of many blame
> > viewers. There we have a human in the loop saying "no, this is not quite
> > the change I'm looking for; go back further".
> >
> > -Peff
>
>
>
> --
> help me, help you.



-- 
help me, help you.
