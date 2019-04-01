Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26B020248
	for <e@80x24.org>; Mon,  1 Apr 2019 10:45:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDAKpw (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 06:45:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAKpw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 06:45:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so11354520wrn.6
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=6prCWM6yzRXJvXTPHkvuCJCoCbUvO9iE0KNR8HDUTEg=;
        b=nLecWVO63ZuWbnctAdzGvfakqIFO7ZXjHFJpafkb0eFgYnsS+/0iMzHeojxyKwIOXP
         jQj87X7No4eAt+jywYrrAwlwc1mNETRwWJb+NqUmeJf40aZBqoLltCtezu6Tl6vN7GLX
         6hWOUJiSsltfjLZywTfWv1ylohkPdoWabvmANNfXeGohsGeCOx9LDy3zmVN4rM+oJeiL
         RTF2kNhM0nh9JS3h8/MsVbGO4o77vhYmlv8v9RdJIS4Ch65t820eneIm+LFdg40y/QIe
         OvxEIPqCIBpNs6wKsOZFT2msMT8S587/44cGoVknIYFkY6dWeFGB6fWljNKF7HXiS8bB
         sUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=6prCWM6yzRXJvXTPHkvuCJCoCbUvO9iE0KNR8HDUTEg=;
        b=kS5UaPnMJOdJRbPYlqqDKTM6OhFDIxZvwQkA2WaonE8krx8XX5ZK6p9WvKToXZoOAF
         xkgyyTAOT9NE8klzdI2EUWdZJ+itcPN1unFLfFewqt0dYvlEUud4oOttOdvlHV0da76o
         2zpZznk5URraV0TAIDiLng5P5CTWzcquVA1mnUbl3vhuCk6EaD/diAZMj8ncfW738vQC
         fSukV3iFh0odIU6BW2FYTiYS62MTpBfbulW54U3z67EDE6/FzQH542s0TbhxyTahhRFU
         HScih6YNiBhb8KDk45EjlevKG3iD3QRE8Sn53rlKxX421agKXx9/qHbRALkUQpkVzoJM
         6wNQ==
X-Gm-Message-State: APjAAAXB9YVu+woY4suqD9ZInoowrPXMADLxin9i84GVsfGrKS9+146X
        rQAdEQcN2gu9zG777B2F/jY=
X-Google-Smtp-Source: APXvYqx4ygLBEgzrAtW8wNl3sLgDGO93Yy4UU0sOdk+xvvE3LHTM62RgvWJddijv4aKBp/X4Rl4mgw==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr28784667wro.244.1554115550418;
        Mon, 01 Apr 2019 03:45:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y125sm16040441wmc.39.2019.04.01.03.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 03:45:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
        <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
        <xmqqtvfso1cz.fsf@gitster-ct.c.googlers.com>
        <20190325000618.GB9384@archbookpro.localdomain>
        <20190325054145.GA1652@archbookpro.localdomain>
Date:   Mon, 01 Apr 2019 19:45:49 +0900
Message-ID: <xmqqftr2vw9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> > I never use the "feature" myself, but I recall that when "git
>> > rebase" is run on a branch appropriately prepared, you do not even
>> > have to say <upstream> (iow, you type "git rebase<RET>" and rebase
>> > on top of @{upstream}).  
>> > 
>> > Can this new "--keep-base" feature mesh well with it?  When the
>> > current branch has forked from origin/master, for example, it would
>> > be good if
>> > 
>> > 	$ git rebase -i --same-base
>> > 
>> > becomes a usable short-hand for
>> > 
>> > 	$ git rebase -i --same-base origin/master
>> 
>> By "--same-base", I am assuming you mistyped and meant to write
>> "--keep-base"? If that's the case, I can make it a shorthand.
>
> Sorry, I misunderstood your question. "--keep-base" already has the
> shorthand case handled by default.

I actually think you understood _my_ question perfectly well, but
misremembered what your implementation already supported ;-)

If the new option works well with "the branch knows who its upstream
is" feature already, so that the user does not have to type
origin/master in the above example without doing anything special on
your implementation's side, that is a great news.
