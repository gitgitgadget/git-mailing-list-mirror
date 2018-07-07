Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83A981F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 16:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeGGQlD (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 12:41:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42428 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754233AbeGGQlC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 12:41:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1-v6so6874411wrs.9
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z27uvwhB8G7e0r+lpxVEw2w7GyGwg1OQCE6Nxd85YOY=;
        b=rdQdMWe3bJJza+dlUKV5f6E/6hKweoRm1s3LhKG9pXHxJ8kq4a9MuvBUba2M+upwKv
         S/QzqSOUb68pHCnTs5MMQ+/KMuX7tjQztdgCs3aL6lTEGrXzV98zmeiMabhYI3ZrAS8w
         RcjaSrkt7D89W0vbCwEPklSh4y+nmRyofAylY9KJD9MPg3nlAFT6z0mligY1bggDKtoM
         v8kzF/UMyAgxZNu75I8y+U+l+isvCi+1qHDxpB+k9KaUJWjE0KtJS5aIOuZqZnmyc25g
         l3OAfju5CZJ/wRkauty1zvVJgmIA6DjfQQwvVofrI8tjGScxBPrqRMvaMbXPnS7TRQId
         7+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z27uvwhB8G7e0r+lpxVEw2w7GyGwg1OQCE6Nxd85YOY=;
        b=iGll6ckyLNR4HRtjLLAUG6BE7U2EWQCu3wTekWDRxGxJYCiwTYJoxmh+EcP4uUiMxj
         9jRViTZooOmVsZ0brTDdXah/sKGpZOcxCfa0QOIxBwn8AVu3KXlphg8MTlfGUtNZp9H6
         Uy20+0WsEKLVeYgW1GBvKUKXUiwd/PFIsOCTrJQnxVOakwyLiURJL70EOg8hdj37DH6M
         jZfwrHooOJHdf43HGLD4ItRq8U2fpKHgruzZMYQpnqM42VTeR5GBYGlcpIG6/joFtzuR
         8SItCe7v/clskKBfsOTMy2qaE5d2jMEIxJGKeYrcwXU8FFaNFmvQa1Ss3uAB03dFXCUq
         IWfQ==
X-Gm-Message-State: APt69E1P+A8hoNQixsOgxVwJ0/LsfGhwhP+HNyBMH3dGSlvhV041neFo
        IJ41q10ayqmPl7aIuUzOZvwi8Tsl
X-Google-Smtp-Source: AAOMgpechfsMOQ/yBUTBOc19GFhBvKd/kisyrKKaI0YcLNHFzfVeIAHdETcMoUZRRo2eGDMh1UiygQ==
X-Received: by 2002:adf:9ed0:: with SMTP id b16-v6mr9580664wrf.170.1530981660450;
        Sat, 07 Jul 2018 09:41:00 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m17-v6sm17086554wrg.65.2018.07.07.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 09:40:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-7-alban.gruin@gmail.com>
        <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807061457250.75@tvgsbejvaqbjf.bet>
        <xmqqy3eommq2.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807062052230.75@tvgsbejvaqbjf.bet>
        <xmqq7em8hvv9.fsf@gitster-ct.c.googlers.com>
Date:   Sat, 07 Jul 2018 09:40:59 -0700
In-Reply-To: <xmqq7em8hvv9.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 06 Jul 2018 14:55:54 -0700")
Message-ID: <xmqq36wvgfs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I actually think that is a good example of doing the same thing
> slightly differently.  ...

[jc: Beating the dead horse, only to avoid misleading those who are
learning from the sidelines...]

The above was a stupid thing to say and end the message with, as it
made it sound as if there are only two cases and we have a simple
(but not that simple as alluded to earlier by Dscho that essentially
says not to write 'else' when 'if' body returns or exits) rule that
you should blindly apply after telling these two cases apart.  

That is a total opposite of the message that should be read from the
whole thread.

