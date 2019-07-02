Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459171F461
	for <e@80x24.org>; Tue,  2 Jul 2019 17:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGBRXA (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 13:23:00 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:46982 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 13:23:00 -0400
Received: by mail-io1-f54.google.com with SMTP id i10so25034517iol.13
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 10:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=mhhtDnkr9NRFSWAzV5dOYMzcYdz/g3NL4gXwzrF/kVg=;
        b=T8Oko8+1JSRF44od8dZqnlA5uV2Et0toU1DSWpRtXnCn5rcEeESdmte7OHpdlba4qU
         8aEQwc168SWRxHNozE5Fdk3iJXs45Wv+4BGR4pIdSYUjSpKhvmAmHyHQeAJ+rMpy+SOE
         MKxVoUoq5tYatnttdoiP9x5BzlP5ypaqopQhOy+F6hoEujQecgybOkR4FU8RRm1chIfQ
         Ws1H8nu2lozDFnqIJaj6TuRaS2JbueAPCEWts1LasvNUZf80Vp9rW/n3Gu+30Xj+rYBL
         kyB4Jkd3rs7ps0BKinsGygG7QLCHjR9o0CMsirZfNS3zZLPAsA2E3uIESP0EyWI6966J
         sLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mhhtDnkr9NRFSWAzV5dOYMzcYdz/g3NL4gXwzrF/kVg=;
        b=jAHD+c30sDV4wWYVL8Rh2h0m+MViXvp7QLl/Un4Kg173fF6IMJs4a5IJhN44jrQAvr
         nlhCOfbVsuRzBceOG91Zzcw6tTAryFqsnhPzV+PqGMwE5+ozz0OxLKMAKkjVyPx9BjoL
         Vu/vRXQBPiCVJLrsob1KI4CLeHnHXBPOupr72Fr4kfWtmz3Y30bQWZyM+jPnepW+Lbyy
         NVlQfA10DsCjbkSIOHFFgVq5tUQkQXjHadK56fMJccKQ+ZM1xhxNZNAPYFDFTSoq1wk6
         Oyqt4KYuIM4R6GlDjhooLzVXpFXZ0EIjNjnfmRX5bpgCeje/eOQfgSlP0INZU+JX1mVw
         6tKw==
X-Gm-Message-State: APjAAAUmGWvzXG75/LFNCx+8VahoE/6zHhDFCZJD9uy54wmoxmKAbMts
        qQXWKwgvcfc1JVse72REZ6UcBROaTw6/lZy9d5x3/Xsk8J8=
X-Google-Smtp-Source: APXvYqzLzDu6DiwCmV8JPj324Qk9Wa5rPE5TIOTP7DoquHwo8QjnWTkZTFHBaTcz9tv5nrxaJMFugINUpVdTk1VzZTk=
X-Received: by 2002:a02:4484:: with SMTP id o126mr37298200jaa.34.1562088179254;
 Tue, 02 Jul 2019 10:22:59 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Brachet-Mialot <alexbrachetmialot@gmail.com>
Date:   Tue, 2 Jul 2019 13:22:48 -0400
Message-ID: <CAOt2X9sqbpK2qaKk9uf7fL=WCdzJr4+bx-0CsgjssTKkEhd++Q@mail.gmail.com>
Subject: [Bug] Unexpected behavior on case insensitive filesystems
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Branches behave weirdly for case insensitive filesystems, and I'm
guessing other things as well. For example say I am on a branch other
than master, checking out 'Master' will _work_, I will of course be on
the right branch but git status will say I am on 'Master' (expected
just 'master') and git branch will highlight no branch.
