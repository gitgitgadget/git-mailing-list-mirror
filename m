Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0065202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 23:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCNXpM (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 19:45:12 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33007 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfCNXpM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 19:45:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id z7so6379954lji.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=878lZTaXWeGJfatF0WVv/dNcFERLXRDaiRdBE7YTaJQ=;
        b=gPq0GZOp81ynfoaX9y4PHFSh6j9Z9l538KY6vx3I0yteh+efYJ9OX4hjZQxcwpGPid
         BDWD7pDhM9/4PV2VOwb73F1IMDcKMAoh5bQ2Tt+2fnYmR1ML1Aw0dRQr74lsQRcR+x5Q
         Rty2uLh8TXLe+WTxeCg1716k4ciyhS5er9OdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=878lZTaXWeGJfatF0WVv/dNcFERLXRDaiRdBE7YTaJQ=;
        b=VJoJGTNy8d9P1Fb8auxqtXD18HrCJPirq9C50mkO9wUylIwLbFAcMsDXzbYx7E5CcK
         Okjm9LcSE57217Q3Whtb71uM4sVMIcPw+aA8qplU9yCuDovfezMV1YDfJvSA3daTNCQ6
         /X0KknJ1RpqcOw/QsguaAxNsiQ5M1Ss77spErwY91h6Hy1L4hMKWceG0xqIolN8MOqR7
         6dnnFTn9K/tIRH+poNu26dWWD4w0EupvnZX5kZKRwV5zSEkfVTrYH4Fd5cG09wgNZRco
         xpKncGuUv2DrzO8bkRcLR33hNry7nYxQj5IQw6pQofFbN//cZa0llAzpF0hMxKtYQDU9
         SbHA==
X-Gm-Message-State: APjAAAVq3QX2UdchhCJAuh8Eh6Oym9BNb3KuBqY6+uic65OkLuoSirMj
        uhD5X2nxtTE9RGS90g7OtSl32ILPJgI=
X-Google-Smtp-Source: APXvYqw6/WpJI8EiMP0mrT+S+TqYOpplt7KjLVqgZi56XdNDq83e9q9TEhkHf2wDvGQ809k0XGB4QQ==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr356507ljj.103.1552607108823;
        Thu, 14 Mar 2019 16:45:08 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r11sm80632ljb.29.2019.03.14.16.45.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 16:45:08 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id t13so6373108lji.2
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 16:45:07 -0700 (PDT)
X-Received: by 2002:a2e:7616:: with SMTP id r22mr378772ljc.94.1552607107429;
 Thu, 14 Mar 2019 16:45:07 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Mar 2019 16:44:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
Message-ID: <CAHk-=whP1stFZNAaJiMi5eZ9rj0MRt20Y_yHVczZPH+O01d+sA@mail.gmail.com>
Subject: "Problems" with git format-patch --thread email header ordering
To:     Junio Hamano C <gitster@pobox.com>
Cc:     Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So Thomas Gleixner just figured out that the google gmail support for
S/MIME is even more broken than we initially thought, and has been
rejecting emails that have a non-canonical order of headers in the
email. In particular, gmail s/mime parsing hates emails generated with
"git format-patch --thread" (and then encrypted to be s/mime).

With the git format-patch header ordering, S/MIME senders will get
incomprehensible (and wrong) bounces that say

   Mail delivery failed: returning message to sender (fwd)

    550-5.7.1 Our system has detected that this
    550-5.7.1 message is not RFC 5322 compliant:
    550-5.7.1 'From' header is missing.

when sending to an gmail S/MIME-enabled recipient.

Now, this is very much a gmail bug, but I've long since given up any
hope at all that the gmail people would listen to outsiders (and from
my interactions with people _inside_ of google, I think they consider
anybody outside the "gmail" team to be outsiders - good luck to any
Google people trying to get gmail issues fixed either).

Note that the gmail bounce about 'From' header is missing is
completely bogus, and claims about RFC 5322 are equally inane. The
SMTP RFC's very much say that the order of header files is not
guaranteed, and gmail is wrong.

Also note that this does not affect any *normal* emails to gmail
recipients. It only seems to affect the server-side s/mime decryption
of the email, so you'll never see it unless the recipient actually has
s/mime support enabled (and you encode the git format-patch as
s/mime).

HOWEVER.

While it's true that header ordering isn't specified, there's a common
"canonical" order that the headers are listed in. To quote rfc822:

     Note:  Due to an artifact of the notational conventions, the syn-
            tax  indicates that, when present, some fields, must be in
            a particular order.  Header fields  are  NOT  required  to
            occur  in  any  particular  order, except that the message
            body must occur AFTER  the  headers.   It  is  recommended
            that,  if  present,  headers be sent in the order "Return-
            Path", "Received", "Date",  "From",  "Subject",  "Sender",
            "To", "cc", etc.

Note how that very basic smtp rfc makes it very clear that headers are
very much not required to occur in any particular order, but it does
have a recommended ordering.

I suspect some broken code inside gmail uses that "notational
convention with syntax that indicates that some fields must be in a
particular order". The RFC explicitly states that it's wrong, but hey,
somebody cut-and-pasted the syntax from the RFC and didn't read the
note.

Also note that rfc 5322 (which is a newer version of 822) doesn't
really change that, but does make it clear that trace and resent
fields must not be re-ordered during retransmission (so "Received"
fields etc should stay ordered). That's not about accepting messages,
that's about the transfer of them, though. Gmail is still wrong, and
pointing to the newer rtc doesn't make gmail any more correct.

So gmail is simply wrong in having some odd ordering requirement.

But git format-patch does create the email headers out in a different
order than the one recommended.  When you do "git format-patch
--thread" to create the emails, the header ordering looks roughly like
this:

  Message-Id: <cover.1552606170.git.torvalds@linux-foundation.org>
  From: Linus Torvalds <torvalds@linux-foundation.org>
  Date: Thu, 14 Mar 2019 16:29:30 -0700
  Subject: [PATCH 0/6] *** SUBJECT HERE ***
  MIME-Version: 1.0
  Content-Type: text/plain; charset=UTF-8
  Content-Transfer-Encoding: 8bit

and gmail is quite unhappy with the result if it is then sent as
s/mime. Gmail apparently really wants that
Date/From/Subject/To/Message-Id ordering.

Don't ask me why. Gmail is simply wrong. But I have a very strong
suspicion that it's easier to fix "git format-patch" than it is to fix
whatever odd gmail issue.

Comments? Thomas has munged his s/mime infrastructure to re-order
things, but git _could_ do the proper recommended ordering.

And yes, if somebody from Google on this list wants to bring this up
with the gmail team, I wish you the best of luck. Let me know how it
goes.

                   Linus
