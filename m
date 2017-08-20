Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB8420899
	for <e@80x24.org>; Sun, 20 Aug 2017 18:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbdHTSpF (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 14:45:05 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37981 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753304AbdHTSpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 14:45:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id t3so119985pgt.5
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=MPm/D3wJp6z3hkM1fJSeX1OWNa0y3d3rjo6H95W5Gnk=;
        b=BNqgonY3NhxoDsDKhPeJpeZhxpmTHiYgckkx3pQTiMe27TIWt8jgDrqcWVvHEk4KMy
         07oC/Va08qh86QiGNMbt6ZAerqxE64ySO4S1PjxGFgL9/tT10wbw1o5KOq1n2gqrjegi
         QQs/r10l+dqQfQD69hRUfQDXrf225yWHyUlFYOSaSSZDLbwjYxPOhsruQ+cY/bIp5lCT
         ocSvg7dAuUy090fC6febRJtJfAXPGHFG48+e2XhHURlifCpCHu7wze7S/ngY6e/GOeLj
         hWufMvBXgLc8C05m50ZpqLxjhaSrTssZcuhyp2xn9D7rbGNlby9I98pJyIUj1T+WATjI
         /sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=MPm/D3wJp6z3hkM1fJSeX1OWNa0y3d3rjo6H95W5Gnk=;
        b=iGmM0sfzcX5cXfBhbEkpsNGi2KwQflSWAz0yuKc/nX4KFfla2SEnBXJLtUGaBgqPNR
         f2xsPrLFDjIq+1r/xy83QTnSQqGodZLf9nX37QM1X4uwdqUdsL1NC8ncyttaNRT//7fy
         eEaJjpwla59dXsvX/1mp99XGrg8tqSid+S61OiP2RW3SAxsyvjFRWS/V4ydFIz8LiRAU
         4FMgrO1LrvbtN3MSlqIAPpxhpwLMikw7B8QE/H904zek/DxUzp39zLoBKiWAcb6O/Ukg
         VAsiAUJOcWjc7sTYTAZR7F+p5CPsNQMuG6DAlyp8lS+42K7GzuMQ0hgEhzcnMjfSjeGG
         wdEg==
X-Gm-Message-State: AHYfb5g5j8Y5+i5Z07UUzqq86lxYpvIKmZsF5L2vatAZPQlbSw0I5jng
        cqgbGiESyLv47ZkcbUY=
X-Received: by 10.98.194.8 with SMTP id l8mr3398726pfg.293.1503254704526;
        Sun, 20 Aug 2017 11:45:04 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id 184sm2623585pfg.2.2017.08.20.11.45.02
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Aug 2017 11:45:03 -0700 (PDT)
Message-ID: <1503254759.3881.9.camel@gmail.com>
Subject: What does 'git blame --before <rev> -- <file>' supposed to mean?
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 21 Aug 2017 00:15:59 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I tried to do a 'git blame' on a file and wanted to see the blame
before a particular revision of that file. I initially didn't know that
you could achieve that with,

    $ git blame <rev> <file>

I thought I need to pass the revision as a parameter so I tried (before
looking into the documentation) the command found in the subject. It
worked but to my surprise it had the same result as,

    $ git blame -- <file>

I was confused and came to know from the documentation that blame
doesn't have any '--before' option. That was even more surprising. Why
does blame accept an option which it doesn't identify? Shouldn't it
have warned that it doesn't accept the '--before' option? I guess it
should not accept it because it confuses the user a lot as the could
make it hard time for him to identify the issue.

'git blame' doesn't seem to be the only command that accepts options
not specified in the documentation there's 'git show' for it's company,

    $ git show --grep 'regex'

But the good thing with the above command is it behaves as expected. I
suspect this should be documented, anyway.

Thoughts ?

-- 
Kaartic
