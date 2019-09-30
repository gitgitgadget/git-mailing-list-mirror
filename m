Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABBD1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 07:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbfI3Hp1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 03:45:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45489 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfI3Hp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 03:45:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so8312209ljb.12
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q2PZmTupTttxRzQUltJTDJ+yOetE75dbPiYYeXC+69w=;
        b=TlkhxP5RLvl1otslXQHx1Srgnum1vpwJFsNRTPgg+m98uDV5FNaMaG7wCsRaaqPp/o
         aE3fcAtoj2TcyE75qy9VhgryVl+gMdha+X2jyRJYod5fGDsWQy0i0IPsCIGK5UVK1/Ob
         Bf7CE23JAikonbTH4EIWRBqcCAp7DsE6qdZUbeQY57x3hrTNmD81htQ3qCmuzb9yJpOi
         X18ggp/ugD7+rOmI0aMxkV8uR8rb3zaIEPuvnGFlh4FSBpZHoTOtMRLhYThPNUyz7uN0
         3QofT5YDsG0h0OEyDw9oOp+CDFGuBRdHDjRX+1sM+3DZQE8CtT6PTqh2dSri3NI+Tta8
         HCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q2PZmTupTttxRzQUltJTDJ+yOetE75dbPiYYeXC+69w=;
        b=DVBi57HWcUfBECt6PnGcR9wxEbyrN4XfuNwzSq/+2UIc1pyb8ZPVUAbeIGpS43X/lD
         lTeAMnufQueMUIlEDg0Y+aBpqIYhfO9VB3EpjbyaUVZ0B/6QOQkMlnsR1quNFb3UF4F2
         OIe1Qsod83cnNbk7TCqrNZv9o5eFcEoXkhEY0FlvWSlx8Hfr51nChHas6Pj3Mtq6uJ2h
         A1FCzbhR5uZygasCogTAR6CFERH4PO/CWXOTgDL5CDIW8gLfndDx64dRU8/MzpqxNIpk
         +nxkuE36VMrhkOV6Yu+tWp/RHH73O2dkmkEOwOqewM3mhwc4ZmHVNc3hvqe7nZPKnUg4
         fZIA==
X-Gm-Message-State: APjAAAWHmkEV8aFEV1vqJhVZpkgOSzywVDgS3X7qt1xOnaiH+f2h/0ey
        cEZyWqsw3jzCAVxSGRXNcdw98klJqVC3eT22Zj4=
X-Google-Smtp-Source: APXvYqyHBW/bZ5EFXpfZqP0cNski8u6ue8WfzNxvKpmKGxSu7NXIRhuklfshxl+es0aR/6+OO26ywXGQgcpY56ns5Bw=
X-Received: by 2002:a2e:3806:: with SMTP id f6mr11318644lja.143.1569829523455;
 Mon, 30 Sep 2019 00:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190929204322.1244907-1-alexhenrie24@gmail.com> <xmqqa7amimzc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7amimzc.fsf@gitster-ct.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 30 Sep 2019 01:45:12 -0600
Message-ID: <CAMMLpeQLXN=jvD6MSJPdUTr60MiKdQq=zHFQ7aiatFuhqX1aeQ@mail.gmail.com>
Subject: Re: [PATCH v4] diffcore-break: use a goto instead of a redundant if statement
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        CB Bailey <cb@hashpling.org>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 29, 2019 at 7:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > The condition "if (q->nr <= j)" checks whether the loop exited normally
> > or via a break statement. This check can be avoided by replacing the
> > jump out of the inner loop with a jump to the end of the outer loop.
> >
> > With the break replaced by a goto, the two diff_q calls then can be
> > replaced with a single diff_q call outside of the outer if statement.
>
> I doubt that it is a good idea to do these two things.  Especially I
> do not see why the latter makes the resulting code better.

Well, I admit that code clarity is somewhat subjective. To me it's not
obvious that "if (q->nr <= j)" means "if the loop exited normally",
but a goto does make it obvious. (And it's definitely more clear to
scan-build, which complains about a possible memory leak when an if
statement is used but does not complain when the if statement is
replaced with a goto.)

As far as the diff_q calls, I think that having one call instead of
two is slightly more readable, but I don't care very much about it.
I'd be happy to drop that change from the next version of the patch.

-Alex
