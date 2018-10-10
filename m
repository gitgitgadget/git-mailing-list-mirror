Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462BE1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 23:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbeJKG0C (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 02:26:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50648 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKG0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 02:26:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so7053862wmg.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9sr4WP9wxiNgReE3WP58OTsazSI7kOHyViNBulD7RwQ=;
        b=rZj7+xUnmyzJPvahTkvII+uNFxHt42OiLikrBOGN/1Da/JPAeuInXvH9NJz+5wtfxw
         FwcOWsGwlMkPPR4UHVXP9cP1H5Cgad1xZn0GWxVgfT0XaX4Am7JNFUbD0GyFGIBpJVLK
         4Vx5n72BxAZRBi/0TTuSSBAWbd2blU695uGACwREYZhVv9AbsjDkUl3dJQtKIq+G6DKh
         AVGrQ3aHWyFwzdhFx7e8Z2B/WhbplVju+SkCjoePfbAHBJyK2+8yNdbtPXLSDPi+0Hhi
         OumJiUxxD+6+ZO/hWQ2YoQrVPJmAyAHBKV2sbNEPwxHYdshpH99UQoqJNNdk/8Hgzeg0
         t5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9sr4WP9wxiNgReE3WP58OTsazSI7kOHyViNBulD7RwQ=;
        b=XfOBi3Y2RJpUb65HlBGt4bZJCAw0DecP7/BovAQ7NulabWJ1NfSZktE6HKTNIs3i+J
         b3M+8oiqvNJZkTubIQbLoBXmZXzognXrz5HkI4vvmv0beBkWKH67ZwckglviZ/IDi9qe
         8IRL/6e44gaQrpQx443kK9DiJTphVArqq5CLqykOOnw26bsECP2UJxcwG8fMvJYENo0w
         bRbVslUFnX3YqnkXP3mx0cIK7ql1hPYUhbKnkw1r+d/tIk7lh8P/Ngs7ZDtrmhwPBXxL
         hZL65U1hcDiWEEwcEGtlOiSyaNEfLGM34WflXhol7gb5sMJivos38N0aSPTJgbz8NM7q
         ghOQ==
X-Gm-Message-State: ABuFfoguHN7TWRGvUhxmGgf9jgdW24i9OlvpLjUds9AJbkHpCa3ETHUY
        NRSIe+b4DBr7IUMDxcqE5BU=
X-Google-Smtp-Source: ACcGV61aM86WQk257QW5+cIZwEA/vJUISBf8qvnLVs5WtnPgMDjraSKEcN4lTSZfu1pwpeRJqo22Rg==
X-Received: by 2002:a1c:d105:: with SMTP id i5-v6mr2276233wmg.69.1539212502498;
        Wed, 10 Oct 2018 16:01:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r134-v6sm12558974wmg.9.2018.10.10.16.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 16:01:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Witten <mfwitten@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Subject: Re: `--rebase-merges' still failing badly
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
Date:   Thu, 11 Oct 2018 08:01:40 +0900
In-Reply-To: <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com> (Michael
        Witten's message of "Wed, 10 Oct 2018 18:51:17 -0000")
Message-ID: <xmqqsh1djtij.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Witten <mfwitten@gmail.com> writes:

> On Wed, 10 Oct 2018 14:43:46 +0900, Junio wrote:
>
>> We haven't seen  much complaints and breakages  reported against the
>> two big "rewrite in C" topics  around "rebase"; perhaps it is a good
>> time to merge  them to 'next' soonish  to cook them for  a few weeks
>> before moving them to 'master'?
>
> In my opinion, the `--rebase-merges' feature has been broken since the
> beginning, and the builtin version should  be fixed before it is moved
> ahead.

I'll omit the remainder of the message not because I disagree with
your suggested improvements to "rebase-merges" (that conversation
should happen primarily with Dscho), but because I need to react to
the above three lines.

If "rebase-merges" has been broken since the beginning, as long as
the "rewrite in C" topics around "rebase" do not make it even worse,
I do not think it is a good move to block the topics moving forward.
If the feature were so broken that it is not practically useful,
then people wouldn't be using it in the versions of Git before the
rewrite, so it won't harm anybody if the same feature in the rewritten
version is equally (or even more severely) broken, as long as the
other parts of the feature works at least equally well compared to
the older version.

We are not in the business of hostage taking.

What *should* block the rewrited version is a regression,
i.e. something that used to work well no longer works or works
differently in such a way that established workflows need to be
adjusted.

In any case, suggestions to improve "rebase-merges" is a very much
welcome thing to be discussed on the list, so thanks for raising the
issue.  What I wanted to say is that I do not think that is a reason
to keep "rewrite in C" waiting in 'pu'.

