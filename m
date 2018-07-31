Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D301F597
	for <e@80x24.org>; Tue, 31 Jul 2018 19:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbeGaVK2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:10:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51040 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729777AbeGaVK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:10:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so4334962wmc.0
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 12:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+ltGsmQp9ehf/KZET6x0oCb6p9oFCfBI/Cx3ZkuI0iQ=;
        b=bCgo6d1ch018oVrgaRdlkwLayX+d3SwhhdYZrt9bxVsrgLguwbpQjOOM4vtWLuKg4n
         moTWpjB+CxwdgXNTPih349GLbt2oWvByNyzS8POCiVftA2nWd6A4wX/9fQS1/82q4Q/G
         dOmiveRGbvgJewq9/QClnkHBg1WL8WKu50Fwt5UAxtWhBgo7YDq7FLTKVdfRF9ARQeA9
         MTjufBPeQRf0AvWacYbfXHYoOUdwZunlJ7E4fj5hBBqWR64AkQRbzmVPsAQ2zkAxEljj
         27PHXuJYG8KARottW/FKfQXg5NOzCK/UDXt04SBEWBW8zhyNF/upSHNV01Bw4gdlb3ao
         bNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+ltGsmQp9ehf/KZET6x0oCb6p9oFCfBI/Cx3ZkuI0iQ=;
        b=NUISWvE+QrEkTo+CKUxv2IqykAldFaNRGNySzaRKBIqYY8kg/DA91vjNDoI0p8uOML
         jkIimvqOo6D1N9vAXmSXqvENmw9+j9Ay8kMeqM+JR4JY1L37af8yujqoT6tDHI6b+GmO
         wEdpL3f+BDcHL34qGS0rvNL6zCNZavlVDBowlN58ldqudQntOXNpgs/KZntPwm+Tw5hn
         ynNoujvmLSC2SVGG89AJtIDTQrSCqm4nAfeza8epCzyQsufryTg7k1NGKQRmboNeTy/+
         DhaNnneQh6k9YbIg/KURhLDbZyWcAkOaAvzj4L9ZBxb0YRF365AEB3uSXvOP3bByzcuv
         cTcw==
X-Gm-Message-State: AOUpUlFqF00yN6ejTgc8kw100e3PGh6i1TrxXZ1QZFB0IMQ9a+x2VRIC
        /ZCSvU1K/EOkxUypC5obTzs=
X-Google-Smtp-Source: AAOMgpceylUXbUYq7giE1BZNHmkoFqGMxR1KXOoZuNgUDzN9TS/KgP+X9uFnA0/ztAtQwYTZIrlKSQ==
X-Received: by 2002:a1c:e043:: with SMTP id x64-v6mr682146wmg.58.1533065319536;
        Tue, 31 Jul 2018 12:28:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h5-v6sm18353775wrr.19.2018.07.31.12.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:28:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v5 00/20] rebase -i: rewrite in C
References: <20180724163221.15201-1-alban.gruin@gmail.com>
        <20180731180003.5421-1-alban.gruin@gmail.com>
Date:   Tue, 31 Jul 2018 12:28:38 -0700
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 31 Jul 2018 19:59:43 +0200")
Message-ID: <xmqqftzzb3x5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This patch series rewrite the interactive rebase from shell to C.

Thanks.

> It is based on ffc6fa0e39 ("Fourth batch for 2.19 cycle", 2018-07-24).
> The v4 was based on b7bd9486 ("Third batch for 2.19 cycle", 2018-07-18).
> I wanted to make sure my series works well with 'bb/pedantic',
> 'jk/empty-pick-fix', and 'as/sequencer-customizable-comment-char', as
> they modified sequencer.c.

It is a good practice to keey an eye on other topics in flight to
make sure you play well with others.

What you can do better in a case like this is to apply the patches
on the same base as v4 and then trial merge the result into the
newer base of your choice (e.g. ffc6fa0e39), and also apply the same
patches on top of the same newer base.  If

 (1) the application to the old base goes cleanly,
 (2) the trial merge goes cleanly, and 
 (3) the result of the trial merge exactly matches the tree as applying
     the patches on the newer base

then it is preferrable not to rebase but keep the old base as the
previous round to avoid needless churn.  For a new development like
this (as opposed to "fix for long standing bugs"), keeping an old
and tested base does not matter too much, but it is a good
discipline to get into to hold your base steady.

The patches looked all good and applied cleanly.  Will queue and
wait for a few days to see if anybody spots something glaringly
wrong (I expect none) and then merge it to 'next'.

Thanks.
