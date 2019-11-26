Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80342C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 04:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415DB20674
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 04:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy56JWC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfKZEz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:55:27 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36369 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfKZEz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 23:55:26 -0500
Received: by mail-ed1-f68.google.com with SMTP id f7so15117969edq.3
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 20:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/zneCw66zNP5GV9HfZPIE/3kjY/3KIHO6XkVcF/wo0=;
        b=Xy56JWC/NfLAjdpkz7WeKWEmCh+MTVXTlFxcTMfwatiTvJg+dVCdb2weZJhm8z77Xg
         u1CpmxJ9iJM2xmtUNTwIKiJ5HDqIDm28/YqO6v41gmj5wFGY/AtX4r0AmU/++MJaJpAR
         IjcbhWur7NA5/0wXXIzLPTEhGl20iPaM9Jo3t5CE3N/V6m/6LV8FEd9Wl25tRciWQhav
         SJIa3HlIwC2tCh7E7Mwfe1aAls+qtfL3nErvbFsXJwLlR7tEKrKS8Ic+Aaj7/mXDkbL9
         KlyOiR88eWW53xa7D6l5+TcmIp4cr5Xu3ZdLJ1x3wC+UhCQD+TAo05WwOm33cnNXfZA/
         bfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/zneCw66zNP5GV9HfZPIE/3kjY/3KIHO6XkVcF/wo0=;
        b=DtImSNB2it11jF5orfDX07xPJyOv/qVknRVyNfs4fonyM9L0F7gCX+dhl2HE91vpme
         5jnMtDY0rVh/Z8fwzlWiQWIxZWOXGVq9uSqAdIFP+vZCzr7XbI3cAXE4n1nNj40irbiD
         HFwxumMCHBvEwtIUe4VqmRKDVJAf0YH+WMq9l1nnInY0F9YN8HOU0Nn5s7eJrhbYO89O
         mviClNLgof8UHRuc4jXccfcG8LAX9GGn03xSC3x5EjDKmdvMGDdARJgt5IktLOslHOXk
         myXdFxn4IxyNYpaHriUv8LKs+9OSabFsD4MSjQTnVUxC1Tt/zxOaPkocEaaVB0qDigJg
         KQxg==
X-Gm-Message-State: APjAAAW6u9EMuRrOAwQvJNibbZJmfCaDhtMEHbORNyZXQvQ3GrdnsqAu
        /fFGnEdL2grzXBYAAZ1vSgdZ7+t4nGlft+NgscA=
X-Google-Smtp-Source: APXvYqwjRnyJiknC4Ul3JvPftVvMoKrCKQ6srMlKXQshoXeZPYNTe+MrzopIX5/pfoCEo0BLjGZuE2IEL218QnoxEG8=
X-Received: by 2002:a17:906:459:: with SMTP id e25mr40512622eja.259.1574744124946;
 Mon, 25 Nov 2019 20:55:24 -0800 (PST)
MIME-Version: 1.0
References: <87o8x06sbw.fsf@sydneypc> <20191125141635.GD494@sigill.intra.peff.net>
In-Reply-To: <20191125141635.GD494@sigill.intra.peff.net>
From:   chen bin <chenbin.sh@gmail.com>
Date:   Tue, 26 Nov 2019 15:55:14 +1100
Message-ID: <CAAE-R+8betprfFOH+m_mMATX2mODHQ8pFUpLo4tyLVBVAVtySg@mail.gmail.com>
Subject: Re: A new idea to extend git-blame
To:     Jeff King <peff@peff.net>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I re-tested `git log -L20,20:README.md` in git's own repo with HEAD
d01d26f2df. Looks git log is not what I expected. The output contains
many unrelated commits. So it will be slow in real project.

A recursive blame with the algorithm I suggest will get correct commit
in short time. So my suggestion still hold.

I could submit a patch to enhance blame.

On Tue, Nov 26, 2019 at 1:16 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 25, 2019 at 11:41:55PM +1100, Chen Bin wrote:
>
> > The key algorithm is simple,
> >
> > The algorithm only works for one line blame and the user must
> > select text inside the line first.
> >
> > Step 1, `git blame -L6,1 --porcelain -- hello.js` output,
> >
> >     4f87408612e0dacfd89a1cd2515944e21cf68561 6 6 1
> >     skip...
> >     filename hello.js
> >      doit({bad: 'destroy world', good: 'hello world', ...});
> >
> > I got the commit id (1st column), the line number (2nd column),
> > file name (hello.js) and the code line (last line).
> >
> > Step 2, if the code line does not contain the selected text, the
> >   recursive search stops
> >
> > Step 3, or else use commit id, line number and file name to build
> >   new git blame cli, like,
> >
> > `git blame -L line-num,1 --porcelain 4f8740^ file-name`
> >
> > Step 4, execute new git blame command and start from Step 1
>
> This sounds a lot like how git-log's "-L" option works, which tries to
> find the history of a line over many changes.
>
> It's also similar to the "re-blame from parent" feature of many blame
> viewers. There we have a human in the loop saying "no, this is not quite
> the change I'm looking for; go back further".
>
> -Peff



-- 
help me, help you.
