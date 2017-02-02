Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A581FAAD
	for <e@80x24.org>; Thu,  2 Feb 2017 17:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbdBBRwC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 12:52:02 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35359 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdBBRwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 12:52:01 -0500
Received: by mail-lf0-f50.google.com with SMTP id n124so12659704lfd.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ARcfkTgsMGBy3OP2sBW3nH3BvE4M7x4uSXqMWmwAbGY=;
        b=IIKCXW9WHjFFM9Yb0CLy1tUZwpSQ8KGW0OeqQmRLOhEYiIN/vLf/Y6fYH7TrbPhUnp
         lrABcAc9+FA0RvX3BIxkh5qNCuxbVdD4YMj9B7X2p8JX9nE3By4n7O4TxYg1mWIgh8pc
         +87XkC9W2ODrOXuXIwReqcqnM0sFQVJ6Xc3IWDHFiWgZm6NDKNRZUrRY3I9Dj0JprZRv
         5vP1JMvfD+oV71oxukaPfG4udMwstn/F8C2Gevy48Kq97incQmR/iv9Tbckn2lZ8ONkt
         nBH0ztogsLLhBVTSBwD6NQYEhN6EQu1ng9SezG4JTw4qZ7gmYI7B3Mr51OlKV7wGjNib
         LNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ARcfkTgsMGBy3OP2sBW3nH3BvE4M7x4uSXqMWmwAbGY=;
        b=HE/LGK+2RoUlMMkZ8ktlfMcoqeIE/ql4FoAJ1qK41TIecYJ0jTSoiWs9v8cpC1W5Of
         7SYYS5YFLt2zvlcGbRtuoZqsZcwtLF+1IU8J3K1tjfNusRK3U3Uwp5981yrS0i58u2Dn
         BAgso0g/aLD5Fpn5lncIXSERx9mH/Lj1sMnMojRrz5O3fOsPTkpq3JrT7/gId2ar59VQ
         5zhQOiMmYHSYXbOkdrQ4yOcxQ0Rfvtil/bJCuVWPf5E2jalyywPOSvcEXwWpDS/+h2T6
         tdy80q0mUDk8moAHSA0PPfRteX48FviTquwnqD/t3o85uq+eA7gZq7WC+d15YhxdX5UF
         jS/A==
X-Gm-Message-State: AIkVDXIVEveTY5m1fBWYnIdWANfIR9EhSNb+oV8D3wn/ua3cxxLnTUu+kydQEJ2Wp1Ek5YXuTlK1bsV89GV1rw==
X-Received: by 10.46.72.17 with SMTP id v17mr4174854lja.18.1486057919231; Thu,
 02 Feb 2017 09:51:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.20.193 with HTTP; Thu, 2 Feb 2017 09:51:38 -0800 (PST)
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Thu, 2 Feb 2017 09:51:38 -0800
Message-ID: <CAE1pOi0-8JnnZbdm9vu1RwTU1mXr7dboLC3ito3LcvK9gkNi_A@mail.gmail.com>
Subject: How to use git show's "%<(<N>[,trunc|ltrunc|mtrunc])"?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm trying to get the committer date printed in a custom fashion.
Using "%cI" gets me close:

$ git show --format="%cI | %an" master | head -n 1
2017-01-31T17:02:13-08:00 | Hilco Wijbenga

I would like to get rid of the "-08:00" bit at the end of the
timestamp. According to the "git show" manual I should be able to use
"%<(<N>[,trunc|ltrunc|mtrunc])" to drop that last part.

$ git show --format="%<(19,trunc)cI | %an" master | head -n 1
cI | Hilco Wijbenga

Mmm, it seems to be recognized as a valid "something" but it's not
working as I had expected. :-) I tried several other versions of this
but no luck. Clearly, I'm misunderstanding the format description. How
do I get "2017-01-31T17:02:13 | Hilco Wijbenga" to be output?

Cheers,
Hilco
