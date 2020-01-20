Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BEC32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA77022525
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAWWn1gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgATTMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:12:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43512 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgATTMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 14:12:37 -0500
Received: by mail-io1-f68.google.com with SMTP id n21so150025ioo.10
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 11:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqvtMVLey0PLdXT1woq/m9+aIFhucq9uS8hMiKnCMHs=;
        b=RAWWn1gtHolS0+XK5BmoylQLSIwGSVRL/NKRtakkvgKAdVzPya81mZcfASXitwXLPa
         udXPB22nbamHb0PXP7CbZwrfwZDqUgnshvpZo1uEwIsPnVtNMlOR8igGkDkEbacyA3XH
         NVPf1NU229XtvzkeMhTnmsfb15znL5B74DC5FkRcjZRmtWEcj9HQypxP06i+pmy8xKl7
         X9GvLGQeacj05eBIvFyLYOJz+qxtpnpN8Z+fBP6uNlt+giZYT/0elnoOep7LmDj7wau1
         XGEHeQA8m3c/HqwlFDM/1im3C9zZIQbIG5OLDTZHIIqZmq024ihcuwV+yx1tR4dVaCtw
         wvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqvtMVLey0PLdXT1woq/m9+aIFhucq9uS8hMiKnCMHs=;
        b=r+HPKNoumZ+HoCGsZJFX7N1pfWIwTviE8oJpSqKaSthffTYEmADVjG9hlvSex0tSHg
         0sBW2E2rMYQB+CYD5lMQ19IbdtjBk6MFKW9hCt5XwWC+EOWm49Eqes/jp4gZisxGe9Fr
         VtWgTd9+dK/jQ9iSxvQ4IrOnBl+lpff1zE+mB3DuqY1pTLo003JPN4tzEAck9Aake1Pb
         QywPuq/CdZKCWeUWWxdaoYcbMqtPQnwFXCe3CgcfrLjmzNhK7qNsiUIynihzpc7cEUv5
         +/BUmfXM+wV5mSAY9Q3CM/r5hK5bEQvBJXMgvhFxjfWmgLrijdPseqcQB1s/aQ36nD8O
         xk7g==
X-Gm-Message-State: APjAAAWNPUDmhrMCQZsea1RWz0JQlXsbcQtXnStmqvlgfH4k+3ENv02/
        EcFm3NqnbsgQBvbVTXe3WpdIheUZgJCB09HCixs=
X-Google-Smtp-Source: APXvYqwtHX2gWKXbgWEd7cuIp2vy+LI20PpmRuuxVosO9AMYXKRoadDUnDs3SIK5K0Ru7D87h9I54SMkjYk+nV4fwyI=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr299466iom.57.1579547556634;
 Mon, 20 Jan 2020 11:12:36 -0800 (PST)
MIME-Version: 1.0
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
 <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Tue, 21 Jan 2020 00:42:00 +0530
Message-ID: <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
Subject: Re: Facing error in git-imap-send while compiling Git
To:     Johannes.Schindelin@gmx.de
Cc:     gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Johannes!

On Fri, Jan 17, 2020 at 7:05 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Nirmal,
>
> On Fri, 17 Jan 2020, Nirmal Khedkar wrote:
>
> > On Fri, Jan 17, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Nirmal Khedkar <nirmalhk7@gmail.com> writes:
> > >
> > > > Hey!
> > > > I've been facing this error everytime I run the Makefile:
> > > > -----
> > > > LINK git-imap-send
> > > > imap-send.o: In function `verify_hostname':
> > > > /git/imap-send.c:252: undefined reference to `sk_num'
> > >
> > > Perhaps the thread
> > >
> > >   https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com
> > >
> > > may help?
> >
> > It did, to the extent that I now know why I'm facing these errors out
> > of the blue.
> >
> > I'm  not quite sure as to what am I supposed to do right now, should I
> > wait for Liam's patch to be merged,  or should I implement his fixes
> > locally or should I just downgrade my openssl?
> >
> > Liam's PR (#516 on GitGitGadget [1]) haven't yet passed all build
> > checks and I guess its still a work in progress. Nevertheless I've
> > tried implementing his fixes to imap-send.c, and the make still fails.
> > Am I missing something here?
>
> Speaking for myself, I am still waiting for
> https://public-inbox.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.com/
> to be addressed adequately. I think this is the main blocker.
>
> You could be that person who addresses this, as already 10 days went past
> without even so much as an acknowledgement of Junio's suggestion. Maybe
> you can make it work, and submit a fixed patch (You could take authorship
> and add a footer "Original-patch-by: Liam Huang <liamhuang0205@gmail.com>"
> because it is most likely a total rewrite of Liam's patch).
>
> Ciao,
> Johannes

The OpenSSL version on my system is 1.1.1. I've tried implementing
Junio's suggestions, and it just doesn't work. It gives me the same
error as it gave me earlier. Here's the error:
-----
LINK git-imap-send
imap-send.o: In function `verify_hostname':
/git/imap-send.c:252: undefined reference to `sk_num'
/git/imap-send.c:254: undefined reference to `sk_value'
/git/imap-send.c:260: undefined reference to `sk_pop_free'
/git/imap-send.c:260: undefined reference to `sk_pop_free'
imap-send.o: In function `ssl_socket_connect':
/git/imap-send.c:287: undefined reference to `SSL_library_init'
/git/imap-send.c:288: undefined reference to `SSL_load_error_strings'
/git/imap-send.c:290: undefined reference to `SSLv23_method'
collect2: error: ld returned 1 exit status

Makefile:2454: recipe for target 'git-imap-send' failed
make: *** [git-imap-send] Error 1
-----

From my limited understanding of OpenSSL API's, I reckon all these
errors might be because of the errors around 'SSL_library_init' and
'SSL_load_error_strings'. Both these functions are called before
'verify_hostname' is ever called.

StackOverflow suggested ([1]) to add tags during compilation, but I
dont think that'd work here.
What should I do? Would love it if you could guide me out.


Thanks!
Regards,
Nirmal Khedkar
https://nirmalhk7.github.io

[1] https://stackoverflow.com/questions/5593284/undefined-reference-to-ssl-library-init-and-ssl-load-error-strings
